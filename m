Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23594670C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjAQWxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAQWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:52:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A74DCD7;
        Tue, 17 Jan 2023 13:40:15 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673991592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MGlhxDfvMswyv1SvAr4PTIZoEWhp6ukErC3lnvtfzms=;
        b=WCrx1f1BxleMDIz8u0yeTbWlkiEiKEN122P+7xwcPwRYApnZsKV1L7CNPoYK9myJHRs+Y4
        pDyXg+Ki+0F5eGyXxqr9iMuHGNsqAXgYYBNmbh2B47lQQJTBGHsk+ahQKIpx386EeT0UIA
        UHvdcGsnWrvn4lq605gpRNzK+0UTQzwGFe4lOzBs7fcxIjFnPjFrLuMUu6w+EWSPFjT0K2
        omrVWTQ85N3CKAu2PX6dYrQn8R/C8LbwpTqI4OnC18PBbPi6PJP0UCmScHk/5uatomXpiC
        mnlpFyjwlFt+B41gfzJuveVNkzsAMukT7zWeOtC8AJXTxr3rl8dq0OXR7/5E2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673991592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MGlhxDfvMswyv1SvAr4PTIZoEWhp6ukErC3lnvtfzms=;
        b=N6LgIkMUYxa6WRP/QzNw6ztcv7ZBHwqm2zHX/j2/UL0W2IqnlpbLf0d4Yx1U6dZcAdnhk4
        yL+zZjZdkX1kfsBg==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 09/19] irqdomain: Fix mapping-creation race
In-Reply-To: <20230116135044.14998-10-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-10-johan+linaro@kernel.org>
Date:   Tue, 17 Jan 2023 22:39:51 +0100
Message-ID: <87sfg8kfh4.ffs@tglx>
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

On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:

> Parallel probing (e.g. due to asynchronous probing) of devices that share
> interrupts can currently result in two mappings for the same hardware
> interrupt to be created.

This lacks an explanation why this can happen.

> @@ -802,6 +811,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
>  		type &= IRQ_TYPE_SENSE_MASK;
>  
> +	mutex_lock(&irq_domain_mutex);
> +
>  	/*
>  	 * If we've already configured this interrupt,
>  	 * don't do it again, or hell will break loose.
> @@ -814,7 +825,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  		 * interrupt number.
>  		 */
>  		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
> -			return virq;
> +			goto out;
>  
>  		/*
>  		 * If the trigger type has not been set yet, then set
> @@ -823,36 +834,43 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
>  			irq_data = irq_get_irq_data(virq);
>  			if (!irq_data)
> -				return 0;
> +				goto err;
>  
>  			irqd_set_trigger_type(irq_data, type);
> -			return virq;
> +			goto out;
>  		}
>  
>  		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
>  			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
> -		return 0;
> +		goto err;
>  	}
>  
>  	if (irq_domain_is_hierarchy(domain)) {
> -		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
> +		virq = ___irq_domain_alloc_irqs(domain, -1, 1, NUMA_NO_NODE,
> +						fwspec, false, NULL);
>  		if (virq <= 0)
> -			return 0;
> +			goto err;
>  	} else {
>  		/* Create mapping */
>  		virq = __irq_create_mapping_affinity(domain, hwirq, NULL);
>  		if (!virq)
> -			return virq;
> +			goto err;
>  	}
>  
>  	irq_data = irq_get_irq_data(virq);
>  	if (WARN_ON(!irq_data))
> -		return 0;
> +		goto err;
>  
>  	/* Store trigger type */
>  	irqd_set_trigger_type(irq_data, type);
> +out:
> +	mutex_unlock(&irq_domain_mutex);
>  
>  	return virq;
> +err:
> +	mutex_unlock(&irq_domain_mutex);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);

You can spare that goto churn by renaming the existing function to
irq_create_fwspec_mapping_locked() and invoked that guarded by the
mutex, no?

Thanks,

        tglx
