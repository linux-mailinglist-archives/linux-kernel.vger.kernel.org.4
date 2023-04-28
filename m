Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2006F1288
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345612AbjD1Hkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbjD1Hkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:40:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BADE4C03
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7c58ec19so1906692276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667599; x=1685259599;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0dr9db51Jq/RsQdl+jWHc6lduK3C41zW9xfdl5Qlv8=;
        b=ewLTh6orGi24TO5rSZ4qxWQLztSdIuc/hM+uQupBczCiHYpZN1V+/Oy3I4ilMm/xZ1
         8wtVAoPH3w3H7w55dV9yJ4jOxfAtfGqWFQdRlshe8W3dXuaVsFxhXTOh9k/F+gbJzrbH
         qwLG2P3NbVaiRntc6Uj+ciouoECXurA1D3SFAzJgsbPdLl4uAf2Wupr337pv1i2oJxEZ
         wVFpziAJeiMlHwVVHCz7+wjkFZFQIcutQ8T899UC3UQwIWdWuQ4k7EYOuTynF9FHQFrZ
         43zunt3xVhcm+XtDn32ReECBI5oC9fWsTzxFue6KUreubdqDTVJ+yotDHRuTsk+A7eiH
         RW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667599; x=1685259599;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0dr9db51Jq/RsQdl+jWHc6lduK3C41zW9xfdl5Qlv8=;
        b=gIxMCiFdM9cccMrMYDsct8UL4iwS1Va8d6QO8S5BJitGxXvuN2zRyS0obTAxdCUt6C
         CR4UMXjX6bSGfep/bpdMKUNFM9OkS1A+XrlgQqMSWI2IYfcgYpASSx+f7bZGDOhb3rYs
         fzl2Gmch5ILuWfe94a0ziHFF1DfzXrpcLxaAdNURm6fyqJAWTL4KBE0yUDAO5bo1y0C/
         lGa9Uk06QbYuF3d3zmQ5tk7FKgjbnzUErzRq6cSr64ojbW2LFzdC5AjDNXcB8bb1/IYE
         ju9sFC3Xc7yfmeEBmRHbjv9r2tRkdocfrh3cXaZv0Rms4m3xzBDIoIV6SpmzPzGF2dXN
         Ik/A==
X-Gm-Message-State: AC+VfDzfWMGOMhSedjUckCjV/z2bWlimQRqNyBIZGJJI3L0zdhBwapUe
        A2tzNucA5z+gvfqGrTnRlyBhMIg/1vsu
X-Google-Smtp-Source: ACHHUZ72JqiGVUpS4l1s/IPwZGgQi3bg2pWBgyFpuMBYG2WiARwboDKTq9Z4TAbVj25gr9qEyQ0Xo31MqWnq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b8f:54f5:89ff with SMTP
 id w3-20020a056902100300b00b8f54f589ffmr2582980ybt.11.1682667599608; Fri, 28
 Apr 2023 00:39:59 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:36 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-11-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 10/43] perf test: Test more sysfs events
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse events for all PMUs, and not just cpu, in test "Parsing of all
PMU events from sysfs".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 121 +++++++++++++++++---------------
 1 file changed, 65 insertions(+), 56 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8068cfd89b84..35b35a5c795c 100644
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
@@ -2225,74 +2226,82 @@ static int test_pmu(void)
 
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct stat st;
-	char path[PATH_MAX];
-	struct dirent *ent;
-	DIR *dir;
-	int ret;
+	struct perf_pmu *pmu;
+	int ret = TEST_OK;
 
-	if (!test_pmu())
-		return TEST_SKIP;
+	perf_pmus__for_each_pmu(pmu) {
+		struct stat st;
+		char path[PATH_MAX];
+		struct dirent *ent;
+		DIR *dir;
+		int err;
 
-	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/",
-		 sysfs__mountpoint());
+		snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/",
+			sysfs__mountpoint(), pmu->name);
 
-	ret = stat(path, &st);
-	if (ret) {
-		pr_debug("omitting PMU cpu events tests: %s\n", path);
-		return TEST_OK;
-	}
+		err = stat(path, &st);
+		if (err) {
+			pr_debug("skipping PMU %s events tests: %s\n", pmu->name, path);
+			ret = combine_test_results(ret, TEST_SKIP);
+			continue;
+		}
 
-	dir = opendir(path);
-	if (!dir) {
-		pr_debug("can't open pmu event dir: %s\n", path);
-		return TEST_FAIL;
-	}
+		dir = opendir(path);
+		if (!dir) {
+			pr_debug("can't open pmu event dir: %s\n", path);
+			ret = combine_test_results(ret, TEST_SKIP);
+			continue;
+		}
 
-	ret = TEST_OK;
-	while ((ent = readdir(dir))) {
-		struct evlist_test e = { .name = NULL, };
-		char name[2 * NAME_MAX + 1 + 12 + 3];
-		int test_ret;
+		while ((ent = readdir(dir))) {
+			struct evlist_test e = { .name = NULL, };
+			char name[2 * NAME_MAX + 1 + 12 + 3];
+			int test_ret;
 
-		/* Names containing . are special and cannot be used directly */
-		if (strchr(ent->d_name, '.'))
-			continue;
+			/* Names containing . are special and cannot be used directly */
+			if (strchr(ent->d_name, '.'))
+				continue;
 
-		snprintf(name, sizeof(name), "cpu/event=%s/u", ent->d_name);
+			snprintf(name, sizeof(name), "%s/event=%s/u", pmu->name, ent->d_name);
 
-		e.name  = name;
-		e.check = test__checkevent_pmu_events;
+			e.name  = name;
+			e.check = test__checkevent_pmu_events;
 
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
+			test_ret = test_event(&e);
+			if (test_ret != TEST_OK) {
+				pr_debug("Test PMU event failed for '%s'", name);
+				ret = combine_test_results(ret, test_ret);
+			}
 
-		snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
-		e.name  = name;
-		e.check = test__checkevent_pmu_events_mix;
-		test_ret = test_event(&e);
-		if (test_ret != TEST_OK) {
-			pr_debug("Test PMU event failed for '%s'", name);
-			ret = combine_test_results(ret, test_ret);
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

