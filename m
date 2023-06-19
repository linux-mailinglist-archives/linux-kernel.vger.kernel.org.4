Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1C735D18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFSRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjFSRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:37:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D069D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:37:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687196223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aT8uw3JSbhUHnASOBYOMs/d52pMMrlBV/L6BcVUXgWs=;
        b=gY4wCXfSMajOhipTAeOlMv/Sou5w6MezHOFg6L3NbrChC5J2jYqop7FHtcRqEAI+UXobxZ
        Zz2XxY9CPXEZsgH7YvqaPvfhtUGgEyH3Av2Zj0xUIWERnBv9SI9WDCF3ikpgIZWi9MT+Fe
        xvZN6buwdVWT49+ZlRbTG2wjuTsSwOU2NW+AP2ChHMYOXZs6nH+3BEg3DsB6ZU8AMVQ8c8
        /E7sbb+AEqfgIt/CleiYUfI26IqK+BwXmGLq6QEefaAP68BXorWhB4BXsujz5ldTFSJ2jU
        /dYzc8gfS9lI0poCc8zvrKlNyOlL9gd8vuX8GpWQeDO0K2Br3hCNw31lFXTFwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687196223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aT8uw3JSbhUHnASOBYOMs/d52pMMrlBV/L6BcVUXgWs=;
        b=ukHKS+5T1sd2wxaKJvQij6FQlwrMmWe3ROd1b+PUi7xsmpOunsvlPSazn32NTCzuI5qBw8
        jzEok/DJl5aEO9Bg==
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] genirq: Fix nested thread vs synchronize_hardirq()
 deadlock
In-Reply-To: <20230613-genirq-nested-v1-1-289dc15b7669@axis.com>
References: <20230613-genirq-nested-v1-1-289dc15b7669@axis.com>
Date:   Mon, 19 Jun 2023 19:37:03 +0200
Message-ID: <87sfanpd4w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15 2023 at 15:11, Vincent Whitchurch wrote:
> There is a possibility of deadlock if synchronize_hardirq() is called
> when the nested threaded interrupt is active.  The following scenario
> was observed on a uniprocessor PREEMPT_NONE system:
>
>  Thread 1                      Thread 2
>
>  handle_nested_thread()
>   Set INPROGRESS
>   Call ->thread_fn()
>    thread_fn goes to sleep
>
>                               free_irq()
>                                __synchronize_hardirq()
>                                 Busy-loop forever waiting for INPROGRESS
>                                 to be cleared

Duh. Right! Nice find.

> Since the purpose of the INPROGRESS flag seems to be for hard IRQ

seems? Either it is or it is not.

It's really for hard interrupt handlers only and does not make sense for
the nested threaded case.

> handlers, remove its usage in the nested threaded interrupt case and
> instead re-use the active_threads mechanism to wait for nested threaded
> interrupts to complete.

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  kernel/irq/chip.c   | 5 +++--
>  kernel/irq/manage.c | 4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 49e7bc871fece..3e4b4c6de8195 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -476,7 +476,7 @@ void handle_nested_irq(unsigned int irq)
>  	}
>  
>  	kstat_incr_irqs_this_cpu(desc);
> -	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
> +	atomic_inc(&desc->threads_active);
>  	raw_spin_unlock_irq(&desc->lock);
>  
>  	action_ret = IRQ_NONE;
> @@ -487,7 +487,8 @@ void handle_nested_irq(unsigned int irq)
>  		note_interrupt(desc, action_ret);
>  
>  	raw_spin_lock_irq(&desc->lock);
> -	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
> +	if (atomic_dec_and_test(&desc->threads_active))
> +		wake_up(&desc->wait_for_threads);
>  
>  out_unlock:
>  	raw_spin_unlock_irq(&desc->lock);
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index d2742af0f0fd8..58dcc9df6d72c 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1977,6 +1977,10 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
>  		}
>  	}
>  
> +	/* Wait for any remaining nested threaded interrupts. */
> +	wait_event(desc->wait_for_threads,
> +		   !atomic_read(&desc->threads_active));

Which is together with the above _synchronize_hardirq(desc, true);
equivivalent to synchronize_irq(), no?

Thanks,

        tglx
