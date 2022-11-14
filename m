Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC789628B19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiKNVJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiKNVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:09:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0BD53
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:09:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36810cfa61fso115082497b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti+JlRPlvf29szNKHd8D87Ic6A2ZX1BqgklOcnqMgNY=;
        b=blPMmbozMTkHt9hp+lIjTvLkVtmuKQN72BdaX1ZrrC4/mqEMliU4ct4X4K0d2HE6Wb
         RZ8KZo+3fKrtkWvRvBmKO7BKz6UvRefkUq4Ug06Za2uyaavxbPbL3zItrcRTugkT5RrA
         VIiISazbCGrzbB+tK4hGwH3p5VnH9qu6C5lM4EZBboTmB/ppKHRNg4dprTe2pUx54akA
         BOWSMWMYM3HGlF4BE7wrOAz+ELlzzj0xXOpgJszbkdTwk7I78JGRZE3VoeLPk8/u4+YZ
         206IgQip3UhQVm7TCrVlnJsURVzINvFdsxb2V8WuvMT/I4hCezRUF80KDcjhFEB9Xonn
         qiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti+JlRPlvf29szNKHd8D87Ic6A2ZX1BqgklOcnqMgNY=;
        b=FS6zkAqw6Yr6MMSOI1vEjq/FOliiIfwA+PK1lDnCFlNV8iBf0vhJMtrXxE3JKgXJqj
         a6dhuiCzPa/ufqiq82jYpOHAqLCYq4S5DvSlNkN2vqYT1FdGwOhet+I2sWvLJeM8JXe7
         HGgOELyuQEoPp3F6UMJ3j04/JOxVaUAqk6PIyUvL9Yur1N3hEGUFewSRflDRsuvLjeQG
         gVgfwtxK5km2FxeBpgHvexmdumdtpzNpjSiuJ5wwWjmoxIHbojaTYAS4vkGgxqI7r32/
         5a13OEoZOu7btaOTccWrpHZ6dUPo+YEEDe87cta3SBTqyveqqcYCI2DcUP28ir5EIUxb
         2U2A==
X-Gm-Message-State: ANoB5pnkq5B3hEhVU5GUYJKha2XnezMcwkm4r96Wme8jvC3pAGCtitjy
        iYy4GD0Oib79mWGsbsG+QbTrfK29tiJO
X-Google-Smtp-Source: AA0mqf6tpHdLVL6fg0kfeQlp8XGR7lcAkLnW8b5mo33GijlwCBB5nOQY6JEbarY2fvIRa5O7AsAs+9xZYaWx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a25:e812:0:b0:679:6725:3e2c with SMTP id
 k18-20020a25e812000000b0067967253e2cmr13188809ybd.425.1668460140801; Mon, 14
 Nov 2022 13:09:00 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:21 -0800
In-Reply-To: <20221114210723.2749751-1-irogers@google.com>
Message-Id: <20221114210723.2749751-9-irogers@google.com>
Mime-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 08/10] perf pmu: Restructure print_pmu_events
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously print_pmu_events would compute the values to be printed,
place them in struct sevent, sort them and then print them. Modify the
code so that struct sevent holds just the PMU and event, sort these
and then in the main print loop calculate aliases for names, etc. This
avoids memory allocations for copied values as they are computed then
printed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 208 ++++++++++++++++++++++--------------------
 1 file changed, 110 insertions(+), 98 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e6790175307b..075c82dd1347 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1553,8 +1553,8 @@ static int sub_non_neg(int a, int b)
 	return a - b;
 }
 
-static char *format_alias(char *buf, int len, struct perf_pmu *pmu,
-			  struct perf_pmu_alias *alias)
+static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
+			  const struct perf_pmu_alias *alias)
 {
 	struct parse_events_term *term;
 	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
@@ -1579,51 +1579,67 @@ static char *format_alias(char *buf, int len, struct perf_pmu *pmu,
 	return buf;
 }
 
-static char *format_alias_or(char *buf, int len, struct perf_pmu *pmu,
-			     struct perf_pmu_alias *alias)
+static char *format_alias_or(char *buf, int len, const struct perf_pmu *pmu,
+			     const struct perf_pmu_alias *alias)
 {
 	snprintf(buf, len, "%s OR %s/%s/", alias->name, pmu->name, alias->name);
 	return buf;
 }
 
+/** Struct for ordering events as output in perf list. */
 struct sevent {
-	char *name;
-	char *desc;
-	char *topic;
-	char *str;
-	char *pmu;
-	char *metric_expr;
-	char *metric_name;
-	int is_cpu;
+	/** PMU for event. */
+	const struct perf_pmu *pmu;
+	/**
+	 * Optional event for name, desc, etc. If not present then this is a
+	 * selectable PMU and the event name is shown as "//".
+	 */
+	const struct perf_pmu_alias *event;
+	/** Is the PMU for the CPU? */
+	bool is_cpu;
 };
 
 static int cmp_sevent(const void *a, const void *b)
 {
 	const struct sevent *as = a;
 	const struct sevent *bs = b;
+	const char *a_pmu_name, *b_pmu_name;
+	const char *a_name = "//", *a_desc = NULL, *a_topic = "";
+	const char *b_name = "//", *b_desc = NULL, *b_topic = "";
 	int ret;
 
-	/* Put extra events last */
-	if (!!as->desc != !!bs->desc)
-		return !!as->desc - !!bs->desc;
-	if (as->topic && bs->topic) {
-		int n = strcmp(as->topic, bs->topic);
-
-		if (n)
-			return n;
+	if (as->event) {
+		a_name = as->event->name;
+		a_desc = as->event->desc;
+		a_topic = as->event->topic ?: "";
 	}
+	if (bs->event) {
+		b_name = bs->event->name;
+		b_desc = bs->event->desc;
+		b_topic = bs->event->topic ?: "";
+	}
+	/* Put extra events last. */
+	if (!!a_desc != !!b_desc)
+		return !!a_desc - !!b_desc;
+
+	/* Order by topics. */
+	ret = strcmp(a_topic, b_topic);
+	if (ret)
+		return ret;
 
 	/* Order CPU core events to be first */
 	if (as->is_cpu != bs->is_cpu)
 		return bs->is_cpu - as->is_cpu;
 
-	ret = strcmp(as->name, bs->name);
-	if (!ret) {
-		if (as->pmu && bs->pmu)
-			return strcmp(as->pmu, bs->pmu);
-	}
+	/* Order by PMU name. */
+	a_pmu_name = as->pmu->name ?: "";
+	b_pmu_name = bs->pmu->name ?: "";
+	ret = strcmp(a_pmu_name, b_pmu_name);
+	if (ret)
+		return ret;
 
-	return ret;
+	/* Order by event name. */
+	return strcmp(a_name, b_name);
 }
 
 static void wordwrap(char *s, int start, int max, int corr)
@@ -1655,16 +1671,18 @@ bool is_pmu_core(const char *name)
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
 				   struct sevent *alias_b)
 {
-	/* Different names -> never duplicates */
-	if (strcmp(alias_a->name, alias_b->name))
-		return false;
+	const char *a_pmu_name, *b_pmu_name;
+	const char *a_name = alias_a->event ? alias_a->event->name : "//";
+	const char *b_name = alias_b->event ? alias_b->event->name : "//";
 
-	/* Don't remove duplicates for hybrid PMUs */
-	if (perf_pmu__is_hybrid(alias_a->pmu) &&
-	    perf_pmu__is_hybrid(alias_b->pmu))
+	/* Different names -> never duplicates */
+	if (strcmp(a_name, b_name))
 		return false;
 
-	return true;
+	/* Don't remove duplicates for different PMUs */
+	a_pmu_name = alias_a->pmu->name ?: "";
+	b_pmu_name = alias_b->pmu->name ?: "";
+	return strcmp(a_pmu_name, b_pmu_name) == 0;
 }
 
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
@@ -1690,110 +1708,104 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			len++;
 	}
 	aliases = zalloc(sizeof(struct sevent) * len);
-	if (!aliases)
-		goto out_enomem;
+	if (!aliases) {
+		pr_err("FATAL: not enough memory to print PMU events\n");
+		return;
+	}
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		bool is_cpu;
+
 		if (pmu_name && pmu->name && strcmp(pmu_name, pmu->name))
 			continue;
 
-		list_for_each_entry(alias, &pmu->aliases, list) {
-			char *name = alias->desc ? alias->name :
-				format_alias(buf, sizeof(buf), pmu, alias);
-			bool is_cpu = is_pmu_core(pmu->name) ||
-				      perf_pmu__is_hybrid(pmu->name);
+		is_cpu = is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
 
+		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (alias->deprecated && !deprecated)
 				continue;
 
 			if (event_glob != NULL &&
-			    !(strglobmatch_nocase(name, event_glob) ||
-			      (!is_cpu && strglobmatch_nocase(alias->name,
-						       event_glob)) ||
+			    !(strglobmatch_nocase(alias->name, event_glob) ||
+			      (!is_cpu &&
+			       strglobmatch_nocase(alias->name, event_glob)) ||
 			      (alias->topic &&
 			       strglobmatch_nocase(alias->topic, event_glob))))
 				continue;
 
-			if (is_cpu && !name_only && !alias->desc)
-				name = format_alias_or(buf, sizeof(buf), pmu, alias);
-
-			aliases[j].name = name;
-			if (is_cpu && !name_only && !alias->desc)
-				aliases[j].name = format_alias_or(buf,
-								  sizeof(buf),
-								  pmu, alias);
-			aliases[j].name = strdup(aliases[j].name);
-			if (!aliases[j].name)
-				goto out_enomem;
-
-			aliases[j].desc = long_desc ? alias->long_desc :
-						alias->desc;
-			aliases[j].topic = alias->topic;
-			aliases[j].str = alias->str;
-			aliases[j].pmu = pmu->name;
-			aliases[j].metric_expr = alias->metric_expr;
-			aliases[j].metric_name = alias->metric_name;
+			aliases[j].event = alias;
+			aliases[j].pmu = pmu;
 			aliases[j].is_cpu = is_cpu;
 			j++;
 		}
 		if (pmu->selectable &&
 		    (event_glob == NULL || strglobmatch(pmu->name, event_glob))) {
-			char *s;
-			if (asprintf(&s, "%s//", pmu->name) < 0)
-				goto out_enomem;
-			aliases[j].name = s;
+			aliases[j].event = NULL;
+			aliases[j].pmu = pmu;
+			aliases[j].is_cpu = is_cpu;
 			j++;
 		}
 	}
 	len = j;
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (j = 0; j < len; j++) {
+		char *name, *desc;
+
 		/* Skip duplicates */
 		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
 			continue;
 
+		if (!aliases[j].event) {
+			/* A selectable event. */
+			snprintf(buf, sizeof(buf), "%s//", aliases[j].pmu->name);
+			name = buf;
+		} else if (aliases[j].event->desc) {
+			name = aliases[j].event->name;
+		} else {
+			if (!name_only && aliases[j].is_cpu) {
+				name = format_alias_or(buf, sizeof(buf), aliases[j].pmu,
+						       aliases[j].event);
+			} else {
+				name = format_alias(buf, sizeof(buf), aliases[j].pmu,
+						    aliases[j].event);
+			}
+		}
 		if (name_only) {
-			printf("%s ", aliases[j].name);
+			printf("%s ", name);
 			continue;
 		}
-		if (aliases[j].desc && !quiet_flag) {
-			if (numdesc++ == 0)
-				printf("\n");
-			if (aliases[j].topic && (!topic ||
-					strcmp(topic, aliases[j].topic))) {
-				printf("%s%s:\n", topic ? "\n" : "",
-						aliases[j].topic);
-				topic = aliases[j].topic;
-			}
-			printf("  %-50s\n", aliases[j].name);
-			printf("%*s", 8, "[");
-			wordwrap(aliases[j].desc, 8, columns, 0);
-			printf("]\n");
-			if (details_flag) {
-				printf("%*s%s/%s/ ", 8, "", aliases[j].pmu, aliases[j].str);
-				if (aliases[j].metric_name)
-					printf(" MetricName: %s", aliases[j].metric_name);
-				if (aliases[j].metric_expr)
-					printf(" MetricExpr: %s", aliases[j].metric_expr);
-				putchar('\n');
-			}
-		} else
-			printf("  %-50s [Kernel PMU event]\n", aliases[j].name);
 		printed++;
+		if (!aliases[j].event || !aliases[j].event->desc || quiet_flag) {
+			printf("  %-50s [Kernel PMU event]\n", name);
+			continue;
+		}
+		if (numdesc++ == 0)
+			printf("\n");
+		if (aliases[j].event->topic && (!topic ||
+						strcmp(topic, aliases[j].event->topic))) {
+			printf("%s%s:\n", topic ? "\n" : "", aliases[j].event->topic);
+			topic = aliases[j].event->topic;
+		}
+		printf("  %-50s\n", name);
+		printf("%*s", 8, "[");
+		desc = long_desc ? aliases[j].event->long_desc : aliases[j].event->desc;
+		wordwrap(desc, 8, columns, 0);
+		printf("]\n");
+		if (details_flag) {
+			printf("%*s%s/%s/ ", 8, "", aliases[j].pmu->name, aliases[j].event->str);
+			if (aliases[j].event->metric_name)
+				printf(" MetricName: %s", aliases[j].event->metric_name);
+			if (aliases[j].event->metric_expr)
+				printf(" MetricExpr: %s", aliases[j].event->metric_expr);
+			putchar('\n');
+		}
 	}
 	if (printed && pager_in_use())
 		printf("\n");
-out_free:
-	for (j = 0; j < len; j++)
-		zfree(&aliases[j].name);
+
 	zfree(&aliases);
 	return;
-
-out_enomem:
-	printf("FATAL: not enough memory to print PMU events\n");
-	if (aliases)
-		goto out_free;
 }
 
 bool pmu_have_event(const char *pname, const char *name)
-- 
2.38.1.431.g37b22c650d-goog

