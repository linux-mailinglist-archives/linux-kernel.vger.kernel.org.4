Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7605F47E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJDQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJDQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:47:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359B20BFB;
        Tue,  4 Oct 2022 09:47:29 -0700 (PDT)
Date:   Tue, 4 Oct 2022 18:47:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664902047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFLeaZNysEsn0UTLLCGuw736dT8SNd3jnhai8kQD4aE=;
        b=Csnvsvllv7H1sbQ5v8vMk+zY8ETUd8TKZyb8EKMnpm66M8N8B+xzsia/cuZFs84maqZtL+
        t6qH8RBzGQHZdlJdxzhfJSI0V6BRYuuekdTpEAPBsCFRvLg6MHeMMUF3P3lCh4nlOiyv78
        vZmEHTimmfLGf71VrcvTP3i1QyVUapY7a362CUMnvbAzQ3G+K8AQJdGlpD6mjapYIgxeT1
        OsQUVbgeVPOWa9mJYcuksC3LCqcaKSFVKqrVz7OoQhN/muFrKgf3J/JElL/Y9QxintMMJt
        dkDGcJSQUQRw/RYsYrJj+ZYGo61Lg53or7m9Yu4M0nkGogJZEabZm1HKsVG1oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664902047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFLeaZNysEsn0UTLLCGuw736dT8SNd3jnhai8kQD4aE=;
        b=7sjin08RaVatGszkKF7K7EMZAssiNXhWJvulNA2+NdiUDK0ahBM5jQeIHdXjpfgBMxA1CF
        9c4PWtiOcOOC4oCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] irq_work: Migrate the remaining work of the offline CPU
 on PREEMPT_RT
Message-ID: <Yzxjnhg0kcmSrnHf@linutronix.de>
References: <20220925104111.1454100-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220925104111.1454100-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-25 18:41:11 [+0800], Zqiang wrote:
> When CPU goes offline and invoke CPU_DYING callbacks, the
> smpcfd_dying_cpu() be invoked to flush the remaining irq_work of the
> offline CPU, for lazy irq_work, will wakeup per-CPU irq_work kthreads
> to invoke callbacks, but the irq_work kthreads are in TASK_PARKED
> state, will not get the actual wakeup, resulting in the remaining lazy
> irq_work not being executed.
> 
> This commit requeue remaining of lazy irq_work to online CPU.

At CPU_DYING the CPU runs with disabled interrupts so we can't invoke
the remaining callbacks directly. Migrating them to another CPU will
solve the problem but callbacks enqueued with irq_work_queue_on() will
then be invoked on the wrong CPU.

Is there a specific irq_work item that made you aware of this?

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  include/linux/irq_work.h |  1 +
>  kernel/cpu.c             |  1 +
>  kernel/irq_work.c        | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 8cd11a223260..900d9053a62d 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -66,6 +66,7 @@ void irq_work_sync(struct irq_work *work);
>  void irq_work_run(void);
>  bool irq_work_needs_cpu(void);
>  void irq_work_single(void *arg);
> +void irq_work_migrate(int cpu);
>  #else
>  static inline bool irq_work_needs_cpu(void) { return false; }
>  static inline void irq_work_run(void) { }
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bbad5e375d3b..70461b6d785d 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1075,6 +1075,7 @@ static int takedown_cpu(unsigned int cpu)
>  
>  	tick_cleanup_dead_cpu(cpu);
>  	rcutree_migrate_callbacks(cpu);
> +	irq_work_migrate(cpu);
>  	return 0;
>  }
>  
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 7afa40fe5cc4..bfa21468c2df 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -242,6 +242,26 @@ static void irq_work_run_list(struct llist_head *list)
>  		irq_work_single(work);
>  }
>  
> +void irq_work_migrate(int cpu)
> +{
> +	struct irq_work *work, *tmp;
> +	struct llist_node *llnode;
> +	struct llist_head *list = per_cpu_ptr(&lazy_list, cpu);
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return;
> +
> +	if (llist_empty(list))
> +		return;
> +
> +	llnode = llist_del_all(list);
> +	llist_for_each_entry_safe(work, tmp, llnode, node.llist) {
> +		atomic_set(&work->node.a_flags, 0);
> +		irq_work_queue(work);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(irq_work_migrate);
> +
>  /*
>   * hotplug calls this through:
>   *  hotplug_cfd() -> flush_smp_call_function_queue()
> -- 
> 2.25.1

Sebastian
