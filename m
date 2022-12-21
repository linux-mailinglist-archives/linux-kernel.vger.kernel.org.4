Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983B46536FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiLUT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiLUT00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:26:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA944252B1;
        Wed, 21 Dec 2022 11:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67CC2B81C08;
        Wed, 21 Dec 2022 19:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CEDC433D2;
        Wed, 21 Dec 2022 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671650783;
        bh=C/lj6yGccwZckTCKpHVGZugFfXG5pDoxRQVY7QKnaWc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gIACsbrSKbS0wsDZ0uBmXKjIbxOJ0FAbw0Dv9+RffZ2ZkHlsxLSXec/Xh6BHTlboC
         9Qq5Japy8gGgG7xl/1KMObe3L5a76juNdo765U5G/I+iZt/jmeFEYxA5bi7AEVUiqr
         +vSP6sQxtI886oaoMMx5SKnNi/GMEpur6vAe94AeL2QEIlvisFxoc1fc4B41/YGZ5V
         MEkzLd5VAj5s0Hq1MFRgiMGfNidbCMKaiG9XeLnUVZvtmOH3Ehwslui4oEt0DOGP62
         xcxcLw2gbMRIRZpfpEgL4u2476GKUzicEtd6TrY3B4hkSXdZIFJDaFx6j004WqWsyI
         e458ENEPhPsMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A9CDF5C0989; Wed, 21 Dec 2022 11:26:22 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:26:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads
 affinity
Message-ID: <20221221192622.GD4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215090029.2972236-1-qiang1.zhang@intel.com>
 <20221217010919.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B9403488CAB5DF9810FFDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58806ABF242993103390A6F5DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58806ABF242993103390A6F5DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 01:02:03PM +0000, Zhang, Qiang1 wrote:
> On Thu, Dec 15, 2022 at 05:00:29PM +0800, Zqiang wrote:
> > Currently, when CPUs going offline, the rcu boost kthreads CPU
> > affinity has been reset in rcutree_offline_cpu(), therefore this
> > commit remove duplicate settings in rcutree_dead_cpu().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >One question...
> >
> >Given that rcutree_offline_cpu() causes rcu_boost_kthread_setaffinity()
> >to be invoked with the number of the outgoing CPU, but rcutree_dead_cpu()
> >instead passes in -1, are these two invocations really redundant?
> >
> >Although -1 is passed in, but at this time, the outgoing CPU has been removed from 
> >rcu_rnp_online_cpus(rnp),  in other words, we will eliminate the same CPU, which is
> >also  we passed in cpu in the rcutree_offline_cpu() before.
> >
> 
> I also used " qemu -smp 4 "for a simple test.
> 
> 1) rcutree_offline_cpu()
> 
> (gdb) bt
> #0  set_cpus_allowed_ptr (p=p@entry=0xffff888100bd9cc0, new_mask=new_mask@entry=0xffff888100ce7cd0)
>     at kernel/sched/core.c:2939
> #1  0xffffffff811be169 in rcu_boost_kthread_setaffinity (rnp=0xffffffff837a4c00 <rcu_state>,
>     outgoingcpu=outgoingcpu@entry=3) at kernel/rcu/tree_plugin.h:1250
> #2  0xffffffff811cfa9f in rcutree_affinity_setting (outgoing=3, cpu=3) at kernel/rcu/tree.c:4297
> #3  rcutree_offline_cpu (cpu=3) at kernel/rcu/tree.c:4341
> #4  0xffffffff810c4e6f in cpuhp_invoke_callback (cpu=cpu@entry=3, state=state@entry=CPUHP_AP_RCUTREE_ONLINE,
>     bringup=bringup@entry=false, node=<optimized out>, lastp=lastp@entry=0xffff88815b027568) at kernel/cpu.c:192
> #5  0xffffffff810c6e24 in cpuhp_thread_fun (cpu=<optimized out>) at kernel/cpu.c:785
> #6  0xffffffff8111784e in smpboot_thread_fn (data=0xffff88810014c3c0) at kernel/smpboot.c:164
> #7  0xffffffff8110c88e in kthread (_create=0xffff8881009b8b00) at kernel/kthread.c:376
> #8  0xffffffff81002902 in ret_from_fork () at arch/x86/entry/entry_64.S:306
> #9  0x0000000000000000 in ?? ()
> 
> (gdb) p/x *0xffff888100ce7cd0
> $1 = 0x7
> 
> 2) rcutree_dead_cpu()
> 
> #0  set_cpus_allowed_ptr (p=p@entry=0xffff888100bd9cc0, new_mask=new_mask@entry=0xffff888109fc7948)
>     at kernel/sched/core.c:2939
> #1  0xffffffff811be169 in rcu_boost_kthread_setaffinity (rnp=0xffffffff837a4c00 <rcu_state>,
>     outgoingcpu=outgoingcpu@entry=-1) at kernel/rcu/tree_plugin.h:1250
> #2  0xffffffff811cf4a1 in rcutree_dead_cpu (cpu=3) at kernel/rcu/tree.c:4176
> #3  0xffffffff810c4e6f in cpuhp_invoke_callback (cpu=cpu@entry=3, state=CPUHP_RCUTREE_PREP, bringup=bringup@entry=false,
>     node=node@entry=0x0 <fixed_percpu_data>, lastp=lastp@entry=0x0 <fixed_percpu_data>) at kernel/cpu.c:192
> #4  0xffffffff810c58f5 in cpuhp_invoke_callback_range (bringup=bringup@entry=false, cpu=cpu@entry=3,
>     st=st@entry=0xffff88815b027540, target=target@entry=CPUHP_OFFLINE) at kernel/cpu.c:675
> #5  0xffffffff827a5f6a in cpuhp_down_callbacks (target=CPUHP_OFFLINE, st=0xffff88815b027540, cpu=3) at kernel/cpu.c:1170
> #6  _cpu_down (cpu=cpu@entry=3, tasks_frozen=tasks_frozen@entry=0, target=target@entry=CPUHP_OFFLINE) at kernel/cpu.c:1170
> #7  0xffffffff810c6ff8 in cpu_down_maps_locked (target=CPUHP_OFFLINE, cpu=3) at kernel/cpu.c:1202
> #8  cpu_down (cpu=3, target=target@entry=CPUHP_OFFLINE) at kernel/cpu.c:1210
> #9  0xffffffff810c7906 in cpu_device_down (dev=dev@entry=0xffff88815b026988) at kernel/cpu.c:1227
> 
> (gdb) p/x *0xffff888109fc7948
> $2 = 0x7
> 
> As can be seen from the above, we have set the same cpumask twice for the same boost kthreads.

Very good, thank you for checking!

I have queued this as shown below, so please let me know of any issues.

							Thanx, Paul

------------------------------------------------------------------------

commit 5815245b56229198d5f5d0c48c26d3c0c53ee222
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Wed Dec 21 11:15:43 2022 -0800

    rcu: Remove redundant call to rcu_boost_kthread_setaffinity()
    
    The rcu_boost_kthread_setaffinity() function is invoked at
    rcutree_online_cpu() and rcutree_offline_cpu() time, early in the online
    timeline and late in the offline timeline, respectively.  It is also
    invoked from rcutree_dead_cpu(), however, in the absence of userspace
    manipulations (for which userspace must take responsibility), this call
    is redundant with that from rcutree_offline_cpu().  This redundancy can
    be demonstrated by printing out the relevant cpumasks
    
    This commit therefore removes the call to rcu_boost_kthread_setaffinity()
    from rcutree_dead_cpu().
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c3255d27286c4..a6181b76fd5ab 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4165,15 +4165,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
  */
 int rcutree_dead_cpu(unsigned int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
-
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
-	/* Adjust any no-longer-needed kthreads. */
-	rcu_boost_kthread_setaffinity(rnp, -1);
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
