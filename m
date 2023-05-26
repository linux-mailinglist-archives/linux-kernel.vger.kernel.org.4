Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0964712DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbjEZTpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243077AbjEZTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:44:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F15BD
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:44:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso1512414276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685130288; x=1687722288;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCEuHB+EAhk+z6YgMVeylt+nnvBXz0KV/fMFiqSw75M=;
        b=00c8A4WdV3GcZZCBWyJI3N171+nLyljMSnaQpXe6v9LMUp01Hu3fn5FEAKGT4ivB1N
         P5EcKBGfI5YekKMp+h2uaJGZvCpu0i6Kwh88bNnZRTBInCk6jnIZQodHPCrq/smVsoJH
         MDFnTBJMiEb2bx5MKmw0kcUg00X+YbE8YdtiBuQxbvaCvgN7xTBMX/nBYdCqhIET3xX6
         dtgh9TYGlzpv6vBYzN4Nr/vgLC3ztLDpjjJa1tR4fZGHw8Gk6PQkoTwi1QtXC/UVMX/j
         rZBw7OgFAxMuzWFVjzvrSWJn7iKPVMf7jd5bl/1TwJJSr/oxBH9eLtuSElxitNpSyJ//
         datQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130288; x=1687722288;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCEuHB+EAhk+z6YgMVeylt+nnvBXz0KV/fMFiqSw75M=;
        b=QFPSw2x/xMSWdZMQbN7Zg9CgHC76CO/UaIGXRanKBZKnG/MKUgQLgf64FuGJZ9vegm
         xDXn9ymGzFGqelMIDI+zlnSu2tZGY1Lb4M0DSBLJDQ9G58CoKbuAE6G/a1gGJMCM7cof
         Vt3XCholK4IZzeWm+ZdIpFXOHsSZwvKlCyq+DejH88gC2UkKMwOrcaOBii3my0DDoNIC
         C5cw/8eHziXKU+2vLIw9BXE/oqNrlYYBatxrxQOpoJHkvU1UxbjBxfvRbLSL1QcX+12r
         hlLSIWO+Rw4W2xq/ngAQFxEvdxcoNt4yX8bZUV5D7iNDMUDijAI+uVPO4kZuXjv7Y33U
         3M8g==
X-Gm-Message-State: AC+VfDz8L4cS7HfPeDJzyzNh4K0+0sGsxSXnTWqjG8wLNl6/WEDe0e4Q
        KAEkxvADT+3W9axeebA64RflsYrRp/Hf
X-Google-Smtp-Source: ACHHUZ4w9+UOJ8hpR92L+iuqXV2CCmM6jGTjaatKscEYXFC++9uOkF55WjICj/Btteh9ifUfJVf9/dcy0/O/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:d8a:0:b0:ba8:2415:f27c with SMTP id
 132-20020a250d8a000000b00ba82415f27cmr1536907ybn.3.1685130288399; Fri, 26 May
 2023 12:44:48 -0700 (PDT)
Date:   Fri, 26 May 2023 12:44:41 -0700
In-Reply-To: <20230526194442.2355872-1-irogers@google.com>
Message-Id: <20230526194442.2355872-2-irogers@google.com>
Mime-Version: 1.0
References: <20230526194442.2355872-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v3 1/2] perf evsel: evsel__group_pmu_name fixes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Previously the evsel__group_pmu_name would iterate the evsel's group,
however, the list of evsels aren't yet sorted and so the loop may
terminate prematurely. It is also not desirable to iterate the list of
evsels during list_sort as the list may be broken. Precompute the
group_pmu_name for the evsel before sorting, as part of the
computation and only if necessary, iterate the whole list looking for
group members so that being sorted isn't necessary.

Move the group pmu name computation to parse-events.c given the closer
dependency on the behavior of
parse_events__sort_events_and_fix_groups.

Fixes: 7abf0bccaaec ("perf evsel: Add function to compute group PMU name")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c        | 31 ++++-----------
 tools/perf/util/evsel.h        |  2 +-
 tools/perf/util/parse-events.c | 70 ++++++++++++++++++++++++++++------
 3 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 42d6dfacf191..a3c24d2e8ca3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -291,6 +291,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
 	evsel->pmu_name      = NULL;
+	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
 }
 
@@ -390,6 +391,11 @@ struct evsel *evsel__clone(struct evsel *orig)
 		if (evsel->pmu_name == NULL)
 			goto out_err;
 	}
+	if (orig->group_pmu_name) {
+		evsel->group_pmu_name = strdup(orig->group_pmu_name);
+		if (evsel->group_pmu_name == NULL)
+			goto out_err;
+	}
 	if (orig->filter) {
 		evsel->filter = strdup(orig->filter);
 		if (evsel->filter == NULL)
@@ -786,30 +792,6 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
 	return !strcmp(evsel__name(evsel), name);
 }
 
-const char *evsel__group_pmu_name(const struct evsel *evsel)
-{
-	struct evsel *leader = evsel__leader(evsel);
-	struct evsel *pos;
-
-	/*
-	 * Software events may be in a group with other uncore PMU events. Use
-	 * the pmu_name of the first non-software event to avoid breaking the
-	 * software event out of the group.
-	 *
-	 * Aux event leaders, like intel_pt, expect a group with events from
-	 * other PMUs, so substitute the AUX event's PMU in this case.
-	 */
-	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
-		/* Starting with the leader, find the first event with a named PMU. */
-		for_each_group_evsel(pos, leader) {
-			if (pos->pmu_name)
-				return pos->pmu_name;
-		}
-	}
-
-	return evsel->pmu_name ?: "cpu";
-}
-
 const char *evsel__metric_id(const struct evsel *evsel)
 {
 	if (evsel->metric_id)
@@ -1491,6 +1473,7 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
+	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
 	zfree(&evsel->metric_id);
 	evsel__zero_per_pkg(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 429b172cc94d..6d9536ecbc7b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -72,6 +72,7 @@ struct evsel {
 		char			*name;
 		char			*group_name;
 		const char		*pmu_name;
+		const char		*group_pmu_name;
 #ifdef HAVE_LIBTRACEEVENT
 		struct tep_event	*tp_format;
 #endif
@@ -287,7 +288,6 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
 bool evsel__name_is(struct evsel *evsel, const char *name);
-const char *evsel__group_pmu_name(const struct evsel *evsel);
 const char *evsel__metric_id(const struct evsel *evsel);
 
 static inline bool evsel__is_tool(const struct evsel *evsel)
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 47ee628a65bb..ac67bb667cd9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1983,6 +1983,42 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	return ret;
 }
 
+static int evsel__compute_group_pmu_name(struct evsel *evsel,
+					  const struct list_head *head)
+{
+	struct evsel *leader = evsel__leader(evsel);
+	struct evsel *pos;
+	const char *group_pmu_name = evsel->pmu_name ?: "cpu";
+
+	/*
+	 * Software events may be in a group with other uncore PMU events. Use
+	 * the pmu_name of the first non-software event to avoid breaking the
+	 * software event out of the group.
+	 *
+	 * Aux event leaders, like intel_pt, expect a group with events from
+	 * other PMUs, so substitute the AUX event's PMU in this case.
+	 */
+	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
+		/*
+		 * Starting with the leader, find the first event with a named
+		 * PMU. for_each_group_(member|evsel) isn't used as the list
+		 * isn't yet sorted putting evsel's in the same group together.
+		 */
+		if (leader->pmu_name) {
+			group_pmu_name = leader->pmu_name;
+		} else if (leader->core.nr_members > 1) {
+			list_for_each_entry(pos, head, core.node) {
+				if (evsel__leader(pos) == leader && pos->pmu_name) {
+					group_pmu_name = pos->pmu_name;
+					break;
+				}
+			}
+		}
+	}
+	evsel->group_pmu_name = strdup(group_pmu_name);
+	return evsel->group_pmu_name ? 0 : -ENOMEM;
+}
+
 __weak int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
 	/* Order by insertion index. */
@@ -2002,7 +2038,11 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 
 	/*
 	 * First sort by grouping/leader. Read the leader idx only if the evsel
-	 * is part of a group, as -1 indicates no group.
+	 * is part of a group, by default ungrouped events will be sorted
+	 * relative to grouped events based on where the first ungrouped event
+	 * occurs. If both events don't have a group we want to fall-through to
+	 * the arch specific sorting, that can reorder and fix things like
+	 * Intel's topdown events.
 	 */
 	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
 		lhs_has_group = true;
@@ -2018,8 +2058,8 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 
 	/* Group by PMU if there is a group. Groups can't span PMUs. */
 	if (lhs_has_group && rhs_has_group) {
-		lhs_pmu_name = evsel__group_pmu_name(lhs);
-		rhs_pmu_name = evsel__group_pmu_name(rhs);
+		lhs_pmu_name = lhs->group_pmu_name;
+		rhs_pmu_name = rhs->group_pmu_name;
 		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
 		if (ret)
 			return ret;
@@ -2029,13 +2069,14 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 	return arch_evlist__cmp(lhs, rhs);
 }
 
-static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
+static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 {
 	int idx = 0, unsorted_idx = -1;
 	struct evsel *pos, *cur_leader = NULL;
 	struct perf_evsel *cur_leaders_grp = NULL;
 	bool idx_changed = false;
 	int orig_num_leaders = 0, num_leaders = 0;
+	int ret;
 
 	/*
 	 * Compute index to insert ungrouped events at. Place them where the
@@ -2044,6 +2085,10 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
 
+		ret = evsel__compute_group_pmu_name(pos, list);
+		if (ret)
+			return ret;
+
 		if (pos == pos_leader)
 			orig_num_leaders++;
 
@@ -2068,7 +2113,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 	idx = 0;
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
-		const char *pos_pmu_name = evsel__group_pmu_name(pos);
+		const char *pos_pmu_name = pos->group_pmu_name;
 		const char *cur_leader_pmu_name, *pos_leader_pmu_name;
 		bool force_grouped = arch_evsel__must_be_in_group(pos);
 
@@ -2085,7 +2130,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 		if (!cur_leader)
 			cur_leader = pos;
 
-		cur_leader_pmu_name = evsel__group_pmu_name(cur_leader);
+		cur_leader_pmu_name = cur_leader->group_pmu_name;
 		if ((cur_leaders_grp != pos->core.leader && !force_grouped) ||
 		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
 			/* Event is for a different group/PMU than last. */
@@ -2097,7 +2142,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 			 */
 			cur_leaders_grp = pos->core.leader;
 		}
-		pos_leader_pmu_name = evsel__group_pmu_name(pos_leader);
+		pos_leader_pmu_name = pos_leader->group_pmu_name;
 		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_grouped) {
 			/*
 			 * Event's PMU differs from its leader's. Groups can't
@@ -2114,7 +2159,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 			num_leaders++;
 		pos_leader->core.nr_members++;
 	}
-	return idx_changed || num_leaders != orig_num_leaders;
+	return (idx_changed || num_leaders != orig_num_leaders) ? 1 : 0;
 }
 
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
@@ -2131,7 +2176,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 		.pmu_filter = pmu_filter,
 		.match_legacy_cache_terms = true,
 	};
-	int ret;
+	int ret, ret2;
 
 	ret = parse_events__scanner(str, &parse_state);
 
@@ -2140,8 +2185,11 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 		return -1;
 	}
 
-	if (parse_events__sort_events_and_fix_groups(&parse_state.list) &&
-	    warn_if_reordered && !parse_state.wild_card_pmus)
+	ret2 = parse_events__sort_events_and_fix_groups(&parse_state.list);
+	if (ret2 < 0)
+		return ret;
+
+	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus)
 		pr_warning("WARNING: events were regrouped to match PMUs\n");
 
 	/*
-- 
2.41.0.rc0.172.g3f132b7071-goog

