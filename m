Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914836E708F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDSAz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjDSAz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:55:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FB1AF19
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:55:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d132-20020a254f8a000000b00b868826cdfeso5427160ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681865720; x=1684457720;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgpFRzLsPCsmw+w1zq633w9jcLiodLm4VirGQEvb5RY=;
        b=vBA3SzoZXXeDqn/rMIgmbfhUeiGm1CcJEyEwbeIg+pukLcNHuwyfvhCOrkBbMr1Bpe
         FUMxT1Tb5cSc+thuRnVguBerJ8hxfld79zBzEvY/y4vLWeOXw9NUnMplk9vy4sWqIsbo
         Q5XqFA9UnMNbB81/1zPHL/6tLgSRVxSY6YtoYU/i4cISTE96OrXxxyG6Ttxq+YZQabCT
         LA5HM+hD9u1o5FTGSO0h7ZOc6pxuKfSL7fBQZ7CZYDGoGvDn/A7jruGl4XpEuixhAppT
         S0z+lerhY7mZhFgWExOVd0rARRwdhDsM4HS/mfLvdn/WF0tF9k3Uj1qkXb9WPaoLq8M1
         qRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681865720; x=1684457720;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zgpFRzLsPCsmw+w1zq633w9jcLiodLm4VirGQEvb5RY=;
        b=l6sRRRHEFnTGPaVIMDqdLtnigCJkZZffz0jTU3Dpxy/S0lbVwwuHhad3bbXUiT93Ac
         GKqDS2JsugAII51Hk50QeWvE84I7qEh6y72e99Rzo9tsmFh7i6253as42CzqYe4F9xt3
         P+5XVzvA1WZKM+QZCSCAigC0TD0fOOAqOpLiRY27+LCe7wtwNUoHW0de7G4aJVkVLgDB
         Zrg+AE0leyCIrN9BBhtFpgCM4LCf1XpdjQY30VO15C3SJExfFYHcYiiwAa7HkLFH6rOA
         uG6ydE7/dNbusBTc/+uijx+H3oCjygci/Ne5tweNkPNx4tX6/LD3lJVBwIrwNac36FVK
         iBEA==
X-Gm-Message-State: AAQBX9c+fROy0IHNA3ZHrcN66bJT8nI2uCi9k5bZatbh2bRQ/TZ5xHib
        yv/vUEK3Hd5wljhG1+byi1j27NtfReLx
X-Google-Smtp-Source: AKy350aPyRJ5K2QkJNbSesjh24FqYWxPvjPQiIS25pPAqwigK8r3O+2smNGyUjhkV+Lc9iTcwpxXKwKY8Rmq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f6da:3a8f:84ce:3dd3])
 (user=irogers job=sendgmr) by 2002:a25:da02:0:b0:b92:282b:d557 with SMTP id
 n2-20020a25da02000000b00b92282bd557mr9326013ybf.13.1681865720283; Tue, 18 Apr
 2023 17:55:20 -0700 (PDT)
Date:   Tue, 18 Apr 2023 17:54:23 -0700
In-Reply-To: <20230419005423.343862-1-irogers@google.com>
Message-Id: <20230419005423.343862-6-irogers@google.com>
Mime-Version: 1.0
References: <20230419005423.343862-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Subject: [PATCH v2 6/6] perf vendor events intel: Remove TopdownL1 from CPUs
 without perf metric events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As requested by Kan in:
https://lore.kernel.org/lkml/ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.int=
el.com/

Note, atom CPUs lack perf metric (aka topdown) events and so these
metrics are also not placed in the group TopdownL1 to avoid perf stat
showing them by default.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlake/adl-metrics.json     | 10 +++++-----
 .../pmu-events/arch/x86/alderlaken/adln-metrics.json   | 10 +++++-----
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json     |  8 ++++----
 .../pmu-events/arch/x86/broadwellde/bdwde-metrics.json |  8 ++++----
 .../pmu-events/arch/x86/broadwellx/bdx-metrics.json    |  8 ++++----
 .../pmu-events/arch/x86/cascadelakex/clx-metrics.json  |  8 ++++----
 .../perf/pmu-events/arch/x86/haswell/hsw-metrics.json  |  8 ++++----
 .../perf/pmu-events/arch/x86/haswellx/hsx-metrics.json |  8 ++++----
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json     |  8 ++++----
 .../perf/pmu-events/arch/x86/ivytown/ivt-metrics.json  |  8 ++++----
 .../perf/pmu-events/arch/x86/jaketown/jkt-metrics.json |  8 ++++----
 .../pmu-events/arch/x86/sandybridge/snb-metrics.json   |  8 ++++----
 .../perf/pmu-events/arch/x86/skylake/skl-metrics.json  |  8 ++++----
 .../perf/pmu-events/arch/x86/skylakex/skx-metrics.json |  8 ++++----
 14 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index d09361dacd4f..a837ed8666fe 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -130,7 +130,7 @@
     {
         "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
         "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_slots",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.1",
         "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.   The rest of t=
hese subevents count backend stalls, in cycles, due to an outstanding reque=
st which is memory bound vs core bound.   The subevents are not slot based =
events and therefore can not be precisely added or subtracted from the Back=
end_Bound_Aux subevents which are slot based.",
@@ -140,7 +140,7 @@
     {
         "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
         "MetricExpr": "tma_backend_bound",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_backend_bound_aux",
         "MetricThreshold": "tma_backend_bound_aux > 0.2",
         "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that UOPS mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.  All of these s=
ubevents count backend stalls, in slots, due to a resource limitation.   Th=
ese are not cycle based events and therefore can not be precisely added or =
subtracted from the Backend_Bound subevents which are cycle based.  These s=
ubevents are supplementary to Backend_Bound and can be used to analyze resu=
lts from a resource perspective at allocation.",
@@ -150,7 +150,7 @@
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
         "MetricExpr": "(tma_info_slots - (TOPDOWN_FE_BOUND.ALL + TOPDOWN_B=
E_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_slots",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
@@ -288,7 +288,7 @@
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_slots",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.2",
         "ScaleUnit": "100%",
@@ -736,7 +736,7 @@
     {
         "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots.",
         "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_slots",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.75",
         "ScaleUnit": "100%",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index 1a85d935c733..66bd7e376e88 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -95,7 +95,7 @@
     {
         "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
         "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_slots",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.1",
         "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.   The rest of t=
hese subevents count backend stalls, in cycles, due to an outstanding reque=
st which is memory bound vs core bound.   The subevents are not slot based =
events and therefore can not be precisely added or subtracted from the Back=
end_Bound_Aux subevents which are slot based.",
@@ -104,7 +104,7 @@
     {
         "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
         "MetricExpr": "tma_backend_bound",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_backend_bound_aux",
         "MetricThreshold": "tma_backend_bound_aux > 0.2",
         "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that UOPS mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.  All of these s=
ubevents count backend stalls, in slots, due to a resource limitation.   Th=
ese are not cycle based events and therefore can not be precisely added or =
subtracted from the Backend_Bound subevents which are cycle based.  These s=
ubevents are supplementary to Backend_Bound and can be used to analyze resu=
lts from a resource perspective at allocation.",
@@ -113,7 +113,7 @@
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
         "MetricExpr": "(tma_info_slots - (TOPDOWN_FE_BOUND.ALL + TOPDOWN_B=
E_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_slots",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
@@ -236,7 +236,7 @@
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_slots",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.2",
         "ScaleUnit": "100%"
@@ -626,7 +626,7 @@
     {
         "BriefDescription": "Counts the numer of issue slots  that result =
in retirement slots.",
         "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_slots",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.75",
         "ScaleUnit": "100%"
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/to=
ols/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index 51cf8560a8d3..8a954a2ef703 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -100,7 +100,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -109,7 +109,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -323,7 +323,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
@@ -1045,7 +1045,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json =
b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index fb57c7382408..1cd150d714ba 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -94,7 +94,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
@@ -103,7 +103,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -308,7 +308,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
@@ -1010,7 +1010,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index 65ec0c9e55d1..b0e03a84d7f4 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -100,7 +100,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -109,7 +109,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -323,7 +323,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
@@ -1076,7 +1076,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b=
/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 8f7dc72accd0..36cee1086fa5 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -98,7 +98,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (IN=
T_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) /=
 tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -107,7 +107,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -351,7 +351,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
@@ -1455,7 +1455,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tool=
s/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index 2528418200bb..41b15da86580 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -100,7 +100,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -109,7 +109,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -269,7 +269,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
@@ -871,7 +871,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 11f152c346eb..000e7301ce81 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -100,7 +100,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -109,7 +109,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -269,7 +269,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
@@ -902,7 +902,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/to=
ols/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index 5247f69c13b6..9caac46d3359 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -100,7 +100,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -109,7 +109,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -296,7 +296,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
@@ -914,7 +914,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tool=
s/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 89469b10fa30..9c1a4b9ef748 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -100,7 +100,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -109,7 +109,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -296,7 +296,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
@@ -945,7 +945,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/too=
ls/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index e8f4e5c01c9f..914dbf0d839c 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -73,7 +73,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -82,7 +82,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -202,7 +202,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
@@ -484,7 +484,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/=
tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index 4a99fe515f4b..687ea8c6b8a8 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -73,7 +73,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma=
_retiring)",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -82,7 +82,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -202,7 +202,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
@@ -483,7 +483,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index a6d212b349f5..32f4a16db4ea 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -98,7 +98,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (IN=
T_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) /=
 tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -107,7 +107,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -342,7 +342,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
@@ -1340,7 +1340,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index fa2f7f126a30..48fe6738c112 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -98,7 +98,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "MetricExpr": "1 - tma_frontend_bound - (UOPS_ISSUED.ANY + 4 * (IN=
T_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)) /=
 tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
@@ -107,7 +107,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
         "MetricExpr": "(UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * =
(INT_MISC.RECOVERY_CYCLES_ANY / 2 if #SMT_on else INT_MISC.RECOVERY_CYCLES)=
) / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
@@ -351,7 +351,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / tma_info_slots",
-        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "PGO;TmaL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
@@ -1426,7 +1426,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / tma_info_slots",
-        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.RETIRE_SLOTS",
--=20
2.40.0.634.g4ca3ef3211-goog

