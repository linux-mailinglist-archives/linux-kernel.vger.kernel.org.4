Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AA6FF349
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbjEKNoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbjEKNnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:43:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136E3198E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4qp46Ij5xomW4Ib0h9qDvEyH41IkXYN+EmI7j+nWbNA=; b=lMT5uLQAVGw13egEF/Wfg2LNgb
        3bHesWw9/FN3alBo1Eg+PCEh5PnlOf/pp6tfdeY+ZuGfzbGPB/YQ/NwKqFOvMJwOsbBwPorr22qWq
        a2aYED9/QisqUt8luFfDP0kKmsF4dGEVk8hf+q+3s/Znoe6xYeD/UDoBOfR/JUCTuHREKOdfuDXFr
        NSwF3A4OegtmM9PwtbUS2iZKKn/Nlk/qqR3By2tHQuetJVN4AXx/ejXnXp+mdZKPeerm31h8JI0mx
        HIH6eHkUIw35yGxvnffDvtFBPx6g2zRdFaopw78GzupwW2aaXOimOkxrvwkyybKrFUQ5hioebpMwr
        drc8K2Pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1px6Zb-008FSE-1t;
        Thu, 11 May 2023 13:43:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6C34300338;
        Thu, 11 May 2023 15:43:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63EAB2007BEFE; Thu, 11 May 2023 15:43:08 +0200 (CEST)
Date:   Thu, 11 May 2023 15:43:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Crystal Wood <swood@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/core: Provide sched_rtmutex() and expose
 sched work helpers
Message-ID: <20230511134308.GV4253@hirez.programming.kicks-ass.net>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
 <20230427111937.2745231-2-bigeasy@linutronix.de>
 <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
 <20230510150415.6BXNs0I1@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510150415.6BXNs0I1@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:04:15PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-05-03 15:20:51 [+0200], Peter Zijlstra wrote:
> > Urgh, so I really don't like this.
> > 
> > The end result is something like:
> > 
> > 	rt_mutex_lock()
> > 	  sched_submit_work();
> > 	    // a nested rt_mutex_lock() here will not clobber
> > 	    // ->pi_blocked_on because it's not set yet.
> > 
> > 	  task_blocks_on_rt_mutex();
> > 	    tsk->pi_blocked_on = waiter;
> > 	    rt_mutex_enqueue(lock, waiter); <-- the real problem
> > 
> > 	  rt_mutex_slowlock_block();
> > 	    schedule_rtmutex();
> > 
> > 	  sched_resume_work();
> > 
> > And all of this it not just because tsk->pi_blocked_on, but mostly
> > because of task_blocks_on_rt_mutex() enqueueing the waiter. The whole
> > enqueue thing is what makes the 'simple' solution of saving/restoring
> > tsk->pi_blocked_on not work.
> > 
> > Basically the pi_blocked_on curruption is a side effect, not the
> > fundamental issue. One task having two waiters registered is the bigger
> > issue.
> 
> Yes, one task blocks on two locks but the lock in sched_submit_work()
> needs to be solved first.

Sure.. just saying that the focus on ->pi_blocked_on is a wee bit under
representing the issue, because there's a 'simple' solution for
->pi_blocked_on. There is not for the whole waiter situation.

> > Now, sched_submit_work() could also use (regular) mutex -- after all
> > it's a fully preemptible context. And then we're subject to the 'same'
> > problem but with tsk->blocked_on (DEBUG_MUTEXES=y).
> 
> Not sure I follow. We only invoke sched_submit_work() if we block on a
> lock which is sleeping on !RT (mutex_t, not spinlock_t). I browsed of
> few of the sched_submit_work() callbacks and they all use non-sleeping
> locks (on !RT).

Right, but this is not enforced, they could change this and we'd never
know.

It used to be ran with IRQs disabled so anybody trying to do 'funny'
things would get yelled at, but commit 9c40cef2b799 ("sched: Move
blk_schedule_flush_plug() out of __schedule()") broke that.

> If a sched_submit_work() would use a mutex_t lock then we would
> recursively call blk_flush_plug() before setting tsk->blocked_on and

I'm not following, mutex code sets tsk->blocked_on before it calls
schedule(), getting into the very same problem you have with rt_mutex.

> perform the same callback and block on the very same lock (again).
> This isn't different compared to !RT therefore you must not use a
> sleeping lock (mutex_t) in the callback.

See the enforcement thing; today nothing stops the code from using a
mutex or other blocking primitives here.


> > pulling out task_is_running() like this is going to get into conflict
> > with TJs patches here:
> > 
> >   https://lkml.kernel.org/r/20230418205159.724789-1-tj@kernel.org
> > 
> > That makes sched_submit_work() do things even if task_is_running().
> 
> Do I rebase my stuff on top of his then and we good?

I just suggested he try something else:

  https://lkml.kernel.org/r/20230510150946.GO4253@hirez.programming.kicks-ass.net

if that works out this worry goes away.

If we get PROVE_RAW_LOCK_NESTING usable, something like the below might
help out with the validation part...

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae39861..8df1aa333dee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6694,11 +6694,18 @@ void __noreturn do_task_dead(void)
 
 static inline void sched_submit_work(struct task_struct *tsk)
 {
+	static DEFINE_WAIT_OVERRIDE_MAP(sched_map, LD_WAIT_CONFIG);
 	unsigned int task_flags;
 
 	if (task_is_running(tsk))
 		return;
 
+	/*
+	 * Establish LD_WAIT_CONFIG context to ensure none of the code called
+	 * will use a blocking primitive.
+	 */
+	lock_map_acquire_try(&sched_map);
+
 	task_flags = tsk->flags;
 	/*
 	 * If a worker goes to sleep, notify and ask workqueue whether it
@@ -6723,6 +6730,8 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * make sure to submit it to avoid deadlocks.
 	 */
 	blk_flush_plug(tsk->plug, true);
+
+	lock_map_release(&sched_map);
 }
 
 static void sched_update_worker(struct task_struct *tsk)
