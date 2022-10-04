Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CCC5F4BE2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJDW3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJDW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:29:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5452B6CF7E;
        Tue,  4 Oct 2022 15:28:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 074FEB81BF7;
        Tue,  4 Oct 2022 22:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5289EC433D6;
        Tue,  4 Oct 2022 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664922536;
        bh=N3YayFgFJZfGstwTbVoetCDW2Fxn2dolBfe2/35dETY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOjmfkAuTDVx/Z8DbaZH+UH2kQK9/rrT5uy48Q4FIn9ArIl7t4X5vwG9YYIacXYXd
         O7P0Eu8A1rBm5fPIysmHkwhh4KU7MXaSfdM1hdAmWUknAAQgNy+fGuf/Nrg+xhHm+O
         0YbKl0aCE/XNWxv1J9VHPIMQFrkbiNsCrjchYq4hqBSJcpVVlcgRUgJBGzfAfOV3ev
         BUC1kwlkCKmd47+65nDvJJr7faN8/Jnlr6y3mXDonukkF4Q9jHHKixNo83rKAh0j+Q
         Hm7aOx9adn3K+5N3HYejgDs2wBlLkUVjzYsCkubhCSBefDHPkixld2n3JfA3eQ1Nc/
         z3WpDyvp4xujQ==
Date:   Wed, 5 Oct 2022 00:28:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 01/11] rcu: Wake up nocb gp thread on
 rcu_barrier_entrain()
Message-ID: <20221004222853.GA323878@lothringen>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004024157.2470238-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:41:47AM +0000, Joel Fernandes (Google) wrote:
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> In preparation of RCU lazy changes, wake up the RCU nocb gp thread if

It's more than just prep work for a new feature, it's a regression fix.

> needed after an entrain. Otherwise, the RCU barrier callback can wait in
> the queue for several seconds before the lazy callbacks in front of it
> are serviced.

It's not about lazy callbacks here (but you can mention the fact that
waking nocb_gp if necessary after flushing bypass is a beneficial side
effect for further lazy implementation).

So here is the possible bad scenario:

1) CPU 0 is nocb, it queues a callback
2) CPU 0 goes idle (or userspace with nohz_full) forever
3) The grace period related to that callback elapses
4) The callback is moved to the done list (but is not invoked yet), there are no more pending for CPU 0
5) CPU 1 calls rcu_barrier() and entrains to CPU 0 cblist
6) CPU 1 waits forever

> 
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")

Thanks.

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c      | 11 +++++++++++
>  kernel/rcu/tree_nocb.h |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..04f33191e5ed 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3894,6 +3894,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  {
>  	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
>  	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> +	bool wake_nocb = false;
> +	bool was_done = false;
>  
>  	lockdep_assert_held(&rcu_state.barrier_lock);
>  	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> @@ -3902,6 +3904,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	rdp->barrier_head.func = rcu_barrier_callback;
>  	debug_rcu_head_queue(&rdp->barrier_head);
>  	rcu_nocb_lock(rdp);
> +	was_done = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
>  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>  		atomic_inc(&rcu_state.barrier_cpu_count);
> @@ -3909,7 +3912,15 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  		debug_rcu_head_unqueue(&rdp->barrier_head);
>  		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>  	}
> +
> +	/*
> +	 * If bypass list was non-empty, wake up the nocb GP thread otherwise
> +	 * bypass/lazy CBs may not be noticed, and can cause real long delays!
> +	 */
> +	wake_nocb = was_done && rcu_segcblist_pend_cbs(&rdp->cblist);
>  	rcu_nocb_unlock(rdp);
> +	if (wake_nocb)
> +		wake_nocb_gp(rdp, false);
>  	smp_store_release(&rdp->barrier_seq_snap, gseq);
>  }
>  
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f77a6d7e1356..6caade0683dd 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1558,6 +1558,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  {
>  }
>  
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> +{
> +}
> +
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j)
>  {
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
