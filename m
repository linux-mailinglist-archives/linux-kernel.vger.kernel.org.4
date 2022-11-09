Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBFD623105
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiKIREk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiKIREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448081147;
        Wed,  9 Nov 2022 09:03:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8A65B81F39;
        Wed,  9 Nov 2022 17:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCCCC433D6;
        Wed,  9 Nov 2022 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668013400;
        bh=/DC7txXo1eft1GARRQpJ0cZkbHGmgyDvTb7YH1EnkJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4tkJnzhIlczU77xaG/lWDICv8juWY3rDLrDEkNBIgW3/z+4AYz1n9kddoRtuCaRR
         K/dCGrbAZc+N3Ur/TwEUbsUde0OKpmyO5IpXyxcwNxWTxEfzJpsKxiIHvT0jkc0I2+
         +LbfydyXiYow97mAMISHcKlNEwur6I8/H7wrVUPdz+ZYgTbm21D2X34ra5SjZomn1T
         DWlKdkg12ngQey8yWRO0T8O2IfdbgYeSMGLNfC7+jfCXilSFzjuKSyFQ0fZlxg6AdU
         DhbqGBlnfsXrm/Tp+6IyDo51JkTKJx3riTxRqlFana+izmz7vy4kREJEvFY3GE1JcA
         4lNtnpaGgVnRg==
Date:   Wed, 9 Nov 2022 18:03:17 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v6 0/2] rcu: Add RCU stall diagnosis information
Message-ID: <20221109170317.GA300561@lothringen>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109152621.GB298683@lothringen>
 <20221109155901.GA727034@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109155901.GA727034@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 07:59:01AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 09, 2022 at 04:26:21PM +0100, Frederic Weisbecker wrote:
> > Hi Zhen Lei,
> > 
> > On Wed, Nov 09, 2022 at 05:37:36PM +0800, Zhen Lei wrote:
> > > v5 --> v6:
> > > 1. When there are more than two continuous RCU stallings, correctly handle the
> > >    value of the second and subsequent sampling periods. Update comments and
> > >    document.
> > >    Thanks to Elliott, Robert for the test.
> > > 2. Change "rcu stall" to "RCU stall".
> > > 
> > > v4 --> v5:
> > > 1. Resolve a git am conflict. No code change.
> > > 
> > > v3 --> v4:
> > > 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
> > > 
> > > v2 --> v3:
> > > 1. Fix the return type of kstat_cpu_irqs_sum()
> > > 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
> > >    rcupdate.rcu_cpu_stall_deep_debug.
> > > 3. Add comments and normalize local variable name
> > > 
> > > 
> > > v1 --> v2:
> > > 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
> > >    kcpustat_this_cpu cannot be used.
> > > @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
> > >         if (r->gp_seq != rdp->gp_seq)
> > >                 return;
> > > 
> > > -       cpustat = kcpustat_this_cpu->cpustat;
> > > +       cpustat = kcpustat_cpu(cpu).cpustat;
> > > 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
> > >    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
> > > 
> > > v1:
> > > In some extreme cases, such as the I/O pressure test, the CPU usage may
> > > be 100%, causing RCU stall. In this case, the printed information about
> > > current is not useful. Displays the number and usage of hard interrupts,
> > > soft interrupts, and context switches that are generated within half of
> > > the CPU stall timeout, can help us make a general judgment. In other
> > > cases, we can preliminarily determine whether an infinite loop occurs
> > > when local_irq, local_bh or preempt is disabled.
> > 
> > That looks useful but I have to ask: what does it bring that the softlockup
> > and hardlockup watchdog can not already solve?
> 
> This is a good point.  One possible benefit is putting the needed information
> in one spot, for example, in cases where the soft/hard lockup timeouts are
> significantly different than the RCU CPU stall warning timeout.

Arguably, the hardlockup/softlockup detectors usually trigger after RCU stall,
unless all CPUs are caught into a hardlockup, in which case only the hardlockup
detector has a chance.

Anyway I would say that in this case just lower the delay for the lockup
detectors to consider the situation is a lockup?

Thanks.


> 
> Thoughts?
> 
> 							Thanx, Paul
> 
> > Thanks.
> > 
> > > 
> > > Zhen Lei (2):
> > >   rcu: Add RCU stall diagnosis information
> > >   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
> > > 
> > >  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
> > >  .../admin-guide/kernel-parameters.txt         |  6 ++
> > >  kernel/rcu/Kconfig.debug                      | 11 +++
> > >  kernel/rcu/rcu.h                              |  1 +
> > >  kernel/rcu/tree.c                             | 17 ++++
> > >  kernel/rcu/tree.h                             | 19 ++++
> > >  kernel/rcu/tree_stall.h                       | 29 ++++++
> > >  kernel/rcu/update.c                           |  2 +
> > >  8 files changed, 173 insertions(+)
> > > 
> > > -- 
> > > 2.25.1
> > > 
