Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CBE622F06
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiKIP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiKIP0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:26:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC463BE05;
        Wed,  9 Nov 2022 07:26:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8774361B91;
        Wed,  9 Nov 2022 15:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60098C433D7;
        Wed,  9 Nov 2022 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668007583;
        bh=Pymxl7n2ZYnyw0RfNbgM6GPwZJA+tDvhsLK+AEj1BeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TB7ExP5ufy4aISASgWuc05goswVICGpEEyRnvHQ4or/hixANtp2I5+tbwEr5fjdnQ
         olZKSDmVszAsEw7exmnEZuMP6qBhD33QC+nsmUDlrZdhA2JmZPbbD/KbcLEpmlf3y5
         L6FrDmNfgYg7ekPK5yaUYOyWkiuKAoqrYfuN6fjYXg3R4DyHsz80rdTqb/5oKnj6ZT
         kMN1XKW/xATlZokeu6gzkLmxW1rIukitaluvjHlovSbShoG1j0JW6XErOPfZ2qKhQz
         HAh3o+2+J1RLx2/tIWKVxjeiFjdoUL2JARn+FTF2Bzg4z8Z8Ic0e4bNvLhsVll33Cs
         xIjccerdW8vPw==
Date:   Wed, 9 Nov 2022 16:26:21 +0100
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
Subject: Re: [PATCH v6 0/2] rcu: Add RCU stall diagnosis information
Message-ID: <20221109152621.GB298683@lothringen>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109093739.187-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

On Wed, Nov 09, 2022 at 05:37:36PM +0800, Zhen Lei wrote:
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

That looks useful but I have to ask: what does it bring that the softlockup
and hardlockup watchdog can not already solve?

Thanks.

> 
> Zhen Lei (2):
>   rcu: Add RCU stall diagnosis information
>   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
> 
>  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
>  .../admin-guide/kernel-parameters.txt         |  6 ++
>  kernel/rcu/Kconfig.debug                      | 11 +++
>  kernel/rcu/rcu.h                              |  1 +
>  kernel/rcu/tree.c                             | 17 ++++
>  kernel/rcu/tree.h                             | 19 ++++
>  kernel/rcu/tree_stall.h                       | 29 ++++++
>  kernel/rcu/update.c                           |  2 +
>  8 files changed, 173 insertions(+)
> 
> -- 
> 2.25.1
> 
