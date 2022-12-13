Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14D64AEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiLMFEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiLMFEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:04:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A627A1F2FE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:01:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s6-20020a259006000000b00706c8bfd130so15462875ybl.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AGnxJT7wFPrT6O2zjqnv50t0OxM3hN31p4+XTV8CeE=;
        b=E7g3wOZoSoV4aJa6GNlR2D6FAnt//pfKjjXbey1DRdILGuysRzGgPZth7GUYYtPdF/
         6DyY8PPYKWr7o89yiynyqDlX1ladpDHOjt9tDhtR8LBefuIBeiA0UJA7BK5t/A0qM0AE
         I7eXgO8UpnozbgcDbFT2v4KXDGCuJluycIf0PAQPuk+MNZvzEmwiFI3GUY1T0aL0zAAj
         /2VbEjphHxVsSWU3cjaCIEQZijVd7xYnMpt2jWlt6q1UA0jUfCYPVaLpdabv5zlrXFMY
         PqwYpf8Z6cdeRZCAjr1OC0LP5CLzHo/KI8hmX755lNB/SaWgoACnQTLdcwbZrKtWRT9r
         bnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AGnxJT7wFPrT6O2zjqnv50t0OxM3hN31p4+XTV8CeE=;
        b=jWW5q3WVvmo2+x101++Wv2GEPEqnjBe85qrOHNndoTK48XqKrgtuhFfEhuAGTqxYwx
         3WG190OLOdwZrVnUxAnmnjnmehJ+TVgroRU2vgU7iq2YJAkV38K8QSOD43yYa7ZNk6Vm
         Kygc9EqHnuUjLwUwFONj593fZ6biBoOtNsCdLBWrBEfmgyBS68HAdEaWZ+DlH8oEeQQ+
         I6L5PkzKMCzpR5xdj6GpDoK4nQW1KI0CAJ7ko5vYllUgiNGJg9tVKL/IfNd5ZoXhHAPV
         TIju+tRrW7Y16S3MxnTcyQcMM08Ms/5JOqSzNdg7MdtuolqCq26wHQVijcE+VRJsqC6Q
         aphg==
X-Gm-Message-State: ANoB5pl6nXzEaF6867pZ6FOsfK3IcrNVWJCkui/LYCXGogOYftILrSQZ
        uuM0Bd4GBBaaxWJ3zVG6vGVd6/TIppLg
X-Google-Smtp-Source: AA0mqf40TO7Mr+/zV7GrkQuA3b0tyV7KzhW6jOhVtPzEws2j2FcuyC6lQSc/GOCYxZg/uDoo0fVOjla2QTv4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6b9f:864c:28da:e99b])
 (user=irogers job=sendgmr) by 2002:a25:d250:0:b0:6f4:f4d:c47a with SMTP id
 j77-20020a25d250000000b006f40f4dc47amr57842041ybg.398.1670907698769; Mon, 12
 Dec 2022 21:01:38 -0800 (PST)
Date:   Mon, 12 Dec 2022 21:00:36 -0800
In-Reply-To: <20221213050043.1199380-1-irogers@google.com>
Message-Id: <20221213050043.1199380-3-irogers@google.com>
Mime-Version: 1.0
References: <20221213050043.1199380-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH v1 2/9] perf jevents metric: Add ability to rewrite metrics in
 terms of others
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RewriteMetricsInTermsOfOthers that iterates over pairs of names
and expressions trying to replace an expression, within the current
expression, with its name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py      | 69 +++++++++++++++++++++++++++-
 tools/perf/pmu-events/metric_test.py | 10 ++++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 1fa3478b9ab0..8e4deb8e95e2 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -4,7 +4,7 @@ import ast
 import decimal
 import json
 import re
-from typing import Dict, List, Optional, Set, Union
+from typing import Dict, List, Optional, Set, Tuple, Union
 
 
 class Expression:
@@ -26,6 +26,9 @@ class Expression:
     """Returns true when two expressions are the same."""
     raise NotImplementedError()
 
+  def Substitute(self, name: str, expression: 'Expression') -> 'Expression':
+    raise NotImplementedError()
+
   def __str__(self) -> str:
     return self.ToPerfJson()
 
@@ -186,6 +189,15 @@ class Operator(Expression):
           other.lhs) and self.rhs.Equals(other.rhs)
     return False
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    if self.Equals(expression):
+      return Event(name)
+    lhs = self.lhs.Substitute(name, expression)
+    rhs = None
+    if self.rhs:
+      rhs = self.rhs.Substitute(name, expression)
+    return Operator(self.operator, lhs, rhs)
+
 
 class Select(Expression):
   """Represents a select ternary in the parse tree."""
@@ -225,6 +237,14 @@ class Select(Expression):
           other.false_val) and self.true_val.Equals(other.true_val)
     return False
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    if self.Equals(expression):
+      return Event(name)
+    true_val = self.true_val.Substitute(name, expression)
+    cond = self.cond.Substitute(name, expression)
+    false_val = self.false_val.Substitute(name, expression)
+    return Select(true_val, cond, false_val)
+
 
 class Function(Expression):
   """A function in an expression like min, max, d_ratio."""
@@ -267,6 +287,15 @@ class Function(Expression):
       return result
     return False
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    if self.Equals(expression):
+      return Event(name)
+    lhs = self.lhs.Substitute(name, expression)
+    rhs = None
+    if self.rhs:
+      rhs = self.rhs.Substitute(name, expression)
+    return Function(self.fn, lhs, rhs)
+
 
 def _FixEscapes(s: str) -> str:
   s = re.sub(r'([^\\]),', r'\1\\,', s)
@@ -293,6 +322,9 @@ class Event(Expression):
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Event) and self.name == other.name
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
 
 class Constant(Expression):
   """A constant within the expression tree."""
@@ -317,6 +349,9 @@ class Constant(Expression):
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Constant) and self.value == other.value
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
 
 class Literal(Expression):
   """A runtime literal within the expression tree."""
@@ -336,6 +371,9 @@ class Literal(Expression):
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Literal) and self.value == other.value
 
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
 
 def min(lhs: Union[int, float, Expression], rhs: Union[int, float,
                                                        Expression]) -> Function:
@@ -461,9 +499,11 @@ class MetricGroup:
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
+  """Transformer to convert if-else nodes to Select expressions."""
 
   def visit_IfExp(self, node):
     # pylint: disable=invalid-name
+    self.generic_visit(node)
     call = ast.Call(
         func=ast.Name(id='Select', ctx=ast.Load()),
         args=[node.body, node.test, node.orelse],
@@ -501,3 +541,30 @@ def ParsePerfJson(orig: str) -> Expression:
   _RewriteIfExpToSelect().visit(parsed)
   parsed = ast.fix_missing_locations(parsed)
   return _Constify(eval(compile(parsed, orig, 'eval')))
+
+
+def RewriteMetricsInTermsOfOthers(metrics: list[Tuple[str, Expression]]
+                                  )-> Dict[str, Expression]:
+  """Shorten metrics by rewriting in terms of others.
+
+  Args:
+    metrics (list): pairs of metric names and their expressions.
+  Returns:
+    Dict: mapping from a metric name to a shortened expression.
+  """
+  updates: Dict[str, Expression] = dict()
+  for outer_name, outer_expression in metrics:
+    updated = outer_expression
+    while True:
+      for inner_name, inner_expression in metrics:
+        if inner_name == outer_name:
+          continue
+        if inner_name in updates:
+          inner_expression = updates[inner_name]
+        updated = updated.Substitute(inner_name, inner_expression)
+      if updated.Equals(outer_expression):
+        break
+      if outer_name in updates and updated.Equals(updates[outer_name]):
+        break
+      updates[outer_name] = updated
+  return updates
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index 4741b7b6612d..3a0182898bfe 100644
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -2,7 +2,9 @@
 import unittest
 from metric import Constant
 from metric import Event
+from metric import Expression
 from metric import ParsePerfJson
+from metric import RewriteMetricsInTermsOfOthers
 
 
 class TestMetricExpressions(unittest.TestCase):
@@ -149,5 +151,13 @@ class TestMetricExpressions(unittest.TestCase):
     after = '0 * SLOTS'
     self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
 
+  def test_RewriteMetricsInTermsOfOthers(self):
+    Expression.__eq__ = lambda e1, e2: e1.Equals(e2)
+    before = [('m1', ParsePerfJson('a + b + c + d')),
+              ('m2', ParsePerfJson('a + b + c'))]
+    after = {'m1': ParsePerfJson('m2 + d')}
+    self.assertEqual(RewriteMetricsInTermsOfOthers(before), after)
+    Expression.__eq__ = None
+
 if __name__ == '__main__':
   unittest.main()
-- 
2.39.0.rc1.256.g54fd8350bd-goog

