Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D765D6F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjADPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjADPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:15:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BCC1AD92;
        Wed,  4 Jan 2023 07:15:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F2F2B816AA;
        Wed,  4 Jan 2023 15:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978CDC433EF;
        Wed,  4 Jan 2023 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672845300;
        bh=VoyMbdz4WGPr8X9D8F+7mFIWceum4H4LLR+0Z+3k84E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdoGYDqo8aEBDd5HflIXNU+ctH7IdXtZaaiC3JdWY9cRFSu2YneTmUos2N5e10DNk
         YXt43Ji3VpZC8Yidu2jOQZ3RBNhX8a8d8PAgI1ZkgWR2Mg7wgjnDRyReyujqitSa+y
         K6q9+VkUOjQUKZnewn2HZWX0zWLYG8oO4852bw+UC7RshPSmlzZnyfwlEvsrKWaxYs
         TmnsOTaNMJMl1I+4rDpAU3gWHJjmtLdtjOe06pSVCDZSUlGOUcWHCx0DwRTHPam19D
         5XEEI74r58YLaLLnlsBcQrmIW/bN4Nx75QE9J01QyCxV1rgxHa4p+gMS9AuO7mVa8Z
         eZfamX0RDDmqQ==
Date:   Wed, 4 Jan 2023 16:14:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, quic_neeraju@quicinc.com,
        joelfernandes.org@lothringen, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Rework tick dependency setting into
 rcu_exp_handler()
Message-ID: <Y7WX8Uy7t+33FyUO@lothringen>
References: <20230104114722.931144-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104114722.931144-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:47:22PM +0800, Zqiang wrote:
> @@ -586,39 +586,19 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
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
> +
> +	if (synchronize_rcu_expedited_wait_once(1))
> +		return;

Do we still need this? This is immediately followed by the same call with
a higher time limit.

>  
>  	for (;;) {
>  		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
> @@ -653,8 +633,6 @@ static void synchronize_rcu_expedited_wait(void)
>  		if (ndetected) {
>  			pr_err("blocking rcu_node structures (internal RCU debug):");
>  			rcu_for_each_node_breadth_first(rnp) {
> -				if (rnp == rnp_root)
> -					continue; /* printed unconditionally */

Is that chunk from another patch?

>  				if (sync_rcu_exp_done_unlocked(rnp))
>  					continue;
>  				pr_cont(" l=%u:%d-%d:%#lx/%c",
> @@ -729,6 +707,17 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
>  
>  #ifdef CONFIG_PREEMPT_RCU
>  
> +static void rcu_exp_set_tickdep(int cpu)
> +{
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);

This is only used locally so you can use this_cpu_ptr() or even
better you can pass the rdp from rcu_exp_handler()

> +
> +	if (tick_nohz_full_enabled() && rcu_inkernel_boot_has_ended() &&

You can directly test tick_nohz_full_cpu(smp_processor_id()), this has the
advantage to only evaluate smp_processor_id() if nohz_full is current running
(using static key). It's a micro optimization, but still...


> +						cpu_online(cpu)) {

Right good point, this could happen if rcu_exp_handler() is called from
smpcfd_dying_cpu(). In which case we can't requeue an IPI or an IRQ work.
Which is not a problem since rcu_report_dead() -> rcu_preempt_deferred_qs()
then does the QS report. Can you add a comment about that?


> +		rdp->rcu_forced_tick_exp = true;
> +		tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> +	}
> +}
> +
>  /*
>   * Remote handler for smp_call_function_single().  If there is an
>   * RCU read-side critical section in effect, request that the
> @@ -743,6 +732,7 @@ static void rcu_exp_handler(void *unused)
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
>  	struct task_struct *t = current;
> +	int cpu = raw_smp_processor_id();

And then no need to fetch smp_processor_id() here.

Thanks.
