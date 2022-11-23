Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCE9634BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiKWA0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiKWA0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:26:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06E7BEAFE;
        Tue, 22 Nov 2022 16:26:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C66D6195A;
        Wed, 23 Nov 2022 00:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4D4C433D7;
        Wed, 23 Nov 2022 00:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669163192;
        bh=5i9nIHhwqVmvzh0mZrit4SoCEiwLPbgmrDJj5rqrRgU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tBHUL+xpCr7xsHdi93mvRd57hGmh17xvE1BxlCxFo285BigX+OE7Xktsrqn6oBYLH
         kqIvKjs7mBQvth52bMPO/FkDcnYi2buNCjQBDntCW6eUzACs0rhpMLd/dGjQRWbZyk
         c+NsAjy8a+wkoToXIN4dTbaWCqPyROsGn2zIP/0kH5dvLiT3f5jK5/KAl4npVfQLS+
         c5FC80NYnuDa40azbBXoYCwIjLaUrN5Gin0Am2rvPy6MXCxcveszwtIixN6HM00kD0
         AxOagvzKMn8GiXE/ZqcMf8QVzabOzpzqTaERXSSbpncyswWbjXZq3aqgPRlRd0fBIm
         iBeo7BP3zGtrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4B0405C0BE7; Tue, 22 Nov 2022 16:26:32 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:26:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v8 0/6] rcu: Add RCU stall diagnosis information
Message-ID: <20221123002632.GS4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221119092508.1766-1-thunder.leizhen@huawei.com>
 <20221121222910.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <6877d891-7314-d9b3-5e1a-3e6bd239489b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6877d891-7314-d9b3-5e1a-3e6bd239489b@huawei.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:14:04AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/22 6:29, Paul E. McKenney wrote:
> > On Sat, Nov 19, 2022 at 05:25:02PM +0800, Zhen Lei wrote:
> >> v7 --> v8:
> >> 1. Change call jiffies64_to_msecs() to call jiffies_to_msecs().
> >> 2. Mention that rcupdate.rcu_cpu_stall_cputime overrides
> >>    CONFIG_RCU_CPU_STALL_CPUTIME behaviour in the Kconfig help text.
> >> 3. Fix a make htmldocs warning, change "|...|" to ":...:".
> >>
> >> v6 --> v7:
> >> 1. Use kcpustat_field() to obtain the cputime.
> >> 2. Make the output start with "\t" to match other related prints.
> >> 3. Aligns the output of the last line of RCU stall.
> >>
> >> v5 --> v6:
> >> 1. When there are more than two continuous RCU stallings, correctly handle the
> >>    value of the second and subsequent sampling periods. Update comments and
> >>    document.
> >>    Thanks to Elliott, Robert for the test.
> >> 2. Change "rcu stall" to "RCU stall".
> >>
> >> v4 --> v5:
> >> 1. Resolve a git am conflict. No code change.
> >>
> >> v3 --> v4:
> >> 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
> >>
> >> v2 --> v3:
> >> 1. Fix the return type of kstat_cpu_irqs_sum()
> >> 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
> >>    rcupdate.rcu_cpu_stall_deep_debug.
> >> 3. Add comments and normalize local variable name
> >>
> >> v1 --> v2:
> >> 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
> >>    kcpustat_this_cpu cannot be used.
> >> @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
> >>         if (r->gp_seq != rdp->gp_seq)
> >>                 return;
> >>
> >> -       cpustat = kcpustat_this_cpu->cpustat;
> >> +       cpustat = kcpustat_cpu(cpu).cpustat;
> >> 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
> >>    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
> >>
> >> v1:
> >> In some extreme cases, such as the I/O pressure test, the CPU usage may
> >> be 100%, causing RCU stall. In this case, the printed information about
> >> current is not useful. Displays the number and usage of hard interrupts,
> >> soft interrupts, and context switches that are generated within half of
> >> the CPU stall timeout, can help us make a general judgment. In other
> >> cases, we can preliminarily determine whether an infinite loop occurs
> >> when local_irq, local_bh or preempt is disabled.
> > 
> > Queued for further review and testing, thank you!
> > 
> > I did the usual wordsmithing, so please check to see if I messed
> > something up.
> 
> Thanks for your help.
> 
> Sorry, I think I missed a word in the commit message of patch 5/6.
> 
> This commit documents the additional RCU CPU stall warning output produced
> - by kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y.
> + by kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
> + rcupdate.rcu_cpu_stall_cputime=1.

Good eyes, fixed, thank you!

							Thanx, Paul

> >> Zhen Lei (6):
> >>   genirq: Fix the return type of kstat_cpu_irqs_sum()
> >>   sched: Add helper kstat_cpu_softirqs_sum()
> >>   sched: Add helper nr_context_switches_cpu()
> >>   rcu: Add RCU stall diagnosis information
> >>   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
> >>   rcu: Align the output of RCU stall
> >>
> >>  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
> >>  .../admin-guide/kernel-parameters.txt         |  6 ++
> >>  include/linux/kernel_stat.h                   | 14 ++-
> >>  kernel/rcu/Kconfig.debug                      | 13 +++
> >>  kernel/rcu/rcu.h                              |  1 +
> >>  kernel/rcu/tree.c                             | 18 ++++
> >>  kernel/rcu/tree.h                             | 19 ++++
> >>  kernel/rcu/tree_stall.h                       | 35 +++++++-
> >>  kernel/rcu/update.c                           |  2 +
> >>  kernel/sched/core.c                           |  5 ++
> >>  10 files changed, 198 insertions(+), 3 deletions(-)
> >>
> >> -- 
> >> 2.25.1
> >>
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
