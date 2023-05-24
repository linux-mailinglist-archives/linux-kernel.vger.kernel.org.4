Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542EF7100B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjEXWS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbjEXWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:18:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A2013A
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8338f2103so2884419276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966722; x=1687558722;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAoaFyBJOeyjHfZvGABM9yDThQmXliV0lqnBHOLa6q0=;
        b=zlbh0StDHb0NXfGfXg/X3LfsmeDzOHLH1YC1qEfX6cRN7wrLa7RBRNYltOVYHQZznF
         Qj6tcRduEffZVSuvM+NkKpIzs2/Yn/1/v2OXQHBbzm/KyggfjUhzB3z07p5R7onauVA4
         BzzwVCRgEtBeKzsW7mXUpaSM5tYjehgTBXO+RvfETWvvcrWvHyiCk1xmfjFA4tG9OXVy
         vqnu09Hp/mrjZd+mt28IXuvqkdyd+8dV2AlzFpGd4QAToETp/lnxRQrJ3dkeh5sSJRG6
         pOrHodyD/8xM3NQnw0fnY6Ff97Ye2bV9guPTrRxmve80oAhJLFbO/Iao7HNgd2Gi80I0
         y4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966722; x=1687558722;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAoaFyBJOeyjHfZvGABM9yDThQmXliV0lqnBHOLa6q0=;
        b=Cyrq9SEkcKwWGd59EwpKCb8pbtyvy04cH/xuZlPRGJPXgkz/oG5mlfF20lVisv5Rwp
         mEwb06tzD2fDgQ4VgmEGs5EMdYsAmvJt2m6YMyl4lydhSUTcbOVKuwthfNnq6Lyvt9dP
         skN+wddPRam7sGHGB+1RHlBRpZUexWc/QkwIzk+lZgA3CNoMbLt8TmzwWzQwBE9WiLTe
         WyyQq5V+0EQx5evOyXoYqY3DJlBSuC2eB3nbBaj/w9ZxVawvoV4K+X5YubB5eCNhSQPY
         qYln0Oc+VvC15qW4IfdE3/02K+Xr/4K7cifKE641hFtAIRpwHDiJ8PZCF9pyZ56HUonr
         SnHA==
X-Gm-Message-State: AC+VfDzFCT/iDWQ7iIZHFiPwGeiC0TO+UENuaI9WpiF3K1l5duhFFm8z
        4xvkMnjy3kpZ6/D2GeGMot59zJhOYQ4A
X-Google-Smtp-Source: ACHHUZ67iw6irCTpD7UvqWqkTdeLj7Zvgy/Do6A19KOegEO5oEs6WH6+/P6qeq5gp6xRG1thiKj91Wt3B8s7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:3256:0:b0:b8f:53e1:64b with SMTP id
 y83-20020a253256000000b00b8f53e1064bmr570703yby.13.1684966721885; Wed, 24 May
 2023 15:18:41 -0700 (PDT)
Date:   Wed, 24 May 2023 15:17:59 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-4-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 03/35] perf cpumap: Add equal function
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

Equality is a useful property to compare after merging and
intersecting maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 21 ++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 tools/perf/tests/cpumap.c            | 37 ++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index d4f3a1a12522..48595a3ad69c 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -321,6 +321,27 @@ bool perf_cpu_map__has(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
+bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct perf_cpu_map *rhs)
+{
+	int nr;
+
+	if (lhs == rhs)
+		return true;
+
+	if (!lhs || !rhs)
+		return false;
+
+	nr = perf_cpu_map__nr(lhs);
+	if (nr != perf_cpu_map__nr(rhs))
+		return false;
+
+	for (int idx = 0; idx < nr; idx++) {
+		if (RC_CHK_ACCESS(lhs)->map[idx].cpu != RC_CHK_ACCESS(rhs)->map[idx].cpu)
+			return false;
+	}
+	return true;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 0466c4216fbb..d0ae9552f8e2 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -28,6 +28,8 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
+LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
+				     const struct perf_cpu_map *rhs);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 83805690c209..7730fc2ab40b 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -211,11 +211,48 @@ static int test__cpu_map_intersect(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
+static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_cpu_map *any = perf_cpu_map__dummy_new();
+	struct perf_cpu_map *one = perf_cpu_map__new("1");
+	struct perf_cpu_map *two = perf_cpu_map__new("2");
+	struct perf_cpu_map *empty = perf_cpu_map__intersect(one, two);
+	struct perf_cpu_map *pair = perf_cpu_map__new("1-2");
+	struct perf_cpu_map *tmp;
+	struct perf_cpu_map *maps[] = {empty, any, one, two, pair};
+
+	for (size_t i = 0; i < ARRAY_SIZE(maps); i++) {
+		/* Maps equal themself. */
+		TEST_ASSERT_VAL("equal", perf_cpu_map__equal(maps[i], maps[i]));
+		for (size_t j = 0; j < ARRAY_SIZE(maps); j++) {
+			/* Maps dont't equal each other. */
+			if (i == j)
+				continue;
+			TEST_ASSERT_VAL("not equal", !perf_cpu_map__equal(maps[i], maps[j]));
+		}
+	}
+
+	/* Maps equal made maps. */
+	tmp = perf_cpu_map__merge(perf_cpu_map__get(one), two);
+	TEST_ASSERT_VAL("pair", perf_cpu_map__equal(pair, tmp));
+	perf_cpu_map__put(tmp);
+
+	tmp = perf_cpu_map__intersect(pair, one);
+	TEST_ASSERT_VAL("one", perf_cpu_map__equal(one, tmp));
+	perf_cpu_map__put(tmp);
+
+	for (size_t i = 0; i < ARRAY_SIZE(maps); i++)
+		perf_cpu_map__put(maps[i]);
+
+	return TEST_OK;
+}
+
 static struct test_case tests__cpu_map[] = {
 	TEST_CASE("Synthesize cpu map", cpu_map_synthesize),
 	TEST_CASE("Print cpu map", cpu_map_print),
 	TEST_CASE("Merge cpu map", cpu_map_merge),
 	TEST_CASE("Intersect cpu map", cpu_map_intersect),
+	TEST_CASE("Equal cpu map", cpu_map_equal),
 	{	.name = NULL, }
 };
 
-- 
2.40.1.698.g37aff9b760-goog

