Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1F6020CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiJRCDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJRCDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA78D0EA;
        Mon, 17 Oct 2022 19:02:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o21so10057548ple.5;
        Mon, 17 Oct 2022 19:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45K39jThQAzcpDReWZZtA2vEDUWmLg4vPVifalEZNJI=;
        b=RRCmWXoQWPtnH+4Ky1/XpCLaYx2vBLbMMXmwSd7IPEj9WWBYYoGU6A2pE6DXXBMZ8N
         wDAloXeoQ3Bi/zhVYXtQLWjX+QWrzK52erK/EnlrfIk41h89PM6umD1ktGcvEqZ5pMXP
         bwqD4l1L/hwkQf5dNXgq13ecX0ZQ/BtZxN3+RUqoSwE+luf45Rk90kRVfRWA/BjBghwS
         UJNkIf0BvaYQ/jyv+nZHh+V+2BNsHWSQoJesE3cjQuIcNyoqMTWUfbhIMLq0NdBsQBAM
         pe8f0RThFlZQ0QjsAHiOgbeL4AUItmYUJXMT8KFwESkTNcQG2dXg32vf2EBKwdXlWF8d
         5LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45K39jThQAzcpDReWZZtA2vEDUWmLg4vPVifalEZNJI=;
        b=2YXABTwFY+sZmFyz4Kh7YEKRGS50W8SZoaPN++igXW5E7SUv7s91wgMBNoV5BQOYdL
         z793PchlmgtySfy+HboZgUTua09f2VWP+qywtdlifWQFErv8yHp/PQ1Xj1NzvXCvDrw8
         kJ2hqMkgjDyiMxnsgDiaMhBq9OYj6kimLXmw2zZYZm+WT1VtGapqQVa1vdeHR2PN/joI
         F1UOYCdMa0CaBA0aVW+k6DS3XwDZbbHK+USR42gmP/A+NJh+dKEEzybhUOACzTnu98c3
         8zpB9O2pI0yPTP1gk3lORRycIC0Ajn5Hk4GbVUvkZWL42/qes7K4iOoqoRz8cr/CGkS0
         Y/Rw==
X-Gm-Message-State: ACrzQf1enHE9MkL8yqGYEFaeKSy8dN/SQMG8jmnyNW1VkC7nLrEwU6sg
        Vb0y3sfNZhOq176HSuL0KTo=
X-Google-Smtp-Source: AMsMyM7UZjxMWgcNrQ/CrRT/LwxMyJb0WS1BTzhEJ5OwJ1XB/BH59GThb2ZzY151W39lJD8RTkcUPg==
X-Received: by 2002:a17:902:7295:b0:17d:5176:fe6e with SMTP id d21-20020a170902729500b0017d5176fe6emr578396pll.147.1666058572444;
        Mon, 17 Oct 2022 19:02:52 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:52 -0700 (PDT)
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 12/20] perf stat: Allocate aggr counts for recorded data
Date:   Mon, 17 Oct 2022 19:02:19 -0700
Message-Id: <20221018020227.85905-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
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

In the process_stat_config_event() it sets the aggr_mode that means the
earlier evlist__alloc_stats() cannot allocate the aggr counts due to the
missing aggr_mode.

Do it after setting the aggr_map using evlist__alloc_aggr_stats().

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 20 +++++++++++++++-----
 tools/perf/util/stat.c    | 39 +++++++++++++++++++++++++++++++--------
 tools/perf/util/stat.h    |  2 ++
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6777fef0d56c..2a6a5d0c5563 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1342,7 +1342,11 @@ static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __m
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 					      aggr_get_id_t get_id, struct perf_cpu cpu)
 {
-	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct aggr_cpu_id id;
+
+	/* per-process mode - should use global aggr mode */
+	if (cpu.cpu == -1)
+		return get_id(config, cpu);
 
 	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
 		config->cpus_aggr_map->map[cpu.cpu] = get_id(config, cpu);
@@ -2125,17 +2129,23 @@ int process_stat_config_event(struct perf_session *session,
 	if (perf_cpu_map__empty(st->cpus)) {
 		if (st->aggr_mode != AGGR_UNSET)
 			pr_warning("warning: processing task data, aggregation mode not set\n");
-		return 0;
-	}
-
-	if (st->aggr_mode != AGGR_UNSET)
+	} else if (st->aggr_mode != AGGR_UNSET) {
 		stat_config.aggr_mode = st->aggr_mode;
+	}
 
 	if (perf_stat.data.is_pipe)
 		perf_stat_init_aggr_mode();
 	else
 		perf_stat_init_aggr_mode_file(st);
 
+	if (stat_config.aggr_map) {
+		int nr_aggr = stat_config.aggr_map->nr;
+
+		if (evlist__alloc_aggr_stats(session->evlist, nr_aggr) < 0) {
+			pr_err("cannot allocate aggr counts\n");
+			return -1;
+		}
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5b04c9d16156..1b9048115a18 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -141,6 +141,31 @@ static void evsel__reset_stat_priv(struct evsel *evsel)
 		memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
 }
 
+static int evsel__alloc_aggr_stats(struct evsel *evsel, int nr_aggr)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+
+	if (ps == NULL)
+		return 0;
+
+	ps->nr_aggr = nr_aggr;
+	ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
+	if (ps->aggr == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__alloc_aggr_stats(evsel, nr_aggr) < 0)
+			return -1;
+	}
+	return 0;
+}
 
 static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 {
@@ -150,16 +175,14 @@ static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 	if (ps == NULL)
 		return -ENOMEM;
 
-	if (nr_aggr) {
-		ps->nr_aggr = nr_aggr;
-		ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
-		if (ps->aggr == NULL) {
-			free(ps);
-			return -ENOMEM;
-		}
+	evsel->stats = ps;
+
+	if (nr_aggr && evsel__alloc_aggr_stats(evsel, nr_aggr) < 0) {
+		evsel->stats = NULL;
+		free(ps);
+		return -ENOMEM;
 	}
 
-	evsel->stats = ps;
 	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 0980875b9be1..4c00f814bd79 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -275,6 +275,8 @@ void evlist__reset_prev_raw_counts(struct evlist *evlist);
 void evlist__copy_prev_raw_counts(struct evlist *evlist);
 void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
 
+int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
+
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 struct perf_tool;
-- 
2.38.0.413.g74048e4d9e-goog

