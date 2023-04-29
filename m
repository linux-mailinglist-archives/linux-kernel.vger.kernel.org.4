Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB46F2320
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbjD2Fhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347255AbjD2Fhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:37:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DE44AE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:37:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso1048433276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746625; x=1685338625;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qq4G/Esc0Oue6FYAx7cV0j1FiAAwFCfIaU2APuStCt4=;
        b=zF7VN5xIg/Xls/P70nXNmlMvwt8It/YyYoobszVrtva9rBrXtP8z0xKGNoEL5pr/nD
         9Oy3Iog+9mZWB3p1ESqM6eWUvXDmIBsWKnyGod3Q3zoJQWxEDnMuR/04H+dmYquUuakQ
         mfHoNvPS+fM6Nzf7/E1D9SI//wIrjEQnucNbh+4RqnkbRmu7Sp1PvF0xfQUJwDNamR+Q
         MsIGsX6L033DKxskwa47W82x+ONRhTo0Uo/ZLNZ3Moy4XVUB+w1bNYtayA574gp9apa4
         93jp6VBkV3qQsixhuHr4rX6akTEasJgFK7RIJHQa41s1kiT8iB2Uljv6SF3FQZk8qYxV
         XVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746625; x=1685338625;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qq4G/Esc0Oue6FYAx7cV0j1FiAAwFCfIaU2APuStCt4=;
        b=DwBifJkIm/rBjcx1poRsOWbmEmy3j22ELdeWKx5dDoUvdLjAOjVAU+BYlUfZ7Dbjco
         543TzyHV4yLJGHJ+2ZzdjeByDXsGCb6r1N/Y4lN93Tirbeni+J7vavg+KocmlUsCog02
         YyH5gIW9iTxN7WtrgYGy4aOJkjSLlP2mmqUnVygPga7hHjTWZCGgETc88+ui6a+nuW0F
         yZPOeFCdKxQ87FwwrfDCwsZ5Yvg/8PE6hwzB9DroYCb9lzKhn39VQqnPu02Zhi+9ecGb
         vbu+5KaRX+NfQ2kJxm2zx+MyEXUOp/PhK2GvakqeZHAjSK0KDwG7vXgm9Vl8MDr4GclI
         MRDA==
X-Gm-Message-State: AC+VfDz8yOYTRXSTXopevAAIwJ5GeT65603Xbsn2xz5Ue12rd5V2rCD4
        D95eUGrfLLb+gYDgVlWjpMK6TNinyEr+
X-Google-Smtp-Source: ACHHUZ5n59FgbcH2rhCiSNafqEqAfWsNzgQwBKfmroVvhkKjF7s6+OraaFq9NKh3lNG5yJBUOs+dCsZdR6Gh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a25:aea5:0:b0:b9a:78bf:1a4d with SMTP id
 b37-20020a25aea5000000b00b9a78bf1a4dmr4022294ybj.10.1682746625479; Fri, 28
 Apr 2023 22:37:05 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:33 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-14-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 13/46] perf test: Use valid for PMU tests
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

