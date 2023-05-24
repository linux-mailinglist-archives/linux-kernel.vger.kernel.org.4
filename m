Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089B27100AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjEXWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjEXWSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:18:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B113A
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so2863426276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966717; x=1687558717;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOYhuvl7j4rILtDYoGdkPuYJrVXEqJknY6wScK522SU=;
        b=67+9ALB3eZ2ZAz2DQQxqS9HpMTTA2RMnCLODfUbzvIf2IN2exBLSJWH+utQF2kJCC3
         8Yeuq5eqt/fW0Vd9MzYgXMa/brXXO+Slc7bNtXryqVvjvwL+Qc1gaGBkowPvoKd65BV3
         lCP1CT9xWxjoBgKR2Bqo4rUqoxCk1c7/t26JsaF0pdbhm6SqVGo2b7w9exP17WpU+JTQ
         2G2JR47bt4R6ZVVhayAnsWyUb3PgyHFpGFMlg1kwkBxY6w7a56HuLqkO0OrrH5m8ezp3
         wHDKWhIwtPsBTCa7h/ETGkqI2utZVjWAeD+/lzVCFTgJeY2ZL1N1pYXxkx0Y51fKmrhG
         fuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966717; x=1687558717;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOYhuvl7j4rILtDYoGdkPuYJrVXEqJknY6wScK522SU=;
        b=ClbNsVNXhxnNB1WMdFrQNcYY5nCwNwNUrGuzdY+r+FS/RlDNMkAlub/u08LtnVPncM
         xViLITJO0c0O0J3m5jLg+WiTe2wzdVhvfxlClIEgspa2sJ3Js+0qf6OHhX2MrmX/TA7R
         jk326C1bPmvzCWaY6cyQAhJEqUQeHEHGr5Gf+fL++oFHVc7/lASdU6uX5FblLdDY9Wom
         Pqj2lNNclL3cGzQRRBEz75W8tLTXH1Z8mzAWSNYpU+NgfCNylPtd9wNPOI+lTCjjKit8
         M5npBl29icrdry5ujZDYXjHD4b7GiN6fobKSAPTM3CCl2x2uhkiBjRjUZM0QrBh6KXeR
         /KTQ==
X-Gm-Message-State: AC+VfDwoDInOKA3BFzdyHKwksZVCE2iLM/C/c7TUIWKhbPfBLP+GZj6v
        m9J9G+fhj8YILrKkz1+tIaMv3KN6mHSk
X-Google-Smtp-Source: ACHHUZ5RlOQlKwSPkAmv8JiRproRQrkYaHEo+hNcLC6PUdaeblJ0iScX+tlypvYK2W6mwqg5V3Z4OtevgWkw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a05:6902:1615:b0:ba7:8099:c5f2 with SMTP
 id bw21-20020a056902161500b00ba78099c5f2mr588863ybb.8.1684966717718; Wed, 24
 May 2023 15:18:37 -0700 (PDT)
Date:   Wed, 24 May 2023 15:17:57 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-2-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 01/35] perf cpumap: Add intersect function
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

The merge function gives the union of two cpu maps. Add an intersect
function which is necessary, for example, when intersecting a PMUs
supported CPUs with user requested.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.40.1.698.g37aff9b760-goog

