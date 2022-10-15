Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA045FF936
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 10:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJOIvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJOIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 04:51:44 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352595464D;
        Sat, 15 Oct 2022 01:51:43 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0699EC022; Sat, 15 Oct 2022 10:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665823903; bh=QvdtUhikgp0J/cIM42N14CyZKYBUt4qgToUSnTp76Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbAteqlihw/5y2hl3JdXaR4VRN28Mu6heQlqPt0OUajz9HQ5fBIaHUOJcRAg/wGLZ
         hEjZsrYfszZ+SbgGc8Q9RzjrROST0E9pkRYwHYevtwAhQXFNHfYzuBMNWhdYwNNKkK
         MoMXm6rvEF1R6rFz+2txrqnfEnWG9fKcJw+qrZmWTT8vxyRREYFK2K7zm5DCOQb92M
         Ms2byMylgG0/VlqD/kUQeWgHf3x9DdhbS1p6rwUalGoPFwGGsUMvIqcNNcEcNcOQvN
         xZL+iUjY14FE3qrrkRZAxAJze5FFTSd7YgFit2XRfInxhJDw06seLKNWJ9Wm5VVYnh
         qTXl7rEx5+7wQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E7466C01A;
        Sat, 15 Oct 2022 10:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665823901; bh=QvdtUhikgp0J/cIM42N14CyZKYBUt4qgToUSnTp76Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1BiwKmyDPC8ZFxs7gHhRkqKi9PWR+b2pBXrkgojrYN/yrF4wlzYuLBy7QbwwBccYy
         iTdj9jkC5qCGYOBZTj3bR26z47jDp/Yglut0peCBNHPO2zpk3qkxjOPy+USvVDAeKV
         rIbP52Q7QRF3LoT1gJq95+KWrV8q5eMOZDIYSp7e51K+eimd1jd5+Mz95nOgqrbOPR
         CARNOjPK0cum0Wza1HNIGkBNfay44hFCmUMQ8nS2I/tLskNoykroa9zFwCwMFFYKYP
         XPzPGDZphVhxfo+P580M/LSjZ4+qPquh67ZbEw+in0eWP9lU7o1SJuaM4hLYI2bML7
         xhZtz+3mK8U8A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 13bf58b1;
        Sat, 15 Oct 2022 08:51:35 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/3] perf parse-events: add fake_tp field to trace state for tests
Date:   Sat, 15 Oct 2022 17:48:12 +0900
Message-Id: <20221015084810.2114158-2-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221015084810.2114158-1-asmadeus@codewreck.org>
References: <20221015084810.2114158-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests currently require the tracepoint to exist on the system to pass.
This works fine for common tracepoints, but if we add a test for rarely
loaded module's probes e.g. 9p tracepoints the test would only pass with
the 9p module loaded and that is not acceptable.

Instead, add a new flag like fake_pmu for tracepoints (fake_tp) that
skip the tracepoint existence check.

Linf: https://lore.kernel.org/all/YsGduWiTvkM2/tHv@krava/
Co-authored-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/tests/parse-events.c |  4 ++--
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/evlist.c        |  2 +-
 tools/perf/util/evsel.c         | 16 ++++++++++------
 tools/perf/util/evsel.h         |  4 ++--
 tools/perf/util/metricgroup.c   |  2 +-
 tools/perf/util/parse-events.c  |  7 +++++--
 tools/perf/util/parse-events.h  |  5 +++--
 8 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 459afdb256a1..a8b5a570aaf6 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2053,7 +2053,7 @@ static int test_event(const struct evlist_test *e)
 		return TEST_FAIL;
 	}
 	parse_events_error__init(&err);
-	ret = parse_events(evlist, e->name, &err);
+	ret = __parse_events(evlist, e->name, &err, NULL, true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 e->name, ret, err.str);
@@ -2082,7 +2082,7 @@ static int test_event_fake_pmu(const char *str)
 
 	parse_events_error__init(&err);
 	perf_pmu__test_parse_init();
-	ret = __parse_events(evlist, str, &err, &perf_pmu__fake);
+	ret = __parse_events(evlist, str, &err, &perf_pmu__fake, false);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 str, ret, err.str);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 097e05c796ab..a0ce94bc9b4d 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -816,7 +816,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 		 */
 		perf_pmu__test_parse_init();
 	}
-	ret = __parse_events(evlist, dup, error, fake_pmu);
+	ret = __parse_events(evlist, dup, error, fake_pmu, false);
 	free(dup);
 
 	evlist__delete(evlist);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6612b00949e7..51d87f21519c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -290,7 +290,7 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 
 struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
 {
-	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0);
+	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0, true);
 
 	if (IS_ERR(evsel))
 		return evsel;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 76605fde3507..e7b7c7d00fd0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -481,7 +481,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 	int err = -ENOMEM;
@@ -498,14 +498,18 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
 			goto out_free;
 
-		evsel->tp_format = trace_event__tp_format(sys, name);
-		if (IS_ERR(evsel->tp_format)) {
-			err = PTR_ERR(evsel->tp_format);
-			goto out_free;
+		if (format) {
+			evsel->tp_format = trace_event__tp_format(sys, name);
+			if (IS_ERR(evsel->tp_format)) {
+				err = PTR_ERR(evsel->tp_format);
+				goto out_free;
+			}
+			attr.config = evsel->tp_format->id;
+		} else {
+			attr.config = (__u64) -1;
 		}
 
 		event_attr_init(&attr);
-		attr.config = evsel->tp_format->id;
 		attr.sample_period = 1;
 		evsel__init(evsel, &attr, idx);
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 989865e16aad..212aeae37df1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -225,7 +225,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 }
 
 struct evsel *evsel__clone(struct evsel *orig);
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
 
 int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
@@ -235,7 +235,7 @@ void free_config_terms(struct list_head *config_terms);
  */
 static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 {
-	return evsel__newtp_idx(sys, name, 0);
+	return evsel__newtp_idx(sys, name, 0, true);
 }
 
 struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4c98ac29ee13..29b3a2a5288e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1520,7 +1520,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	}
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
-	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
+	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu, false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index aa06be9583a2..d4d7a1bf289f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -478,7 +478,8 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 			  struct parse_events_error *err,
 			  struct list_head *head_config)
 {
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++);
+	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++,
+					       !parse_state->fake_tp);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name);
@@ -2233,7 +2234,8 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 }
 
 int __parse_events(struct evlist *evlist, const char *str,
-		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
+		   struct parse_events_error *err,
+		   struct perf_pmu *fake_pmu, bool fake_tp)
 {
 	struct parse_events_state parse_state = {
 		.list	  = LIST_HEAD_INIT(parse_state.list),
@@ -2242,6 +2244,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.evlist	  = evlist,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
+		.fake_tp  = fake_tp,
 	};
 	int ret;
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c6606638d8cf..fb6702c4fe23 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -27,13 +27,13 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 __attribute__((nonnull(1, 2, 3)))
 int __parse_events(struct evlist *evlist, const char *str, struct parse_events_error *error,
-		   struct perf_pmu *fake_pmu);
+		   struct perf_pmu *fake_pmu, bool fake_tp);
 
 __attribute__((nonnull))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
-	return __parse_events(evlist, str, err, NULL);
+	return __parse_events(evlist, str, err, NULL, false);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -129,6 +129,7 @@ struct parse_events_state {
 	struct list_head	  *terms;
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
+	bool			   fake_tp;
 	char			  *hybrid_pmu_name;
 };
 
-- 
2.37.3

