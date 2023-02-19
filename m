Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1369BFB9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBSJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBSJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:36:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC2126F1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:35:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536885323c1so17996037b3.15
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1iaZVlYNhiAOA5cs/+UwDX1JeW2DyTfNmupgRycGXY=;
        b=GXX1CCWTT7DpChHpiAo8vxK/43ddF9gck9mQoSZ2hA08LIJ0U1Cu7/SFYa9EJvJFxe
         m8KaqG9d0IPv1H+awLg+uCW+JyHffDXi8RxqbbHwMymD1tyKhcsbVu23oOmaI7vI3Ggo
         A8m02HvwUYluQ/hwtU5heVipo9Wh/I0ByZJ263Ywidlya5sIiWqmTKfXXSjdJB+GukoV
         TUk+iK3GL6mVBoiR/DsqTD45H27yUEHyxZf4toav9JGdIbqj/1fHLuj6CnEuBf5HvRQU
         AhDI6PM1KMSvWtTcjBjzp7iRHFEfMo2PY+iby22NhQ0i2XGrdBrVZdFwwu7jGnEkvvA1
         P5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1iaZVlYNhiAOA5cs/+UwDX1JeW2DyTfNmupgRycGXY=;
        b=S3yNglxsSfJcMJ1Gioyloib6GxEHGCu7e71UqEARRGGpldMm0niCK/ZXtozrKdKnPV
         eyypy9n7oprL+uW7beu/x74fVxlo8kY/ssobVAtKpAqTEPdPLVJVTgpsyES9Et3RVCdE
         8SgZ3nCKvHvGeQi6R6ZCqmx9nLlLNBl6dNBZA9LO6s9jU6Kc0TaGI8SBOOYauekBnONJ
         m2J1Y9oSFjqHMRP1MlZ/7eYMLSe6LhuvzE5UN05dv7L2dc2fwzsRvcCS13qOxcZperc2
         FH0cU0pz/dzRfo1IatiszHFHAXpu8zqWkND/s0au2NkwWgINv+ktX6idZfKdHATuQNOp
         rqMg==
X-Gm-Message-State: AO0yUKUyv7YY8TEs+Hu8l8bZbNvrHRu2qbu3Fo6idEgl2RekiRJ4Wxkj
        lIpzCM58sY4PSweTCYrre7qKBkanb2iS
X-Google-Smtp-Source: AK7set+1MTqVPBeVJ1iYyp/8DZ7MkvnpE8pT6AIUM7vIfURx7AFVUwdj5cGYtnDmeFMNAIrj/Jd0CiKRDfkv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a0d:ee44:0:b0:52e:e6ed:30a1 with SMTP id
 x65-20020a0dee44000000b0052ee6ed30a1mr1338109ywe.545.1676799225232; Sun, 19
 Feb 2023 01:33:45 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:31 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-35-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 34/51] perf pmu-events: Test parsing metric thresholds with
 the fake PMU
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the correctness of metric thresholds by testing them all with the
fake PMU logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 521557c396bc..db2fed0c6993 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1021,12 +1021,34 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
 	return pmu_for_each_sys_metric(test__parsing_fake_callback, NULL);
 }
 
+static int test__parsing_threshold_callback(const struct pmu_metric *pm,
+					const struct pmu_metrics_table *table __maybe_unused,
+					void *data __maybe_unused)
+{
+	if (!pm->metric_threshold)
+		return 0;
+	return metric_parse_fake(pm->metric_name, pm->metric_threshold);
+}
+
+static int test__parsing_threshold(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
+{
+	int err = 0;
+
+	err = pmu_for_each_core_metric(test__parsing_threshold_callback, NULL);
+	if (err)
+		return err;
+
+	return pmu_for_each_sys_metric(test__parsing_threshold_callback, NULL);
+}
+
 static struct test_case pmu_events_tests[] = {
 	TEST_CASE("PMU event table sanity", pmu_event_table),
 	TEST_CASE("PMU event map aliases", aliases),
 	TEST_CASE_REASON("Parsing of PMU event table metrics", parsing,
 			 "some metrics failed"),
 	TEST_CASE("Parsing of PMU event table metrics with fake PMUs", parsing_fake),
+	TEST_CASE("Parsing of metric thresholds with fake PMUs", parsing_threshold),
 	{ .name = NULL, }
 };
 
-- 
2.39.2.637.g21b0678d19-goog

