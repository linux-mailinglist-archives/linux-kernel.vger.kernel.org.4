Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E4690984
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBINH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBINH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:07:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE7E04F;
        Thu,  9 Feb 2023 05:07:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94A6161A46;
        Thu,  9 Feb 2023 13:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8DFC433EF;
        Thu,  9 Feb 2023 13:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675948045;
        bh=SpEERSHFmfgk88dtM6HPJS6HGSu329rEjBienFTWdo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cK/a2kA+P7wIJ8ME19ajuwu71EB/pUoKS7KAewCmkCKdaaqn+D1Z0oHQskqZMivPK
         Ufud3WRojlR8BgUzyXldn36Re0UpGcUvr0SONeJw5M07UikC3dIi2a2MHbMxus4XRC
         x8uAT/jWWc6fpGwjTjlIx8IliiGVv59ZqbCA73W4zX/ov9mwVLJnuw2xKQ0FtcFSp6
         HQYIG4NtPN+WWokTJO0ixnKgBSEde2otFNAkc6mcwWSXM6FUFb02aO1jLIQYClZLtg
         /R8XSd+K6S324HJHMYPHT7daJZJK0vy/NPm4IPVQqoXR4duRj9Xeo9TTankEC49UL3
         BHvAZ/jtXvXiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pQ6ei-0001IT-8s; Thu, 09 Feb 2023 14:08:04 +0100
Date:   Thu, 9 Feb 2023 14:08:04 +0100
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
Message-ID: <Y+TwNOYbeZxCE0c8@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-10-johan+linaro@kernel.org>
 <87sfg8kfh4.ffs@tglx>
 <Y8e+qfaC+ytx2LDv@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8e+qfaC+ytx2LDv@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:40:57AM +0100, Johan Hovold wrote:
> On Tue, Jan 17, 2023 at 10:39:51PM +0100, Thomas Gleixner wrote:
> > On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
 
> > > @@ -802,6 +811,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> > >  	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
> > >  		type &= IRQ_TYPE_SENSE_MASK;
> > >  
> > > +	mutex_lock(&irq_domain_mutex);
> > > +
> > >  	/*
> > >  	 * If we've already configured this interrupt,
> > >  	 * don't do it again, or hell will break loose.
> > > @@ -814,7 +825,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> > >  		 * interrupt number.
> > >  		 */
> > >  		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
> > > -			return virq;
> > > +			goto out;
> > >  
> > >  		/*
> > >  		 * If the trigger type has not been set yet, then set
> > > @@ -823,36 +834,43 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> > >  		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
> > >  			irq_data = irq_get_irq_data(virq);
> > >  			if (!irq_data)
> > > -				return 0;
> > > +				goto err;
> > >  
> > >  			irqd_set_trigger_type(irq_data, type);
> > > -			return virq;
> > > +			goto out;
> > >  		}
> > >  
> > >  		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
> > >  			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
> > > -		return 0;
> > > +		goto err;
> > >  	}
> > >  
> > >  	if (irq_domain_is_hierarchy(domain)) {
> > > -		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
> > > +		virq = ___irq_domain_alloc_irqs(domain, -1, 1, NUMA_NO_NODE,
> > > +						fwspec, false, NULL);
> > >  		if (virq <= 0)
> > > -			return 0;
> > > +			goto err;
> > >  	} else {
> > >  		/* Create mapping */
> > >  		virq = __irq_create_mapping_affinity(domain, hwirq, NULL);
> > >  		if (!virq)
> > > -			return virq;
> > > +			goto err;
> > >  	}
> > >  
> > >  	irq_data = irq_get_irq_data(virq);
> > >  	if (WARN_ON(!irq_data))
> > > -		return 0;
> > > +		goto err;
> > >  
> > >  	/* Store trigger type */
> > >  	irqd_set_trigger_type(irq_data, type);
> > > +out:
> > > +	mutex_unlock(&irq_domain_mutex);
> > >  
> > >  	return virq;
> > > +err:
> > > +	mutex_unlock(&irq_domain_mutex);
> > > +
> > > +	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
> > 
> > You can spare that goto churn by renaming the existing function to
> > irq_create_fwspec_mapping_locked() and invoked that guarded by the
> > mutex, no?
> 
> That may be possible, but I'm not sure it's better. It wasn't really
> obvious which of the above returns where error paths and which were
> success paths before this change.
> 
> I'll try and see what it would look like.

I gave it a try but the resulting diff is even bigger and also obscures
the reason for why the locking is there (i.e. that the lookup and and
creation needs to be done atomically).

Adding unlocked domain lookup helpers as a preparatory patch could
possible help somewhat with the diff size, but that doesn't really make
sense with the per-domain locking added by the final patch.

(I've made some experiments to quantify the parallel probe speed up that
using per-domain locks can result in so I'm including that for v5.)

Johan
