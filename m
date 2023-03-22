Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D06C4EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCVO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCVO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:58:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B3E3430F;
        Wed, 22 Mar 2023 07:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93E45B81D11;
        Wed, 22 Mar 2023 14:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E6FC433D2;
        Wed, 22 Mar 2023 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679497048;
        bh=Y3HtKtckdIyVycaNg7jC2DNyivhIui6yCz3yQioPQdk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iKuInfSMVIkMoiqTwiz5b6AWyGjTKHqgKQ8VkmkEMyhp8Znvf5dODRrMldam2G4Mc
         hkWWVAHCDcObQTQtyFTuagctIXDgHzFC8o8HDNeuV3/EtRFI+mBVFllOxDMBeIa5o6
         EGDyb31rmWq7d+Qc08kf2H6jYjAQgMAoFOtmX91kPvf08zbJX87A62nz4L1qeP2weJ
         qUQy/fJfuBKVKrxgBp6XDmUe3Eh8WvlJVDhDRClqZ0VH6AV0VGYfzJTnWpYxa4AxBy
         rAAtTPsynSr0h//GwMJyIzrn4fif7nK+rgFVNaMRI6pEsEyu7dvAfhysz2I4e14bBw
         QCByONW/dUTBg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C7577154033A; Wed, 22 Mar 2023 07:57:27 -0700 (PDT)
Date:   Wed, 22 Mar 2023 07:57:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Message-ID: <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
 <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
 <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 04:38:29AM +0000, Zhang, Qiang1 wrote:
> > > insmod rcutorture.ko
> > > rmmod rcutorture.ko
> > > 
> > > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167 
> > > __flush_work+0x50a/0x540 [  209.437346] Modules linked in: 
> > > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382] 
> > > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standard+ 
> > > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776]  
> > > cleanup_srcu_struct+0x68/0x2e0 [  209.437817]  
> > > srcu_module_notify+0x71/0x140 [  209.437854]  
> > > blocking_notifier_call_chain+0x9d/0xd0
> > > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062]  
> > > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > 
> > > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(), 
> > > when compiling and loading as modules, the srcu_module_coming() is 
> > > invoked, allocate memory for srcu structure's->sda and initialize 
> > > sda structure, due to not fully initialize srcu structure's->sup, so 
> > > at this time the sup structure's->delaywork.func is null, if not 
> > > invoke init_srcu_struct_fields() before unloading modules, in 
> > > srcu_module_going() the __flush_work() find
> > > work->func is empty, will raise the warning above.
> > > 
> > > This commit add init_srcu_struct_fields() to initialize srcu 
> > > structure's->sup, in srcu_module_coming().
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >Good catch, and thank you for testing the in-module case!
> > >
> > >One question below...
> > >
> > >							Thanx, Paul
> > >
> > > ---
> > >  kernel/rcu/srcutree.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index 
> > > 1fb078abbdc9..42d8720e016c 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *mod)
> > >  		ssp->sda = alloc_percpu(struct srcu_data);
> > >  		if (WARN_ON_ONCE(!ssp->sda))
> > >  			return -ENOMEM;
> > > -		init_srcu_struct_data(ssp);
> > > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > > +			return -ENOMEM;
> > >
> > >Wouldn't it be better to simply delete the init_srcu_struct_data()?
> > >
> > >Then the first call to check_init_srcu_struct() would take care of 
> > >the initialization, just as for the non-module case.  Or am I missing 
> > >something subtle?
> > 
> > Hi Paul
> > 
> > Maybe the check_init_srcu_struct() is always not invoked, for example,
> > In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(srcu_ctl),
> > but we use torture_type=rcu to test,  there will not be any interface 
> > calling
> > check_init_srcu_struct() to initialize srcu_ctl and set  
> > structure's->delaywork.func is process_srcu().
> > when we unload the rcutorture module, invoke cleanup_srcu_struct() to 
> > flush sup structure's->delaywork.func, due to the func pointer is not 
> > initialize, it's null, will trigger warning.
> > 
> > About kernel/workqueue.c:3167
> > 
> > __flush_work
> >      if (WARN_ON(!work->func))   <---------trigger waning
> > 	return false;
> > 
> > 
> > and  in  init_srcu_struct_fields(ssp, true), wil set 
> > srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_needed 
> > is zero,  after that when we call
> >  check_init_srcu_struct() again, it not be initialized again.
> >
> >
> >Good point!  In the non-module statically allocated case there is never a call to cleanup_srcu_struct().
> >
> >So suppose the code in srcu_module_coming() only did the alloc_percpu(), and then the
> >code in srcu_module_going() only did the the matching
> >free_percpu() instead of the current cleanup_srcu_struct()?
> 
> But in modules, for srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),
> when a module is unloaded, we usually don't call cleanup_srcu_struct() in the module
> unload function.
> If in srcu_module_going() only do free_percpu(), the srcu_sup->node memory maybe
> can not free and also lost the opportunity to refresh the running work.

But in the module case, isn't the srcu_sup->node also statically
allocated via the "static struct srcu_usage" declaration?

							Thanx, Paul

------------------------------------------------------------------------

#ifdef MODULE
# define __DEFINE_SRCU(name, is_static)								\
	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage);	\
	extern struct srcu_struct * const __srcu_struct_##name;					\
	struct srcu_struct * const __srcu_struct_##name						\
		__section("___srcu_struct_ptrs") = &name
#else
# define __DEFINE_SRCU(name, is_static)								\
	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
	is_static struct srcu_struct name =							\
		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
#endif

> Thanks
> Zqiang
> 
> 
> >
> >							Thanx, Paul
> >
> > Thanks
> > Zqiang
> > 
> > >
> > >It should also be possible to eliminate duplicate code between the 
> > >in-module and non-module statically allocated initialization cases, 
> > >come to think of it.
> > >
> > >  	}
> > >  	return 0;
> > >  }
> > > @@ -1931,9 +1932,13 @@ static void srcu_module_going(struct module 
> > > *mod)  {
> > >  	int i;
> > >  	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> > > +	struct srcu_struct *ssp;
> > >  
> > > -	for (i = 0; i < mod->num_srcu_structs; i++)
> > > -		cleanup_srcu_struct(*(sspp++));
> > > +	for (i = 0; i < mod->num_srcu_structs; i++) {
> > > +		ssp = *(sspp++);
> > > +		cleanup_srcu_struct(ssp);
> > > +		free_percpu(ssp->sda);
> > > +	}
> > >
> > >And good catch on another memory leak with this one, looks proper to 
> > >me.
> > >
> > >  }
> > >  
> > >  /* Handle one module, either coming or going. */
> > > --
> > > 2.25.1
> > > 
