Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4935A6EEED2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbjDZHFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbjDZHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:04:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFE04686
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:03:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so7383594276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492602; x=1685084602;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjuboGAp9ru4SnSIW5FLSn0mUR/AY3DyroHqTIHNwEU=;
        b=sBlg/i3eLnD4UQIvD1Ots6pX3JAgdWb2iZdiPnk+L9cXtOGQp7d7cKUzdVgaigpQCd
         Ld821gQkXe21anWpF0Jv26BsUPJmUJaFBgPgX3/M4FfoMZC2kfuCJK5fNFzdDbEjywiR
         D+WmY/WIuPlPjHCkwuRguKolpF4pggT+qEIYEcmwD8YISDR8ioElgGxlpphh3kyqJQ17
         atamyWXOfkICffnapgXxTEB45wNeMy3vLzqBgaZuyHDTjtPR0Qu1ZPvaO1CFDAnP6CdK
         msw96QpC2dN0luIR+BNrwZKksWnO6kJmkPR4wPeanEhPOSnxXJTokMvPx947IBF2ltPy
         UbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492602; x=1685084602;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjuboGAp9ru4SnSIW5FLSn0mUR/AY3DyroHqTIHNwEU=;
        b=Jbu5mAsgimKJyssbpXGFae45F+5wAZnmBSucs743wrM4GeiRAHRR95KftgK/fbgfXn
         tQAIkFptZLTFFlmb1z1VujS/pfCeqmC2DRtjUWfZGB1ixvHjVs3KxMdfIQ6Ji2ufyG/2
         HOux+Phk3HSlpttz0/9jhuQMWCm2lq+kn1N30hp2bHH8vkm3ahTtTtTfjMNNZ0O5iDIT
         T3fVV5zcLWi2EyFxpJohmNnHmIglOvuj51+mLpDUYIPfuxx1HXvhFDqNwLcKg3T+TMrF
         L6BmCPjktAHj82el7Nc+y0zeO+hGoStXv0jd9c8KcP60RtKZ/60MnV3tO9ORdtgqo2fa
         N/5g==
X-Gm-Message-State: AAQBX9fx/oOP9ufrJTGvOG6XnMlwxcyDxIYFNAOAKjNL+NZMuj31q0TJ
        RD99qTlO3lcMmRmL/eZQ7tnWPQT+D5Vg
X-Google-Smtp-Source: AKy350ZKCF6AWWNH8UHj0BVpfzJLYnJboM0AtbYgLh9kcD2AuzMqHmjbv/4m/FvGcFtSXkhq6k+ud7nyztf3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:7452:0:b0:b92:2c78:1481 with SMTP id
 p79-20020a257452000000b00b922c781481mr11283377ybc.12.1682492602305; Wed, 26
 Apr 2023 00:03:22 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:28 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-19-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 18/40] perf test: Move x86 hybrid tests to arch/x86
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

The tests use x86 hybrid specific PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/include/arch-tests.h |   1 +
 tools/perf/arch/x86/tests/Build          |   1 +
 tools/perf/arch/x86/tests/arch-tests.c   |  10 +
 tools/perf/arch/x86/tests/hybrid.c       | 277 +++++++++++++++++++++++
 tools/perf/tests/parse-events.c          | 181 ---------------
 5 files changed, 289 insertions(+), 181 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/hybrid.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 902e9ea9b99e..33d39c1d3e64 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -11,6 +11,7 @@ int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
 int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
 int test__bp_modify(struct test_suite *test, int subtest);
 int test__x86_sample_parsing(struct test_suite *test, int subtest);
+int test__hybrid(struct test_suite *test, int subtest);
 
 extern struct test_suite *arch_tests[];
 
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 6f4e8636c3bf..08cc8b9c931e 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -3,5 +3,6 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
 perf-y += sample-parsing.o
+perf-y += hybrid.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index aae6ea0fe52b..147ad0638bbb 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -22,6 +22,15 @@ struct test_suite suite__intel_pt = {
 DEFINE_SUITE("x86 bp modify", bp_modify);
 #endif
 DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
+static struct test_case hybrid_tests[] = {
+	TEST_CASE_REASON("x86 hybrid event parsing", hybrid, "not hybrid"),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__hybrid = {
+	.desc = "x86 hybrid",
+	.test_cases = hybrid_tests,
+};
 
 struct test_suite *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
@@ -35,5 +44,6 @@ struct test_suite *arch_tests[] = {
 	&suite__bp_modify,
 #endif
 	&suite__x86_sample_parsing,
+	&suite__hybrid,
 	NULL,
 };
diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
new file mode 100644
index 000000000000..0f99cfd116ee
--- /dev/null
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arch-tests.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "pmu-hybrid.h"
+#include "tests/tests.h"
+
+static bool test_config(const struct evsel *evsel, __u64 expected_config)
+{
+	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
+}
+
+static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	return TEST_OK;
+}
+
+static int test__hybrid_hw_group_event(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+	return TEST_OK;
+}
+
+static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+	return TEST_OK;
+}
+
+static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+	return TEST_OK;
+}
+
+static int test__hybrid_group_modifier1(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
+	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+	return TEST_OK;
+}
+
+static int test__hybrid_raw1(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
+		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+		return TEST_OK;
+	}
+
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+
+	/* The type of second event is randome value */
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+	return TEST_OK;
+}
+
+static int test__hybrid_raw2(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+	return TEST_OK;
+}
+
+static int test__hybrid_cache_event(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x2 == (evsel->core.attr.config & 0xffffffff));
+	return TEST_OK;
+}
+
+static int test__checkevent_pmu(struct evlist *evlist)
+{
+
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config",    10 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
+	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
+	TEST_ASSERT_VAL("wrong config3",    0 == evsel->core.attr.config3);
+	/*
+	 * The period value gets configured within evlist__config,
+	 * while this test executes only parse events method.
+	 */
+	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
+
+	return TEST_OK;
+}
+
+struct evlist_test {
+	const char *name;
+	bool (*valid)(void);
+	int (*check)(struct evlist *evlist);
+};
+
+static const struct evlist_test test__hybrid_events[] = {
+	{
+		.name  = "cpu_core/cpu-cycles/",
+		.check = test__hybrid_hw_event_with_pmu,
+		/* 0 */
+	},
+	{
+		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
+		.check = test__hybrid_hw_group_event,
+		/* 1 */
+	},
+	{
+		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
+		.check = test__hybrid_sw_hw_group_event,
+		/* 2 */
+	},
+	{
+		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
+		.check = test__hybrid_hw_sw_group_event,
+		/* 3 */
+	},
+	{
+		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
+		.check = test__hybrid_group_modifier1,
+		/* 4 */
+	},
+	{
+		.name  = "r1a",
+		.check = test__hybrid_raw1,
+		/* 5 */
+	},
+	{
+		.name  = "cpu_core/r1a/",
+		.check = test__hybrid_raw2,
+		/* 6 */
+	},
+	{
+		.name  = "cpu_core/config=10,config1,config2=3,period=1000/u",
+		.check = test__checkevent_pmu,
+		/* 7 */
+	},
+	{
+		.name  = "cpu_core/LLC-loads/",
+		.check = test__hybrid_cache_event,
+		/* 8 */
+	},
+};
+
+static int test_event(const struct evlist_test *e)
+{
+	struct parse_events_error err;
+	struct evlist *evlist;
+	int ret;
+
+	if (e->valid && !e->valid()) {
+		pr_debug("... SKIP\n");
+		return TEST_OK;
+	}
+
+	evlist = evlist__new();
+	if (evlist == NULL) {
+		pr_err("Failed allocation");
+		return TEST_FAIL;
+	}
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, e->name, &err);
+	if (ret) {
+		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
+			 e->name, ret, err.str);
+		parse_events_error__print(&err, e->name);
+		ret = TEST_FAIL;
+		if (strstr(err.str, "can't access trace events"))
+			ret = TEST_SKIP;
+	} else {
+		ret = e->check(evlist);
+	}
+	parse_events_error__exit(&err);
+	evlist__delete(evlist);
+
+	return ret;
+}
+
+static int combine_test_results(int existing, int latest)
+{
+	if (existing == TEST_FAIL)
+		return TEST_FAIL;
+	if (existing == TEST_SKIP)
+		return latest == TEST_OK ? TEST_SKIP : latest;
+	return latest;
+}
+
+static int test_events(const struct evlist_test *events, int cnt)
+{
+	int ret = TEST_OK;
+
+	for (int i = 0; i < cnt; i++) {
+		const struct evlist_test *e = &events[i];
+		int test_ret;
+
+		pr_debug("running test %d '%s'\n", i, e->name);
+		test_ret = test_event(e);
+		if (test_ret != TEST_OK) {
+			pr_debug("Event test failure: test %d '%s'", i, e->name);
+			ret = combine_test_results(ret, test_ret);
+		}
+	}
+
+	return ret;
+}
+
+int test__hybrid(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	if (!perf_pmu__has_hybrid())
+		return TEST_SKIP;
+
+	return test_events(test__hybrid_events, ARRAY_SIZE(test__hybrid_events));
+}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index cb976765b8b0..15fec7f01315 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -6,7 +6,6 @@
 #include "tests.h"
 #include "debug.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
 #include "pmus.h"
 #include <dirent.h>
 #include <errno.h>
@@ -1509,127 +1508,6 @@ static int test__all_tracepoints(struct evlist *evlist)
 }
 #endif /* HAVE_LIBTRACEVENT */
 
-static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
-{
-	struct evsel *evsel = evlist__first(evlist);
-
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
-	return TEST_OK;
-}
-
-static int test__hybrid_hw_group_event(struct evlist *evlist)
-{
-	struct evsel *evsel, *leader;
-
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return TEST_OK;
-}
-
-static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
-{
-	struct evsel *evsel, *leader;
-
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return TEST_OK;
-}
-
-static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
-{
-	struct evsel *evsel, *leader;
-
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return TEST_OK;
-}
-
-static int test__hybrid_group_modifier1(struct evlist *evlist)
-{
-	struct evsel *evsel, *leader;
-
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x3c));
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0xc0));
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	return TEST_OK;
-}
-
-static int test__hybrid_raw1(struct evlist *evlist)
-{
-	struct evsel *evsel = evlist__first(evlist);
-
-	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
-		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
-		return TEST_OK;
-	}
-
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
-
-	/* The type of second event is randome value */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
-	return TEST_OK;
-}
-
-static int test__hybrid_raw2(struct evlist *evlist)
-{
-	struct evsel *evsel = evlist__first(evlist);
-
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
-	return TEST_OK;
-}
-
-static int test__hybrid_cache_event(struct evlist *evlist)
-{
-	struct evsel *evsel = evlist__first(evlist);
-
-	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x2 == (evsel->core.attr.config & 0xffffffff));
-	return TEST_OK;
-}
-
 struct evlist_test {
 	const char *name;
 	bool (*valid)(void);
@@ -1997,54 +1875,6 @@ static const struct terms_test test__terms[] = {
 	},
 };
 
-static const struct evlist_test test__hybrid_events[] = {
-	{
-		.name  = "cpu_core/cpu-cycles/",
-		.check = test__hybrid_hw_event_with_pmu,
-		/* 0 */
-	},
-	{
-		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
-		.check = test__hybrid_hw_group_event,
-		/* 1 */
-	},
-	{
-		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
-		.check = test__hybrid_sw_hw_group_event,
-		/* 2 */
-	},
-	{
-		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
-		.check = test__hybrid_hw_sw_group_event,
-		/* 3 */
-	},
-	{
-		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
-		.check = test__hybrid_group_modifier1,
-		/* 4 */
-	},
-	{
-		.name  = "r1a",
-		.check = test__hybrid_raw1,
-		/* 5 */
-	},
-	{
-		.name  = "cpu_core/r1a/",
-		.check = test__hybrid_raw2,
-		/* 6 */
-	},
-	{
-		.name  = "cpu_core/config=10,config1,config2=3,period=1000/u",
-		.check = test__checkevent_pmu,
-		/* 7 */
-	},
-	{
-		.name  = "cpu_core/LLC-loads/",
-		.check = test__hybrid_cache_event,
-		/* 8 */
-	},
-};
-
 static int test_event(const struct evlist_test *e)
 {
 	struct parse_events_error err;
@@ -2307,14 +2137,6 @@ static bool test_alias(char **event, char **alias)
 	return false;
 }
 
-static int test__hybrid(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
-{
-	if (!perf_pmu__has_hybrid())
-		return TEST_SKIP;
-
-	return test_events(test__hybrid_events, ARRAY_SIZE(test__hybrid_events));
-}
-
 static int test__checkevent_pmu_events_alias(struct evlist *evlist)
 {
 	struct evsel *evsel1 = evlist__first(evlist);
@@ -2378,9 +2200,6 @@ static struct test_case tests__parse_events[] = {
 	TEST_CASE_REASON("Test event parsing",
 			 events2,
 			 "permissions"),
-	TEST_CASE_REASON("Test parsing of \"hybrid\" CPU events",
-			 hybrid,
-			"not hybrid"),
 	TEST_CASE_REASON("Parsing of all PMU events from sysfs",
 			 pmu_events,
 			 "permissions"),
-- 
2.40.1.495.gc816e09b53d-goog

