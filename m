Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A07A73723A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFTRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjFTRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:00:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA501729;
        Tue, 20 Jun 2023 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687280437; x=1718816437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lx6VvDMUnfTWmZ+SOzq2AS5ZcPMg85xEXw9RWTbNa68=;
  b=nkI+akmsZeCCvR3r7lgK6t2TxqVMmh35ywL9zTJS7uRAaq2MrpQYaL13
   MqIgAhxdc/7MAElZTGGph1MsBSwbmakdkZbB4ouFg0LhZZNVHYizd0N0X
   ftaSYPE1NZY9RCKkrx2IHWV20o9n+J97wgd19VeC7y+T6MpJ6fZnvuQWq
   RP513vG4IxdhH7IHoPASHeDrsA2SEwFUpvrMKOGnPxwiqwS3ep0+XO3/d
   7XFbsG1YNZuE17ptbRJt5FwQ2bOz/DWxIj9XX8lQT1RERzwWGecVLG24N
   jsWDUydVtzinKCk+Uac8Qpo6qMatWokfPy99Qqe/+dC5Vg8San3uRu0EN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="359929653"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="359929653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888314370"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="888314370"
Received: from a0cec87da3f2.jf.intel.com (HELO worker-node-1.jf.intel.com) ([10.165.55.163])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2023 10:00:35 -0700
From:   Weilin Wang <weilin.wang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>, ravi.bangoria@amd.com
Subject: [PATCH v5 3/3] perf test: Rerun failed metrics with longer workload
Date:   Tue, 20 Jun 2023 10:00:27 -0700
Message-Id: <20230620170027.1861012-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620170027.1861012-1-weilin.wang@intel.com>
References: <20230620170027.1861012-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rerun failed metrics with longer workload to avoid false failure because
sometimes metric value test fails when running in very short amount of
time. Skip rerun if equal to or more than 20 metrics fail.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 .../tests/shell/lib/perf_metric_validation.py | 129 +++++++++++-------
 1 file changed, 83 insertions(+), 46 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools/perf/tests/shell/lib/perf_metric_validation.py
index 3c3a9b4f8b82..50a34a9cc040 100644
--- a/tools/perf/tests/shell/lib/perf_metric_validation.py
+++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
@@ -11,8 +11,9 @@ class Validator:
         self.rulefname = rulefname
         self.reportfname = reportfname
         self.rules = None
-        self.collectlist=metrics
-        self.metrics = set(metrics)
+        self.collectlist:str = metrics
+        self.metrics = self.__set_metrics(metrics)
+        self.skiplist = set()
         self.tolerance = t
 
         self.workloads = [x for x in workload.split(",") if x]
@@ -41,6 +42,12 @@ class Validator:
         self.debug = debug
         self.fullrulefname = fullrulefname
 
+    def __set_metrics(self, metrics=''):
+        if metrics != '':
+            return set(metrics.split(","))
+        else:
+            return set()
+
     def read_json(self, filename: str) -> dict:
         try:
             with open(Path(filename).resolve(), "r") as f:
@@ -113,7 +120,7 @@ class Validator:
         All future test(s) on this metric will fail.
 
         @param name: name of the metric
-        @returns: list with value found in self.results; list is empty when not value found.
+        @returns: list with value found in self.results; list is empty when value is not found.
         """
         results = []
         data = self.results[ridx] if ridx in self.results else self.results[0]
@@ -123,7 +130,6 @@ class Validator:
             elif name.replace('.', '1').isdigit():
                 results.append(float(name))
             else:
-                self.errlist.append("Metric '%s' is not collected or the value format is incorrect"%(name))
                 self.ignoremetrics.add(name)
         return results
 
@@ -138,27 +144,32 @@ class Validator:
         Failure: when metric value is negative or not provided.
         Metrics with negative value will be added into the self.failtests['PositiveValueTest'] and self.ignoremetrics.
         """
-        negmetric = set()
-        missmetric = set()
+        negmetric = dict()
         pcnt = 0
         tcnt = 0
+        rerun = list()
         for name, val in self.get_results().items():
-            if val is None or val == '':
-                missmetric.add(name)
-                self.errlist.append("Metric '%s' is not collected"%(name))
-            elif val < 0:
-                negmetric.add("{0}(={1:.4f})".format(name, val))
-                self.collectlist[0].append(name)
+            if val < 0:
+                negmetric[name] = val
+                rerun.append(name)
             else:
                 pcnt += 1
             tcnt += 1
+        if len(rerun) > 0 and len(rerun) < 20:
+            second_results = dict()
+            self.second_test(rerun, second_results)
+            for name, val in second_results.items():
+                if name not in negmetric: continue
+                if val >= 0:
+                    del negmetric[name]
+                    pcnt += 1
 
         self.failtests['PositiveValueTest']['Total Tests'] = tcnt
         self.failtests['PositiveValueTest']['Passed Tests'] = pcnt
-        if len(negmetric) or len(missmetric)> 0:
-            self.ignoremetrics.update(negmetric)
-            self.ignoremetrics.update(missmetric)
-            self.failtests['PositiveValueTest']['Failed Tests'].append({'NegativeValue':list(negmetric), 'MissingValue':list(missmetric)})
+        if len(negmetric.keys()):
+            self.ignoremetrics.update(negmetric.keys())
+            negmessage = ["{0}(={1:.4f})".format(name, val) for name, val in negmetric.items()]
+            self.failtests['PositiveValueTest']['Failed Tests'].append({'NegativeValue': negmessage})
 
         return
 
@@ -259,21 +270,36 @@ class Validator:
         metrics = rule['Metrics']
         passcnt = 0
         totalcnt = 0
-        faillist = []
+        faillist = list()
+        failures = dict()
+        rerun = list()
         for m in metrics:
             totalcnt += 1
             result = self.get_value(m['Name'])
-            if len(result) > 0 and self.check_bound(result[0], lbv, ubv, t):
+            if len(result) > 0 and self.check_bound(result[0], lbv, ubv, t) or m['Name'] in self.skiplist:
                 passcnt += 1
             else:
-                faillist.append({'MetricName':m['Name'], 'CollectedValue':result})
-                self.collectlist[0].append(m['Name'])
+                failures[m['Name']] = result
+                rerun.append(m['Name'])
+
+        if len(rerun) > 0 and len(rerun) < 20:
+            second_results = dict()
+            self.second_test(rerun, second_results)
+            for name, val in second_results.items():
+                if name not in failures: continue
+                if self.check_bound(val, lbv, ubv, t):
+                    passcnt += 1
+                    del failures[name]
+                else:
+                    failures[name] = val
+                    self.results[0][name] = val
 
         self.totalcnt += totalcnt
         self.passedcnt += passcnt
         self.failtests['SingleMetricTest']['Total Tests'] += totalcnt
         self.failtests['SingleMetricTest']['Passed Tests'] += passcnt
-        if len(faillist) != 0:
+        if len(failures.keys()) != 0:
+            faillist = [{'MetricName':name, 'CollectedValue':val} for name, val in failures.items()]
             self.failtests['SingleMetricTest']['Failed Tests'].append({'RuleIndex':rule['RuleIndex'],
                                                                        'RangeLower': rule['RangeLower'],
                                                                        'RangeUpper': rule['RangeUpper'],
@@ -316,7 +342,7 @@ class Validator:
         return True
 
     # Start of Collector and Converter
-    def convert(self, data: list, idx: int):
+    def convert(self, data: list, metricvalues:dict):
         """
         Convert collected metric data from the -j output to dict of {metric_name:value}.
         """
@@ -326,20 +352,29 @@ class Validator:
                 if "metric-unit" in result and result["metric-unit"] != "(null)" and result["metric-unit"] != "":
                     name = result["metric-unit"].split("  ")[1] if len(result["metric-unit"].split("  ")) > 1 \
                         else result["metric-unit"]
-                    if idx not in self.results: self.results[idx] = dict()
-                    self.results[idx][name.lower()] = float(result["metric-value"])
+                    metricvalues[name.lower()] = float(result["metric-value"])
             except ValueError as error:
                 continue
         return
 
-    def collect_perf(self, data_file: str, workload: str):
+    def _run_perf(self, metric, workload: str):
+        tool = 'perf'
+        command = [tool, 'stat', '-j', '-M', f"{metric}", "-a"]
+        wl = workload.split()
+        command.extend(wl)
+        print(" ".join(command))
+        cmd = subprocess.run(command, stderr=subprocess.PIPE, encoding='utf-8')
+        data = [x+'}' for x in cmd.stderr.split('}\n') if x]
+        return data
+
+
+    def collect_perf(self, workload: str):
         """
         Collect metric data with "perf stat -M" on given workload with -a and -j.
         """
         self.results = dict()
-        tool = 'perf'
         print(f"Starting perf collection")
-        print(f"Workload: {workload}")
+        print(f"Long workload: {workload}")
         collectlist = dict()
         if self.collectlist != "":
             collectlist[0] = {x for x in self.collectlist.split(",")}
@@ -353,17 +388,20 @@ class Validator:
                     collectlist[rule["RuleIndex"]] = [",".join(list(set(metrics)))]
 
         for idx, metrics in collectlist.items():
-            if idx == 0: wl = "sleep 0.5".split()
-            else: wl = workload.split()
+            if idx == 0: wl = "true"
+            else: wl = workload
             for metric in metrics:
-                command = [tool, 'stat', '-j', '-M', f"{metric}", "-a"]
-                command.extend(wl)
-                print(" ".join(command))
-                cmd = subprocess.run(command, stderr=subprocess.PIPE, encoding='utf-8')
-                data = [x+'}' for x in cmd.stderr.split('}\n') if x]
-                self.convert(data, idx)
-        self.collectlist = dict()
-        self.collectlist[0] = list()
+                data = self._run_perf(metric, wl)
+                if idx not in self.results: self.results[idx] = dict()
+                self.convert(data, self.results[idx])
+        return
+
+    def second_test(self, collectlist, second_results):
+        workload = self.workloads[self.wlidx]
+        for metric in collectlist:
+            data = self._run_perf(metric, workload)
+            self.convert(data, second_results)
+
     # End of Collector and Converter
 
     # Start of Rule Generator
@@ -381,7 +419,7 @@ class Validator:
                 if 'MetricName' not in m:
                     print("Warning: no metric name")
                     continue
-                name = m['MetricName']
+                name = m['MetricName'].lower()
                 self.metrics.add(name)
                 if 'ScaleUnit' in m and (m['ScaleUnit'] == '1%' or m['ScaleUnit'] == '100%'):
                     self.pctgmetrics.add(name.lower())
@@ -391,14 +429,12 @@ class Validator:
 
         return
 
-    def remove_unsupported_rules(self, rules, skiplist: set = None):
-        for m in skiplist:
-            self.metrics.discard(m)
+    def remove_unsupported_rules(self, rules):
         new_rules = []
         for rule in rules:
             add_rule = True
             for m in rule["Metrics"]:
-                if m["Name"] not in self.metrics:
+                if m["Name"] in self.skiplist or m["Name"] not in self.metrics:
                     add_rule = False
                     break
             if add_rule:
@@ -415,15 +451,15 @@ class Validator:
         """
         data = self.read_json(self.rulefname)
         rules = data['RelationshipRules']
-        skiplist = set(data['SkipList'])
-        self.rules = self.remove_unsupported_rules(rules, skiplist)
+        self.skiplist = set([name.lower() for name in data['SkipList']])
+        self.rules = self.remove_unsupported_rules(rules)
         pctgrule = {'RuleIndex':0,
                     'TestType':'SingleMetricTest',
                     'RangeLower':'0',
                     'RangeUpper': '100',
                     'ErrorThreshold': self.tolerance,
                     'Description':'Metrics in percent unit have value with in [0, 100]',
-                    'Metrics': [{'Name': m} for m in self.pctgmetrics]}
+                    'Metrics': [{'Name': m.lower()} for m in self.pctgmetrics]}
         self.rules.append(pctgrule)
 
         # Re-index all rules to avoid repeated RuleIndex
@@ -479,8 +515,9 @@ class Validator:
             self.parse_perf_metrics()
         self.create_rules()
         for i in range(0, len(self.workloads)):
+            self.wlidx = i
             self._init_data()
-            self.collect_perf(self.datafname, self.workloads[i])
+            self.collect_perf(self.workloads[i])
             # Run positive value test
             self.pos_val_test()
             for r in self.rules:
-- 
2.39.1

