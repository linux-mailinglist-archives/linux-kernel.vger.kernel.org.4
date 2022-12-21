Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9369B653758
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLUUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUUIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:08:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F49720BD5;
        Wed, 21 Dec 2022 12:08:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C72586190C;
        Wed, 21 Dec 2022 20:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA51C433EF;
        Wed, 21 Dec 2022 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671653330;
        bh=tgkhlusnoqrOCl0ix0q96zvD0vmGeJvGQZl1TUQm6RY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hbvMqFvykjoKg8wpcFafh8mkGa/u9xDVhBnXv5zWLFL9m3MIgQttaCNAS7ZSR295Y
         SSzp+f/9rZnr5oRc0J00Tapb1G2TIzACEigpNdGqMjD8MprhYrRYe6t+8B44mPf89J
         L9bP7AfzVf+qopkYV7vS+yhpi+Eb7B9LTutXuFh4H80eo/X3sKuMvawyH+Y7LM9L5l
         LF9MkDuNQMq2Hu0F7Nl+2b9v15AXJGFQhdWxEzeUUcsGqh6zkCRHCtILvnktQw/7mN
         m8bI/OVlQ1OxAVcmVobr1stof8D65QYvRYXcPkpFnuV/X6ZpmaWtqMvrisGwDMdMPO
         6HMzk14wmaSsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A1D395C0989; Wed, 21 Dec 2022 12:08:49 -0800 (PST)
Date:   Wed, 21 Dec 2022 12:08:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP
 bitmask
Message-ID: <20221221200849.GG4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220112520.3596920-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220112520.3596920-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:25:20PM +0800, Zqiang wrote:
> For the kernel bulit with CONFIG_NO_HZ_FULL enabled and the following
> cpus is nohz_full cpus:
> 
> 	CPU1                                                 CPU2
> rcu_report_exp_cpu_mult                          synchronize_rcu_expedited_wait
>    acquires rnp->lock                               mask = rnp->expmask;
>                                                     for_each_leaf_node_cpu_mask(rnp, cpu, mask)
>    rnp->expmask = rnp->expmask & ~mask;                rdp = per_cpu_ptr(&rcu_data, cpu1);
>    for_each_leaf_node_cpu_mask(rnp, cpu, mask)
>       rdp = per_cpu_ptr(&rcu_data, cpu1);
>       if (!rdp->rcu_forced_tick_exp)
>              continue;                                 rdp->rcu_forced_tick_exp = true;
>                                                        tick_dep_set_cpu(cpu1, TICK_DEP_BIT_RCU_EXP);
> 
> In the above scenario, after CPU1 reported the quiescent state, CPU1
> misses the opportunity to clear the TICK_DEP_BIT_RCU_EXP bitmask, it
> will not be cleared until the next expedited grace period starts and
> the CPU1 quiescent state is reported again. during this window period,
> the CPU1 whose tick can not be stopped, if CPU1 has only one runnable
> task and this task has aggressive real-time response constraints, this
> task may have one of the worst response times.
> 
> Therefore, this commit add rnp->lock when set TICK_DEP_BIT_RCU_EXP
> bitmask to fix this race.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good eyes, thank you!!!

Queued for testing and further review as follows, as always, please
check for errors.

							Thanx, Paul

------------------------------------------------------------------------

commit acfe689f2e473fb59b6d2c95af5fe36198bb9a84
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Dec 20 19:25:20 2022 +0800

    rcu: Fix set/clear TICK_DEP_BIT_RCU_EXP bitmask race
    
    For kernels built with CONFIG_NO_HZ_FULL=y, the following scenario can result
    in the scheduling-clock interrupt remaining enabled on a holdout CPU after
    its quiescent state has been reported:
    
            CPU1                                                 CPU2
    rcu_report_exp_cpu_mult                          synchronize_rcu_expedited_wait
       acquires rnp->lock                               mask = rnp->expmask;
                                                        for_each_leaf_node_cpu_mask(rnp, cpu, mask)
       rnp->expmask = rnp->expmask & ~mask;                rdp = per_cpu_ptr(&rcu_data, cpu1);
       for_each_leaf_node_cpu_mask(rnp, cpu, mask)
          rdp = per_cpu_ptr(&rcu_data, cpu1);
          if (!rdp->rcu_forced_tick_exp)
                 continue;                                 rdp->rcu_forced_tick_exp = true;
                                                           tick_dep_set_cpu(cpu1, TICK_DEP_BIT_RCU_EXP);
    
    The problem is that CPU2's sampling of rnp->expmask is obsolete by the
    time it invokes tick_dep_set_cpu(), and CPU1 is not guaranteed to see
    CPU2's store to ->rcu_forced_tick_exp in time to clear it.  And even if
    CPU1 does see that store, it might invoke tick_dep_clear_cpu() before
    CPU2 got around to executing its tick_dep_set_cpu(), which would still
    leave the victim CPU with its scheduler-clock tick running.
    
    Either way, an nohz_full real-time application running on the victim
    CPU would have its latency needlessly degraded.
    
    Note that expedited RCU grace periods look at context-tracking
    information, and so if the CPU is executing in nohz_full usermode
    throughout, that CPU cannot be victimized in this manner.
    
    This commit therefore causes synchronize_rcu_expedited_wait to hold
    the rcu_node structure's ->lock when checking for holdout CPUs, setting
    TICK_DEP_BIT_RCU_EXP, and invoking tick_dep_set_cpu(), thus preventing
    this race.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 249c2967d9e6c..7cc4856da0817 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -594,6 +594,7 @@ static void synchronize_rcu_expedited_wait(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root = rcu_get_root();
+	unsigned long flags;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_exp_jiffies_till_stall_check();
@@ -602,17 +603,17 @@ static void synchronize_rcu_expedited_wait(void)
 		if (synchronize_rcu_expedited_wait_once(1))
 			return;
 		rcu_for_each_leaf_node(rnp) {
+			raw_spin_lock_irqsave_rcu_node(rnp, flags);
 			mask = READ_ONCE(rnp->expmask);
 			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp = true;
-				preempt_disable();
 				if (cpu_online(cpu))
 					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
-				preempt_enable();
 			}
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 		j = READ_ONCE(jiffies_till_first_fqs);
 		if (synchronize_rcu_expedited_wait_once(j + HZ))
