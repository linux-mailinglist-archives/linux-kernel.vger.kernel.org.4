Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8F6F4CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjEBWlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjEBWk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:40:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13E358E
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:40:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552f2f940edso84337997b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067222; x=1685659222;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hc6sYqaX/JTEzA/WD5PdQqzvPbvzN/Ao//5MFid2Dk=;
        b=cPM/XeaYqW8ATEh2et7lHdr0dAMzZNIm5WbuxFf8j8j45I0GkN69BbdrMqfbvtTjFz
         /rwgkYHSWC2gH7+pVPv4Tep2Zl1i4ofTcxJWGu21WQU5f2n+npUt3CnreJzRJfB0Vuuc
         DRLXb+f4x0X3cZe4SFAa3gfzN7lHKQU0gtpHFQOZ3H2Ald2QdjFk/xpj2qKEhrAn+EoH
         kt7DdfJLOuiwhz9l+SqgE85rpt5CJDQtCeQYyHkr7RX09hbO0RTSaiXsSo6u3mg3oXkJ
         bWUtBTofyZCuUyzSy8IIZZWqd6+PoU69fjDSZ/yuISJ9duzO3QAhqmVIFpUU3eFVgrp9
         cOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067222; x=1685659222;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hc6sYqaX/JTEzA/WD5PdQqzvPbvzN/Ao//5MFid2Dk=;
        b=XhsPtfRnYhVfaqAHWS/qiHv0DLxwC9HmA2RKJ1l6mwsKXY3fu+9Kllg9UkU3YUy2Mc
         Ixc5Y2cgZcFVXpsEQ2/Mke13NgGbugD3sY9t62A4F5Lg3xtLLHwSFo72pKvWrMpZ1XTo
         vGQcfAgqSErOEfka/Kuzl2n19tJ1qu/KDU34e6R0tpmrnYdNKe3vRO3mXznuhjDrjiTR
         /JPTEMac9K8e9ZJy7zPp7Tv9Dqx7+q9QmjvKroe8idmxSky6HwDVYLUmBGYsXNwzvMsj
         iREEKBrcWh6anE3i7NlAbYzw/X+IJDni3bP0Voh9/E2Vz8+Yv+tmyl6YniHFc6Z48auZ
         MlSA==
X-Gm-Message-State: AC+VfDyCnWy/hxUEvATpSCeqo6wBxVB1VhY9JkYj064UdSNQJXD8Bc+r
        LHn+Zp7Mt0m6lk2pkKxKcblEPt976puR
X-Google-Smtp-Source: ACHHUZ6aqJfkF1DqLqV5dk0PcZwobR7Cpms4xHZeUifk8XAn1c6w2Zms4SRaNZSJKKQ3uNmdCClNiXbd+SuL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:a8c4:0:b0:556:edb1:1fb0 with SMTP id
 f187-20020a81a8c4000000b00556edb11fb0mr11609056ywh.10.1683067222531; Tue, 02
 May 2023 15:40:22 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:17 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-11-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 10/44] perf test: Test more sysfs events
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

Parse events for all PMUs, and not just cpu, in test "Parsing of all
PMU events from sysfs".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 129 ++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 58 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8068cfd89b84..3721a2182f45 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -7,6 +7,7 @@
 #include "debug.h"
 #include "pmu.h"
 #include "pmu-hybrid.h"
+#include "pmus.h"
 #include <dirent.h>
 #include <errno.h>
 #include "fncache.h"
@@ -558,7 +559,8 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
+				      strcmp(evsel->pmu_name, "cpu"));
 	TEST_ASSERT_VAL("wrong exclude_user",
 			!evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel",
@@ -590,7 +592,8 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	/* cpu/pmu-event/u*/
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
+				      strcmp(evsel->pmu_name, "cpu"));
 	TEST_ASSERT_VAL("wrong exclude_user",
 			!evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel",
@@ -2225,74 +2228,84 @@ static int test_pmu(void)
 
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct stat st;
-	char path[PATH_MAX];
-	struct dirent *ent;
-	DIR *dir;
-	int ret;
-
-	if (!test_pmu())
-		return TEST_SKIP;
+	struct perf_pmu *pmu;
+	int ret = TEST_OK;
 
-	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/",
-		 sysfs__mountpoint());
+	if (list_empty(&pmus))
+		perf_pmu__scan(NULL);
 
-	ret = stat(path, &st);
-	if (ret) {
-		pr_debug("omitting PMU cpu events tests: %s\n", path);
-		return TEST_OK;
-	}
+	perf_pmus__for_each_pmu(pmu) {
+		struct stat st;
+		char path[PATH_MAX];
+		struct dirent *ent;
+		DIR *dir;
+		int err;
 
-	dir = opendir(path);
-	if (!dir) {
-		pr_debug("can't open pmu event dir: %s\n", path);
-		return TEST_FAIL;
-	}
+		snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/",
+			sysfs__mountpoint(), pmu->name);
 
-	ret = TEST_OK;
-	while ((ent = readdir(dir))) {
-		struct evlist_test e = { .name = NULL, };
-		char name[2 * NAME_MAX + 1 + 12 + 3];
-		int test_ret;
+		err = stat(path, &st);
+		if (err) {
+			pr_debug("skipping PMU %s events tests: %s\n", pmu->name, path);
+			continue;
+		}
 
-		/* Names containing . are special and cannot be used directly */
-		if (strchr(ent->d_name, '.'))
+		dir = opendir(path);
+		if (!dir) {
+			pr_debug("can't open pmu event dir: %s\n", path);
+			ret = combine_test_results(ret, TEST_SKIP);
 			continue;
+		}
 
-		snprintf(name, sizeof(name), "cpu/event=%s/u", ent->d_name);
+		while ((ent = readdir(dir))) {
+			struct evlist_test e = { .name = NULL, };
+			char name[2 * NAME_MAX + 1 + 12 + 3];
+			int test_ret;
 
-		e.name  = name;
-		e.check = test__checkevent_pmu_events;
+			/* Names containing . are special and cannot be used directly */
+			if (strchr(ent->d_name, '.'))
+				continue;
 
-		test_ret = test_event(&e);
-		if (test_ret != TEST_OK) {
-			pr_debug("Test PMU event failed for '%s'", name);
-			ret = combine_test_results(ret, test_ret);
-		}
-		/*
-		 * Names containing '-' are recognized as prefixes and suffixes
-		 * due to '-' being a legacy PMU separator. This fails when the
-		 * prefix or suffix collides with an existing legacy token. For
-		 * example, branch-brs has a prefix (branch) that collides with
-		 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
-		 * isn't expected after this. As event names in the config
-		 * slashes are allowed a '-' in the name we check this works
-		 * above.
-		 */
-		if (strchr(ent->d_name, '-'))
-			continue;
+			snprintf(name, sizeof(name), "%s/event=%s/u", pmu->name, ent->d_name);
 
-		snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
-		e.name  = name;
-		e.check = test__checkevent_pmu_events_mix;
-		test_ret = test_event(&e);
-		if (test_ret != TEST_OK) {
-			pr_debug("Test PMU event failed for '%s'", name);
-			ret = combine_test_results(ret, test_ret);
+			e.name  = name;
+			e.check = test__checkevent_pmu_events;
+
+			test_ret = test_event(&e);
+			if (test_ret != TEST_OK) {
+				pr_debug("Test PMU event failed for '%s'", name);
+				ret = combine_test_results(ret, test_ret);
+			}
+
+			if (!is_pmu_core(pmu->name))
+				continue;
+
+			/*
+			 * Names containing '-' are recognized as prefixes and suffixes
+			 * due to '-' being a legacy PMU separator. This fails when the
+			 * prefix or suffix collides with an existing legacy token. For
+			 * example, branch-brs has a prefix (branch) that collides with
+			 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
+			 * isn't expected after this. As event names in the config
+			 * slashes are allowed a '-' in the name we check this works
+			 * above.
+			 */
+			if (strchr(ent->d_name, '-'))
+				continue;
+
+			snprintf(name, sizeof(name), "%s:u,%s/event=%s/u",
+				 ent->d_name, pmu->name, ent->d_name);
+			e.name  = name;
+			e.check = test__checkevent_pmu_events_mix;
+			test_ret = test_event(&e);
+			if (test_ret != TEST_OK) {
+				pr_debug("Test PMU event failed for '%s'", name);
+				ret = combine_test_results(ret, test_ret);
+			}
 		}
-	}
 
-	closedir(dir);
+		closedir(dir);
+	}
 	return ret;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

