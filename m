Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1B56F2337
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347389AbjD2FnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347425AbjD2Fme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:42:34 -0400
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4156171B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:42:12 -0700 (PDT)
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-24b28355b5eso656915a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746803; x=1685338803;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c476LBsImvqE5/6YQn4dOI9c3SaoXwyAgImR8nGz1Ik=;
        b=rPa0iYDULAc65dNx3Li2Dsln0bipld12ZX7c4eqwr5wOKOrGIfaTZ0GjklQLQZhQtm
         Kos6TjiNCRqzmv+hrbqKJOu7weQCbzHWPjE2Vk+dNTXGBihBwfXbQPqdVThRyZ47bgwK
         zuIBv42R31dSE8Ulp1Lr1DWGO91w0+HmmZuLLZ2ZzKarg6esDwf53CGs8zc0Uq/Xi834
         3jRF5j8DU19BmH7LKszav0YB0Y6/EvkQttY/xIMYcQD+ltsXn8Q+F5eW2VYeusPJQXpV
         Te6S4KlaPnhl8QlQpiD24dl1q9NgbWD6ENinJLSM9AICUmuDy6L5gc/g+O08sqtAhEGe
         SevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746803; x=1685338803;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c476LBsImvqE5/6YQn4dOI9c3SaoXwyAgImR8nGz1Ik=;
        b=YYHysGlGtL4EP3KLLyEdOKhr2MegxorcRbD88Bitttx5gwFFF5Vkc4DZLTo3NnoVcq
         m5OiiuKdY+MN+sq+GSf/C64+Yj4Fe3lYVdugcrMyWQbpV5XlkHMSxDAHQ4N1rfDo9bWc
         WH3aehRCrLInSbZwzT/maTftkY5Z2mM+MKK9IYAyFwR4luCTFBex5qpB8MbfzvbUL20s
         xehC0mSfMw1GU4ybyH03iJ2WzQnKeuAQ4JFTy/nhudajTw2lzYMKg3g3sQrV9lcEMpN/
         bK6FEHkT8OFLkapi2REunCHH18EVetTb6xhFagitelh2s9Qd0HOBJGAJJ/SJ+kx+4BM0
         SCkQ==
X-Gm-Message-State: AC+VfDyThtkf7ql7BlKLPg01SsiXFpqPq3bKsPETyfy8zLrvFNw6jt88
        wsuDCARD/eNNWSNWjHHnSherEQ4KYnSY
X-Google-Smtp-Source: ACHHUZ5VfEVezs60jwuoMR2q/UZSFUIrvVKdzDBPm5gCB9WRRkZt0Ra3/gGIO4tmA1E5LsP16SVmFykMFQnz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a17:90a:5584:b0:24d:ddd7:c906 with SMTP id
 c4-20020a17090a558400b0024dddd7c906mr94316pji.7.1682746803272; Fri, 28 Apr
 2023 22:40:03 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:54 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-35-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 34/46] perf test: Fix parse-events tests for >1 core PMU
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 4d57f5437cc0..e507b6d40099 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -25,6 +25,11 @@ static bool test_config(const struct evsel *evsel, __u64 expected_config)
 	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
 
+static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_config)
+{
+	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 
 #if defined(__s390x__)
@@ -87,11 +92,27 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 
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
 
@@ -107,31 +128,35 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
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
 
@@ -147,11 +172,14 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 
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
 
@@ -243,17 +271,15 @@ static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
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
@@ -262,25 +288,27 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 
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
 
@@ -298,21 +326,23 @@ static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 
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
 
@@ -330,13 +360,14 @@ static int test__checkevent_symbolic_alias_modifier(struct evlist *evlist)
 
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
 
@@ -466,21 +497,23 @@ static int test__checkevent_list(struct evlist *evlist)
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
@@ -1916,7 +1949,7 @@ static int test_event(const struct evlist_test *e)
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

