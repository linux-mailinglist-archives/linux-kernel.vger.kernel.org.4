Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F2633BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiKVL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiKVL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:59:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8D513EB0;
        Tue, 22 Nov 2022 03:59:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13A7BB81A09;
        Tue, 22 Nov 2022 11:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D863C433D6;
        Tue, 22 Nov 2022 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669118371;
        bh=awIitadsf/uo1C7l6pvVh4QYBC6b2uHMr5qvDAo+Zvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZo7+YFb6KE0Xfg4iZY0adz7ph8k7Q2yTgCQ4Ul963JgXTlUMRMPubmkI7sdeReax
         LXPv/DojlpOddNPYtD3tC2LK5BitNd7sKQC4Ou1/DK3lCtN3SVY4EjAQgPLHpBVbiw
         VdFFpvzc4qT//7YyxvfpKIG53GdweNBlIwYqL8laUivXCD7etXBqlE84kK0IPNkyMQ
         0zmt9RnbhQ63aTIzPOepNaM9o6as3tpIY1ieWgknUqbBxRDl3Pa1eDo0f/aBw44Crg
         6fdsV1qErdGzV17ISPIJz0xEXIxzFC2rgQVWo+hoJo91DuzfvwraSZ45IuDkTj5Up7
         oTUAPJ5j9+xeg==
Date:   Tue, 22 Nov 2022 12:59:28 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v8 0/6] rcu: Add RCU stall diagnosis information
Message-ID: <20221122115928.GA1158713@lothringen>
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
> 
> Zhen Lei (6):
>   genirq: Fix the return type of kstat_cpu_irqs_sum()
>   sched: Add helper kstat_cpu_softirqs_sum()
>   sched: Add helper nr_context_switches_cpu()
>   rcu: Add RCU stall diagnosis information
>   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
>   rcu: Align the output of RCU stall

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

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
