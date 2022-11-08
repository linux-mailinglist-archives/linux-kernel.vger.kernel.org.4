Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9D620BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiKHJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiKHJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:20:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B71425C42
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J9YI2yfMXfeaVkk01Qez3Yo05WRbedBYrlY3e+dTokg=; b=G1+McNwDhgQI8OuKumpVpUzQJI
        k+EgETyuFN5+CofixTVCLSEFP0RbLAc/Oj6nGl5jy3L4t4pCo7tPuVCRy9s1vzxIIF7GQ+/YMeAT6
        hsenbuUcWC8HLoPj4uUDIuMkuN8WvSVjHf6k+6TAD1So6/7OCumyAm7iDWCAV6rdpWqgWyLYovy2r
        wXXoghl4QBPWY7ZNs86AOG9PJ7xj/p9Ycvy7IbbTfwjvnUPuWJ0M2WcOaHkqozVd2WaAQlS+5N3Tt
        Ff8AakhE2zyjuO10hC7+Zf2na9zeYh2xOZ29UWadItlUC0kwGZEd6nCryqdxXZnRIXE8fSNiD+TZ/
        pw+dfSSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osKmd-00A8yp-Dq; Tue, 08 Nov 2022 09:20:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B92C0300244;
        Tue,  8 Nov 2022 10:20:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7BE12B878550; Tue,  8 Nov 2022 10:20:31 +0100 (CET)
Date:   Tue, 8 Nov 2022 10:20:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Minor optimize ttwu_runnable()
Message-ID: <Y2ofXw0FfQHEBUpu@hirez.programming.kicks-ass.net>
References: <20221102102343.57845-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102102343.57845-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:23:43PM +0800, Chengming Zhou wrote:
> ttwu_runnable() is used as a fast wakeup path when the wakee task
> is between set_current_state() and schedule(), in which case all
> we need to do is change p->state back to TASK_RUNNING. So we don't
> need to update_rq_clock() and check_preempt_curr() in this case.
> 
> Some performance numbers using mmtests/perfpipe on Intel Xeon server:
> 
>                            linux-next                patched
> Min       Time        8.67 (   0.00%)        8.66 (   0.13%)
> 1st-qrtle Time        8.83 (   0.00%)        8.72 (   1.19%)
> 2nd-qrtle Time        8.90 (   0.00%)        8.76 (   1.57%)
> 3rd-qrtle Time        8.98 (   0.00%)        8.82 (   1.82%)
> Max-1     Time        8.67 (   0.00%)        8.66 (   0.13%)
> Max-5     Time        8.67 (   0.00%)        8.66 (   0.13%)
> Max-10    Time        8.79 (   0.00%)        8.69 (   1.09%)
> Max-90    Time        9.01 (   0.00%)        8.84 (   1.94%)
> Max-95    Time        9.02 (   0.00%)        8.85 (   1.86%)
> Max-99    Time        9.02 (   0.00%)        8.88 (   1.56%)
> Max       Time        9.59 (   0.00%)        8.89 (   7.29%)
> Amean     Time        8.92 (   0.00%)        8.77 *   1.65%*
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 87c9cdf37a26..3785418de127 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3718,9 +3718,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
> -		/* check_preempt_curr() may use rq clock */
> -		update_rq_clock(rq);
> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
> +		WRITE_ONCE(p->__state, TASK_RUNNING);
> +		trace_sched_wakeup(p);
>  		ret = 1;
>  	}
>  	__task_rq_unlock(rq, &rf);

Yes, I think this is correct; however I would re-organize code a little.

How's this?


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..43d9a1551a5d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3602,15 +3602,40 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 		__schedstat_inc(p->stats.nr_wakeups_sync);
 }
 
 /*
- * Mark the task runnable and perform wakeup-preemption.
+ * Mark the task runnable...
  */
-static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
-			   struct rq_flags *rf)
+static inline void ttwu_do_wakeup(struct task_struct *p)
 {
-	check_preempt_curr(rq, p, wake_flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
 	trace_sched_wakeup(p);
+}
+
+static void
+ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
+		 struct rq_flags *rf)
+{
+	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
+
+	lockdep_assert_rq_held(rq);
+
+	if (p->sched_contributes_to_load)
+		rq->nr_uninterruptible--;
+
+#ifdef CONFIG_SMP
+	if (wake_flags & WF_MIGRATED)
+		en_flags |= ENQUEUE_MIGRATED;
+	else
+#endif
+	if (p->in_iowait) {
+		delayacct_blkio_end(p);
+		atomic_dec(&task_rq(p)->nr_iowait);
+	}
+
+	activate_task(rq, p, en_flags);
+	check_preempt_curr(rq, p, wake_flags);
+
+	ttwu_do_wakeup(p);
 
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
@@ -3640,31 +3666,6 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 }
 
-static void
-ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
-		 struct rq_flags *rf)
-{
-	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
-
-	lockdep_assert_rq_held(rq);
-
-	if (p->sched_contributes_to_load)
-		rq->nr_uninterruptible--;
-
-#ifdef CONFIG_SMP
-	if (wake_flags & WF_MIGRATED)
-		en_flags |= ENQUEUE_MIGRATED;
-	else
-#endif
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
-	activate_task(rq, p, en_flags);
-	ttwu_do_wakeup(rq, p, wake_flags, rf);
-}
-
 /*
  * Consider @p being inside a wait loop:
  *
@@ -3698,9 +3699,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
-		/* check_preempt_curr() may use rq clock */
-		update_rq_clock(rq);
-		ttwu_do_wakeup(rq, p, wake_flags, &rf);
+		ttwu_do_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
@@ -4062,8 +4061,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;
 
 		trace_sched_waking(p);
-		WRITE_ONCE(p->__state, TASK_RUNNING);
-		trace_sched_wakeup(p);
+		ttwu_do_wakeup(p);
 		goto out;
 	}
 
