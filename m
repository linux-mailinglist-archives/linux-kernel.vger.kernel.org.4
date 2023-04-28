Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7B26F12A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345766AbjD1HnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345732AbjD1Hmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:42:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEDD59EB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:41:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7df507c5so2969002276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667698; x=1685259698;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rqf+4LZB3K5zbnutGN9kUI7oM4wotdfV0bKKNzUfXY=;
        b=jEOLk297rmL5t/Yp5ZAALjB2Q+OlkDUa2Q5eOfsUiMw6xc35e9U96Slb4UOlCmJDc2
         Jly+RQXZ8NR1YerLT3VFlmps7+YuUTMJmSV6hqv+H5wvUTPcigjdE6BTC9gIebcKzLOL
         qYR3xWmlm+unMN2lIi3jBWSjq1wKYw1wrOWmM4xfcfAe0wZ0M8K4hrkCoWpbfiI8y1kW
         qZUjhFJs0n9hf2SKi5pKlhAib+BvKqmDvVzDOfzQb0SFZaSboYoKJ5fb+Mdh/BkIlS8m
         1QSlF2AiItJI0gY33vLp4mQ9YuQ/kNKWKqnQtqzZEwpwPkdOFS8osu3ZAispWGLiws+X
         r7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667698; x=1685259698;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rqf+4LZB3K5zbnutGN9kUI7oM4wotdfV0bKKNzUfXY=;
        b=cj/uqnqMSFzgJSPjDw1UyAhLk8AITkvxSVrwCiRuQtenrF0MDqtkkyBEF69EUYhvuH
         9DDKPfHJvQHA7eddJPY4oT5bayYICOF4iSMqlt6LD8wAEfLkpmEheQCNB/LXQpC/2Vcv
         QS7CO6Rh+tk3ORGauKyGiesaHzz+4RvcFDPWeHjt+XvLyhP1Pg5rbE2TPnRKfNJj+1XL
         PqFrA/UERwtptGq7XeaniKGBBidrUjh7fIRW50nVX3OYyB5xvH9oL/ZyKIt3XH1FQM7J
         6jQaL/VYvq9a7077VQss9DzpoFqOlIssSqyXOOBT1qZulh2tmsOO4sxgxplxXzzOZjJR
         pK0Q==
X-Gm-Message-State: AC+VfDzPZjjJA7eF5XulmmN04Vibz6Y9ynHFTylm2EKKTMOZ+wPE1vsM
        qaShFbRXt5I8zVCHDOGSWqlEwclxZWXj
X-Google-Smtp-Source: ACHHUZ7DPmIYAAoZT9LN9diDwCsV/Hy/Y4vKadATYFKf2J4I47yk0c1wsbaopz+p4lONEvyTB28WJUum+CN7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:4884:0:b0:b9a:6a68:7c25 with SMTP id
 v126-20020a254884000000b00b9a6a687c25mr2506852yba.5.1682667698346; Fri, 28
 Apr 2023 00:41:38 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:49 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-24-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 23/43] perf parse-events: Wildcard legacy cache events
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

It is inconsistent that "perf stat -e instructions-retired" wildcard
opens on all PMUs while legacy cache events like "perf stat -e
L1-dcache-load-miss" do not. A behavior introduced by hybrid is that a
legacy cache event like L1-dcache-load-miss should wildcard open on
all hybrid PMUs. Previously hybrid would call to is_event_supported
for each PMU, a failure of which results in the event not being
added. This isn't done in this case as the parser should just create
perf_event_attr and the later open should fail, or the counter give
"<not counted>". If this wants to be avoided then the PMU can be named
with the event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events-hybrid.c | 33 -------------
 tools/perf/util/parse-events-hybrid.h |  7 ---
 tools/perf/util/parse-events.c        | 68 ++++++++++++++-------------
 tools/perf/util/parse-events.h        |  3 +-
 tools/perf/util/parse-events.y        |  2 +-
 5 files changed, 37 insertions(+), 76 deletions(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 7c9f9150bad5..d2c0be051d46 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -179,36 +179,3 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 	return add_raw_hybrid(parse_state, list, attr, name, metric_id,
 			      config_terms);
 }
-
-int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
-				   struct perf_event_attr *attr,
-				   const char *name,
-				   const char *metric_id,
-				   struct list_head *config_terms,
-				   bool *hybrid,
-				   struct parse_events_state *parse_state)
-{
-	struct perf_pmu *pmu;
-	int ret;
-
-	*hybrid = false;
-	if (!perf_pmu__has_hybrid())
-		return 0;
-
-	*hybrid = true;
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		LIST_HEAD(terms);
-
-		if (pmu_cmp(parse_state, pmu))
-			continue;
-
-		copy_config_terms(&terms, config_terms);
-		ret = create_event_hybrid(PERF_TYPE_HW_CACHE, idx, list,
-					  attr, name, metric_id, &terms, pmu);
-		free_config_terms(&terms);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
index cbc05fec02a2..bc2966e73897 100644
--- a/tools/perf/util/parse-events-hybrid.h
+++ b/tools/perf/util/parse-events-hybrid.h
@@ -15,11 +15,4 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 				     struct list_head *config_terms,
 				     bool *hybrid);
 
-int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
-				   struct perf_event_attr *attr,
-				   const char *name, const char *metric_id,
-				   struct list_head *config_terms,
-				   bool *hybrid,
-				   struct parse_events_state *parse_state);
-
 #endif /* __PERF_PARSE_EVENTS_HYBRID_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 166f4dc5bae2..a07d4ecad13e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -472,46 +472,48 @@ static int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_error *err,
-			   struct list_head *head_config,
-			   struct parse_events_state *parse_state)
+			   struct list_head *head_config)
 {
-	struct perf_event_attr attr;
-	LIST_HEAD(config_terms);
-	const char *config_name, *metric_id;
-	int ret;
-	bool hybrid;
+	struct perf_pmu *pmu = NULL;
+	bool found_supported = false;
+	const char *config_name = get_config_name(head_config);
+	const char *metric_id = get_config_metric_id(head_config);
 
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		LIST_HEAD(config_terms);
+		struct perf_event_attr attr;
+		int ret;
 
-	memset(&attr, 0, sizeof(attr));
-	attr.type = PERF_TYPE_HW_CACHE;
-	ret = parse_events__decode_legacy_cache(name, /*pmu_type=*/0, &attr.config);
-	if (ret)
-		return ret;
+		/* Skip unsupported PMUs. */
+		if (!perf_pmu__supports_legacy_cache(pmu))
+			continue;
 
-	if (head_config) {
-		if (config_attr(&attr, head_config, err,
-				config_term_common))
-			return -EINVAL;
+		memset(&attr, 0, sizeof(attr));
+		attr.type = PERF_TYPE_HW_CACHE;
 
-		if (get_config_terms(head_config, &config_terms))
-			return -ENOMEM;
-	}
+		ret = parse_events__decode_legacy_cache(name, pmu->type, &attr.config);
+		if (ret)
+			return ret;
 
-	config_name = get_config_name(head_config);
-	metric_id = get_config_metric_id(head_config);
-	ret = parse_events__add_cache_hybrid(list, idx, &attr,
-					     config_name ? : name,
-					     metric_id,
-					     &config_terms,
-					     &hybrid, parse_state);
-	if (hybrid)
-		goto out_free_terms;
+		found_supported = true;
 
-	ret = add_event(list, idx, &attr, config_name ? : name, metric_id,
-			&config_terms);
-out_free_terms:
-	free_config_terms(&config_terms);
-	return ret;
+		if (head_config) {
+			if (config_attr(&attr, head_config, err,
+						config_term_common))
+				return -EINVAL;
+
+			if (get_config_terms(head_config, &config_terms))
+				return -ENOMEM;
+		}
+
+		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
+				metric_id, pmu, &config_terms, /*auto_merge_stats=*/false,
+				/*cpu_list=*/NULL) == NULL)
+			return -ENOMEM;
+
+		free_config_terms(&config_terms);
+	}
+	return found_supported ? 0 : -EINVAL;
 }
 
 #ifdef HAVE_LIBTRACEEVENT
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5acb62c2e00a..0c26303f7f63 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -172,8 +172,7 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 			  int tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_error *error,
-			   struct list_head *head_config,
-			   struct parse_events_state *parse_state);
+			   struct list_head *head_config);
 int parse_events_add_breakpoint(struct list_head *list, int *idx,
 				u64 addr, char *type, u64 len);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f84fa1b132b3..cc7528558845 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -476,7 +476,7 @@ PE_LEGACY_CACHE opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, error, $2, parse_state);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, error, $2);
 
 	parse_events_terms__delete($2);
 	free($1);
-- 
2.40.1.495.gc816e09b53d-goog

