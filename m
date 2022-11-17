Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7257B62D60A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiKQJLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbiKQJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:11:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C343413E81;
        Thu, 17 Nov 2022 01:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rs9mPbZMWkmGpFMwZXAxzgJsIHnGFVekqWq8NHBYPaE=; b=R1R3c0H1DMOPHL2EgzaQiKmWc6
        4g7vKNmWUZA3OnVQZ/791nS7MV15HGuXYR4LWct/zjRRgTK+dNnL85b46VmpoobJ+EHG/3iX5n7IA
        +equo9lBjaJUg3gTG+mevrb7K9jv6FfkkHfl2p47Rs0cy6NoLBkr9vyQZjccWCdTguIbSq3W8L+M+
        g5vZQ/0UzVMiD70Ih/xvhFHjAJMHV/ca+Xik2nReUKV0TeWwkr909DO60dbGyjqIg2jCR8xKkeWGW
        uwTyKLOnFvLCxPonjQNLfIhyogu3+VVn7IZf6T5ilF6RWcC9C3xOpf/z/mpnIIqLWzT4qucfdy49N
        D47XaqmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovavI-000qVG-8t; Thu, 17 Nov 2022 09:11:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C93830002E;
        Thu, 17 Nov 2022 10:10:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64B5420B670CB; Thu, 17 Nov 2022 10:10:57 +0100 (CET)
Date:   Thu, 17 Nov 2022 10:10:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH v2 5/8] irq_work: Trace self-IPIs sent via
 arch_irq_work_raise()
Message-ID: <Y3X6oQdySdXBh7v8@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-4-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-4-vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:33:33PM +0000, Valentin Schneider wrote:
> IPIs sent to remove CPUs via irq_work_queue_on() are now covered by
> trace_ipi_send_cpumask(), add another instance of the tracepoint to cover
> self-IPIs.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/irq_work.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 7afa40fe5cc43..aec38c294ce68 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -22,6 +22,8 @@
>  #include <asm/processor.h>
>  #include <linux/kasan.h>
>  
> +#include <trace/events/ipi.h>
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
>  static DEFINE_PER_CPU(struct task_struct *, irq_workd);
> @@ -74,6 +76,16 @@ void __weak arch_irq_work_raise(void)
>  	 */
>  }
>  
> +static inline void irq_work_raise(struct irq_work *work)

__always_inline, unless you want to occasionally only see it point to
__irq_work_queue_local().

> +{
> +	if (trace_ipi_send_cpumask_enabled() && arch_irq_work_has_interrupt()) {
> +		trace_ipi_send_cpumask(cpumask_of(smp_processor_id()),
> +				       _RET_IP_,
> +				       work->func);
	}
> +
> +	arch_irq_work_raise();
> +}
> +
>  /* Enqueue on current CPU, work must already be claimed and preempt disabled */
>  static void __irq_work_queue_local(struct irq_work *work)
>  {
> @@ -99,7 +111,7 @@ static void __irq_work_queue_local(struct irq_work *work)
>  
>  	/* If the work is "lazy", handle it from next tick if any */
>  	if (!lazy_work || tick_nohz_tick_stopped())
> -		arch_irq_work_raise();
> +		irq_work_raise(work);
>  }
>  
>  /* Enqueue the irq work @work on the current CPU */
> -- 
> 2.31.1
> 
