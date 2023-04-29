Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1AA6F233F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347516AbjD2Fmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347581AbjD2Fmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:42:32 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D24EEA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:42:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24b27b7f627so325529a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746872; x=1685338872;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9J7avGu03QLF3OzvxpAd+rFmIiyVUKJL1J9REWiEeQ0=;
        b=4qawOTBzZo1K3PPRYRluewynoQ6DIkHYHASLfg17/KuSCz3CqO3LFBBm4WK2dmYjBU
         pO/Hs9GkvST+LJUt4jFyGT6exvmq8os8LQyGEefnsVT2F7sGfskdsfK2+7vmAT7nNzZm
         0IpuEQdSG0k+vC5tBOardKqMIYOWKypr+IA2KX1u29d+AFWCzgRsxdB8CkAxPNDkrwmj
         meSK6ju+J1f5v9OJm8fA3rpSt6UVxX1De4cdrAkpZU/gY4uEvTXfZAx7kF844qf/0RSu
         F+CcLWHQWSTLMYDiTotnnkfc8Fg7qx1WQ+D0AF/qRka6mmp5q6QW9ZF21wYu9VylgLjx
         vk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746872; x=1685338872;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9J7avGu03QLF3OzvxpAd+rFmIiyVUKJL1J9REWiEeQ0=;
        b=gm27cQCW3fG4rO24CiJa6X58vkDYY3Shg/c1tMtq7BTuva0Un4vfhoM6h3oNKX73jO
         8dnlBVRx0drZUaqShNvFfmmthrHTbZ/Osvj2UoFjV3OYTZ+CdIPStvW6z0K2+nJFzkE/
         +cjBTDlW9VwvgjBInfCb9ecIU7Fj0BhqxMo0vh3cNx/3aYRKLTL7rMyhMp4n3bamu2Fm
         ZdgwSv+g1SketwuF1l+y5g9oJhSgfznAi0SoEAI0Yal6ft5EaiQn0SPCs1vkkbvwURjk
         ZGTy3CP9lmH2Jmov0zJyBjpHi9VQc81M3IO4BUv5imKNdNW40GEVaM3gQ3q+6XRM8FpZ
         gsyw==
X-Gm-Message-State: AC+VfDw9JpTVZ0HkgONqN2OsGVultBwki+tMHSuH9F2NX5apcCGMxSqE
        nkUmvNK/55ET2aakJzecLXhiP1kzCqCm
X-Google-Smtp-Source: ACHHUZ6I9g/30b44THk55dFQmZiPjelKatWE+shwe8u4M+h2PkLilzM0tM8/Juy80xm4ntHgPvLdgW9ZCDj8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a17:902:d512:b0:1a9:8769:36a5 with SMTP id
 b18-20020a170902d51200b001a9876936a5mr2441973plg.2.1682746872266; Fri, 28 Apr
 2023 22:41:12 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:35:01 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-42-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 41/46] perf stat: Command line PMU metric filtering
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

