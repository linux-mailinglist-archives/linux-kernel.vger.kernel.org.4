Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCE69BF9B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBSJd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjBSJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:33:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C21259E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:32:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f33-20020a25b0a1000000b009433a21be0dso2107037ybj.19
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHfJUUC7WFoksqzMwO/wB71MjmrmmBDk4U3wZWtbf08=;
        b=fX59j52xFTzLYLu6bfL/D7xhUQY699O8G2CBhOY2b+WQeh/CNRkmVbk6izOLD09kRS
         ElhU4Qo79C2zelyYISHlIQ06bx7oywbUO5YVV+td+ogHhr5ySpZA39YLt/jD3Rgl4Hru
         NSl1oSHcdzoPDzg7iF8Lms4PQ0/pfTnWuTfK8wSI6NYne98qpyTFNmdRCtV6neg55tJh
         Ro7kutyBaTvkQVQM9r2EZf+9Ichm6O4JTDhrgZK0xRKCqHyknhKGMchi+O2i5EdVLhjY
         xtmOJEGgVHLUBujQkjjQT/JAK8oWzaiy/iTO9dpZZUZDbqFaUd9bzxnQJrq9uVzKKKb3
         CXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HHfJUUC7WFoksqzMwO/wB71MjmrmmBDk4U3wZWtbf08=;
        b=ab5hjDgrxUSS2DL/EsGHsrIK3qFVlNyw/gB47LyHu5pePIAYSTLr2VI2oHlwvACc8U
         3HABmbyoLcWcp2QS9eZ0+tePlLr+9CO4+Im2rVYRgmfKQ10UcMp8aNCvmEolFxoy2NNV
         9ci/xCrCLdO6dvtx0t2KUqZLefUvFZzQhYTuNTKgIFt9+wMKhhz19yuWHuXDY44NqepM
         Vvlf2SsaLLOTwWtvpSzBzMh5i2+vt0YV4XjrOGv83SIl8Dw8fzIwlB5EjjYCHRCUPyqn
         TTTYS092RC61S7jYrLCk6KIEJsQNovSEn4U0oRzb2Hu2G9m5waZobruiNov9pnzxWzHO
         bvqw==
X-Gm-Message-State: AO0yUKUskbPSG1MHQSb2mSBlJfmeiw78ewl/AbzFzPdEqhMcQdJS5Aem
        Mu7l97fYD3Bq+HUJjOaK7qzx+YVGiJi/
X-Google-Smtp-Source: AK7set8jEArVFXMo6IHVLJPY3ZmOWPp1glRFXg65Ui1PEiXcYJcQSImzCALuyAA28kKpKUSiX264PfiGtWoA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a25:8312:0:b0:889:8b19:faec with SMTP id
 s18-20020a258312000000b008898b19faecmr515910ybk.196.1676799165017; Sun, 19
 Feb 2023 01:32:45 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:24 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-28-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 27/51] perf vendor events intel: Refresh silvermont events
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the silvermont events from 14 to 15. Generation was done using
https://github.com/intel/perfmon.

The most notable change is in corrections to event descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv              | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/frontend.json | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/pipeline.json | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 1f611a7dbdda..d1d40d0f2b2c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v18,sandybridge,core
 GenuineIntel-6-(8F|CF),v1.11,sapphirerapids,core
-GenuineIntel-6-(37|4A|4C|4D|5A),v14,silvermont,core
+GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/frontend.json
index c35da10f7133..cd6ed3f59e26 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
@@ -11,7 +11,7 @@
         "BriefDescription": "Counts the number of JCC baclears",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
-        "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.COND event counts the number of J=
CC (Jump on Condtional Code) baclears.",
+        "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.COND event counts the number of J=
CC (Jump on Conditional Code) baclears.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 59f6116a7eae..2d4214bf9e39 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -228,7 +228,7 @@
         "BriefDescription": "Counts the number of cycles when no uops are =
allocated, the IQ is empty, and no other condition is blocking allocation."=
,
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.NOT_DELIVERED",
-        "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is u=
sed to measure front-end inefficiencies, i.e. when front-end of the machine=
 is not delivering micro-ops to the back-end and the back-end is not stalle=
d. This event can be used to identify if the machine is truly front-end bou=
nd.  When this event occurs, it is an indication that the front-end of the =
machine is operating at less than its theoretical peak performance.  Backgr=
ound: We can think of the processor pipeline as being divided into 2 broade=
r parts: Front-end and Back-end. Front-end is responsible for fetching the =
instruction, decoding into micro-ops (uops) in machine understandable forma=
t and putting them into a micro-op queue to be consumed by back end. The ba=
ck-end then takes these micro-ops, allocates the required resources.  When =
all resources are ready, micro-ops are executed. If the back-end is not rea=
dy to accept micro-ops from the front-end, then we do not want to count the=
se as front-end bottlenecks.  However, whenever we have bottlenecks in the =
back-end, we will have allocation unit stalls and eventually forcing the fr=
ont-end to wait until the back-end is ready to receive more UOPS. This even=
t counts the cycles only when back-end is requesting more uops and front-en=
d is not able to provide them. Some examples of conditions that cause front=
-end efficiencies are: Icache misses, ITLB misses, and decoder restrictions=
 that limit the the front-end bandwidth.",
+        "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is u=
sed to measure front-end inefficiencies, i.e. when front-end of the machine=
 is not delivering micro-ops to the back-end and the back-end is not stalle=
d. This event can be used to identify if the machine is truly front-end bou=
nd.  When this event occurs, it is an indication that the front-end of the =
machine is operating at less than its theoretical peak performance.  Backgr=
ound: We can think of the processor pipeline as being divided into 2 broade=
r parts: Front-end and Back-end. Front-end is responsible for fetching the =
instruction, decoding into micro-ops (uops) in machine understandable forma=
t and putting them into a micro-op queue to be consumed by back end. The ba=
ck-end then takes these micro-ops, allocates the required resources.  When =
all resources are ready, micro-ops are executed. If the back-end is not rea=
dy to accept micro-ops from the front-end, then we do not want to count the=
se as front-end bottlenecks.  However, whenever we have bottlenecks in the =
back-end, we will have allocation unit stalls and eventually forcing the fr=
ont-end to wait until the back-end is ready to receive more UOPS. This even=
t counts the cycles only when back-end is requesting more uops and front-en=
d is not able to provide them. Some examples of conditions that cause front=
-end efficiencies are: Icache misses, ITLB misses, and decoder restrictions=
 that limit the front-end bandwidth.",
         "SampleAfterValue": "200003",
         "UMask": "0x50"
     },
--=20
2.39.2.637.g21b0678d19-goog

