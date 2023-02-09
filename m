Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761BA69096E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBIM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBIM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:59:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7E5ACF8;
        Thu,  9 Feb 2023 04:59:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16332CE1C71;
        Thu,  9 Feb 2023 12:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CD2C433D2;
        Thu,  9 Feb 2023 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675947582;
        bh=ueSbzbCgVSLYf9tlzKphbkF8Np2IEsOAlfnOzU+6UYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOc+j1ULKe63GU4YvUl0yQ8bwgBE+7iwrHHEvKuBw8MujB+tpgtKUBpHDPA1bPpSl
         SW3x9IMWqIraRRZLEPtbeNS28PM5edk7e7+Pk5pTra9igPlkodT8v1m0EYDmNNSXbi
         CHqcSozPpQainIemp1Vbh97AGqQWlzCxCi+Jy7pPjJdfYVjlwkvedW6YlQ33ZFJKGs
         LwLXGwN6FCmFPCovq+2ScjoWz/mDIY/HxX0yU7XthFXo2yf1HTjBZnuImZgwfcUB8f
         VvByTdpLcZfrHuwXlzvnLBId6YQaYSKVzd0CbpIqwrpYFMuGdZXnScG+aQ0mXLvcoa
         khCs8I7+tJEYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pQ6XE-0001F4-8c; Thu, 09 Feb 2023 14:00:21 +0100
Date:   Thu, 9 Feb 2023 14:00:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 07/19] irqdomain: Look for existing mapping only once
Message-ID: <Y+TuZDGwi6wfdFeK@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-8-johan+linaro@kernel.org>
 <87wn5kkfqo.ffs@tglx>
 <Y8e7OGlPXolkC1+R@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8e7OGlPXolkC1+R@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:26:16AM +0100, Johan Hovold wrote:
> On Tue, Jan 17, 2023 at 10:34:07PM +0100, Thomas Gleixner wrote:
> > On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> > > Avoid looking for an existing mapping twice when creating a new mapping
> > > using irq_create_fwspec_mapping() by factoring out the actual allocation
> > > which is shared with irq_create_mapping_affinity().
> > 
> > This changelog is incomplete and it took me a while to figure out why
> > this is before the race fix.
> > 
> > The point is that you need __irq_create_mapping_affinity() later to fix
> > the shared mapping race. The double check avoidance is just a nice side
> > effect.
> > 
> > So please spell it out and make it clear that this needs to be
> > backported too, e.g. by adding:
> > 
> > The split out internal function will be used to fix a shared interrupt
> > mapping race. This change is therefore tagged with the same fixes tag.
> > 
> > Fixes: ....
> 
> Sure. It was originally part of the fix of the race, but I was told to
> clean up the code first (and not worry about backporting).
> 
> I'll see what I can do about reordering these again with the aim of
> making things easier to backport.
> 
> > > +static unsigned int __irq_create_mapping_affinity(struct irq_domain *domain,
> > > +						  irq_hw_number_t hwirq,
> > > +						  const struct irq_affinity_desc *affinity)
> > 
> > Please rename to irq_create_mapping_affinity_locked() so it's clear what
> > this is about and what the calling convention is. A lockdep assert to
> > that effect would be nice too.
> 
> Will do.

Actually this cannot be done as part of this patch as the function is
still being called without the lock held until the actual
shared-interrupt mapping fix. I have a vague recollection that this was
part of the reason I went with the double underscore prefix.

I'll rename the function using a __locked suffix as part of the race
fix, but a lockdep assert feels like overkill here as this static
function is only in two places where the lock has just been taken (and
the asserts in the revmap helper will eventually catch any future
hypothetical offenders).

Johan
