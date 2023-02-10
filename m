Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71F691F60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjBJM5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjBJM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:57:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B53D925;
        Fri, 10 Feb 2023 04:57:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8740EB82364;
        Fri, 10 Feb 2023 12:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44405C433D2;
        Fri, 10 Feb 2023 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676033819;
        bh=1Vcqa1iCdDbfvxfUxGBiXpNM9JirYvElkN4exLpYZOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqcLuXFQ9nykzcFlr1OREL4e3g6mvAgH51Qg2WXcUnJ/XVz+VOsY9coDArD/g9EUi
         VQFHqPlsnzGBAKyVoxtNiCEVJtULNoEZM2v8MBBRHcfOmFSXYnZl+Ez17yKgUEWHfo
         NkV8fOdEXRRG42SAIMeq0M2H5tQJsgmRhIolMXMiwvGQGJcQ/GnxSTAimRrohZClKu
         TWiwh1PLklHkH1xEI4Z5/Z6/2pk4QRHI/R466pbIVMEK3iIZRrByFIOx1238GQi01S
         c4W9vSLmnA900pebzji66AppOJNwjXsGK1NuseVcP5BW0OosT94BoJLJxX/EhA84/0
         DCbuhUv93/S3w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pQSyC-0001mH-RL; Fri, 10 Feb 2023 13:57:41 +0100
Date:   Fri, 10 Feb 2023 13:57:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v5 19/19] irqdomain: Switch to per-domain locking
Message-ID: <Y+Y/RDRPhgm0pLWk@hovoldconsulting.com>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
 <20230209132323.4599-20-johan+linaro@kernel.org>
 <86cz6izv48.wl-maz@kernel.org>
 <Y+YUs6lzalneLyz7@hovoldconsulting.com>
 <86bkm1zr59.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bkm1zr59.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:38:58AM +0000, Marc Zyngier wrote:
> On Fri, 10 Feb 2023 09:56:03 +0000,
> Johan Hovold <johan@kernel.org> wrote:
> > 
> > On Thu, Feb 09, 2023 at 04:00:55PM +0000, Marc Zyngier wrote:
> > > On Thu, 09 Feb 2023 13:23:23 +0000,
> > > Johan Hovold <johan+linaro@kernel.org> wrote:

> > I went back and forth over that a bit, but decided to only use
> > domain->root->mutex in paths that can be called for hierarchical
> > domains (i.e. the "shared code paths" mentioned above).
> > 
> > Using it in paths that are clearly only called for non-hierarchical
> > domains where domain->root == domain felt a bit lazy.
> 
> My concern here is that as this code gets further refactored, it may
> become much harder to reason about what is the correct level of
> locking.

Yeah, that's conceivable.

> > The counter argument is of course that using domain->root->lock allows
> > people to think less about the code they are changing, but that's not
> > necessarily always a good thing.
> 
> Eventually, non-hierarchical domains should simply die and be replaced
> with a single level hierarchy. Having a unified locking in place will
> definitely make the required work clearer.
> 
> > Also note that the lockdep asserts in the revmap helpers would catch
> > anyone using domain->mutex where they should not (i.e. using
> > domain->mutex for an hierarchical domain).
> 
> Lockdep is great, but lockdep is a runtime thing. It doesn't help
> reasoning about what gets locked when changing this code.

Contributers are expected to test their changes with lockdep enabled,
right?

But sure, using root->domain->mutex throughout may prevent prevent
people from getting this wrong.

I'll update this for v6.
 
> > > > @@ -1132,6 +1147,7 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
> > > >  	else
> > > >  		domain = irq_domain_create_tree(fwnode, ops, host_data);
> > > >  	if (domain) {
> > > > +		domain->root = parent->root;
> > > >  		domain->parent = parent;
> > > >  		domain->flags |= flags;
> > > 
> > > So we still have a bug here, as we have published a domain that we
> > > keep updating. A parallel probing could find it in the interval and do
> > > something completely wrong.
> > 
> > Indeed we do, even if device links should make this harder to hit these
> > days.
> > 
> > > Splitting the work would help, as per the following patch.
> > 
> > Looks good to me. Do you want to submit that as a patch that I'll rebase
> > on or should I submit it as part of a v6?
> 
> Just take it directly.

Ok, thanks.

I guess this turns the "Use irq_domain_create_hierarchy()" patches into
fixes that should be backported as well.

But note that your proposed diff may not be sufficient to prevent
lookups from racing with domain registration generally. Many drivers
still update the bus token after the domain has been added (and
apparently some still set flags also after creating hierarchies I just
noticed, e.g. amd_iommu_create_irq_domain).

It seems we'd need to expose a separate allocation and registration
interface, or at least pass in the bus token to a new combined
interface.

Johan
