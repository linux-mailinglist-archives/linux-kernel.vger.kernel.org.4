Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049777437E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjF3JHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjF3JHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:07:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570371B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 02:07:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688116028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MniJm0LOoR4n97+3NWjQqbb60JTe1rhNqX48Esge7w=;
        b=01hO3O5aVOS6PKzikxNzT0X51bdL4JL59AwxouX7dpy7di6aSYK15WsXVq6P1lBzFuGr1m
        iqH6GO6bCgijAKC9tZA80I4E1NUzqkXf0jiLS7ddrrtQw5NApTmDl01E952aKXVdu4vOJx
        F0hwfVfoUXO9Xxo2UBvEGCPpNijYDQhTFz9/OQiEXDeVrRYl9LSamXoF/UOtwu3dmDahyE
        x2EtYwKh3mtu5Vvxaytpf7yCXkphV4ZIDQe2oKhMDld5l/FylRzoIBLXYVyBasu6DQKn5b
        Do4mWBusblWrH0G0BW3dmAtNIRDmm092yt+5dS0tffnQBfYJ69RLc/GthqIJnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688116028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MniJm0LOoR4n97+3NWjQqbb60JTe1rhNqX48Esge7w=;
        b=3kzU8tPzcs8Dsj1wCKngidLHm9jQSOl64WqEA2XWBl01pd0+B4wiCm/ryx+XU5JIM7S++d
        PS3kJUAtq33PzPCQ==
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2] genirq: Fix nested thread vs synchronize_hardirq()
 deadlock
In-Reply-To: <20230613-genirq-nested-v2-1-fd5114b1e90c@axis.com>
References: <20230613-genirq-nested-v2-1-fd5114b1e90c@axis.com>
Date:   Fri, 30 Jun 2023 11:07:08 +0200
Message-ID: <87leg1z5c3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20 2023 at 13:16, Vincent Whitchurch wrote:
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

This breaks on RT. The wakeup cannot be inside the raw spin-locked
region.

Also this is open coding wake_threads_waitq().
  
> +static void __synchronize_irq(struct irq_desc *desc)
> +{
> +	__synchronize_hardirq(desc, true);
> +	/*
> +	 * We made sure that no hardirq handler is
> +	 * running. Now verify that no threaded handlers are
> +	 * active.
> +	 */
> +	wait_event(desc->wait_for_threads,
> +		   !atomic_read(&desc->threads_active));

Splitting this out is fine. Not reformatting it not so much.

Thanks,

        tglx
