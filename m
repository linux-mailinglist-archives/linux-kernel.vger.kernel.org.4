Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA7712F34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbjEZVyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbjEZVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:54:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886410A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bac6a453dd5so1641423276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138056; x=1687730056;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EneS6k0fHW+m74eWzDjwM1uOc1Pmt8jkSJOP/MXeXmY=;
        b=cSJ9niReYqrmuFkcQ1ETRJue7gVxvLZ/VOGme3fOFi2IvXXWUxzlexmxLeii6Vk3H+
         cLsn1mTS7p0IolvfXMXCCcSG3pZr2F0vHAvak0DcQV5u+qOEnJNZhQMG/grWoFWIcNlV
         qkQI42YHK+Whwhvuvq8AivZYqoqweVvJQ7Ei0qponQWqFogbx04XrLqpVPanTUn1NU/U
         vj7263FOe5ziX+J9eVs87CNz8I+o6jnzQk0wBzUrl7kKtV2etgGSU+ite4vgKFQILGPy
         tKaxK+kyaRiZJkPyM0WTDFRe0cYQ/QeC2DTcPidpySU063Lmok8QQTA3Cs21Oexqgo27
         KMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138056; x=1687730056;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EneS6k0fHW+m74eWzDjwM1uOc1Pmt8jkSJOP/MXeXmY=;
        b=aNNQalp/XsW+SlKmltUbgqxQDubJa77ZeCaRNPlYEqwmWKyRMp9aO+RhhtdE0RK74z
         L1/ZuaJJ15T/VMKRowFc6uDRj41zMAnca5dLzs46f3IMp91cJo+GMWQE/voftr4IheU4
         qmfhMogXuRBxrRutSkyDYlSVI4YcNrB6CRk69fQ3OOBtZ5VhCNL9B1l038OdYUTaZud+
         8BV4RnjNZdHFIuEkuVbCTrNzsYtrhaKaDXxvvaprB6nHTJ8eXDKLcmfBt8DYRp11C4bD
         mCMX+zqwSGBw8NlQ1sPhABBi1OiM0s5PQJIyrzxmapCdb3COMyhI3IoRi29WQBO2D5/q
         Lm6w==
X-Gm-Message-State: AC+VfDxtCgyUizrLt+6HzBTh6qqW2NvwDs8r9MrDlHaVi4XWWfqmLg73
        A7Nl3osBno5ae6lzzuBLYgJ9wjH47inU
X-Google-Smtp-Source: ACHHUZ7pyOT9lS3V6y+iDxHsLZyo/eaK+QtOpy4IcWNjPJIW/GXPNefY54a7T1cr2UkcUpsBxEIiNInXknTM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:8204:0:b0:bac:fd63:b567 with SMTP id
 q4-20020a258204000000b00bacfd63b567mr1723894ybk.4.1685138056472; Fri, 26 May
 2023 14:54:16 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:36 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-2-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 01/35] perf cpumap: Add intersect function
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The merge function gives the union of two cpu maps. Add an intersect
function which is necessary, for example, when intersecting a PMUs
supported CPUs with user requested.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/lib/perf/cpumap.c              | 35 ++++++++++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 tools/perf/tests/builtin-test.c      |  1 +
 tools/perf/tests/cpumap.c            | 41 ++++++++++++++++++++++++++++
 tools/perf/tests/tests.h             |  1 +
 5 files changed, 80 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 1229b18bcdb1..d4f3a1a12522 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -402,3 +402,38 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 	perf_cpu_map__put(orig);
 	return merged;
 }
+
+struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
+					     struct perf_cpu_map *other)
+{
+	struct perf_cpu *tmp_cpus;
+	int tmp_len;
+	int i, j, k;
+	struct perf_cpu_map *merged = NULL;
+
+	if (perf_cpu_map__is_subset(other, orig))
+		return perf_cpu_map__get(orig);
+	if (perf_cpu_map__is_subset(orig, other))
+		return perf_cpu_map__get(other);
+
+	tmp_len = max(orig->nr, other->nr);
+	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
+	if (!tmp_cpus)
+		return NULL;
+
+	i = j = k = 0;
+	while (i < orig->nr && j < other->nr) {
+		if (orig->map[i].cpu < other->map[j].cpu)
+			i++;
+		else if (orig->map[i].cpu > other->map[j].cpu)
+			j++;
+		else {
+			j++;
+			tmp_cpus[k++] = orig->map[i++];
+		}
+	}
+	if (k)
+		merged = cpu_map__trim_new(k, tmp_cpus);
+	free(tmp_cpus);
+	return merged;
+}
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 3f43f770cdac..0466c4216fbb 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -20,6 +20,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 						     struct perf_cpu_map *other);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
+							 struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b89d69afcef0..eef400025fca 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -97,6 +97,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__backward_ring_buffer,
 	&suite__cpu_map_print,
 	&suite__cpu_map_merge,
+	&suite__cpu_map_intersect,
 	&suite__sdt_event,
 	&suite__is_printable_array,
 	&suite__bitmap_print,
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index b1a924314e09..92232978fe5e 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -171,6 +171,47 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
 	return 0;
 }
 
+static int __test__cpu_map_intersect(const char *lhs, const char *rhs, int nr, const char *expected)
+{
+	struct perf_cpu_map *a = perf_cpu_map__new(lhs);
+	struct perf_cpu_map *b = perf_cpu_map__new(rhs);
+	struct perf_cpu_map *c = perf_cpu_map__intersect(a, b);
+	char buf[100];
+
+	TEST_ASSERT_EQUAL("failed to intersect map: bad nr", perf_cpu_map__nr(c), nr);
+	cpu_map__snprint(c, buf, sizeof(buf));
+	TEST_ASSERT_VAL("failed to intersect map: bad result", !strcmp(buf, expected));
+	perf_cpu_map__put(a);
+	perf_cpu_map__put(b);
+	perf_cpu_map__put(c);
+	return 0;
+}
+
+static int test__cpu_map_intersect(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = __test__cpu_map_intersect("4,2,1", "4,5,7", 1, "4");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_intersect("1-8", "6-9", 3, "6-8");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_intersect("1-8,12-20", "6-9,15", 4, "6-8,15");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_intersect("4,2,1", "1", 1, "1");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_intersect("1", "4,2,1", 1, "1");
+	if (ret)
+		return ret;
+	ret = __test__cpu_map_intersect("1", "1", 1, "1");
+	return ret;
+}
+
 DEFINE_SUITE("Synthesize cpu map", cpu_map_synthesize);
 DEFINE_SUITE("Print cpu map", cpu_map_print);
 DEFINE_SUITE("Merge cpu map", cpu_map_merge);
+DEFINE_SUITE("Intersect cpu map", cpu_map_intersect);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9a0f3904e53d..b4e54f08bc39 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -127,6 +127,7 @@ DECLARE_SUITE(event_times);
 DECLARE_SUITE(backward_ring_buffer);
 DECLARE_SUITE(cpu_map_print);
 DECLARE_SUITE(cpu_map_merge);
+DECLARE_SUITE(cpu_map_intersect);
 DECLARE_SUITE(sdt_event);
 DECLARE_SUITE(is_printable_array);
 DECLARE_SUITE(bitmap_print);
-- 
2.41.0.rc0.172.g3f132b7071-goog

