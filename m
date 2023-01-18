Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032BA671909
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjARKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjARKfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:35:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2BAC3824;
        Wed, 18 Jan 2023 01:40:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33457B81BA0;
        Wed, 18 Jan 2023 09:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95B9C433EF;
        Wed, 18 Jan 2023 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674034833;
        bh=tTHcg/z9T99BPI6eUaM75jLrRAUzs67xHkkXXR/GIsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=en2ki9TitjA9re2RPj4k2fvbiPi/ck3YT8R35kX3l0lXrNQQivGwFzrZXToiPbV3F
         8gxILssBC53HB4YA61N56jY8/OyLzuoZZfq5ZCZjXggI9uy8VZRJ3dZEB5SiyzTbnL
         g/afZldFS7UsN4MpeL63ER52kRKrRtv9UBXdqhoI9wxNu/GfSYJcpBbNpH96YGMBkU
         k090SA3FiMS6x7qkW0/EbdynvWVsBvVZgCZq3fnxB5gC7U4XTx/RRYfklgz3t0XKar
         MF4GzVa0pIqKRBvbNS5zCchyhCavvHK5JoGTdSXanfeeXjmynBREUHsq5LCR0Rmj4A
         6lO0XNVq92U0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI4wD-0001se-DC; Wed, 18 Jan 2023 10:40:58 +0100
Date:   Wed, 18 Jan 2023 10:40:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 09/19] irqdomain: Fix mapping-creation race
Message-ID: <Y8e+qfaC+ytx2LDv@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-10-johan+linaro@kernel.org>
 <87sfg8kfh4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfg8kfh4.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:39:51PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> 
> > Parallel probing (e.g. due to asynchronous probing) of devices that share
> > interrupts can currently result in two mappings for the same hardware
> > interrupt to be created.
> 
> This lacks an explanation why this can happen.

The explanation is there (parallel probing), but I can amend it with the
concrete example from the input subsystem if that's what you're after?

Or do you mean that the above doesn't say that the current locking is
incomplete? I believe that's covered by the next paragraph:

    Make sure to hold the irq_domain_mutex when creating mappings so that
    looking for an existing mapping before creating a new one is done
    atomically.
 
> > @@ -802,6 +811,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> >  	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
> >  		type &= IRQ_TYPE_SENSE_MASK;
> >  
> > +	mutex_lock(&irq_domain_mutex);
> > +
> >  	/*
> >  	 * If we've already configured this interrupt,
> >  	 * don't do it again, or hell will break loose.
> > @@ -814,7 +825,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> >  		 * interrupt number.
> >  		 */
> >  		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
> > -			return virq;
> > +			goto out;
> >  
> >  		/*
> >  		 * If the trigger type has not been set yet, then set
> > @@ -823,36 +834,43 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> >  		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
> >  			irq_data = irq_get_irq_data(virq);
> >  			if (!irq_data)
> > -				return 0;
> > +				goto err;
> >  
> >  			irqd_set_trigger_type(irq_data, type);
> > -			return virq;
> > +			goto out;
> >  		}
> >  
> >  		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
> >  			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
> > -		return 0;
> > +		goto err;
> >  	}
> >  
> >  	if (irq_domain_is_hierarchy(domain)) {
> > -		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
> > +		virq = ___irq_domain_alloc_irqs(domain, -1, 1, NUMA_NO_NODE,
> > +						fwspec, false, NULL);
> >  		if (virq <= 0)
> > -			return 0;
> > +			goto err;
> >  	} else {
> >  		/* Create mapping */
> >  		virq = __irq_create_mapping_affinity(domain, hwirq, NULL);
> >  		if (!virq)
> > -			return virq;
> > +			goto err;
> >  	}
> >  
> >  	irq_data = irq_get_irq_data(virq);
> >  	if (WARN_ON(!irq_data))
> > -		return 0;
> > +		goto err;
> >  
> >  	/* Store trigger type */
> >  	irqd_set_trigger_type(irq_data, type);
> > +out:
> > +	mutex_unlock(&irq_domain_mutex);
> >  
> >  	return virq;
> > +err:
> > +	mutex_unlock(&irq_domain_mutex);
> > +
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
> 
> You can spare that goto churn by renaming the existing function to
> irq_create_fwspec_mapping_locked() and invoked that guarded by the
> mutex, no?

That may be possible, but I'm not sure it's better. It wasn't really
obvious which of the above returns where error paths and which were
success paths before this change.

I'll try and see what it would look like.

Johan
