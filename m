Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519E76EEED9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbjDZHGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbjDZHFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:05:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1214685
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:04:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9968fb4a8cso6733612276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492650; x=1685084650;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6zRrC4hUX7PhEDuCu1xgf2T0BrwgQLaocW+FLFGQhc=;
        b=3UnvADMGiII/idx03XAm56r+ktXmNfMerZBFmOqGNncLDgwou2irg/laiIWINguUpg
         JQCELgweUNWqtgUNpv6q0gOdpu9ED3ls2ff2Nr/RmwcFlb9ipXSCdjFg7WBij7ZeLJcO
         Cp/rZyzoMbAlSD1ksmcQQHtEDnPIf5/5acJOo0d9Zo2qoBMgrwNw1My7kC6nAO4bu3bP
         sDtq8WP2QZPP1bwo1+q8tlV6rG1/Ap7ioZDpct9QO0pxCtlQeB0m5ljkORcn5BY74CrC
         9/42U6uNNY8vjkGyCfos7au+GVFKy32Ub3akteJIboVE4XiZExoX4rndWUBFrEIN2fdb
         qW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492650; x=1685084650;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6zRrC4hUX7PhEDuCu1xgf2T0BrwgQLaocW+FLFGQhc=;
        b=fJQpvd8QNbt0OTdMd6yUBBrXiZdpEfvPFth3K2+b562um+MWYMiPeLu3BsOexqJ7x8
         FhJgvNSIkT0+oosSdNsDra9DCPpAn8eQvocGw1ngjJF8trdJVv4fCu8bsmo4OyqHBQzz
         8O+fO1mspreJY+kj4USRPlZaTDZzR1lHbu0qGZyThavzIbHUetNqrEkNkt0+f8XbmTbh
         P+bKfVfx+BPflNpxIHK5lzewuRZqG2zg38EduW8biOSGckISK6oLGHJaQhIoQEdunJd7
         q/r9s6LunfFQ2t+Em2dQypsJlJZNo0CdAaPBrIaj1zRdU4G3IzQ8/+G4Ypkv1sfwYBee
         SmPg==
X-Gm-Message-State: AAQBX9dlRYisAJ1r7YDRUqwBNuUb235TuPWkv/ThkrdpKp1nqjr2Okbv
        kknkqDB7FYW56dg3tCKKq8bjHIHYkfre
X-Google-Smtp-Source: AKy350ZZbP+u+Nl4dEFaMlKn7bv6x49oSVfRvOCSyyiYuGhMXwDVJKTl9BVxzgfPlw/19Epmnw2BBKFA0QyH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:734e:0:b0:b99:4877:99e4 with SMTP id
 o75-20020a25734e000000b00b99487799e4mr6074655ybc.11.1682492649844; Wed, 26
 Apr 2023 00:04:09 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:33 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-24-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 23/40] perf parse-events: Support wildcards on raw events
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

Legacy raw events like r1a open as PERF_TYPE_RAW on non-hybrid systems
and on each hybrid PMU on hybrid systems. Rather than iterate hybrid
PMUs add a perf_pmu__supports_wildcard_numeric function that says when
a numeric event should be opened upon it. If the parsed event
specifies the type of the PMU then don't wildcard match PMUs, use the
specified PMU type.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 43 ++++++++++++++++++++++++----------
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y | 13 ++++++----
 tools/perf/util/pmu.c          |  5 ++++
 tools/perf/util/pmu.h          |  1 +
 5 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ae421a5c9ddd..12b312935353 100644
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
@@ -1449,15 +1448,14 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 #endif
 }
 
-int parse_events_add_numeric(struct parse_events_state *parse_state,
-			     struct list_head *list,
-			     u32 type, u64 config,
-			     struct list_head *head_config)
+static int __parse_events_add_numeric(struct parse_events_state *parse_state,
+				struct list_head *list,
+				u32 type, u64 config,
+				struct list_head *head_config)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
 	const char *name, *metric_id;
-	bool hybrid;
 	int ret;
 
 	memset(&attr, 0, sizeof(attr));
@@ -1475,19 +1473,38 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 	name = get_config_name(head_config);
 	metric_id = get_config_metric_id(head_config);
-	ret = parse_events__add_numeric_hybrid(parse_state, list, &attr,
-					       name, metric_id,
-					       &config_terms, &hybrid);
-	if (hybrid)
-		goto out_free_terms;
-
 	ret = add_event(list, &parse_state->idx, &attr, name, metric_id,
 			&config_terms);
-out_free_terms:
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
+		return __parse_events_add_numeric(parse_state, list, type, config, head_config);
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		int ret;
+
+		if (!perf_pmu__supports_wildcard_numeric(pmu))
+			continue;
+
+		found_supported = true;
+		ret = __parse_events_add_numeric(parse_state, list, pmu->type, config, head_config);
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

