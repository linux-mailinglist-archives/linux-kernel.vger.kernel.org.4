Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E926363E650
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiLAARQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiLAAQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:16:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5444C275;
        Wed, 30 Nov 2022 16:13:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AD86B81D12;
        Thu,  1 Dec 2022 00:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE990C433D6;
        Thu,  1 Dec 2022 00:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669853587;
        bh=ZaNvpG11vcB+GiLgt2vyshN/xWWvj2/3IfUh3oU3sTg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hHGMHxf6nU3pFBZck2Z57Lm8maCTVmZOTG0K9FzIKshI230GtlblYZPs/udCAOsLU
         9ixE7MqwdhS6Mr8Z+179ExBA38IxEKGLQWfDzGHSZCxIRnG+mox1R1rpqfHyM8istx
         2FRm/FWe1Cj8pBrfUbXa5Y6/YMVc/7HMq16G8f6XdmsVOioTTzCeA0CB3hJslAo5sN
         KQb1ZOaVp7RnauGeVXtBabfXmEqO9iYmpRjdh23fz1un6JK6UeIA4DhEDENKlO9PoZ
         Pakbhf+4cbEpPKTpB6GzEZYUoxIte0AR5UnFI3Zl6+O/CRLUr2f/IlLAp3/Et8CqPQ
         T7U48LSxiX/bQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 550465C089E; Wed, 30 Nov 2022 16:13:07 -0800 (PST)
Date:   Wed, 30 Nov 2022 16:13:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Message-ID: <20221201001307.GF4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221130234533.1983769-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130234533.1983769-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 07:45:33AM +0800, Zqiang wrote:
> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
> RCU-tasks grace period, if __num_online_cpus == 1, will return
> directly, indicates the end of the rude RCU-task grace period.
> suppose the system has two cpus, consider the following scenario:
> 
>         CPU0                                   CPU1 (going offline)
>                                           migration/1 task:
>                                       cpu_stopper_thread
>                                        -> take_cpu_down
>                                           -> _cpu_disable
>                                            (dec __num_online_cpus)
>                                           ->cpuhp_invoke_callback
>                                                 preempt_disable
>                                                 access old_data0
>            task1
>  del old_data0                                  .....
>  synchronize_rcu_tasks_rude()
>  task1 schedule out
>  ....
>  task2 schedule in
>  rcu_tasks_rude_wait_gp()
>      ->__num_online_cpus == 1
>        ->return
>  ....
>  task1 schedule in
>  ->free old_data0
>                                                 preempt_enable
> 
> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
> the CPU1 has not finished offline, stop_machine task(migration/1)
> still running on CPU1, maybe still accessing 'old_data0', but the
> 'old_data0' has freed on CPU0.
> 
> In order to prevent the above scenario from happening, this commit
> remove check for __num_online_cpus == 0 and add handling of calling
> synchronize_rcu_tasks_generic() during early boot(when the
> rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE, the scheduler
> not yet initialized and only one boot-CPU online).
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Very good, thank you!  I did the usual wordsmithing, including to that
error message, so as usual please check to make sure that I didn't mess
something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 033ddc5d337984e20b9d49c8af4faa4689727626
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Thu Dec 1 07:45:33 2022 +0800

    rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
    
    The synchronize_rcu_tasks_rude() function invokes rcu_tasks_rude_wait_gp()
    to wait one rude RCU-tasks grace period.  The rcu_tasks_rude_wait_gp()
    function in turn checks if there is only a single online CPU.  If so, it
    will immediately return, because a call to synchronize_rcu_tasks_rude()
    is by definition a grace period on a single-CPU system.  (We could
    have blocked!)
    
    Unfortunately, this check uses num_online_cpus() without synchronization,
    which can result in too-short grace periods.  To see this, consider the
    following scenario:
    
            CPU0                                   CPU1 (going offline)
                                              migration/1 task:
                                          cpu_stopper_thread
                                           -> take_cpu_down
                                              -> _cpu_disable
                                               (dec __num_online_cpus)
                                              ->cpuhp_invoke_callback
                                                    preempt_disable
                                                    access old_data0
               task1
     del old_data0                                  .....
     synchronize_rcu_tasks_rude()
     task1 schedule out
     ....
     task2 schedule in
     rcu_tasks_rude_wait_gp()
         ->__num_online_cpus == 1
           ->return
     ....
     task1 schedule in
     ->free old_data0
                                                    preempt_enable
    
    When CPU1 decrements __num_online_cpus, its value becomes 1.  However,
    CPU1 has not finished going offline, and will take one last trip through
    the scheduler and the idle loop before it actually stops executing
    instructions.  Because synchronize_rcu_tasks_rude() is mostly used for
    tracing, and because both the scheduler and the idle loop can be traced,
    this means that CPU0's prematurely ended grace period might disrupt the
    tracing on CPU1.  Given that this disruption might include CPU1 executing
    instructions in memory that was just now freed (and maybe reallocated),
    this is a matter of some concern.
    
    This commit therefore removes that problematic single-CPU check from the
    rcu_tasks_rude_wait_gp() function.  This dispenses with the single-CPU
    optimization, but there is no evidence indicating that this optimization
    is important.  In addition, synchronize_rcu_tasks_generic() contains a
    similar optimization (albeit only for early boot), which also splats.
    (As in exactly why are you invoking synchronize_rcu_tasks_rude() so
    early in boot, anyway???)
    
    It is OK for the synchronize_rcu_tasks_rude() function's check to be
    unsynchronized because the only times that this check can evaluate to
    true is when there is only a single CPU running with preemption
    disabled.
    
    While in the area, this commit also fixes a minor bug in which a
    call to synchronize_rcu_tasks_rude() would instead be attributed to
    synchronize_rcu_tasks().
    
    [ paulmck: Add "synchronize_" prefix and "()" suffix. ]
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4dda8e6e5707f..d845723c1af41 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 {
 	/* Complain if the scheduler has not started.  */
-	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
-			 "synchronize_rcu_tasks called too soon");
+	if (WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+			 "synchronize_%s() called too soon", rtp->name))
+		return;
 
 	// If the grace-period kthread is running, use it.
 	if (READ_ONCE(rtp->kthread_ptr)) {
@@ -1064,9 +1065,6 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
-	if (num_online_cpus() <= 1)
-		return;	// Fastpath for only one CPU.
-
 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
 	schedule_on_each_cpu(rcu_tasks_be_rude);
 }
