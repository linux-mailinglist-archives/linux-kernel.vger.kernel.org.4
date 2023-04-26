Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF36EEED5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjDZHF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbjDZHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:04:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB7746B1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:03:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55605fd3e19so108467637b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492621; x=1685084621;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDs5sNjGxVFMYjKVJIMo2SP2BU30kPnmI4jylpJiVuo=;
        b=rVMdrCQ228VTd/ZUVy7OQMpgibz/TSP8noXKCVnsMEqCx9MfoYiU9CuCuvyQHHWTE7
         siqVhjMH2hSx54t/Hinfg4kt2yQGey9EnDWpZK9nyxpPrNRLlubSnQxdaX2VjeKlBhzf
         /4RpvHDTyXZx35u49Wf1ZVN4JdXfxnZtrfebQspzc+3v9xUXwkdjSiZfjDYzaTQwv92K
         7jQAosQ1edCxzqZcYm/YtXA3ueAxJVRaicMIJhB9enMoVJlMB6njMdH/TcGL6hpIZv0K
         9ShRHZakh5uEKw1NrCUS4m6/UKgsv+BY7Yn5KUkkLpltlqGPqbJxOkf2xwGWqgygLDuV
         Tw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492621; x=1685084621;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDs5sNjGxVFMYjKVJIMo2SP2BU30kPnmI4jylpJiVuo=;
        b=ipTQYgv8VZIk5m0MYBiIAJPCX+/7w68m4dURaH57ObYT5OilbNPQQuizz4MffbBjpI
         yDzjwCq/hCtC60cVJ3DMguH0mO5gaEbpxjRUzw1kymrwPtCimzwiJkVzM5GhuLRkXXaQ
         pFghTSGABTVxv7Xd+vb/71rTBket8Nqk8Q3iKHOv8y0c8ncbDWn3mGkScLYRSZEQiKTr
         x+1w1T7Vgy3TG6PZgshyjJjGPY8GIPcXc4dj/piVAojuI90h3YCbHZyng3iEwHVWu0e7
         4UHEXDf2hsFnkVF1KXhp3szfeEoI7WIaoUJ+okLGGblWvD79HE0DuaGGlj82slbs7fPY
         vQIg==
X-Gm-Message-State: AAQBX9cCVGgpv7OyjwK5gffGKp8ZyJXNG/p8lb7IowKZxysxEHYglMXq
        1i2yY0dE+IXta+Dq9I75TsGn2YAhm9YJ
X-Google-Smtp-Source: AKy350YHSIu532ulvHLyrcq9djBeOskjz4Ohyc28H6L/w7RU/xbFB8C/IsmKXvhCRAGwbH1lVQ5Cx5v2Pwyi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a81:ad4e:0:b0:54c:2889:7105 with SMTP id
 l14-20020a81ad4e000000b0054c28897105mr10357539ywk.0.1682492620899; Wed, 26
 Apr 2023 00:03:40 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:30 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-21-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 20/40] perf parse-events: Support PMUs for legacy cache events
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

Allow a legacy cache event to be both, for example,
"L1-dcache-load-miss" and "cpu/L1-dcache-load-miss/" by introducing a
new legacy cache term type. The term type is processed in
config_term_pmu, setting both the type in perf_event_attr and the
config. The code to determine the config is factored out of
parse_events_add_cache and shared. If the PMU doesn't support legacy
events, currently just core/hybrid PMUs do, then the term is treated
like a PE_NAME term - as before. If only terms are being parsed, such
as for perf_pmu__new_alias, then the PE_LEGACY_CACHE token is always
parsed as PE_NAME.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 18 +++++++++
 tools/perf/util/parse-events.c  | 70 ++++++++++++++++++++++-----------
 tools/perf/util/parse-events.h  |  3 ++
 tools/perf/util/parse-events.l  |  9 ++++-
 tools/perf/util/parse-events.y  | 14 ++++++-
 tools/perf/util/pmu.c           |  5 +++
 tools/perf/util/pmu.h           |  1 +
 7 files changed, 96 insertions(+), 24 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 15fec7f01315..6aea51e33dc0 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1861,6 +1861,24 @@ static const struct evlist_test test__events_pmu[] = {
 		.check = test__checkevent_raw_pmu,
 		/* 5 */
 	},
+	{
+		.name  = "cpu/L1-dcache-load-miss/",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_genhw,
+		/* 6 */
+	},
+	{
+		.name  = "cpu/L1-dcache-load-miss/kp",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_genhw_modifier,
+		/* 7 */
+	},
+	{
+		.name  = "cpu/L1-dcache-misses,name=cachepmu/",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_config_cache,
+		/* 8 */
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e416e653cf74..9b2d7b6572c2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -403,33 +403,27 @@ static int config_attr(struct perf_event_attr *attr,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term);
 
-int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
-			   struct parse_events_error *err,
-			   struct list_head *head_config,
-			   struct parse_events_state *parse_state)
+/**
+ * parse_events__decode_legacy_cache - Search name for the legacy cache event
+ *                                     name composed of 1, 2 or 3 hyphen
+ *                                     separated sections. The first section is
+ *                                     the cache type while the others are the
+ *                                     optional op and optional result. To make
+ *                                     life hard the names in the table also
+ *                                     contain hyphens and the longest name
+ *                                     should always be selected.
+ */
+static int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config)
 {
-	struct perf_event_attr attr;
-	LIST_HEAD(config_terms);
-	const char *config_name, *metric_id;
-	int cache_type = -1, cache_op = -1, cache_result = -1;
-	int ret, len;
+	int len, cache_type = -1, cache_op = -1, cache_result = -1;
 	const char *name_end = &name[strlen(name) + 1];
-	bool hybrid;
 	const char *str = name;
 
-	/*
-	 * Search str for the legacy cache event name composed of 1, 2 or 3
-	 * hyphen separated sections. The first section is the cache type while
-	 * the others are the optional op and optional result. To make life hard
-	 * the names in the table also contain hyphens and the longest name
-	 * should always be selected.
-	 */
 	cache_type = parse_aliases(str, evsel__hw_cache, PERF_COUNT_HW_CACHE_MAX, &len);
 	if (cache_type == -1)
 		return -EINVAL;
 	str += len + 1;
 
-	config_name = get_config_name(head_config);
 	if (str < name_end) {
 		cache_op = parse_aliases(str, evsel__hw_cache_op,
 					PERF_COUNT_HW_CACHE_OP_MAX, &len);
@@ -470,9 +464,28 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	if (cache_result == -1)
 		cache_result = PERF_COUNT_HW_CACHE_RESULT_ACCESS;
 
+	*config = ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT) |
+		cache_type | (cache_op << 8) | (cache_result << 16);
+	return 0;
+}
+
+int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
+			   struct parse_events_error *err,
+			   struct list_head *head_config,
+			   struct parse_events_state *parse_state)
+{
+	struct perf_event_attr attr;
+	LIST_HEAD(config_terms);
+	const char *config_name, *metric_id;
+	int ret;
+	bool hybrid;
+
+
 	memset(&attr, 0, sizeof(attr));
-	attr.config = cache_type | (cache_op << 8) | (cache_result << 16);
 	attr.type = PERF_TYPE_HW_CACHE;
+	ret = parse_events__decode_legacy_cache(name, /*pmu_type=*/0, &attr.config);
+	if (ret)
+		return ret;
 
 	if (head_config) {
 		if (config_attr(&attr, head_config, err,
@@ -483,6 +496,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			return -ENOMEM;
 	}
 
+	config_name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
 	ret = parse_events__add_cache_hybrid(list, idx, &attr,
 					     config_name ? : name,
@@ -1021,6 +1035,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
 	[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
 	[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
+	[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 };
 
 static bool config_term_shrinked;
@@ -1198,15 +1213,25 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_error *err)
 {
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
+		const struct perf_pmu *pmu = perf_pmu__find_by_type(attr->type);
+
+		if (perf_pmu__supports_legacy_cache(pmu)) {
+			attr->type = PERF_TYPE_HW_CACHE;
+			return parse_events__decode_legacy_cache(term->config, pmu->type,
+								 &attr->config);
+		} else
+			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
+	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
-	    term->type_term == PARSE_EVENTS__TERM_TYPE_DRV_CFG)
+	    term->type_term == PARSE_EVENTS__TERM_TYPE_DRV_CFG) {
 		/*
 		 * Always succeed for sysfs terms, as we dont know
 		 * at this point what type they need to have.
 		 */
 		return 0;
-	else
-		return config_term_common(attr, term, err);
+	}
+	return config_term_common(attr, term, err);
 }
 
 #ifdef HAVE_LIBTRACEEVENT
@@ -2145,6 +2170,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.evlist	  = evlist,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
+		.match_legacy_cache_terms = true,
 	};
 	int ret;
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index f638542c8638..5acb62c2e00a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -71,6 +71,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
 	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
 	PARSE_EVENTS__TERM_TYPE_RAW,
+	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
@@ -122,6 +123,8 @@ struct parse_events_state {
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
 	char			  *hybrid_pmu_name;
+	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
+	bool			   match_legacy_cache_terms;
 	bool			   wild_card_pmus;
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4b35c099189a..abe0ce681d29 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -63,6 +63,11 @@ static int str(yyscan_t scanner, int token)
 	return token;
 }
 
+static int lc_str(yyscan_t scanner, const struct parse_events_state *state)
+{
+	return str(scanner, state->match_legacy_cache_terms ? PE_LEGACY_CACHE : PE_NAME);
+}
+
 static bool isbpf_suffix(char *text)
 {
 	int len = strlen(text);
@@ -185,7 +190,6 @@ lc_op_result	(load|loads|read|store|stores|write|prefetch|prefetches|speculative
 
 %{
 	struct parse_events_state *_parse_state = parse_events_get_extra(yyscanner);
-
 	{
 		int start_token = _parse_state->stoken;
 
@@ -269,6 +273,9 @@ r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
+{lc_type}			{ return lc_str(yyscanner, _parse_state); }
+{lc_type}-{lc_op_result}	{ return lc_str(yyscanner, _parse_state); }
+{lc_type}-{lc_op_result}-{lc_op_result}	{ return lc_str(yyscanner, _parse_state); }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
 \[all\]			{ return PE_ARRAY_ALL; }
 "["			{ BEGIN(array); return '['; }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e7072b5601c5..f84fa1b132b3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -723,7 +723,7 @@ event_term
 	$$ = head;
 }
 
-name_or_raw: PE_RAW | PE_NAME
+name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
 
 event_term:
 PE_RAW
@@ -775,6 +775,18 @@ name_or_raw '=' PE_VALUE_SYM_HW
 	$$ = term;
 }
 |
+PE_LEGACY_CACHE
+{
+	struct parse_events_term *term;
+
+	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
+					$1, 1, true, &@1, NULL)) {
+		free($1);
+		YYABORT;
+	}
+	$$ = term;
+}
+|
 PE_NAME
 {
 	struct parse_events_term *term;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cb33d869f1ed..63071d876190 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1650,6 +1650,11 @@ bool is_pmu_core(const char *name)
 	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
 }
 
+bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
+{
+	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+}
+
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
 				   struct sevent *alias_b)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b9a02dedd473..05702bc4bcf8 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -220,6 +220,7 @@ void perf_pmu__del_formats(struct list_head *formats);
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
 bool is_pmu_core(const char *name);
+bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 void print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool pmu_have_event(const char *pname, const char *name);
 
-- 
2.40.1.495.gc816e09b53d-goog

