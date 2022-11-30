Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5781663DA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiK3P4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiK3Pzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:55:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8529D2CDC8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:55:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669823748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2KHy07QWrTX+1D9UzkoPb3Qm8ZT2RgqyB31qSopRt+I=;
        b=rhoDJ2/E9Fver/OeYrAtrubBBoQ8IUPrGQqV7czmlkmQ6puXksOACic9LjosjaJFNr1iJN
        InijpJpxUUiz/0IpYVXEs6dlLYEjR2umgM3H99nNJ2OUkKNYb3bIVK1JPW34BsVG30Q3kK
        C2unfDM/bv5QVCOCkk9oCJJuc7dJex1ldhPb94Noc9RC7pDsxv76SmzPOejIumEeKsbEdJ
        DsapN8Tc7gOwtbL+t+q6c9m5r6DiGjzBLRcEptCmngLPPOzvC8KtJ5oJG/GHZPyZIDZOeH
        odbAoebgS9S6AiHWmcfgzZOI/LtkZlm+U9M83pWeaXzAP83rAMij2xx1M187Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669823748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2KHy07QWrTX+1D9UzkoPb3Qm8ZT2RgqyB31qSopRt+I=;
        b=5DHbn8BCk3NSvj8IleFcJJWueUI6gaWiVaVhR6EmJHyWfCy5yZCJX1ug2mueOkTuuER/U/
        8tPnhf91HqIsG9BA==
To:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] genirq: Add support for oneshot-safe threaded EOIs
In-Reply-To: <20221126234134.32660-3-samuel@sholland.org>
References: <20221126234134.32660-1-samuel@sholland.org>
 <20221126234134.32660-3-samuel@sholland.org>
Date:   Wed, 30 Nov 2022 16:55:47 +0100
Message-ID: <877czctp18.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel!

On Sat, Nov 26 2022 at 17:41, Samuel Holland wrote:
> For irqchips such as the SiFive PLIC with a claim/EOI flow, each IRQ is
> implicitly masked during the claim operation and unmasked after the EOI.
> By delaying the EOI until after the thread runs, we can support threaded
> IRQs without any explicit mask/unmask operations.
>
> irqchips can declare this capability using the combination of flags
> IRQCHIP_ONESHOT_SAFE | IRQCHIP_EOI_THREADED.
>
> In this case, we still set IRQF_ONESHOT and thus action->thread_mask, so
> we know based on desc->threads_oneshot when to send the EOI. However, we
> do not set IRQS_ONESHOT, so we skip the actual mask/unmask operations.

Lots of 'we' here.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 672bad021a1f..7a4b3fa85da0 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -446,7 +446,9 @@ void unmask_threaded_irq(struct irq_desc *desc)
>  	if (chip->flags & IRQCHIP_EOI_THREADED)
>  		chip->irq_eoi(&desc->irq_data);
>  
> -	unmask_irq(desc);
> +	if (!irqd_irq_disabled(&desc->irq_data) &&
> +	    (desc->istate & IRQS_ONESHOT))
> +		unmask_irq(desc);
>
>  /*
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 40fe7806cc8c..b9edb66428cd 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1074,9 +1074,10 @@ static int irq_wait_for_interrupt(struct irqaction *action)
>  static void irq_finalize_oneshot(struct irq_desc *desc,
>  				 struct irqaction *action)
>  {
> -	if (!(desc->istate & IRQS_ONESHOT) ||
> +	if (!(action->flags & IRQF_ONESHOT) ||
>  	    action->handler == irq_forced_secondary_handler)
>  		return;
> +
>  again:
>  	chip_bus_lock(desc);
>  	raw_spin_lock_irq(&desc->lock);
> @@ -1112,8 +1113,7 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
>  
>  	desc->threads_oneshot &= ~action->thread_mask;
>  
> -	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&

Same undocumented change vs. disabled and EOI. It might not matter, but
if something like this is changed, then it has to be done in a separate
commit with a very good explanation why this is correct and not silently
burried into a hodgepodge of other changes.

> -	    irqd_irq_masked(&desc->irq_data))
> +	if (!desc->threads_oneshot)
>  		unmask_threaded_irq(desc);
>  
>  out_unlock:
> @@ -1565,8 +1565,12 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  	 * MSI based interrupts are per se one shot safe. Check the
>  	 * chip flags, so we can avoid the unmask dance at the end of
>  	 * the threaded handler for those.
> +	 *
> +	 * If IRQCHIP_EOI_THREADED is also set, we do an EOI dance
> +	 * instead of a mask/unmask dance.
>  	 */
> -	if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
> +	if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE &&
> +	    !(desc->irq_data.chip->flags & IRQCHIP_EOI_THREADED))

This flag combination makes my head spin. 

>  		new->flags &= ~IRQF_ONESHOT;
>  
>  	/*
> @@ -1755,7 +1759,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  		if (noirqdebug)
>  			irq_settings_set_no_debug(desc);
>  
> -		if (new->flags & IRQF_ONESHOT)
> +		if (new->flags & IRQF_ONESHOT &&
> +		    !(desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE))
>  			desc->istate |= IRQS_ONESHOT;

And I really detest the resulting action to desc inconsistency:

> -	if (!(desc->istate & IRQS_ONESHOT) ||
> +	if (!(action->flags & IRQF_ONESHOT) ||

It's clever, but completely non-obvious.

So let's take a step back. You want to defer the EOI to the point where
the threaded handler finishes, but you dont want the mask/unmask
mechanism which is attached to IRQS_ONESHOT.

So instead of playing games with IRQS_ONESHOT and IRQF_ONESHOT and
creating something which cannot even be remotely followed, why not
having explicit and understandable flags for theses cases.

Something like the incomplete, uncompiled below. You get the idea,
right?

Thanks,

        tglx
---
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -656,23 +656,27 @@ void handle_level_irq(struct irq_desc *d
 }
 EXPORT_SYMBOL_GPL(handle_level_irq);
 
+static inline cond_mask_eoi_irq(struct irq_desc *desc)
+{
+	if (desc->istate & IRQS_UNMASK_EOI_THREAD)
+		mask_irq(desc);
+}
+
 static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 {
-	if (!(desc->istate & IRQS_ONESHOT)) {
-		chip->irq_eoi(&desc->irq_data);
-		return;
-	}
-	/*
-	 * We need to unmask in the following cases:
-	 * - Oneshot irq which did not wake the thread (caused by a
-	 *   spurious interrupt or a primary handler handling it
-	 *   completely).
-	 */
-	if (!irqd_irq_disabled(&desc->irq_data) &&
-	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot) {
-		chip->irq_eoi(&desc->irq_data);
-		unmask_irq(desc);
-	} else if (!(chip->flags & IRQCHIP_EOI_THREADED)) {
+	if (desc->istate & IRQS_UNMASK_EOI_THREAD) {
+		/*
+		 * We need to EOI and unmask when the primary handler
+		 * did not wake the thread due to a spurious interrupt or
+		 * the primary handler handling the interrupt completely.
+		 */
+		if (!irqd_irq_disabled(&desc->irq_data) &&
+		    irqd_irq_masked(&desc->irq_data) &&
+		    !desc->threads_oneshot) {
+			chip->irq_eoi(&desc->irq_data);
+			unmask_irq(desc);
+		}
+	} else if (!(desc->istate & IRQS_EOI_THREAD) || !desc->threads_oneshot) {
 		chip->irq_eoi(&desc->irq_data);
 	}
 }
@@ -708,8 +712,7 @@ void handle_fasteoi_irq(struct irq_desc
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	if (desc->istate & IRQS_ONESHOT)
-		mask_irq(desc);
+	cond_mask_eoi_irq(desc);
 
 	handle_irq_event(desc);
 
@@ -1219,8 +1222,7 @@ void handle_fasteoi_ack_irq(struct irq_d
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	if (desc->istate & IRQS_ONESHOT)
-		mask_irq(desc);
+	cond_mask_eoi_irq(desc);
 
 	/* Start handling the irq */
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
@@ -1266,16 +1268,14 @@ void handle_fasteoi_mask_irq(struct irq_
 	 */
 	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
 		desc->istate |= IRQS_PENDING;
-		mask_irq(desc);
 		goto out;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
-	if (desc->istate & IRQS_ONESHOT)
-		mask_irq(desc);
 
 	handle_irq_event(desc);
 
+	/* Needs more fixes ... */
 	cond_unmask_eoi_irq(desc, chip);
 
 	raw_spin_unlock(&desc->lock);
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -53,6 +53,8 @@ enum {
  * IRQS_SUSPENDED		- irq is suspended
  * IRQS_NMI			- irq line is used to deliver NMIs
  * IRQS_SYSFS			- descriptor has been added to sysfs
+ * IRQS_UNMASK_EOI_THREAD	- EOI and unmask is deferred to the threaded handler
+ * IRQS_EOI_THREAD		- EOI is deferred to the threaded handler
  */
 enum {
 	IRQS_AUTODETECT		= 0x00000001,
@@ -66,6 +68,8 @@ enum {
 	IRQS_TIMINGS		= 0x00001000,
 	IRQS_NMI		= 0x00002000,
 	IRQS_SYSFS		= 0x00004000,
+	IRQS_UNMASK_EOI_THREAD	= 0x00008000,
+	IRQS_EOI_THREAD		= 0x00010000,
 };
 
 #include "debug.h"


