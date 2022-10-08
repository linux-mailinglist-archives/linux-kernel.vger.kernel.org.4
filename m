Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D35F8116
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 01:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJGXUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 19:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJGXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:19:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4473C1D303
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:19:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3606e54636aso15224887b3.16
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yTVUGcd5K3xDwAQq486SYITnu8K77nx5kyYPP7G9G9A=;
        b=pRPVaHHI5F1mCKyxwfur/dyTTNlKBr1vSyWSiBQiDvLDqyDF/79JYUbDnPIe6G3NOB
         inynR3CNcuKiiHESyGSP1PtNODjTeLZEdP+oiicL4fwyurYyF7CBnwtJNQ8EoNhP8OzZ
         9YdKCqG8S0NIn/u1vTtd+WLRiVPvhuXbSMgqjOs0G42iSjbBz7VeEXn5zXo5YhFNQz39
         geGOtbjia84wqJ34hXiuvhfkhdb44kKr56bEOxOHjzktmXI1ziuX/u7FYKl27NJlQuWH
         lUXEvV+f3TIXOkxocMT4XJZqGC0bW7m/f87WQkArQQJhaRIdzAC8gI9OQbPBCubJKIre
         A/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTVUGcd5K3xDwAQq486SYITnu8K77nx5kyYPP7G9G9A=;
        b=0i1ZCMaoE7vYB6RPJIKxmYrN8B27U5CGTqU/tV3V9eSAO8tOl42HZlfstfY7jEyFmH
         pdcFCDVYi+rbii+8LYQxPNJT5HRUDOzV/vMrPBzF/btG2yMrE4EsrPwhqfPgYXX3ELBW
         JfDWSHDdZljqGenBQBie3vzq6n3FyKDtADmM1LBa/oRKznWBlGWOw/hU2D5O1R5CgtN3
         zv2pFYC8a6aQSKDrCyX1FTooOlFn27KcC4EiVWI3Yx8NVSPEpXB/qNT3WpQy3ngDjvsd
         c770NcyouYMofCIhTvqzDfnsUKZp7qfb/OLtz2L00XV52RAcPd9LSp+f93QL4cMwwTbO
         PlaQ==
X-Gm-Message-State: ACrzQf2le1Rq6g+r/ZYLoXTjhAfgk5cmB5KFbbYuRzQm2WQsbFAPq1do
        oPNBIhGztHrn/Yxzx/hw8C+C/CJwYeM8
X-Google-Smtp-Source: AMsMyM515vNd1SDesP70+4dbMvYDD7dzMrtbP9wowVOGJWbahvcNn2MYu5xhve0ORnfx+VJAklGGCrXZs/FV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9b0c:e906:194f:244b])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c9:b0:6af:2099:f0c with SMTP id
 w9-20020a05690210c900b006af20990f0cmr7330475ybu.317.1665184792442; Fri, 07
 Oct 2022 16:19:52 -0700 (PDT)
Date:   Fri,  7 Oct 2022 16:19:46 -0700
Message-Id: <20221007231946.1711967-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH] perf jevents: Parse metrics during conversion
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

2) The conversion to a string from the tree can minimize the
   metric's string size, for example, preferring 1e6 over 1000000
   and removing unnecessary whitespace. On x86 this reduces the
   string size by 2,823bytes (0.06%).

In future changes it would be possible to programmatically
generate the json expressions (a single line of text and so a
pain to write manually) for an architecture using the expression
tree. This could avoid copy-pasting metrics for all architecture
variants.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build          |   2 +-
 tools/perf/pmu-events/jevents.py     |  11 +-
 tools/perf/pmu-events/metric.py      | 459 +++++++++++++++++++++++++++
 tools/perf/pmu-events/metric_test.py | 143 +++++++++
 4 files changed, 611 insertions(+), 4 deletions(-)
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
index 0daa3e007528..81bcbd15c962 100755
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
@@ -268,9 +269,9 @@ class JsonEvent:
     self.metric_name = jd.get('MetricName')
     self.metric_group = jd.get('MetricGroup')
     self.metric_constraint = jd.get('MetricConstraint')
-    self.metric_expr = jd.get('MetricExpr')
-    if self.metric_expr:
-      self.metric_expr = self.metric_expr.replace('\\', '\\\\')
+    self.metric_expr = None
+    if 'MetricExpr' in jd:
+       self.metric_expr = metric.ParsePerfJson(jd.get('MetricExpr'))
     arch_std = jd.get('ArchStdEvent')
     if precise and self.desc and '(Precise Event)' not in self.desc:
       extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
@@ -322,6 +323,10 @@ class JsonEvent:
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
index 000000000000..14e0752cb119
--- /dev/null
+++ b/tools/perf/pmu-events/metric.py
@@ -0,0 +1,459 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+"""Parse or generate representations of perf metrics."""
+import ast
+import decimal
+import re
+import json
+from typing import (Optional, Set, TypeVar, Union)
+
+ExprVal = TypeVar('ExprVal', int, float, 'Expression')
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
+  def __or__(self, other: ExprVal) -> 'Operator':
+    return Operator('|', self, other)
+
+  def __ror__(self, other: ExprVal) -> 'Operator':
+    return Operator('|', other, self)
+
+  def __xor__(self, other: ExprVal) -> 'Operator':
+    return Operator('^', self, other)
+
+  def __and__(self, other: ExprVal) -> 'Operator':
+    return Operator('&', self, other)
+
+  def __lt__(self, other: ExprVal) -> 'Operator':
+    return Operator('<', self, other)
+
+  def __gt__(self, other: ExprVal) -> 'Operator':
+    return Operator('>', self, other)
+
+  def __add__(self, other: ExprVal) -> 'Operator':
+    return Operator('+', self, other)
+
+  def __radd__(self, other: ExprVal) -> 'Operator':
+    return Operator('+', other, self)
+
+  def __sub__(self, other: ExprVal) -> 'Operator':
+    return Operator('-', self, other)
+
+  def __rsub__(self, other: ExprVal) -> 'Operator':
+    return Operator('-', other, self)
+
+  def __mul__(self, other: ExprVal) -> 'Operator':
+    return Operator('*', self, other)
+
+  def __rmul__(self, other: ExprVal) -> 'Operator':
+    return Operator('*', other, self)
+
+  def __truediv__(self, other: ExprVal) -> 'Operator':
+    return Operator('/', self, other)
+
+  def __rtruediv__(self, other: ExprVal) -> 'Operator':
+    return Operator('/', other, self)
+
+  def __mod__(self, other: ExprVal) -> 'Operator':
+    return Operator('%', self, other)
+
+
+def _Constify(val: ExprVal) -> Expression:
+  """Used to ensure that the nodes in the expression tree are all Expression."""
+  if isinstance(val, bool):
+    return Constant(1 if val else 0)
+  if isinstance(val, int) or isinstance(val, float):
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
+  def __init__(self, operator: str, lhs: ExprVal, rhs: ExprVal):
+    self.operator = operator
+    self.lhs = _Constify(lhs)
+    self.rhs = _Constify(rhs)
+
+  def Bracket(self,
+              other: Expression,
+              other_str: str,
+              rhs: bool = False) -> str:
+    """Returns whether to bracket ``other``
+
+    ``other`` is the lhs or rhs, ``other_str`` is ``other`` in the
+    appropriate string from. If ``other`` is an operator then a
+    bracket is necessary when this/self operator has higher
+    precedence. Consider: '(a + b) * c', ``other_str`` will be 'a +
+    b'. A bracket is necessary as without the bracket 'a + b * c' will
+    evaluate 'b * c' first. However, '(a * b) + c' doesn't need a
+    bracket as 'a * b' will always be evaluated first. For 'a / (b *
+    c)' (ie the same precedence level operations) then we add the
+    bracket to best match the original input, but not for '(a / b) *
+    c' where the bracket is unnecessary.
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
+    return f'{self.Bracket(self.lhs, self.lhs.ToPerfJson())} {self.operator} ' \
+      f'{self.Bracket(self.rhs, self.rhs.ToPerfJson(), True)}'
+
+  def ToPython(self):
+    return f'{self.Bracket(self.lhs, self.lhs.ToPython())} {self.operator} ' \
+      f'{self.Bracket(self.rhs, self.rhs.ToPython(), True)}'
+
+  def Simplify(self) -> Expression:
+    lhs = self.lhs.Simplify()
+    rhs = self.rhs.Simplify()
+    if isinstance(lhs, Constant) and isinstance(rhs, Constant):
+      return Constant(eval(lhs + self.operator + rhs))
+
+    if isinstance(self.lhs, Constant):
+      if (self.operator == '+' or self.operator == '|') and lhs.value == '0':
+        return rhs
+
+      if self.operator == '*' and lhs.value == '0':
+        return Constant(0)
+
+      if self.operator == '*' and lhs.value == '1':
+        return rhs
+
+    if isinstance(rhs, Constant):
+      if (self.operator == '+' or self.operator == '|') and rhs.value == '0':
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
+class Select(Expression):
+  """Represents a select ternary in the parse tree."""
+
+  def __init__(self, true_val: ExprVal, cond, false_val):
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
+    return f'Select({self.true_val.ToPython()}, {self.cond.ToPython()}, ' \
+      f'{self.false_val.ToPython()})'
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
+class Function(Expression):
+  """A function in an expression like min, max, d_ratio."""
+
+  def __init__(self, fn: str, lhs: ExprVal, rhs: Optional[ExprVal] = None):
+    self.fn = fn
+    self.lhs = _Constify(lhs)
+    self.rhs = _Constify(rhs)
+
+  def ToPerfJson(self):
+    if self.rhs:
+      return f'{self.fn}({self.lhs.ToPerfJson()}, {self.rhs.ToPerfJson()})'
+    else:
+      return f'{self.fn}({self.lhs.ToPerfJson()})'
+
+  def ToPython(self):
+    if self.rhs:
+      return f'{self.fn}({self.lhs.ToPython()}, {self.rhs.ToPython()})'
+    else:
+      return f'{self.fn}({self.lhs.ToPython()})'
+
+  def Simplify(self) -> Expression:
+    lhs = self.lhs.Simplify()
+    rhs = self.rhs.Simplify()
+    if isinstance(lhs, Constant) and isinstance(rhs, Constant):
+      if self.fn == 'd_ratio':
+        if rhs.value == '0':
+          return Constant(0)
+        Constant(eval(f'{lhs} / {rhs}'))
+      return Constant(eval(f'{self.fn}({lhs}, {rhs})'))
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
+class Event(Expression):
+  """An event in an expression."""
+
+  def __init__(self, name: str, legacy_name: str = ''):
+    self.name = name
+    self.legacy_name = legacy_name
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
+def min(lhs, rhs) -> Function:
+  return Function('min', lhs, rhs)
+
+
+def max(lhs, rhs) -> Function:
+  return Function('max', lhs, rhs)
+
+
+def d_ratio(lhs, rhs) -> Function:
+  return Function('d_ratio', lhs, rhs)
+
+
+def source_count(event: Event) -> Function:
+  return Function('source_count', event)
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
+  def Flatten(self) -> set:
+    """Return a leaf metric."""
+    return set([self])
+
+  def ToPerfJson(self):
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
+  def default(self, obj):
+    if isinstance(obj, Metric):
+      return obj.ToPerfJson()
+    return json.JSONEncoder.default(self, obj)
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
+  def __init__(self, name: str, metric_list: list[Union[Metric,
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
+  def Flatten(self) -> set:
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
+  """
+  py = orig.strip()
+  py = re.sub(r'([a-zA-Z][^-+/\* \\\(\),]*(?:\\.[^-+/\* \\\(\),]*)*)',
+              r'Event(r"\1")', py)
+  py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
+  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
+  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count']
+  for kw in keywords:
+    py = re.sub(f'Event\(r"{kw}"\)', kw, py)
+
+  parsed = ast.parse(py, mode='eval')
+  _RewriteIfExpToSelect().visit(parsed)
+  parsed = ast.fix_missing_locations(parsed)
+  return _Constify(eval(compile(parsed, orig, 'eval')))
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
new file mode 100644
index 000000000000..3909ca773ca1
--- /dev/null
+++ b/tools/perf/pmu-events/metric_test.py
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+import unittest
+from metric import Constant, Event, ParsePerfJson
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
+    before = 'arb@event\=0x81\,umask\=0x1@ + arb@event\=0x84\,umask\=0x1@'
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
+if __name__ == '__main__':
+  unittest.main()
-- 
2.38.0.rc1.362.ged0d419d3c-goog

