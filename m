Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7940C65E521
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjAEFfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEFfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:35:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8F37265;
        Wed,  4 Jan 2023 21:35:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1C56163B;
        Thu,  5 Jan 2023 05:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F65C433EF;
        Thu,  5 Jan 2023 05:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672895506;
        bh=/42NPCYs4D9ce+al7eJYFUYxfGp0bcl2LbZGaPT23iA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nr+zsmbjsSPBMk/r4N7/mRqGYaCikKrOThHMxinF3pDA9biN3lK5VdjTt92+tZwC2
         ROIXi8LO6tcH/uzkyHPuaq2XZ7AM+fJQZaQnVUDNvac0OJly5U0Qafa4pVsA7mxnWV
         xhh/8wFF1JH/iBKc037MhDMpxm9jfyVgnnKOZffTXI3uMAmEbM2eGg4GamusWupqu0
         NinemtR05zZJ3dLsnTGwO3kLCO2GRZz+IjPeqNwosVddy7iLTJKdxdAdLpYAC1MR/q
         vB9dHzJ4Mc7uoCtlBMR4ykKh+ujF9DIZH44yMwI5FJZU9aPKjWEtvrEamVm4/xLzf+
         uUaVAEiwFw01w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 09B845C05CA; Wed,  4 Jan 2023 21:11:46 -0800 (PST)
Date:   Wed, 4 Jan 2023 21:11:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Rework tick dependency setting into
 rcu_exp_handler()
Message-ID: <20230105051146.GN4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105034000.971748-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105034000.971748-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:40:00AM +0800, Zqiang wrote:
> Currently, when first find out the expedited grace period is not end
> and timeout occurred, we set tick dependency for CPUs that have not
> yet reported the quiescent state in the rcu_node structure's->expmask
> but need to eliminate races between set and clear tick dependency, setting
> CPU tick dependency need to hold rcu_node structure's->lock.
> 
> This commit move tick dependency setting into rcu_exp_handler(), set tick
> dependency when fail to report a quiescent state and clear tick dependency
> in rcu_report_exp_rdp(). [from Frederic Weisbecker suggestion]
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

First, a big "thank you" to you an Frederic for investigating this
approach!

So which is better, this patch or the one that I already have queued?

The advantage of the patch of yours that I already have queued is that
CPUs that respond in some other way within a millisecond do not get hit
with an additional scheduling-clock interrupt.

On the other hand, if the CPU goes through a quiescent state before the
next scheduling-clock interrupt arrives, rcu_report_exp_cpu_mult() will
shut down the tick before it happens.  Plus if the CPU waits a full tick
before reaching a quiescent state, then the tick_dep_set_cpu() called from
synchronize_rcu_expedited_wait() is going to send along an IPI anyway.

Except that invoking tick_dep_set_cpu() on the CPU itself will also
do an IPI from tick_dep_set_cpu() because of IRQ_WORK_INIT_HARD(), right?
Which means that the patch below gets us an extra self-IPI, right?
Or am I misreading the code?

In addition, doesn't tick_dep_clear_cpu() just clear a bit?  Won't that
mean that the next scheduling-clock interrupt will happen, just that the
one after that won't?  (Give or take kernel-to-user or kernel-to-idle
transitions that might happen in the meantime.)

Am I missing something in my attempts to model the costs?

							Thanx, Paul

> ---
>  kernel/rcu/tree_exp.h | 43 ++++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 7cc4856da081..f1e947675727 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -586,39 +586,16 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
>  static void synchronize_rcu_expedited_wait(void)
>  {
>  	int cpu;
> -	unsigned long j;
>  	unsigned long jiffies_stall;
>  	unsigned long jiffies_start;
>  	unsigned long mask;
>  	int ndetected;
> -	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  	struct rcu_node *rnp_root = rcu_get_root();
> -	unsigned long flags;
>  
>  	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
>  	jiffies_stall = rcu_exp_jiffies_till_stall_check();
>  	jiffies_start = jiffies;
> -	if (tick_nohz_full_enabled() && rcu_inkernel_boot_has_ended()) {
> -		if (synchronize_rcu_expedited_wait_once(1))
> -			return;
> -		rcu_for_each_leaf_node(rnp) {
> -			raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -			mask = READ_ONCE(rnp->expmask);
> -			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
> -				rdp = per_cpu_ptr(&rcu_data, cpu);
> -				if (rdp->rcu_forced_tick_exp)
> -					continue;
> -				rdp->rcu_forced_tick_exp = true;
> -				if (cpu_online(cpu))
> -					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> -			}
> -			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> -		}
> -		j = READ_ONCE(jiffies_till_first_fqs);
> -		if (synchronize_rcu_expedited_wait_once(j + HZ))
> -			return;
> -	}
>  
>  	for (;;) {
>  		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
> @@ -729,6 +706,24 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
>  
>  #ifdef CONFIG_PREEMPT_RCU
>  
> +static void rcu_exp_set_tickdep(struct rcu_data *rdp)
> +{
> +	int cpu = rdp->cpu;
> +
> +	if (tick_nohz_full_cpu(cpu) && rcu_inkernel_boot_has_ended() &&
> +						cpu_online(cpu)) {
> +		/*
> +		 * The rcu_exp_handler() can be invoked from stop machine,
> +		 * at this time CPU has disabled all interrupts and offline,
> +		 * in which case, we don't need requeue IPI or irq work.
> +		 * which is not a problem since rcu_report_dead() does the
> +		 * QS report.
> +		 */
> +		rdp->rcu_forced_tick_exp = true;
> +		tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> +	}
> +}
> +
>  /*
>   * Remote handler for smp_call_function_single().  If there is an
>   * RCU read-side critical section in effect, request that the
> @@ -757,6 +752,7 @@ static void rcu_exp_handler(void *unused)
>  			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
>  			set_tsk_need_resched(t);
>  			set_preempt_need_resched();
> +			rcu_exp_set_tickdep(rdp);
>  		}
>  		return;
>  	}
> @@ -778,6 +774,7 @@ static void rcu_exp_handler(void *unused)
>  		if (rnp->expmask & rdp->grpmask) {
>  			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
>  			t->rcu_read_unlock_special.b.exp_hint = true;
> +			rcu_exp_set_tickdep(rdp);
>  		}
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		return;
> -- 
> 2.25.1
> 
