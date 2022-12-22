Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09865441B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLVPSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLVPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:18:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74823B3A;
        Thu, 22 Dec 2022 07:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1129A61BFE;
        Thu, 22 Dec 2022 15:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E362C433F0;
        Thu, 22 Dec 2022 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671722317;
        bh=5a9OAoDX+zFY//uri2cR0evJiOLLaWYnsfGzbWxO+hk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uZHdjiib8JFDli0eByjTdDCqRgeRrrdii3XDp2dOaxL/yAfeUGLWSSOuvVaVkljol
         VIboc8R4HFOGmZqRhr7zriwFI6fuMkBrZ76l6qS3luS3SXFJAVNPBYyfoCr/3E40G/
         gTGZ4qQ5Uobxl7efJG0NPy3JdIOlx6f4CLvOQ2xdQfoBT5XmXOofQ5s8rTms4bt389
         lqktb/gZA3uRWwjjKX7/a6tnFx7bk+Dv3l9J9kqlitt9gOhVrez4IP0KuC/CbIe7ip
         vWYyd9GIE3Ase50+G3Uv4hIKOnBO0THDEhgCG2BLO5Y20usdFU1cVSTpa+M7dl9Pa3
         39MUeqWSx3XFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E42E85C0F2E; Thu, 22 Dec 2022 07:18:36 -0800 (PST)
Date:   Thu, 22 Dec 2022 07:18:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP
 bitmask
Message-ID: <20221222151836.GM4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220112520.3596920-1-qiang1.zhang@intel.com>
 <20221221200849.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58806135271427BC1A13AF34DAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58806135271427BC1A13AF34DAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 09:48:14AM +0000, Zhang, Qiang1 wrote:
> > For the kernel bulit with CONFIG_NO_HZ_FULL enabled and the following 
> > cpus is nohz_full cpus:
> > 
> > 	CPU1                                                 CPU2
> > rcu_report_exp_cpu_mult                          synchronize_rcu_expedited_wait
> >    acquires rnp->lock                               mask = rnp->expmask;
> >                                                     for_each_leaf_node_cpu_mask(rnp, cpu, mask)
> >    rnp->expmask = rnp->expmask & ~mask;                rdp = per_cpu_ptr(&rcu_data, cpu1);
> >    for_each_leaf_node_cpu_mask(rnp, cpu, mask)
> >       rdp = per_cpu_ptr(&rcu_data, cpu1);
> >       if (!rdp->rcu_forced_tick_exp)
> >              continue;                                 rdp->rcu_forced_tick_exp = true;
> >                                                        
> > tick_dep_set_cpu(cpu1, TICK_DEP_BIT_RCU_EXP);
> > 
> > In the above scenario, after CPU1 reported the quiescent state, CPU1 
> > misses the opportunity to clear the TICK_DEP_BIT_RCU_EXP bitmask, it 
> > will not be cleared until the next expedited grace period starts and 
> > the CPU1 quiescent state is reported again. during this window period, 
> > the CPU1 whose tick can not be stopped, if CPU1 has only one runnable 
> > task and this task has aggressive real-time response constraints, this 
> > task may have one of the worst response times.
> > 
> > Therefore, this commit add rnp->lock when set TICK_DEP_BIT_RCU_EXP 
> > bitmask to fix this race.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Good eyes, thank you!!!
> >
> >Queued for testing and further review as follows, as always, please check for errors.
> >
> 
> It looks more clear now, thank you!

Thank you for checking them both!

							Thanx, Paul

> Thanks
> Zqiang
> 
> >							Thanx, Paul
> >
> >------------------------------------------------------------------------
> 
> commit acfe689f2e473fb59b6d2c95af5fe36198bb9a84
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Tue Dec 20 19:25:20 2022 +0800
> 
>     rcu: Fix set/clear TICK_DEP_BIT_RCU_EXP bitmask race
>     
>     For kernels built with CONFIG_NO_HZ_FULL=y, the following scenario can result
>     in the scheduling-clock interrupt remaining enabled on a holdout CPU after
>     its quiescent state has been reported:
>     
>             CPU1                                                 CPU2
>     rcu_report_exp_cpu_mult                          synchronize_rcu_expedited_wait
>        acquires rnp->lock                               mask = rnp->expmask;
>                                                         for_each_leaf_node_cpu_mask(rnp, cpu, mask)
>        rnp->expmask = rnp->expmask & ~mask;                rdp = per_cpu_ptr(&rcu_data, cpu1);
>        for_each_leaf_node_cpu_mask(rnp, cpu, mask)
>           rdp = per_cpu_ptr(&rcu_data, cpu1);
>           if (!rdp->rcu_forced_tick_exp)
>                  continue;                                 rdp->rcu_forced_tick_exp = true;
>                                                            tick_dep_set_cpu(cpu1, TICK_DEP_BIT_RCU_EXP);
>     
>     The problem is that CPU2's sampling of rnp->expmask is obsolete by the
>     time it invokes tick_dep_set_cpu(), and CPU1 is not guaranteed to see
>     CPU2's store to ->rcu_forced_tick_exp in time to clear it.  And even if
>     CPU1 does see that store, it might invoke tick_dep_clear_cpu() before
>     CPU2 got around to executing its tick_dep_set_cpu(), which would still
>     leave the victim CPU with its scheduler-clock tick running.
>     
>     Either way, an nohz_full real-time application running on the victim
>     CPU would have its latency needlessly degraded.
>     
>     Note that expedited RCU grace periods look at context-tracking
>     information, and so if the CPU is executing in nohz_full usermode
>     throughout, that CPU cannot be victimized in this manner.
>     
>     This commit therefore causes synchronize_rcu_expedited_wait to hold
>     the rcu_node structure's ->lock when checking for holdout CPUs, setting
>     TICK_DEP_BIT_RCU_EXP, and invoking tick_dep_set_cpu(), thus preventing
>     this race.
>     
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h index 249c2967d9e6c..7cc4856da0817 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -594,6 +594,7 @@ static void synchronize_rcu_expedited_wait(void)
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  	struct rcu_node *rnp_root = rcu_get_root();
> +	unsigned long flags;
>  
>  	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
>  	jiffies_stall = rcu_exp_jiffies_till_stall_check();
> @@ -602,17 +603,17 @@ static void synchronize_rcu_expedited_wait(void)
>  		if (synchronize_rcu_expedited_wait_once(1))
>  			return;
>  		rcu_for_each_leaf_node(rnp) {
> +			raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  			mask = READ_ONCE(rnp->expmask);
>  			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
>  				rdp = per_cpu_ptr(&rcu_data, cpu);
>  				if (rdp->rcu_forced_tick_exp)
>  					continue;
>  				rdp->rcu_forced_tick_exp = true;
> -				preempt_disable();
>  				if (cpu_online(cpu))
>  					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> -				preempt_enable();
>  			}
> +			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		}
>  		j = READ_ONCE(jiffies_till_first_fqs);
>  		if (synchronize_rcu_expedited_wait_once(j + HZ))
