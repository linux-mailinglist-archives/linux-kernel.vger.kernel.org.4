Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B52622F87
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiKIP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKIP7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:59:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181DDBF55;
        Wed,  9 Nov 2022 07:59:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D119DB81F2C;
        Wed,  9 Nov 2022 15:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA2EC433B5;
        Wed,  9 Nov 2022 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668009543;
        bh=OFd6OVBr+n3XZOEzeSYbl1sXmtALGXnT13WVARihOCQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uAlQaznFZfmkgaFsuTx3Cj67MkITNjKvRLqcMMqpkQFzerdAzlJRWwEt7BFy2U/xN
         iFO2bje5siMOiR1RN+ce8yv/KT4qUd7kYx7zpJ5fmpuwJN85shEFa6qhg3pwKZktDg
         uLE3/zn3tYbkW5hMxcAaimp98EhnkhhtkxaQh3ZJEkGey41On5jRSc7ly7gI8zrIwk
         LwDVxEGqTf71HnJqrRcztccIQrwtKJj3aFSkCnBLFBzJPpUI6R/jPj0HZCIimHdsm9
         H2zD3Ruhn7ZDrAjsxm7PnQhDRPvUWYrt50G+d4SUJ9+JEAP4aZ776i5xC56AL1mJQL
         6jRtxqsa/vENw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D753F5C097E; Wed,  9 Nov 2022 07:59:01 -0800 (PST)
Date:   Wed, 9 Nov 2022 07:59:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v6 0/2] rcu: Add RCU stall diagnosis information
Message-ID: <20221109155901.GA727034@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109152621.GB298683@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109152621.GB298683@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 04:26:21PM +0100, Frederic Weisbecker wrote:
> Hi Zhen Lei,
> 
> On Wed, Nov 09, 2022 at 05:37:36PM +0800, Zhen Lei wrote:
> > v5 --> v6:
> > 1. When there are more than two continuous RCU stallings, correctly handle the
> >    value of the second and subsequent sampling periods. Update comments and
> >    document.
> >    Thanks to Elliott, Robert for the test.
> > 2. Change "rcu stall" to "RCU stall".
> > 
> > v4 --> v5:
> > 1. Resolve a git am conflict. No code change.
> > 
> > v3 --> v4:
> > 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
> > 
> > v2 --> v3:
> > 1. Fix the return type of kstat_cpu_irqs_sum()
> > 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
> >    rcupdate.rcu_cpu_stall_deep_debug.
> > 3. Add comments and normalize local variable name
> > 
> > 
> > v1 --> v2:
> > 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
> >    kcpustat_this_cpu cannot be used.
> > @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
> >         if (r->gp_seq != rdp->gp_seq)
> >                 return;
> > 
> > -       cpustat = kcpustat_this_cpu->cpustat;
> > +       cpustat = kcpustat_cpu(cpu).cpustat;
> > 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
> >    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
> > 
> > v1:
> > In some extreme cases, such as the I/O pressure test, the CPU usage may
> > be 100%, causing RCU stall. In this case, the printed information about
> > current is not useful. Displays the number and usage of hard interrupts,
> > soft interrupts, and context switches that are generated within half of
> > the CPU stall timeout, can help us make a general judgment. In other
> > cases, we can preliminarily determine whether an infinite loop occurs
> > when local_irq, local_bh or preempt is disabled.
> 
> That looks useful but I have to ask: what does it bring that the softlockup
> and hardlockup watchdog can not already solve?

This is a good point.  One possible benefit is putting the needed information
in one spot, for example, in cases where the soft/hard lockup timeouts are
significantly different than the RCU CPU stall warning timeout.

Thoughts?

							Thanx, Paul

> Thanks.
> 
> > 
> > Zhen Lei (2):
> >   rcu: Add RCU stall diagnosis information
> >   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
> > 
> >  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
> >  .../admin-guide/kernel-parameters.txt         |  6 ++
> >  kernel/rcu/Kconfig.debug                      | 11 +++
> >  kernel/rcu/rcu.h                              |  1 +
> >  kernel/rcu/tree.c                             | 17 ++++
> >  kernel/rcu/tree.h                             | 19 ++++
> >  kernel/rcu/tree_stall.h                       | 29 ++++++
> >  kernel/rcu/update.c                           |  2 +
> >  8 files changed, 173 insertions(+)
> > 
> > -- 
> > 2.25.1
> > 
