Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B416F12A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbjD1HoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345676AbjD1Hnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:43:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE5C5FED
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:42:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fc35ab48fso87474777b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667720; x=1685259720;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GL5a69/3p/sYFbtBmudKJ5l2nYH24ZT/ENio0Maec6Y=;
        b=yfBDPauVZr9Fyug5ebjvUlXuRWXzs5iOS2NecaPOWJwpsV/E/Oly2wdMyl5liD+540
         KIlxhhBeYKf+I01ldqGr+ZlhkbQleLMxl+Bz1r6Z5I2dbOxmUdQMkYulJUCpE/luwv33
         VWLzKoggx45gwD9QfRTUS526H20WUIvUkIM92qjECxsAL2iTPIMSuErGtutOfagfVCIO
         OCmExeJXLEqGNqtNNCyxrPtMQQCcK+v6PlB9FwA/QmlBPpHyVGxZNXQ6x3Zc3/agUZXV
         s7iHopCeTb5EqV4s2Iu90jNZ7ZyAIxdvhEz/mJHibMLWUBjWdqGVNyF08Hxr1QKNoRsY
         N1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667720; x=1685259720;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GL5a69/3p/sYFbtBmudKJ5l2nYH24ZT/ENio0Maec6Y=;
        b=H5+yecTwKmsg5a+kjWN8ARpHVl/KMnfvR2Fh9wIaBhqotMBWyeIitTS8NfBcYw2dvz
         a2KuRRq6IWNBwoYW4tzkkqC19HJRB6kIiRrzajTWPnuhZ7Op9DNbOOoLILfLmsmPCj/W
         8YIjF4Q6dYLrY6Bt47mUt9JFqqluwOH/z0ZoBZqRjyLY1QQcFBz7kZOYyicO01xFVHZQ
         qYzefJChYGk/hJ26fIsGic2s+ua+Ka+vkK1i/En83Cf2Lp9dnxlZgzrqHc4D5WYK+p7b
         hyf3qWbLaNDLz9VGisbi1mNLgBOwebNEsPThGvyEQNezt495YqzBjXB8nyI6SUnYAuaI
         k1fA==
X-Gm-Message-State: AC+VfDxEp+r0/2fkVPSFuXzC1jnZJ4LdPt+tK6e6JfYcMlSc1DDSVE0O
        sVFDbFjemixRPiBjFdZJkLvvqYyfdlii
X-Google-Smtp-Source: ACHHUZ6NnKbtsy3wjYV+4ihroKGTUD+Rsx5JnmOXc1oM9jZh25AU8h8KTqzYxZC3slyfcHy5V+a24o6KP/ic
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a81:b109:0:b0:552:b607:634b with SMTP id
 p9-20020a81b109000000b00552b607634bmr2691445ywh.4.1682667720004; Fri, 28 Apr
 2023 00:42:00 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:51 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-26-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 25/43] perf parse-events: Support wildcards on raw events
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

Legacy raw events like r1a open as PERF_TYPE_RAW on non-hybrid systems
and on each hybrid PMU on hybrid systems. Rather than iterate hybrid
PMUs add a perf_pmu__supports_wildcard_numeric function that says when
a numeric event should be opened upon it. If the parsed event
specifies the type of the PMU then don't wildcard match PMUs, use the
specified PMU type.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 50 ++++++++++++++++++++++++----------
 tools/perf/util/parse-events.h |  3 +-
 tools/perf/util/parse-events.y | 13 ++++++---
 tools/perf/util/pmu.c          |  5 ++++
 tools/perf/util/pmu.h          |  1 +
 5 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d95135115d7f..e9515e46a140 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -25,7 +25,6 @@
 #include "util/parse-branch-options.h"
 #include "util/evsel_config.h"
 #include "util/event.h"
-#include "util/parse-events-hybrid.h"
 #include "util/pmu-hybrid.h"
 #include "util/bpf-filter.h"
 #include "util/util.h"
@@ -1448,15 +1447,14 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 #endif
 }
 
-int parse_events_add_numeric(struct parse_events_state *parse_state,
-			     struct list_head *list,
-			     u32 type, u64 config,
-			     struct list_head *head_config)
+static int __parse_events_add_numeric(struct parse_events_state *parse_state,
+				struct list_head *list,
+				struct perf_pmu *pmu, u32 type, u64 config,
+				struct list_head *head_config)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	const char *name, *metric_id;
-	bool hybrid;
 	int ret;
 
 	memset(&attr, 0, sizeof(attr));
@@ -1474,19 +1472,41 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
-	ret = parse_events__add_numeric_hybrid(parse_state, list, &attr,
-					       name, metric_id,
-					       &config_terms, &hybrid);
-	if (hybrid)
-		goto out_free_terms;
-
-	ret = add_event(list, &parse_state->idx, &attr, name, metric_id,
-			&config_terms);
-out_free_terms:
+	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
+			metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+			/*cpu_list=*/NULL) ? 0 : -ENOMEM;
 	free_config_terms(&config_terms);
 	return ret;
 }
 
+int parse_events_add_numeric(struct parse_events_state *parse_state,
+			     struct list_head *list,
+			     u32 type, u64 config,
+			     struct list_head *head_config,
+			     bool wildcard)
+{
+	struct perf_pmu *pmu = NULL;
+	bool found_supported = false;
+
+	if (!wildcard)
+		return __parse_events_add_numeric(parse_state, list, /*pmu=*/NULL,
+						  type, config, head_config);
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		int ret;
+
+		if (!perf_pmu__supports_wildcard_numeric(pmu))
+			continue;
+
+		found_supported = true;
+		ret = __parse_events_add_numeric(parse_state, list, pmu, pmu->type,
+						 config, head_config);
+		if (ret)
+			return ret;
+	}
+	return found_supported ? 0 : -EINVAL;
+}
+
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event)
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 4e49be290209..831cd1ff4702 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -166,7 +166,8 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
-			     struct list_head *head_config);
+			     struct list_head *head_config,
+			     bool wildcard);
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index cc7528558845..5055a29a448f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -435,7 +435,8 @@ value_sym '/' event_config '/'
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_numeric(_parse_state, list, type, config, $3);
+	err = parse_events_add_numeric(_parse_state, list, type, config, $3,
+				       /*wildcard=*/false);
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(list);
@@ -452,7 +453,9 @@ value_sym sep_slash_slash_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config, NULL));
+	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config,
+					  /*head_config=*/NULL,
+					  /*wildcard=*/false));
 	$$ = list;
 }
 |
@@ -596,7 +599,8 @@ PE_VALUE ':' PE_VALUE opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4);
+	err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4,
+				       /*wildcard=*/false);
 	parse_events_terms__delete($4);
 	if (err) {
 		free(list);
@@ -618,7 +622,8 @@ PE_RAW opt_event_config
 	num = strtoull($1 + 1, NULL, 16);
 	ABORT_ON(errno);
 	free($1);
-	err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, num, $2);
+	err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, num, $2,
+				       /*wildcard=*/true);
 	parse_events_terms__delete($2);
 	if (err) {
 		free(list);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 63071d876190..cd4247a379d4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1655,6 +1655,11 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
 }
 
+bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
+{
+	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+}
+
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
 				   struct sevent *alias_b)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 05702bc4bcf8..5a19536a5449 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -221,6 +221,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
+bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu);
 void print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool pmu_have_event(const char *pname, const char *name);
 
-- 
2.40.1.495.gc816e09b53d-goog

