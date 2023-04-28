Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22A6F128A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbjD1Hkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjD1Hkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:40:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA446AC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552cb28adfeso87479107b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667607; x=1685259607;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qq4G/Esc0Oue6FYAx7cV0j1FiAAwFCfIaU2APuStCt4=;
        b=wl+uGpYkga/+gsi520y+IfuDtokWE1MMn/hq9MWVqwzovUkgbz1YO+jXELauNVj+Wm
         fhyn8C7fb8k7K2RS/hHmOhpWlud19czD5ZjDU603nmVdDm4ALQ9+ouqC89AmbXXaFyuX
         vshhMgMW5e1AcIxcqZZA8qF8/gnc+V2DdDTS9x7XH8Rs2BFd8SdqDxHTU21n0BTiZbAa
         jKqB7u9FMOaNgwxVsbkCRJsnYLVlhcbdxy+6nYM9QmjEHPhiONVnEpyFspuNszc2gJC9
         /5C+Wg2H65ry1nV8+TREbFZubQnBaRFQt3CIFENePpNj89hgLUjWcTTBPQx7rwqh7Iej
         3Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667607; x=1685259607;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qq4G/Esc0Oue6FYAx7cV0j1FiAAwFCfIaU2APuStCt4=;
        b=CfdPPn5mpw/Hs03GpJbrGCZzBfW5wHRgTMtX+zkLwr6ToHQyUKCbRRnX8SfZvmr4NF
         waPfBDF+ZwpT7gjWzKaHp5BIqZb8L7xTjK72DstRAdFnpp2oNgmHGS7SZ3WBW9n3Vo3b
         LLust+PZw5lR++UhtS00N1Sod95vnWXCjMXVHuqJam76oQbW0G/+HbiNEqrWHntufrGL
         sJluw2T9rg+4pcjwoU79v4R285yG0r9smwdmUu5r2cCHO1L83q3T53bl9LhoKLS3AicV
         kRztY4iW7EcxSr2FdEwGIoMBt1R46lG78S6TmxMpOkavvqKQVGRw+b6TDNX2L1aw+5vO
         ayyw==
X-Gm-Message-State: AC+VfDxIEBBhSx4EbjTRdfIkciMz8Xs5OJSVmrZmWesk9zPxYZ07VF9F
        gAFOr+Q4h2q86Vf+0GKeLPGGga5oaaLd
X-Google-Smtp-Source: ACHHUZ6E2vk6xSJry54MCPzGwPR+YrYXjS9lrElpk9ypg3Ac51kL8KYyoucQ9SyRwjdCFU77p/FYg19XCAaU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a81:ef04:0:b0:543:bbdb:8c2b with SMTP id
 o4-20020a81ef04000000b00543bbdb8c2bmr2672792ywm.10.1682667606810; Fri, 28 Apr
 2023 00:40:06 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:37 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-12-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 11/43] perf test: Use valid for PMU tests
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

Rather than skip all tests in test__events_pmu if PMU cpu isn't
present, use the per-test valid test. This allows the running of
software PMU tests on hybrid and arm systems.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 35b35a5c795c..767b296b91e4 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1430,6 +1430,11 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	return TEST_OK;
 }
 
+static bool test__pmu_cpu_valid(void)
+{
+	return !!perf_pmu__find("cpu");
+}
+
 static bool test__intel_pt_valid(void)
 {
 	return !!perf_pmu__find("intel_pt");
@@ -1979,21 +1984,25 @@ static const struct evlist_test test__events[] = {
 static const struct evlist_test test__events_pmu[] = {
 	{
 		.name  = "cpu/config=10,config1,config2=3,period=1000/u",
+		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_pmu,
 		/* 0 */
 	},
 	{
 		.name  = "cpu/config=1,name=krava/u,cpu/config=2/u",
+		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_pmu_name,
 		/* 1 */
 	},
 	{
 		.name  = "cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/",
+		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_pmu_partial_time_callgraph,
 		/* 2 */
 	},
 	{
 		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
+		.valid = test__pmu_cpu_valid,
 		.check = test__checkevent_complex_name,
 		/* 3 */
 	},
@@ -2209,21 +2218,6 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
 	return test_terms(test__terms, ARRAY_SIZE(test__terms));
 }
 
-static int test_pmu(void)
-{
-	struct stat st;
-	char path[PATH_MAX];
-	int ret;
-
-	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/format/",
-		 sysfs__mountpoint());
-
-	ret = stat(path, &st);
-	if (ret)
-		pr_debug("omitting PMU cpu tests\n");
-	return !ret;
-}
-
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_pmu *pmu;
@@ -2307,9 +2301,6 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 
 static int test__pmu_events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	if (!test_pmu())
-		return TEST_SKIP;
-
 	return test_events(test__events_pmu, ARRAY_SIZE(test__events_pmu));
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

