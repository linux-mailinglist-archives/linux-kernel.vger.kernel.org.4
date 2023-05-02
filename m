Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079966F4CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjEBWlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEBWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:41:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1A93A9A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:40:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7c45b8e1so7730734276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067229; x=1685659229;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOnZ2OKjlCq2CMx90UX2ZPWCEDMEl/hBSCdauBOSwyg=;
        b=IoTJMyEobSDIJv1QyUDMmxGGV9wHG4+zMd6uosrqg//eIBbse9xgINyme8g2w9CntC
         DFPbZ3X8+n3aJsIiNC2/Ul7Bdojx6o5tVgszEn9B/qpRuVxKNt9Ow8hw1pKeqZLeYcd1
         IbJoq6P1NIS4QZEyvKfTKTSOANbl+4Bnau+JSClba+FF2atLEFMO2sAVnVw+Or5aZVRI
         2EfixSZzj+Q8A3CR0a47urNbRvtSK/ELNieLxZd5ikydlCWCZTF5VXkCR7GH503SqaoI
         8rESINzQAlxOqwcyWsxz/xdToKiviJMW16wIHCHkAJTqjmQrVWrfe+L0Z4A6iSbV3UTh
         JldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067229; x=1685659229;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOnZ2OKjlCq2CMx90UX2ZPWCEDMEl/hBSCdauBOSwyg=;
        b=a2V59TNnp5oSj80nGqKsjeYikIG1LUyLVQ0qSLQlcECxwT076XktV73Zy4GxcRuHdH
         dlNWpsVjvZ7KL8DA8BbMVB00wFhR/nk8PenHQcLQoWH5jaOBeS4JFuHaPp4djcupaCKc
         uZMc4xvo5BpBxSB3vT4pF8N0S/T3G44YVvyGLTt4UcErb26SL/hjyNzquLzu6mZvhS2R
         61bNSPQ7dRPT+kgegE52ly402U0iQgHdNcR3o66aNIVqBh2EWVmytlpMQ40q6zdAcMMH
         wP31AWGMR8dzUC7s1wilkYeu/4W0WZGY5JkGsncUZdTk5vNLs90K6iBwSx0+YvSHaHyF
         +sew==
X-Gm-Message-State: AC+VfDzJZTbWSCNLpv/vT8L0KDDdm6gMMfAVZ5xKWTKMKobSExouRICM
        AYBKe6N9pB1m88X5hE4AceGTMEi1owVn
X-Google-Smtp-Source: ACHHUZ7bkS+Y09SwE9jvgupciznHDby6NANZZhdZ47txsHbvKXbziwG5oshPrZcmZcSd7aM/aAZ/WxBv1xJX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:d250:0:b0:b9e:2f92:52b with SMTP id
 j77-20020a25d250000000b00b9e2f92052bmr2684908ybg.2.1683067229666; Tue, 02 May
 2023 15:40:29 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:18 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-12-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 11/44] perf test: Use valid for PMU tests
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

Rather than skip all tests in test__events_pmu if PMU cpu isn't
present, use the per-test valid test. This allows the running of
software PMU tests on hybrid and arm systems.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 3721a2182f45..c06fa7653ac2 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1432,6 +1432,11 @@ static int test__checkevent_config_cache(struct evlist *evlist)
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
@@ -1981,21 +1986,25 @@ static const struct evlist_test test__events[] = {
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
@@ -2211,21 +2220,6 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
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
@@ -2311,9 +2305,6 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 
 static int test__pmu_events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	if (!test_pmu())
-		return TEST_SKIP;
-
 	return test_events(test__events_pmu, ARRAY_SIZE(test__events_pmu));
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

