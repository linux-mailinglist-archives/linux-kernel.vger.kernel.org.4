Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D064AEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiLMFEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiLMFEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:04:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9482036A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:01:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 203-20020a2502d4000000b006f94ab02400so15335000ybc.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yu0KB4t7W5Xd9zmAyi2lGA9bjdxvCQ3UbAdr4QNgMY=;
        b=omQOjH/uMzQeAufRIrLE+kRo3ideghY40BKbwOZwFmudyu4uFE7auJtDweQ0mgBWBC
         Xe/ehOcpjuhrS8AnJNOFTXsn88ZjN2rxZ1t+wf1Sje7s60Z8rKlaPlGa65gqJyKyObec
         uaXybn0CaXL3zIdsOqEmqzRxfpSoNL4IRVhrkBEje3myCz/7e2IlWdz3F7kxnqg3iX0K
         a06iF6z0wPrCA15a9+OOX7ZloPFLa4zvD0XIQbLiMoC4dAqlJl5wj3k1NIpmp9X2CPqd
         BwqYepF5WXs+Q8tjTZWuR3DB4w9r3XPBqibOZPe8Mfj2HRajmijaCcPhBOEmYfP/J8K9
         vqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/yu0KB4t7W5Xd9zmAyi2lGA9bjdxvCQ3UbAdr4QNgMY=;
        b=e507RMKkyNgswN6imu5Q6mWRT+k5xJAuOhZqGiImBCFpXfpcxaDWOSiiZ9y4IPfvm3
         A/Mt6aGh3S9ru3xZ1B9kRenhoxUq5AuX5+scFbWn0S8sdhKCt3y4bsJF971tqmVnn0qq
         6i6zI4YLMhg8lEJbFGHwuc9mAUMuIh1ch1ty3TL/fOlspEHSba/2D6Ah6rYRP1xWqGuR
         9CP5yaT/HEvukkkMcCzpHnCAOG+VdO2h3arWf+nz8mumEDPOlKRCeuFRXRaik46P1CKK
         JMuDIAhtZWx8rLWscfe70P6raRjWuNN4rmE9GBY8rYxO2r1/xTuDbMrqMFPQk2ud3YJC
         HvkA==
X-Gm-Message-State: ANoB5plfN3GCk89RS4fnHKHO+/PRvCnn1sM78KamBjORuBDq5ihICfYt
        ohom0FFktWOERpwuWdkfT5Bi8rVEFpT5
X-Google-Smtp-Source: AA0mqf6LMHxkSd1PpCxd+RlFoILbgtvWw1wyzKsAapYJZvZE1Kj8RskNcjPo93idzf1GhYNyS3ZVHXsus8j4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6b9f:864c:28da:e99b])
 (user=irogers job=sendgmr) by 2002:a81:b807:0:b0:3b3:3f1d:8623 with SMTP id
 v7-20020a81b807000000b003b33f1d8623mr1908277ywe.96.1670907707153; Mon, 12 Dec
 2022 21:01:47 -0800 (PST)
Date:   Mon, 12 Dec 2022 21:00:37 -0800
In-Reply-To: <20221213050043.1199380-1-irogers@google.com>
Message-Id: <20221213050043.1199380-4-irogers@google.com>
Mime-Version: 1.0
References: <20221213050043.1199380-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH v1 3/9] perf jevents: Rewrite metrics in the same file with
 each other
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
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

Rewrite metrics within the same file in terms of each other. For example, o=
n Power8
other_stall_cpi is rewritten from:
"PM_CMPLU_STALL / PM_RUN_INST_CMPL - PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_C=
MPL - PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_VSU / PM_RUN_I=
NST_CMPL - PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NTCG_FLUS=
H / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL"
to:
"stall_cpi - bru_cru_stall_cpi - fxu_stall_cpi - vsu_stall_cpi - lsu_stall_=
cpi - ntcg_flush_cpi - no_ntf_stall_cpi"
Which more closely matches the definition on Power9.

To avoid recomputation decorate the function with a cache.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 4c398e0eeb2f..229402565425 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -3,6 +3,7 @@
 """Convert directories of JSON events to C code."""
 import argparse
 import csv
+from functools import lru_cache
 import json
 import metric
 import os
@@ -337,18 +338,28 @@ class JsonEvent:
     s =3D self.build_c_string()
     return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
=20
-
+@lru_cache(maxsize=3DNone)
 def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
-
   try:
-    result =3D json.load(open(path), object_hook=3DJsonEvent)
+    events =3D json.load(open(path), object_hook=3DJsonEvent)
   except BaseException as err:
     print(f"Exception processing {path}")
     raise
-  for event in result:
+  metrics: list[Tuple[str, metric.Expression]] =3D []
+  for event in events:
     event.topic =3D topic
-  return result
+    if event.metric_name and '-' not in event.metric_name:
+      metrics.append((event.metric_name, event.metric_expr))
+  updates =3D metric.RewriteMetricsInTermsOfOthers(metrics)
+  if updates:
+    for event in events:
+      if event.metric_name in updates:
+        # print(f'Updated {event.metric_name} from\n"{event.metric_expr}"\=
n'
+        #       f'to\n"{updates[event.metric_name]}"')
+        event.metric_expr =3D updates[event.metric_name]
+
+  return events
=20
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
--=20
2.39.0.rc1.256.g54fd8350bd-goog

