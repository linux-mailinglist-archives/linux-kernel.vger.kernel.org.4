Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C44728BC0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbjFHX3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFHX3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD2A30E4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb39aebdd87so2572031276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266953; x=1688858953;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVrxFoXm1Y9BE+cSFKEBl3aqhI2wzHdN+Ni9StCoKlc=;
        b=tFiMSrtQwD/5A9NFS7UinYAeI6GpdGFuQ5rqSaHnkUkPLib+d0l+Os9dph+Y/D6IcU
         KB/pTYETV+CyOtxmwAJsgpa905tfPtSnUUfUBOnfDxBbrxqh5eURn7vMLsU38hMm+ui0
         Z3NjyvHO9+jpyWQ5bOkv9cyYeJKRs8wLx2xsRCla0K/B/XQOxsi+VctGHZmpBo8A0gCq
         CQg41RjtE73ICFq75M3Cj4sctLt8m9K+AJN31KxAo870xSvLvHSjocO5LaGyc4A1c5Mh
         w67efiEXzITPqFx7LHFmujhLNV0NMbcbXO9tgGcMhbVQ3O03eWgp0oZ7MHCXGJaWJhJK
         9SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266953; x=1688858953;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVrxFoXm1Y9BE+cSFKEBl3aqhI2wzHdN+Ni9StCoKlc=;
        b=c8eVOlccyI9GIz8ewQm/vm1CcMtcSt10QuxYfZUIEMgzXo5MNJPP8TenhmqeonNDr7
         UPEQ/CwFw2Tizb3+OZ08fcRRG06N+f1e2/YXs5s6wdKcftbyqCd4qGTAbO8IhJajBJAK
         ZcYuhe6jQeU1XDtwQAzIgrT9wTsthKShJrYUVR33YX1tJoeajYtsBEn8F3DtlQzSnQRB
         /gUf84fkTG6xCKMvaRnPnpdRK3Afp2dfK2K2qUB0QZrZ1c6cf59vbfXEk0E6Y9yROi4Y
         0imIXI6DudVme5M+4Va+buPFsYoTjApJSdL0fEWIHLZ8VDrOcqk/UnQmKip5pVClhgvF
         QELg==
X-Gm-Message-State: AC+VfDzONlerhV+DsiEyS+xB2ZF96hUN8g9LGGFu9pXL+odzuZ9u+usP
        hk3RMTeZ6pmQ6mRwIsSlEHmhfy2PWQa5
X-Google-Smtp-Source: ACHHUZ6q7cd5oaM+do72HcSC59pF4lji4zjehfp0QAiha0uuBSxG0h3bXE32gnB2HBzKTBzCP6jiY50dBdqe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:ab8d:0:b0:bb3:9b99:f3f5 with SMTP id
 v13-20020a25ab8d000000b00bb39b99f3f5mr531633ybi.4.1686266953549; Thu, 08 Jun
 2023 16:29:13 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:27:58 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-2-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 01/26] perf thread: Remove notion of dead threads
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
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

The dead thread list is best effort. Threads live on it until the
reference count hits zero and they are removed. With correct reference
counting this should never happen. It is, however, part of the 'perf
sched' output that is now removed. If this is an issue we should
implement tracking of dead threads in a robust not best-effort way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 23 +----------------------
 tools/perf/util/cs-etm.c   |  6 ------
 tools/perf/util/intel-pt.c |  8 --------
 tools/perf/util/machine.c  | 32 +-------------------------------
 tools/perf/util/thread.c   | 25 +------------------------
 tools/perf/util/thread.h   | 11 +----------
 6 files changed, 4 insertions(+), 101 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cc4ba506e119..3a30c2ac5b47 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2760,7 +2760,7 @@ struct total_run_stats {
 	u64  total_run_time;
 };
 
-static int __show_thread_runtime(struct thread *t, void *priv)
+static int show_thread_runtime(struct thread *t, void *priv)
 {
 	struct total_run_stats *stats = priv;
 	struct thread_runtime *r;
@@ -2783,22 +2783,6 @@ static int __show_thread_runtime(struct thread *t, void *priv)
 	return 0;
 }
 
-static int show_thread_runtime(struct thread *t, void *priv)
-{
-	if (t->dead)
-		return 0;
-
-	return __show_thread_runtime(t, priv);
-}
-
-static int show_deadthread_runtime(struct thread *t, void *priv)
-{
-	if (!t->dead)
-		return 0;
-
-	return __show_thread_runtime(t, priv);
-}
-
 static size_t callchain__fprintf_folded(FILE *fp, struct callchain_node *node)
 {
 	const char *sep = " <- ";
@@ -2890,11 +2874,6 @@ static void timehist_print_summary(struct perf_sched *sched,
 	if (!task_count)
 		printf("<no still running tasks>\n");
 
-	printf("\nTerminated tasks:\n");
-	machine__for_each_thread(m, show_deadthread_runtime, &totals);
-	if (task_count == totals.task_count)
-		printf("<no terminated tasks>\n");
-
 	/* CPU idle stats not tracked when samples were skipped */
 	if (sched->skipped_samples && !sched->idle_hist)
 		return;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 91299cc56bf7..0f5be4ad24ba 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3292,12 +3292,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		goto err_free_queues;
 	}
 
-	/*
-	 * Initialize list node so that at thread__zput() we can avoid
-	 * segmentation fault at list_del_init().
-	 */
-	INIT_LIST_HEAD(&etm->unknown_thread->node);
-
 	err = thread__set_comm(etm->unknown_thread, "unknown", 0);
 	if (err)
 		goto err_delete_thread;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fe893c9bab3f..dde2ca77a005 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -4311,14 +4311,6 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		goto err_free_queues;
 	}
 
-	/*
-	 * Since this thread will not be kept in any rbtree not in a
-	 * list, initialize its list node so that at thread__put() the
-	 * current thread lifetime assumption is kept and we don't segfault
-	 * at list_del_init().
-	 */
-	INIT_LIST_HEAD(&pt->unknown_thread->node);
-
 	err = thread__set_comm(pt->unknown_thread, "unknown", 0);
 	if (err)
 		goto err_delete_thread;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9e02e19c1b7a..a1954ac85f59 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -241,17 +241,6 @@ void machine__exit(struct machine *machine)
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
-		struct thread *thread, *n;
-		/*
-		 * Forget about the dead, at this point whatever threads were
-		 * left in the dead lists better have a reference count taken
-		 * by who is using them, and then, when they drop those references
-		 * and it finally hits zero, thread__put() will check and see that
-		 * its not in the dead threads list and will not try to remove it
-		 * from there, just calling thread__delete() straight away.
-		 */
-		list_for_each_entry_safe(thread, n, &threads->dead, node)
-			list_del_init(&thread->node);
 
 		exit_rwsem(&threads->lock);
 	}
@@ -2046,18 +2035,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	rb_erase_cached(&th->rb_node, &threads->entries);
 	RB_CLEAR_NODE(&th->rb_node);
 	--threads->nr;
-	/*
-	 * Move it first to the dead_threads list, then drop the reference,
-	 * if this is the last reference, then the thread__delete destructor
-	 * will be called and we will remove it from the dead_threads list.
-	 */
-	list_add_tail(&th->node, &threads->dead);
 
-	/*
-	 * We need to do the put here because if this is the last refcount,
-	 * then we will be touching the threads->dead head when removing the
-	 * thread.
-	 */
 	thread__put(th);
 
 	if (lock)
@@ -2145,10 +2123,8 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_task(event, stdout);
 
-	if (thread != NULL) {
-		thread__exited(thread);
+	if (thread != NULL)
 		thread__put(thread);
-	}
 
 	return 0;
 }
@@ -3204,12 +3180,6 @@ int machine__for_each_thread(struct machine *machine,
 			if (rc != 0)
 				return rc;
 		}
-
-		list_for_each_entry(thread, &threads->dead, node) {
-			rc = fn(thread, priv);
-			if (rc != 0)
-				return rc;
-		}
 	}
 	return rc;
 }
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 4b5bdc277baa..d949bffc0ed6 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -125,31 +125,8 @@ struct thread *thread__get(struct thread *thread)
 
 void thread__put(struct thread *thread)
 {
-	if (thread && refcount_dec_and_test(&thread->refcnt)) {
-		/*
-		 * Remove it from the dead threads list, as last reference is
-		 * gone, if it is in a dead threads list.
-		 *
-		 * We may not be there anymore if say, the machine where it was
-		 * stored was already deleted, so we already removed it from
-		 * the dead threads and some other piece of code still keeps a
-		 * reference.
-		 *
-		 * This is what 'perf sched' does and finally drops it in
-		 * perf_sched__lat(), where it calls perf_sched__read_events(),
-		 * that processes the events by creating a session and deleting
-		 * it, which ends up destroying the list heads for the dead
-		 * threads, but before it does that it removes all threads from
-		 * it using list_del_init().
-		 *
-		 * So we need to check here if it is in a dead threads list and
-		 * if so, remove it before finally deleting the thread, to avoid
-		 * an use after free situation.
-		 */
-		if (!list_empty(&thread->node))
-			list_del_init(&thread->node);
+	if (thread && refcount_dec_and_test(&thread->refcnt))
 		thread__delete(thread);
-	}
 }
 
 static struct namespaces *__thread__namespaces(const struct thread *thread)
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 395c626699a9..86737812e06b 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -30,10 +30,7 @@ struct lbr_stitch {
 };
 
 struct thread {
-	union {
-		struct rb_node	 rb_node;
-		struct list_head node;
-	};
+	struct rb_node		rb_node;
 	struct maps		*maps;
 	pid_t			pid_; /* Not all tools update this */
 	pid_t			tid;
@@ -43,7 +40,6 @@ struct thread {
 	refcount_t		refcnt;
 	bool			comm_set;
 	int			comm_len;
-	bool			dead; /* if set thread has exited */
 	struct list_head	namespaces_list;
 	struct rw_semaphore	namespaces_lock;
 	struct list_head	comm_list;
@@ -81,11 +77,6 @@ static inline void __thread__zput(struct thread **thread)
 
 #define thread__zput(thread) __thread__zput(&thread)
 
-static inline void thread__exited(struct thread *thread)
-{
-	thread->dead = true;
-}
-
 struct namespaces *thread__namespaces(struct thread *thread);
 int thread__set_namespaces(struct thread *thread, u64 timestamp,
 			   struct perf_record_namespaces *event);
-- 
2.41.0.162.gfafddb0af9-goog

