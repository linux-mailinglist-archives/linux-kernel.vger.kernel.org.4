Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0B67C23E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbjAZBTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbjAZBTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:19:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5080661D64
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:19:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k15-20020a5b0a0f000000b007eba3f8e3baso369335ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNubpHubQS9oijDNkedGQDFmSM8xq+UbZvj/SDA553c=;
        b=pgVAJ11gdMFkeQekNhg7CG7ZryLoBS4Ig9z31agnkDHhcFuu1h2UQxELiNMU5/eouW
         AmDXXHJs33hYQ1Git4k0IBvqj1KGq4W1crRxsSzkXMz4nDinq3C2o9mqZBiSEmHhSbGQ
         YV6CSMrklfPXAuzDQhCuNxFw8xAEdMRrEB42XBTC2GrZuQUQCUuGDqJv1SrV61u0TuDm
         atI3pOn21Udq6n5T+hDG/+SA8z3SMnkY9PFKCYOM6YVFPH+lqWH27hp9T3xvj1zpwzxF
         vkpCOV0nUI6NLe3jLZOfClko+tFd/y+mXGOONM770ARZazBvODooA38YJVFXcxO4qKgF
         o16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNubpHubQS9oijDNkedGQDFmSM8xq+UbZvj/SDA553c=;
        b=o9ZdzW3c1jdK7DvZ8AKgLp9od9+VTvq/q9Joje/0gs89SPf2P889xLSt+yw1xWtcCY
         b95wGKW5EldyEvFKQ4nNAUAe6T2ZT10wdt6tPI7Tx9sATb2Qh5RbbG8Yj+mDJIbdknnS
         6vLD7IwkteaPO0tjgM8ByCu/OX9JMtAhulaRy/HCpnPDui7dbhWNONYRW4WWbWkbvKtD
         B37ymoE3zq5aThFOBMnp+wDgQb3Y2ayBa8ily9U37UviBZlupsaYbPGIjgT+AhIGrc6/
         QaG6h9MgOSkQWma/gNOpBdVozleo8/TvDizRoMUXPCTCogO4M/cF9qdi5uL/vOWvaaX0
         FffQ==
X-Gm-Message-State: AO0yUKV+WM7saf2jC8u2F92lCA11K8D1zxoQqjeIzlbyWjyyEGL+viDg
        c5WdaT9isH+Rs5fc2Tx15FoQ1QluHmZW
X-Google-Smtp-Source: AK7set+O3oLnATb/7nfISfjXSs716r/624JlSux3EJyoImU7UQJNO4w7zyM5uiaeIT2G7JdN+7NIe89dmJRI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a25:e0cd:0:b0:80b:7727:8363 with SMTP id
 x196-20020a25e0cd000000b0080b77278363mr670452ybg.366.1674695970390; Wed, 25
 Jan 2023 17:19:30 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:18:45 -0800
In-Reply-To: <20230126011854.198243-1-irogers@google.com>
Message-Id: <20230126011854.198243-4-irogers@google.com>
Mime-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 03/12] perf jevents: Rewrite metrics in the same file with
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 0416b7442171..15a1671740cc 100755
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
2.39.1.456.gfc5497dd1b-goog

