Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148866B160F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCHXB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCHXBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:01:14 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F6D49FD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:00:45 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c6ce8d74so700167b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316443;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5MPo35xGT8I5no97e54JFoAV8IlgxfgBAbMEiQkE8U=;
        b=tGLBbmk6mEkyaPVhJkZRCYWA6iEy5ckHJhLPb7F8UqErknxUOA5qOz8VB2+BvRY4bN
         LDlVBlhI3wLjbVj3S+97kTVLarHFG7Lrd22PX3efIySxkJhUBeTHuy8uevzWBho3PT0g
         eGNFgG1G6cmd1vYXW2/tD2t/sXAnNbDrkNLVJtt2uCBDB9OnrkEiPxvGq3Hb/QRaIa6Q
         K9KToen8jFhaLhboI8Xddizefkh6aAtWbiw2O2763qDEgl95SYASXcSYvZqEfQNkDTbq
         ZwhhKNaoxsVZFPjJBaBUuCvBWdkt3EV5KLrFrfpOyhojPs9DO3VIJbqp5OSiObZ375yN
         bFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316443;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5MPo35xGT8I5no97e54JFoAV8IlgxfgBAbMEiQkE8U=;
        b=klMTcq5fq7lkc6tvgXmbmRZzuLyjyoClWc1s0ruXIIjICXKmHfFUgXmhyn1fKMo29p
         9HQDrwDBLyrblVKhytnXAH6US/lVUgjgHs/TM1ltfHn8wmSVk22UjJ69SiuJDRLGk/Px
         AcBtmz5MDeohRUugHjaAVKDxy8mgeYcO5KKyMKhEunRHi3Xu71i/GFEarHIWL0w8qhCe
         hvjDwxOz4jrlfXRSOgOEuwAq87j6a1Fo1xHe4XUjHtF+7Bzp0ubWWOa95TyaAOpa0hJD
         J0b8CoU8TZEhjc2PR6QU8Lv5N1G7phY11rf6tgCtzpuNUhozQYY9sJO3Hja7pAdQGpJm
         agNw==
X-Gm-Message-State: AO0yUKVIdPYAYl8mWTrinB8tDpIpuGpqpxbYLitCElQSfFlorjLgaFPL
        bEtp93NEWeZKm7Out5DVqclo50Kh86vX
X-Google-Smtp-Source: AK7set8cHVeu2tes5PIhkpiZB9G05ecICAh5BhC4MNN5AarP7q9+ndGq4yJkt8Mpa6MaAqQxOO4a2GMkfC2g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a5b:e92:0:b0:ab8:1ed9:cfc9 with SMTP id
 z18-20020a5b0e92000000b00ab81ed9cfc9mr11861623ybr.6.1678316443692; Wed, 08
 Mar 2023 15:00:43 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:12 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-12-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 11/11] perf parse-events: Warn when events are regrouped
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Use if an event is reordered or the number of groups increases to
signal that regrouping has happened and warn about it. Disable the
warning in the case wild card PMU names are used and for metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c |  2 +-
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/metricgroup.c   |  3 ++-
 tools/perf/util/parse-events.c  | 28 ++++++++++++++++++++--------
 tools/perf/util/parse-events.h  |  7 ++++---
 tools/perf/util/parse-events.y  |  1 +
 6 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index ffa6f0a90741..b1c2f0a20306 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2103,7 +2103,7 @@ static int test_event_fake_pmu(const char *str)
 
 	parse_events_error__init(&err);
 	perf_pmu__test_parse_init();
-	ret = __parse_events(evlist, str, &err, &perf_pmu__fake);
+	ret = __parse_events(evlist, str, &err, &perf_pmu__fake, /*warn_if_reordered=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 str, ret, err.str);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 6ccd413b5983..7f8e86452527 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -785,7 +785,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 		 */
 		perf_pmu__test_parse_init();
 	}
-	ret = __parse_events(evlist, dup, error, fake_pmu);
+	ret = __parse_events(evlist, dup, error, fake_pmu, /*warn_if_reordered=*/true);
 	free(dup);
 
 	evlist__delete(evlist);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index de6dd527a2ba..5783f4c2d1ef 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1441,7 +1441,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	}
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
-	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
+	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu,
+			     /*warn_if_reordered=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9ec3c1dc81e0..4bb28c32b511 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2157,11 +2157,13 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 	return arch_evlist__cmp(lhs, rhs);
 }
 
-static void parse_events__sort_events_and_fix_groups(struct list_head *list)
+static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 {
 	int idx = -1;
 	struct evsel *pos, *cur_leader = NULL;
 	struct perf_evsel *cur_leaders_grp = NULL;
+	bool idx_changed = false;
+	int orig_num_leaders = 0, num_leaders = 0;
 
 	/*
 	 * Compute index to insert ungrouped events at. Place them where the
@@ -2170,11 +2172,11 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
 
-		if (pos != pos_leader || pos->core.nr_members > 1)
-			continue;
+		if (pos == pos_leader)
+			orig_num_leaders++;
 
-		idx = pos->core.idx;
-		break;
+		if (idx == -1 && pos == pos_leader && pos->core.nr_members < 2)
+			idx = pos->core.idx;
 	}
 
 	/* Sort events. */
@@ -2192,6 +2194,8 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
 		bool force_grouped = arch_evsel__must_be_in_group(pos);
 
 		/* Reset index and nr_members. */
+		if (pos->core.idx != idx)
+			idx_changed = true;
 		pos->core.idx = idx++;
 		pos->core.nr_members = 0;
 
@@ -2225,12 +2229,18 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
 		}
 	}
 	list_for_each_entry(pos, list, core.node) {
-		pos->core.leader->nr_members++;
+		struct evsel *pos_leader = evsel__leader(pos);
+
+		if (pos == pos_leader)
+			num_leaders++;
+		pos_leader->core.nr_members++;
 	}
+	return idx_changed || num_leaders != orig_num_leaders;
 }
 
 int __parse_events(struct evlist *evlist, const char *str,
-		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
+		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
+		   bool warn_if_reordered)
 {
 	struct parse_events_state parse_state = {
 		.list	  = LIST_HEAD_INIT(parse_state.list),
@@ -2250,7 +2260,9 @@ int __parse_events(struct evlist *evlist, const char *str,
 		return -1;
 	}
 
-	parse_events__sort_events_and_fix_groups(&parse_state.list);
+	if (parse_events__sort_events_and_fix_groups(&parse_state.list) &&
+	    warn_if_reordered && !parse_state.wild_card_pmus)
+		pr_warning("WARNING: events were regrouped to match PMUs\n");
 
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 767ad1729228..46204c1a7916 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -26,13 +26,13 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 __attribute__((nonnull(1, 2, 3)))
 int __parse_events(struct evlist *evlist, const char *str, struct parse_events_error *error,
-		   struct perf_pmu *fake_pmu);
+		   struct perf_pmu *fake_pmu, bool warn_if_reordered);
 
-__attribute__((nonnull))
+__attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
-	return __parse_events(evlist, str, err, NULL);
+	return __parse_events(evlist, str, err, /*fake_pmu=*/NULL, /*warn_if_reordered=*/true);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -128,6 +128,7 @@ struct parse_events_state {
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
 	char			  *hybrid_pmu_name;
+	bool			   wild_card_pmus;
 };
 
 void parse_events__shrink_config_terms(void);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 3a04602d2982..4488443e506e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -323,6 +323,7 @@ event_pmu_name opt_pmu_config
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms,
 							  /*auto_merge_stats=*/true)) {
 					ok++;
+					parse_state->wild_card_pmus = true;
 				}
 				parse_events_terms__delete(terms);
 			}
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

