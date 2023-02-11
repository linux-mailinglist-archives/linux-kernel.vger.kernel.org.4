Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3F969305B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBKLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBKLex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:34:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650CA1F5E8;
        Sat, 11 Feb 2023 03:34:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05F2AB8015B;
        Sat, 11 Feb 2023 11:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EFDC433D2;
        Sat, 11 Feb 2023 11:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676115288;
        bh=dhtusJGynXGgskXM92CDiaTl631kCSGdwtjk5C98K3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yef82oIpRDD2NsasPYaOgvr3WR+0uo7DOAZBQ6JL8CQST5/MoDeDCY45qMGkcgjU/
         N/UarZFbF6yJW+SRxbMQXcvrIm6/qqnimfHFcHRV0wTVgZUo4f1re3rj5ggDtqYghu
         JwBch+2MBCjxTCc6/LWatXrlKVv2zoSQqO/kRk8NvGWYG4/kMhJntF2HQF3Y7SNbeF
         k4p1XEKZRJWU2Vf4+H0wmdR4hebzahfL0RLGj2W5WmoOFycUJCprQg2B5UYgO+wlIa
         6uxslTKorD9PpXDHi9fUkCCW/0hZ+lWUo4yPZzAqaV6DwA6L95wvCf9VhG2x5b8NDa
         V+hA5B7/7bktg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pQoAG-0004iB-MA; Sat, 11 Feb 2023 12:35:33 +0100
Date:   Sat, 11 Feb 2023 12:35:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v5 19/19] irqdomain: Switch to per-domain locking
Message-ID: <Y+d9hM2yaBV1Tr2o@hovoldconsulting.com>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
 <20230209132323.4599-20-johan+linaro@kernel.org>
 <86cz6izv48.wl-maz@kernel.org>
 <Y+YUs6lzalneLyz7@hovoldconsulting.com>
 <86bkm1zr59.wl-maz@kernel.org>
 <Y+Y/RDRPhgm0pLWk@hovoldconsulting.com>
 <868rh5zhj6.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868rh5zhj6.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:06:37PM +0000, Marc Zyngier wrote:
> On Fri, 10 Feb 2023 12:57:40 +0000,
> Johan Hovold <johan@kernel.org> wrote:
> > 
> > On Fri, Feb 10, 2023 at 11:38:58AM +0000, Marc Zyngier wrote:
> > > On Fri, 10 Feb 2023 09:56:03 +0000,
> > > Johan Hovold <johan@kernel.org> wrote:
 
> > > > > > @@ -1132,6 +1147,7 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
> > > > > >  	else
> > > > > >  		domain = irq_domain_create_tree(fwnode, ops, host_data);
> > > > > >  	if (domain) {
> > > > > > +		domain->root = parent->root;
> > > > > >  		domain->parent = parent;
> > > > > >  		domain->flags |= flags;
> > > > > 
> > > > > So we still have a bug here, as we have published a domain that we
> > > > > keep updating. A parallel probing could find it in the interval and do
> > > > > something completely wrong.
> > > > 
> > > > Indeed we do, even if device links should make this harder to hit these
> > > > days.
> > > > 
> > > > > Splitting the work would help, as per the following patch.
> > > > 
> > > > Looks good to me. Do you want to submit that as a patch that I'll rebase
> > > > on or should I submit it as part of a v6?
> > > 
> > > Just take it directly.
> > 
> > Ok, thanks.

I've added a commit message and turned it into a patch to include in v6
now:

commit 3af395aa894c7df94ef2337e572e5e1710b4bbda (HEAD -> work)
Author: Marc Zyngier <maz@kernel.org>
Date:   Thu Feb 9 16:00:55 2023 +0000

    irqdomain: Fix domain registration race
    
    Hierarchical domains created using irq_domain_create_hierarchy() are
    currently added to the domain list before having been fully initialised.
    
    This specifically means that a racing allocation request might fail to
    allocate irq data for the inner domains of a hierarchy in case the
    parent domain pointer has not yet been set up.
    
    Note that this is not really any issue for irqchip drivers that are
    registered early via IRQCHIP_DECLARE() or IRQCHIP_ACPI_DECLARE(), but
    could potentially cause trouble with drivers that are registered later
    (e.g. when using IRQCHIP_PLATFORM_DRIVER_BEGIN(), gpiochip drivers,
    etc.).
    
    Fixes: afb7da83b9f4 ("irqdomain: Introduce helper function irq_domain_add_hierarchy()")
    Cc: stable@vger.kernel.org      # 3.19
    ...
    [ johan: add a commit message ]
    Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Could you just give your SoB for the diff here so I can credit you as
author?

> > I guess this turns the "Use irq_domain_create_hierarchy()" patches into
> > fixes that should be backported as well.
> 
> Maybe. Backports are not my immediate concern.

Turns out all of those drivers are registered early via
IRQCHIP_DECLARE() or IRQCHIP_ACPI_DECLARE() so there shouldn't really be
any risk of hitting this race for those.
 
> > But note that your proposed diff may not be sufficient to prevent
> > lookups from racing with domain registration generally. Many drivers
> > still update the bus token after the domain has been added (and
> > apparently some still set flags also after creating hierarchies I just
> > noticed, e.g. amd_iommu_create_irq_domain).
> 
> The bus token should only rarely be a problem, as it is often set on
> an intermediate level which isn't directly looked-up by anything else.
> And if it did happen, it would probably result in a the domain not
> being found.
> 
> Flags, on the other hand, are more problematic. But I consider this a
> driver bug which should be fixed independently.

I agree.
 
> > It seems we'd need to expose a separate allocation and registration
> > interface, or at least pass in the bus token to a new combined
> > interface.
> 
> Potentially, yes. But this could come later down the line. I'm more
> concerned in getting this series into -next, as the merge window is
> fast approaching.

I'll post a v6 first thing Monday if you can give me that SoB before
then.

Johan
