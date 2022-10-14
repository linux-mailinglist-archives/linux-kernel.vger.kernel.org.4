Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75395FE8CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJNGRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJNGQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA3613640B;
        Thu, 13 Oct 2022 23:16:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k9so3427730pll.11;
        Thu, 13 Oct 2022 23:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CinZ7zSYX9gn5zCAZvlRZM2c/7GGvF7Lz78MJtI/ScY=;
        b=MZnIP39HgO5U44cLy2QBsPw1/tXRBIdzuog0HVJ/taZsjhJSrPg0nsRmWYP3WCca3W
         HhE5xba6s0A3QBrQZeIdIC01qJCt+jDhOaAGv2fNJY76wYOBSHo7RGm3gNwlWhNVuKSg
         SQTxJlqpE+zKi2dS4onZq31YZhFWC8kDLkJvWzfzw+ed/nrRsVztjGNQQG5c+x7YX6tR
         81L2oH9gB9iXIN/Cbj7fj1Kmel8WWiBcgM3g/SOsDLSPGcdiQVGNYjMFkrdgvSHWGBui
         2zWbURDmxI401V+uqKh2MkknkLmeQUTqE13jeBDMNkh5VhCnWnVm34TGMPiLHKKcuM2f
         Y8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CinZ7zSYX9gn5zCAZvlRZM2c/7GGvF7Lz78MJtI/ScY=;
        b=ru4UZAt5rw6+URaKS/WX8g+mzrrtHreRCZFbtVQQQhrNH8yT2ILwL76WVJ1TK0el5h
         adHGgT7hZaFb013Zcf20HBQTFM3ZneX/Wavn3ImFIXAWpMK9lbbIYxbav6mAH6zwODOg
         iYRhcfhddT43G9RHsMfNxO2rMPYIxGqoY5O+zO+/oYWcmlq7dL9m1ZvGqOdJ0qURuMtM
         tn4zxlR7UvDnlmD3f0uiHvCjD1PNdNLW5OzuzCQPhoVGDsQ7kdPwm0mWy17DSn5sxHv7
         RsPgWobICwHb4G4SwNSNeUdAWogF16QtRTH33mMDRZRqu8CLAYVQB/uM/Y723aScpXlI
         T1Wg==
X-Gm-Message-State: ACrzQf3cDkJBdW8w4MzHYZfpJNNJSEFETZarsTkOhsagmkFDKK0NhD6f
        wavzlZgXOVpCpp/bYMgaEEI=
X-Google-Smtp-Source: AMsMyM4TmZeXRrOCajE7zRcGZUh+tGnYxRrOhTIC9Tbj8EnXRxRy1NCAHjZugIMJDQaIOiQwzEV2kQ==
X-Received: by 2002:a17:90b:3901:b0:20b:210d:d5d9 with SMTP id ob1-20020a17090b390100b0020b210dd5d9mr3843661pjb.83.1665728175341;
        Thu, 13 Oct 2022 23:16:15 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 14/19] perf stat: Add perf_stat_merge_counters()
Date:   Thu, 13 Oct 2022 23:15:45 -0700
Message-Id: <20221014061550.463644-15-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_stat_merge_counters() is to aggregate the same events in different
PMUs like in case of uncore or hybrid.  The same logic is in the stat-display
routines but I think it should be handled when it processes the event counters.

As it works on the aggr_counters, it doesn't change the output yet.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  2 +
 tools/perf/util/stat.c    | 96 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  2 +
 3 files changed, 100 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 838d29590bed..371d6e896942 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -486,6 +486,8 @@ static void process_counters(void)
 			pr_warning("failed to process counter %s\n", counter->name);
 		counter->err = 0;
 	}
+
+	perf_stat_merge_counters(&stat_config, evsel_list);
 }
 
 static void process_interval(void)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 847481cc3d5a..877107f5a820 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -577,6 +577,102 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	return 0;
 }
 
+static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
+{
+	struct perf_stat_evsel *ps_a = evsel->stats;
+	struct perf_stat_evsel *ps_b = alias->stats;
+	int i;
+
+	if (ps_a->aggr == NULL && ps_b->aggr == NULL)
+		return 0;
+
+	if (ps_a->nr_aggr != ps_b->nr_aggr) {
+		pr_err("Unmatched aggregation mode between aliases\n");
+		return -1;
+	}
+
+	for (i = 0; i < ps_a->nr_aggr; i++) {
+		struct perf_counts_values *aggr_counts_a = &ps_a->aggr[i].counts;
+		struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
+
+		/* NB: don't increase aggr.nr for aliases */
+
+		aggr_counts_a->val += aggr_counts_b->val;
+		aggr_counts_a->ena += aggr_counts_b->ena;
+		aggr_counts_a->run += aggr_counts_b->run;
+	}
+
+	return 0;
+}
+/* events should have the same name, scale, unit, cgroup but on different PMUs */
+static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
+{
+	if (strcmp(evsel__name(evsel_a), evsel__name(evsel_b)))
+		return false;
+
+	if (evsel_a->scale != evsel_b->scale)
+		return false;
+
+	if (evsel_a->cgrp != evsel_b->cgrp)
+		return false;
+
+	if (strcmp(evsel_a->unit, evsel_b->unit))
+		return false;
+
+	if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
+		return false;
+
+	return !!strcmp(evsel_a->pmu_name, evsel_b->pmu_name);
+}
+
+static void evsel__merge_aliases(struct evsel *evsel)
+{
+	struct evlist *evlist = evsel->evlist;
+	struct evsel *alias;
+
+	alias = list_prepare_entry(evsel, &(evlist->core.entries), core.node);
+	list_for_each_entry_continue(alias, &evlist->core.entries, core.node) {
+		/* Merge the same events on different PMUs. */
+		if (evsel__is_alias(evsel, alias)) {
+			evsel__merge_aggr_counters(evsel, alias);
+			alias->merged_stat = true;
+		}
+	}
+}
+
+static bool evsel__should_merge_hybrid(struct evsel *evsel, struct perf_stat_config *config)
+{
+	struct perf_pmu *pmu;
+
+	if (!config->hybrid_merge)
+		return false;
+
+	pmu = evsel__find_pmu(evsel);
+	return pmu && pmu->is_hybrid;
+}
+
+static void evsel__merge_stats(struct evsel *evsel, struct perf_stat_config *config)
+{
+	/* this evsel is already merged */
+	if (evsel->merged_stat)
+		return;
+
+	if (evsel->auto_merge_stats || evsel__should_merge_hybrid(evsel, config))
+		evsel__merge_aliases(evsel);
+}
+
+/* merge the same uncore and hybrid events if requested */
+void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	if (config->no_merge)
+		return;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__merge_stats(evsel, config);
+}
+
 int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event)
 {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 809f9f0aff0c..728bbc823b0d 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -280,6 +280,8 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
+void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
+
 struct perf_tool;
 union perf_event;
 struct perf_session;
-- 
2.38.0.413.g74048e4d9e-goog

