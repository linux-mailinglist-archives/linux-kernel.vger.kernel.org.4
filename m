Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185276F12AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjD1HoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbjD1Hnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:43:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7BE5FD9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:42:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso1859568276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667728; x=1685259728;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtvZcWesW8Mm8rvH5HZ5XKI28WhNCgFXQkrV9l3sIAI=;
        b=BrLkYSwCSfUmKbI6B/AfT2HWhBTzYowcZlHhH2xqjrdwsGm8J2xmafRi37pBVszUQ7
         6OTN+N6vs1/TvCbv86pCjrXF+O3AdodXuXzBY/jdiX8K//K/102fzVDiVheW3/BBPVbs
         glZs5YFCZQ5OyTwDNtMSsA1MkvO/GJ9a2bI0pxYgPeyWL2+iv6Q7N2vJPsDYwbbx3pP5
         MPEVDytkhKVFDJyzxZg40nOzFJz4I1E+S8TNCTVr+RZxG0bVJUDk5blbpOCL1vqE5lH+
         FVr5bAkkMVHRQjzhHqxyJt1ELZo/7x/xn+sagF1HM8ALtrvGw2M/FJpSPV3m5hHojNlO
         IqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667728; x=1685259728;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtvZcWesW8Mm8rvH5HZ5XKI28WhNCgFXQkrV9l3sIAI=;
        b=SnQaWO40KX9KdbX3NqcDznQLSthtYO8FgwLixK8qiyO7uo1Fgq9gKESGnv2MAUS2XP
         BB8DwoC8N9sRS8bIXlW/lcwTW+84etPqCOKu5yQ8rkL/GnQqMVxEC839xQ/LngLt8FPd
         9I9WuP9FnPliOAPacS3ZBmXOeRvdPOgfNcg4sEH79aKb+OUZ1ov7nA8UyprrQQyni2/7
         lA/Nu7gN9H9I02Zs5WNN/sfM/QeXHIL+7EcehCvuC9TbQa3htwfzh8g2i1FGtcUSxo+r
         Fm7IIT4AWXGRVSaLvpqRLMhVFwtBwsYnqyKaOoXDmmXY98IYD8MhrveyqqNvcfn4Ya14
         0Q6A==
X-Gm-Message-State: AC+VfDwNJo3NTHjdfGEneODo37Yk/1AXCg95GjmiVmBMzPg0cncB7MqP
        cIm7rdNVvRNOHRU71V4238MMFQTyuCud
X-Google-Smtp-Source: ACHHUZ5oX85r+qrjtw47GQpfj+cDPrLcfmUeOsIIrMDslToxio9pZtjURd1cBW+v90U9hLWgsDQLMZH2XWLX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:6902:72d:b0:b6c:2d28:b3e7 with SMTP id
 l13-20020a056902072d00b00b6c2d28b3e7mr2598000ybt.9.1682667728085; Fri, 28 Apr
 2023 00:42:08 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:52 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-27-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 26/43] perf parse-events: Remove now unused hybrid logic
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

The event parser no longer needs to recurse in case of a legacy cache
event in a PMU, the necessary wild card logic has moved to
perf_pmu__supports_legacy_cache and
perf_pmu__supports_wildcard_numeric.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build                 |   1 -
 tools/perf/util/parse-events-hybrid.c | 181 --------------------------
 tools/perf/util/parse-events-hybrid.h |  18 ---
 tools/perf/util/parse-events.c        |  74 -----------
 tools/perf/util/parse-events.h        |   8 --
 5 files changed, 282 deletions(-)
 delete mode 100644 tools/perf/util/parse-events-hybrid.c
 delete mode 100644 tools/perf/util/parse-events-hybrid.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index bd18fe5f2719..c146736ead19 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -24,7 +24,6 @@ perf-y += llvm-utils.o
 perf-y += mmap.o
 perf-y += memswap.o
 perf-y += parse-events.o
-perf-y += parse-events-hybrid.o
 perf-y += print-events.o
 perf-y += tracepoint.o
 perf-y += perf_regs.o
diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
deleted file mode 100644
index d2c0be051d46..000000000000
--- a/tools/perf/util/parse-events-hybrid.c
+++ /dev/null
@@ -1,181 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/err.h>
-#include <linux/zalloc.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/param.h>
-#include "evlist.h"
-#include "evsel.h"
-#include "parse-events.h"
-#include "parse-events-hybrid.h"
-#include "debug.h"
-#include "pmu.h"
-#include "pmu-hybrid.h"
-#include "perf.h"
-
-static void config_hybrid_attr(struct perf_event_attr *attr,
-			       int type, int pmu_type)
-{
-	/*
-	 * attr.config layout for type PERF_TYPE_HARDWARE and
-	 * PERF_TYPE_HW_CACHE
-	 *
-	 * PERF_TYPE_HARDWARE:                 0xEEEEEEEE000000AA
-	 *                                     AA: hardware event ID
-	 *                                     EEEEEEEE: PMU type ID
-	 * PERF_TYPE_HW_CACHE:                 0xEEEEEEEE00DDCCBB
-	 *                                     BB: hardware cache ID
-	 *                                     CC: hardware cache op ID
-	 *                                     DD: hardware cache op result ID
-	 *                                     EEEEEEEE: PMU type ID
-	 * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
-	 */
-	attr->type = type;
-	attr->config = (attr->config & PERF_HW_EVENT_MASK) |
-			((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
-}
-
-static int create_event_hybrid(__u32 config_type, int *idx,
-			       struct list_head *list,
-			       struct perf_event_attr *attr, const char *name,
-			       const char *metric_id,
-			       struct list_head *config_terms,
-			       struct perf_pmu *pmu)
-{
-	struct evsel *evsel;
-	__u32 type = attr->type;
-	__u64 config = attr->config;
-
-	config_hybrid_attr(attr, config_type, pmu->type);
-
-	/*
-	 * Some hybrid hardware cache events are only available on one CPU
-	 * PMU. For example, the 'L1-dcache-load-misses' is only available
-	 * on cpu_core, while the 'L1-icache-loads' is only available on
-	 * cpu_atom. We need to remove "not supported" hybrid cache events.
-	 */
-	if (attr->type == PERF_TYPE_HW_CACHE
-	    && !is_event_supported(attr->type, attr->config))
-		return 0;
-
-	evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
-					       pmu, config_terms);
-	if (evsel) {
-		evsel->pmu_name = strdup(pmu->name);
-		if (!evsel->pmu_name)
-			return -ENOMEM;
-	} else
-		return -ENOMEM;
-	attr->type = type;
-	attr->config = config;
-	return 0;
-}
-
-static int pmu_cmp(struct parse_events_state *parse_state,
-		   struct perf_pmu *pmu)
-{
-	if (parse_state->evlist && parse_state->evlist->hybrid_pmu_name)
-		return strcmp(parse_state->evlist->hybrid_pmu_name, pmu->name);
-
-	if (parse_state->hybrid_pmu_name)
-		return strcmp(parse_state->hybrid_pmu_name, pmu->name);
-
-	return 0;
-}
-
-static int add_hw_hybrid(struct parse_events_state *parse_state,
-			 struct list_head *list, struct perf_event_attr *attr,
-			 const char *name, const char *metric_id,
-			 struct list_head *config_terms)
-{
-	struct perf_pmu *pmu;
-	int ret;
-
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		LIST_HEAD(terms);
-
-		if (pmu_cmp(parse_state, pmu))
-			continue;
-
-		copy_config_terms(&terms, config_terms);
-		ret = create_event_hybrid(PERF_TYPE_HARDWARE,
-					  &parse_state->idx, list, attr, name,
-					  metric_id, &terms, pmu);
-		free_config_terms(&terms);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int create_raw_event_hybrid(int *idx, struct list_head *list,
-				   struct perf_event_attr *attr,
-				   const char *name,
-				   const char *metric_id,
-				   struct list_head *config_terms,
-				   struct perf_pmu *pmu)
-{
-	struct evsel *evsel;
-
-	attr->type = pmu->type;
-	evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
-					       pmu, config_terms);
-	if (evsel)
-		evsel->pmu_name = strdup(pmu->name);
-	else
-		return -ENOMEM;
-
-	return 0;
-}
-
-static int add_raw_hybrid(struct parse_events_state *parse_state,
-			  struct list_head *list, struct perf_event_attr *attr,
-			  const char *name, const char *metric_id,
-			  struct list_head *config_terms)
-{
-	struct perf_pmu *pmu;
-	int ret;
-
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		LIST_HEAD(terms);
-
-		if (pmu_cmp(parse_state, pmu))
-			continue;
-
-		copy_config_terms(&terms, config_terms);
-		ret = create_raw_event_hybrid(&parse_state->idx, list, attr,
-					      name, metric_id, &terms, pmu);
-		free_config_terms(&terms);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
-				     struct list_head *list,
-				     struct perf_event_attr *attr,
-				     const char *name, const char *metric_id,
-				     struct list_head *config_terms,
-				     bool *hybrid)
-{
-	*hybrid = false;
-	if (attr->type == PERF_TYPE_SOFTWARE)
-		return 0;
-
-	if (!perf_pmu__has_hybrid())
-		return 0;
-
-	*hybrid = true;
-	if (attr->type != PERF_TYPE_RAW) {
-		return add_hw_hybrid(parse_state, list, attr, name, metric_id,
-				     config_terms);
-	}
-
-	return add_raw_hybrid(parse_state, list, attr, name, metric_id,
-			      config_terms);
-}
diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
deleted file mode 100644
index bc2966e73897..000000000000
--- a/tools/perf/util/parse-events-hybrid.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_PARSE_EVENTS_HYBRID_H
-#define __PERF_PARSE_EVENTS_HYBRID_H
-
-#include <linux/list.h>
-#include <stdbool.h>
-#include <linux/types.h>
-#include <linux/perf_event.h>
-#include <string.h>
-
-int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
-				     struct list_head *list,
-				     struct perf_event_attr *attr,
-				     const char *name, const char *metric_id,
-				     struct list_head *config_terms,
-				     bool *hybrid);
-
-#endif /* __PERF_PARSE_EVENTS_HYBRID_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e9515e46a140..c8484fa63696 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -25,7 +25,6 @@
 #include "util/parse-branch-options.h"
 #include "util/evsel_config.h"
 #include "util/event.h"
-#include "util/pmu-hybrid.h"
 #include "util/bpf-filter.h"
 #include "util/util.h"
 #include "tracepoint.h"
@@ -39,9 +38,6 @@ extern int parse_events_debug;
 int parse_events_parse(void *parse_state, void *scanner);
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused);
-static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
-					 const char *str, char *pmu_name,
-					 struct list_head *list);
 
 struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -1526,33 +1522,6 @@ static bool config_term_percore(struct list_head *config_terms)
 	return false;
 }
 
-static int parse_events__inside_hybrid_pmu(struct parse_events_state *parse_state,
-					   struct list_head *list, char *name,
-					   struct list_head *head_config)
-{
-	struct parse_events_term *term;
-	int ret = -1;
-
-	if (parse_state->fake_pmu || !head_config || list_empty(head_config) ||
-	    !perf_pmu__is_hybrid(name)) {
-		return -1;
-	}
-
-	/*
-	 * More than one term in list.
-	 */
-	if (head_config->next && head_config->next->next != head_config)
-		return -1;
-
-	term = list_first_entry(head_config, struct parse_events_term, list);
-	if (term && term->config && strcmp(term->config, "event")) {
-		ret = parse_events__with_hybrid_pmu(parse_state, term->config,
-						    name, list);
-	}
-
-	return ret;
-}
-
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
@@ -1642,11 +1611,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
 		return -ENOMEM;
 
-	if (!parse_events__inside_hybrid_pmu(parse_state, list, name,
-					     head_config)) {
-		return 0;
-	}
-
 	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
 		free_config_terms(&config_terms);
 		return -EINVAL;
@@ -2023,32 +1987,6 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	return ret;
 }
 
-static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
-					 const char *str, char *pmu_name,
-					 struct list_head *list)
-{
-	struct parse_events_state ps = {
-		.list            = LIST_HEAD_INIT(ps.list),
-		.stoken          = PE_START_EVENTS,
-		.hybrid_pmu_name = pmu_name,
-		.idx             = parse_state->idx,
-	};
-	int ret;
-
-	ret = parse_events__scanner(str, &ps);
-
-	if (!ret) {
-		if (!list_empty(&ps.list)) {
-			list_splice(&ps.list, list);
-			parse_state->idx = ps.idx;
-			return 0;
-		} else
-			return -1;
-	}
-
-	return ret;
-}
-
 __weak int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
 	/* Order by insertion index. */
@@ -2772,15 +2710,3 @@ char *parse_events_formats_error_string(char *additional_terms)
 fail:
 	return NULL;
 }
-
-struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
-					     struct perf_event_attr *attr,
-					     const char *name,
-					     const char *metric_id,
-					     struct perf_pmu *pmu,
-					     struct list_head *config_terms)
-{
-	return __add_event(list, idx, attr, /*init_attr=*/true, name, metric_id,
-			   pmu, config_terms, /*auto_merge_stats=*/false,
-			   /*cpu_list=*/NULL);
-}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 831cd1ff4702..77b8f7efdb94 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -122,7 +122,6 @@ struct parse_events_state {
 	struct list_head	  *terms;
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
-	char			  *hybrid_pmu_name;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
 	bool			   match_legacy_cache_terms;
 	bool			   wild_card_pmus;
@@ -235,11 +234,4 @@ static inline bool is_sdt_event(char *str __maybe_unused)
 }
 #endif /* HAVE_LIBELF_SUPPORT */
 
-struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
-					     struct perf_event_attr *attr,
-					     const char *name,
-					     const char *metric_id,
-					     struct perf_pmu *pmu,
-					     struct list_head *config_terms);
-
 #endif /* __PERF_PARSE_EVENTS_H */
-- 
2.40.1.495.gc816e09b53d-goog

