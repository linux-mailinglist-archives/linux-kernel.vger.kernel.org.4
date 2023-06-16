Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3117325BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbjFPDPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbjFPDPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:15:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102A2D5D;
        Thu, 15 Jun 2023 20:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686885291; x=1718421291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zoirwNfFQwkO8VigFGv+WWlEWBCZ3Ym94UWruU5bY8w=;
  b=nS7ESmATDVpKRDz/KSzZOEMNUkEaXhFWfYZ3/tHxNMTXOIzxDkq15Bkj
   OKaud5NNVJJqcrNWwf59oj1c219EqeAaEATMCMGEfFidFt2T3oleYHj9G
   czWHtI3zX3OB1O2dsYLOcWlwlhSfBJzsxnN6ka9/f4z4ljFTXkLJqA98i
   +3fDXHas26hebbHjD1HwYv+rlWSILKB4v4cH8E27LHdUbA3p3mltm/VeO
   5h0vg+EdE0qeJ7zN2UEuSy8uT5o3R2dAPitGsoPYPCTRWqrRG7wvel2Lo
   vQ9tFco7CxrVFLeAnzuloqVOZFUgngZFmsWvfw94ahNoEqlO2p++o5PVR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338718199"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="338718199"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825555598"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="825555598"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 20:14:50 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 1/5] perf metrics: Sort the Default metricgroup
Date:   Thu, 15 Jun 2023 20:14:16 -0700
Message-Id: <20230616031420.3751973-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230616031420.3751973-1-kan.liang@linux.intel.com>
References: <20230616031420.3751973-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The new default mode will print the metrics as a metric group. The
metrics from the same metric group must be adjacent to each other in the
metric list. But the metric_list_cmp() sorts metrics by the number of
events.

Add a new sort for the Default metricgroup, which sorts by
default_metricgroup_name and metric_name.

Add is_default in the struct metric_event to indicate that it's from
the Default metricgroup.

Store the displayed metricgroup name of the Default metricgroup into
the metric expr for output.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/metricgroup.c | 26 ++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8b19644ade7d..a6a5ed44a679 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -79,6 +79,7 @@ static struct rb_node *metric_event_new(struct rblist *rblist __maybe_unused,
 		return NULL;
 	memcpy(me, entry, sizeof(struct metric_event));
 	me->evsel = ((struct metric_event *)entry)->evsel;
+	me->is_default = false;
 	INIT_LIST_HEAD(&me->head);
 	return &me->nd;
 }
@@ -1160,6 +1161,25 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 	return right_count - left_count;
 }
 
+/**
+ * default_metricgroup_cmp - Implements complex key for the Default metricgroup
+ *			     that first sorts by default_metricgroup_name, then
+ *			     metric_name.
+ */
+static int default_metricgroup_cmp(void *priv __maybe_unused,
+				   const struct list_head *l,
+				   const struct list_head *r)
+{
+	const struct metric *left = container_of(l, struct metric, nd);
+	const struct metric *right = container_of(r, struct metric, nd);
+	int diff = strcmp(right->default_metricgroup_name, left->default_metricgroup_name);
+
+	if (diff)
+		return diff;
+
+	return strcmp(right->metric_name, left->metric_name);
+}
+
 struct metricgroup__add_metric_data {
 	struct list_head *list;
 	const char *pmu;
@@ -1515,6 +1535,7 @@ static int parse_groups(struct evlist *perf_evlist,
 	LIST_HEAD(metric_list);
 	struct metric *m;
 	bool tool_events[PERF_TOOL_MAX] = {false};
+	bool is_default = !strcmp(str, "Default");
 	int ret;
 
 	if (metric_events_list->nr_entries == 0)
@@ -1549,6 +1570,9 @@ static int parse_groups(struct evlist *perf_evlist,
 			goto out;
 	}
 
+	if (is_default)
+		list_sort(NULL, &metric_list, default_metricgroup_cmp);
+
 	list_for_each_entry(m, &metric_list, nd) {
 		struct metric_event *me;
 		struct evsel **metric_events;
@@ -1637,6 +1661,8 @@ static int parse_groups(struct evlist *perf_evlist,
 		expr->metric_unit = m->metric_unit;
 		expr->metric_events = metric_events;
 		expr->runtime = m->pctx->sctx.runtime;
+		expr->default_metricgroup_name = m->default_metricgroup_name;
+		me->is_default = is_default;
 		list_add(&expr->nd, &me->head);
 	}
 
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index bf18274c15df..d5325c6ec8e1 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -22,6 +22,7 @@ struct cgroup;
 struct metric_event {
 	struct rb_node nd;
 	struct evsel *evsel;
+	bool is_default; /* the metric evsel from the Default metricgroup */
 	struct list_head head; /* list of metric_expr */
 };
 
@@ -55,6 +56,8 @@ struct metric_expr {
 	 * more human intelligible) and then add "MiB" afterward when displayed.
 	 */
 	const char *metric_unit;
+	/** Displayed metricgroup name of the Default metricgroup */
+	const char *default_metricgroup_name;
 	/** Null terminated array of events used by the metric. */
 	struct evsel **metric_events;
 	/** Null terminated array of referenced metrics. */
-- 
2.35.1

