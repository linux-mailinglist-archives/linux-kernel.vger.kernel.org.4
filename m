Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC09691C04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjBJJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjBJJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:55:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB75F728A4;
        Fri, 10 Feb 2023 01:55:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3682D61D46;
        Fri, 10 Feb 2023 09:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306F4C433EF;
        Fri, 10 Feb 2023 09:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676022922;
        bh=1i9ZElDatR0OqMwUgiiOwJCcLUFMDfJa3A7e3mF2FQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGpZ07KDLLN52qEj1kKD0UP+JpHfcTFAWYCaQVHt/K03wZUO/TrWZe9hl9q7qOJ6e
         Z4oKct+9pdyGEnO+rlFY6gXwRALYsP4K8pA+47OjETFcpCkLUZDANUqKgpyKvjgFUE
         oSPaHGvH+MDEwVieN50WWPZaqLcyLfkhBkaQPFIlUZQnpdG3t5zVuzthBIJvuS0QJL
         nlW0n8294SAFr61SPmMWTM+HMY9qRLYgdj8rfd+zAGuI+dcE3vWoFlIm1pSh8cLvAx
         3fmCGqFpuvn/gROkZq8R2UZjf97aSjlcj6qVh7Y0rBH2UeLNLgNlJgSb/qC0WYJd9q
         ZinxqipP6thvw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pQQ8R-0005X7-Nb; Fri, 10 Feb 2023 10:56:03 +0100
Date:   Fri, 10 Feb 2023 10:56:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v5 19/19] irqdomain: Switch to per-domain locking
Message-ID: <Y+YUs6lzalneLyz7@hovoldconsulting.com>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
 <20230209132323.4599-20-johan+linaro@kernel.org>
 <86cz6izv48.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cz6izv48.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 04:00:55PM +0000, Marc Zyngier wrote:
> On Thu, 09 Feb 2023 13:23:23 +0000,
> Johan Hovold <johan+linaro@kernel.org> wrote:
> > 
> > The IRQ domain structures are currently protected by the global
> > irq_domain_mutex. Switch to using more fine-grained per-domain locking,
> > which can speed up parallel probing by reducing lock contention.
> > 
> > On a recent arm64 laptop, the total time spent waiting for the locks
> > during boot drops from 160 to 40 ms on average, while the maximum
> > aggregate wait time drops from 550 to 90 ms over ten runs for example.
> > 
> > Note that the domain lock of the root domain (innermost domain) must be
> > used for hierarchical domains. For non-hierarchical domains (as for root
> > domains), the new root pointer is set to the domain itself so that
> > domain->root->mutex can be used in shared code paths.
> > 
> > Also note that hierarchical domains should be constructed using
> > irq_domain_create_hierarchy() (or irq_domain_add_hierarchy()) to avoid
> > poking at irqdomain internals. As a safeguard, the lockdep assertion in
> > irq_domain_set_mapping() will catch any offenders that fail to set the
> > root domain pointer.
> > 
> > Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  include/linux/irqdomain.h |  4 +++
> >  kernel/irq/irqdomain.c    | 61 +++++++++++++++++++++++++--------------
> >  2 files changed, 44 insertions(+), 21 deletions(-)
> > 
> > diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> > index 16399de00b48..cad47737a052 100644
> > --- a/include/linux/irqdomain.h
> > +++ b/include/linux/irqdomain.h
> > @@ -125,6 +125,8 @@ struct irq_domain_chip_generic;
> >   *		core code.
> >   * @flags:	Per irq_domain flags
> >   * @mapcount:	The number of mapped interrupts
> > + * @mutex:	Domain lock, hierarhical domains use root domain's lock
> 
> nit: hierarchical
> 
> > + * @root:	Pointer to root domain, or containing structure if non-hierarchical

> > @@ -226,6 +226,17 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
> >  
> >  	domain->revmap_size = size;
> >  
> > +	/*
> > +	 * Hierarchical domains use the domain lock of the root domain
> > +	 * (innermost domain).
> > +	 *
> > +	 * For non-hierarchical domains (as for root domains), the root
> > +	 * pointer is set to the domain itself so that domain->root->mutex
> > +	 * can be used in shared code paths.
> > +	 */
> > +	mutex_init(&domain->mutex);
> > +	domain->root = domain;
> > +
> >  	irq_domain_check_hierarchy(domain);
> >  
> >  	mutex_lock(&irq_domain_mutex);

> > @@ -518,7 +529,11 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
> >  				   irq_hw_number_t hwirq,
> >  				   struct irq_data *irq_data)
> >  {
> > -	lockdep_assert_held(&irq_domain_mutex);
> > +	/*
> > +	 * This also makes sure that all domains point to the same root when
> > +	 * called from irq_domain_insert_irq() for each domain in a hierarchy.
> > +	 */
> > +	lockdep_assert_held(&domain->root->mutex);
> >  
> >  	if (irq_domain_is_nomap(domain))
> >  		return;
> > @@ -540,7 +555,7 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
> >  
> >  	hwirq = irq_data->hwirq;
> >  
> > -	mutex_lock(&irq_domain_mutex);
> > +	mutex_lock(&domain->mutex);
> 
> So you made that point about being able to uniformly using root>mutex,
> which I think is a good invariant. Yet you hardly make use of it. Why?

I went back and forth over that a bit, but decided to only use
domain->root->mutex in paths that can be called for hierarchical
domains (i.e. the "shared code paths" mentioned above).

Using it in paths that are clearly only called for non-hierarchical
domains where domain->root == domain felt a bit lazy.

The counter argument is of course that using domain->root->lock allows
people to think less about the code they are changing, but that's not
necessarily always a good thing.

Also note that the lockdep asserts in the revmap helpers would catch
anyone using domain->mutex where they should not (i.e. using
domain->mutex for an hierarchical domain).

> >  	irq_set_status_flags(irq, IRQ_NOREQUEST);
> >  
> > @@ -562,7 +577,7 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
> >  	/* Clear reverse map for this hwirq */
> >  	irq_domain_clear_mapping(domain, hwirq);
> >  
> > -	mutex_unlock(&irq_domain_mutex);
> > +	mutex_unlock(&domain->mutex);
> >  }
> >  
> >  static int irq_domain_associate_locked(struct irq_domain *domain, unsigned int virq,
> > @@ -612,9 +627,9 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
> >  {
> >  	int ret;
> >  
> > -	mutex_lock(&irq_domain_mutex);
> > +	mutex_lock(&domain->mutex);
> >  	ret = irq_domain_associate_locked(domain, virq, hwirq);
> > -	mutex_unlock(&irq_domain_mutex);
> > +	mutex_unlock(&domain->mutex);
> >  
> >  	return ret;
> >  }
> > @@ -731,7 +746,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
> >  		return 0;
> >  	}
> >  
> > -	mutex_lock(&irq_domain_mutex);
> > +	mutex_lock(&domain->mutex);
> >  
> >  	/* Check if mapping already exists */
> >  	virq = irq_find_mapping(domain, hwirq);
> > @@ -742,7 +757,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
> >  
> >  	virq = irq_create_mapping_affinity_locked(domain, hwirq, affinity);
> >  out:
> > -	mutex_unlock(&irq_domain_mutex);
> > +	mutex_unlock(&domain->mutex);
> >  
> >  	return virq;
> >  }
> > @@ -811,7 +826,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> >  	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
> >  		type &= IRQ_TYPE_SENSE_MASK;
> >  
> > -	mutex_lock(&irq_domain_mutex);
> > +	mutex_lock(&domain->root->mutex);
> >  
> >  	/*
> >  	 * If we've already configured this interrupt,
> > @@ -864,11 +879,11 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
> >  	/* Store trigger type */
> >  	irqd_set_trigger_type(irq_data, type);
> >  out:
> > -	mutex_unlock(&irq_domain_mutex);
> > +	mutex_unlock(&domain->root->mutex);
> >  
> >  	return virq;
> >  err:
> > -	mutex_unlock(&irq_domain_mutex);
> > +	mutex_unlock(&domain->root->mutex);
> >  
> >  	return 0;
> >  }
> > @@ -1132,6 +1147,7 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
> >  	else
> >  		domain = irq_domain_create_tree(fwnode, ops, host_data);
> >  	if (domain) {
> > +		domain->root = parent->root;
> >  		domain->parent = parent;
> >  		domain->flags |= flags;
> 
> So we still have a bug here, as we have published a domain that we
> keep updating. A parallel probing could find it in the interval and do
> something completely wrong.

Indeed we do, even if device links should make this harder to hit these
days.

> Splitting the work would help, as per the following patch.

Looks good to me. Do you want to submit that as a patch that I'll rebase
on or should I submit it as part of a v6?

Johan
