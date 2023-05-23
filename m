Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F7F70D2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 06:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjEWEo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 00:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjEWEoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 00:44:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1FBFA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 21:44:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564fb1018bcso42808627b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 21:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684817092; x=1687409092;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ubJ6qLNNMdFM+mApGXm7T3NWpqESngBUUmFw592/CxU=;
        b=s3AAiGnzmqnbhCLpuN7FQUeFJGTlSMTuIJt7S588QTHGnC/KflXw5ntjW8PkJFNZ95
         Fc4jR6AQz9nPQCNWOV+xIIqAw6YCv36gLeIZB5fjS48E7j+BDcvCMtO5XNhQbmPLKgeY
         Vd8EHraYG2RYZmZj3A82H9SwZexJrJnaCvihEKeGqxJoFwlymBeJuOF1bptjQ50plHqi
         sGiXWv4i8SjemfW1SLNdUEerAFWSeklxzASR/GbUcKJG3ZdO/3NmntRWsV46OOmFhkfg
         Tf6mcHV+lxKn0bjWc4fUxOyLPFAmp6rlwoM4an+RT9IsEn3CDlI7PbUIajdSo2uwBHF+
         7HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684817092; x=1687409092;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubJ6qLNNMdFM+mApGXm7T3NWpqESngBUUmFw592/CxU=;
        b=V0riv/gyKAEFknVpx448ngm3ITDYUhu2x+lGw0tbCHkoz0jDItcTkaPPvINoltEtqj
         0DxYVgjjSZmTLyME3+N5aNjQTS8P2Uorac1CTtFgEmYQrFVTCDMGRaCmHGGyio/HYX3F
         eoDecIC6m8UgBgk0s6vo8Ge+v/sJEEJCrhMSf9oPFAM4lwU8lGlN/j6tH5hNiwNoyGrQ
         LlNghYIXq2tgmlAlKMIKSvCIJ1lnvdKF/SyCtiYnYRT3qwQkJHY26fd+a0IgvRnNcguM
         m+xzaIGRJtj7Gz8wWcx3kRuj1OwDrIAsmEB/xs3S7XawH85tLKgfEx3rbhmJVt9eNF0V
         JTwQ==
X-Gm-Message-State: AC+VfDwm1APtrU0sOeuvpsP/5fCRuT+gYjbJdudRMyhsc3sLLKDpKAOT
        i2Dc9Mfop5VflUgVk/o9H+/DG6oKLayd
X-Google-Smtp-Source: ACHHUZ6ZuZhCi0MFDePSiWF7j1qiAbcPldZQEwcj7sGsKpUIGJFAhzYgUjpu9x2dfQeqZkfEJMejOYj7jXhD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a05:690c:72c:b0:561:8c47:de72 with SMTP id
 bt12-20020a05690c072c00b005618c47de72mr8508442ywb.2.1684817092491; Mon, 22
 May 2023 21:44:52 -0700 (PDT)
Date:   Mon, 22 May 2023 21:44:45 -0700
Message-Id: <20230523044446.1020769-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 1/2] perf evsel: evsel__group_pmu_name fixes
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
 tools/perf/util/evsel.c        | 31 +++++-----------------
 tools/perf/util/evsel.h        |  2 +-
 tools/perf/util/parse-events.c | 47 ++++++++++++++++++++++++++++++----
 3 files changed, 50 insertions(+), 30 deletions(-)

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
index 34ba840ae19a..210e6f713c6f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2125,6 +2125,41 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 	return ret;
 }
 
+static void evsel__compute_group_pmu_name(struct evsel *evsel,
+					  const struct list_head *head)
+{
+	struct evsel *leader = evsel__leader(evsel);
+	struct evsel *pos;
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
+			evsel->group_pmu_name = strdup(leader->pmu_name);
+			return;
+		}
+		list_for_each_entry(pos, head, core.node) {
+			if (evsel__leader(pos) == leader && pos->pmu_name) {
+				evsel->group_pmu_name = strdup(pos->pmu_name);
+				return;
+			}
+		}
+	}
+
+	evsel->group_pmu_name = strdup(evsel->pmu_name ?: "cpu");
+}
+
 __weak int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
 	/* Order by insertion index. */
@@ -2160,8 +2195,8 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 
 	/* Group by PMU if there is a group. Groups can't span PMUs. */
 	if (lhs_has_group && rhs_has_group) {
-		lhs_pmu_name = evsel__group_pmu_name(lhs);
-		rhs_pmu_name = evsel__group_pmu_name(rhs);
+		lhs_pmu_name = lhs->group_pmu_name;
+		rhs_pmu_name = rhs->group_pmu_name;
 		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
 		if (ret)
 			return ret;
@@ -2186,6 +2221,8 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
 
+		evsel__compute_group_pmu_name(pos, list);
+
 		if (pos == pos_leader)
 			orig_num_leaders++;
 
@@ -2210,7 +2247,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 	idx = 0;
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
-		const char *pos_pmu_name = evsel__group_pmu_name(pos);
+		const char *pos_pmu_name = pos->group_pmu_name;
 		const char *cur_leader_pmu_name, *pos_leader_pmu_name;
 		bool force_grouped = arch_evsel__must_be_in_group(pos);
 
@@ -2227,7 +2264,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 		if (!cur_leader)
 			cur_leader = pos;
 
-		cur_leader_pmu_name = evsel__group_pmu_name(cur_leader);
+		cur_leader_pmu_name = cur_leader->group_pmu_name;
 		if ((cur_leaders_grp != pos->core.leader && !force_grouped) ||
 		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
 			/* Event is for a different group/PMU than last. */
@@ -2239,7 +2276,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 			 */
 			cur_leaders_grp = pos->core.leader;
 		}
-		pos_leader_pmu_name = evsel__group_pmu_name(pos_leader);
+		pos_leader_pmu_name = pos_leader->group_pmu_name;
 		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_grouped) {
 			/*
 			 * Event's PMU differs from its leader's. Groups can't
-- 
2.40.1.698.g37aff9b760-goog

