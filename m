Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03726F4D16
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjEBWo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjEBWoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:44:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55273A9B
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:44:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a7d1f6914so42354487b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067382; x=1685659382;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxzMWV72g/5LziCMw5rVJi/60zDX6vPO62VzJj3WeeM=;
        b=L4zp+ojO3/dsaN9Zl2hNxzuW4CpOJRMKBu7ZFqlXtU4AXmrpeGxoBzosaxxnP0owgq
         S7Pzz3cEGPNiSSh7xDRORyKwPBBz7pnU8jvUKzCPIPntZydSl59yxTmzEXNusJFXsE6J
         O+SIXNQUN3LLVXrftvbRVJcXfnmCCBtIKBPPeMeZ8HxIFYqeAm+tsOYZFdZxA9PCYjwX
         K35WTi5yAuJXI1yj4CALnlgid2vtfEaME6gGM4/ec2ZBdYIki2vWOlw0t+eRGY/jPpod
         vOd5OeUJ1JB7fdDzn8fJAGalObHZ6oMZ4ULnEs7DgLvWQXNom1FARATtPdJDiPMEbjxm
         9WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067382; x=1685659382;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxzMWV72g/5LziCMw5rVJi/60zDX6vPO62VzJj3WeeM=;
        b=HjYo3EC7JMlcTbg7uuHIWbDCud+b939DE96xr6TembUy99wkFV6aFpfjPI4Z5ZdQ/b
         PfvpnYqjsndUvlJfOYXcqov2b8RF7md6GtYCBIiZq/rOWPSmqM/W61zQkPFRsbOySJCJ
         DUhTUbPTR+S39P5vWjsfypZAFMYyJPKiW1i9DLeyNChJHj1qkZzyq8InQqsPbyPvbduO
         SybwNcC1kN8yFdNn3f0XEVm35fG0B+X5+Qjo19IUMH8+mYbm+YMfaH6EgT9OdQPsGPSl
         4EPlpV+FhA9a/RmX01V7MWJPdeQmPGhTW2vxH7jog33Af6UG0Phza7U/I3AGrUp1X0XH
         1Z3Q==
X-Gm-Message-State: AC+VfDxqyO1uLFRDfihburzKcq6Y6O9h2UzshQfpUvzE9JOQhSQ3B9S3
        kv9Lf4xC6DlPHtQa9qe4bEu6/yocpzQj
X-Google-Smtp-Source: ACHHUZ66soYnECQZp4BbCJ1RSj4aYgqWSOEyD2imVPLgT2TYJ0Y8Te3meALarRq8sIBkqYNumKYmNUWQvSJ/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:a747:0:b0:55a:8fe8:4fc8 with SMTP id
 e68-20020a81a747000000b0055a8fe84fc8mr2609297ywh.3.1683067381833; Tue, 02 May
 2023 15:43:01 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:39 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-33-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 32/44] perf test: Fix parse-events tests for >1 core PMU
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

Remove assumptions of just 1 core PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 177 +++++++++++++++++++-------------
 1 file changed, 105 insertions(+), 72 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0d0c869d2d09..71c77d9d2744 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -35,6 +35,11 @@ static bool test_config(const struct evsel *evsel, __u64 expected_config)
 	return config == expected_config;
 }
 
+static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_config)
+{
+	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 
 #if defined(__s390x__)
@@ -97,11 +102,27 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 
 static int test__checkevent_raw(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct perf_evsel *evsel;
+	bool raw_type_match = false;
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
+
+	perf_evlist__for_each_evsel(&evlist->core, evsel) {
+		struct perf_pmu *pmu;
+		bool type_matched = false;
+
+		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
+		perf_pmus__for_each_pmu(pmu) {
+			if (pmu->type == evsel->attr.type) {
+				TEST_ASSERT_VAL("PMU type expected once", !type_matched);
+				type_matched = true;
+				if (pmu->type == PERF_TYPE_RAW)
+					raw_type_match = true;
+			}
+		}
+		TEST_ASSERT_VAL("No PMU found for type", type_matched);
+	}
+	TEST_ASSERT_VAL("Raw PMU not matched", raw_type_match);
 	return TEST_OK;
 }
 
@@ -117,31 +138,35 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
 static int test__checkevent_symbolic_name(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct perf_evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
+
+	perf_evlist__for_each_evsel(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
+		TEST_ASSERT_VAL("wrong config",
+				test_perf_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+	}
 	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct perf_evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	/*
-	 * The period value gets configured within evlist__config,
-	 * while this test executes only parse events method.
-	 */
-	TEST_ASSERT_VAL("wrong period",
-			0 == evsel->core.attr.sample_period);
-	TEST_ASSERT_VAL("wrong config1",
-			0 == evsel->core.attr.config1);
-	TEST_ASSERT_VAL("wrong config2",
-			1 == evsel->core.attr.config2);
+	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
+
+	perf_evlist__for_each_evsel(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
+		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		/*
+		 * The period value gets configured within evlist__config,
+		 * while this test executes only parse events method.
+		 */
+		TEST_ASSERT_VAL("wrong period", 0 == evsel->attr.sample_period);
+		TEST_ASSERT_VAL("wrong config1", 0 == evsel->attr.config1);
+		TEST_ASSERT_VAL("wrong config2", 1 == evsel->attr.config2);
+	}
 	return TEST_OK;
 }
 
@@ -157,11 +182,14 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 
 static int test__checkevent_genhw(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct perf_evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1 << 16));
+	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
+
+	perf_evlist__for_each_entry(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->attr.type);
+		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 1 << 16));
+	}
 	return TEST_OK;
 }
 
@@ -253,17 +281,15 @@ static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
 static int
 test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel;
+	struct perf_evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries > 1);
 
-	evlist__for_each_entry(evlist, evsel) {
-		TEST_ASSERT_VAL("wrong exclude_user",
-				!evsel->core.attr.exclude_user);
-		TEST_ASSERT_VAL("wrong exclude_kernel",
-				evsel->core.attr.exclude_kernel);
-		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	perf_evlist__for_each_entry(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
 	}
 
 	return test__checkevent_tracepoint_multi(evlist);
@@ -272,25 +298,27 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 
 static int test__checkevent_raw_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
-
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+	struct perf_evsel *evsel;
 
+	perf_evlist__for_each_entry(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
+	}
 	return test__checkevent_raw(evlist);
 }
 
 static int test__checkevent_numeric_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
-
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+	struct perf_evsel *evsel;
 
+	perf_evlist__for_each_entry(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
+	}
 	return test__checkevent_numeric(evlist);
 }
 
@@ -308,21 +336,23 @@ static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 
 static int test__checkevent_exclude_host_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
-
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+	struct perf_evsel *evsel;
 
+	perf_evlist__for_each_entry(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", evsel->attr.exclude_host);
+	}
 	return test__checkevent_symbolic_name(evlist);
 }
 
 static int test__checkevent_exclude_guest_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
-
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+	struct perf_evsel *evsel;
 
+	perf_evlist__for_each_entry(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->attr.exclude_host);
+	}
 	return test__checkevent_symbolic_name(evlist);
 }
 
@@ -340,13 +370,14 @@ static int test__checkevent_symbolic_alias_modifier(struct evlist *evlist)
 
 static int test__checkevent_genhw_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
-
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+	struct perf_evsel *evsel;
 
+	perf_evlist__for_each_entry(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", evsel->attr.precise_ip);
+	}
 	return test__checkevent_genhw(evlist);
 }
 
@@ -476,21 +507,23 @@ static int test__checkevent_list(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 3 <= evlist->core.nr_entries);
 
 	/* r1 */
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
-	TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
-	TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
-	TEST_ASSERT_VAL("wrong config3", 0 == evsel->core.attr.config3);
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT != evsel->core.attr.type);
+	while (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
+		TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
+		TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
+		TEST_ASSERT_VAL("wrong config3", 0 == evsel->core.attr.config3);
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		evsel = evsel__next(evsel);
+	}
 
 	/* syscalls:sys_enter_openat:k */
-	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
@@ -1930,7 +1963,7 @@ static int test_event(const struct evlist_test *e)
 			 e->name, ret, err.str);
 		parse_events_error__print(&err, e->name);
 		ret = TEST_FAIL;
-		if (strstr(err.str, "can't access trace events"))
+		if (err.str && strstr(err.str, "can't access trace events"))
 			ret = TEST_SKIP;
 	} else {
 		ret = e->check(evlist);
-- 
2.40.1.495.gc816e09b53d-goog

