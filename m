Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADE5FF4CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiJNUr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiJNUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986C183D9D;
        Fri, 14 Oct 2022 13:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D89461C0D;
        Fri, 14 Oct 2022 20:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA07C433D7;
        Fri, 14 Oct 2022 20:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665780473;
        bh=Y7cSkEtUOjuIr7FqCD+7qZvk2lC0Q/y7fiup3u4Ldi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNbp6++2LvkDrdKGSTnUe4UQQKhTR4gUKL9HN1pBvDAByrrMAZkZUrq4lAR/x5mW1
         jbumKhOPY6bNZJuLFYXR7vIFv8PZaZIeRaR+JoDpg6Agpc3RtKP046U5PKcLRv/5Rc
         wjQhhxx4qQuW5RhcCVUnjuyQJDqX6Q9gaH2bruYafSJc+4m7TBc7CmjJNoBFKptYU3
         npcALBHnqtq1BAATXkqmfRKxBHpaJKmP9TCRz6kRXxt0eh6nTm2GbubIUJEYuJLxMG
         edxNdQTDEsOP8dU2E2hMoubZCwqAIt3VE6Rm7RVeH/IJvje19os7PelpSgdH8i42o6
         BXmNoRx61m5uw==
Date:   Fri, 14 Oct 2022 22:47:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v8 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
Message-ID: <20221014204750.GA1119620@lothringen>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-2-joel@joelfernandes.org>
 <20221014142127.GE4221@paulmck-ThinkPad-P17-Gen-1>
 <20221014144019.GB1108603@lothringen>
 <20221014150344.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQoRUJ=0_GJG6JunR58yASmehPanp14zbR3Y+KAGL1TDA@mail.gmail.com>
 <20221014154606.GJ4221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014154606.GJ4221@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 08:46:06AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 14, 2022 at 11:19:28AM -0400, Joel Fernandes wrote:
> > I agree with the discussion, though if all CBs are in the bypass list,
> > the patch will also save 2 jiffies.
> > 
> > So just commit messages that need rework then? This one can be taken instead:
> > https://lore.kernel.org/rcu/21ECDA9F-81B1-4D22-8B03-020FB5DADA4F@joelfernandes.org/T/#m14d21fbce23539a521693a4184b28ddc55d7d2c5
> 
> This one looks plausible to me.

With the following modified diff (passed 25 hours of TREE01):

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96d678c9cfb6..7f1f6f792240 100644
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
@@ -3922,7 +3924,14 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	/*
+	 * Flush bypass and wakeup rcuog if we add callbacks to an empty regular
+	 * queue. This way we don't wait for bypass timer that can reach seconds
+	 * if it's fully lazy.
+	 */
+	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -3930,6 +3939,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
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
