Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92269BF77
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBSJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBSJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:30:37 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3EC1207F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53686d8ce27so20518817b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuS1q84R0xcAiENu72F9xaB/dldCNXgOZrtbWFpv52E=;
        b=cI8dh0bWWKZeW1y5k5GPM8AzvnkbIA5dJQUUoDzOXJvWxVyShYBYx60369eQUy4OzL
         E6SVtCAQM+IaKz1bV0Rn3Uuqp+jyypxxArizXArFcTzgMndVSzmzut43pU+fIivj5gSC
         XKTj5fMpGYRtuDMkea81itweVHTeFMS37/+yA2iSPh75iDbyZ+kgaX2m5UodziZr1WHu
         sKBH5KHPK9zik8QbzJ6V3vRrwymvXNniazfNki04nQD+n1XXTKZW1LPzmzv18NmS4/2T
         4FkiuO6YzbUl/HqF+S/0btFco6XOhO2Bs0WDcFHWpQ5VE+9asDN4xuYeYZaRTGDc6yIO
         VGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuS1q84R0xcAiENu72F9xaB/dldCNXgOZrtbWFpv52E=;
        b=u8q07jSD/7KZrJgC/nzMHUEVKwihYCZHeJo97FXilnoLuAduI1fVB8hdBDIMjj82go
         jiMrx+PqNFKBiUisKUaRvcqmujq8rbMDwW4dlNem+eHw4WDFTGZkLhkYMNDmjT3t+DKb
         ZS2h7k0mc1Cokx0E0Twis2Fpjy13zeLECKVYNsdKeGMRaByVadjr/f186pfL2fJPB9O2
         Lp/7TLZ7Ny3EqNestCtvZrJT2ttxsFCQji9DPIQyK+iqben/YmgysFiXjmmTWCbZbqyy
         AAAF8m9ZLOKZVCSRDLY90t0gA7tV6hDaGY+PSwtqUDVTmfbNIq7hsFNVRdb10EEVnvvA
         OGww==
X-Gm-Message-State: AO0yUKXVfXURObbT0XdN52dbkQ+hujW3qF4fmJClonvcy4QFkBgr/CST
        /GmnGqEjs3yfmeogeXDMuzLAQU0EoCiT
X-Google-Smtp-Source: AK7set93SE5NbWPGLqx8+0V5OQ1Zd7PwyZiB6jBWIqTaGMZiQIyzx9cn7NuqKPF1uean13HLVminRfyvDmVj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a0d:dc85:0:b0:530:a183:aa0 with SMTP id
 f127-20020a0ddc85000000b00530a1830aa0mr1619527ywe.384.1676799008532; Sun, 19
 Feb 2023 01:30:08 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:05 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-9-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 08/51] perf pmu-events: Make the metric_constraint an enum
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
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

Rename metric_constraint to event_grouping to better explain what the
variable is used for. Switch to use an enum for encoding instead of a
string. Rather than just no constraint/grouping information or
"NO_NMI_WATCHDOG", have 4 enum values. The values encode whether to
group or not, and two cases where the behavior is dependent on either
the NMI watchdog being enabled or SMT being enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   | 20 ++++++++++++++++----
 tools/perf/pmu-events/pmu-events.h | 25 ++++++++++++++++++++++++-
 tools/perf/util/metricgroup.c      | 19 ++++++++++++-------
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2da55408398f..dc0c56dccb5e 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -51,8 +51,8 @@ _json_event_attributes = [
 
 # Attributes that are in pmu_metric rather than pmu_event.
 _json_metric_attributes = [
-    'metric_name', 'metric_group', 'metric_constraint', 'metric_expr', 'desc',
-    'long_desc', 'unit', 'compat', 'aggr_mode'
+    'metric_name', 'metric_group', 'metric_expr', 'desc',
+    'long_desc', 'unit', 'compat', 'aggr_mode', 'event_grouping'
 ]
 
 def removesuffix(s: str, suffix: str) -> str:
@@ -204,6 +204,18 @@ class JsonEvent:
       }
       return aggr_mode_to_enum[aggr_mode]
 
+    def convert_metric_constraint(metric_constraint: str) -> Optional[str]:
+      """Returns the metric_event_groups enum value associated with the JSON string."""
+      if not metric_constraint:
+        return None
+      metric_constraint_to_enum = {
+          'NO_GROUP_EVENTS': '1',
+          'NO_GROUP_EVENTS_NMI': '2',
+          'NO_NMI_WATCHDOG': '2',
+          'NO_GROUP_EVENTS_SMT': '3',
+      }
+      return metric_constraint_to_enum[metric_constraint]
+
     def lookup_msr(num: str) -> Optional[str]:
       """Converts the msr number, or first in a list to the appropriate event field."""
       if not num:
@@ -288,7 +300,7 @@ class JsonEvent:
     self.deprecated = jd.get('Deprecated')
     self.metric_name = jd.get('MetricName')
     self.metric_group = jd.get('MetricGroup')
-    self.metric_constraint = jd.get('MetricConstraint')
+    self.event_grouping = convert_metric_constraint(jd.get('MetricConstraint'))
     self.metric_expr = None
     if 'MetricExpr' in jd:
       self.metric_expr = metric.ParsePerfJson(jd['MetricExpr']).Simplify()
@@ -678,7 +690,7 @@ static void decompress_event(int offset, struct pmu_event *pe)
 {
 \tconst char *p = &big_c_string[offset];
 """)
-  enum_attributes = ['aggr_mode', 'deprecated', 'perpkg']
+  enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg']
   for attr in _json_event_attributes:
     _args.output_file.write(f'\n\tpe->{attr} = ')
     if attr in enum_attributes:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 4d236bb32fd3..57a38e3e5c32 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -11,6 +11,29 @@ enum aggr_mode_class {
 	PerCore
 };
 
+/**
+ * enum metric_event_groups - How events within a pmu_metric should be grouped.
+ */
+enum metric_event_groups {
+	/**
+	 * @MetricGroupEvents: Default, group events within the metric.
+	 */
+	MetricGroupEvents = 0,
+	/**
+	 * @MetricNoGroupEvents: Don't group events for the metric.
+	 */
+	MetricNoGroupEvents = 1,
+	/**
+	 * @MetricNoGroupEventsNmi: Don't group events for the metric if the NMI
+	 *                          watchdog is enabled.
+	 */
+	MetricNoGroupEventsNmi = 2,
+	/**
+	 * @MetricNoGroupEventsSmt: Don't group events for the metric if SMT is
+	 *                          enabled.
+	 */
+	MetricNoGroupEventsSmt = 3,
+};
 /*
  * Describe each PMU event. Each CPU has a table of PMU events.
  */
@@ -33,10 +56,10 @@ struct pmu_metric {
 	const char *metric_expr;
 	const char *unit;
 	const char *compat;
-	const char *metric_constraint;
 	const char *desc;
 	const char *long_desc;
 	enum aggr_mode_class aggr_mode;
+	enum metric_event_groups event_grouping;
 };
 
 struct pmu_events_table;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b2aa6e049804..868fc9c35606 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -13,6 +13,7 @@
 #include "pmu.h"
 #include "pmu-hybrid.h"
 #include "print-events.h"
+#include "smt.h"
 #include "expr.h"
 #include "rblist.h"
 #include <string.h>
@@ -168,16 +169,20 @@ static void metric__watchdog_constraint_hint(const char *name, bool foot)
 
 static bool metric__group_events(const struct pmu_metric *pm)
 {
-	if (!pm->metric_constraint)
-		return true;
-
-	if (!strcmp(pm->metric_constraint, "NO_NMI_WATCHDOG") &&
-	    sysctl__nmi_watchdog_enabled()) {
+	switch (pm->event_grouping) {
+	case MetricNoGroupEvents:
+		return false;
+	case MetricNoGroupEventsNmi:
+		if (!sysctl__nmi_watchdog_enabled())
+			return true;
 		metric__watchdog_constraint_hint(pm->metric_name, /*foot=*/false);
 		return false;
+	case MetricNoGroupEventsSmt:
+		return !smt_on();
+	case MetricGroupEvents:
+	default:
+		return true;
 	}
-
-	return true;
 }
 
 static void metric__free(struct metric *m)
-- 
2.39.2.637.g21b0678d19-goog

