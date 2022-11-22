Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18BF633CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiKVMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiKVMho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:37:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0302F13DE5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cNXoS8rK3xdXYHntjExdlYL5Xqo/UM8xFFchEuZahf8=; b=EaYGanzfFaL4Bx00RjIVqndAU6
        InhoUYCHsw745V6+pRgDH8/YgglXGx3G2QWlYq0by+AW6X/+diRoEwKhIBGNjt8Z6w+3kBdmAI8NB
        FnwmATxbGFZurrrET4bhqemtn75ouzH0nBtnIOBKXZQ7UiTnEzKKOMgX9oM0kM+JeL778fVRTUJ19
        B7yKDep3XUU7PUeGESfzWTnfoFitjbzEhvvbMF1jJjER5BXi6bE377iLDgDeh1bPcJAvADb4jr5bh
        ZQoHM0azouNctW5Nsaq9iy1flA/mtL3OyjzLCV49PljnZSfUFP/LeJR39rtZiQRHVTMRatSDIbPJn
        +8SAco6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxSWi-006MRl-RQ; Tue, 22 Nov 2022 12:37:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A242300244;
        Tue, 22 Nov 2022 13:37:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17D452D694B12; Tue, 22 Nov 2022 13:37:17 +0100 (CET)
Date:   Tue, 22 Nov 2022 13:37:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH-tip] sched: Don't call kfree() in do_set_cpus_allowed()
Message-ID: <Y3zCfQCpBu8aBy6O@hirez.programming.kicks-ass.net>
References: <20221118193302.522399-1-longman@redhat.com>
 <Y3tVPjAjE9OFRLaP@hirez.programming.kicks-ass.net>
 <601640d0-9dc2-a060-e165-c8efac54aa34@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <601640d0-9dc2-a060-e165-c8efac54aa34@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:04:33AM -0500, Waiman Long wrote:
> 
> On 11/21/22 05:38, Peter Zijlstra wrote:
> > On Fri, Nov 18, 2022 at 02:33:02PM -0500, Waiman Long wrote:
> > > Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> > > do_set_cpus_allowed()") may call kfree() if user_cpus_ptr was previously
> > > set. Unfortunately, some of the callers of do_set_cpus_allowed()
> > 'some' ? There's only 3 or so, which one triggers this?
> 
> It happenned at __kthread_bind_mask() where do_set_cpus_allowed() is called
> with pi_lock held.
> 
> [ 1084.820105]  <TASK>
> [ 1084.820110]  dump_stack_lvl+0x57/0x81
> [ 1084.820117]  check_noncircular+0x103/0x120
> [ 10[ 1084.820160]  lock_acquire+0xba/0x230
> [ 1084.820164]  ? kfree+0x10f/0x380
> [ 1084.820172]  ? do_set_cpus_allowed+0x40/0x60
> [ 1084.820181]  rt_spin_lock+0x27/0xe0
> [ 1084.820184]  ? kfree+0x10f/0x380
> [ 1084.820188]  kfree+0x10f/0x380
> [ 1084.820195]  do_set_cpus_allowed+0x40/0x60
> [ 1084.820203]  kthread_bind_mask+0x4a/0x70
> [ 1084.820211]  create_worker+0xfb/0x1a0
> [ 1084.820220]  worker_thread+0x2e3/0x3c0
> [ 1084.820226]  ? process_one_work+0x450/0x450
> [ 1084.820230]  kthread+0x111/0x130
> [ 1084.820236]  ? kthread_complete_and_exit+0x20/0x20
> [ 1084.820244]  ret_from_fork+0x22/0x30
> [ 1084.820258]  </TASK>
> [ 1084.820260] BUG: sleeping function called from invalid context at
> kernel/locking/spinlock_rt.c:46
> 
> It shows up with PREEMPT_RT kernel.

Oh, I see ..

> Maybe. One thing that I am not clear about is why user_cpus_ptr is set in
> the first place.

Perhaps someone set an affinity on kthreadd ?

But I'm thinking this exact problem is also possible (rather more likely
even) with select_fallback_rq() that too holds pi_lock (which account
for both other users of this function).

Bah.

And the allocation is just the one long in size (for small configs)
which is just enough space for a single linked list like you had.

Urgh.

The below is yuck too, and I'm not sure Paul wants us to use
kvfree_call_rcu() without its wrapper.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78b2d5cabcc5..0d0af0fc7fcf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2606,7 +2606,12 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	};
 
 	__do_set_cpus_allowed(p, &ac);
-	kfree(ac.user_mask);
+	/*
+	 * Because this is called with p->pi_lock held, it is not possible
+	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
+	 * kfree_rcu().
+	 */
+	kvfree_call_rcu((struct rcu_head *)ac.user_mask, (rcu_callback_t)0);
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
@@ -8196,7 +8201,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	struct affinity_context ac;
 	struct cpumask *user_mask;
 	struct task_struct *p;
-	int retval;
+	int retval, size;
 
 	rcu_read_lock();
 
@@ -8229,7 +8234,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+	/*
+	 * See do_set_cpus_allowed() for the rcu_head usage.
+	 */
+	size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
+	user_mask = kmalloc(size, GFP_KERNEL);
 	if (!user_mask) {
 		retval = -ENOMEM;
 		goto out_put_task;
