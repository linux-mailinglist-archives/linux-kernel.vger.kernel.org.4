Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B167D9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjAZXhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjAZXha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:37:30 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C728C6B98D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:37:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5028c723d28so37269327b3.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZMgv7d+qS2IPgaZDQ3hwKBijNPiryE68frwCkys2NE=;
        b=p07QyxNyuqbp4f6wdTyQ7nt4VdaMwxGyoUK/0k2+63P0aiCeLgEz6DjMog0g+BetuJ
         q4pQTACbjzryhviMQ7vTHUrQI24o/45haTUFAOLWErFNTxgCq5X5+HRsBn9eyAWoH4N4
         kF3zZU3ZD5vxAiRvXWqhkXutjZAdJZbRD7+JVrpfqF/FValQvpWBkxlakz+yZRJ8lepk
         SGDXDTqhl0YpGkN+hMyL0Rem7V4cd7OfHr057iRaKSizy6p8XVO9HOOaU4/hv8m32p0Y
         aeTuUyycKmjfDfm76GbEp6ylGlX0/qmzKS6fY4eGiYHwbWPrrVLMtnbfxgsipHXOy3mk
         RLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sZMgv7d+qS2IPgaZDQ3hwKBijNPiryE68frwCkys2NE=;
        b=qyiREh6LzmXzZM0wB1bx7gpCkBY1hV8WQCjSBQRseWRpYoIO9xZREQm1gIjlOIS6Ov
         gCNgtc0WbR/h2gphOnnTCs9mOLrDSLNSTpgP/rBnp7Mh8PaBPr5W2+w3yFqIgljg8vuy
         U8KRCRUyKymyg3dn2IN/pz7v+2EbuEfmV2EQVtWqNy+oVPWm9rCuHPaNIWVEPWEalfmV
         zi0sQlPaWuF5sLHuMbQK6924GBVbr/AIIQMhoyE5bxPPjbPgI9qJ6ciI+YDkahtxKWwc
         Rn3IAXzAS+2PDD8LZpUqjFYe45m8bow4xbAxXdgQ8a6HUQ+HUyrG0CWxHVWV2F5V2M3P
         g57g==
X-Gm-Message-State: AO0yUKWBLUdhizrJPrkajJXqxl9Myhvk9Xo40/ulHvJE3RXtkdtxZakT
        3+rC78oHSwz3hz61CGqN+kQ4w9qYWCxW
X-Google-Smtp-Source: AK7set8J8fjITXrFkqjV8qoRxG/OptJXGdliAd6Ni2HXOVXiJKUwFJUhB7iGDfPx931wpEDI7WZbS7czEKbF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a25:491:0:b0:80b:d57a:612f with SMTP id
 139-20020a250491000000b0080bd57a612fmr361423ybe.448.1674776240866; Thu, 26
 Jan 2023 15:37:20 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:33 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-4-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 03/15] perf jevents: Rewrite metrics in the same file with
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

