Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51006F231F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbjD2FiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347288AbjD2Fhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:37:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A1930EE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:37:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559e281c5dfso2782267b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746633; x=1685338633;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBeD3heSi56E6ZGsfQEHPtefLoi5KCpqqg8w0Weodw=;
        b=5Mfu6uChKpJRRw5ExfCXcHvyU0Mq32gY+/vIscysKJ8lPSRUuEbpRHXaMhEM4JyrvV
         K0GhIhRh9tP9Fgaj0dLV25+glnWWl/tPGFRQ4eTROWZ2Lfg8LtFmAGeQoDyXSd8eLR1E
         mERzF6V4du705AkPKvcHHypcYVn1h4tXyXP7y7+9hUvC1AySK3wLK5wPRqtQ8vOYDXBS
         rMrOcYvqaC14uwVZTGiieab/Oyst5XRl3fRmXRa05EJLFUlB7jJNNOEXtA2IhjOS/Ex3
         G1gEk79YwCEl6vjJJxN8FPHQO5jRFJPoDaYPPazm5ZJRGZrP5DOz9bCA53yep7+ZXmkU
         l6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746633; x=1685338633;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBeD3heSi56E6ZGsfQEHPtefLoi5KCpqqg8w0Weodw=;
        b=d36skYuezZo/uK0IqLVP0qhI0uyFnVgvfzQKfSQF3AFAJKf8pjE9w0dLYTn7uKV/OX
         q0MNFky/4ZsnBVCYuYkgtw0WdE7UEbdm/KfOJXKPnDwNJajW3d66ls4E8p/KMuyJRxVY
         KYQBdQOPUSQKpAv6GvoKFNSCr4fjimGbiepPxHuFEhS5h4OF6/VuIM98PoeqyKzJ+k1Z
         csqPBDwF13wl8+j+rB5GAB2lRnToeJXgU6A90zcEI2KX5ttn1wmF23puOV8CYo/nlQ/5
         Aeb289xU2tZ1KTrm8OvgaPeGwekp7Qe4hDXvqQZ87XSZ5/pnRaTg/5MaGjdfWuAvdnMO
         W5Kg==
X-Gm-Message-State: AC+VfDxfL90BpIn9DeWKdbO8276usNNc22tDVYeEIoKmglXM//abqHfu
        jYHqwJMHpVOODzsEETd52ftF10DUXlId
X-Google-Smtp-Source: ACHHUZ6oivNbNQbor6aNWaj8xW7A0NfJ//sW6FSAfncl2yGfksFfoIi0g2n1NMU09zmfKpMhLpabKOhm7Hta
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b8f:54f5:89ff with SMTP
 id w3-20020a056902100300b00b8f54f589ffmr4593051ybt.11.1682746632895; Fri, 28
 Apr 2023 22:37:12 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:34 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-15-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 14/46] perf test: Mask config then test
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

Add helper to test the config of an evsel. Mask the config so that
high-bits containing the PMU type, which isn't constant for hybrid,
are ignored.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 183 +++++++++++++-------------------
 1 file changed, 75 insertions(+), 108 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 767b296b91e4..4ff1d70e8375 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -21,6 +21,11 @@
 #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
 
+static bool test_config(const struct evsel *evsel, __u64 expected_config)
+{
+	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 
 #if defined(__s390x__)
@@ -87,7 +92,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 	return TEST_OK;
 }
 
@@ -97,7 +102,7 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
 	return TEST_OK;
 }
 
@@ -107,8 +112,7 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	return TEST_OK;
 }
 
@@ -118,8 +122,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	/*
 	 * The period value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -139,8 +142,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
 	return TEST_OK;
 }
 
@@ -150,7 +152,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", (1 << 16) == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1 << 16));
 	return TEST_OK;
 }
 
@@ -160,7 +162,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_4 ==
@@ -174,7 +176,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", sizeof(long) == evsel->core.attr.bp_len);
@@ -188,7 +190,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_R == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -203,7 +205,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_W == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -218,7 +220,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -447,7 +449,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",    10 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config",    test_config(evsel, 10));
 	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
 	TEST_ASSERT_VAL("wrong config3",    0 == evsel->core.attr.config3);
@@ -469,7 +471,7 @@ static int test__checkevent_list(struct evlist *evlist)
 
 	/* r1 */
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
 	TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
 	TEST_ASSERT_VAL("wrong config3", 0 == evsel->core.attr.config3);
@@ -492,7 +494,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	/* 1:1:hp */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -509,14 +511,14 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	/* cpu/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",  1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config",  test_config(evsel, 1));
 	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "krava"));
 
 	/* cpu/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config",  test_config(evsel, 2));
 	TEST_ASSERT_VAL("wrong name",
 			!strcmp(evsel__name(evsel), "cpu/config=2/u"));
 
@@ -530,7 +532,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	/* cpu/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",  1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config",  test_config(evsel, 1));
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -542,7 +544,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config",  test_config(evsel, 2));
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -694,8 +696,7 @@ static int test__group1(struct evlist *evlist)
 	/* instructions:k */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -710,8 +711,7 @@ static int test__group1(struct evlist *evlist)
 	/* cycles:upp */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -736,8 +736,7 @@ static int test__group2(struct evlist *evlist)
 	/* faults + :ku modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -752,8 +751,7 @@ static int test__group2(struct evlist *evlist)
 	/* cache-references + :u modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_REFERENCES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_REFERENCES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -767,8 +765,7 @@ static int test__group2(struct evlist *evlist)
 	/* cycles:k */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -811,8 +808,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	/* group1 cycles:kppp */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -828,8 +824,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	/* group2 cycles + G modifier */
 	evsel = leader = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -846,7 +841,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	/* group2 1:3 + G modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 3 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 3));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -860,8 +855,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	/* instructions:u */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -885,8 +879,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	/* cycles:u + p */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -903,8 +896,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	/* instructions:kp + p */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -929,8 +921,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* cycles + G */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -946,8 +937,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* instructions + G */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -961,8 +951,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* cycles:G */
 	evsel = leader = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -978,8 +967,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* instructions:G */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -992,8 +980,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* cycles */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1015,8 +1002,7 @@ static int test__group_gh1(struct evlist *evlist)
 	/* cycles + :H group modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1031,8 +1017,7 @@ static int test__group_gh1(struct evlist *evlist)
 	/* cache-misses:G + :H group modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1055,8 +1040,7 @@ static int test__group_gh2(struct evlist *evlist)
 	/* cycles + :G group modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1071,8 +1055,7 @@ static int test__group_gh2(struct evlist *evlist)
 	/* cache-misses:H + :G group modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1095,8 +1078,7 @@ static int test__group_gh3(struct evlist *evlist)
 	/* cycles:G + :u group modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1111,8 +1093,7 @@ static int test__group_gh3(struct evlist *evlist)
 	/* cache-misses:H + :u group modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1135,8 +1116,7 @@ static int test__group_gh4(struct evlist *evlist)
 	/* cycles:G + :uG group modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1151,8 +1131,7 @@ static int test__group_gh4(struct evlist *evlist)
 	/* cache-misses:H + :uG group modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1174,8 +1153,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	/* cycles - sampling group leader */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1189,8 +1167,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	/* cache-misses - not sampling */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1203,8 +1180,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	/* branch-misses - not sampling */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1227,8 +1203,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	/* instructions - sampling group leader */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1242,8 +1217,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	/* branch-misses - not sampling */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1279,8 +1253,7 @@ static int test__pinned_group(struct evlist *evlist)
 	/* cycles - group leader */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
@@ -1288,14 +1261,12 @@ static int test__pinned_group(struct evlist *evlist)
 	/* cache-misses - can not be pinned, but will go on with the leader */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
 	/* branch-misses - ditto */
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
 	return TEST_OK;
@@ -1323,8 +1294,7 @@ static int test__exclusive_group(struct evlist *evlist)
 	/* cycles - group leader */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
@@ -1332,14 +1302,12 @@ static int test__exclusive_group(struct evlist *evlist)
 	/* cache-misses - can not be pinned, but will go on with the leader */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
 	/* branch-misses - ditto */
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
 	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
 	return TEST_OK;
@@ -1350,7 +1318,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_1 ==
@@ -1365,7 +1333,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type", HW_BREAKPOINT_W ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_2 ==
@@ -1393,8 +1361,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_SW_TASK_CLOCK == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_TASK_CLOCK));
 	return TEST_OK;
 }
 
@@ -1462,7 +1429,7 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 	return TEST_OK;
 }
 
@@ -1471,7 +1438,7 @@ static int test__sym_event_slash(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
-	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	return TEST_OK;
 }
@@ -1481,7 +1448,7 @@ static int test__sym_event_dc(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
-	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	return TEST_OK;
 }
@@ -1548,7 +1515,7 @@ static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
 	return TEST_OK;
 }
 
@@ -1559,12 +1526,12 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0xc0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -1580,7 +1547,7 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -1592,7 +1559,7 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
@@ -1608,14 +1575,14 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0xc0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -1629,17 +1596,17 @@ static int test__hybrid_raw1(struct evlist *evlist)
 	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
 		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-		TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 		return TEST_OK;
 	}
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 
 	/* The type of second event is randome value */
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 	return TEST_OK;
 }
 
@@ -1649,7 +1616,7 @@ static int test__hybrid_raw2(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 	return TEST_OK;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

