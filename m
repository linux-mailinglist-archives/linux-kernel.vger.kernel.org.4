Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561646276C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiKNHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiKNHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:52:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2449192B9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:52:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o2-20020a5b0502000000b006cade5e7c07so9898813ybp.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTIHSMroaHgB/iMQ3IvinP/fljLnemrJKwp3rOoSeAs=;
        b=KyT0SnrmMbJyp+ALYoXvpui2u47FKZCPPFG7HcEtUJ1he5eLAItPfBQsWEVZsFkY76
         l2TprOg3tRYYUfBjZP5ZkKy5GX0NWMaY0kcrRbhQeV3cJj1hJOoCAM7EemXdcb5oPEFI
         d5LaFIVgHZEB7B50W8Xfy70975gh9A5v0+MVr8FGe6I49yC9Kg0zuEvF8ihnwgcKSOnH
         rvvLiWfSpNwU30/wx/rQu3X2/O6Xv6oEkpS6uqidjJjA2TQHOHLI2LyWiu3+bndSTMYA
         VqErpCGGC8W1RKFPpZs2F2Xg/jcXeVFLUzIliNRMqVnDKHVJacWgc9UfhNyHl5N0zW7U
         OCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTIHSMroaHgB/iMQ3IvinP/fljLnemrJKwp3rOoSeAs=;
        b=ZX8eL+YplZK+Zwd1UlsSulI+T36+kmYT4JC6Qf2Sl60KeKBioKR4/G/rA6zjZvbRDQ
         BSXQ2wfUyR0dEXi5MP6LrxiQVBaHWVZ3iF/1+QzSC+fvGRxrRJ7tFNAs0Rssj3DvGLg4
         bKNgYSqAklfPZdPosRbsRXCIQpn/MHruNoar1UUnN8PPxXQMdH6X23ls5GRLAz0riI/N
         Mp95meXXtQlfKDWyAVdgc6z1a8KjiZhrc0UpswELBW6hJ5t6pdwppQ3P5+j+XWqJ1jci
         o8U7utpy4Kbi6WXNV0TTWS6/GvWTJJ/RDXwKtjJ/iC1SGKeaTMSc0T3SgTRk5wQ4nOc2
         asMg==
X-Gm-Message-State: ACrzQf2HzfoCHGkRtvn6wmBbBbYExIv4E0HTA0fA5Ma8cv+Uiapsq3MR
        7T+Img0G0ie6IHmK0xY/AQh/a25hlPfF
X-Google-Smtp-Source: AMsMyM6TYmzNp2OlYaFfBsiynO+dL9+o7Ih96UUHiQMM/dSOWBICoqYQNmv7aKAa8/+RtfEXaFgDP53sfvHh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP
 id g18-20020a056902135200b006bb3f4b9666mr61574188ybu.101.1668412374640; Sun,
 13 Nov 2022 23:52:54 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:25 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-8-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 7/9] perf pmu: Restructure print_pmu_events
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 9c771f136b81..8322395c9cf7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1552,8 +1552,8 @@ static int sub_non_neg(int a, int b)
 	return a - b;
 }
 
-static char *format_alias(char *buf, int len, struct perf_pmu *pmu,
-			  struct perf_pmu_alias *alias)
+static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
+			  const struct perf_pmu_alias *alias)
 {
 	struct parse_events_term *term;
 	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
@@ -1578,51 +1578,67 @@ static char *format_alias(char *buf, int len, struct perf_pmu *pmu,
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
@@ -1654,16 +1670,18 @@ bool is_pmu_core(const char *name)
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
@@ -1689,110 +1707,104 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
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
+		is_cpu = is_pmu_core(pmu->name) || pmu->is_hybrid;
 
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

