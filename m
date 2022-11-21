Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459D6632FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiKUW3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUW3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:29:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7510C694A;
        Mon, 21 Nov 2022 14:29:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D6CDB810DB;
        Mon, 21 Nov 2022 22:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5268BC433C1;
        Mon, 21 Nov 2022 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669069751;
        bh=/eg94iwVmYNRjwpHdAHBpwFGQ8ZAlh9U7hMm2Nx7ZME=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d2PvJhwDZse8EP5R1tPpuigYIZAWgjZ8eeV11wv2inj2erpOwci3dpMQGopU2yKpP
         vmHcVGYqyFFXU/acHZpZoZ8mbMz0T2MRX7KiPACUxciweEhyCgKkOXfJFoEcI6Hup8
         46SwZbikSH4WZF/JaevpO/bc5WbMXlcDWVJIBSoeYXv45VZd62/RqEmmHyxMzp9ulX
         mqLzxfo120jAyUjkG7MNuE+37XAMM11RnQN+LIEjviQyV+58ta7BPCW0ubYmaiW3/s
         ZUS3iViuDdJgODG7NmBAehy1Nmi3JGhuU9Q9W8fbVGxj+8tmTrMCm1U/74+cYU9vf4
         BHsAB27mntXGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DCACF5C0DFC; Mon, 21 Nov 2022 14:29:10 -0800 (PST)
Date:   Mon, 21 Nov 2022 14:29:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v8 0/6] rcu: Add RCU stall diagnosis information
Message-ID: <20221121222910.GP4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221119092508.1766-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119092508.1766-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 05:25:02PM +0800, Zhen Lei wrote:
> v7 --> v8:
> 1. Change call jiffies64_to_msecs() to call jiffies_to_msecs().
> 2. Mention that rcupdate.rcu_cpu_stall_cputime overrides
>    CONFIG_RCU_CPU_STALL_CPUTIME behaviour in the Kconfig help text.
> 3. Fix a make htmldocs warning, change "|...|" to ":...:".
> 
> v6 --> v7:
> 1. Use kcpustat_field() to obtain the cputime.
> 2. Make the output start with "\t" to match other related prints.
> 3. Aligns the output of the last line of RCU stall.
> 
> v5 --> v6:
> 1. When there are more than two continuous RCU stallings, correctly handle the
>    value of the second and subsequent sampling periods. Update comments and
>    document.
>    Thanks to Elliott, Robert for the test.
> 2. Change "rcu stall" to "RCU stall".
> 
> v4 --> v5:
> 1. Resolve a git am conflict. No code change.
> 
> v3 --> v4:
> 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
> 
> v2 --> v3:
> 1. Fix the return type of kstat_cpu_irqs_sum()
> 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
>    rcupdate.rcu_cpu_stall_deep_debug.
> 3. Add comments and normalize local variable name
> 
> v1 --> v2:
> 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
>    kcpustat_this_cpu cannot be used.
> @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
>         if (r->gp_seq != rdp->gp_seq)
>                 return;
> 
> -       cpustat = kcpustat_this_cpu->cpustat;
> +       cpustat = kcpustat_cpu(cpu).cpustat;
> 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
>    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
> 
> v1:
> In some extreme cases, such as the I/O pressure test, the CPU usage may
> be 100%, causing RCU stall. In this case, the printed information about
> current is not useful. Displays the number and usage of hard interrupts,
> soft interrupts, and context switches that are generated within half of
> the CPU stall timeout, can help us make a general judgment. In other
> cases, we can preliminarily determine whether an infinite loop occurs
> when local_irq, local_bh or preempt is disabled.

Queued for further review and testing, thank you!

I did the usual wordsmithing, so please check to see if I messed
something up.

							Thanx, Paul

> Zhen Lei (6):
>   genirq: Fix the return type of kstat_cpu_irqs_sum()
>   sched: Add helper kstat_cpu_softirqs_sum()
>   sched: Add helper nr_context_switches_cpu()
>   rcu: Add RCU stall diagnosis information
>   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
>   rcu: Align the output of RCU stall
> 
>  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
>  .../admin-guide/kernel-parameters.txt         |  6 ++
>  include/linux/kernel_stat.h                   | 14 ++-
>  kernel/rcu/Kconfig.debug                      | 13 +++
>  kernel/rcu/rcu.h                              |  1 +
>  kernel/rcu/tree.c                             | 18 ++++
>  kernel/rcu/tree.h                             | 19 ++++
>  kernel/rcu/tree_stall.h                       | 35 +++++++-
>  kernel/rcu/update.c                           |  2 +
>  kernel/sched/core.c                           |  5 ++
>  10 files changed, 198 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.1
> 
