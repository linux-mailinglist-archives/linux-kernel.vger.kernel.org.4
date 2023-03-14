Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69716B8A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCNFd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCNFdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:33:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14B95BD3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:33:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5416d3a321eso82351657b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678772011;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yo+9QhC9Y1oOJSW75hPwug1Qu/dRSp9aIk8ghfKEMgQ=;
        b=Dq4zD5rWpRk6oJ7t52YqdkGvzqU/c2AcWgrcr8r0JVvfNFhCNitsu61mQ6ob6Vrble
         i5gvgoer2AMcz7ZYe27Mb0etmBEMrN5/ty4zQ4IZoO2MQYPzcW1CvkfodfAmaPK/bflc
         lKcAcWuv9FYk5o9zVmrEmb32QMUN6/xtcCnxbRuzifz8Kd+UkRhbBFPA38F76enNrqY6
         QFywG2ZKl+uHRZmZlS0XMj6sv1Yu96jfyzdW5p7QoITUQZgg6TTasSvFzTMpcqow04wC
         cA8w8E4lGqNPpSlHmo1Eg5EC6yLOzX0Xr0n0wZKckBhpvRz22oODLUSzfdx08gWtL1oO
         t7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772011;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yo+9QhC9Y1oOJSW75hPwug1Qu/dRSp9aIk8ghfKEMgQ=;
        b=jHQA/rRxlE6KX6S6YyhVpEBpXUqiDMmImXB7FQiAXls1cCqtDKFxllZ5AI64jfaSb7
         +CQHy5kG81qHiXRQwDIcG2STg1+p1J+ul8bPdtU+WWdx2xB7NUssWQt4bqIqh81fT+7i
         d56fv8tFPoKYFNVjqVpk/rVNEsGlChvoGjAaFfPO+yArFEVcaPQfmkdTTwKg2vgQCZ41
         7zmIZ6IlQNv3obnAlZcyCjcEcASbZby8zOgFGng1ZwEQnyDj3JyKlWBq+UU35QqW8olL
         S/VNMmVjgnUjEwuhl0Au52qa8DDIwqCsMUCYOMqrE5pEDVgmhVERWw7B+TkHtT/OF/3F
         s4bQ==
X-Gm-Message-State: AO0yUKXk6Uw3N7i1oLAMCTAgHMvQC1j8GLCHz2Rt7pwgwkFpiULG11sQ
        xBeprS7fccG65DFXEgDGZpte0v36DduU
X-Google-Smtp-Source: AK7set8yUqbHELyqGpga0KYDTnr4HkzzSgZx416+cfvef6fIqYMHez/P8DmyhkwpcNOrpbQeVvnSHbg7Kg16
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:adc3:d11e:dcd7:fd4e])
 (user=irogers job=sendgmr) by 2002:a05:6902:3:b0:a24:7038:ae61 with SMTP id
 l3-20020a056902000300b00a247038ae61mr12ybh.611.1678772010865; Mon, 13 Mar
 2023 22:33:30 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:33:10 -0700
In-Reply-To: <20230314053312.3237390-1-irogers@google.com>
Message-Id: <20230314053312.3237390-2-irogers@google.com>
Mime-Version: 1.0
References: <20230314053312.3237390-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 1/3] perf vendor events intel: Update graniterapids events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
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

Update from 1.00 to 1.01, some event description updates.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/graniterapids/frontend.json | 2 +-
 tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json | 4 ++--
 tools/perf/pmu-events/arch/x86/mapfile.csv                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/frontend.json
index dfd9c5ea1584..c6d5016e7337 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
@@ -3,7 +3,7 @@
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were no operation was delivered to the back-end pipeline due =
to instruction fetch limitations when the back-end could have accepted more=
 operations. Common examples include instruction cache misses or x86 instru=
ction decode limitations.",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations.\nThe count may be distributed among unhalted log=
ical processors (hyper-threads) who share the same physical core, in proces=
sors that support Intel Hyper-Threading Technology. Software can use this e=
vent as the nominator for the Frontend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were no operation was delivered to the back-end pipeline due=
 to instruction fetch limitations when the back-end could have accepted mor=
e operations. Common examples include instruction cache misses or x86 instr=
uction decode limitations.\nThe count may be distributed among unhalted log=
ical processors (hyper-threads) who share the same physical core, in proces=
sors that support Intel Hyper-Threading Technology. Software can use this e=
vent as the numerator for the Frontend Bound metric (or top-level category)=
 of the Top-down Microarchitecture Analysis method.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index d6aafb258708..764c0435d1d2 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -72,7 +72,7 @@
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions.\nThe count is distributed among unhalted l=
ogical processors (hyper-threads) who share the same physical core, in proc=
essors that support Intel Hyper-Threading Technology. Software can use this=
 event as the nominator for the Backend Bound metric (or top-level category=
) of the Top-down Microarchitecture Analysis method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that were not consumed by the back-end pipeline due to lack of ba=
ck-end resources, as a result of memory subsystem delays, execution units l=
imitations, or other conditions.\nThe count is distributed among unhalted l=
ogical processors (hyper-threads) who share the same physical core, in proc=
essors that support Intel Hyper-Threading Technology. Software can use this=
 event as the numerator for the Backend Bound metric (or top-level category=
) of the Top-down Microarchitecture Analysis method.",
         "SampleAfterValue": "10000003",
         "UMask": "0x2"
     },
@@ -95,7 +95,7 @@
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric.\nSoftware can use this event as the nominator for the Retirin=
g metric (or top-level category) of the Top-down Microarchitecture Analysis=
 method.",
+        "PublicDescription": "This event counts a subset of the Topdown Sl=
ots event that are utilized by operations that eventually get retired (comm=
itted) by the processor pipeline. Usually, this event positively correlates=
 with higher performance  for example, as measured by the instructions-per-=
cycle metric.\nSoftware can use this event as the numerator for the Retirin=
g metric (or top-level category) of the Top-down Microarchitecture Analysis=
 method.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index bb4e545fa100..210dd9b2004f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-55-[56789ABCDEF],v1.17,cascadelakex,core
 GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-A[DE],v1.00,graniterapids,core
+GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v32,haswell,core
 GenuineIntel-6-3F,v26,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
--=20
2.40.0.rc1.284.g88254d51c5-goog

