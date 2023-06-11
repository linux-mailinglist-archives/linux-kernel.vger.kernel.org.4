Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1487372B4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 01:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjFKXgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 19:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjFKXgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 19:36:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2F191
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:36:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568a85f180dso55654887b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686526599; x=1689118599;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0SRK1kSYCeqvK1qNU5OousMuIxmVIPnMAyM5t7CjMcw=;
        b=ZwfYgwTDL/Y0LaE98Z7Zo5txUB+VdNB71y4+5t7W7WSXBMgQE+vK09m4GoeAoYx2W6
         N8DkSi+CXOorYbQbn2daFm/buibMU3q2i57QqSHmQsIm7eAw5RQKw6dDliHKR/oRaLnz
         GvSck+VcnvWO4/8xuEcAMONymH8jJNfViO+W6AWoVlpBIzVOHLByRk5s72dBpcU0+NWK
         MUTJDymRHr0FD5WH5gS/joG6BCv2s16WhbrHFYvSoFOq7wbTXFyuqX4db1yQq1EHp+eM
         ob2NNinkI2jPoKmOwcx5KIKalcTJCNjkqsdswUkjrGE4vdA4TNxuh9N1tl5NuLxfcsik
         8xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686526599; x=1689118599;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SRK1kSYCeqvK1qNU5OousMuIxmVIPnMAyM5t7CjMcw=;
        b=SfVpRkCDmNZDJZhmC0Iv0p4kYVEdJBEkdZYk0upKIShvs/8GvYUfOLFMYLrf3xwEjg
         6gBlE3ldt8dkWyCDQCFayh5AmNukzZJcg+AoWo5RrV2XSON28mzf/ZS66I3r815I2fdb
         gESdkEdTQOhjHm7OZ38PsyrKMsdCGF5wp2DXhC9ogoyhxzFs2nCGt8V5U4zXZRwCapHg
         Fm62/xwxTrUISjKlTDxubjT5Oh9ol5oAH9132mxRdUSxbLXtgIjYJrLdjubpklrJdzkf
         sp936pQ5HiKyZl/ZDNjQfUExGVoul37R8kEwhShoqFFQY/qKB18dfwPhtclUmvNelVX5
         SDUg==
X-Gm-Message-State: AC+VfDxS9LvQL2hS+z6/0kHPlCOGMa5yS8GlQpAfkJdOc3H/Tve77W3r
        pTyJA0yarblxI0fbNvgC+0BE2BIO2uS7
X-Google-Smtp-Source: ACHHUZ5NJiymLisecu9Z8qjcVQ5x9zy52GB7Htv/aTLR2Rbb1lsoOgxYcck5Lnjxb9fwct8DS4gMgKQxsBVm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:aca9:d7c7:ed17:e760])
 (user=irogers job=sendgmr) by 2002:a81:b706:0:b0:56d:21a1:16a1 with SMTP id
 v6-20020a81b706000000b0056d21a116a1mr960686ywh.5.1686526598963; Sun, 11 Jun
 2023 16:36:38 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:36:09 -0700
In-Reply-To: <20230611233610.953456-1-irogers@google.com>
Message-Id: <20230611233610.953456-4-irogers@google.com>
Mime-Version: 1.0
References: <20230611233610.953456-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 4/5] perf bench futex: Avoid memory leaks from pthread_attr
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Remove code sharing the pthread_attr_t and initialize/destroy
pthread_attr_t when needed. This avoids the same attribute being set
that leak sanitizer reports as a memory leak.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/futex-lock-pi.c       | 12 ++++++------
 tools/perf/bench/futex-requeue.c       | 12 ++++++------
 tools/perf/bench/futex-wake-parallel.c | 19 +++++++++++--------
 tools/perf/bench/futex-wake.c          | 12 ++++++------
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 2d0417949727..092cbd52db82 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -118,8 +118,7 @@ static void *workerfn(void *arg)
 	return NULL;
 }
 
-static void create_threads(struct worker *w, pthread_attr_t thread_attr,
-			   struct perf_cpu_map *cpu)
+static void create_threads(struct worker *w, struct perf_cpu_map *cpu)
 {
 	cpu_set_t *cpuset;
 	unsigned int i;
@@ -133,6 +132,9 @@ static void create_threads(struct worker *w, pthread_attr_t thread_attr,
 	size = CPU_ALLOC_SIZE(nrcpus);
 
 	for (i = 0; i < params.nthreads; i++) {
+		pthread_attr_t thread_attr;
+
+		pthread_attr_init(&thread_attr);
 		worker[i].tid = i;
 
 		if (params.multi) {
@@ -154,6 +156,7 @@ static void create_threads(struct worker *w, pthread_attr_t thread_attr,
 			CPU_FREE(cpuset);
 			err(EXIT_FAILURE, "pthread_create");
 		}
+		pthread_attr_destroy(&thread_attr);
 	}
 	CPU_FREE(cpuset);
 }
@@ -163,7 +166,6 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	int ret = 0;
 	unsigned int i;
 	struct sigaction act;
-	pthread_attr_t thread_attr;
 	struct perf_cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_lock_pi_usage, 0);
@@ -203,11 +205,9 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	cond_init(&thread_worker);
 
 	threads_starting = params.nthreads;
-	pthread_attr_init(&thread_attr);
 	gettimeofday(&bench__start, NULL);
 
-	create_threads(worker, thread_attr, cpu);
-	pthread_attr_destroy(&thread_attr);
+	create_threads(worker, cpu);
 
 	mutex_lock(&thread_lock);
 	while (threads_starting)
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 69ad896f556c..c0035990a33c 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -121,8 +121,7 @@ static void *workerfn(void *arg __maybe_unused)
 	return NULL;
 }
 
-static void block_threads(pthread_t *w,
-			  pthread_attr_t thread_attr, struct perf_cpu_map *cpu)
+static void block_threads(pthread_t *w, struct perf_cpu_map *cpu)
 {
 	cpu_set_t *cpuset;
 	unsigned int i;
@@ -137,6 +136,9 @@ static void block_threads(pthread_t *w,
 
 	/* create and block all threads */
 	for (i = 0; i < params.nthreads; i++) {
+		pthread_attr_t thread_attr;
+
+		pthread_attr_init(&thread_attr);
 		CPU_ZERO_S(size, cpuset);
 		CPU_SET_S(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, size, cpuset);
 
@@ -149,6 +151,7 @@ static void block_threads(pthread_t *w,
 			CPU_FREE(cpuset);
 			err(EXIT_FAILURE, "pthread_create");
 		}
+		pthread_attr_destroy(&thread_attr);
 	}
 	CPU_FREE(cpuset);
 }
@@ -165,7 +168,6 @@ int bench_futex_requeue(int argc, const char **argv)
 	int ret = 0;
 	unsigned int i, j;
 	struct sigaction act;
-	pthread_attr_t thread_attr;
 	struct perf_cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_requeue_usage, 0);
@@ -209,7 +211,6 @@ int bench_futex_requeue(int argc, const char **argv)
 
 	init_stats(&requeued_stats);
 	init_stats(&requeuetime_stats);
-	pthread_attr_init(&thread_attr);
 	mutex_init(&thread_lock);
 	cond_init(&thread_parent);
 	cond_init(&thread_worker);
@@ -219,7 +220,7 @@ int bench_futex_requeue(int argc, const char **argv)
 		struct timeval start, end, runtime;
 
 		/* create, launch & block all threads */
-		block_threads(worker, thread_attr, cpu);
+		block_threads(worker, cpu);
 
 		/* make sure all threads are already blocked */
 		mutex_lock(&thread_lock);
@@ -301,7 +302,6 @@ int bench_futex_requeue(int argc, const char **argv)
 	cond_destroy(&thread_parent);
 	cond_destroy(&thread_worker);
 	mutex_destroy(&thread_lock);
-	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
 
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 6682e49d0ee0..5ab0234d74e6 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -95,10 +95,12 @@ static void *waking_workerfn(void *arg)
 	return NULL;
 }
 
-static void wakeup_threads(struct thread_data *td, pthread_attr_t thread_attr)
+static void wakeup_threads(struct thread_data *td)
 {
 	unsigned int i;
+	pthread_attr_t thread_attr;
 
+	pthread_attr_init(&thread_attr);
 	pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_JOINABLE);
 
 	pthread_barrier_init(&barrier, NULL, params.nwakes + 1);
@@ -122,6 +124,7 @@ static void wakeup_threads(struct thread_data *td, pthread_attr_t thread_attr)
 			err(EXIT_FAILURE, "pthread_join");
 
 	pthread_barrier_destroy(&barrier);
+	pthread_attr_destroy(&thread_attr);
 }
 
 static void *blocked_workerfn(void *arg __maybe_unused)
@@ -142,8 +145,7 @@ static void *blocked_workerfn(void *arg __maybe_unused)
 	return NULL;
 }
 
-static void block_threads(pthread_t *w, pthread_attr_t thread_attr,
-			  struct perf_cpu_map *cpu)
+static void block_threads(pthread_t *w, struct perf_cpu_map *cpu)
 {
 	cpu_set_t *cpuset;
 	unsigned int i;
@@ -158,6 +160,9 @@ static void block_threads(pthread_t *w, pthread_attr_t thread_attr,
 
 	/* create and block all threads */
 	for (i = 0; i < params.nthreads; i++) {
+		pthread_attr_t thread_attr;
+
+		pthread_attr_init(&thread_attr);
 		CPU_ZERO_S(size, cpuset);
 		CPU_SET_S(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, size, cpuset);
 
@@ -170,6 +175,7 @@ static void block_threads(pthread_t *w, pthread_attr_t thread_attr,
 			CPU_FREE(cpuset);
 			err(EXIT_FAILURE, "pthread_create");
 		}
+		pthread_attr_destroy(&thread_attr);
 	}
 	CPU_FREE(cpuset);
 }
@@ -238,7 +244,6 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	int ret = 0;
 	unsigned int i, j;
 	struct sigaction act;
-	pthread_attr_t thread_attr;
 	struct thread_data *waking_worker;
 	struct perf_cpu_map *cpu;
 
@@ -294,7 +299,6 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	init_stats(&wakeup_stats);
 	init_stats(&waketime_stats);
 
-	pthread_attr_init(&thread_attr);
 	mutex_init(&thread_lock);
 	cond_init(&thread_parent);
 	cond_init(&thread_worker);
@@ -305,7 +309,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 			err(EXIT_FAILURE, "calloc");
 
 		/* create, launch & block all threads */
-		block_threads(blocked_worker, thread_attr, cpu);
+		block_threads(blocked_worker, cpu);
 
 		/* make sure all threads are already blocked */
 		mutex_lock(&thread_lock);
@@ -317,7 +321,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		usleep(100000);
 
 		/* Ok, all threads are patiently blocked, start waking folks up */
-		wakeup_threads(waking_worker, thread_attr);
+		wakeup_threads(waking_worker);
 
 		for (i = 0; i < params.nthreads; i++) {
 			ret = pthread_join(blocked_worker[i], NULL);
@@ -336,7 +340,6 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	cond_destroy(&thread_parent);
 	cond_destroy(&thread_worker);
 	mutex_destroy(&thread_lock);
-	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
 
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 9ecab6620a87..18a5894af8bb 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -95,8 +95,7 @@ static void print_summary(void)
 	       rel_stddev_stats(waketime_stddev, waketime_avg));
 }
 
-static void block_threads(pthread_t *w,
-			  pthread_attr_t thread_attr, struct perf_cpu_map *cpu)
+static void block_threads(pthread_t *w, struct perf_cpu_map *cpu)
 {
 	cpu_set_t *cpuset;
 	unsigned int i;
@@ -110,6 +109,9 @@ static void block_threads(pthread_t *w,
 
 	/* create and block all threads */
 	for (i = 0; i < params.nthreads; i++) {
+		pthread_attr_t thread_attr;
+
+		pthread_attr_init(&thread_attr);
 		CPU_ZERO_S(size, cpuset);
 		CPU_SET_S(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, size, cpuset);
 
@@ -122,6 +124,7 @@ static void block_threads(pthread_t *w,
 			CPU_FREE(cpuset);
 			err(EXIT_FAILURE, "pthread_create");
 		}
+		pthread_attr_destroy(&thread_attr);
 	}
 	CPU_FREE(cpuset);
 }
@@ -138,7 +141,6 @@ int bench_futex_wake(int argc, const char **argv)
 	int ret = 0;
 	unsigned int i, j;
 	struct sigaction act;
-	pthread_attr_t thread_attr;
 	struct perf_cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_wake_usage, 0);
@@ -178,7 +180,6 @@ int bench_futex_wake(int argc, const char **argv)
 
 	init_stats(&wakeup_stats);
 	init_stats(&waketime_stats);
-	pthread_attr_init(&thread_attr);
 	mutex_init(&thread_lock);
 	cond_init(&thread_parent);
 	cond_init(&thread_worker);
@@ -188,7 +189,7 @@ int bench_futex_wake(int argc, const char **argv)
 		struct timeval start, end, runtime;
 
 		/* create, launch & block all threads */
-		block_threads(worker, thread_attr, cpu);
+		block_threads(worker, cpu);
 
 		/* make sure all threads are already blocked */
 		mutex_lock(&thread_lock);
@@ -228,7 +229,6 @@ int bench_futex_wake(int argc, const char **argv)
 	cond_destroy(&thread_parent);
 	cond_destroy(&thread_worker);
 	mutex_destroy(&thread_lock);
-	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
 
-- 
2.41.0.162.gfafddb0af9-goog

