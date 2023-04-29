Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97B6F2333
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347448AbjD2FmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347474AbjD2Fls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:41:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCEA5589
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:41:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso16041278276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746812; x=1685338812;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNrenPg5Auuyv67oJobHQmmBO8s0NbAF7ULzoFM6URI=;
        b=sUOrXBrtA/ndtFBUEcmf1/Fc3lLAcx/kjhWFHZ6zsw4FXx7AZ79fHeJPMjq0Li453N
         OPpnCQ+x2cAcjuTCnuSWLJRo2mBDu10G2Px7uzcPPwiBptlIVCoQfk7qc8q1V7S/xPyk
         ed9YAMP+pi0jeoh44muDaGsz6SCr1sUer64j9qhE/y3AJ6Dy6B771F5OLpupw866WbDG
         cigKOlBT8IYfsUye0V+R8+4qNIWlzjThOUHCIYTfllex5JggexMLw8dLxOmBjsVZ9BIV
         9O06LJOjygO3tWmxiaEaamrvOtq6pAkDnk2VDChRT9tLkHoSBq4mlrAVnuTJ0y7xd2dn
         94bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746812; x=1685338812;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNrenPg5Auuyv67oJobHQmmBO8s0NbAF7ULzoFM6URI=;
        b=kWGzhpJUZ/p/59c8VtSi4rNcAI6n+d0BCv/4L8SP+nQ+1OoiNZ7Tfjnp6oaQNLcc7d
         S+E9uUNLNwV12UbjEEu4X3Rgv31fiAeULodAOnUaQynRYhEAHKE7hNy8bsRl/0n32+FD
         h0nQD2SI3c25zLlODRLwciDEPs7mZZHnewjnJ5EZULGvSMsnslc+sFNjzIMitLvO2Tdm
         W3m3eMbXpLe/12SClYa/pWp2A3cZ261XPL2xisUwkneOkArGsG8eR0puU/0gle1jLgoj
         Xu6jMfxdOdiLhh4KFx4B2/6nZU6khgEL29UwiHQ5ZRdLq+mqmDmbK8d/zOT21QrlZEAC
         0h7A==
X-Gm-Message-State: AC+VfDyRzqefQyrl0L2Wkk4V+3bColpTR4EJ40am0bsuHY+WbC8d/cRU
        PEiktiJb8DKi/IO92IKfBdh+8hBMOrB1
X-Google-Smtp-Source: ACHHUZ6K+RPzPopDU4vtogrxzrJUR3ecc6bWccZie/wIexXmzW1AFH7XyehdOqIL7dN+qsTZgSqm1BIM19s9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a25:8252:0:b0:b96:3383:3585 with SMTP id
 d18-20020a258252000000b00b9633833585mr7367422ybn.4.1682746811884; Fri, 28 Apr
 2023 22:40:11 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:55 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-36-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 35/46] perf parse-events: Support hardware events as terms
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

An event like "cpu/instructions/" typically parses due to there being
a sysfs event called instructions. On hybrid recursive parsing means
that the hardware event is encoded in the attribute, with the PMU
being placed in the high bits of the config:

'''
$ perf stat -vv -e 'cpu_core/cycles/' true
...
------------------------------------------------------------
perf_event_attr:
  size                             136
  config                           0x400000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
'''

Make this behavior the default by adding a new term type and token for
hardware events. The token gathers both the numeric config and the
parsed name, so that if the token appears like "cycles/name=cycles/"
then the token can be handled like a name. The numeric value isn't
sufficient to distinguish say "cpu-cycles" from "cycles".

Extend the parse-events test so that all current non-PMU hardware
parsing tests, also test with the PMU cpu - more than half the change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 126 ++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.c  |  37 +++-------
 tools/perf/util/parse-events.h  |   3 +-
 tools/perf/util/parse-events.l  |  20 +++++
 tools/perf/util/parse-events.y  |  34 +++++++--
 5 files changed, 187 insertions(+), 33 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index e507b6d40099..49166d51c0a1 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1912,6 +1912,132 @@ static const struct evlist_test test__events_pmu[] = {
 		.check = test__checkevent_config_cache,
 		/* 8 */
 	},
+	{
+		.name  = "cpu/instructions/",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_symbolic_name,
+		/* 9 */
+	},
+	{
+		.name  = "cpu/cycles,period=100000,config2/",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_symbolic_name_config,
+		/* 0 */
+	},
+	{
+		.name  = "cpu/instructions/h",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_symbolic_name_modifier,
+		/* 1 */
+	},
+	{
+		.name  = "cpu/instructions/G",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_exclude_host_modifier,
+		/* 2 */
+	},
+	{
+		.name  = "cpu/instructions/H",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_exclude_guest_modifier,
+		/* 3 */
+	},
+	{
+		.name  = "{cpu/instructions/k,cpu/cycles/upp}",
+		.valid = test__pmu_cpu_valid,
+		.check = test__group1,
+		/* 4 */
+	},
+	{
+		.name  = "{cpu/cycles/u,cpu/instructions/kp}:p",
+		.valid = test__pmu_cpu_valid,
+		.check = test__group4,
+		/* 5 */
+	},
+	{
+		.name  = "{cpu/cycles/,cpu/cache-misses/G}:H",
+		.valid = test__pmu_cpu_valid,
+		.check = test__group_gh1,
+		/* 6 */
+	},
+	{
+		.name  = "{cpu/cycles/,cpu/cache-misses/H}:G",
+		.valid = test__pmu_cpu_valid,
+		.check = test__group_gh2,
+		/* 7 */
+	},
+	{
+		.name  = "{cpu/cycles/G,cpu/cache-misses/H}:u",
+		.valid = test__pmu_cpu_valid,
+		.check = test__group_gh3,
+		/* 8 */
+	},
+	{
+		.name  = "{cpu/cycles/G,cpu/cache-misses/H}:uG",
+		.valid = test__pmu_cpu_valid,
+		.check = test__group_gh4,
+		/* 9 */
+	},
+	{
+		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:S",
+		.valid = test__pmu_cpu_valid,
+		.check = test__leader_sample1,
+		/* 0 */
+	},
+	{
+		.name  = "{cpu/instructions/,cpu/branch-misses/}:Su",
+		.valid = test__pmu_cpu_valid,
+		.check = test__leader_sample2,
+		/* 1 */
+	},
+	{
+		.name  = "cpu/instructions/uDp",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_pinned_modifier,
+		/* 2 */
+	},
+	{
+		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:D",
+		.valid = test__pmu_cpu_valid,
+		.check = test__pinned_group,
+		/* 3 */
+	},
+	{
+		.name  = "cpu/instructions/I",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_exclude_idle_modifier,
+		/* 4 */
+	},
+	{
+		.name  = "cpu/instructions/kIG",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_exclude_idle_modifier_1,
+		/* 5 */
+	},
+	{
+		.name  = "cpu/cycles/u",
+		.valid = test__pmu_cpu_valid,
+		.check = test__sym_event_slash,
+		/* 6 */
+	},
+	{
+		.name  = "cpu/cycles/k",
+		.valid = test__pmu_cpu_valid,
+		.check = test__sym_event_dc,
+		/* 7 */
+	},
+	{
+		.name  = "cpu/instructions/uep",
+		.valid = test__pmu_cpu_valid,
+		.check = test__checkevent_exclusive_modifier,
+		/* 8 */
+	},
+	{
+		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:e",
+		.valid = test__pmu_cpu_valid,
+		.check = test__exclusive_group,
+		/* 9 */
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d9d964bbc0e2..dea27bc0b376 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1052,6 +1052,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
 	[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 	[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
+	[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
 };
 
 static bool config_term_shrinked;
@@ -1239,6 +1240,17 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		} else
 			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
 	}
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_HARDWARE) {
+		const struct perf_pmu *pmu = perf_pmu__find_by_type(attr->type);
+
+		if (!pmu) {
+			pr_debug("Failed to find PMU for type %d", attr->type);
+			return -EINVAL;
+		}
+		attr->type = PERF_TYPE_HARDWARE;
+		attr->config = ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT) | term->val.num;
+		return 0;
+	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
 	    term->type_term == PARSE_EVENTS__TERM_TYPE_DRV_CFG) {
 		/*
@@ -2569,31 +2581,6 @@ int parse_events_term__str(struct parse_events_term **term,
 	return new_term(term, &temp, str, 0);
 }
 
-int parse_events_term__sym_hw(struct parse_events_term **term,
-			      char *config, unsigned idx)
-{
-	struct event_symbol *sym;
-	char *str;
-	struct parse_events_term temp = {
-		.type_val  = PARSE_EVENTS__TERM_TYPE_STR,
-		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
-		.config    = config,
-	};
-
-	if (!temp.config) {
-		temp.config = strdup("event");
-		if (!temp.config)
-			return -ENOMEM;
-	}
-	BUG_ON(idx >= PERF_COUNT_HW_MAX);
-	sym = &event_symbols_hw[idx];
-
-	str = strdup(sym->symbol);
-	if (!str)
-		return -ENOMEM;
-	return new_term(term, &temp, str, 0);
-}
-
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index d4cbda6e946a..7fe80b416143 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -79,6 +79,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
+	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
@@ -147,8 +148,6 @@ int parse_events_term__num(struct parse_events_term **term,
 int parse_events_term__str(struct parse_events_term **term,
 			   int type_term, char *config, char *str,
 			   void *loc_term, void *loc_val);
-int parse_events_term__sym_hw(struct parse_events_term **term,
-			      char *config, unsigned idx);
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term);
 void parse_events_term__delete(struct parse_events_term *term);
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index abe0ce681d29..6deb70c25984 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -149,6 +149,16 @@ static int term(yyscan_t scanner, int type)
 	return PE_TERM;
 }
 
+static int hw_term(yyscan_t scanner, int config)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
+
+	yylval->hardware_term.str = strdup(text);
+	yylval->hardware_term.num = PERF_TYPE_HARDWARE + config;
+	return PE_TERM_HW;
+}
+
 #define YY_USER_ACTION					\
 do {							\
 	yylloc->last_column  = yylloc->first_column;	\
@@ -269,6 +279,16 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
+stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
+stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
+instructions					{ return hw_term(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
+cache-references				{ return hw_term(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
+cache-misses					{ return hw_term(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
+branch-instructions|branches			{ return hw_term(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
+branch-misses					{ return hw_term(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
+bus-cycles					{ return hw_term(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
+ref-cycles					{ return hw_term(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
 r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 ,			{ return ','; }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index c95877cbd6cf..819a5123fd77 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -65,6 +65,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
+%token PE_TERM_HW
 %type <num> PE_VALUE
 %type <num> PE_VALUE_SYM_HW
 %type <num> PE_VALUE_SYM_SW
@@ -112,6 +113,8 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <array> array_term
 %type <array> array_terms
 %destructor { free ($$.ranges); } <array>
+%type <hardware_term> PE_TERM_HW
+%destructor { free ($$.str); } <hardware_term>
 
 %union
 {
@@ -125,6 +128,10 @@ static void free_list_evsel(struct list_head* list_evsel)
 		char *event;
 	} tracepoint_name;
 	struct parse_events_array array;
+	struct hardware_term {
+		char *str;
+		u64 num;
+	} hardware_term;
 }
 %%
 
@@ -770,13 +777,14 @@ name_or_raw '=' PE_VALUE
 	$$ = term;
 }
 |
-name_or_raw '=' PE_VALUE_SYM_HW
+name_or_raw '=' PE_TERM_HW
 {
 	struct parse_events_term *term;
-	int config = $3 & 255;
 
-	if (parse_events_term__sym_hw(&term, $1, config)) {
+	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $3.str, &@1, &@3)) {
 		free($1);
+		free($3.str);
 		YYABORT;
 	}
 	$$ = term;
@@ -806,12 +814,15 @@ PE_NAME
 	$$ = term;
 }
 |
-PE_VALUE_SYM_HW
+PE_TERM_HW
 {
 	struct parse_events_term *term;
-	int config = $1 & 255;
 
-	ABORT_ON(parse_events_term__sym_hw(&term, NULL, config));
+	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_HARDWARE,
+				   $1.str, $1.num & 255, false, &@1, NULL)) {
+		free($1.str);
+		YYABORT;
+	}
 	$$ = term;
 }
 |
@@ -826,6 +837,17 @@ PE_TERM '=' PE_NAME
 	$$ = term;
 }
 |
+PE_TERM '=' PE_TERM_HW
+{
+	struct parse_events_term *term;
+
+	if (parse_events_term__str(&term, (int)$1, NULL, $3.str, &@1, &@3)) {
+		free($3.str);
+		YYABORT;
+	}
+	$$ = term;
+}
+|
 PE_TERM '=' PE_VALUE
 {
 	struct parse_events_term *term;
-- 
2.40.1.495.gc816e09b53d-goog

