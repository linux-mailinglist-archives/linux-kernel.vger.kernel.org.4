Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C66436A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiLEVQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLEVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:16:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D1A2C66F;
        Mon,  5 Dec 2022 13:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 260BB61459;
        Mon,  5 Dec 2022 21:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AC6C433D6;
        Mon,  5 Dec 2022 21:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670274997;
        bh=WOS6AsLAD3h/ufcHAM7KS1SF76vYuLHpGoyFvgdD/NU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MRJRvtfArM6xOAWKEKAcYekp25Ggqs6Lyp6iOnhWMjcr786NCgxMKxknf+DPv6P0l
         cJJBRrRUysAD8ivqVFtYa92nppUVH1Wn9EpAgv3S7tlSMlC0ZKZ6Hbv4Nr4guAd5A6
         qYQmf06NE+aEK7YBsEAuCylXznUhZIlOvsftQqN6zxiLOc9lLqgokA+axUveKtt7mA
         tunCJCNN1oFfKykihCfgJQpq3qoiBWdbrovs60vSSwzdLPuYGpO0rYhZ+MfB552O0e
         Z/fZxNSHlb2MKILLQiYM2zpt0HSD647cN4MzMka1cH0k1aopajQxqszgrISoyvoVpd
         Gn9yoqoTe4L5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 28F355C0E98; Mon,  5 Dec 2022 13:16:37 -0800 (PST)
Date:   Mon, 5 Dec 2022 13:16:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu-tasks: Make shrink down to a single callback queue
 safely
Message-ID: <20221205211637.GA1476235@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221130051253.1884572-1-qiang1.zhang@intel.com>
 <20221202195723.GB4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B8D62B5EA5643593EC62DA179@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221203002154.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880D9440D871BB09C1D3731DA199@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880D9440D871BB09C1D3731DA199@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 01:47:11AM +0000, Zhang, Qiang1 wrote:
> On Fri, Dec 02, 2022 at 11:35:09PM +0000, Zhang, Qiang1 wrote:
> > On Wed, Nov 30, 2022 at 01:12:53PM +0800, Zqiang wrote:
> > > Assume that the current RCU-task belongs to per-CPU callback queuing
> > > mode and the rcu_task_cb_adjust is true.
> > > 
> > >       CPU0					CPU1
> > > 
> > > rcu_tasks_need_gpcb()
> > >   ncbsnz == 0 and
> > >   ncbs < rcu_task_collapse_lim
> > > 
> > > 					      invoke call_rcu_tasks_generic()
> > > 						 enqueue callback to CPU1
> > > 					        (CPU1 n_cbs not equal zero)
> > > 
> > >   if (rcu_task_cb_adjust &&
> > >   ncbs <= rcu_task_collapse_lim)
> > >     if (rtp->percpu_enqueue_lim > 1)
> > >       rtp->percpu_enqueue_lim = 1;
> > >       rtp->percpu_dequeue_gpseq =
> > >       get_state_synchronize_rcu();
> > > 
> > > 
> > >   A full RCU grace period has passed
> > >
> > >
> > >I don't see how this grace period can elapse.  The rcu_tasks_need_gpcb()
> > >function is invoked only from rcu_tasks_one_gp(), and while holding
> > >->tasks_gp_mutex.
> > 
> > 
> > Hi Paul
> > 
> > I mean that It's the RCU grace period instead of the RCU task grace period.
> > 
> > rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
> > 
> > get_state_synchronize_rcu(rtp->percpu_dequeue_gpseq);
> > 
> > There is a window period between these two calls,  preemption may occur.
> > A full RCU grace period may have passed.
> > when we run it again we find get_state_synchronize_rcu() == true.
> >
> >Ah, thank you!
> >
> >But for that issue, why not just place both "if" statements into an
> >RCU read-side critical section?  
> 
> Ah, a better method(my brain didn't think of this way at the first time), I have been send v2.

Well, one reason that your brain might not have thought of this way is
that it does not actually fix the problem.  ;-)

The reason that it does not fix the problem is that this problem isn't
just that the grace period can end between those two "if" statements.
The problem is also that the grace period can end just after the loop
over the CPUs, the one that computes ncbsnz.

Don't get me wrong, I am very happy that you found this bug.  After all,
we cannot fix bugs that we don't know about.

So I updated your commit to check for grace-period completion upon entry
to the rcu_tasks_need_gpcb() function.

And now my question to you is "What bugs remain?"  There are bugs in
there somewhere!  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit d5655681fe0f1cf531ec8300c06d3a7826cbca8f
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Sat Dec 3 10:25:03 2022 +0800

    rcu-tasks: Handle queue-shrink/callback-enqueue race condition
    
    The rcu_tasks_need_gpcb() determines whether or not: (1) There are
    callbacks needing another grace period, (2) There are callbacks ready
    to be invoked, and (3) It would be a good time to shrink back down to a
    single-CPU callback list.  This third case is interesting because some
    other CPU might be adding new callbacks, which might suddenly make this
    a very bad time to be shrinking.
    
    This is currently handled by requiring call_rcu_tasks_generic() to
    enqueue callbacks under the protection of rcu_read_lock() and requiring
    rcu_tasks_need_gpcb() to wait for an RCU grace period to elapse before
    finalizing the transition.  This works well in practice.
    
    Unfortunately, the current code assumes that a grace period whose end is
    detected by the poll_state_synchronize_rcu() in the second "if" condition
    actually ended before the earlier code counted the callbacks queued on
    CPUs other than CPU 0 (local variable "ncbsnz").  Given the current code,
    it is possible that a long-delayed call_rcu_tasks_generic() invocation
    will queue a callback on a non-zero CPU after these CPUs have had their
    callbacks counted and zero has been stored to ncbsnz.  Such a callback
    would trigger the WARN_ON_ONCE() in the second "if" statement.
    
    To see this, consider the following sequence of events:
    
    o       CPU 0 invokes rcu_tasks_one_gp(), and counts fewer than
            rcu_task_collapse_lim callbacks.  It sees at least one
            callback queued on some other CPU, thus setting ncbsnz
            to a non-zero value.
    
    o       CPU 1 invokes call_rcu_tasks_generic() and loads 42 from
            ->percpu_enqueue_lim.  It therefore decides to enqueue its
            callback onto CPU 1's callback list, but is delayed.
    
    o       CPU 0 sees the rcu_task_cb_adjust is non-zero and that the number
            of callbacks does not exceed rcu_task_collapse_lim.  It therefore
            checks percpu_enqueue_lim, and sees that its value is greater
            than the value one.  CPU 0 therefore  starts the shift back
            to a single callback list.  It sets ->percpu_enqueue_lim to 1,
            but CPU 1 has already read the old value of 42.  It also gets
            a grace-period state value from get_state_synchronize_rcu().
    
    o       CPU 0 sees that ncbsnz is non-zero in its second "if" statement,
            so it declines to finalize the shrink operation.
    
    o       CPU 0 again invokes rcu_tasks_one_gp(), and counts fewer than
            rcu_task_collapse_lim callbacks.  It also sees that there are
            no callback queued on any other CPU, and thus sets ncbsnz to zero.
    
    o       CPU 1 resumes execution and enqueues its callback onto its own
            list.  This invalidates the value of ncbsnz.
    
    o       CPU 0 sees the rcu_task_cb_adjust is non-zero and that the number
            of callbacks does not exceed rcu_task_collapse_lim.  It therefore
            checks percpu_enqueue_lim, but sees that its value is already
            unity.  It therefore does not get a new grace-period state value.
    
    o       CPU 0 sees that rcu_task_cb_adjust is non-zero, ncbsnz is zero,
            and that poll_state_synchronize_rcu() says that the grace period
            has completed.  it therefore finalizes the shrink operation,
            setting ->percpu_dequeue_lim to the value one.
    
    o       CPU 0 does a debug check, scanning the other CPUs' callback lists.
            It sees that CPU 1's list has a callback, so it (rightly)
            triggers the WARN_ON_ONCE().  After all, the new value of
            ->percpu_dequeue_lim says to not bother looking at CPU 1's
            callback list, which means that this callback will never be
            invoked.  This can result in hangs and maybe even OOMs.
    
    Based on long experience with rcutorture, this is an extremely
    low-probability race condition, but it really can happen, especially in
    preemptible kernels or within guest OSes.
    
    This commit therefore checks for completion of the grace period
    before counting callbacks.  With this change, in the above failure
    scenario CPU 0 would know not to prematurely end the shrink operation
    because the grace period would not have completed before the count
    operation started.
    
    [ paulmck: Adjust grace-period end rather than adding RCU reader. ]
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d845723c1af41..38f7b5892560d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -384,6 +384,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 {
 	int cpu;
 	unsigned long flags;
+	bool gpdone = poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq);
 	long n;
 	long ncbs = 0;
 	long ncbsnz = 0;
@@ -425,12 +426,12 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
+			gpdone = false;
 			pr_info("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
-	if (rcu_task_cb_adjust && !ncbsnz &&
-	    poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq)) {
+	if (rcu_task_cb_adjust && !ncbsnz && gpdone) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
 			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
