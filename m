Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810CC6F4D14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEBWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjEBWnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:43:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787830DD
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:43:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a8023ccf1so8699729276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067362; x=1685659362;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIy1w7Suqr6o3m/wJrfSKrKWSdqbzqB7RJQwe4p4GGY=;
        b=XsMbJlHkDCMgrHHR0sONjvSl1QaHIlCBfs7hrYO9z7BqSaH0YUOBD46md6wq/ky+10
         IDg3thG6w1jz7abHSyp50Sbxbv/aAddV3ouaO/YiZHckNHKEKjrkns05qNSviYwjiddL
         0GCeN3hNrZmHyqyXPpKtevSMyC3nSDN4cT4qVtGp/l2cVn6CEMWr5dREL9vizVlIoR59
         Ltfg0yvP7TXIWa0j7/ampcUKlUgq0FcQdj9D6GXx+xc+nVG9Gu8GtqQXR91Kg45ATzLl
         W/yU8a/7CGz9vDcA13jYJKjmsTGaKMBG3nIPCj7GTNUjUSH+45U5abWbNbOSmqWGN0YB
         E6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067362; x=1685659362;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIy1w7Suqr6o3m/wJrfSKrKWSdqbzqB7RJQwe4p4GGY=;
        b=T8IvDt4yBK8A9Mc/c8v8iAIGEeb9h+flV9i1vykyKooEr5Vrg62SB3nfhmEwdg4HcE
         7BcgGOBS3btCCoVsEMhLISC9uIZGmdjkhm1fWi9A00WEQKWCuNM3KPfHpr05s/e1iZMB
         GS+18F/CmbmKfhcc2m9yRmH2cK8gglZJ8/BqRu54+XX42D+YUxyFm/PkgtjnhRi5H5pI
         UcBKyBzQ4YMVRtOH5cz1J+5Wb8aktWCOy0U8oOugD8G7yhoABsvMfl1HNz/y91aQThQa
         jqCBoeOH6wY4XjnU0NVuaEDWEAcpT7vMxZF6rBa+gcCeEffxixvjkxKKmN9OjZTN4LUy
         rQ1A==
X-Gm-Message-State: AC+VfDw9V2/sUSeHfVWYpretcjI6gywyKpIscLyn+ujjCpB56Dx187my
        uQBD/fFK+WwL2dRdYP2w6QZau2vjmtnG
X-Google-Smtp-Source: ACHHUZ7TZGwSrb219E1b+bY23owoCyi2h24jldDYMrySXgPgVNaxdPQjbUYN1rDDiB37NJholkaP59A7/cF+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:4884:0:b0:b9a:6a68:7c25 with SMTP id
 v126-20020a254884000000b00b9a6a687c25mr11147022yba.5.1683067362583; Tue, 02
 May 2023 15:42:42 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:36 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-30-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 29/44] perf parse-events: Add pmu filter
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

To support the cputype argument added to "perf stat" for hybrid it is
necessary to filter events during wildcard matching. Add a scanner
argument for the filter and checking it when wildcard matching.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c     | 13 +++++++--
 tools/perf/builtin-stat.c       | 10 +++++--
 tools/perf/builtin-top.c        |  5 +++-
 tools/perf/builtin-trace.c      |  5 +++-
 tools/perf/tests/parse-events.c |  3 +-
 tools/perf/tests/pmu-events.c   |  3 +-
 tools/perf/util/evlist.h        |  1 -
 tools/perf/util/metricgroup.c   |  4 +--
 tools/perf/util/parse-events.c  | 51 ++++++++++++++++++++++++---------
 tools/perf/util/parse-events.h  | 21 ++++++++++----
 tools/perf/util/parse-events.y  |  6 ++--
 11 files changed, 90 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7b7e74a56346..7e4490dfc0b5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3335,6 +3335,14 @@ const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
 
 static bool dry_run;
 
+static struct parse_events_option_args parse_events_option_args = {
+	.evlistp = &record.evlist,
+};
+
+static struct parse_events_option_args switch_output_parse_events_option_args = {
+	.evlistp = &record.sb_evlist,
+};
+
 /*
  * XXX Will stay a global variable till we fix builtin-script.c to stop messing
  * with it and switch to use the library functions in perf_evlist that came
@@ -3343,7 +3351,7 @@ static bool dry_run;
  * using pipes, etc.
  */
 static struct option __record_options[] = {
-	OPT_CALLBACK('e', "event", &record.evlist, "event",
+	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
 	OPT_CALLBACK(0, "filter", &record.evlist, "filter",
@@ -3496,7 +3504,8 @@ static struct option __record_options[] = {
 			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
 			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
 			  "signal"),
-	OPT_CALLBACK_SET(0, "switch-output-event", &record.sb_evlist, &record.switch_output_event_set, "switch output event",
+	OPT_CALLBACK_SET(0, "switch-output-event", &switch_output_parse_events_option_args,
+			 &record.switch_output_event_set, "switch output event",
 			 "switch output event selector. use 'perf list' to list available events",
 			 parse_events_option_new_evlist),
 	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ffb47b166098..3b25fcab5cd1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -101,6 +101,10 @@
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
 static struct evlist	*evsel_list;
+static struct parse_events_option_args parse_events_option_args = {
+	.evlistp = &evsel_list,
+};
+
 static bool all_counters_use_bpf = true;
 
 static struct target target = {
@@ -1096,8 +1100,8 @@ static int parse_hybrid_type(const struct option *opt,
 		return -1;
 	}
 
-	evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
-	if (!evlist->hybrid_pmu_name) {
+	parse_events_option_args.pmu_filter = perf_pmu__hybrid_type_to_pmu(str);
+	if (!parse_events_option_args.pmu_filter) {
 		fprintf(stderr, "--cputype %s is not supported!\n", str);
 		return -1;
 	}
@@ -1108,7 +1112,7 @@ static int parse_hybrid_type(const struct option *opt,
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
-	OPT_CALLBACK('e', "event", &evsel_list, "event",
+	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
 	OPT_CALLBACK(0, "filter", &evsel_list, "filter",
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index eb5740154bc0..48ee49e95c5e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1440,12 +1440,15 @@ int cmd_top(int argc, const char **argv)
 		.max_stack	     = sysctl__max_stack(),
 		.nr_threads_synthesize = UINT_MAX,
 	};
+	struct parse_events_option_args parse_events_option_args = {
+		.evlistp = &top.evlist,
+	};
 	bool branch_call_mode = false;
 	struct record_opts *opts = &top.record_opts;
 	struct target *target = &opts->target;
 	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
 	const struct option options[] = {
-	OPT_CALLBACK('e', "event", &top.evlist, "event",
+	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8ee3a45c3c54..b49d3abb1203 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4591,8 +4591,11 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	err = 0;
 
 	if (lists[0]) {
+		struct parse_events_option_args parse_events_option_args = {
+			.evlistp = &trace->evlist,
+		};
 		struct option o = {
-			.value = &trace->evlist,
+			.value = &parse_events_option_args,
 		};
 		err = parse_events_option(&o, lists[0], 0);
 	}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index c3afd0b129bb..0d0c869d2d09 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1952,7 +1952,8 @@ static int test_event_fake_pmu(const char *str)
 		return -ENOMEM;
 
 	parse_events_error__init(&err);
-	ret = __parse_events(evlist, str, &err, &perf_pmu__fake, /*warn_if_reordered=*/true);
+	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
+			     &perf_pmu__fake, /*warn_if_reordered=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 str, ret, err.str);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index a2cde61b1c77..734004f1a37d 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -776,7 +776,8 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
 		*cur = '/';
 
-	ret = __parse_events(evlist, dup, error, fake_pmu, /*warn_if_reordered=*/true);
+	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, fake_pmu,
+			     /*warn_if_reordered=*/true);
 	free(dup);
 
 	evlist__delete(evlist);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 46cf402add93..e7e5540cc970 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -67,7 +67,6 @@ struct evlist {
 	struct evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
-	const char *hybrid_pmu_name;
 	void (*trace_event_sample_raw)(struct evlist *evlist,
 				       union perf_event *event,
 				       struct perf_sample *sample);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e1acb0d23b95..1afc8d7a5838 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1441,8 +1441,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	}
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
-	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu,
-			     /*warn_if_reordered=*/false);
+	ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
+			     &parse_error, fake_pmu, /*warn_if_reordered=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1d8c3cf9c185..d9d964bbc0e2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -465,8 +465,24 @@ int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *con
 	return 0;
 }
 
+/**
+ * parse_events__filter_pmu - returns false if a wildcard PMU should be
+ *                            considered, true if it should be filtered.
+ */
+bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
+			      const struct perf_pmu *pmu)
+{
+	if (parse_state->pmu_filter == NULL)
+		return false;
+
+	if (pmu->name == NULL)
+		return true;
+
+	return strcmp(parse_state->pmu_filter, pmu->name) != 0;
+}
+
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
-			   struct parse_events_error *err,
+			   struct parse_events_state *parse_state,
 			   struct list_head *head_config)
 {
 	struct perf_pmu *pmu = NULL;
@@ -483,6 +499,9 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 		if (!perf_pmu__supports_legacy_cache(pmu))
 			continue;
 
+		if (parse_events__filter_pmu(parse_state, pmu))
+			continue;
+
 		memset(&attr, 0, sizeof(attr));
 		attr.type = PERF_TYPE_HW_CACHE;
 
@@ -493,8 +512,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 		found_supported = true;
 
 		if (head_config) {
-			if (config_attr(&attr, head_config, err,
-						config_term_common))
+			if (config_attr(&attr, head_config, parse_state->error, config_term_common))
 				return -EINVAL;
 
 			if (get_config_terms(head_config, &config_terms))
@@ -1494,6 +1512,9 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 		if (!perf_pmu__supports_wildcard_numeric(pmu))
 			continue;
 
+		if (parse_events__filter_pmu(parse_state, pmu))
+			continue;
+
 		found_supported = true;
 		ret = __parse_events_add_numeric(parse_state, list, pmu, pmu->type,
 						 config, head_config);
@@ -1682,6 +1703,9 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		struct perf_pmu_alias *alias;
 
+		if (parse_events__filter_pmu(parse_state, pmu))
+			continue;
+
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (!strcasecmp(alias->name, str)) {
 				parse_events_copy_term_list(head, &orig_head);
@@ -2121,7 +2145,7 @@ static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 	return idx_changed || num_leaders != orig_num_leaders;
 }
 
-int __parse_events(struct evlist *evlist, const char *str,
+int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
 		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
 		   bool warn_if_reordered)
 {
@@ -2132,6 +2156,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.evlist	  = evlist,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
+		.pmu_filter = pmu_filter,
 		.match_legacy_cache_terms = true,
 	};
 	int ret;
@@ -2313,12 +2338,13 @@ void parse_events_error__print(struct parse_events_error *err,
 int parse_events_option(const struct option *opt, const char *str,
 			int unset __maybe_unused)
 {
-	struct evlist *evlist = *(struct evlist **)opt->value;
+	struct parse_events_option_args *args = opt->value;
 	struct parse_events_error err;
 	int ret;
 
 	parse_events_error__init(&err);
-	ret = parse_events(evlist, str, &err);
+	ret = __parse_events(*args->evlistp, str, args->pmu_filter, &err,
+			     /*fake_pmu=*/NULL, /*warn_if_reordered=*/true);
 
 	if (ret) {
 		parse_events_error__print(&err, str);
@@ -2331,22 +2357,21 @@ int parse_events_option(const struct option *opt, const char *str,
 
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset)
 {
-	struct evlist **evlistp = opt->value;
+	struct parse_events_option_args *args = opt->value;
 	int ret;
 
-	if (*evlistp == NULL) {
-		*evlistp = evlist__new();
+	if (*args->evlistp == NULL) {
+		*args->evlistp = evlist__new();
 
-		if (*evlistp == NULL) {
+		if (*args->evlistp == NULL) {
 			fprintf(stderr, "Not enough memory to create evlist\n");
 			return -1;
 		}
 	}
-
 	ret = parse_events_option(opt, str, unset);
 	if (ret) {
-		evlist__delete(*evlistp);
-		*evlistp = NULL;
+		evlist__delete(*args->evlistp);
+		*args->evlistp = NULL;
 	}
 
 	return ret;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 77b8f7efdb94..d4cbda6e946a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -22,17 +22,24 @@ bool is_event_supported(u8 type, u64 config);
 
 const char *event_type(int type);
 
+/* Arguments encoded in opt->value. */
+struct parse_events_option_args {
+	struct evlist **evlistp;
+	const char *pmu_filter;
+};
 int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
-__attribute__((nonnull(1, 2, 3)))
-int __parse_events(struct evlist *evlist, const char *str, struct parse_events_error *error,
-		   struct perf_pmu *fake_pmu, bool warn_if_reordered);
+__attribute__((nonnull(1, 2, 4)))
+int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
+		   struct parse_events_error *error, struct perf_pmu *fake_pmu,
+		   bool warn_if_reordered);
 
 __attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
-	return __parse_events(evlist, str, err, /*fake_pmu=*/NULL, /*warn_if_reordered=*/true);
+	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/NULL,
+			      /*warn_if_reordered=*/true);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -122,11 +129,15 @@ struct parse_events_state {
 	struct list_head	  *terms;
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
+	/* If non-null, when wildcard matching only match the given PMU. */
+	const char		  *pmu_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
 	bool			   match_legacy_cache_terms;
 	bool			   wild_card_pmus;
 };
 
+bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
+			      const struct perf_pmu *pmu);
 void parse_events__shrink_config_terms(void);
 int parse_events__is_hardcoded_term(struct parse_events_term *term);
 int parse_events_term__num(struct parse_events_term **term,
@@ -171,7 +182,7 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
-			   struct parse_events_error *error,
+			   struct parse_events_state *parse_state,
 			   struct list_head *head_config);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct list_head *list, int *idx,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e709508b1d6e..c95877cbd6cf 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -312,6 +312,9 @@ PE_NAME opt_pmu_config
 		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 			char *name = pmu->name;
 
+			if (parse_events__filter_pmu(parse_state, pmu))
+				continue;
+
 			if (!strncmp(name, "uncore_", 7) &&
 			    strncmp($1, "uncore_", 7))
 				name += 7;
@@ -473,13 +476,12 @@ event_legacy_cache:
 PE_LEGACY_CACHE opt_event_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
 	struct list_head *list;
 	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, error, $2);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
 
 	parse_events_terms__delete($2);
 	free($1);
-- 
2.40.1.495.gc816e09b53d-goog

