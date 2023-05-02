Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03B16F4CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjEBWl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjEBWlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:41:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C483ABA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:40:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a40d32a6bso32953517b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067238; x=1685659238;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dK5S8mU9rwbMcBHhA51JwhTrLHY8Q2AOOjtiR8G9v4Y=;
        b=k05Rs1L+/P+dL52ExnC3GepqHz5YxI4hF8D3xtemOGb+/3E0XruDnFShQx/AkzK9Le
         8ffrEsZLMpIRYOWT0QUXydNhMaw7xtXQeCoVbVTNEbNl/pdOeepRLfB8JABv2hymulxt
         2f44sdHQkD/X43MPJrLpEBBRKrfvQMV/1uEKAfriCn+dt+4mxSm1gSmo8ljm6wNgFY7y
         a4nMjuyqsfHX+VJ/9vRzWEHTFHcyCkLDFI5ODrhJ7wskv1lONwQeywUZSSkPzwycKsu3
         QnUYTAqBnwBTltxGT+3fmIxV3+1zyjEvMhMYAQ0ULNKTRN86gt1cPOj/lIpAGYiIJkUO
         FqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067238; x=1685659238;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dK5S8mU9rwbMcBHhA51JwhTrLHY8Q2AOOjtiR8G9v4Y=;
        b=SInIrX/fUYgl8uyNwUrO4HGbPFg8EWSM1tb2G0UUxFUkaYDjHRCEjFL3MYiH9zlMs0
         84RaeEE/TuAAQglmNX5BXAawfs9Ygg7O+hnAxY6N33peErsaypfYnXWgpWANz6K3/h4Y
         DQbc/dY7HXZ4BbnYIxGp+KjO69UbOvt5n1evhXLgf0KDAB0RUOVow+yNfAhkzsN2QTHV
         9vxQ1+5HGFYua7AOpM7gLJh0hR0u0pSMOuGmIZ1Gw/TMb2HBYfIAgkSkXNcP0IVepeZp
         KUkd6Ghv739iQc/QkDQ6shyVCh+GkY5x+HC/knLx8Hh66Tjouhy+XQnreTXTNDeyfXf7
         +2gQ==
X-Gm-Message-State: AC+VfDxnM8ka4ciycGv2QDpvJTp5IGRDPkSX4syKs70gCIZOioBI4pIA
        OWRJrlDjg9KeYfjsm0xdpJ9+/lDSTdg2
X-Google-Smtp-Source: ACHHUZ7W2ieYrIqlSQXSrqb47BfmN5rhcvBoq+5vjU8fiJ+oO7Sh4qNeygmVcPn47CbYft/b96bPpqx+rRm7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:ef04:0:b0:543:bbdb:8c2b with SMTP id
 o4-20020a81ef04000000b00543bbdb8c2bmr11404682ywm.10.1683067238293; Tue, 02
 May 2023 15:40:38 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:19 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-13-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 12/44] perf test: Mask configs with extended types then test
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

Add helper to test the config of an evsel. Dependent on the type of
the evsel, mask the config so that high-bits containing the extended
PMU type are ignored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 197 ++++++++++++++------------------
 1 file changed, 88 insertions(+), 109 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index c06fa7653ac2..4b00cb4aa73a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -21,6 +21,21 @@
 #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
 
+static bool test_config(const struct evsel *evsel, __u64 expected_config)
+{
+	__u32 type = evsel->core.attr.type;
+	__u64 config = evsel->core.attr.config;
+
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
+		/*
+		 * HARDWARE and HW_CACHE events encode the PMU's extended type
+		 * in the top 32-bits. Mask in order to ignore.
+		 */
+		config &= PERF_HW_EVENT_MASK;
+	}
+	return config == expected_config;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 
 #if defined(__s390x__)
@@ -87,7 +102,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 	return TEST_OK;
 }
 
@@ -97,7 +112,7 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
 	return TEST_OK;
 }
 
@@ -107,8 +122,7 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	return TEST_OK;
 }
 
@@ -118,8 +132,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	/*
 	 * The period value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -139,8 +152,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
 	return TEST_OK;
 }
 
@@ -150,7 +162,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", (1 << 16) == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1 << 16));
 	return TEST_OK;
 }
 
@@ -160,7 +172,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_4 ==
@@ -174,7 +186,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", sizeof(long) == evsel->core.attr.bp_len);
@@ -188,7 +200,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_R == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -203,7 +215,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_W == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -218,7 +230,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type",
 			PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
@@ -447,7 +459,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",    10 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config",    test_config(evsel, 10));
 	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
 	TEST_ASSERT_VAL("wrong config3",    0 == evsel->core.attr.config3);
@@ -469,7 +481,7 @@ static int test__checkevent_list(struct evlist *evlist)
 
 	/* r1 */
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
 	TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
 	TEST_ASSERT_VAL("wrong config3", 0 == evsel->core.attr.config3);
@@ -492,7 +504,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	/* 1:1:hp */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -509,14 +521,14 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	/* cpu/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",  1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
 	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "krava"));
 
 	/* cpu/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
 	TEST_ASSERT_VAL("wrong name",
 			!strcmp(evsel__name(evsel), "cpu/config=2/u"));
 
@@ -530,7 +542,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	/* cpu/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",  1 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -542,7 +554,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -696,8 +708,7 @@ static int test__group1(struct evlist *evlist)
 	/* instructions:k */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -712,8 +723,7 @@ static int test__group1(struct evlist *evlist)
 	/* cycles:upp */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -738,8 +748,7 @@ static int test__group2(struct evlist *evlist)
 	/* faults + :ku modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -754,8 +763,7 @@ static int test__group2(struct evlist *evlist)
 	/* cache-references + :u modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_REFERENCES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_REFERENCES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -769,8 +777,7 @@ static int test__group2(struct evlist *evlist)
 	/* cycles:k */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -813,8 +820,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	/* group1 cycles:kppp */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -830,8 +836,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	/* group2 cycles + G modifier */
 	evsel = leader = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -848,7 +853,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	/* group2 1:3 + G modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 3 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 3));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -862,8 +867,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	/* instructions:u */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -887,8 +891,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	/* cycles:u + p */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -905,8 +908,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	/* instructions:kp + p */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -931,8 +933,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* cycles + G */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -948,8 +949,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* instructions + G */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -963,8 +963,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* cycles:G */
 	evsel = leader = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -980,8 +979,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* instructions:G */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -994,8 +992,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	/* cycles */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1017,8 +1014,7 @@ static int test__group_gh1(struct evlist *evlist)
 	/* cycles + :H group modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1033,8 +1029,7 @@ static int test__group_gh1(struct evlist *evlist)
 	/* cache-misses:G + :H group modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1057,8 +1052,7 @@ static int test__group_gh2(struct evlist *evlist)
 	/* cycles + :G group modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1073,8 +1067,7 @@ static int test__group_gh2(struct evlist *evlist)
 	/* cache-misses:H + :G group modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1097,8 +1090,7 @@ static int test__group_gh3(struct evlist *evlist)
 	/* cycles:G + :u group modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1113,8 +1105,7 @@ static int test__group_gh3(struct evlist *evlist)
 	/* cache-misses:H + :u group modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1137,8 +1128,7 @@ static int test__group_gh4(struct evlist *evlist)
 	/* cycles:G + :uG group modifier */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1153,8 +1143,7 @@ static int test__group_gh4(struct evlist *evlist)
 	/* cache-misses:H + :uG group modifier */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1176,8 +1165,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	/* cycles - sampling group leader */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1191,8 +1179,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	/* cache-misses - not sampling */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1205,8 +1192,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	/* branch-misses - not sampling */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -1229,8 +1215,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	/* instructions - sampling group leader */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1244,8 +1229,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	/* branch-misses - not sampling */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -1281,8 +1265,7 @@ static int test__pinned_group(struct evlist *evlist)
 	/* cycles - group leader */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
@@ -1290,14 +1273,12 @@ static int test__pinned_group(struct evlist *evlist)
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
@@ -1325,8 +1306,7 @@ static int test__exclusive_group(struct evlist *evlist)
 	/* cycles - group leader */
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
@@ -1334,14 +1314,12 @@ static int test__exclusive_group(struct evlist *evlist)
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
@@ -1352,7 +1330,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type", (HW_BREAKPOINT_R | HW_BREAKPOINT_W) ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_1 ==
@@ -1367,7 +1345,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type", HW_BREAKPOINT_W ==
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_2 ==
@@ -1395,8 +1373,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config",
-			PERF_COUNT_SW_TASK_CLOCK == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_TASK_CLOCK));
 	return TEST_OK;
 }
 
@@ -1454,7 +1431,9 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong complex name parsing", evsel__name_is(evsel, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks"));
+	TEST_ASSERT_VAL("wrong complex name parsing",
+			evsel__name_is(evsel,
+				       "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks"));
 	return TEST_OK;
 }
 
@@ -1464,7 +1443,7 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 	return TEST_OK;
 }
 
@@ -1473,7 +1452,7 @@ static int test__sym_event_slash(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
-	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	return TEST_OK;
 }
@@ -1483,7 +1462,7 @@ static int test__sym_event_dc(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
-	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
 	return TEST_OK;
 }
@@ -1550,7 +1529,7 @@ static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
 	return TEST_OK;
 }
 
@@ -1561,12 +1540,12 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
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
@@ -1582,7 +1561,7 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
 
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -1594,7 +1573,7 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
 	evsel = leader = evlist__first(evlist);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 
 	evsel = evsel__next(evsel);
@@ -1610,14 +1589,14 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
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
@@ -1631,17 +1610,17 @@ static int test__hybrid_raw1(struct evlist *evlist)
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
 
@@ -1651,7 +1630,7 @@ static int test__hybrid_raw2(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
 	return TEST_OK;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

