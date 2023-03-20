Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541E16C25AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjCTXfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCTXfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BFC36087;
        Mon, 20 Mar 2023 16:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 445E7618C2;
        Mon, 20 Mar 2023 23:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E29C433D2;
        Mon, 20 Mar 2023 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679355334;
        bh=5xOvmHmUf2cEKOzAJOcRijmuejRiFNLhPJ88WTuylQ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rKUOXh7a0R2s0mRzp93zpdwuFs0B7H8/Rc95jS/fLT9+Yz8daFD0bR7DGV0RaBLDF
         QTN+l/re3XsVtgAzUgelfJr6ryk8AkqsEMm1J4x2aB/IuK0t/ST2WDj3AM3Z+H124I
         P9xapvUxHmbUHZx2vbd3wmv1SiDTH6ZIU5v3lqT8YsMcBZzqw9kbU6WW7rywycNxFm
         1m8uN0+ultPGBBE8jECLqClo9vPmr8+CgJ1Rrzm4ohx/NAD8GM3Fj1OzWhIWPtt8Rx
         YzKU4Oah7bRr/DLpQgioqXIKQXv8jsdvIp2Zwn6WQYdNKSiUvu0wjqUGPjJCqimyrZ
         TXrY2JVCkgFhw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 29D3F1540395; Mon, 20 Mar 2023 16:35:34 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:35:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcutorture: Convert
 schedule_timeout_uninterruptible() to mdelay() in rcu_torture_stall()
Message-ID: <5a887ca6-10e9-4026-b792-164deb80d0a8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230320032422.4010801-1-qiang1.zhang@intel.com>
 <7a414721-25fa-485c-91a5-13d3149073fe@paulmck-laptop>
 <PH0PR11MB58806032CE88C9E6BE61059CDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58806032CE88C9E6BE61059CDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:05:17PM +0000, Zhang, Qiang1 wrote:
> > For kernels built with enable PREEMPT_NONE and CONFIG_DEBUG_ATOMIC_SLEEP,
> > running the RCU stall tests.
> > 
> > runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4"
> > bootparams="nokaslr console=ttyS0 rcutorture.stall_cpu=30
> > rcutorture.stall_no_softlockup=1 rcutorture.stall_cpu_irqsoff=1
> > rcutorture.stall_cpu_block=1" -d
> > 
> > [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> > [   10.841073] rcu_torture_stall start on CPU 3.
> > [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
> > ....
> > [   10.841108] Call Trace:
> > [   10.841110]  <TASK>
> > [   10.841112]  dump_stack_lvl+0x64/0xb0
> > [   10.841118]  dump_stack+0x10/0x20
> > [   10.841121]  __schedule_bug+0x8b/0xb0
> > [   10.841126]  __schedule+0x2172/0x2940
> > [   10.841157]  schedule+0x9b/0x150
> > [   10.841160]  schedule_timeout+0x2e8/0x4f0
> > [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> > [   10.841195]  rcu_torture_stall+0x2e8/0x300
> > [   10.841199]  kthread+0x175/0x1a0
> > [   10.841206]  ret_from_fork+0x2c/0x50
> > 
> > The above calltrace occurs in the local_irq_disable/enable() critical
> > section call schedule_timeout(), and invoke schedule_timeout() also
> > implies a quiescent state, of course it also fails to trigger RCU stall,
> > this commit therefore use mdelay() instead of schedule_timeout() to
> > trigger RCU stall.
> > 
> > Suggested-by: Joel Fernandes <joel@joelfernandes.org>
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/rcutorture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index d06c2da04c34..a08a72bef5f1 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -2472,7 +2472,7 @@ static int rcu_torture_stall(void *args)
> >
> >Right here there is:
> >
> >			if (stall_cpu_block) {
> >
> >In other words, the rcutorture.stall_cpu_block module parameter says to
> >block, even if it is a bad thing to do.  The point of this is to verify
> >the error messages that are supposed to be printed on the console when
> >this happens.
> >
> >  #ifdef CONFIG_PREEMPTION
> >  				preempt_schedule();
> >  #else
> > -				schedule_timeout_uninterruptible(HZ);
> > +				mdelay(jiffies_to_msecs(HZ));
> >
> >So this really needs to stay schedule_timeout_uninterruptible(HZ).
> 
> But invoke schedule_timeout_uninterruptible(HZ) implies a quiescent state, 
> this will not cause an RCU stall to occur, and still in the RCU read critical section(PREEMPT_COUNT=y).
> 
> It didn't happen RCU stall when I tested with the following parameters for 
> rcutorture.stall_cpu=30
> rcutorture.stall_no_softlockup=1
> rcutorture.stall_cpu_irqsoff=1
> rcutorture.stall_cpu_block=1

Understood.  If you want that RCU CPU stall in a CONFIG_PREEMPTION=n
kernel, you should not use rcutorture.stall_cpu_block=1.

In a CONFIG_PREEMPTION=y kernel, rcutorture.stall_cpu_block=1 forces
the grace period to be stalled on a task rather than a CPU, exercising
a different part of the RCU CPU stall warning code.

In a CONFIG_PREEMPTION=n kernel, using rcutorture.stall_cpu_block=1
forces the CPU to go through a quiescent state, as you say.  It can
also cause lockdep and scheduling-while-atomic complaints, depending on
exactly what type of RCU reader is in effect.

So these are test-the-diagnostics parameters.  The mdelay() instead
makes rcutorture.stall_cpu_block=1 do the same thing as does
rcutorture.stall_cpu_block=0 for CONFIG_PREEMPTION=n kernels, right?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >So should there be a change to kernel-parameters.txt to make it
> >more clear that this is intended behavior?
> >
> >						Thanx, Paul
> >
> >  #endif
> >  			} else if (stall_no_softlockup) {
> >  				touch_softlockup_watchdog();
> > -- 
> > 2.25.1
> > 
