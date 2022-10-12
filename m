Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1325FCC63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJLUsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJLUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:48:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F655E556;
        Wed, 12 Oct 2022 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9sjzWyKdmZ9OHhAKFmjjGkydIB7vKqM9NhqC/8vlv8Y=; b=LOSgfJ4C+rzH5Qa9aLLf1JkUWk
        +VzpDxeba7h2b44jUArU54rfYAIiCnJDuQT9GqdHFrqlbpH2WH8Xz8wK5OzwYZAt17nEtQ37C4hK2
        UEavj5NENKwlyFIJn6DyrGMaEDg6p4BnLkgFBxWDX7Nx0R7/Ps2oA8Zgj2bh60gjBNlo1awu2m8Fx
        gkqsyXQhc+H4OagJixgZgM6v7jMNsyOTKTLuVmz67xCbE6kRvxIyDB+Dv4LwoQBUAlJEJtN14uk/D
        IyZRdLuFYVw0nbTtXsFZlU3FzXKl1J39rbJi5vJWvg1x8Q3DDL/xVfaOUrzy3/ImaJRPizT1j16E7
        8WLBSZ9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiidN-002wt9-7C; Wed, 12 Oct 2022 20:47:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70541300023;
        Wed, 12 Oct 2022 22:47:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56BEA2B6BE2AB; Wed, 12 Oct 2022 22:47:19 +0200 (CEST)
Date:   Wed, 12 Oct 2022 22:47:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, ndesaulniers@google.com,
        srw@sladewatkins.net, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2] perf: Rewrite core context handling
Message-ID: <Y0cn1xazYpNmqhRo@hirez.programming.kicks-ass.net>
References: <20221008062424.313-1-ravi.bangoria@amd.com>
 <Y0VTn0qLWd925etP@hirez.programming.kicks-ass.net>
 <ba47d079-6d97-0412-69a0-fa15999b5024@amd.com>
 <Y0V3kOWInrvCvVtk@hirez.programming.kicks-ass.net>
 <Y0WsRItHmfI5uaq3@hirez.programming.kicks-ass.net>
 <174fb540-ec18-eeca-191d-c02e1f1005d2@amd.com>
 <Y0awHa8oS5yal5M9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0awHa8oS5yal5M9@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 02:16:29PM +0200, Peter Zijlstra wrote:

> That's the intent yeah. But due to not always holding ctx->mutex over
> put_pmu_ctx() this might be moot. I'm almost through auditing epc usage
> and I think ctx->lock is sufficient, fingers crossed.

So the very last epc usage threw a spanner into the works and made
things complicated.

Specifically sys_perf_event_open()'s group_leader case uses
event->pmu_ctx while only holding ctx->mutex. Therefore we can't fully
let go of ctx->mutex locking and purely rely on ctx->lock.

Now the good news is that the annoying put_pmu_ctx() without holding
ctx->mutex case doesn't actually matter here. Since we hold a reference
on the group_leader (per the filedesc) the event can't go away,
therefore it must have a pmu_ctx, and then holding ctx->mutex ensures
the pmu_ctx is stable -- iow it serializes against
sys_perf_event_open()'s move_group and perf_pmu_migrate_context()
changing the epc around.

So we're going with the normal mutex+lock for modification rule, but
allow the weird put_pmu_ctx() exception.

I have the below delta.

I'm hoping we can call this done -- I'm going to see if I can bribe Mark
to take a look at the arm64 thing soon and then hopefully queue the
whole thing once -rc1 happens. That should give us a good long soak
until the next merge window.

---
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -826,21 +826,28 @@ struct perf_event {
 };
 
 /*
- *           ,------------------------[1:n]---------------------.
+ *           ,-----------------------[1:n]----------------------.
  *           V                                                  V
  * perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
  *           ^                      ^     |                     |
  *           `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
  *
  *
- * XXX destroy epc when empty
- *   refcount, !rcu
- *
- * XXX epc locking
- *
- *   event->pmu_ctx            ctx->mutex && inactive
- *   ctx->pmu_ctx_list         ctx->mutex && ctx->lock
- *
+ * struct perf_event_pmu_context  lifetime is refcount based and RCU freed
+ * (similar to perf_event_context). Locking is as if it were a member of
+ * perf_event_context; specifically:
+ *
+ *   modification, both: ctx->mutex && ctx->lock
+ *   reading, either:    ctx->mutex || ctx->lock
+ *
+ * There is one exception to this; namely put_pmu_ctx() isn't always called
+ * with ctx->mutex held; this means that as long as we can guarantee the epc
+ * has events the above rules hold.
+ *
+ * Specificially, sys_perf_event_open()'s group_leader case depends on
+ * ctx->mutex pinning the configuration. Since we hold a reference on
+ * group_leader (through the filedesc) it can't fo away, therefore it's
+ * associated pmu_ctx must exist and cannot change due to ctx->mutex.
  */
 struct perf_event_pmu_context {
 	struct pmu			*pmu;
@@ -857,6 +864,7 @@ struct perf_event_pmu_context {
 	unsigned int			nr_events;
 
 	atomic_t			refcount; /* event <-> epc */
+	struct rcu_head			rcu_head;
 
 	void				*task_ctx_data; /* pmu specific data */
 	/*
@@ -906,7 +914,7 @@ struct perf_event_context {
 	int				nr_freq;
 	int				rotate_disable;
 
-	refcount_t			refcount;
+	refcount_t			refcount; /* event <-> ctx */
 	struct task_struct		*task;
 
 	/*
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1727,6 +1727,10 @@ perf_event_groups_next(struct perf_event
 	return NULL;
 }
 
+#define perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu)		\
+	for (event = perf_event_groups_first(groups, cpu, pmu, NULL);	\
+	     event; event = perf_event_groups_next(event, pmu))
+
 /*
  * Iterate through the whole groups tree.
  */
@@ -3366,6 +3370,14 @@ static void perf_event_sync_stat(struct
 	}
 }
 
+#define double_list_for_each_entry(pos1, pos2, head1, head2, member)	\
+	for (pos1 = list_first_entry(head1, typeof(*pos1), member),	\
+	     pos2 = list_first_entry(head2, typeof(*pos2), member);	\
+	     !list_entry_is_head(pos1, head1, member) &&		\
+	     !list_entry_is_head(pos2, head2, member);			\
+	     pos1 = list_next_entry(pos1, member),			\
+	     pos2 = list_next_entry(pos2, member))
+
 static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
 					  struct perf_event_context *next_ctx)
 {
@@ -3374,17 +3386,12 @@ static void perf_event_swap_task_ctx_dat
 	if (!prev_ctx->nr_task_data)
 		return;
 
-	prev_epc = list_first_entry(&prev_ctx->pmu_ctx_list,
-				    struct perf_event_pmu_context,
-				    pmu_ctx_entry);
-	next_epc = list_first_entry(&next_ctx->pmu_ctx_list,
-				    struct perf_event_pmu_context,
-				    pmu_ctx_entry);
-
-	while (&prev_epc->pmu_ctx_entry != &prev_ctx->pmu_ctx_list &&
-	       &next_epc->pmu_ctx_entry != &next_ctx->pmu_ctx_list) {
+	double_list_for_each_entry(prev_epc, next_epc,
+				   &prev_ctx->pmu_ctx_list, &next_ctx->pmu_ctx_list,
+				   pmu_ctx_entry) {
 
-		WARN_ON_ONCE(prev_epc->pmu != next_epc->pmu);
+		if (WARN_ON_ONCE(prev_epc->pmu != next_epc->pmu))
+			continue;
 
 		/*
 		 * PMU specific parts of task perf context can require
@@ -3706,7 +3713,6 @@ static noinline int visit_groups_merge(s
 		perf_assert_pmu_disabled((*evt)->pmu_ctx->pmu);
 	}
 
-
 	min_heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.nr) {
@@ -3845,7 +3851,6 @@ ctx_sched_in(struct perf_event_context *
 		/* start ctx time */
 		__update_context_time(ctx, false);
 		perf_cgroup_set_timestamp(cpuctx);
-		// XXX ctx->task =? task
 		/*
 		 * CPU-release for the below ->is_active store,
 		 * see __load_acquire() in perf_event_time_now()
@@ -4815,6 +4820,15 @@ find_get_pmu_context(struct pmu *pmu, st
 
 	__perf_init_event_pmu_context(new, pmu);
 
+	/*
+	 * XXX
+	 *
+	 * lockdep_assert_held(&ctx->mutex);
+	 *
+	 * can't because perf_event_init_task() doesn't actually hold the
+	 * child_ctx->mutex.
+	 */
+
 	raw_spin_lock_irq(&ctx->lock);
 	list_for_each_entry(epc, &ctx->pmu_ctx_list, pmu_ctx_entry) {
 		if (epc->pmu == pmu) {
@@ -4849,6 +4863,14 @@ static void get_pmu_ctx(struct perf_even
 	WARN_ON_ONCE(!atomic_inc_not_zero(&epc->refcount));
 }
 
+static void free_epc_rcu(struct rcu_head *head)
+{
+	struct perf_event_pmu_context *epc = container_of(head, typeof(*epc), rcu_head);
+
+	kfree(epc->task_ctx_data);
+	kfree(epc);
+}
+
 static void put_pmu_ctx(struct perf_event_pmu_context *epc)
 {
 	unsigned long flags;
@@ -4859,7 +4881,14 @@ static void put_pmu_ctx(struct perf_even
 	if (epc->ctx) {
 		struct perf_event_context *ctx = epc->ctx;
 
-		// XXX ctx->mutex
+		/*
+		 * XXX
+		 *
+		 * lockdep_assert_held(&ctx->mutex);
+		 *
+		 * can't because of the call-site in _free_event()/put_event()
+		 * which isn't always called under ctx->mutex.
+		 */
 
 		WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
 		raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -4874,17 +4903,15 @@ static void put_pmu_ctx(struct perf_even
 	if (epc->embedded)
 		return;
 
-	kfree(epc->task_ctx_data);
-	kfree(epc);
+	call_rcu(&epc->rcu_head, free_epc_rcu);
 }
 
 static void perf_event_free_filter(struct perf_event *event);
 
 static void free_event_rcu(struct rcu_head *head)
 {
-	struct perf_event *event;
+	struct perf_event *event = container_of(head, typeof(*event), rcu_head);
 
-	event = container_of(head, struct perf_event, rcu_head);
 	if (event->ns)
 		put_pid_ns(event->ns);
 	perf_event_free_filter(event);
@@ -12436,6 +12463,9 @@ SYSCALL_DEFINE5(perf_event_open,
 			 * Allow the addition of software events to hw
 			 * groups, this is safe because software events
 			 * never fail to schedule.
+			 *
+			 * Note the comment that goes with struct
+			 * pmu_event_pmu_context.
 			 */
 			pmu = group_leader->pmu_ctx->pmu;
 		} else if (!is_software_event(event) &&
@@ -12643,13 +12673,6 @@ perf_event_create_kernel_counter(struct
 		goto err_alloc;
 	}
 
-	pmu_ctx = find_get_pmu_context(pmu, ctx, event);
-	if (IS_ERR(pmu_ctx)) {
-		err = PTR_ERR(pmu_ctx);
-		goto err_ctx;
-	}
-	event->pmu_ctx = pmu_ctx;
-
 	WARN_ON_ONCE(ctx->parent_ctx);
 	mutex_lock(&ctx->mutex);
 	if (ctx->task == TASK_TOMBSTONE) {
@@ -12657,6 +12680,13 @@ perf_event_create_kernel_counter(struct
 		goto err_unlock;
 	}
 
+	pmu_ctx = find_get_pmu_context(pmu, ctx, event);
+	if (IS_ERR(pmu_ctx)) {
+		err = PTR_ERR(pmu_ctx);
+		goto err_unlock;
+	}
+	event->pmu_ctx = pmu_ctx;
+
 	if (!task) {
 		/*
 		 * Check if the @cpu we're creating an event for is online.
@@ -12668,13 +12698,13 @@ perf_event_create_kernel_counter(struct
 			container_of(ctx, struct perf_cpu_context, ctx);
 		if (!cpuctx->online) {
 			err = -ENODEV;
-			goto err_unlock;
+			goto err_pmu_ctx;
 		}
 	}
 
 	if (!exclusive_event_installable(event, ctx)) {
 		err = -EBUSY;
-		goto err_unlock;
+		goto err_pmu_ctx;
 	}
 
 	perf_install_in_context(ctx, event, event->cpu);
@@ -12683,9 +12713,10 @@ perf_event_create_kernel_counter(struct
 
 	return event;
 
+err_pmu_ctx:
+	put_pmu_ctx(pmu_ctx);
 err_unlock:
 	mutex_unlock(&ctx->mutex);
-err_ctx:
 	perf_unpin_context(ctx);
 	put_ctx(ctx);
 err_alloc:
@@ -12702,9 +12733,7 @@ static void __perf_pmu_remove(struct per
 {
 	struct perf_event *event, *sibling;
 
-	for (event = perf_event_groups_first(groups, cpu, pmu, NULL);
-	     event; event = perf_event_groups_next(event, pmu)) {
-
+	perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu) {
 		perf_remove_from_context(event, 0);
 		unaccount_event_cpu(event, cpu);
 		put_pmu_ctx(event->pmu_ctx);
@@ -12998,7 +13027,7 @@ void perf_event_free_task(struct task_st
 	struct perf_event_context *ctx;
 	struct perf_event *event, *tmp;
 
-	ctx = rcu_dereference(task->perf_event_ctxp);
+	ctx = rcu_access_pointer(task->perf_event_ctxp);
 	if (!ctx)
 		return;
 


