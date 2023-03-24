Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6D06C763B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjCXDb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D763218AB9;
        Thu, 23 Mar 2023 20:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6222F6293D;
        Fri, 24 Mar 2023 03:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E4DC433EF;
        Fri, 24 Mar 2023 03:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679628683;
        bh=k2odxTgxbb9CVjSqPJg3BbtEgJGXZK8uJr/AreuURZQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lrrDsYEYPxSlXd20s+yAqua7o2BwXZMWKqlTa0x7A+HRO4HQV8gEZEqqZAGjOsa5P
         o7y3BMQxGIH+Slyq84s8j4DIk6LjVIjVcGHri+eoWWRptGSLyJXm5ihiuFFMi8s/KN
         sKX/dUHdU5Rh5MPdPedkJl1/jwE5f4CXeMEYHzn8dzZ1BLS8IqhqZ2LHdLAUanqVhM
         /Qq/y8vAkkPAl2P6XTjTEi8Gq2YKJ85dqIwn9AshqrZ5w9IaVAjr2n8SsPEG/l0dQK
         bVl1iTbKwCkqNGv6owajsBhki8J43obHkUUqFYqNl5TTZigXpKNsh21iBWbAbNNYVT
         Z492XlqsJeIWA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6B7BE1540379; Thu, 23 Mar 2023 20:31:23 -0700 (PDT)
Date:   Thu, 23 Mar 2023 20:31:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2] srcu: Fix flush srcu structure's->sup work warning in
 cleanup_srcu_struct()
Message-ID: <baf071c3-142c-4886-aea5-6b6ef2ff3ade@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230323134621.336832-1-qiang1.zhang@intel.com>
 <f18cad71-38f0-411d-9dc7-bda52d1d5a3a@paulmck-laptop>
 <PH0PR11MB58803F01B73914E1D7A052F5DA849@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB58803F01B73914E1D7A052F5DA849@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:20:18AM +0000, Zhang, Qiang1 wrote:
> Cc:  my personal email qiang.zhang1211@gmail.com
> 
> > When unloading rcutorture kmod will trigger the following callstack:
> > 
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
> > flush_delayed_work()
> > ->__flush_work()
> >    ->if (WARN_ON(!work->func))
> >         return false;
> > 
> > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),
> > when compiling and loading as modules, the srcu_module_coming() is
> > invoked, allocate memory for srcu structure's->sda and initialize
> > sda structure, due to not fully initialize srcu structure's->sup,
> > so at this time the sup structure's->work.work.func is null, if not
> > invoke init_srcu_struct_fields() before unloading modules, the
> > __flush_work() be invoked in srcu_module_going() and find work->func
> > is empty, will raise the warning above.
> > 
> > This commit add the check of srcu_sup structure's->srcu_gp_seq_needed
> > to determine whether the check_init_srcu_struct() has been invoked to
> > initialize srcu objects in srcu_module_going(), if not initialize, there
> > are no pending or running works, so there is no need to flush, only invoke
> > free_percpu() to release srcu structure's->sda.
> > 
> > Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
> >
> >Thank you for the testing, bug-finding, and problem-solving!
> >
> >In theory, you would need a Signed-off-by here from me as well, but
> >in practice bisectability means that this must be folded into this:
> >
> >e7c778489040 ("srcu: Use static init for statically allocated in-module srcu_struct")
> >	
> >This will of course be with attribution.
> >
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >But this is still a bit more complex than needed.  How about something
> >like this?
> 
> Agree,  from a logical point of view, this is more rigorous😊.

And I finally got around to doing some modprobe/rmmod testing myself,
and it passes eleven cycles.

May I add your Tested-by to the series?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >							Thanx, Paul
> >
> >------------------------------------------------------------------------
> >
> >/* Initialize any global-scope srcu_struct structures used by this module. */
> >static int srcu_module_coming(struct module *mod)
> >{
> >	int i;
> >	struct srcu_struct *ssp;
> >	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> >
> >	for (i = 0; i < mod->num_srcu_structs; i++) {
> >		ssp = *(sspp++);
> >		ssp->sda = alloc_percpu(struct srcu_data);
> >		if (WARN_ON_ONCE(!ssp->sda))
> >			return -ENOMEM;
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
> >		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
> >		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
> >				cleanup_srcu_struct(ssp);
> >		free_percpu(ssp->sda);
> >	}
> >}
