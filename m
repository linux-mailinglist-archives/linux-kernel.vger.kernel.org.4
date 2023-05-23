Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D270E4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbjEWSiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbjEWSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:38:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30AD1A8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:37:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b238ee8so78849276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684867061; x=1687459061;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EXNjvkTat2Mrjd9QzN+5oFCVBjhFpsk/0r+uHdavgk=;
        b=0xSaTKMrmKuk96Uegzb15Tdj9ZMszefyqLZVmD6gA3vc5YJWQR3xbYEfhWyP3gYKjw
         BNvFi5mFOshM+wXxq5agjUfCd9gTBiPncB0oAJ0AJklKn2mmva2sJ/ITsGvscQ/UCpIZ
         F+97qAIZDbFoPawhZtw5u3gS2Us8VgWdS0Kw+YSinYbL/e9cfzALiDV6yQ9Z7ZokNK+q
         toW4u+mRHkBb+8i0XG8m8lSdKWvebXE8AbggSWLNTEp5aqGMJIS2s3JuiMn5i2cslT3L
         ypWct5HXZN880H28c6AF/mPm+KZeG8SsOH/aWAR+tGKzWapNoH7Pa85bIY8GYjG3DGP3
         bLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684867061; x=1687459061;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EXNjvkTat2Mrjd9QzN+5oFCVBjhFpsk/0r+uHdavgk=;
        b=NVddfrH/+Ym4MlCEkOwwaKJEEXrWXTb/6ulo4qzhZFYlCWcgWiZHtuGslPahclRBfl
         R2/j5oUGsoGJSjud3L/bi6Ae7TghF+UlWc27ct22AcuRgHvBKSmuxRcaWa9DaMiqz/9C
         LLcW+sknXqTnBqlFpmS2WYVWaAT12gi+IXrjEN1IxXrzwX1x3DVPHLkCzmEeY5fnGV59
         9jsdyQSMiQwcb00rT6vE0npRCvMg1Zj+GeAh0mwJmrx+/zSdPiy49yfI/8aW6An2i18g
         9Pi725bRyI5fjtOIVb7Bm41R3xWcoynWzJhfnmbjQDPD7MoxdbJItgsacIJSz0IZPYqp
         DYQw==
X-Gm-Message-State: AC+VfDyL//tyxObLB3KBvszsQ4aNeELq6EkiO2oMokJN8rOCNs4gYhc/
        EMQgsBA3pg6N5ewQvTwPaon01juVrtPV
X-Google-Smtp-Source: ACHHUZ5CdkkGoEL4HvrMuSmiw17EFFzhIkpo6y6OMVWpI67zX/4MRIN+kc7EAZh3C+itNxV96vUdfOY2mWSJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:235b:5195:e7b8:a5c2])
 (user=irogers job=sendgmr) by 2002:a05:6902:14f:b0:ba8:6148:4300 with SMTP id
 p15-20020a056902014f00b00ba861484300mr6219672ybh.6.1684867060821; Tue, 23 May
 2023 11:37:40 -0700 (PDT)
Date:   Tue, 23 May 2023 11:36:19 -0700
In-Reply-To: <20230523183620.1147607-1-irogers@google.com>
Message-Id: <20230523183620.1147607-2-irogers@google.com>
Mime-Version: 1.0
References: <20230523183620.1147607-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 1/2] perf evsel: evsel__group_pmu_name fixes
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
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2f5910b31fa9..3247773f9e24 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->per_pkg_mask  = NULL;
 	evsel->collect_stat  = false;
 	evsel->pmu_name      = NULL;
+	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
 }
 
@@ -431,6 +432,11 @@ struct evsel *evsel__clone(struct evsel *orig)
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
@@ -827,30 +833,6 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
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
@@ -1536,6 +1518,7 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
+	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
 	zfree(&evsel->metric_id);
 	evsel__zero_per_pkg(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index df8928745fc6..820771a649b2 100644
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
@@ -289,7 +290,6 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
 bool evsel__name_is(struct evsel *evsel, const char *name);
-const char *evsel__group_pmu_name(const struct evsel *evsel);
 const char *evsel__metric_id(const struct evsel *evsel);
 
 static inline bool evsel__is_tool(const struct evsel *evsel)
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 34ba840ae19a..9899953e91f0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2125,6 +2125,42 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
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
@@ -2144,7 +2180,11 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 
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
@@ -2160,8 +2200,8 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 
 	/* Group by PMU if there is a group. Groups can't span PMUs. */
 	if (lhs_has_group && rhs_has_group) {
-		lhs_pmu_name = evsel__group_pmu_name(lhs);
-		rhs_pmu_name = evsel__group_pmu_name(rhs);
+		lhs_pmu_name = lhs->group_pmu_name;
+		rhs_pmu_name = rhs->group_pmu_name;
 		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
 		if (ret)
 			return ret;
@@ -2171,13 +2211,14 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
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
@@ -2186,6 +2227,10 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
 
+		ret = evsel__compute_group_pmu_name(pos, list);
+		if (ret)
+			return ret;
+
 		if (pos == pos_leader)
 			orig_num_leaders++;
 
@@ -2210,7 +2255,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 	idx = 0;
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
-		const char *pos_pmu_name = evsel__group_pmu_name(pos);
+		const char *pos_pmu_name = pos->group_pmu_name;
 		const char *cur_leader_pmu_name, *pos_leader_pmu_name;
 		bool force_grouped = arch_evsel__must_be_in_group(pos);
 
@@ -2227,7 +2272,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 		if (!cur_leader)
 			cur_leader = pos;
 
-		cur_leader_pmu_name = evsel__group_pmu_name(cur_leader);
+		cur_leader_pmu_name = cur_leader->group_pmu_name;
 		if ((cur_leaders_grp != pos->core.leader && !force_grouped) ||
 		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
 			/* Event is for a different group/PMU than last. */
@@ -2239,7 +2284,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 			 */
 			cur_leaders_grp = pos->core.leader;
 		}
-		pos_leader_pmu_name = evsel__group_pmu_name(pos_leader);
+		pos_leader_pmu_name = pos_leader->group_pmu_name;
 		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_grouped) {
 			/*
 			 * Event's PMU differs from its leader's. Groups can't
@@ -2256,7 +2301,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 			num_leaders++;
 		pos_leader->core.nr_members++;
 	}
-	return idx_changed || num_leaders != orig_num_leaders;
+	return (idx_changed || num_leaders != orig_num_leaders) ? 1 : 0;
 }
 
 int __parse_events(struct evlist *evlist, const char *str,
@@ -2271,7 +2316,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
 	};
-	int ret;
+	int ret, ret2;
 
 	ret = parse_events__scanner(str, &parse_state);
 	perf_pmu__parse_cleanup();
@@ -2281,8 +2326,11 @@ int __parse_events(struct evlist *evlist, const char *str,
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
2.40.1.698.g37aff9b760-goog

