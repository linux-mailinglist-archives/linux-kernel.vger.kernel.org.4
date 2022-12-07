Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B7E6453C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLGGAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiLGF7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:59:43 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD30059874
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 21:59:14 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3b0af5bcbd3so177707417b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 21:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYbNqgEE03p3A4pTlvAUnV0fi+Mn7k/68mvpccxV7jU=;
        b=qLed3h5rDpVylUJbc3S0BBXE10VW3t1zXnP0ieXXG1fOqNRscP2XfIToYkcin9izQy
         XYXoMhTK9arYFa8uuXPRWtB1A/CWkm40Og0pNG+olOZWVTLi2R0857ypbl6eRLBQstR9
         huL0K+5TQFSOt2/wjh8btYUb3Cmn2Y4RgA50mizRvokzD6zTcHxANtJ3ElAJ9YvUDuh0
         XI656cokVDaDJA90ecQfseSO8xILtl6fzoQFtQv+J3yoJypVXh/V1nHvmTfFCvuXdC/a
         7dUNYNx8XKBjGw4pSDONJIUVR8kYD+s6k5CspcB5va5qKDD33mS7wkZ0EngjCT57Whwv
         ye4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYbNqgEE03p3A4pTlvAUnV0fi+Mn7k/68mvpccxV7jU=;
        b=vpgLyayv86QddUQoqZRWqXA8SqCdyOpkarVjhAA1iJiQqTW+RWM+kODj309L1bB3+P
         KPSnh9+7D6CAzd9y545wKsJvKlnApMvebI81SGfcV0qK2UFv/sVA4f0qoyV4xBzBop4i
         zL9xuTlFA6XKOSmknxYnQ7nean3IZQwuKdE4do63UHl3XlynjQng3VT/wSqzncZq3rHm
         Eru8jAHRYQJS4IzO369VYiosf9BmXeuA89JarqVFN+n/PU6GeyjczL5jzplkgdU8QHAS
         fZ1wxo3XXvZd7cACOAU4SP2Yv5wXfT20DYKI3L2Z9N3Y0t1PhPUN5mylYt/cPGgsPmrB
         vhQA==
X-Gm-Message-State: ANoB5pkV4W4JohipOdQaQP8A532lR/5hxCtXSAp7Nk+bX4z4C9S0HV1w
        1NVy0HmYT+1tHzWZwn2vJVyoY62g+KvX
X-Google-Smtp-Source: AA0mqf4/+95K6SCk7ZsVJu+//kAF2EH3IwsOKbbFGksHxSL/IV8jM+TVSqLTs7wMyKqQqACz4d8Bg4j/1P0c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9924:6640:f748:d70b])
 (user=irogers job=sendgmr) by 2002:a25:d655:0:b0:6fc:1c96:c9fe with SMTP id
 n82-20020a25d655000000b006fc1c96c9femr25780434ybg.36.1670392754072; Tue, 06
 Dec 2022 21:59:14 -0800 (PST)
Date:   Tue,  6 Dec 2022 21:59:08 -0800
Message-Id: <20221207055908.1385448-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH v4] perf jevents: Parse metrics during conversion
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the 'MetricExpr' json value is passed from the json
file to the pmu-events.c. This change introduces an expression
tree that is parsed into. The parsing is done largely by using
operator overloading and python's 'eval' function. Two advantages
in doing this are:

1) Broken metrics fail at compile time rather than relying on
   `perf test` to detect. `perf test` remains relevant for checking
   event encoding and actual metric use.

2) The conversion to a string from the tree can minimize the metric's
   string size, for example, preferring 1e6 over 1000000, avoiding
   multiplication by 1 and removing unnecessary whitespace. On x86
   this reduces the string size by 2,930bytes (0.07%).

In future changes it would be possible to programmatically
generate the json expressions (a single line of text and so a
pain to write manually) for an architecture using the expression
tree. This could avoid copy-pasting metrics for all architecture
variants.

Signed-off-by: Ian Rogers <irogers@google.com>

v4. Doesn't simplify "0*SLOTS" to 0, as the pattern is used to fix
    Intel metrics with topdown events.
v3. Avoids generic types on standard types like set that aren't
    supported until Python 3.9, fixing an issue with Python 3.6
    reported-by John Garry. v3 also fixes minor pylint issues and adds
    a call to Simplify on the read expression tree.
v2. Improvements to type information.
---
 tools/perf/pmu-events/Build          |   2 +-
 tools/perf/pmu-events/jevents.py     |  12 +-
 tools/perf/pmu-events/metric.py      | 501 +++++++++++++++++++++++++++
 tools/perf/pmu-events/metric_test.py | 153 ++++++++
 4 files changed, 664 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/pmu-events/metric.py
 create mode 100644 tools/perf/pmu-events/metric_test.py

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 04ef95174660..15b9e8fdbffa 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -21,7 +21,7 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY) pmu-events/metric.py
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
 endif
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 0daa3e007528..4c398e0eeb2f 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -4,6 +4,7 @@
 import argparse
 import csv
 import json
+import metric
 import os
 import sys
 from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
@@ -268,9 +269,10 @@ class JsonEvent:
     self.metric_name = jd.get('MetricName')
     self.metric_group = jd.get('MetricGroup')
     self.metric_constraint = jd.get('MetricConstraint')
-    self.metric_expr = jd.get('MetricExpr')
-    if self.metric_expr:
-      self.metric_expr = self.metric_expr.replace('\\', '\\\\')
+    self.metric_expr = None
+    if 'MetricExpr' in jd:
+       self.metric_expr = metric.ParsePerfJson(jd['MetricExpr']).Simplify()
+
     arch_std = jd.get('ArchStdEvent')
     if precise and self.desc and '(Precise Event)' not in self.desc:
       extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
@@ -322,6 +324,10 @@ class JsonEvent:
     s = ''
     for attr in _json_event_attributes:
       x = getattr(self, attr)
+      if x and attr == 'metric_expr':
+        # Convert parsed metric expressions into a string. Slashes
+        # must be doubled in the file.
+        x = x.ToPerfJson().replace('\\', '\\\\')
       s += f'{x}\\000' if x else '\\000'
     return s
 
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
new file mode 100644
index 000000000000..cc451a265751
--- /dev/null
+++ b/tools/perf/pmu-events/metric.py
@@ -0,0 +1,501 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+"""Parse or generate representations of perf metrics."""
+import ast
+import decimal
+import json
+import re
+from typing import Dict, List, Optional, Set, Union
+
+
+class Expression:
+  """Abstract base class of elements in a metric expression."""
+
+  def ToPerfJson(self) -> str:
+    """Returns a perf json file encoded representation."""
+    raise NotImplementedError()
+
+  def ToPython(self) -> str:
+    """Returns a python expr parseable representation."""
+    raise NotImplementedError()
+
+  def Simplify(self):
+    """Returns a simplified version of self."""
+    raise NotImplementedError()
+
+  def Equals(self, other) -> bool:
+    """Returns true when two expressions are the same."""
+    raise NotImplementedError()
+
+  def __str__(self) -> str:
+    return self.ToPerfJson()
+
+  def __or__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('|', self, other)
+
+  def __ror__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('|', other, self)
+
+  def __xor__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('^', self, other)
+
+  def __and__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('&', self, other)
+
+  def __lt__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('<', self, other)
+
+  def __gt__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('>', self, other)
+
+  def __add__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('+', self, other)
+
+  def __radd__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('+', other, self)
+
+  def __sub__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('-', self, other)
+
+  def __rsub__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('-', other, self)
+
+  def __mul__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('*', self, other)
+
+  def __rmul__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('*', other, self)
+
+  def __truediv__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('/', self, other)
+
+  def __rtruediv__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('/', other, self)
+
+  def __mod__(self, other: Union[int, float, 'Expression']) -> 'Operator':
+    return Operator('%', self, other)
+
+
+def _Constify(val: Union[bool, int, float, Expression]) -> Expression:
+  """Used to ensure that the nodes in the expression tree are all Expression."""
+  if isinstance(val, bool):
+    return Constant(1 if val else 0)
+  if isinstance(val, (int, float)):
+    return Constant(val)
+  return val
+
+
+# Simple lookup for operator precedence, used to avoid unnecessary
+# brackets. Precedence matches that of python and the simple expression parser.
+_PRECEDENCE = {
+    '|': 0,
+    '^': 1,
+    '&': 2,
+    '<': 3,
+    '>': 3,
+    '+': 4,
+    '-': 4,
+    '*': 5,
+    '/': 5,
+    '%': 5,
+}
+
+
+class Operator(Expression):
+  """Represents a binary operator in the parse tree."""
+
+  def __init__(self, operator: str, lhs: Union[int, float, Expression],
+               rhs: Union[int, float, Expression]):
+    self.operator = operator
+    self.lhs = _Constify(lhs)
+    self.rhs = _Constify(rhs)
+
+  def Bracket(self,
+              other: Expression,
+              other_str: str,
+              rhs: bool = False) -> str:
+    """If necessary brackets the given other value.
+
+    If ``other`` is an operator then a bracket is necessary when
+    this/self operator has higher precedence. Consider: '(a + b) * c',
+    ``other_str`` will be 'a + b'. A bracket is necessary as without
+    the bracket 'a + b * c' will evaluate 'b * c' first. However, '(a
+    * b) + c' doesn't need a bracket as 'a * b' will always be
+    evaluated first. For 'a / (b * c)' (ie the same precedence level
+    operations) then we add the bracket to best match the original
+    input, but not for '(a / b) * c' where the bracket is unnecessary.
+
+    Args:
+      other (Expression): is a lhs or rhs operator
+      other_str (str): ``other`` in the appropriate string form
+      rhs (bool):  is ``other`` on the RHS
+
+    Returns:
+      str: possibly bracketed other_str
+    """
+    if isinstance(other, Operator):
+      if _PRECEDENCE.get(self.operator, -1) > _PRECEDENCE.get(
+          other.operator, -1):
+        return f'({other_str})'
+      if rhs and _PRECEDENCE.get(self.operator, -1) == _PRECEDENCE.get(
+          other.operator, -1):
+        return f'({other_str})'
+    return other_str
+
+  def ToPerfJson(self):
+    return (f'{self.Bracket(self.lhs, self.lhs.ToPerfJson())} {self.operator} '
+            f'{self.Bracket(self.rhs, self.rhs.ToPerfJson(), True)}')
+
+  def ToPython(self):
+    return (f'{self.Bracket(self.lhs, self.lhs.ToPython())} {self.operator} '
+            f'{self.Bracket(self.rhs, self.rhs.ToPython(), True)}')
+
+  def Simplify(self) -> Expression:
+    lhs = self.lhs.Simplify()
+    rhs = self.rhs.Simplify()
+    if isinstance(lhs, Constant) and isinstance(rhs, Constant):
+      return Constant(ast.literal_eval(lhs + self.operator + rhs))
+
+    if isinstance(self.lhs, Constant):
+      if self.operator in ('+', '|') and lhs.value == '0':
+        return rhs
+
+      # Simplify multiplication by 0 except for the slot event which
+      # is deliberately introduced using this pattern.
+      if self.operator == '*' and lhs.value == '0' and (
+          not isinstance(rhs, Event) or 'slots' not in rhs.name.lower()):
+        return Constant(0)
+
+      if self.operator == '*' and lhs.value == '1':
+        return rhs
+
+    if isinstance(rhs, Constant):
+      if self.operator in ('+', '|') and rhs.value == '0':
+        return lhs
+
+      if self.operator == '*' and rhs.value == '0':
+        return Constant(0)
+
+      if self.operator == '*' and self.rhs.value == '1':
+        return lhs
+
+    return Operator(self.operator, lhs, rhs)
+
+  def Equals(self, other: Expression) -> bool:
+    if isinstance(other, Operator):
+      return self.operator == other.operator and self.lhs.Equals(
+          other.lhs) and self.rhs.Equals(other.rhs)
+    return False
+
+
+class Select(Expression):
+  """Represents a select ternary in the parse tree."""
+
+  def __init__(self, true_val: Union[int, float, Expression],
+               cond: Union[int, float, Expression],
+               false_val: Union[int, float, Expression]):
+    self.true_val = _Constify(true_val)
+    self.cond = _Constify(cond)
+    self.false_val = _Constify(false_val)
+
+  def ToPerfJson(self):
+    true_str = self.true_val.ToPerfJson()
+    cond_str = self.cond.ToPerfJson()
+    false_str = self.false_val.ToPerfJson()
+    return f'({true_str} if {cond_str} else {false_str})'
+
+  def ToPython(self):
+    return (f'Select({self.true_val.ToPython()}, {self.cond.ToPython()}, '
+            f'{self.false_val.ToPython()})')
+
+  def Simplify(self) -> Expression:
+    cond = self.cond.Simplify()
+    true_val = self.true_val.Simplify()
+    false_val = self.false_val.Simplify()
+    if isinstance(cond, Constant):
+      return false_val if cond.value == '0' else true_val
+
+    if true_val.Equals(false_val):
+      return true_val
+
+    return Select(true_val, cond, false_val)
+
+  def Equals(self, other: Expression) -> bool:
+    if isinstance(other, Select):
+      return self.cond.Equals(other.cond) and self.false_val.Equals(
+          other.false_val) and self.true_val.Equals(other.true_val)
+    return False
+
+
+class Function(Expression):
+  """A function in an expression like min, max, d_ratio."""
+
+  def __init__(self,
+               fn: str,
+               lhs: Union[int, float, Expression],
+               rhs: Optional[Union[int, float, Expression]] = None):
+    self.fn = fn
+    self.lhs = _Constify(lhs)
+    self.rhs = _Constify(rhs)
+
+  def ToPerfJson(self):
+    if self.rhs:
+      return f'{self.fn}({self.lhs.ToPerfJson()}, {self.rhs.ToPerfJson()})'
+    return f'{self.fn}({self.lhs.ToPerfJson()})'
+
+  def ToPython(self):
+    if self.rhs:
+      return f'{self.fn}({self.lhs.ToPython()}, {self.rhs.ToPython()})'
+    return f'{self.fn}({self.lhs.ToPython()})'
+
+  def Simplify(self) -> Expression:
+    lhs = self.lhs.Simplify()
+    rhs = self.rhs.Simplify() if self.rhs else None
+    if isinstance(lhs, Constant) and isinstance(rhs, Constant):
+      if self.fn == 'd_ratio':
+        if rhs.value == '0':
+          return Constant(0)
+        Constant(ast.literal_eval(f'{lhs} / {rhs}'))
+      return Constant(ast.literal_eval(f'{self.fn}({lhs}, {rhs})'))
+
+    return Function(self.fn, lhs, rhs)
+
+  def Equals(self, other: Expression) -> bool:
+    if isinstance(other, Function):
+      return self.fn == other.fn and self.lhs.Equals(
+          other.lhs) and self.rhs.Equals(other.rhs)
+    return False
+
+
+def _FixEscapes(s: str) -> str:
+  s = re.sub(r'([^\\]),', r'\1\\,', s)
+  return re.sub(r'([^\\])=', r'\1\\=', s)
+
+
+class Event(Expression):
+  """An event in an expression."""
+
+  def __init__(self, name: str, legacy_name: str = ''):
+    self.name = _FixEscapes(name)
+    self.legacy_name = _FixEscapes(legacy_name)
+
+  def ToPerfJson(self):
+    result = re.sub('/', '@', self.name)
+    return result
+
+  def ToPython(self):
+    return f'Event(r"{self.name}")'
+
+  def Simplify(self) -> Expression:
+    return self
+
+  def Equals(self, other: Expression) -> bool:
+    return isinstance(other, Event) and self.name == other.name
+
+
+class Constant(Expression):
+  """A constant within the expression tree."""
+
+  def __init__(self, value: Union[float, str]):
+    ctx = decimal.Context()
+    ctx.prec = 20
+    dec = ctx.create_decimal(repr(value) if isinstance(value, float) else value)
+    self.value = dec.normalize().to_eng_string()
+    self.value = self.value.replace('+', '')
+    self.value = self.value.replace('E', 'e')
+
+  def ToPerfJson(self):
+    return self.value
+
+  def ToPython(self):
+    return f'Constant({self.value})'
+
+  def Simplify(self) -> Expression:
+    return self
+
+  def Equals(self, other: Expression) -> bool:
+    return isinstance(other, Constant) and self.value == other.value
+
+
+class Literal(Expression):
+  """A runtime literal within the expression tree."""
+
+  def __init__(self, value: str):
+    self.value = value
+
+  def ToPerfJson(self):
+    return self.value
+
+  def ToPython(self):
+    return f'Literal({self.value})'
+
+  def Simplify(self) -> Expression:
+    return self
+
+  def Equals(self, other: Expression) -> bool:
+    return isinstance(other, Literal) and self.value == other.value
+
+
+def min(lhs: Union[int, float, Expression], rhs: Union[int, float,
+                                                       Expression]) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('min', lhs, rhs)
+
+
+def max(lhs: Union[int, float, Expression], rhs: Union[int, float,
+                                                       Expression]) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('max', lhs, rhs)
+
+
+def d_ratio(lhs: Union[int, float, Expression],
+            rhs: Union[int, float, Expression]) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('d_ratio', lhs, rhs)
+
+
+def source_count(event: Event) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('source_count', event)
+
+
+class Metric:
+  """An individual metric that will specifiable on the perf command line."""
+  groups: Set[str]
+  expr: Expression
+  scale_unit: str
+  constraint: bool
+
+  def __init__(self,
+               name: str,
+               description: str,
+               expr: Expression,
+               scale_unit: str,
+               constraint: bool = False):
+    self.name = name
+    self.description = description
+    self.expr = expr.Simplify()
+    # Workraound valid_only_metric hiding certain metrics based on unit.
+    scale_unit = scale_unit.replace('/sec', ' per sec')
+    if scale_unit[0].isdigit():
+      self.scale_unit = scale_unit
+    else:
+      self.scale_unit = f'1{scale_unit}'
+    self.constraint = constraint
+    self.groups = set()
+
+  def __lt__(self, other):
+    """Sort order."""
+    return self.name < other.name
+
+  def AddToMetricGroup(self, group):
+    """Callback used when being added to a MetricGroup."""
+    self.groups.add(group.name)
+
+  def Flatten(self) -> Set['Metric']:
+    """Return a leaf metric."""
+    return set([self])
+
+  def ToPerfJson(self) -> Dict[str, str]:
+    """Return as dictionary for Json generation."""
+    result = {
+        'MetricName': self.name,
+        'MetricGroup': ';'.join(sorted(self.groups)),
+        'BriefDescription': self.description,
+        'MetricExpr': self.expr.ToPerfJson(),
+        'ScaleUnit': self.scale_unit
+    }
+    if self.constraint:
+      result['MetricConstraint'] = 'NO_NMI_WATCHDOG'
+
+    return result
+
+
+class _MetricJsonEncoder(json.JSONEncoder):
+  """Special handling for Metric objects."""
+
+  def default(self, o):
+    if isinstance(o, Metric):
+      return o.ToPerfJson()
+    return json.JSONEncoder.default(self, o)
+
+
+class MetricGroup:
+  """A group of metrics.
+
+  Metric groups may be specificd on the perf command line, but within
+  the json they aren't encoded. Metrics may be in multiple groups
+  which can facilitate arrangements similar to trees.
+  """
+
+  def __init__(self, name: str, metric_list: List[Union[Metric,
+                                                        'MetricGroup']]):
+    self.name = name
+    self.metric_list = metric_list
+    for metric in metric_list:
+      metric.AddToMetricGroup(self)
+
+  def AddToMetricGroup(self, group):
+    """Callback used when a MetricGroup is added into another."""
+    for metric in self.metric_list:
+      metric.AddToMetricGroup(group)
+
+  def Flatten(self) -> Set[Metric]:
+    """Returns a set of all leaf metrics."""
+    result = set()
+    for x in self.metric_list:
+      result = result.union(x.Flatten())
+
+    return result
+
+  def ToPerfJson(self) -> str:
+    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+
+  def __str__(self) -> str:
+    return self.ToPerfJson()
+
+
+class _RewriteIfExpToSelect(ast.NodeTransformer):
+
+  def visit_IfExp(self, node):
+    # pylint: disable=invalid-name
+    call = ast.Call(
+        func=ast.Name(id='Select', ctx=ast.Load()),
+        args=[node.body, node.test, node.orelse],
+        keywords=[])
+    ast.copy_location(call, node.test)
+    return call
+
+
+def ParsePerfJson(orig: str) -> Expression:
+  """A simple json metric expression decoder.
+
+  Converts a json encoded metric expression by way of python's ast and
+  eval routine. First tokens are mapped to Event calls, then
+  accidentally converted keywords or literals are mapped to their
+  appropriate calls. Python's ast is used to match if-else that can't
+  be handled via operator overloading. Finally the ast is evaluated.
+
+  Args:
+    orig (str): String to parse.
+
+  Returns:
+    Expression: The parsed string.
+  """
+  # pylint: disable=eval-used
+  py = orig.strip()
+  py = re.sub(r'([a-zA-Z][^-+/\* \\\(\),]*(?:\\.[^-+/\* \\\(\),]*)*)',
+              r'Event(r"\1")', py)
+  py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
+  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
+  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count']
+  for kw in keywords:
+    py = re.sub(rf'Event\(r"{kw}"\)', kw, py)
+
+  parsed = ast.parse(py, mode='eval')
+  _RewriteIfExpToSelect().visit(parsed)
+  parsed = ast.fix_missing_locations(parsed)
+  return _Constify(eval(compile(parsed, orig, 'eval')))
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
new file mode 100644
index 000000000000..4741b7b6612d
--- /dev/null
+++ b/tools/perf/pmu-events/metric_test.py
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+import unittest
+from metric import Constant
+from metric import Event
+from metric import ParsePerfJson
+
+
+class TestMetricExpressions(unittest.TestCase):
+
+  def test_Operators(self):
+    a = Event('a')
+    b = Event('b')
+    self.assertEqual((a | b).ToPerfJson(), 'a | b')
+    self.assertEqual((a ^ b).ToPerfJson(), 'a ^ b')
+    self.assertEqual((a & b).ToPerfJson(), 'a & b')
+    self.assertEqual((a < b).ToPerfJson(), 'a < b')
+    self.assertEqual((a > b).ToPerfJson(), 'a > b')
+    self.assertEqual((a + b).ToPerfJson(), 'a + b')
+    self.assertEqual((a - b).ToPerfJson(), 'a - b')
+    self.assertEqual((a * b).ToPerfJson(), 'a * b')
+    self.assertEqual((a / b).ToPerfJson(), 'a / b')
+    self.assertEqual((a % b).ToPerfJson(), 'a % b')
+    one = Constant(1)
+    self.assertEqual((a + one).ToPerfJson(), 'a + 1')
+
+  def test_Brackets(self):
+    a = Event('a')
+    b = Event('b')
+    c = Event('c')
+    self.assertEqual((a * b + c).ToPerfJson(), 'a * b + c')
+    self.assertEqual((a + b * c).ToPerfJson(), 'a + b * c')
+    self.assertEqual(((a + a) + a).ToPerfJson(), 'a + a + a')
+    self.assertEqual(((a + b) * c).ToPerfJson(), '(a + b) * c')
+    self.assertEqual((a + (b * c)).ToPerfJson(), 'a + b * c')
+    self.assertEqual(((a / b) * c).ToPerfJson(), 'a / b * c')
+    self.assertEqual((a / (b * c)).ToPerfJson(), 'a / (b * c)')
+
+  def test_ParsePerfJson(self):
+    # Based on an example of a real metric.
+    before = '(a + b + c + d) / (2 * e)'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
+    # Parsing should handle events with '-' in their name. Note, in
+    # the json file the '\' are doubled to '\\'.
+    before = r'topdown\-fe\-bound / topdown\-slots - 1'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
+    # Parsing should handle escaped modifiers. Note, in the json file
+    # the '\' are doubled to '\\'.
+    before = r'arb@event\=0x81\,umask\=0x1@ + arb@event\=0x84\,umask\=0x1@'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
+    # Parsing should handle exponents in numbers.
+    before = r'a + 1e12 + b'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
+  def test_IfElseTests(self):
+    # if-else needs rewriting to Select and back.
+    before = r'Event1 if #smt_on else Event2'
+    after = f'({before})'
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
+    before = r'Event1 if 0 else Event2'
+    after = f'({before})'
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
+    before = r'Event1 if 1 else Event2'
+    after = f'({before})'
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
+    # Ensure the select is evaluate last.
+    before = r'Event1 + 1 if Event2 < 2 else Event3 + 3'
+    after = (r'Select(Event(r"Event1") + Constant(1), Event(r"Event2") < '
+             r'Constant(2), Event(r"Event3") + Constant(3))')
+    self.assertEqual(ParsePerfJson(before).ToPython(), after)
+
+    before = r'Event1 > 1 if Event2 < 2 else Event3 > 3'
+    after = (r'Select(Event(r"Event1") > Constant(1), Event(r"Event2") < '
+             r'Constant(2), Event(r"Event3") > Constant(3))')
+    self.assertEqual(ParsePerfJson(before).ToPython(), after)
+
+    before = r'min(a + b if c > 1 else c + d, e + f)'
+    after = r'min((a + b if c > 1 else c + d), e + f)'
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
+  def test_ToPython(self):
+    # pylint: disable=eval-used
+    # Based on an example of a real metric.
+    before = '(a + b + c + d) / (2 * e)'
+    py = ParsePerfJson(before).ToPython()
+    after = eval(py).ToPerfJson()
+    self.assertEqual(before, after)
+
+  def test_Simplify(self):
+    before = '1 + 2 + 3'
+    after = '6'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = 'a + 0'
+    after = 'a'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = '0 + a'
+    after = 'a'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = 'a | 0'
+    after = 'a'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = '0 | a'
+    after = 'a'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = 'a * 0'
+    after = '0'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = '0 * a'
+    after = '0'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = 'a * 1'
+    after = 'a'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = '1 * a'
+    after = 'a'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = 'a if 0 else b'
+    after = 'b'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = 'a if 1 else b'
+    after = 'a'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    before = 'a if b else a'
+    after = 'a'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+    # Pattern used to add a slots event to metrics that require it.
+    before = '0 * SLOTS'
+    after = '0 * SLOTS'
+    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
+
+if __name__ == '__main__':
+  unittest.main()
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

