Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD172A029
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbjFIQ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbjFIQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:26:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC03A9D;
        Fri,  9 Jun 2023 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686328005; x=1717864005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tZpCEsgi8E9IIcohlcYbamWUJA0IlqXRIgwvdW+xRjM=;
  b=WqZXtnAET24Q33rZv40LbHz5insXwB23LW6HTOvBSc/c4WQ9sf9uPdjG
   Y4DVXDVitb0vLE23Nl9gLywy3v/zAQCZYpMPxyNQ7dWAac4hZ5+2WgX7l
   KhNdJMHNNYc4qcbpQ1JOslu9Q34ydN56+FFjYs0F+LgIQUI9j4dFGgqPP
   jPcuyc1L6JMic0cZ4tdmmaHQKoeXRtKp3SUucqJqifpjqiR31jjbhK1WX
   hV3GXdFYoTaiR96Hc+zVHsTedLK5Ack+nvvVDue6VuNMZVkAAsy3Ln2db
   B8J3Fzk7TVrSCz+LheJtBAIW6lnxqEVX+hbwuklbSasyR02VHAz2Q4GYj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355123906"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="355123906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 09:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="800269705"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="800269705"
Received: from a0cec87da3f2.jf.intel.com (HELO worker-node-1.jf.intel.com) ([10.165.55.163])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2023 09:26:43 -0700
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
        Caleb Biggers <caleb.biggers@intel.com>
Subject: [PATCH v2 2/3] perf test: Add skip list for metrics known would fail
Date:   Fri,  9 Jun 2023 09:26:24 -0700
Message-Id: <20230609162625.100897-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230609162625.100897-1-weilin.wang@intel.com>
References: <20230609162625.100897-1-weilin.wang@intel.com>
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

Add skip list for metrics known would fail because some of the metrics are
very likely to fail due to multiplexing or other errors. So add all of the
flaky tests into the skip list.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 .../tests/shell/lib/perf_metric_validation.py | 31 ++++++++++++++++---
 .../lib/perf_metric_validation_rules.json     | 11 +++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools/perf/tests/shell/lib/perf_metric_validation.py
index 7bc5b9a5f62f..e59941089350 100644
--- a/tools/perf/tests/shell/lib/perf_metric_validation.py
+++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
@@ -12,7 +12,7 @@ class Validator:
         self.reportfname = reportfname
         self.rules = None
         self.collectlist=metrics
-        self.metrics = set()
+        self.metrics = set(metrics)
         self.tolerance = t
 
         self.workloads = [x for x in workload.split(",") if x]
@@ -148,6 +148,7 @@ class Validator:
                 self.errlist.append("Metric '%s' is not collected"%(name))
             elif val < 0:
                 negmetric.add("{0}(={1:.4f})".format(name, val))
+                self.collectlist[0].append(name)
             else:
                 pcnt += 1
             tcnt += 1
@@ -266,6 +267,7 @@ class Validator:
                 passcnt += 1
             else:
                 faillist.append({'MetricName':m['Name'], 'CollectedValue':result})
+                self.collectlist[0].append(m['Name'])
 
         self.totalcnt += totalcnt
         self.passedcnt += passcnt
@@ -348,7 +350,7 @@ class Validator:
             if rule["TestType"] == "RelationshipTest":
                 metrics = [m["Name"] for m in rule["Metrics"]]
                 if not any(m not in collectlist[0] for m in metrics):
-                    collectlist[rule["RuleIndex"]] = set(metrics)
+                    collectlist[rule["RuleIndex"]] = [",".join(list(set(metrics)))]
 
         for idx, metrics in collectlist.items():
             if idx == 0: wl = "sleep 0.5".split()
@@ -356,9 +358,12 @@ class Validator:
             for metric in metrics:
                 command = [tool, 'stat', '-j', '-M', f"{metric}", "-a"]
                 command.extend(wl)
+                print(" ".join(command))
                 cmd = subprocess.run(command, stderr=subprocess.PIPE, encoding='utf-8')
                 data = [x+'}' for x in cmd.stderr.split('}\n') if x]
                 self.convert(data, idx)
+        self.collectlist = dict()
+        self.collectlist[0] = list()
     # End of Collector and Converter
 
     # Start of Rule Generator
@@ -386,6 +391,20 @@ class Validator:
 
         return
 
+    def remove_unsupported_rules(self, rules, skiplist: set = None):
+        for m in skiplist:
+            self.metrics.discard(m)
+        new_rules = []
+        for rule in rules:
+            add_rule = True
+            for m in rule["Metrics"]:
+                if m["Name"] not in self.metrics:
+                    add_rule = False
+                    break
+            if add_rule:
+                new_rules.append(rule)
+        return new_rules
+
     def create_rules(self):
         """
         Create full rules which includes:
@@ -394,7 +413,10 @@ class Validator:
 
         Reindex all the rules to avoid repeated RuleIndex
         """
-        self.rules = self.read_json(self.rulefname)['RelationshipRules']
+        data = self.read_json(self.rulefname)
+        rules = data['RelationshipRules']
+        skiplist = set(data['SkipList'])
+        self.rules = self.remove_unsupported_rules(rules, skiplist)
         pctgrule = {'RuleIndex':0,
                     'TestType':'SingleMetricTest',
                     'RangeLower':'0',
@@ -453,7 +475,8 @@ class Validator:
 
         The final report is written into a JSON file.
         '''
-        self.parse_perf_metrics()
+        if not self.collectlist:
+            self.parse_perf_metrics()
         self.create_rules()
         for i in range(0, len(self.workloads)):
             self._init_data()
diff --git a/tools/perf/tests/shell/lib/perf_metric_validation_rules.json b/tools/perf/tests/shell/lib/perf_metric_validation_rules.json
index debaa910da9f..eb6f59e018b7 100644
--- a/tools/perf/tests/shell/lib/perf_metric_validation_rules.json
+++ b/tools/perf/tests/shell/lib/perf_metric_validation_rules.json
@@ -1,4 +1,15 @@
 {
+    "SkipList": [
+        "tsx_aborted_cycles",
+        "tsx_transactional_cycles",
+        "C2_Pkg_Residency",
+        "C6_Pkg_Residency",
+        "C1_Core_Residency",
+        "C6_Core_Residency",
+        "tma_false_sharing",
+        "tma_remote_cache",
+        "tma_contested_accesses"
+    ],
     "RelationshipRules": [
         {
             "RuleIndex": 1,
-- 
2.39.1

