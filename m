Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B53C731A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbjFONys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344612AbjFONyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:54:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AFB1FD4;
        Thu, 15 Jun 2023 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837280; x=1718373280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15U0WIiyyq0rvPLxNQh5XmogtqMkEiklw2OKMcRnMoU=;
  b=E5qf6IOfdIO0fdDCbB5lGlf57oEcOCQq0TZMwZj8HdtpcqEePYLnLjwY
   5c/4dat+Em07tmRg+dh7SciFyqPNHDC0GlpokP5N1nAC1YXO24nP4/n2N
   opzdVTsAVdrjI7x5eTQ0Ki5vwlax27Wh65Uh69cenXEoc5nhvYsmO3Wto
   b/yOQdJIi5aWqJ94u5QYPl7XDJVOzt0oKm8sMCBmaUzIcx17vuvgA+0b4
   BJXc48ArTKJPbifVlm9YjlTZ3EvBb4Mfna8OnIu4A5xJKeJnXkjohd7eH
   EhVxRbPx39K2A+634RHdzwmkH8NDDfh9LNnGrTPZKW5rPbsd8gVKSf8Nw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356411398"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356411398"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782527053"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="782527053"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 06:54:38 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 3/8] perf stat,jevents: Introduce Default tags for the default mode
Date:   Thu, 15 Jun 2023 06:53:10 -0700
Message-Id: <20230615135315.3662428-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230615135315.3662428-1-kan.liang@linux.intel.com>
References: <20230615135315.3662428-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Introduce a new metricgroup, Default, to tag all the metric groups which
will be collected in the default mode.

Add a new field, DefaultMetricgroupName, in the JSON file to indicate
the real metric group name. It will be printed in the default output
to replace the event names.

There is nothing changed for the output format.

On SPR, both TopdownL1 and TopdownL2 are displayed in the default
output.

On ARM, Intel ICL and later platforms (before SPR), only TopdownL1 is
displayed in the default output.

Suggested-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c          | 4 ++--
 tools/perf/pmu-events/jevents.py   | 5 +++--
 tools/perf/pmu-events/pmu-events.h | 1 +
 tools/perf/util/metricgroup.c      | 6 ++++++
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fc615bdeed4f..55601b4b5c34 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2154,14 +2154,14 @@ static int add_default_attributes(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		if (metricgroup__has_metric(pmu, "TopdownL1")) {
+		if (metricgroup__has_metric(pmu, "Default")) {
 			struct evlist *metric_evlist = evlist__new();
 			struct evsel *metric_evsel;
 
 			if (!metric_evlist)
 				return -1;
 
-			if (metricgroup__parse_groups(metric_evlist, pmu, "TopdownL1",
+			if (metricgroup__parse_groups(metric_evlist, pmu, "Default",
 							/*metric_no_group=*/false,
 							/*metric_no_merge=*/false,
 							/*metric_no_threshold=*/true,
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 7ed258be1829..12e80bb7939b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -54,8 +54,8 @@ _json_event_attributes = [
 # Attributes that are in pmu_metric rather than pmu_event.
 _json_metric_attributes = [
     'pmu', 'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
-    'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group', 'aggr_mode',
-    'event_grouping'
+    'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group',
+    'default_metricgroup_name', 'aggr_mode', 'event_grouping'
 ]
 # Attributes that are bools or enum int values, encoded as '0', '1',...
 _json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg']
@@ -307,6 +307,7 @@ class JsonEvent:
     self.metric_name = jd.get('MetricName')
     self.metric_group = jd.get('MetricGroup')
     self.metricgroup_no_group = jd.get('MetricgroupNoGroup')
+    self.default_metricgroup_name = jd.get('DefaultMetricgroupName')
     self.event_grouping = convert_metric_constraint(jd.get('MetricConstraint'))
     self.metric_expr = None
     if 'MetricExpr' in jd:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 8cd23d656a5d..caf59f23cd64 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -61,6 +61,7 @@ struct pmu_metric {
 	const char *desc;
 	const char *long_desc;
 	const char *metricgroup_no_group;
+	const char *default_metricgroup_name;
 	enum aggr_mode_class aggr_mode;
 	enum metric_event_groups event_grouping;
 };
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 74f2d8efc02d..8b19644ade7d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -137,6 +137,11 @@ struct metric {
 	 * output.
 	 */
 	const char *metric_unit;
+	/**
+	 * Optional name of the metric group reported
+	 * if the Default metric group is being processed.
+	 */
+	const char *default_metricgroup_name;
 	/** Optional null terminated array of referenced metrics. */
 	struct metric_ref *metric_refs;
 	/**
@@ -219,6 +224,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 
 	m->pmu = pm->pmu ?: "cpu";
 	m->metric_name = pm->metric_name;
+	m->default_metricgroup_name = pm->default_metricgroup_name;
 	m->modifier = NULL;
 	if (modifier) {
 		m->modifier = strdup(modifier);
-- 
2.35.1

