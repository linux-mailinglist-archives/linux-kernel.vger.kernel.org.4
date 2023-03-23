Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A06C5AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCWAHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCWAHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A932CC40;
        Wed, 22 Mar 2023 17:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9616162359;
        Thu, 23 Mar 2023 00:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042E8C433D2;
        Thu, 23 Mar 2023 00:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679530055;
        bh=2cz84b5sPCaC4cC71kw+AgzPcuPcrR5Dcs1fU3BqXa4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=od8aW67+A4g0rnsZnoLU/eJ4QcJqWMwPP+Iog1Qqe9EY5Z3sdQTIThzi3V56HMH69
         sLFFYhJyVBGFZCEsahgqPP1E9O7N8fSMfmy86WBjxj6T0nlyQGoL2jvzK1obJ2pX3r
         3MZlUv5IWWMqf3/OV//nOHVSabe2m7u0BLskaADLHHlkpTo/UXagTaG4CNnbvDqbNP
         c7WjaCFuxXtGfXF5TGVisOHMcs3NUcjujIUmcRDDR/m0mNtJYJlVgoGI2zXqi1ksAA
         BmXaKq1CsVtNxDC2AGoEaC8qyZnxPACu4/QmyuJ9RlR1pEa7LkNljEeCXPvqZ+bikl
         DbAgRFOQIwsTw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 824C91540398; Wed, 22 Mar 2023 17:07:34 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:07:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Message-ID: <80edb753-c8d4-4279-853e-201076949bd7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
 <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
 <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
 <PH0PR11MB58804435C08AEADF23B095D1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a9525f8-30a3-4ca9-87ec-355cde7f6ed6@paulmck-laptop>
 <PH0PR11MB588085478B4E13DD48C4B7C1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807A0B060B84C4159A16C0DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58807A0B060B84C4159A16C0DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:52:13PM +0000, Zhang, Qiang1 wrote:
> >On Wed, Mar 22, 2023 at 10:08:54PM +0000, Zhang, Qiang1 wrote:
> > > > > insmod rcutorture.ko
> > > > > rmmod rcutorture.ko
> > > > > 
> > > > > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167 
> > > > > __flush_work+0x50a/0x540 [  209.437346] Modules linked in: 
> > > > > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382] 
> > > > > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standard+ 
> > > > > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > > > > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776]  
> > > > > cleanup_srcu_struct+0x68/0x2e0 [  209.437817]  
> > > > > srcu_module_notify+0x71/0x140 [  209.437854]  
> > > > > blocking_notifier_call_chain+0x9d/0xd0
> > > > > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > > > > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062]  
> > > > > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > > > 
> > > > > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(), 
> > > > > when compiling and loading as modules, the srcu_module_coming() is 
> > > > > invoked, allocate memory for srcu structure's->sda and initialize 
> > > > > sda structure, due to not fully initialize srcu structure's->sup, so 
> > > > > at this time the sup structure's->delaywork.func is null, if not 
> > > > > invoke init_srcu_struct_fields() before unloading modules, in 
> > > > > srcu_module_going() the __flush_work() find
> > > > > work->func is empty, will raise the warning above.
> > > > > 
> > > > > This commit add init_srcu_struct_fields() to initialize srcu 
> > > > > structure's->sup, in srcu_module_coming().
> > > > > 
> > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > >
> > > > >Good catch, and thank you for testing the in-module case!
> > > > >
> > > > >One question below...
> > > > >
> > > > >							Thanx, Paul
> > > > >
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 11 ++++++++---
> > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index 
> > > > > 1fb078abbdc9..42d8720e016c 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *mod)
> > > > >  		ssp->sda = alloc_percpu(struct srcu_data);
> > > > >  		if (WARN_ON_ONCE(!ssp->sda))
> > > > >  			return -ENOMEM;
> > > > > -		init_srcu_struct_data(ssp);
> > > > > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > > > > +			return -ENOMEM;
> > > > >
> > > > >Wouldn't it be better to simply delete the init_srcu_struct_data()?
> > > > >
> > > > >Then the first call to check_init_srcu_struct() would take care of 
> > > > >the initialization, just as for the non-module case.  Or am I missing 
> > > > >something subtle?
> > > > 
> > > > Hi Paul
> > > > 
> > > > Maybe the check_init_srcu_struct() is always not invoked, for example,
> > > > In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(srcu_ctl),
> > > > but we use torture_type=rcu to test,  there will not be any interface 
> > > > calling
> > > > check_init_srcu_struct() to initialize srcu_ctl and set  
> > > > structure's->delaywork.func is process_srcu().
> > > > when we unload the rcutorture module, invoke cleanup_srcu_struct() to 
> > > > flush sup structure's->delaywork.func, due to the func pointer is not 
> > > > initialize, it's null, will trigger warning.
> > > > 
> > > > About kernel/workqueue.c:3167
> > > > 
> > > > __flush_work
> > > >      if (WARN_ON(!work->func))   <---------trigger waning
> > > > 	return false;
> > > > 
> > > > 
> > > > and  in  init_srcu_struct_fields(ssp, true), wil set 
> > > > srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_needed 
> > > > is zero,  after that when we call
> > > >  check_init_srcu_struct() again, it not be initialized again.
> > > >
> > > >
> > > >Good point!  In the non-module statically allocated case there is never a call to cleanup_srcu_struct().
> > > >
> > > >So suppose the code in srcu_module_coming() only did the alloc_percpu(), and then the
> > > >code in srcu_module_going() only did the the matching
> > > >free_percpu() instead of the current cleanup_srcu_struct()?
> > > 
> > > But in modules, for srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),
> > > when a module is unloaded, we usually don't call cleanup_srcu_struct() in the module
> > > unload function.
> > > If in srcu_module_going() only do free_percpu(), the srcu_sup->node memory maybe
> > > can not free and also lost the opportunity to refresh the running work.
> > >
> > >
> > >But in the module case, isn't the srcu_sup->node also statically
> > >allocated via the "static struct srcu_usage" declaration?
> > 
> > static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
> > {
> > 	sp->srcu_sup->node = kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup->node), gfp_flags);
> > 	...
> > }
> > 
> > Regardless of whether the srcu object is declared in the module or not, sup->node is dynamically allocated.
> > right?
> >
> >You are absolutely right, thank you!
> >
> >There are a couple of ways to resolve this.  One is to simply add
> >a check_init_srcu_struct() before the call to cleanup_srcu_struct()
> >from srcu_module_going(), as shown below.  This seems a bit silly,
> >potentially initializing fields for no good reason.
> >
> >Another way is to make cleanup_srcu_struct() do the same check
> >that check_init_srcu_struct() does:
> >
> >	rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed))
> >
> >If the value is non-zero, then cleanup_srcu_struct() should skip
> >consistency checks that complain about things that cannot happen if
> >there never was an RCU grace period.  Maybe something as shown after
> >the second line of dashes.
> >
> >Thoughts?
> >
> >							Thanx, Paul
> >
> >------------------------------------------------------------------------
> >
> >
> >/* Initialize any global-scope srcu_struct structures used by this module. */
> >static int srcu_module_coming(struct module *mod)
> >{
> >	int i;
> >	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> >	struct srcu_struct *ssp;
> >
> >	for (i = 0; i < mod->num_srcu_structs; i++) {
> >		ssp = *(sspp++);
> >		ssp->sda = alloc_percpu(struct srcu_data);
> >		if (WARN_ON_ONCE(!ssp->sda))
> >			return -ENOMEM;
> >		init_srcu_struct_data(ssp);
> >	}
> >	return 0;
> >}
> >
> >/* Clean up any global-scope srcu_struct structures used by this module. */
> >static void srcu_module_going(struct module *mod)
> >{
> >	int i;
> >	struct srcu_struct *ssp;
> >	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> >
> >	for (i = 0; i < mod->num_srcu_structs; i++) {
> >		ssp = *(sspp++);
> >		check_init_srcu_struct(ssp);
> >		cleanup_srcu_struct(ssp);
> >	}
> >}
> >
> >------------------------------------------------------------------------
> >
> >void cleanup_srcu_struct(struct srcu_struct *ssp)
> >{
> >	int cpu;
> >	struct srcu_usage *sup = ssp->srcu_sup;
> >	bool wasused = !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed));
> >
> >	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
> >		return; /* Just leak it! */
> >	if (WARN_ON(srcu_readers_active(ssp)))
> >		return; /* Just leak it! */
> >	flush_delayed_work(&sup->work);
> >	if (wasused) {
> 
>   If   wasused=false  It not need to invoke   flush_delayed_work(&sup->work);
>   this trigger WARN_ON(!work->func)) .

Again, good catch!  I will pull that flush_delayed_work() into this
"if" statement.

> >		for_each_possible_cpu(cpu) {
> >			struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> >
> >			del_timer_sync(&sdp->delay_work);
> >			flush_work(&sdp->work);
> >			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> >				return; /* Forgot srcu_barrier(), so just leak it! */
> >		}
> >	}
> >	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
> >	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) != sup->srcu_gp_seq_needed) ||
> >	    WARN_ON(srcu_readers_active(ssp))) {
> >		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
> >			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
> >			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
> >		return; /* Caller forgot to stop doing call_srcu()? */
> >	}
> >	kfree(sup->node);
> >	sup->node = NULL;
> >	sup->srcu_size_state = SRCU_SIZE_SMALL;
> >	if (!sup->sda_is_static) {
> >		free_percpu(ssp->sda);
> >		ssp->sda = NULL;
> >		kfree(sup);
> >		ssp->srcu_sup = NULL;
> >	}
> >}
> 
> 
> If we have not invoke check_init_srcu_struct() ,  that means call_srcu(),  synchronize_srcu(), srcu_barrier(), start_poll_synchronize_srcu() are also not invoke, so Is there no need to check
> srcu_readers_active()?

The module might have had lots of SRCU readers, but no updaters, and
a bug in that module might mean that that readers are still active.
For example, the module might have passed the srcu_struct structure
to some function in the main kernel, and then forgotten to tell that
function to stop doing srcu_read_lock() and srcu_read_unlock() on it.

Or the module might have created a kthread that did SRCU readers, and
then have forgotten to stop that kthread.

Please see below for an untested patch.

And yet again, thoughts?  ;-)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1fb078abbdc9..fe04214ce84c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -645,22 +645,25 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	int cpu;
 	struct srcu_usage *sup = ssp->srcu_sup;
+	bool wasused = !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed));
 
-	if (WARN_ON(!srcu_get_delay(ssp)))
+	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
-	flush_delayed_work(&sup->work);
-	for_each_possible_cpu(cpu) {
-		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
+	if (wasused) {
+		flush_delayed_work(&sup->work);
+		for_each_possible_cpu(cpu) {
+			struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		del_timer_sync(&sdp->delay_work);
-		flush_work(&sdp->work);
-		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
-			return; /* Forgot srcu_barrier(), so just leak it! */
+			del_timer_sync(&sdp->delay_work);
+			flush_work(&sdp->work);
+			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
+				return; /* Forgot srcu_barrier(), so just leak it! */
+		}
 	}
-	if (WARN_ON(rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
-	    WARN_ON(rcu_seq_current(&sup->srcu_gp_seq) != sup->srcu_gp_seq_needed) ||
+	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
+	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) != sup->srcu_gp_seq_needed) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
 		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
 			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
