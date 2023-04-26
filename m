Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3926EEEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjDZHJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbjDZHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:08:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A594448C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:06:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b99f5daf7c5so3247280276.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492768; x=1685084768;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MugtftIsrKZIg7Mi0F+3pamjw73CnmJWHMI0pVlzdCA=;
        b=hRODWp0wa+TSfZsR5avIhMyjqaY12ijcuh53pzEPp84n77cEG+TzUdjJk6zkVvrV1u
         yZzCYPOCyVaaQ4a9HgZvKNzMMJM5yZ71sv1JgvvZWW1b2KUr6mlrEefteWudZHLbdzUH
         btSy8ocoPoZXM7DcBTe/9uPCchRSUzqi6VkS4Ksb6SIvVhPatj30QquG+vpMX81uDc7L
         68rLHkYele0jqn3AjKFW3zbOmtM1CCudZlNXOZcKyZHm7DUp4VOVHN0vTw8AZtiukUiD
         0m6BRFM6KuW5kNuRUCkkI48V1xPx9OL6L1WjQL7/jm/VPwBIinWR9bErxFWY3jVdzUdQ
         81Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492768; x=1685084768;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MugtftIsrKZIg7Mi0F+3pamjw73CnmJWHMI0pVlzdCA=;
        b=ZXcnP1eJg7+ttGy9UuvwhhoNnxR9IJLTd26o6fKV8TcgsMJLMWZlyhQLGBPdIGkYxn
         C+Xauc/f/eOGiJ6E/QoBp3VDjcwbxXPUvKe07USVOeeVbZcgCig5qqkIIjOmgXVtpzkz
         nQL5v4fBDMyDs7p1UfJFgb38a/QOZ+yS9+0Qrmtcz26jPojpMtDUUKydN48S6cykd/pa
         ep6X92EmAMho0VGJRmftDCqcmHFlY6ykFyu4NZoKeclmbCNDgXeoW07n5YZN6gJuzjUs
         7BWY9co7qJbqTtEA4smxYL1JZRXXo5JgT5BKC4ZCg7EuAntBlK8ie1WNHiFpptXAEdqv
         7ycA==
X-Gm-Message-State: AAQBX9dumX/Fb/RHIqTUPaq7bjcgxp80hoE7fLTIzD+Ax4yk3JeclTbK
        VchrDwYYqZcnPsf3kCaIAE+wtAU6LONT
X-Google-Smtp-Source: AKy350YJMU5f/GxAQibgEg2PZVUAhfgzJv/xZiBTCg5B4ZkBhyuqSwN+WjuGvmCmR7/svTR0SxM7oKOqoOAo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:cb0d:0:b0:b95:8a6b:da93 with SMTP id
 b13-20020a25cb0d000000b00b958a6bda93mr11322851ybg.9.1682492768346; Wed, 26
 Apr 2023 00:06:08 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:47 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-38-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 37/40] perf stat: Command line PMU metric filtering
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the --cputype value to limit which metrics are parsed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 20 ++++++++++++--------
 tools/perf/util/metricgroup.c |  3 ++-
 tools/perf/util/metricgroup.h |  1 +
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5dbdf001028b..67dc69270ae4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1783,6 +1783,7 @@ static int add_default_attributes(void)
 };
 
 	struct perf_event_attr default_null_attrs[] = {};
+	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
 
 	/* Set attrs if no event is selected and !null_run: */
 	if (stat_config.null_run)
@@ -1794,11 +1795,11 @@ static int add_default_attributes(void)
 		 * will use this approach. To determine transaction support
 		 * on an architecture test for such a metric name.
 		 */
-		if (!metricgroup__has_metric("all", "transaction")) {
+		if (!metricgroup__has_metric(pmu, "transaction")) {
 			pr_err("Missing transaction metrics");
 			return -1;
 		}
-		return metricgroup__parse_groups(evsel_list, "transaction",
+		return metricgroup__parse_groups(evsel_list, pmu, "transaction",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -1823,7 +1824,7 @@ static int add_default_attributes(void)
 			smi_reset = true;
 		}
 
-		if (!metricgroup__has_metric("all", "smi")) {
+		if (!metricgroup__has_metric(pmu, "smi")) {
 			pr_err("Missing smi metrics");
 			return -1;
 		}
@@ -1831,7 +1832,7 @@ static int add_default_attributes(void)
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		return metricgroup__parse_groups(evsel_list, "smi",
+		return metricgroup__parse_groups(evsel_list, pmu, "smi",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -1864,7 +1865,8 @@ static int add_default_attributes(void)
 				"Please print the result regularly, e.g. -I1000\n");
 		}
 		str[8] = stat_config.topdown_level + '0';
-		if (metricgroup__parse_groups(evsel_list, str,
+		if (metricgroup__parse_groups(evsel_list,
+						pmu, str,
 						/*metric_no_group=*/false,
 						/*metric_no_merge=*/false,
 						/*metric_no_threshold=*/true,
@@ -1898,14 +1900,14 @@ static int add_default_attributes(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		if (metricgroup__has_metric("all", "TopdownL1")) {
+		if (metricgroup__has_metric(pmu, "TopdownL1")) {
 			struct evlist *metric_evlist = evlist__new();
 			struct evsel *metric_evsel;
 
 			if (!metric_evlist)
 				return -1;
 
-			if (metricgroup__parse_groups(metric_evlist, "TopdownL1",
+			if (metricgroup__parse_groups(metric_evlist, pmu, "TopdownL1",
 							/*metric_no_group=*/false,
 							/*metric_no_merge=*/false,
 							/*metric_no_threshold=*/true,
@@ -2429,7 +2431,9 @@ int cmd_stat(int argc, const char **argv)
 	 * knowing the target is system-wide.
 	 */
 	if (metrics) {
-		metricgroup__parse_groups(evsel_list, metrics,
+		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
+
+		metricgroup__parse_groups(evsel_list, pmu, metrics,
 					stat_config.metric_no_group,
 					stat_config.metric_no_merge,
 					stat_config.metric_no_threshold,
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 17478eb33bdc..4245b23d8efe 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1648,6 +1648,7 @@ static int parse_groups(struct evlist *perf_evlist,
 }
 
 int metricgroup__parse_groups(struct evlist *perf_evlist,
+			      const char *pmu,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
@@ -1661,7 +1662,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 	if (!table)
 		return -EINVAL;
 
-	return parse_groups(perf_evlist, "all", str, metric_no_group, metric_no_merge,
+	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
 }
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 08e9b9e953ec..bf18274c15df 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -67,6 +67,7 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
 					 bool create);
 int metricgroup__parse_groups(struct evlist *perf_evlist,
+			      const char *pmu,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
-- 
2.40.1.495.gc816e09b53d-goog

