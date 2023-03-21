Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CEA6C350F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCUPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCUPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB47B50737;
        Tue, 21 Mar 2023 08:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D86E61CBF;
        Tue, 21 Mar 2023 15:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF91C433D2;
        Tue, 21 Mar 2023 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679411195;
        bh=Gzj2uovWzT6hyqR2+98XxWJboVUxwbVYACiBSIn1gZ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OIs480KBIm32yNFte5TtMvjVCQcvvQTsMqttgcyE+OE/3aOWdT8CK1daXMt18Uy8w
         mFcnOK5B+hnlhnv7NY3NHnOofL/WvpIdnCDPi70CwRMWdEeClXI2/Xs8L0lwT0my+Q
         HOrb2RGYRM8X7b5C1ts6/LqFDLV422DS1l0+7LQX4Zbr3bYWX1euk43FDdF+NOQoot
         XncHOPxRni5jnm+MoUGxzi55leOfehmB6gFuuvgXfIhEBrwDvE0ZfxVhZElXJLKTJx
         7LbC26YvpOnwTEm95Xu1sQ8Dt10yy8k8Rb+YwJ0U08cYACjRExHx/ETD1Z1FLwAZ8y
         BwZmEW873+6aQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 29762154033A; Tue, 21 Mar 2023 08:06:35 -0700 (PDT)
Date:   Tue, 21 Mar 2023 08:06:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Message-ID: <1d9141f1-78c3-48a0-867e-9abd23d15547@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:04:20AM -0700, Paul E. McKenney wrote:
> On Tue, Mar 21, 2023 at 04:13:46PM +0800, Zqiang wrote:
> > insmod rcutorture.ko
> > rmmod rcutorture.ko
> > 
> > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167 __flush_work+0x50a/0x540
> > [  209.437346] Modules linked in: rcutorture(-) torture [last unloaded: rcutorture]
> > [  209.437382] CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standard+
> > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540
> > .....
> > [  209.437758]  flush_delayed_work+0x36/0x90
> > [  209.437776]  cleanup_srcu_struct+0x68/0x2e0
> > [  209.437817]  srcu_module_notify+0x71/0x140
> > [  209.437854]  blocking_notifier_call_chain+0x9d/0xd0
> > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > [  209.438046]  do_syscall_64+0x43/0x90
> > [  209.438062]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > 
> > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),
> > when compiling and loading as modules, the srcu_module_coming() is invoked,
> > allocate memory for srcu structure's->sda and initialize sda structure,
> > due to not fully initialize srcu structure's->sup, so at this time the
> > sup structure's->delaywork.func is null, if not invoke init_srcu_struct_fields()
> > before unloading modules, in srcu_module_going() the __flush_work() find
> > work->func is empty, will raise the warning above.
> > 
> > This commit add init_srcu_struct_fields() to initialize srcu structure's->sup,
> > in srcu_module_coming().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Good catch, and thank you for testing the in-module case!
> 
> One question below...
> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/srcutree.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 1fb078abbdc9..42d8720e016c 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *mod)
> >  		ssp->sda = alloc_percpu(struct srcu_data);
> >  		if (WARN_ON_ONCE(!ssp->sda))
> >  			return -ENOMEM;
> > -		init_srcu_struct_data(ssp);
> > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > +			return -ENOMEM;
> 
> Wouldn't it be better to simply delete the init_srcu_struct_data()?
> 
> Then the first call to check_init_srcu_struct() would take care of
> the initialization, just as for the non-module case.  Or am I missing
> something subtle?
> 
> It should also be possible to eliminate duplicate code between the
> in-module and non-module statically allocated initialization cases,
> come to think of it.

But that would amount to only one line of duplicated code, so this
last is probably not worth it.

						Thanx, Paul

> >  	}
> >  	return 0;
> >  }
> > @@ -1931,9 +1932,13 @@ static void srcu_module_going(struct module *mod)
> >  {
> >  	int i;
> >  	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> > +	struct srcu_struct *ssp;
> >  
> > -	for (i = 0; i < mod->num_srcu_structs; i++)
> > -		cleanup_srcu_struct(*(sspp++));
> > +	for (i = 0; i < mod->num_srcu_structs; i++) {
> > +		ssp = *(sspp++);
> > +		cleanup_srcu_struct(ssp);
> > +		free_percpu(ssp->sda);
> > +	}
> 
> And good catch on another memory leak with this one, looks proper
> to me.
> 
> >  }
> >  
> >  /* Handle one module, either coming or going. */
> > -- 
> > 2.25.1
> > 
