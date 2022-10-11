Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985E5FAD69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJKHZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJKHZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC996290B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A4CB61121
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732A5C433D6;
        Tue, 11 Oct 2022 07:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665473121;
        bh=66tbg2uVHxoHJu/tRj3uKoF0i451y5CEAN+MX7z5GeU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jkgyQwV3z+KvfV8oK8B801D65p+a5S/82b2O8Bnp0JgbLY3fxbFY2SIOOqQsV0Qxc
         6jHd700LEBBcT/g4KdWLboKXwcx//8Uy8hKSv4+V1xNDN/Pt2bAkM4mfZrCL11fsMh
         KIVjPiNoOo94HMZIn+20llpgBfp9NugGtHNxQBoAK+fMsB8fpbd021kawXQ2nYW8d6
         qW9OZM2Tpk6VKzp9sanCT18upSRgib0bZ9nmW3IbLyPyQu42uGiO+qWPGy7r/OpTLk
         /KZrbpPff7vF1gsej/itQ4NvoDuGSHFKvAkAMR7cOKlXSOxOG+wRB6CEiDFyVSNntz
         nXOmuD/6dKnQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 713635C04B3; Tue, 11 Oct 2022 00:25:17 -0700 (PDT)
Date:   Tue, 11 Oct 2022 00:25:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rcu: Fix missing nocb gp wake on rcu_barrier()
Message-ID: <20221011072517.GB4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221010223956.1041247-1-frederic@kernel.org>
 <20221010223956.1041247-2-frederic@kernel.org>
 <Y0TOc8eigdzanBGQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0TOc8eigdzanBGQ@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:01:23AM +0000, Joel Fernandes wrote:
> On Tue, Oct 11, 2022 at 12:39:55AM +0200, Frederic Weisbecker wrote:
> > Upon entraining a callback to a NOCB CPU, no further wake up is
> > issued on the corresponding nocb_gp kthread. As a result, the callback
> > and all the subsequent ones on that CPU may be ignored, at least until
> > an RCU_NOCB_WAKE_FORCE timer is ever armed or another NOCB CPU belonging
> > to the same group enqueues a callback on an empty queue.
> > 
> > Here is a possible bad scenario:
> > 
> > 1) CPU 0 is NOCB unlike all other CPUs.
> > 2) CPU 0 queues a callback
> > 2) The grace period related to that callback elapses
> > 3) The callback is moved to the done list (but is not invoked yet),
> >    there are no more pending callbacks for CPU 0
> > 4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
> > 5) CPU 0 entrains the callback but doesn't wake up nocb_gp
> > 6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
> >    callbacks to arm an RCU_NOCB_WAKE_FORCE timer.
> > 
> > Make sure the necessary wake up is produced whenever necessary.
> > 
> > Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> And if Paul is taking this, I'll rebase and drop this patch from the lazy
> series.

Joel, could you please incorporate this into your series?  My internet
access is likely to be a bit iffy over the next few days.  Likely no
problem for email and the occasional test-systme access, but best not
to take it for granted.  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > ---
> >  kernel/rcu/tree.c      | 6 ++++++
> >  kernel/rcu/tree.h      | 1 +
> >  kernel/rcu/tree_nocb.h | 5 +++++
> >  3 files changed, 12 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 96d678c9cfb6..025f59f6f97f 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3914,6 +3914,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  {
> >  	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
> >  	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> > +	bool wake_nocb = false;
> > +	bool was_alldone = false;
> >  
> >  	lockdep_assert_held(&rcu_state.barrier_lock);
> >  	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> > @@ -3922,6 +3924,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  	rdp->barrier_head.func = rcu_barrier_callback;
> >  	debug_rcu_head_queue(&rdp->barrier_head);
> >  	rcu_nocb_lock(rdp);
> > +	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
> >  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> >  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
> >  		atomic_inc(&rcu_state.barrier_cpu_count);
> > @@ -3929,7 +3932,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  		debug_rcu_head_unqueue(&rdp->barrier_head);
> >  		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
> >  	}
> > +	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
> >  	rcu_nocb_unlock(rdp);
> > +	if (wake_nocb)
> > +		wake_nocb_gp(rdp, false);
> >  	smp_store_release(&rdp->barrier_seq_snap, gseq);
> >  }
> >  
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index d4a97e40ea9c..925dd98f8b23 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
> >  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
> >  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
> >  static void rcu_init_one_nocb(struct rcu_node *rnp);
> > +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
> >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  				  unsigned long j);
> >  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index f77a6d7e1356..094fd454b6c3 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
> >  {
> >  }
> >  
> > +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> > +{
> > +	return false;
> > +}
> > +
> >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  				  unsigned long j)
> >  {
> > -- 
> > 2.25.1
> > 
