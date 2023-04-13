Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D26E0659
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDMFOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjDMFOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:14:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5519012
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:12:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 4-20020a251904000000b00b7f75c3cafdso42853716ybz.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362767; x=1683954767;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXimpLffHE1Rblwo7OX38wPtzyjXUfJpALSjGpbz/KU=;
        b=RaB0Fi3XKhFsEsPlfH1UgD7DtMpmzF1GC9RIxRCgxlxZArmEpnhJ4jr/0egUJeoPMT
         p0YZzwJLYWjMt/VLNlP2dsuazDP4KIZo+Ul9ZhV/kHP35yNN6x+Cc1aa9fv95F2FvolN
         VjM2XBUmMilFZCLFdGj4Cp9Rk66xC2MmD+n3PDIpJvsdeSP6+QLJsTdNfx5xDumMIy++
         S2WCALTHXj5JvRX3JVMwN/aBrMgtb4uDv2/B6nhZIK4oy5uvYwxEK1NGf7gKJVqIqJDK
         Lng4vpOg+E7PvDqFoWLqyaf8iROouN5lVnBaV0inZw/ZNDQY5JecbxZSzdbNkW/lROeK
         2m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362767; x=1683954767;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXimpLffHE1Rblwo7OX38wPtzyjXUfJpALSjGpbz/KU=;
        b=l0jNyFhZhvsG+McD3SEqsIQ1pLGwc8U44eUFWLoMZUOuXlVgHQGxkcUnBagSfJ4a+B
         Bb/cwXsd1YwoNKjrqRbsZxEqQ5R/fuyLvkJ8tOFRBapU2khqA7Z2zUPsm4VIzI3Ex2A3
         igZGHWdSQtvVOLdQCVywTokn4ViiZCA0zyjjptQDiym9TQM6E3pEOhliNtftzHr8eabR
         Ys5jI2ms6flz7dagcsMGKjgt2RyTQ9lrSOq7SnKV6L3qVlcLrZv6KZfHbWLriPWXmMyy
         8ekw1ljXgYa4jgUbiwRWMxhscGasmvr5mvF5GADphUrrW9meXMUYWVZrigfpwojQbxwm
         mFTg==
X-Gm-Message-State: AAQBX9fE7YI/x8MdESHQ6uJEHKgPRQd1NjefiPlhzoxwjdupjABAIbuG
        qHGV8eEMiMt2FzW7tJC4ZyWcQyVp8jxi
X-Google-Smtp-Source: AKy350bIgjDf7CigeO8H/h31SRd4Z0znj9jL4aLQa8G+tHrMv/zX7VZcw8Pularr/7rln7qatu3bgQtT//Vf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a81:e549:0:b0:545:1d7f:acbf with SMTP id
 c9-20020a81e549000000b005451d7facbfmr553298ywm.10.1681362767245; Wed, 12 Apr
 2023 22:12:47 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:10:05 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-16-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 15/21] perf vendor events intel: Fix uncore topics for jaketown
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
 .../arch/x86/jaketown/uncore-cache.json       |  194 +--
 .../x86/jaketown/uncore-interconnect.json     | 1237 ++++++++++++++-
 .../arch/x86/jaketown/uncore-io.json          |  324 ++++
 .../arch/x86/jaketown/uncore-other.json       | 1393 -----------------
 4 files changed, 1574 insertions(+), 1574 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-other.js=
on

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index 47830ca5c682..63395e7ee0ce 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -3,7 +3,7 @@
         "BriefDescription": "Uncore Clocks",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Counter 0 Occupancy",
@@ -11,13 +11,13 @@
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
         "EventCode": "0x21",
         "EventName": "UNC_C_ISMQ_DRD_MISS_OCC",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Data Read Request",
@@ -26,7 +26,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; RTID",
@@ -35,7 +35,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; External Snoop Request",
@@ -44,7 +44,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
         "UMask": "0x9",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cache Lookups; Write Requests",
@@ -53,7 +53,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
         "UMask": "0x5",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
@@ -62,7 +62,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized",
@@ -71,7 +71,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in M state",
@@ -80,7 +80,7 @@
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
@@ -89,7 +89,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Lines Victimized; Lines in S State",
@@ -98,7 +98,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; RFO HitS",
@@ -107,7 +107,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
@@ -116,7 +116,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc",
@@ -125,7 +125,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Cbo Misc; Write Combining Aliasing",
@@ -134,7 +134,7 @@
         "PerPkg": "1",
         "PublicDescription": "Miscellaneous events in the Cbo.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Even",
@@ -143,7 +143,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the 'UP=
' direction is on the clockwise ring and 'DN' is on the counter-clockwise r=
ing.  On the right side of the ring, this is reversed.  The first half of t=
he CBos are on the left side of the ring, and the 2nd half are on the right=
 side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD=
 is NOT the same ring as CBo 2 UP AD because they are on opposite sides of =
the ring.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Down and Odd",
@@ -152,7 +152,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the 'UP=
' direction is on the clockwise ring and 'DN' is on the counter-clockwise r=
ing.  On the right side of the ring, this is reversed.  The first half of t=
he CBos are on the left side of the ring, and the 2nd half are on the right=
 side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD=
 is NOT the same ring as CBo 2 UP AD because they are on opposite sides of =
the ring.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Even",
@@ -161,7 +161,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the 'UP=
' direction is on the clockwise ring and 'DN' is on the counter-clockwise r=
ing.  On the right side of the ring, this is reversed.  The first half of t=
he CBos are on the left side of the ring, and the 2nd half are on the right=
 side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD=
 is NOT the same ring as CBo 2 UP AD because they are on opposite sides of =
the ring.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AD Ring In Use; Up and Odd",
@@ -170,7 +170,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the 'UP=
' direction is on the clockwise ring and 'DN' is on the counter-clockwise r=
ing.  On the right side of the ring, this is reversed.  The first half of t=
he CBos are on the left side of the ring, and the 2nd half are on the right=
 side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD=
 is NOT the same ring as CBo 2 UP AD because they are on opposite sides of =
the ring.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Even",
@@ -179,7 +179,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the 'UP' =
direction is on the clockwise ring and 'DN' is on the counter-clockwise rin=
g.  On the right side of the ring, this is reversed.  The first half of the=
 CBos are on the left side of the ring, and the 2nd half are on the right s=
ide of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD i=
s NOT the same ring as CBo 2 UP AD because they are on opposite sides of th=
e ring.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Down and Odd",
@@ -188,7 +188,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the 'UP' =
direction is on the clockwise ring and 'DN' is on the counter-clockwise rin=
g.  On the right side of the ring, this is reversed.  The first half of the=
 CBos are on the left side of the ring, and the 2nd half are on the right s=
ide of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD i=
s NOT the same ring as CBo 2 UP AD because they are on opposite sides of th=
e ring.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Even",
@@ -197,7 +197,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the 'UP' =
direction is on the clockwise ring and 'DN' is on the counter-clockwise rin=
g.  On the right side of the ring, this is reversed.  The first half of the=
 CBos are on the left side of the ring, and the 2nd half are on the right s=
ide of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD i=
s NOT the same ring as CBo 2 UP AD because they are on opposite sides of th=
e ring.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "AK Ring In Use; Up and Odd",
@@ -206,7 +206,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the 'UP' =
direction is on the clockwise ring and 'DN' is on the counter-clockwise rin=
g.  On the right side of the ring, this is reversed.  The first half of the=
 CBos are on the left side of the ring, and the 2nd half are on the right s=
ide of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD i=
s NOT the same ring as CBo 2 UP AD because they are on opposite sides of th=
e ring.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Even",
@@ -215,7 +215,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from  the ring stop.We really have two rings in JKT -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the 'UP'=
 direction is on the clockwise ring and 'DN' is on the counter-clockwise ri=
ng.  On the right side of the ring, this is reversed.  The first half of th=
e CBos are on the left side of the ring, and the 2nd half are on the right =
side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD =
is NOT the same ring as CBo 2 UP AD because they are on opposite sides of t=
he ring.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Down and Odd",
@@ -224,7 +224,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from  the ring stop.We really have two rings in JKT -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the 'UP'=
 direction is on the clockwise ring and 'DN' is on the counter-clockwise ri=
ng.  On the right side of the ring, this is reversed.  The first half of th=
e CBos are on the left side of the ring, and the 2nd half are on the right =
side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD =
is NOT the same ring as CBo 2 UP AD because they are on opposite sides of t=
he ring.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Even",
@@ -233,7 +233,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from  the ring stop.We really have two rings in JKT -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the 'UP'=
 direction is on the clockwise ring and 'DN' is on the counter-clockwise ri=
ng.  On the right side of the ring, this is reversed.  The first half of th=
e CBos are on the left side of the ring, and the 2nd half are on the right =
side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD =
is NOT the same ring as CBo 2 UP AD because they are on opposite sides of t=
he ring.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Up and Odd",
@@ -242,7 +242,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from  the ring stop.We really have two rings in JKT -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the 'UP'=
 direction is on the clockwise ring and 'DN' is on the counter-clockwise ri=
ng.  On the right side of the ring, this is reversed.  The first half of th=
e CBos are on the left side of the ring, and the 2nd half are on the right =
side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD =
is NOT the same ring as CBo 2 UP AD because they are on opposite sides of t=
he ring.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
@@ -250,7 +250,7 @@
         "EventName": "UNC_C_RING_BOUNCES.AK_CORE",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
@@ -258,7 +258,7 @@
         "EventName": "UNC_C_RING_BOUNCES.BL_CORE",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
@@ -266,7 +266,7 @@
         "EventName": "UNC_C_RING_BOUNCES.IV_CORE",
         "PerPkg": "1",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "BL Ring in Use; Any",
@@ -275,41 +275,41 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in JKT.  Therefore, i=
f one wants to monitor the 'Even' ring, they should select both UP_EVEN and=
 DN_EVEN.  To monitor the 'Odd' ring, they should select both UP_ODD and DN=
_ODD.",
         "UMask": "0xf",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AD_CACHE",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AK_CORE",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.BL_CORE",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.IV_CORE",
         "PerPkg": "1",
         "UMask": "0x8",
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
@@ -318,7 +318,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
@@ -327,7 +327,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ",
@@ -336,7 +336,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
@@ -345,7 +345,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IPQ",
@@ -354,7 +354,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ",
@@ -363,7 +363,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; IRQ Rejected",
@@ -372,7 +372,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Allocations; VFIFO",
@@ -381,7 +381,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
@@ -390,7 +390,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
@@ -399,7 +399,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
@@ -408,7 +408,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; Address Conflict",
@@ -417,7 +417,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; Any Reject",
@@ -426,7 +426,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; No Egress Credits",
@@ -435,7 +435,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Probe Queue Retries; No QPI Credits",
@@ -444,7 +444,7 @@
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
@@ -452,7 +452,7 @@
         "EventName": "UNC_C_RxR_IRQ_RETRY.ADDR_CONFLICT",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
@@ -460,7 +460,7 @@
         "EventName": "UNC_C_RxR_IRQ_RETRY.ANY",
         "PerPkg": "1",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
@@ -468,7 +468,7 @@
         "EventName": "UNC_C_RxR_IRQ_RETRY.FULL",
         "PerPkg": "1",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
@@ -476,7 +476,7 @@
         "EventName": "UNC_C_RxR_IRQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
@@ -484,7 +484,7 @@
         "EventName": "UNC_C_RxR_IRQ_RETRY.RTID",
         "PerPkg": "1",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; Any Reject",
@@ -493,7 +493,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No Egress Credits",
@@ -502,7 +502,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No IIO Credits",
@@ -511,7 +511,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "ISMQ Retries; No QPI Credits",
@@ -520,7 +520,7 @@
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
@@ -529,7 +529,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IPQ",
@@ -538,7 +538,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IRQ",
@@ -547,7 +547,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; IRQ Rejected",
@@ -556,7 +556,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Ingress Occupancy; VFIFO",
@@ -565,7 +565,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Evictions",
@@ -574,7 +574,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Miss All",
@@ -583,7 +583,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0xa",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Miss Opcode Match",
@@ -592,7 +592,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched",
@@ -601,7 +601,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Evictions",
@@ -610,7 +610,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Miss All",
@@ -619,7 +619,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x4a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
@@ -628,7 +628,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x43",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched",
@@ -637,7 +637,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; NID Matched Writebacks",
@@ -646,7 +646,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x50",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Opcode Match",
@@ -655,7 +655,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Inserts; Writebacks",
@@ -664,7 +664,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Any",
@@ -673,7 +673,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Evictions",
@@ -682,7 +682,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Miss All",
@@ -691,7 +691,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0xa",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Miss Opcode Match",
@@ -700,7 +700,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x3",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched",
@@ -709,7 +709,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched Evictions",
@@ -718,7 +718,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID Matched",
@@ -727,7 +727,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x4a",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
@@ -736,7 +736,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x43",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
@@ -745,7 +745,7 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "TOR Occupancy; Opcode Match",
@@ -754,13 +754,13 @@
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "EventCode": "0x4",
         "EventName": "UNC_C_TxR_ADS_USED",
         "PerPkg": "1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AD - Cachebo",
@@ -769,7 +769,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
         "UMask": "0x1",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AD - Corebo",
@@ -778,7 +778,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
         "UMask": "0x10",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AK - Cachebo",
@@ -787,7 +787,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; AK - Corebo",
@@ -796,7 +796,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
         "UMask": "0x20",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; BL - Cacheno",
@@ -805,7 +805,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; BL - Corebo",
@@ -814,7 +814,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
         "UMask": "0x40",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Egress Allocations; IV - Cachebo",
@@ -823,7 +823,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
         "UMask": "0x8",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto AK Ring",
@@ -832,7 +832,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
         "UMask": "0x2",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "Injection Starvation; Onto BL Ring",
@@ -841,7 +841,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
         "UMask": "0x4",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "HA to iMC Bypass; Not Taken",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
index b16bb649225d..874f15ea8228 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
@@ -1,11 +1,307 @@
 [
+    {
+        "BriefDescription": "Address Match (Conflict) Count; Conflict Merg=
es",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_ADDRESS_MATCH.MERGE_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.",
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
another request in the write cache.",
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
 tickle can result in multiple decrements.",
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
 tickle can result in multiple decrements.",
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
 a write request is issued, and decrements when the data is returned.",
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
 a write request is issued, and decrements when the data is returned.",
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
a is returned.",
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
a is returned.",
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
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.",
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
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.",
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
issued, and decrements the data is returned to the uncore.",
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
issued, and decrements the data is returned to the uncore.",
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
+        "EventCode": "0xB",
+        "EventName": "UNC_I_RxR_AK_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the AK Ingr=
ess is full.  This queue is where the IRP receives responses from R2PCIe (t=
he ring).",
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
+        "EventCode": "0xC",
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
tickles.",
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
tickles.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Reads",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Writes",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
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
+        "BriefDescription": "Write Ordering Stalls",
+        "EventCode": "0x1A",
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
This clock runs at 1/8th the 'GT/s' speed of the QPI link.  For example, a =
8GT/s link will have qfclk or 1GHz.  JKT does not support dynamic link spee=
ds, so this frequency is fixed.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Count of CTO Events",
@@ -13,7 +309,7 @@
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
@@ -22,7 +318,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT",
@@ -31,7 +327,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT N=
ot Set",
@@ -40,7 +336,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
@@ -49,7 +345,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles in L1",
@@ -57,7 +353,7 @@
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
         "BriefDescription": "Cycles in L0p",
@@ -65,7 +361,7 @@
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
@@ -73,7 +369,7 @@
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
@@ -81,7 +377,7 @@
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
@@ -90,7 +386,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "CRC Errors Detected; Normal Operations",
@@ -99,7 +395,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; DRS",
@@ -108,7 +404,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; HOM",
@@ -117,7 +413,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NCB",
@@ -126,7 +422,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NCS",
@@ -135,7 +431,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; NDR",
@@ -144,7 +440,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x20",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VN0 Credit Consumed; SNP",
@@ -153,7 +449,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VNA Credit Consumed",
@@ -161,7 +457,7 @@
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
@@ -169,7 +465,7 @@
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
         "BriefDescription": "Flits Received - Group 0; Data Tx Flits",
@@ -178,7 +474,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 0; Idle and Null Flits=
",
@@ -187,7 +483,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 0; Non-Data protocol T=
x Flits",
@@ -196,7 +492,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Flits (both Hea=
der and Data)",
@@ -205,7 +501,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x18",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
@@ -214,7 +510,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; DRS Header Flits",
@@ -223,7 +519,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Flits",
@@ -232,7 +528,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x6",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Non-Request Fli=
ts",
@@ -241,7 +537,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
@@ -250,7 +546,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 1; SNP Flits",
@@ -259,7 +555,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent Rx Fli=
ts",
@@ -268,7 +564,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0xc",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent data R=
x Flits",
@@ -277,7 +573,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent non-da=
ta Rx Flits",
@@ -286,7 +582,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Coherent standa=
rd Rx Flits",
@@ -295,7 +591,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AD",
@@ -304,7 +600,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AK",
@@ -313,7 +609,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Rx Flit Buffer Allocations",
@@ -321,7 +617,7 @@
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
@@ -329,7 +625,7 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - HOM",
@@ -337,7 +633,7 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - NCB",
@@ -345,7 +641,7 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - NCS",
@@ -353,7 +649,7 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - NDR",
@@ -361,7 +657,7 @@
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
         "BriefDescription": "Rx Flit Buffer Allocations - SNP",
@@ -369,7 +665,7 @@
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
         "BriefDescription": "RxQ Occupancy - All Packets",
@@ -377,7 +673,7 @@
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
@@ -385,7 +681,7 @@
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
         "BriefDescription": "RxQ Occupancy - HOM",
@@ -393,7 +689,7 @@
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
         "BriefDescription": "RxQ Occupancy - NCB",
@@ -401,7 +697,7 @@
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
         "BriefDescription": "RxQ Occupancy - NCS",
@@ -409,7 +705,7 @@
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
         "BriefDescription": "RxQ Occupancy - NDR",
@@ -417,7 +713,7 @@
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
         "BriefDescription": "RxQ Occupancy - SNP",
@@ -425,7 +721,7 @@
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
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - HOM",
@@ -434,7 +730,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - DRS",
@@ -443,7 +739,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - SNP",
@@ -452,7 +748,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NDR",
@@ -461,7 +757,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NCS",
@@ -470,7 +766,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI.",
         "UMask": "0x20",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NCB",
@@ -479,7 +775,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; Egress Credits",
@@ -488,7 +784,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI.",
         "UMask": "0x40",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Stalls Sending to R3QPI; GV",
@@ -497,7 +793,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of stalls trying to send to R3QPI.",
         "UMask": "0x80",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles in L0p",
@@ -505,7 +801,7 @@
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
@@ -513,7 +809,7 @@
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
@@ -521,7 +817,7 @@
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
@@ -530,7 +826,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
@@ -539,7 +835,7 @@
         "PerPkg": "1",
         "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Tx Flit Buffer Cycles not Empty",
@@ -547,7 +843,7 @@
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
@@ -555,7 +851,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Idle and Null Fl=
its",
@@ -563,7 +859,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
@@ -571,7 +867,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
@@ -579,7 +875,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x18",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
@@ -587,7 +883,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
@@ -595,7 +891,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
@@ -603,7 +899,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x6",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
@@ -611,7 +907,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
@@ -619,7 +915,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
@@ -627,7 +923,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent Byp=
ass Tx Flits",
@@ -636,7 +932,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0xc",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent dat=
a Tx Flits",
@@ -645,7 +941,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x4",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent non=
-data Tx Flits",
@@ -654,7 +950,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x8",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Coherent sta=
ndard Tx Flits",
@@ -663,7 +959,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x10",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AD",
@@ -672,7 +968,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x1",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AK",
@@ -681,7 +977,7 @@
         "PerPkg": "1",
         "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  This is one of three 'groups' that allow us to track flits=
.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' =
is made up of 80 bits of information (in addition to some ECC data).  In fu=
ll-width (L0) mode, flits are made up of four 'fits', each of which contain=
s 20 bits of data (along with some additional ECC data).   In half-width (L=
0p) mode, the fits are only 10 bits, and therefore it takes twice as many f=
its to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0=
 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system=
 will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcul=
ate the bandwidth of the link by taking: flits*80b/time.  Note that this is=
 not the same as 'data' bandwidth.  For example, when we are transferring a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
         "UMask": "0x2",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "Tx Flit Buffer Allocations",
@@ -689,7 +985,7 @@
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
@@ -697,7 +993,7 @@
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
         "BriefDescription": "VNA Credits Returned",
@@ -705,7 +1001,7 @@
         "EventName": "UNC_Q_VNA_CREDIT_RETURNS",
         "PerPkg": "1",
         "PublicDescription": "Number of VNA credits returned.",
-        "Unit": "QPI LL"
+        "Unit": "QPI"
     },
     {
         "BriefDescription": "VNA Credits Pending Return - Occupancy",
@@ -713,6 +1009,779 @@
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
+        "BriefDescription": "to IIO BL Credit Acquired",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Acquired",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Acquired",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Rejected",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_IIO_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Rejected",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Rejected",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit In Use",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_IIO_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit In Use",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_IIO_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit In Use",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_IIO_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 IV Ring in Use; Any",
+        "EventCode": "0xa",
+        "EventName": "UNC_R3_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.",
+        "UMask": "0xf",
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
+        "BriefDescription": "Ingress Cycles Not Empty; DRS",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x8",
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
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCB",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCS",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x20",
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
 ingress buffers can be tracked at a given time using multiple counters.",
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
 ingress buffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
verage queuing latency.",
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
verage queuing latency.",
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
verage queuing latency.",
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
verage queuing latency.",
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
verage queuing latency.",
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
verage queuing latency.",
+        "UMask": "0x2",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
 buffers.",
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
 buffers.",
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
 buffers.",
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
 buffers.",
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
 buffers.",
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
 buffers.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
+        "BriefDescription": "MsgCh Requests by Size; 4B Requests",
+        "EventCode": "0x47",
+        "EventName": "UNC_U_MSG_CHNL_SIZE_COUNT.4B",
+        "PerPkg": "1",
+        "PublicDescription": "Number of transactions on the message channe=
l filtered by request size.  This includes both reads and writes.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "MsgCh Requests by Size; 8B Requests",
+        "EventCode": "0x47",
+        "EventName": "UNC_U_MSG_CHNL_SIZE_COUNT.8B",
+        "PerPkg": "1",
+        "PublicDescription": "Number of transactions on the message channe=
l filtered by request size.  This includes both reads and writes.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Cycles PHOLD Assert to Ack; ACK to Deassert",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ACK_TO_DEASSERT",
+        "PerPkg": "1",
+        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
+        "UMask": "0x2",
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
+        "EventName": "UNC_U_RACU_REQUESTS.COUNT",
+        "PerPkg": "1",
+        "UMask": "0x1",
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
 or all cores",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; LTError",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T0",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Other",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.OTHER",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
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
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-io.json b/tools=
/perf/pmu-events/arch/x86/jaketown/uncore-io.json
new file mode 100644
index 000000000000..b1ce5f77675e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-io.json
@@ -0,0 +1,324 @@
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
d should be used sparingly).",
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
d should be used sparingly).",
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
d should be used sparingly).",
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
 sparingly).",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; NCB",
+        "EventCode": "0x34",
+        "EventName": "UNC_R2_IIO_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; NCS",
+        "EventCode": "0x34",
+        "EventName": "UNC_R2_IIO_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).",
+        "UMask": "0x20",
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
Ie (and should be used sparingly).",
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
Ie (and should be used sparingly).",
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
Ie (and should be used sparingly).",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even"=
,
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Any",
+        "EventCode": "0xa",
+        "EventName": "UNC_R2_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.",
+        "UMask": "0xf",
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
+        "BriefDescription": "Ingress Cycles Not Empty; DRS",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.",
+        "UMask": "0x8",
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
nters.",
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
nters.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AD",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AK",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; BL",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
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
ible to filter based on direction or polarity.",
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
ible to filter based on direction or polarity.",
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
ible to filter based on direction or polarity.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress NACK; AD",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACKS.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress NACK; AK",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACKS.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress NACK; BL",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACKS.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-other.json
deleted file mode 100644
index ca727c0e1865..000000000000
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
+++ /dev/null
@@ -1,1393 +0,0 @@
-[
-    {
-        "BriefDescription": "Address Match (Conflict) Count; Conflict Merg=
es",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_ADDRESS_MATCH.MERGE_COUNT",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.",
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
another request in the write cache.",
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
 tickle can result in multiple decrements.",
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
 tickle can result in multiple decrements.",
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
 a write request is issued, and decrements when the data is returned.",
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
 a write request is issued, and decrements when the data is returned.",
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
a is returned.",
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
a is returned.",
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
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.",
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
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.",
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
issued, and decrements the data is returned to the uncore.",
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
issued, and decrements the data is returned to the uncore.",
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
-        "EventCode": "0xB",
-        "EventName": "UNC_I_RxR_AK_CYCLES_FULL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the AK Ingr=
ess is full.  This queue is where the IRP receives responses from R2PCIe (t=
he ring).",
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
-        "EventCode": "0xC",
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
tickles.",
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
tickles.",
-        "UMask": "0x2",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
-        "UMask": "0x4",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Reads",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_TRANSACTIONS.READS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
-        "UMask": "0x1",
-        "Unit": "IRP"
-    },
-    {
-        "BriefDescription": "Inbound Transaction Count; Writes",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_TRANSACTIONS.WRITES",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
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
-    {
-        "BriefDescription": "Write Ordering Stalls",
-        "EventCode": "0x1A",
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
d should be used sparingly).",
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
d should be used sparingly).",
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
d should be used sparingly).",
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
 sparingly).",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; NCB",
-        "EventCode": "0x34",
-        "EventName": "UNC_R2_IIO_CREDITS_REJECT.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).",
-        "UMask": "0x10",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; NCS",
-        "EventCode": "0x34",
-        "EventName": "UNC_R2_IIO_CREDITS_REJECT.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).",
-        "UMask": "0x20",
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
Ie (and should be used sparingly).",
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
Ie (and should be used sparingly).",
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
Ie (and should be used sparingly).",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
-        "EventCode": "0x7",
-        "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
-        "EventCode": "0x8",
-        "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x8",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
-        "EventCode": "0x9",
-        "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "R2 IV Ring in Use; Any",
-        "EventCode": "0xa",
-        "EventName": "UNC_R2_RING_IV_USED.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.",
-        "UMask": "0xf",
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
-        "BriefDescription": "Ingress Cycles Not Empty; DRS",
-        "EventCode": "0x10",
-        "EventName": "UNC_R2_RxR_CYCLES_NE.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.",
-        "UMask": "0x8",
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
nters.",
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
nters.",
-        "UMask": "0x20",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; AD",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; AK",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress Cycles Full; BL",
-        "EventCode": "0x25",
-        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
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
ible to filter based on direction or polarity.",
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
ible to filter based on direction or polarity.",
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
ible to filter based on direction or polarity.",
-        "UMask": "0x4",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress NACK; AD",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACKS.AD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
-        "UMask": "0x1",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress NACK; AK",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACKS.AK",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
-        "UMask": "0x2",
-        "Unit": "R2PCIe"
-    },
-    {
-        "BriefDescription": "Egress NACK; BL",
-        "EventCode": "0x26",
-        "EventName": "UNC_R2_TxR_NACKS.BL",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
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
-        "BriefDescription": "to IIO BL Credit Acquired",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "to IIO BL Credit Acquired",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "to IIO BL Credit Acquired",
-        "EventCode": "0x20",
-        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquired in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
heable PCI transactions).  This event can only track one message class at a=
 time.",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "to IIO BL Credit Rejected",
-        "EventCode": "0x21",
-        "EventName": "UNC_R3_IIO_CREDITS_REJECT.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "to IIO BL Credit Rejected",
-        "EventCode": "0x21",
-        "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "to IIO BL Credit Rejected",
-        "EventCode": "0x21",
-        "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachea=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "to IIO BL Credit In Use",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_IIO_CREDITS_USED.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "to IIO BL Credit In Use",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_IIO_CREDITS_USED.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "to IIO BL Credit In Use",
-        "EventCode": "0x22",
-        "EventName": "UNC_R3_IIO_CREDITS_USED.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cacheable PCI transactions).  This event can only track one message class =
at a time.",
-        "UMask": "0x20",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd",
-        "EventCode": "0x7",
-        "EventName": "UNC_R3_RING_AD_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd",
-        "EventCode": "0x8",
-        "EventName": "UNC_R3_RING_AK_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even"=
,
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CCW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x4",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CCW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x8",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CW_EVEN",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd",
-        "EventCode": "0x9",
-        "EventName": "UNC_R3_RING_BL_USED.CW_ODD",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
-        "UMask": "0x2",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "R3 IV Ring in Use; Any",
-        "EventCode": "0xa",
-        "EventName": "UNC_R3_RING_IV_USED.ANY",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.",
-        "UMask": "0xf",
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
-        "BriefDescription": "Ingress Cycles Not Empty; DRS",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.DRS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
-        "UMask": "0x8",
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
 ingress buffers can be tracked at a given time using multiple counters.",
-        "UMask": "0x1",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; NCB",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.NCB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
-        "UMask": "0x10",
-        "Unit": "R3QPI"
-    },
-    {
-        "BriefDescription": "Ingress Cycles Not Empty; NCS",
-        "EventCode": "0x10",
-        "EventName": "UNC_R3_RxR_CYCLES_NE.NCS",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
-        "UMask": "0x20",
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
 ingress buffers can be tracked at a given time using multiple counters.",
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
 ingress buffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
uffers can be tracked at a given time using multiple counters.",
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
verage queuing latency.",
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
verage queuing latency.",
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
verage queuing latency.",
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
verage queuing latency.",
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
verage queuing latency.",
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
verage queuing latency.",
-        "UMask": "0x2",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
credit and is delayed.  This should generally be a rare situation.",
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
 buffers.",
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
 buffers.",
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
 buffers.",
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
 buffers.",
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
 buffers.",
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
 buffers.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
e to drain the requests fast enough.",
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
-        "BriefDescription": "MsgCh Requests by Size; 4B Requests",
-        "EventCode": "0x47",
-        "EventName": "UNC_U_MSG_CHNL_SIZE_COUNT.4B",
-        "PerPkg": "1",
-        "PublicDescription": "Number of transactions on the message channe=
l filtered by request size.  This includes both reads and writes.",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "MsgCh Requests by Size; 8B Requests",
-        "EventCode": "0x47",
-        "EventName": "UNC_U_MSG_CHNL_SIZE_COUNT.8B",
-        "PerPkg": "1",
-        "PublicDescription": "Number of transactions on the message channe=
l filtered by request size.  This includes both reads and writes.",
-        "UMask": "0x2",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Cycles PHOLD Assert to Ack; ACK to Deassert",
-        "EventCode": "0x45",
-        "EventName": "UNC_U_PHOLD_CYCLES.ACK_TO_DEASSERT",
-        "PerPkg": "1",
-        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
-        "UMask": "0x2",
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
-        "EventName": "UNC_U_RACU_REQUESTS.COUNT",
-        "PerPkg": "1",
-        "UMask": "0x1",
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
 or all cores",
-        "UMask": "0x4",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; LTError",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x8",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Monitor T0",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Monitor T1",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
-        "UMask": "0x2",
-        "Unit": "UBOX"
-    },
-    {
-        "BriefDescription": "Monitor Sent to T0; Other",
-        "EventCode": "0x43",
-        "EventName": "UNC_U_U2C_EVENTS.OTHER",
-        "PerPkg": "1",
-        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
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

