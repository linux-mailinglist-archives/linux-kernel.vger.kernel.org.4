Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCB625490
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiKKHpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKKHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:45:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE36B22E;
        Thu, 10 Nov 2022 23:45:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C6A61EC3;
        Fri, 11 Nov 2022 07:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7D4C433C1;
        Fri, 11 Nov 2022 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668152740;
        bh=8out+fJr/WRmEEqmU+0ZgZ+QtyiRoJO1N39Lz9svS7w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=No33eSxefhrrmSk9spcR1TOlz/5TYDuV5wQN7j9pryMCqYp3bzvKdZi9dh/pCMDgh
         cqzhZ+VynIkcfzzuq2BsORXx4sWbbD2OMpdEYhl0PjAhQHPK4bDm/wiv4hmAfcBybU
         U0hDJsG+I6cQGlwYGLkmfKAXK9T/Uvh8O7B4mlBHlQ5HbbTqlj1NHJA/IhDL7BmzBZ
         U0n9TAhz4hyfLpbbvzG0+O3OokWKTGwwJvcNBheVWUpOShn+ySPrSnGM+pFC/Y1768
         sRS8PNvzj4jMJ8yhFiDtJdCoyQx33he/FEnzK++VpWwJq7E80I1pjZmd+SPO49xeN3
         +Yy/Ve6sflO2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BB44C5C13DC; Thu, 10 Nov 2022 23:45:38 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:45:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Dump memory object info if callback is invalid
Message-ID: <20221111074538.GS725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221105023519.147-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105023519.147-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 10:35:19AM +0800, Zhen Lei wrote:
> The callback rhp->func becomes NULL is usually caused by use-after-free.
> So the information about 'rhp' is very useful. Unfortunately, nothing is
> printed at the moment. Look at the panic output below, if no vmcore is
> generated, there is almost no way to analyze it except to know that the
> bug exists.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0
> ... ...
> PC is at 0x0
> LR is at rcu_do_batch+0x1c0/0x3b8
> ... ...
>  (rcu_do_batch) from (rcu_core+0x1d4/0x284)
>  (rcu_core) from (__do_softirq+0x24c/0x344)
>  (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
>  (__irq_exit_rcu) from (irq_exit+0x8/0x10)
>  (irq_exit) from (__handle_domain_irq+0x74/0x9c)
>  (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
>  (gic_handle_irq) from (__irq_svc+0x5c/0x94)
>  (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
>  (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
>  (default_idle_call) from (do_idle+0xf8/0x150)
>  (do_idle) from (cpu_startup_entry+0x18/0x20)
>  (cpu_startup_entry) from (0xc01530)
> 
> So add mem_dump_obj(rhp) to output some information, for example:
>   slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256
> 
> Now we know the size of the memory block and the offset of rcu_head. Then
> we can check the code. It's going to be slow and tiring, but it's better
> than no way to start.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

I have pulled this in with the usual wordsmithing (please check!)
for review and testing, thank you!

Questions include "Is 0x3 correct for functions compiled with all
supported compiler options on all architectures on which the Linux
kernel runs?", "Is this added information useful often enough for
this to be pushed to mainline?", and so on.

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h      | 7 +++++++
>  kernel/rcu/srcutiny.c | 1 +
>  kernel/rcu/srcutree.c | 1 +
>  kernel/rcu/tasks.h    | 1 +
>  kernel/rcu/tiny.c     | 1 +
>  kernel/rcu/tree.c     | 1 +
>  6 files changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 70c79adfdc7046c..4844dec36bddb48 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -10,6 +10,7 @@
>  #ifndef __LINUX_RCU_H
>  #define __LINUX_RCU_H
>  
> +#include <linux/mm.h>
>  #include <trace/events/rcu.h>
>  
>  /*
> @@ -211,6 +212,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
>  }
>  #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>  
> +static inline void debug_rcu_head_callback(struct rcu_head *rhp)
> +{
> +	if (unlikely(!rhp->func || (unsigned long)rhp->func & 0x3))
> +		mem_dump_obj(rhp);
> +}
> +
>  extern int rcu_cpu_stall_suppress_at_boot;
>  
>  static inline bool rcu_stall_is_suppressed_at_boot(void)
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 33adafdad261389..5e7f336baa06ae0 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
>  	while (lh) {
>  		rhp = lh;
>  		lh = lh->next;
> +		debug_rcu_head_callback(rhp);
>  		local_bh_disable();
>  		rhp->func(rhp);
>  		local_bh_enable();
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index ca4b5dcec675bac..294972e66b31863 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1631,6 +1631,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  	rhp = rcu_cblist_dequeue(&ready_cbs);
>  	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
>  		debug_rcu_head_unqueue(rhp);
> +		debug_rcu_head_callback(rhp);
>  		local_bh_disable();
>  		rhp->func(rhp);
>  		local_bh_enable();
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index b0b885e071fa8dc..b7f8c67c586cdc4 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -478,6 +478,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>  	len = rcl.len;
>  	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> +		debug_rcu_head_callback(rhp);
>  		local_bh_disable();
>  		rhp->func(rhp);
>  		local_bh_enable();
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index bb8f7d270f01747..56e9a5d91d97ec5 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>  
>  	trace_rcu_invoke_callback("", head);
>  	f = head->func;
> +	debug_rcu_head_callback(head);
>  	WRITE_ONCE(head->func, (rcu_callback_t)0L);
>  	f(head);
>  	rcu_lock_release(&rcu_callback_map);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 93c286b98c8f03d..3b93b9df8042a84 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2256,6 +2256,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  		trace_rcu_invoke_callback(rcu_state.name, rhp);
>  
>  		f = rhp->func;
> +		debug_rcu_head_callback(rhp);
>  		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
>  		f(rhp);
>  
> -- 
> 2.25.1
> 
