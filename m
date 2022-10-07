Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD585F7766
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJGL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJGL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F5FCA888;
        Fri,  7 Oct 2022 04:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0282B61CBC;
        Fri,  7 Oct 2022 11:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE660C433C1;
        Fri,  7 Oct 2022 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665141991;
        bh=X7RAvmJNnK4SBmAGNKLQDeBkK71nLPL9krwgOwNB8OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RC23KyAIY/JtiPjA9kXUBLTM9pRkhsSVW7PkNaHsvCZeI2+hPuCw/vRbjJ17B8M0P
         fR42YseXkByws5vrhg/caEWSROosh9exRIeeSj94YlAXeHizjkaCoAcRepiVLzv0O6
         HKXxPM6UB3fxT9GsKBwcIPM29tJQoB7uGuscj9WIcEyNV9Yr1RMhvcFrwYUVtwvXG/
         V/2UHfJ/rSNMWnY49XgfGMEprRGrNixGwG/BTrlaQ7DzmOFAQaSvObrpXNITZyPz0q
         2oHozcsVaJWDgjvsTEwNsxhZCi937ZdiDK9so2lLKEnraZ/kCMdn1edZXSqTccbprz
         2uigwAO/JTs9A==
Date:   Fri, 7 Oct 2022 13:26:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 01/11] rcu: Wake up nocb gp thread on
 rcu_barrier_entrain()
Message-ID: <20221007112628.GA871854@lothringen>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-2-joel@joelfernandes.org>
 <20221004222853.GA323878@lothringen>
 <c634e41e-3c6c-0896-0873-b9d1bb317cea@joelfernandes.org>
 <Yz+TWF8ksVK7YzQ0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz+TWF8ksVK7YzQ0@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 02:47:52AM +0000, Joel Fernandes wrote:
> On Tue, Oct 04, 2022 at 06:57:59PM -0400, Joel Fernandes wrote:
> 
> From: Frederic Weisbecker <frederic@kernel.org>
> Subject: [PATCH] rcu: Wake up nocb gp thread on rcu_barrier_entrain()
> 
> In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
> needed after an entrain. Otherwise, the RCU barrier callback can wait in
> the queue for several seconds before the lazy callbacks in front of it
> are serviced.
> 
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c      | 11 +++++++++++
>  kernel/rcu/tree.h      |  1 +
>  kernel/rcu/tree_nocb.h |  4 ++++
>  3 files changed, 16 insertions(+)
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
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c..41faaf8eb872 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -443,6 +443,7 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j);
>  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				bool *was_alldone, unsigned long flags);
> +static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>  static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
>  				 unsigned long flags);
>  static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
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

It misses a return value...

> +}

So I planned to post an updated version (please find below) but I triggered
a rare TREE01 stall related to rcu_barrier(). I just can't remember if it was
before or after the patch :-s

Anyway I'm holding it off until I get more clues.

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Tue, 4 Oct 2022 02:41:47 +0000
Subject: [PATCH] rcu: Fix missing nocb gp wake on rcu_barrier()

Upon entraining a callback to a NOCB CPU, no further wake up is
performed on the corresponding nocb_gp kthread. As a result, the callback
and all the subsequent ones on that CPU may be ignored, at least until
an RCU_NOCB_WAKE_FORCE timer is ever armed.

Here is a possible bad scenario:

1) CPU 0 is NOCB unlike all other CPUs.
2) CPU 0 queues a callback
2) The grace period related to that callback elapses
3) The callback is moved to the done list (but is not invoked yet),
   there are no more pending callbacks for CPU 0
4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
5) CPU 0 entrains the callback but doesn't wake up nocb_gp
6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
   callbacks to arm an RCU_NOCB_WAKE_FORCE timer.

Make sure the necessary wake up is issued if necessary.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 6 ++++++
 kernel/rcu/tree.h      | 1 +
 kernel/rcu/tree_nocb.h | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96d678c9cfb6..025f59f6f97f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3914,6 +3914,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 {
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
+	bool wake_nocb = false;
+	bool was_alldone = false;
 
 	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
@@ -3922,6 +3924,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
@@ -3929,7 +3932,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
+	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
 	rcu_nocb_unlock(rdp);
+	if (wake_nocb)
+		wake_nocb_gp(rdp, false);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c..925dd98f8b23 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -439,6 +439,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f77a6d7e1356..094fd454b6c3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1558,6 +1558,11 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+{
+	return false;
+}
+
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
-- 
2.25.1



