Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27696EEECB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbjDZHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjDZHDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:03:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23EC3581
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5529a6f9f28so101470707b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492557; x=1685084557;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGMhDh/Xxfc/617r/znj1e9S4uhjiiI/jhf4ibmGn/I=;
        b=FhKZ0DbW98MwDW0YYRBsJErMz6DD3KZB3q5XqWRRfggSzXjVsDbhf1nBN17cgMT4bj
         cpMm9pfQsbCSWHdFa+1SzDjDuMaiWZjrYLDHpkDJNeRaTdnF2HB9S956VcP/iEJ8+o3R
         KA23U2jsY/mZlYdg4AJhxyF/2zOAzV9vUUAVoK2QzhcjPT+qhhofQh0DxcJsePhv5bcx
         MMtqxDVJIwhctmaofnNPxZMOJOOOl0o0gP7fsKw2nUXXW8jseH05+zKAKWXGeX433JpL
         0L3MydqE9IAuyp4Muf6R+jq/OuuTqmNjy3IIjKrC9UCHWfiNTgl8gYbOK4yjB4NMWuX4
         FIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492557; x=1685084557;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGMhDh/Xxfc/617r/znj1e9S4uhjiiI/jhf4ibmGn/I=;
        b=DuA+3GztQOrscXsTUMrP2Gfxoewv8G3/qvXtQLfi3QrNXTR25oGX4d7NmToLVD8hMb
         OmvCQwq136DiGhvW0yTjaK0Te0qh7xchObgbYITOl/U9ICwKDnw/SpcRVewp8xTDuHy+
         bN+f/EgVKMt1OJh9VOv48G9LUeDQZDa+IMZUHVKeu311fOygjAoQTJL4+s39VMuRl74Q
         pX2EHqIzirce7WkcPB7QVHJ37CWgp81QlujwMhDfEm92kPaqcUcIpagSApRZXGYAntCt
         V4uVRt3+60ptwpYN67UfuvsFBxKVtGrNTOr6Fb8lW/mRzmcOx3WUXyJzLOPvot42m0iS
         4v3Q==
X-Gm-Message-State: AAQBX9dg6wu2aFGfMGnqSSikwsdDW1n2wTimqG1vUtpbsERo4mp3mueJ
        74Llqpiu5n2o7dg7Jn0/YZ4WxgYKPuPj
X-Google-Smtp-Source: AKy350bakCIOKOTTUH+ySM6QN5fHzmW7rOWqtxS5zVWWvQEvHYfEyG9m9mkU8RLrIUjIpMZbllarcMAar391
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a81:4425:0:b0:552:d924:a304 with SMTP id
 r37-20020a814425000000b00552d924a304mr9106383ywa.4.1682492557276; Wed, 26 Apr
 2023 00:02:37 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:22 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-13-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 12/40] perf test: Roundtrip name, don't assume 1 event per name
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

Opening hardware names and a legacy cache event on a hybrid PMU opens
it on each PMU. Parsing and checking indexes fails, as the parsed
index is double the expected. Avoid checking the index by just
comparing the names immediately after the parse.

This change removes hard coded hybrid logic and removes assumptions
about the expansion of an event. On hybrid the PMUs may or may not
support an event and so using a distance isn't a consistent solution.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/evsel-roundtrip-name.c | 119 ++++++++++--------------
 1 file changed, 49 insertions(+), 70 deletions(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index e94fed901992..15ff86f9da0b 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -4,114 +4,93 @@
 #include "parse-events.h"
 #include "tests.h"
 #include "debug.h"
-#include "pmu.h"
-#include "pmu-hybrid.h"
-#include <errno.h>
 #include <linux/kernel.h>
 
 static int perf_evsel__roundtrip_cache_name_test(void)
 {
-	char name[128];
-	int type, op, err = 0, ret = 0, i, idx;
-	struct evsel *evsel;
-	struct evlist *evlist = evlist__new();
+	int ret = TEST_OK;
 
-        if (evlist == NULL)
-                return -ENOMEM;
-
-	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
+	for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
+		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
 			/* skip invalid cache type */
 			if (!evsel__is_cache_op_valid(type, op))
 				continue;
 
-			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				err = parse_event(evlist, name);
-				if (err)
-					ret = err;
-			}
-		}
-	}
-
-	idx = 0;
-	evsel = evlist__first(evlist);
+			for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
+				char name[128];
+				struct evlist *evlist = evlist__new();
+				struct evsel *evsel;
+				int err;
 
-	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
-			/* skip invalid cache type */
-			if (!evsel__is_cache_op_valid(type, op))
-				continue;
+				if (evlist == NULL) {
+					pr_debug("Failed to alloc evlist");
+					return TEST_FAIL;
+				}
+				__evsel__hw_cache_type_op_res_name(type, op, res,
+								name, sizeof(name));
 
-			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				if (evsel->core.idx != idx)
+				err = parse_event(evlist, name);
+				if (err) {
+					pr_debug("Failure to parse cache event '%s' possibly as PMUs don't support it",
+						name);
+					evlist__delete(evlist);
 					continue;
-
-				++idx;
-
-				if (strcmp(evsel__name(evsel), name)) {
-					pr_debug("%s != %s\n", evsel__name(evsel), name);
-					ret = -1;
 				}
-
-				evsel = evsel__next(evsel);
+				evlist__for_each_entry(evlist, evsel) {
+					if (strcmp(evsel__name(evsel), name)) {
+						pr_debug("%s != %s\n", evsel__name(evsel), name);
+						ret = TEST_FAIL;
+					}
+				}
+				evlist__delete(evlist);
 			}
 		}
 	}
-
-	evlist__delete(evlist);
 	return ret;
 }
 
-static int __perf_evsel__name_array_test(const char *const names[], int nr_names,
-					 int distance)
+static int perf_evsel__name_array_test(const char *const names[], int nr_names)
 {
-	int i, err;
-	struct evsel *evsel;
-	struct evlist *evlist = evlist__new();
+	int ret = TEST_OK;
 
-        if (evlist == NULL)
-                return -ENOMEM;
+	for (int i = 0; i < nr_names; ++i) {
+		struct evlist *evlist = evlist__new();
+		struct evsel *evsel;
+		int err;
 
-	for (i = 0; i < nr_names; ++i) {
+		if (evlist == NULL) {
+			pr_debug("Failed to alloc evlist");
+			return TEST_FAIL;
+		}
 		err = parse_event(evlist, names[i]);
 		if (err) {
 			pr_debug("failed to parse event '%s', err %d\n",
 				 names[i], err);
-			goto out_delete_evlist;
+			evlist__delete(evlist);
+			ret = TEST_FAIL;
+			continue;
 		}
-	}
-
-	err = 0;
-	evlist__for_each_entry(evlist, evsel) {
-		if (strcmp(evsel__name(evsel), names[evsel->core.idx / distance])) {
-			--err;
-			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->core.idx / distance]);
+		evlist__for_each_entry(evlist, evsel) {
+			if (strcmp(evsel__name(evsel), names[i])) {
+				pr_debug("%s != %s\n", evsel__name(evsel), names[i]);
+				ret = TEST_FAIL;
+			}
 		}
+		evlist__delete(evlist);
 	}
-
-out_delete_evlist:
-	evlist__delete(evlist);
-	return err;
+	return ret;
 }
 
-#define perf_evsel__name_array_test(names, distance) \
-	__perf_evsel__name_array_test(names, ARRAY_SIZE(names), distance)
-
 static int test__perf_evsel__roundtrip_name_test(struct test_suite *test __maybe_unused,
 						 int subtest __maybe_unused)
 {
-	int err = 0, ret = 0;
-
-	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom"))
-		return perf_evsel__name_array_test(evsel__hw_names, 2);
+	int err = 0, ret = TEST_OK;
 
-	err = perf_evsel__name_array_test(evsel__hw_names, 1);
+	err = perf_evsel__name_array_test(evsel__hw_names, PERF_COUNT_HW_MAX);
 	if (err)
 		ret = err;
 
-	err = __perf_evsel__name_array_test(evsel__sw_names, PERF_COUNT_SW_DUMMY + 1, 1);
+	err = perf_evsel__name_array_test(evsel__sw_names, PERF_COUNT_SW_DUMMY + 1);
 	if (err)
 		ret = err;
 
-- 
2.40.1.495.gc816e09b53d-goog

