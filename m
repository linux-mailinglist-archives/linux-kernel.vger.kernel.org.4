Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D666D6E97
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjDDVCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbjDDVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:02:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC205BB4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:01:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso32947727ybj.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642092;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4MH1z+r1E3OK2fLosR1Bnw7h5TqzIm+VpTOh5x47/4k=;
        b=U+hepWonjTc0PpgFMdZq/ppqwxymOJ5SsruuSq9kBcDuXZjH8rOFJ9tx97hWJIm9Ed
         4knpFhj3M7CqWxS2Vam+VmS1vG9LR43xb8r5VfA71Ks8WLjW0ECR0gfFTCKqzhxxP6K1
         8KoytNR8DeVjW5EHHzutfZ8HyfYaznjikJN9xbRx9MBcF9ZZcID8ftuC6ZETCIVKi1n/
         gvWVH0fdRNYK4j7lkMQbJio9rx4JlLqPAZ6PbZ1lNzSqVqYolYYsu9ar6sGcAGV1QCFM
         sZHaMIOJW5ivhbi1Iue6zVz/fKX94pruta8QaepkoG5TT58peQXDlRAijYdJ8NGMGuWd
         IGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642092;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MH1z+r1E3OK2fLosR1Bnw7h5TqzIm+VpTOh5x47/4k=;
        b=EeTi0r94KVdWQURayjyDypdbxYFd5xoZ5sXOy66qkMRwkgnEfSh0NoUBIzMpy4bWVl
         HAiUtE3zrBTwB1uzL55p0VafzBbaL4cERFx7p2AFnteEMunxZnnCglj1RVxO190fO7tc
         Q3CF2Rgym+Y+H+NZj37CVwrUd5Ah82CEL2DSQnYqBDdb8sE4/OvYBaS+qWAAD+HVStxb
         cnCkrd3zqr2u4E3SIpCfZ7vqP1F5ROvizXxi8QnZIg5sA6okdbEvdTmGcnXuJQ+0HlHU
         wkh5ruYy6w7DQAvDqFk625jse9959bpjCB+OUjJVhgLn2FJ2n1997TfW5gv98um5Ws2u
         2uHw==
X-Gm-Message-State: AAQBX9eiERcCrNY4zaV9cbk9TlJjYM4gB8lZydZzz5mLz3McOS+UT37I
        neujH87swS1/ltNsb1gleCOJyUyM2XqR
X-Google-Smtp-Source: AKy350Zg+YrQiQT+uJFg4usYd26OF8CxKjRFlEMz9JDYvawneoUItFGiF8WCvlwdnXd9Zb6jty9VWoaJZreV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a25:d9c2:0:b0:b69:f11b:690f with SMTP id
 q185-20020a25d9c2000000b00b69f11b690fmr2282543ybg.6.1680642092594; Tue, 04
 Apr 2023 14:01:32 -0700 (PDT)
Date:   Tue,  4 Apr 2023 13:59:51 -0700
In-Reply-To: <20230404205954.2245628-1-irogers@google.com>
Message-Id: <20230404205954.2245628-10-irogers@google.com>
Mime-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v6 09/12] perf cpumap: Add reference count checking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled when REFCNT_CHECKING is defined. The change adds a memory
allocated pointer that is interposed between the reference counted
cpu map at a get and freed by a put. The pointer replaces the original
perf_cpu_map struct, so use of the perf_cpu_map via APIs remains
unchanged. Any use of the cpu map without the API requires two versions,
handled via the RC_CHK_ACCESS macro.

This change is intended to catch:
 - use after put: using a cpumap after you have put it will cause a
   segv.
 - unbalanced puts: two puts for a get will result in a double free
   that can be captured and reported by tools like address sanitizer,
   including with the associated stack traces of allocation and frees.
 - missing puts: if a put is missing then the get turns into a memory
   leak that can be reported by leak sanitizer, including the stack
   trace at the point the get occurs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Makefile                  |  2 +-
 tools/lib/perf/cpumap.c                  | 94 +++++++++++++-----------
 tools/lib/perf/include/internal/cpumap.h |  4 +-
 tools/perf/tests/cpumap.c                |  4 +-
 tools/perf/util/cpumap.c                 | 40 +++++-----
 tools/perf/util/pmu.c                    |  8 +-
 6 files changed, 81 insertions(+), 71 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index d8cad124e4c5..3a9b2140aa04 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -188,7 +188,7 @@ install_lib: libs
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
 HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
-INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h threadmap.h xyarray.h
+INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
 INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 6cd0be7c1bb4..56eed1ac80d9 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -10,16 +10,16 @@
 #include <ctype.h>
 #include <limits.h>
 
-static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
-
-	if (cpus != NULL) {
+	struct perf_cpu_map *result;
+	RC_STRUCT(perf_cpu_map) *cpus =
+		malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	if (ADD_RC_CHK(result, cpus)) {
 		cpus->nr = nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
-
 	}
-	return cpus;
+	return result;
 }
 
 struct perf_cpu_map *perf_cpu_map__dummy_new(void)
@@ -27,7 +27,7 @@ struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
 
 	if (cpus)
-		cpus->map[0].cpu = -1;
+		RC_CHK_ACCESS(cpus)->map[0].cpu = -1;
 
 	return cpus;
 }
@@ -35,23 +35,30 @@ struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 static void cpu_map__delete(struct perf_cpu_map *map)
 {
 	if (map) {
-		WARN_ONCE(refcount_read(&map->refcnt) != 0,
+		WARN_ONCE(refcount_read(&RC_CHK_ACCESS(map)->refcnt) != 0,
 			  "cpu_map refcnt unbalanced\n");
-		free(map);
+		RC_CHK_FREE(map);
 	}
 }
 
 struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
 {
-	if (map)
-		refcount_inc(&map->refcnt);
-	return map;
+	struct perf_cpu_map *result;
+
+	if (RC_CHK_GET(result, map))
+		refcount_inc(&RC_CHK_ACCESS(map)->refcnt);
+
+	return result;
 }
 
 void perf_cpu_map__put(struct perf_cpu_map *map)
 {
-	if (map && refcount_dec_and_test(&map->refcnt))
-		cpu_map__delete(map);
+	if (map) {
+		if (refcount_dec_and_test(&RC_CHK_ACCESS(map)->refcnt))
+			cpu_map__delete(map);
+		else
+			RC_CHK_PUT(map);
+	}
 }
 
 static struct perf_cpu_map *cpu_map__default_new(void)
@@ -68,7 +75,7 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 		int i;
 
 		for (i = 0; i < nr_cpus; ++i)
-			cpus->map[i].cpu = i;
+			RC_CHK_ACCESS(cpus)->map[i].cpu = i;
 	}
 
 	return cpus;
@@ -94,15 +101,16 @@ static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu
 	int i, j;
 
 	if (cpus != NULL) {
-		memcpy(cpus->map, tmp_cpus, payload_size);
-		qsort(cpus->map, nr_cpus, sizeof(struct perf_cpu), cmp_cpu);
+		memcpy(RC_CHK_ACCESS(cpus)->map, tmp_cpus, payload_size);
+		qsort(RC_CHK_ACCESS(cpus)->map, nr_cpus, sizeof(struct perf_cpu), cmp_cpu);
 		/* Remove dups */
 		j = 0;
 		for (i = 0; i < nr_cpus; i++) {
-			if (i == 0 || cpus->map[i].cpu != cpus->map[i - 1].cpu)
-				cpus->map[j++].cpu = cpus->map[i].cpu;
+			if (i == 0 ||
+			    RC_CHK_ACCESS(cpus)->map[i].cpu != RC_CHK_ACCESS(cpus)->map[i - 1].cpu)
+				RC_CHK_ACCESS(cpus)->map[j++].cpu = RC_CHK_ACCESS(cpus)->map[i].cpu;
 		}
-		cpus->nr = j;
+		RC_CHK_ACCESS(cpus)->nr = j;
 		assert(j <= nr_cpus);
 	}
 	return cpus;
@@ -263,20 +271,20 @@ struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 		.cpu = -1
 	};
 
-	if (cpus && idx < cpus->nr)
-		return cpus->map[idx];
+	if (cpus && idx < RC_CHK_ACCESS(cpus)->nr)
+		return RC_CHK_ACCESS(cpus)->map[idx];
 
 	return result;
 }
 
 int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
-	return cpus ? cpus->nr : 1;
+	return cpus ? RC_CHK_ACCESS(cpus)->nr : 1;
 }
 
 bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 {
-	return map ? map->map[0].cpu == -1 : true;
+	return map ? RC_CHK_ACCESS(map)->map[0].cpu == -1 : true;
 }
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
@@ -287,10 +295,10 @@ int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 		return -1;
 
 	low = 0;
-	high = cpus->nr;
+	high = RC_CHK_ACCESS(cpus)->nr;
 	while (low < high) {
 		int idx = (low + high) / 2;
-		struct perf_cpu cpu_at_idx = cpus->map[idx];
+		struct perf_cpu cpu_at_idx = RC_CHK_ACCESS(cpus)->map[idx];
 
 		if (cpu_at_idx.cpu == cpu.cpu)
 			return idx;
@@ -316,7 +324,9 @@ struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 	};
 
 	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
-	return map->nr > 0 ? map->map[map->nr - 1] : result;
+	return RC_CHK_ACCESS(map)->nr > 0
+		? RC_CHK_ACCESS(map)->map[RC_CHK_ACCESS(map)->nr - 1]
+		: result;
 }
 
 /** Is 'b' a subset of 'a'. */
@@ -324,15 +334,15 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
 {
 	if (a == b || !b)
 		return true;
-	if (!a || b->nr > a->nr)
+	if (!a || RC_CHK_ACCESS(b)->nr > RC_CHK_ACCESS(a)->nr)
 		return false;
 
-	for (int i = 0, j = 0; i < a->nr; i++) {
-		if (a->map[i].cpu > b->map[j].cpu)
+	for (int i = 0, j = 0; i < RC_CHK_ACCESS(a)->nr; i++) {
+		if (RC_CHK_ACCESS(a)->map[i].cpu > RC_CHK_ACCESS(b)->map[j].cpu)
 			return false;
-		if (a->map[i].cpu == b->map[j].cpu) {
+		if (RC_CHK_ACCESS(a)->map[i].cpu == RC_CHK_ACCESS(b)->map[j].cpu) {
 			j++;
-			if (j == b->nr)
+			if (j == RC_CHK_ACCESS(b)->nr)
 				return true;
 		}
 	}
@@ -362,27 +372,27 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 		return perf_cpu_map__get(other);
 	}
 
-	tmp_len = orig->nr + other->nr;
+	tmp_len = RC_CHK_ACCESS(orig)->nr + RC_CHK_ACCESS(other)->nr;
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
 	if (!tmp_cpus)
 		return NULL;
 
 	/* Standard merge algorithm from wikipedia */
 	i = j = k = 0;
-	while (i < orig->nr && j < other->nr) {
-		if (orig->map[i].cpu <= other->map[j].cpu) {
-			if (orig->map[i].cpu == other->map[j].cpu)
+	while (i < RC_CHK_ACCESS(orig)->nr && j < RC_CHK_ACCESS(other)->nr) {
+		if (RC_CHK_ACCESS(orig)->map[i].cpu <= RC_CHK_ACCESS(other)->map[j].cpu) {
+			if (RC_CHK_ACCESS(orig)->map[i].cpu == RC_CHK_ACCESS(other)->map[j].cpu)
 				j++;
-			tmp_cpus[k++] = orig->map[i++];
+			tmp_cpus[k++] = RC_CHK_ACCESS(orig)->map[i++];
 		} else
-			tmp_cpus[k++] = other->map[j++];
+			tmp_cpus[k++] = RC_CHK_ACCESS(other)->map[j++];
 	}
 
-	while (i < orig->nr)
-		tmp_cpus[k++] = orig->map[i++];
+	while (i < RC_CHK_ACCESS(orig)->nr)
+		tmp_cpus[k++] = RC_CHK_ACCESS(orig)->map[i++];
 
-	while (j < other->nr)
-		tmp_cpus[k++] = other->map[j++];
+	while (j < RC_CHK_ACCESS(other)->nr)
+		tmp_cpus[k++] = RC_CHK_ACCESS(other)->map[j++];
 	assert(k <= tmp_len);
 
 	merged = cpu_map__trim_new(k, tmp_cpus);
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 35dd29642296..6c01bee4d048 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -4,6 +4,7 @@
 
 #include <linux/refcount.h>
 #include <perf/cpumap.h>
+#include <internal/rc_check.h>
 
 /**
  * A sized, reference counted, sorted array of integers representing CPU
@@ -12,7 +13,7 @@
  * gaps if CPU numbers were used. For events associated with a pid, rather than
  * a CPU, a single dummy map with an entry of -1 is used.
  */
-struct perf_cpu_map {
+DECLARE_RC_STRUCT(perf_cpu_map) {
 	refcount_t	refcnt;
 	/** Length of the map array. */
 	int		nr;
@@ -24,6 +25,7 @@ struct perf_cpu_map {
 #define MAX_NR_CPUS	2048
 #endif
 
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
 bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b);
 
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 3150fc1fed6f..d6f77b676d11 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -68,7 +68,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 2);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 1).cpu == 256);
-	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
+	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(map)->refcnt) == 1);
 	perf_cpu_map__put(map);
 	return 0;
 }
@@ -94,7 +94,7 @@ static int process_event_range_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 256);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__max(map).cpu == 256);
-	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
+	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(map)->refcnt) == 1);
 	perf_cpu_map__put(map);
 	return 0;
 }
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 5e564974fba4..22453893105f 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -77,9 +77,9 @@ static struct perf_cpu_map *cpu_map__from_entries(const struct perf_record_cpu_m
 			 * otherwise it would become 65535.
 			 */
 			if (data->cpus_data.cpu[i] == (u16) -1)
-				map->map[i].cpu = -1;
+				RC_CHK_ACCESS(map)->map[i].cpu = -1;
 			else
-				map->map[i].cpu = (int) data->cpus_data.cpu[i];
+				RC_CHK_ACCESS(map)->map[i].cpu = (int) data->cpus_data.cpu[i];
 		}
 	}
 
@@ -107,7 +107,7 @@ static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_
 
 		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
 		for_each_set_bit(cpu, local_copy, 64)
-			map->map[j++].cpu = cpu + cpus_per_i;
+		        RC_CHK_ACCESS(map)->map[j++].cpu = cpu + cpus_per_i;
 	}
 	return map;
 
@@ -124,11 +124,11 @@ static struct perf_cpu_map *cpu_map__from_range(const struct perf_record_cpu_map
 		return NULL;
 
 	if (data->range_cpu_data.any_cpu)
-		map->map[i++].cpu = -1;
+		RC_CHK_ACCESS(map)->map[i++].cpu = -1;
 
 	for (int cpu = data->range_cpu_data.start_cpu; cpu <= data->range_cpu_data.end_cpu;
 	     i++, cpu++)
-		map->map[i].cpu = cpu;
+		RC_CHK_ACCESS(map)->map[i].cpu = cpu;
 
 	return map;
 }
@@ -160,16 +160,13 @@ size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr)
 {
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
+	struct perf_cpu_map *cpus = perf_cpu_map__alloc(nr);
 
 	if (cpus != NULL) {
 		int i;
 
-		cpus->nr = nr;
 		for (i = 0; i < nr; i++)
-			cpus->map[i].cpu = -1;
-
-		refcount_set(&cpus->refcnt, 1);
+			RC_CHK_ACCESS(cpus)->map[i].cpu = -1;
 	}
 
 	return cpus;
@@ -239,7 +236,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 {
 	int idx;
 	struct perf_cpu cpu;
-	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);
+	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(perf_cpu_map__nr(cpus));
 
 	if (!c)
 		return NULL;
@@ -263,7 +260,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 		}
 	}
 	/* Trim. */
-	if (c->nr != cpus->nr) {
+	if (c->nr != perf_cpu_map__nr(cpus)) {
 		struct cpu_aggr_map *trimmed_c =
 			realloc(c,
 				sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
@@ -582,31 +579,32 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 
 #define COMMA first ? "" : ","
 
-	for (i = 0; i < map->nr + 1; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map) + 1; i++) {
 		struct perf_cpu cpu = { .cpu = INT_MAX };
-		bool last = i == map->nr;
+		bool last = i == perf_cpu_map__nr(map);
 
 		if (!last)
-			cpu = map->map[i];
+			cpu = perf_cpu_map__cpu(map, i);
 
 		if (start == -1) {
 			start = i;
 			if (last) {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d", COMMA,
-						map->map[i].cpu);
+						perf_cpu_map__cpu(map, i).cpu);
 			}
-		} else if (((i - start) != (cpu.cpu - map->map[start].cpu)) || last) {
+		} else if (((i - start) != (cpu.cpu - perf_cpu_map__cpu(map, start).cpu)) || last) {
 			int end = i - 1;
 
 			if (start == end) {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d", COMMA,
-						map->map[start].cpu);
+						perf_cpu_map__cpu(map, start).cpu);
 			} else {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d-%d", COMMA,
-						map->map[start].cpu, map->map[end].cpu);
+						perf_cpu_map__cpu(map, start).cpu,
+						perf_cpu_map__cpu(map, end).cpu);
 			}
 			first = false;
 			start = i;
@@ -633,7 +631,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	int i, cpu;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
+	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, perf_cpu_map__nr(map) - 1);
 
 	if (buf == NULL)
 		return 0;
@@ -644,7 +642,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 		return 0;
 	}
 
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		cpu = perf_cpu_map__cpu(map, i).cpu;
 		bitmap[cpu / 8] |= 1 << (cpu % 8);
 	}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 78a407b42ad1..c08d42f5e2b4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1966,13 +1966,13 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 
 	perf_cpu_map__for_each_cpu(cpu, i, cpus) {
 		if (!perf_cpu_map__has(pmu_cpus, cpu))
-			unmatched_cpus->map[unmatched_nr++] = cpu;
+			RC_CHK_ACCESS(unmatched_cpus)->map[unmatched_nr++] = cpu;
 		else
-			matched_cpus->map[matched_nr++] = cpu;
+			RC_CHK_ACCESS(matched_cpus)->map[matched_nr++] = cpu;
 	}
 
-	unmatched_cpus->nr = unmatched_nr;
-	matched_cpus->nr = matched_nr;
+	RC_CHK_ACCESS(unmatched_cpus)->nr = unmatched_nr;
+	RC_CHK_ACCESS(matched_cpus)->nr = matched_nr;
 	*mcpus_ptr = matched_cpus;
 	*ucpus_ptr = unmatched_cpus;
 	return 0;
-- 
2.40.0.348.gf938b09366-goog

