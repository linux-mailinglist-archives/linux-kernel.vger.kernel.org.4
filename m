Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69CC69BF9D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBSJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBSJeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:34:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1AE4C08
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:32:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h204-20020a256cd5000000b00953ffdfbe1aso2263058ybc.23
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhC8RlQQDEUumThBVP3BFgOcI9ow4i6TnnBtpNZj6g8=;
        b=NLiqNqqN2UXiBVa/kIcJY7ovAkmY5RZlMuWs3LqQooTQ7jmKpeovntgrAcJjCTFJQF
         8ZxOPeAEWluzKYrDb8Lmmn1QQQFGp4RYZibqZ+XdgcNY0Gulj9egKCnUDB+FDBCU+/wz
         IfFux3pX1h7GnQDz0Fo2rtQF2oZZZP8uHh5lBaCMiDjZC6mNUHh65NbvekbRAUq0cqfY
         qcEN8ZtWjf03eBBDuJ+kAv/mw1xZ3+ayXqspuvzFRRTGhyDeiQl2vPediInZj2DuK6qc
         P0O7xGQZjAtedCZCSp7qfhJmF0TwRjs/EkdhrrQbDwOekwD/j8XAOujIiT4dybqYIaFX
         GuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RhC8RlQQDEUumThBVP3BFgOcI9ow4i6TnnBtpNZj6g8=;
        b=HGnGo1DjXE1UK+jiqBn09duiFXE1f+XO5yPQI7OtCFrwScACBakMieVi2s7+HvrPM5
         ayASAfANQrX4mILtj76+8zN78z3brycwEFKu1hNGpJ7UIIQN0U6mXJVxpqpNRHP2IRnE
         SqTp0mcHdfqdgjFAWHvxM44zPxQ+VrU4e1GU46grC1NHL+1O9o8s+aA4SZl7TI+/G0ES
         Mdo6BlhYf9sdALzFiooL9KwLYCthfnHXm82YgCMHPfzAoHhzO3fZ2XEt7XD2b7M8U2gw
         CHpOwmnJGiBAH39dq4xUEAWQTo7J2+eM7LQQS19L1iPep6ulId8GGRuyHvzWoJBj0YXp
         oDrg==
X-Gm-Message-State: AO0yUKXDMmiaEM/FEoVn3IHZ7MpzsigFBi1y58/iazBN28bgcuuXuboA
        Mf1u/M/b1+sWENTy2dplBY5BCqEjLrge
X-Google-Smtp-Source: AK7set+wG2j6JROLi4IipOflMnlcql2zJZMYYJJ6qZ1zTfA+xN3lYElfRlCZYSX3KiyaCchExfXBiFDcIifu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:291:b0:9a0:1d7b:707b with SMTP id
 v17-20020a056902029100b009a01d7b707bmr49063ybh.4.1676799137260; Sun, 19 Feb
 2023 01:32:17 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:21 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-25-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 24/51] perf vendor events intel: Refresh knightslanding events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
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

Update the knightslanding events from 9 to 10. Generation was done
using https://github.com/intel/perfmon.

The most notable change is in corrections to event descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/knightslanding/cache.json        | 94 +++++++++----------
 .../arch/x86/knightslanding/pipeline.json     |  8 +-
 .../arch/x86/knightslanding/uncore-other.json |  8 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/too=
ls/perf/pmu-events/arch/x86/knightslanding/cache.json
index 01aea3d2832e..d9876cb06b08 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -6,7 +6,7 @@
         "SampleAfterValue": "200003"
     },
     {
-        "BriefDescription": "Counts the number of core cycles the fetch st=
alls because of an icache miss. This is a cummulative count of core cycles =
the fetch stalled for all icache misses.",
+        "BriefDescription": "Counts the number of core cycles the fetch st=
alls because of an icache miss. This is a cumulative count of core cycles t=
he fetch stalled for all icache misses.",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "PublicDescription": "This event counts the number of core cycles =
the fetch stalls because of an icache miss. This is a cumulative count of c=
ycles the NIP stalled for all icache misses.",
@@ -28,7 +28,7 @@
         "UMask": "0x4f"
     },
     {
-        "BriefDescription": "Counts the number of MEC requests from the L2=
Q that reference a cache line (cacheable requests) exlcuding SW prefetches =
filling only to L2 cache and L1 evictions (automatically exlcudes L2HWP, UC=
, WC) that were rejected - Multiple repeated rejects should be counted mult=
iple times",
+        "BriefDescription": "Counts the number of MEC requests from the L2=
Q that reference a cache line (cacheable requests) excluding SW prefetches =
filling only to L2 cache and L1 evictions (automatically exlcudes L2HWP, UC=
, WC) that were rejected - Multiple repeated rejects should be counted mult=
iple times",
         "EventCode": "0x30",
         "EventName": "L2_REQUESTS_REJECT.ALL",
         "SampleAfterValue": "200003"
@@ -108,7 +108,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for reponses from snoop request hit with data fo=
rwarded from it Far(not in the same quadrant as the request)-other tile L2 =
in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from snoop request hit with data f=
orwarded from it Far(not in the same quadrant as the request)-other tile L2=
 in E/F/M state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -135,7 +135,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for reponses from snoop request hit with data fo=
rwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from snoop request hit with data f=
orwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -198,7 +198,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that are outstanding, per weighted cycle, from the time of the=
 request to when any response is received. The oustanding response should b=
e programmed only on PMC0.",
+        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that are outstanding, per weighted cycle, from the time of the=
 request to when any response is received. The outstanding response should =
be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -216,7 +216,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for reponses from snoop request hit with =
data forwarded from it Far(not in the same quadrant as the request)-other t=
ile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from snoop request hit with=
 data forwarded from it Far(not in the same quadrant as the request)-other =
tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -243,7 +243,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for reponses from snoop request hit with =
data forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from snoop request hit with=
 data forwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -306,7 +306,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that are outstanding, per weighted cycle, from the time=
 of the request to when any response is received. The oustanding response s=
hould be programmed only on PMC0.",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that are outstanding, per weighted cycle, from the time=
 of the request to when any response is received. The outstanding response =
should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -324,7 +324,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Prefetch requests that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
+        "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -351,7 +351,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Prefetch requests that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
+        "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -405,7 +405,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Prefetch requests that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The oustanding response should be programmed only on PMC0.",
+        "BriefDescription": "Counts any Prefetch requests that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The outstanding response should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -423,7 +423,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Read request  that accounts for re=
ponses from snoop request hit with data forwarded from it Far(not in the sa=
me quadrant as the request)-other tile L2 in E/F/M state. Valid only in SNC=
4 Cluster mode.",
+        "BriefDescription": "Counts any Read request  that accounts for re=
sponses from snoop request hit with data forwarded from it Far(not in the s=
ame quadrant as the request)-other tile L2 in E/F/M state. Valid only in SN=
C4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -450,7 +450,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Read request  that accounts for re=
ponses from snoop request hit with data forwarded from its Near-other tile =
L2 in E/F/M state",
+        "BriefDescription": "Counts any Read request  that accounts for re=
sponses from snoop request hit with data forwarded from its Near-other tile=
 L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -513,7 +513,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Read request  that are outstanding=
, per weighted cycle, from the time of the request to when any response is =
received. The oustanding response should be programmed only on PMC0.",
+        "BriefDescription": "Counts any Read request  that are outstanding=
, per weighted cycle, from the time of the request to when any response is =
received. The outstanding response should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -531,7 +531,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any request that accounts for reponses=
 from snoop request hit with data forwarded from it Far(not in the same qua=
drant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 Clus=
ter mode.",
+        "BriefDescription": "Counts any request that accounts for response=
s from snoop request hit with data forwarded from it Far(not in the same qu=
adrant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 Clu=
ster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -558,7 +558,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any request that accounts for reponses=
 from snoop request hit with data forwarded from its Near-other tile L2 in =
E/F/M state",
+        "BriefDescription": "Counts any request that accounts for response=
s from snoop request hit with data forwarded from its Near-other tile L2 in=
 E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -621,7 +621,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any request that are outstanding, per =
weighted cycle, from the time of the request to when any response is receiv=
ed. The oustanding response should be programmed only on PMC0.",
+        "BriefDescription": "Counts any request that are outstanding, per =
weighted cycle, from the time of the request to when any response is receiv=
ed. The outstanding response should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -639,7 +639,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for reponses from snoop request hit with data forwarded from =
it Far(not in the same quadrant as the request)-other tile L2 in E/F/M stat=
e. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from snoop request hit with data forwarded from=
 it Far(not in the same quadrant as the request)-other tile L2 in E/F/M sta=
te. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -666,7 +666,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for reponses from snoop request hit with data forwarded from =
its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from snoop request hit with data forwarded from=
 its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -729,7 +729,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data write requests  =
that are outstanding, per weighted cycle, from the time of the request to w=
hen any response is received. The oustanding response should be programmed =
only on PMC0.",
+        "BriefDescription": "Counts Demand cacheable data write requests  =
that are outstanding, per weighted cycle, from the time of the request to w=
hen any response is received. The outstanding response should be programmed=
 only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -747,7 +747,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for reponses from snoop request hit with data forwarded from it F=
ar(not in the same quadrant as the request)-other tile L2 in E/F/M state. V=
alid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from snoop request hit with data forwarded from it =
Far(not in the same quadrant as the request)-other tile L2 in E/F/M state. =
Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -774,7 +774,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for reponses from snoop request hit with data forwarded from its =
Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from snoop request hit with data forwarded from its=
 Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -837,7 +837,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Bus locks and split lock requests that=
 are outstanding, per weighted cycle, from the time of the request to when =
any response is received. The oustanding response should be programmed only=
 on PMC0.",
+        "BriefDescription": "Counts Bus locks and split lock requests that=
 are outstanding, per weighted cycle, from the time of the request to when =
any response is received. The outstanding response should be programmed onl=
y on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -855,7 +855,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for reponses from snoop request hit with data forwarded f=
rom it Far(not in the same quadrant as the request)-other tile L2 in E/F/M =
state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from snoop request hit with data forwarded =
from it Far(not in the same quadrant as the request)-other tile L2 in E/F/M=
 state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -882,7 +882,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for reponses from snoop request hit with data forwarded f=
rom its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from snoop request hit with data forwarded =
from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -945,7 +945,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that are outstanding, per weighted cycle, from the time of the request =
to when any response is received. The oustanding response should be program=
med only on PMC0.",
+        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that are outstanding, per weighted cycle, from the time of the request =
to when any response is received. The outstanding response should be progra=
mmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1035,7 +1035,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that are outstanding, per weighted cycle, from the time of the r=
equest to when any response is received. The oustanding response should be =
programmed only on PMC0.",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch =
data reads that are outstanding, per weighted cycle, from the time of the r=
equest to when any response is received. The outstanding response should be=
 programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1053,7 +1053,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for reponses from snoop request hit with data forwarded from it Far(no=
t in the same quadrant as the request)-other tile L2 in E/F/M state. Valid =
only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from snoop request hit with data forwarded from it Far(n=
ot in the same quadrant as the request)-other tile L2 in E/F/M state. Valid=
 only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1080,7 +1080,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for reponses from snoop request hit with data forwarded from its Near-=
other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from snoop request hit with data forwarded from its Near=
-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1143,7 +1143,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data writes that are =
outstanding, per weighted cycle, from the time of the request to when any r=
esponse is received. The oustanding response should be programmed only on P=
MC0.",
+        "BriefDescription": "Counts Demand cacheable data writes that are =
outstanding, per weighted cycle, from the time of the request to when any r=
esponse is received. The outstanding response should be programmed only on =
PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1170,7 +1170,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for reponses from snoop =
request hit with data forwarded from it Far(not in the same quadrant as the=
 request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from snoop=
 request hit with data forwarded from it Far(not in the same quadrant as th=
e request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1197,7 +1197,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for reponses from snoop =
request hit with data forwarded from its Near-other tile L2 in E/F/M state"=
,
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from snoop=
 request hit with data forwarded from its Near-other tile L2 in E/F/M state=
",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1260,7 +1260,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that are outstanding, per weighted cyc=
le, from the time of the request to when any response is received. The oust=
anding response should be programmed only on PMC0.",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that are outstanding, per weighted cyc=
le, from the time of the request to when any response is received. The outs=
tanding response should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1287,7 +1287,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for reponses from snoop request hi=
t with data forwarded from it Far(not in the same quadrant as the request)-=
other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from snoop request h=
it with data forwarded from it Far(not in the same quadrant as the request)=
-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a7",
@@ -1314,7 +1314,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for reponses from snoop request hi=
t with data forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from snoop request h=
it with data forwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a7",
@@ -1386,7 +1386,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1413,7 +1413,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1476,7 +1476,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data HW prefetches that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The oustanding response should be programmed only on PMC0.",
+        "BriefDescription": "Counts L1 data HW prefetches that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The outstanding response should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1494,7 +1494,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1521,7 +1521,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1566,7 +1566,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L2 code HW prefetches that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The oustanding response should be programmed only on PMC0.",
+        "BriefDescription": "Counts L2 code HW prefetches that are outstan=
ding, per weighted cycle, from the time of the request to when any response=
 is received. The outstanding response should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1602,7 +1602,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for reponses from snoop request hit with da=
ta forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from snoop request hit with d=
ata forwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1683,7 +1683,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Software Prefetches that accounts for =
reponses from snoop request hit with data forwarded from it Far(not in the =
same quadrant as the request)-other tile L2 in E/F/M state. Valid only in S=
NC4 Cluster mode.",
+        "BriefDescription": "Counts Software Prefetches that accounts for =
responses from snoop request hit with data forwarded from it Far(not in the=
 same quadrant as the request)-other tile L2 in E/F/M state. Valid only in =
SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1710,7 +1710,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Software Prefetches that accounts for =
reponses from snoop request hit with data forwarded from its Near-other til=
e L2 in E/F/M state",
+        "BriefDescription": "Counts Software Prefetches that accounts for =
responses from snoop request hit with data forwarded from its Near-other ti=
le L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1773,7 +1773,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Software Prefetches that are outstandi=
ng, per weighted cycle, from the time of the request to when any response i=
s received. The oustanding response should be programmed only on PMC0.",
+        "BriefDescription": "Counts Software Prefetches that are outstandi=
ng, per weighted cycle, from the time of the request to when any response i=
s received. The outstanding response should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.OUTSTANDING",
         "MSRIndex": "0x1a6",
@@ -1818,7 +1818,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for reponses from snoop request hit with =
data forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from snoop request hit with=
 data forwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1881,7 +1881,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that are outstanding, per weighted cycle, from the time=
 of the request to when any response is received. The oustanding response s=
hould be programmed only on PMC0.",
+        "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that are outstanding, per weighted cycle, from the time=
 of the request to when any response is received. The outstanding response =
should be programmed only on PMC0.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index 1b803fa38641..3dc532107ead 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -254,14 +254,14 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "Counts the number of occurences a retired loa=
d gets blocked because its address overlaps with a store whose data is not =
ready",
+        "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address overlaps with a store whose data is not=
 ready",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_STD_NOTREADY",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts the number of occurences a retired loa=
d gets blocked because its address partially overlaps with a store",
+        "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address partially overlaps with a store",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
@@ -270,7 +270,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of occurences a retired loa=
d that is a cache line split. Each split should be counted only once.",
+        "BriefDescription": "Counts the number of occurrences a retired lo=
ad that is a cache line split. Each split should be counted only once.",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_SPLITS",
@@ -293,7 +293,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Counts the number of occurences a retired sto=
re that is a cache line split. Each split should be counted only once.",
+        "BriefDescription": "Counts the number of occurrences a retired st=
ore that is a cache line split. Each split should be counted only once.",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.ST_SPLITS",
         "PublicDescription": "This event counts the number of retired stor=
e that experienced a cache line boundary split(Precise Event). Note that ea=
ch spilt should be counted only once.",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
index 3abd9c3fdc48..491cb37ddab0 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
@@ -1084,7 +1084,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cachable and UC.",
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cacheable and UC.",
         "EventCode": "0x37",
         "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.E_STATE",
         "PerPkg": "1",
@@ -1843,7 +1843,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts cycles source throttling is adderted -=
 horizontal",
+        "BriefDescription": "Counts cycles source throttling is asserted -=
 horizontal",
         "EventCode": "0xA5",
         "EventName": "UNC_H_FAST_ASSERTED.HORZ",
         "PerPkg": "1",
@@ -1851,7 +1851,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts cycles source throttling is adderted -=
 vertical",
+        "BriefDescription": "Counts cycles source throttling is asserted -=
 vertical",
         "EventCode": "0xA5",
         "EventName": "UNC_H_FAST_ASSERTED.VERT",
         "PerPkg": "1",
@@ -2929,7 +2929,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cachable and UC.",
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cacheable and UC.",
         "EventCode": "0x34",
         "EventName": "UNC_H_SF_LOOKUP.WRITE",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index afe811f154d7..41bd13baa265 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -17,7 +17,7 @@ GenuineIntel-6-6[AC],v1.18,icelakex,core
 GenuineIntel-6-3A,v23,ivybridge,core
 GenuineIntel-6-3E,v22,ivytown,core
 GenuineIntel-6-2D,v22,jaketown,core
-GenuineIntel-6-(57|85),v9,knightslanding,core
+GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-A[AC],v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
--=20
2.39.2.637.g21b0678d19-goog

