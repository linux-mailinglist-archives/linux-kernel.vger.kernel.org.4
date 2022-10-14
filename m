Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E55FF032
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJNOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiJNOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:21:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEB615B114;
        Fri, 14 Oct 2022 07:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AC1CB82161;
        Fri, 14 Oct 2022 14:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC27C433C1;
        Fri, 14 Oct 2022 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665757291;
        bh=dqeD1vrMeLYwqQDNjUyf6ndX3UFDCdt2jmlGnqqMgbE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JZLt4iT4Sb6F2ovzVZMOYKi1e06yiH+skqSOzx3M/Ao3GbrGetP+hGIyDtyIva+PX
         9WJakxRwNexPSLjqKkaD4sdCb1cXSDbmLhsBLElCwaxrtsuybWp2wy9IJu/EyKCaBX
         HF0CWIn9GUlrU9isc4QhO6wI76ugSJtUR3axsb3pDeMaSomlYWs+7WP5T03DlJxNGq
         cKvdH6R1WsjjkaYomewHBfe9MMxPBrjf41YCsNGFaU2t2pDRJVGuuVMjq+ACpQP8zl
         4BnLfNnUnsH03TfuyfpOc7X0bb+OgxTWfCjA9RwVoVFqDANfv8nM9/n05ppjRozZGn
         Y96BKmeyqkVnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E0A615C32BF; Fri, 14 Oct 2022 07:21:27 -0700 (PDT)
Date:   Fri, 14 Oct 2022 07:21:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v8 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
Message-ID: <20221014142127.GE4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011180142.2742289-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 06:01:30PM +0000, Joel Fernandes (Google) wrote:
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> Upon entraining a callback to a NOCB CPU, no further wake up is
> issued on the corresponding nocb_gp kthread. As a result, the callback
> and all the subsequent ones on that CPU may be ignored, at least until
> an RCU_NOCB_WAKE_FORCE timer is ever armed or another NOCB CPU belonging
> to the same group enqueues a callback on an empty queue.
> 
> Here is a possible bad scenario:
> 
> 1) CPU 0 is NOCB unlike all other CPUs.
> 2) CPU 0 queues a callback

Call it CB1.

> 2) The grace period related to that callback elapses
> 3) The callback is moved to the done list (but is not invoked yet),
>    there are no more pending callbacks for CPU 0

So CB1 is on ->cblist waiting to be invoked, correct?

> 4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
> 5) CPU 0 entrains the callback but doesn't wake up nocb_gp

And CB1 must still be there because otherwise the IPI handler would not
have entrained the callback, correct?  If so, we have both CB1 and the
rcu_barrier() callback (call it CB2) in ->cblist, but on the done list.

> 6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
>    callbacks to arm an RCU_NOCB_WAKE_FORCE timer.

Except that -something- must have already been prepared to wake up in
order to invoke CB1.  And that something would invoke CB2 along with CB1,
given that they are both on the done list.  If there is no such wakeup
already, then the hang could occur with just CB1, without the help of CB2.

> Make sure the necessary wake up is produced whenever necessary.

I am not seeing that the wakeup is needed in this case.

So what am I missing here?

> This is also required to make sure lazy callbacks in future patches
> don't end up making rcu_barrier() wait for multiple seconds.

But I do see that the wakeup is needed in the lazy case, and if I remember
correctly, the ten-second rcu_barrier() delay really did happen.  If I
understand correctly, for this to happen, all of the callbacks must be
in the bypass list, that is, ->cblist must be empty.

So has the scenario steps 1-6 called out above actually happened in the
absence of lazy callbacks?

							Thanx, Paul

> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c      | 6 ++++++
>  kernel/rcu/tree.h      | 1 +
>  kernel/rcu/tree_nocb.h | 5 +++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..dc1c502216c7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  {
>  	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
>  	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> +	bool wake_nocb = false;
> +	bool was_alldone = false;
>  
>  	lockdep_assert_held(&rcu_state.barrier_lock);
>  	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> @@ -3902,6 +3904,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	rdp->barrier_head.func = rcu_barrier_callback;
>  	debug_rcu_head_queue(&rdp->barrier_head);
>  	rcu_nocb_lock(rdp);
> +	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
>  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>  		atomic_inc(&rcu_state.barrier_cpu_count);
> @@ -3909,7 +3912,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  		debug_rcu_head_unqueue(&rdp->barrier_head);
>  		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>  	}
> +	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
>  	rcu_nocb_unlock(rdp);
> +	if (wake_nocb)
> +		wake_nocb_gp(rdp, false);
>  	smp_store_release(&rdp->barrier_seq_snap, gseq);
>  }
>  
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c..925dd98f8b23 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
>  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f77a6d7e1356..094fd454b6c3 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  {
>  }
>  
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> +{
> +	return false;
> +}
> +
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j)
>  {
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
