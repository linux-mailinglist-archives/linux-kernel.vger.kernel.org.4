Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0D26F233C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjD2FnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347147AbjD2Fm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:42:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA44EC3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:42:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f8a3f1961so6921617b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746888; x=1685338888;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DTTYiMDl8Yj+KSHhgdntFRxS2mVbWmHBiQYwku76Lg=;
        b=Hk1yA8bM/LfgA4lRSpMqvJ7Sl+BXH9x7VzEjrWw8ebLpMTED+LAFpDkkvrPDALumoR
         2pQSE5GXyZUwci4jmGPg9mRKEqBCx8693VhLIU22gCtifSBnZZUivt6qtQPf5ROIhe5O
         SuYAimTIHZJ56hO3J1YbYTmYovkks1Nm+ApTutClxpDTJaozHWPjCxRG85BgayT6r3DO
         sEAllj7iirHwiePJec9cdQFjL1L6tn2GVSfRn7wfptc/8AS0AB5ZVtAp+TicsGdR5Aa0
         C4BQs4F/hhR8nRp+OMhKbwUlzPU/PBowGUyqQFghdLV4oOpkjJZ+vpw8Xc1383QMQtm0
         eLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746888; x=1685338888;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DTTYiMDl8Yj+KSHhgdntFRxS2mVbWmHBiQYwku76Lg=;
        b=LZHcVEQ0O7aO8k9HvwbZZGnNIi20RKnnsws5qc1FfY2DCDCkmckimJ6qolOj3FZYYa
         SskkMdVYLC97301LwyED8v8WoFG4koAQr+5EIy5QVCnBUQ0VpJfCRnRzkwRH/u5d1/+S
         l6ukw7doFsGxZNBQBuzKW+NrHomgbqzB0316DJHKnDGVVW4YOLX/CqkRSR1q0oI0cLr7
         QfXNFgbJbzuiYZbSC7/4vLp1nhEs8qmkJsYFw/WpeuA5bLXn86QcV44Gc5reU7CnobKr
         C8q0Ax8QcRYh7eNZDK78c7F+QYrT8WGw3vDBHcawD84pW/jLmRBKtu/0Zx+e2rqxOX2K
         NEwQ==
X-Gm-Message-State: AC+VfDyJRJGIlee0dAbsUy5OAPlC/KxEj8TVjzeDSTETcd+ECzmcr80G
        Ek/WApGKfVt1r4UXjNGs9yt2NVimRxgL
X-Google-Smtp-Source: ACHHUZ7LeEl8OZgvQjF0bujUMXaM9Can3YTg/hWnMAiWPG3tXc5v9Zhw456PURvXnM3dbD4XpT7Gpbuhkkfl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a81:bc0b:0:b0:54f:69a4:151e with SMTP id
 a11-20020a81bc0b000000b0054f69a4151emr4508430ywi.8.1682746888738; Fri, 28 Apr
 2023 22:41:28 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:35:03 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-44-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 43/46] perf jevents: Don't rewrite metrics across PMUs
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't rewrite metrics across PMUs as the result events likely won't be
found. Identify metrics with a pair of PMU name and metric name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py     |  4 ++--
 tools/perf/pmu-events/metric.py      | 28 +++++++++++++++++-----------
 tools/perf/pmu-events/metric_test.py |  6 +++---
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index b18dd2fcbf04..487ff01baf1b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -391,11 +391,11 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
   except BaseException as err:
     print(f"Exception processing {path}")
     raise
-  metrics: list[Tuple[str, metric.Expression]] = []
+  metrics: list[Tuple[str, str, metric.Expression]] = []
   for event in events:
     event.topic = topic
     if event.metric_name and '-' not in event.metric_name:
-      metrics.append((event.metric_name, event.metric_expr))
+      metrics.append((event.pmu, event.metric_name, event.metric_expr))
   updates = metric.RewriteMetricsInTermsOfOthers(metrics)
   if updates:
     for event in events:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8ec0ba884673..af58b74d1644 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -552,28 +552,34 @@ def ParsePerfJson(orig: str) -> Expression:
   return _Constify(eval(compile(parsed, orig, 'eval')))
 
 
-def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, Expression]]
-                                  )-> Dict[str, Expression]:
+def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, str, Expression]]
+                                  )-> Dict[Tuple[str, str], Expression]:
   """Shorten metrics by rewriting in terms of others.
 
   Args:
-    metrics (list): pairs of metric names and their expressions.
+    metrics (list): pmus, metric names and their expressions.
   Returns:
-    Dict: mapping from a metric name to a shortened expression.
+    Dict: mapping from a pmu, metric name pair to a shortened expression.
   """
-  updates: Dict[str, Expression] = dict()
-  for outer_name, outer_expression in metrics:
+  updates: Dict[Tuple[str, str], Expression] = dict()
+  for outer_pmu, outer_name, outer_expression in metrics:
+    if outer_pmu is None:
+      outer_pmu = 'cpu'
     updated = outer_expression
     while True:
-      for inner_name, inner_expression in metrics:
+      for inner_pmu, inner_name, inner_expression in metrics:
+        if inner_pmu is None:
+          inner_pmu = 'cpu'
+        if inner_pmu.lower() != outer_pmu.lower():
+          continue
         if inner_name.lower() == outer_name.lower():
           continue
-        if inner_name in updates:
-          inner_expression = updates[inner_name]
+        if (inner_pmu, inner_name) in updates:
+          inner_expression = updates[(inner_pmu, inner_name)]
         updated = updated.Substitute(inner_name, inner_expression)
       if updated.Equals(outer_expression):
         break
-      if outer_name in updates and updated.Equals(updates[outer_name]):
+      if (outer_pmu, outer_name) in updates and updated.Equals(updates[(outer_pmu, outer_name)]):
         break
-      updates[outer_name] = updated
+      updates[(outer_pmu, outer_name)] = updated
   return updates
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index 40a3c7d8b2bc..ee22ff43ddd7 100755
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -158,9 +158,9 @@ class TestMetricExpressions(unittest.TestCase):
 
   def test_RewriteMetricsInTermsOfOthers(self):
     Expression.__eq__ = lambda e1, e2: e1.Equals(e2)
-    before = [('m1', ParsePerfJson('a + b + c + d')),
-              ('m2', ParsePerfJson('a + b + c'))]
-    after = {'m1': ParsePerfJson('m2 + d')}
+    before = [('cpu', 'm1', ParsePerfJson('a + b + c + d')),
+              ('cpu', 'm2', ParsePerfJson('a + b + c'))]
+    after = {('cpu', 'm1'): ParsePerfJson('m2 + d')}
     self.assertEqual(RewriteMetricsInTermsOfOthers(before), after)
     Expression.__eq__ = None
 
-- 
2.40.1.495.gc816e09b53d-goog

