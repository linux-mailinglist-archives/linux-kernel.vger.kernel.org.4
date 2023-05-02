Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4C6F4D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjEBWpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjEBWpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:45:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623883AA5
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:45:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559fb850e08so59971647b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067432; x=1685659432;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9J7avGu03QLF3OzvxpAd+rFmIiyVUKJL1J9REWiEeQ0=;
        b=08tXE7YwmZ5Zzxd9BAlqC1LukNL7m13wC3KLBDxKxpCYXC+ZnMUVOchpY1ZAPh9p6K
         WhE99u+/MKrl5F6qjjb0iBX28XHoqBeJ+OlAO2+Q29LM86c57fQ2CtTkVYDpcgnC8g9+
         gCxV2AHiueRuM46ZiOg2xmsAa6UGcS14PLlTCkb/jC2NbtRz6xRjs0gqycFOa3kEQ+UA
         rHzRd/gGi+NnpCNHoGuiiG0LhRvcMutvaWkS2OAbvnnxcSriqOIIYERou9o3TbDwAIej
         081rjgH+Try4yw8K0teDlhNplvRrBBVSd2Y0hPS2X67xIqPRTu/CwhCDlM+sQOE0QxrI
         6Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067432; x=1685659432;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9J7avGu03QLF3OzvxpAd+rFmIiyVUKJL1J9REWiEeQ0=;
        b=AaQqstVkHyW2foB4mnZwJtg3J2bAsyR2GyNilso0ldT+9I0lKShVHDZDGrzH1v6QB8
         3+w75B/l44CsY8q9O/JVJGOt0uA6GrTKZCAkoqx4bGfx4R+YRN3ghwsbBkA+Rkjmyr9n
         Lg42NRjA8nYSMPl2guvmpnLfwEYf0ItQoMXcLv++xfTi3yalGwvAgTtXqPF53jZSuQD1
         tcmN4r58D8rG02+IbSLOUGdnjBCrcQnD4QUIJxxM0neC8e3eHP6tk47qq+tNkSVUa0xp
         RTtLap3FeQ7R6VbXcm4BSkM4GrSb7cAESo4GMLhu2L35LCn3+JFKpGh0lwfVxhAWnsMy
         jbWA==
X-Gm-Message-State: AC+VfDwDWbJpYyjOFrL4hWi+Dkv9q/pl2qZN6YCFSU68gd8igMocWin7
        n2GJJC6qx7OsfKqEDHHROC67bUTfoKUS
X-Google-Smtp-Source: ACHHUZ4QqfkYLMIGE+StYfSBmF8j9IPJCRIVeVN8WAvZ4mBnyhVVIj7f9bLqCCSJ7IF+tmsC7clNc56jJFW4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a0d:ec4c:0:b0:55a:20a3:5ce3 with SMTP id
 r12-20020a0dec4c000000b0055a20a35ce3mr5260768ywn.3.1683067431876; Tue, 02 May
 2023 15:43:51 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:46 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-40-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 39/44] perf stat: Command line PMU metric filtering
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
index bb1a4ecd7558..f4e572f9de6b 100644
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
@@ -1903,14 +1905,14 @@ static int add_default_attributes(void)
 		 * caused by exposing latent bugs. This is fixed properly in:
 		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
 		 */
-		if (metricgroup__has_metric("all", "TopdownL1") && !perf_pmu__has_hybrid()) {
+		if (metricgroup__has_metric(pmu, "TopdownL1") && !perf_pmu__has_hybrid()) {
 			struct evlist *metric_evlist = evlist__new();
 			struct evsel *metric_evsel;
 
 			if (!metric_evlist)
 				return -1;
 
-			if (metricgroup__parse_groups(metric_evlist, "TopdownL1",
+			if (metricgroup__parse_groups(metric_evlist, pmu, "TopdownL1",
 							/*metric_no_group=*/false,
 							/*metric_no_merge=*/false,
 							/*metric_no_threshold=*/true,
@@ -2434,7 +2436,9 @@ int cmd_stat(int argc, const char **argv)
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

