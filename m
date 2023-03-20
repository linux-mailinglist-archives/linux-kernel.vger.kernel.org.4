Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92166C23A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCTV0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjCTV0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:26:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD51A65C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:25:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a4eba107so135483327b3.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347503;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=icBYGhACTLENBFtI0uAK9GZilU3MMSebJp6keqt4NA0=;
        b=jGcUqcPVGFax6oc/S4S8LcGtg6Tuujx2Q1ikG5/H9j7LhIDe2QDAzhq+AQ2UiZ1d4y
         J1GE4K5sr+PAP9ce+SERYJybvNb6dqpZJnmcnqf7yWrPTRAtJT9oXYhJ4/9jCaWGYeYc
         yO5PXUkWWXpEb6bIXELq0y+rU6tSveJTFMPq4wSMXIbBC7kvE6wVxri6KJGEYRNP+fyB
         Wj/Bq2bizYry8N1XCT62ajE/PconuhS87rCa8jyBaDnA+I3ZVygtsni9gb7q/w2VJXsj
         ud+UAncmjX0IWrhwTrznacTDg1xeWIJnv7rDoxKD+kd/OrkWRLdpRxknE4xsXo8ZjB+N
         swpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347503;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icBYGhACTLENBFtI0uAK9GZilU3MMSebJp6keqt4NA0=;
        b=ljbQ/dmfGfzVqvC0A3SUPVFcQhhijO375PK4oUwwwKBsOut7RGohZX7isg7VjEGcSl
         jEbZho20rxURj+McEqeUz5wgLs/sKldWmt2QqMMCRMouNo7wNOMpwyjO1ilV0yvrTxRo
         GHUBVFkbJ8MBUaaTLyLlnC8wIuwFLwlmOL8YBtMKyBF/gzq6TtHdwNLNSPkTXTeXmpPM
         aaTbQ9M6k+ijM+6d+C04rou+4zXMRwjpIldNRquK1tJBeb+mTpzIuor9+uYiSZQFiHf/
         FoHX6P/DGP3AUaQCcuPAZaQK7iBQ8HqNnqyZc/S7xZTi7NoTTYT461DzHQdIm7Rw33xv
         owxQ==
X-Gm-Message-State: AAQBX9ca4Gpng1HfWZ5lHL2fJbGEXLT5S7vmVkTUw5QAN8gw71wfwBaa
        R8wiJ0moarYF09H1rsK0agVNWX+50vha
X-Google-Smtp-Source: AKy350b5F+c1tKe8LfIVMxkrYq9LHCF/Q5UHRj7P1d6wO56g1unbT07IC+jOP6I9+EYXfCIe/AsZk446Gy0U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a25:d512:0:b0:b45:5cbe:48b3 with SMTP id
 r18-20020a25d512000000b00b455cbe48b3mr55577ybe.0.1679347503736; Mon, 20 Mar
 2023 14:25:03 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:47 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-17-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 16/17] perf maps: Add reference count checking.
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reference count checking to make sure of good use of get and put.
Add and use accessors to reduce RC_CHK clutter.

The only significant issue was in tests/thread-maps-share.c where
reference counts were released in the reverse order to acquisition,
leading to a use after put. This was fixed by reversing the put order.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/thread-maps-share.c     | 29 ++++++-------
 tools/perf/util/machine.c                |  2 +-
 tools/perf/util/maps.c                   | 53 +++++++++++++-----------
 tools/perf/util/maps.h                   | 17 ++++----
 tools/perf/util/symbol.c                 | 13 +++---
 tools/perf/util/unwind-libdw.c           |  2 +-
 tools/perf/util/unwind-libunwind-local.c |  2 +-
 tools/perf/util/unwind-libunwind.c       |  2 +-
 8 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index 84edd82c519e..dfe51b21bd7d 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -43,12 +43,12 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 			leader && t1 && t2 && t3 && other);
 
 	maps = leader->maps;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 4);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(maps)->refcnt), 4);
 
 	/* test the maps pointer is shared */
-	TEST_ASSERT_VAL("maps don't match", maps == t1->maps);
-	TEST_ASSERT_VAL("maps don't match", maps == t2->maps);
-	TEST_ASSERT_VAL("maps don't match", maps == t3->maps);
+	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(maps) == RC_CHK_ACCESS(t1->maps));
+	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(maps) == RC_CHK_ACCESS(t2->maps));
+	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(maps) == RC_CHK_ACCESS(t3->maps));
 
 	/*
 	 * Verify the other leader was created by previous call.
@@ -71,25 +71,26 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	machine__remove_thread(machine, other_leader);
 
 	other_maps = other->maps;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_maps->refcnt), 2);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(other_maps)->refcnt), 2);
 
-	TEST_ASSERT_VAL("maps don't match", other_maps == other_leader->maps);
+	TEST_ASSERT_VAL("maps don't match",
+			RC_CHK_ACCESS(other_maps) == RC_CHK_ACCESS(other_leader->maps));
 
 	/* release thread group */
-	thread__put(leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 3);
-
-	thread__put(t1);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 2);
+	thread__put(t3);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(maps)->refcnt), 3);
 
 	thread__put(t2);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(maps)->refcnt), 2);
 
-	thread__put(t3);
+	thread__put(t1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(maps)->refcnt), 1);
+
+	thread__put(leader);
 
 	/* release other group  */
 	thread__put(other_leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_maps->refcnt), 1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(other_maps)->refcnt), 1);
 
 	thread__put(other);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 502e97010a3c..cfbced348335 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -434,7 +434,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 		return NULL;
 
 	/* Assume maps are set up if there are any */
-	if (thread->maps->nr_maps)
+	if (RC_CHK_ACCESS(thread->maps)->nr_maps)
 		return thread;
 
 	host_thread = machine__find_thread(host_machine, -1, pid);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 74e3133f5007..3c8bbcb2c204 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -12,13 +12,13 @@
 
 static void maps__init(struct maps *maps, struct machine *machine)
 {
-	maps->entries = RB_ROOT;
+	RC_CHK_ACCESS(maps)->entries = RB_ROOT;
 	init_rwsem(maps__lock(maps));
-	maps->machine = machine;
-	maps->last_search_by_name = NULL;
-	maps->nr_maps = 0;
-	maps->maps_by_name = NULL;
-	refcount_set(&maps->refcnt, 1);
+	RC_CHK_ACCESS(maps)->machine = machine;
+	RC_CHK_ACCESS(maps)->last_search_by_name = NULL;
+	RC_CHK_ACCESS(maps)->nr_maps = 0;
+	RC_CHK_ACCESS(maps)->maps_by_name = NULL;
+	refcount_set(&RC_CHK_ACCESS(maps)->refcnt, 1);
 }
 
 static void __maps__free_maps_by_name(struct maps *maps)
@@ -29,8 +29,8 @@ static void __maps__free_maps_by_name(struct maps *maps)
 	for (unsigned int i = 0; i < maps__nr_maps(maps); i++)
 		map__put(maps__maps_by_name(maps)[i]);
 
-	zfree(&maps->maps_by_name);
-	maps->nr_maps_allocated = 0;
+	zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
+	RC_CHK_ACCESS(maps)->nr_maps_allocated = 0;
 }
 
 static int __maps__insert(struct maps *maps, struct map *map)
@@ -71,7 +71,7 @@ int maps__insert(struct maps *maps, struct map *map)
 	if (err)
 		goto out;
 
-	++maps->nr_maps;
+	++RC_CHK_ACCESS(maps)->nr_maps;
 
 	if (dso && dso->kernel) {
 		struct kmap *kmap = map__kmap(map);
@@ -88,7 +88,7 @@ int maps__insert(struct maps *maps, struct map *map)
 	 * inserted map and resort.
 	 */
 	if (maps__maps_by_name(maps)) {
-		if (maps__nr_maps(maps) > maps->nr_maps_allocated) {
+		if (maps__nr_maps(maps) > RC_CHK_ACCESS(maps)->nr_maps_allocated) {
 			int nr_allocate = maps__nr_maps(maps) * 2;
 			struct map **maps_by_name = realloc(maps__maps_by_name(maps),
 							    nr_allocate * sizeof(map));
@@ -99,8 +99,8 @@ int maps__insert(struct maps *maps, struct map *map)
 				goto out;
 			}
 
-			maps->maps_by_name = maps_by_name;
-			maps->nr_maps_allocated = nr_allocate;
+			RC_CHK_ACCESS(maps)->maps_by_name = maps_by_name;
+			RC_CHK_ACCESS(maps)->nr_maps_allocated = nr_allocate;
 		}
 		maps__maps_by_name(maps)[maps__nr_maps(maps) - 1] = map__get(map);
 		__maps__sort_by_name(maps);
@@ -122,15 +122,15 @@ void maps__remove(struct maps *maps, struct map *map)
 	struct map_rb_node *rb_node;
 
 	down_write(maps__lock(maps));
-	if (maps->last_search_by_name == map)
-		maps->last_search_by_name = NULL;
+	if (RC_CHK_ACCESS(maps)->last_search_by_name == map)
+		RC_CHK_ACCESS(maps)->last_search_by_name = NULL;
 
 	rb_node = maps__find_node(maps, map);
 	assert(rb_node->map == map);
 	__maps__remove(maps, rb_node);
 	if (maps__maps_by_name(maps))
 		__maps__free_maps_by_name(maps);
-	--maps->nr_maps;
+	--RC_CHK_ACCESS(maps)->nr_maps;
 	up_write(maps__lock(maps));
 }
 
@@ -162,33 +162,38 @@ bool maps__empty(struct maps *maps)
 
 struct maps *maps__new(struct machine *machine)
 {
-	struct maps *maps = zalloc(sizeof(*maps));
+	struct maps *res;
+	RC_STRUCT(maps) *maps = zalloc(sizeof(*maps));
 
-	if (maps != NULL)
-		maps__init(maps, machine);
+	if (ADD_RC_CHK(res, maps))
+		maps__init(res, machine);
 
-	return maps;
+	return res;
 }
 
 void maps__delete(struct maps *maps)
 {
 	maps__exit(maps);
 	unwind__finish_access(maps);
-	free(maps);
+	RC_CHK_FREE(maps);
 }
 
 struct maps *maps__get(struct maps *maps)
 {
-	if (maps)
-		refcount_inc(&maps->refcnt);
+	struct maps *result;
 
-	return maps;
+	if (RC_CHK_GET(result, maps))
+		refcount_inc(&RC_CHK_ACCESS(maps)->refcnt);
+
+	return result;
 }
 
 void maps__put(struct maps *maps)
 {
-	if (maps && refcount_dec_and_test(&maps->refcnt))
+	if (maps && refcount_dec_and_test(&RC_CHK_ACCESS(maps)->refcnt))
 		maps__delete(maps);
+	else
+		RC_CHK_PUT(maps);
 }
 
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index bde3390c7096..0af4b7e42fca 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -8,6 +8,7 @@
 #include <stdbool.h>
 #include <linux/types.h>
 #include "rwsem.h"
+#include <internal/rc_check.h>
 
 struct ref_reloc_sym;
 struct machine;
@@ -32,7 +33,7 @@ struct map *maps__find(struct maps *maps, u64 addr);
 	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
 	     map = next, next = map_rb_node__next(map))
 
-struct maps {
+DECLARE_RC_STRUCT(maps) {
 	struct rb_root      entries;
 	struct rw_semaphore lock;
 	struct machine	 *machine;
@@ -65,38 +66,38 @@ void maps__put(struct maps *maps);
 
 static inline struct rb_root *maps__entries(struct maps *maps)
 {
-	return &maps->entries;
+	return &RC_CHK_ACCESS(maps)->entries;
 }
 
 static inline struct machine *maps__machine(struct maps *maps)
 {
-	return maps->machine;
+	return RC_CHK_ACCESS(maps)->machine;
 }
 
 static inline struct rw_semaphore *maps__lock(struct maps *maps)
 {
-	return &maps->lock;
+	return &RC_CHK_ACCESS(maps)->lock;
 }
 
 static inline struct map **maps__maps_by_name(struct maps *maps)
 {
-	return maps->maps_by_name;
+	return RC_CHK_ACCESS(maps)->maps_by_name;
 }
 
 static inline unsigned int maps__nr_maps(const struct maps *maps)
 {
-	return maps->nr_maps;
+	return RC_CHK_ACCESS(maps)->nr_maps;
 }
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
 static inline void *maps__addr_space(struct maps *maps)
 {
-	return maps->addr_space;
+	return RC_CHK_ACCESS(maps)->addr_space;
 }
 
 static inline const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps)
 {
-	return maps->unwind_libunwind_ops;
+	return RC_CHK_ACCESS(maps)->unwind_libunwind_ops;
 }
 #endif
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f5432c7add09..d99c8e1bb4bf 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2096,8 +2096,8 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 	up_read(maps__lock(maps));
 	down_write(maps__lock(maps));
 
-	maps->maps_by_name = maps_by_name;
-	maps->nr_maps_allocated = maps__nr_maps(maps);
+	RC_CHK_ACCESS(maps)->maps_by_name = maps_by_name;
+	RC_CHK_ACCESS(maps)->nr_maps_allocated = maps__nr_maps(maps);
 
 	maps__for_each_entry(maps, rb_node)
 		maps_by_name[i++] = map__get(rb_node->map);
@@ -2132,11 +2132,12 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 
 	down_read(maps__lock(maps));
 
-	if (maps->last_search_by_name) {
-		const struct dso *dso = map__dso(maps->last_search_by_name);
+
+	if (RC_CHK_ACCESS(maps)->last_search_by_name) {
+		const struct dso *dso = map__dso(RC_CHK_ACCESS(maps)->last_search_by_name);
 
 		if (strcmp(dso->short_name, name) == 0) {
-			map = maps->last_search_by_name;
+			map = RC_CHK_ACCESS(maps)->last_search_by_name;
 			goto out_unlock;
 		}
 	}
@@ -2156,7 +2157,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 		map = rb_node->map;
 		dso = map__dso(map);
 		if (strcmp(dso->short_name, name) == 0) {
-			maps->last_search_by_name = map;
+			RC_CHK_ACCESS(maps)->last_search_by_name = map;
 			goto out_unlock;
 		}
 	}
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 9565f9906e5d..bdccfc511b7e 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -230,7 +230,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	struct unwind_info *ui, ui_buf = {
 		.sample		= data,
 		.thread		= thread,
-		.machine	= thread->maps->machine,
+		.machine	= RC_CHK_ACCESS(thread->maps)->machine,
 		.cb		= cb,
 		.arg		= arg,
 		.max_stack	= max_stack,
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 952c5ee66fe7..2947c210576e 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -667,7 +667,7 @@ static int _unwind__prepare_access(struct maps *maps)
 {
 	void *addr_space = unw_create_addr_space(&accessors, 0);
 
-	maps->addr_space = addr_space;
+	RC_CHK_ACCESS(maps)->addr_space = addr_space;
 	if (!addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
 		return -ENOMEM;
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index c14f04082377..48a7aeb3f9ec 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -14,7 +14,7 @@ struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
 
 static void unwind__register_ops(struct maps *maps, struct unwind_libunwind_ops *ops)
 {
-	maps->unwind_libunwind_ops = ops;
+	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = ops;
 }
 
 int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized)
-- 
2.40.0.rc1.284.g88254d51c5-goog

