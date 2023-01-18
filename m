Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F049671E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjARNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjARNle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:41:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0995F3A3;
        Wed, 18 Jan 2023 05:10:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7A2BB81CE7;
        Wed, 18 Jan 2023 13:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E9AC433EF;
        Wed, 18 Jan 2023 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674047428;
        bh=bpt+30mxSsN1xvbBJxR1fwJPaqsxMgw/iJt4tPkYzhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cruAZgTocHVjYBxF7ep1BPvOCz4QmGEG4hoSm3zu3ZjDO+x61RKhVlCTOeBEXmBqg
         8OEDRR1M8PLakoU1RGjzEFszlft8+4XkYyiJdni3JEP/vu+EAcPElXTIa8iu9ErKhz
         6oc4d3+DNarDkUyxEsw4q0PupqLq6u7V/OOo7hS714SC/9ukuc+Eb5X9uDsvNaXEvh
         Xrr5FZegtAMYhuLVRS2S7Hq0Dkx//uqou4uYbiJ5hlWOL2XNn4yAFJsgmAOWSJWeQU
         9/yqL/QUS6IV5y/z2jOGIDQ1c5TCXJ3MzCrp0hT2oBbCKkZxOWodoo2QsYcfiUVTtT
         /dTRbJBGyggsQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI8DM-0006AH-He; Wed, 18 Jan 2023 14:10:53 +0100
Date:   Wed, 18 Jan 2023 14:10:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 06/19] irqdomain: Drop revmap mutex
Message-ID: <Y8fv3KWoxmaykrP6@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-7-johan+linaro@kernel.org>
 <871qnslut3.ffs@tglx>
 <Y8e6Us0Qgt0p5S4R@hovoldconsulting.com>
 <87r0vshu1y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0vshu1y.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:05:29PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 18 2023 at 10:22, Johan Hovold wrote:
> > On Tue, Jan 17, 2023 at 10:23:20PM +0100, Thomas Gleixner wrote:
> >> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> >> > The global irq_domain_mutex is now held in all paths that update the
> >> > revmap structures so there is no longer any need for the revmap mutex.
> >> 
> >> This can also go after the 3rd race fix, but ...
> >> 
> >> >  static void irq_domain_clear_mapping(struct irq_domain *domain,
> >> >  				     irq_hw_number_t hwirq)
> >> >  {
> >> > +	lockdep_assert_held(&irq_domain_mutex);
> >> 
> >> these lockdep asserts want to be part of the [dis]association race
> >> fixes. They are completely unrelated to the removal of the revmap_mutex.
> >
> > No, they are very much related to the removal of the revmap_mutex. These
> > functions deal with the revmap structures which before this patch were
> > clearly only modified with the revmap_mutex held.
> >
> > The lockdep assert is here to guarantee that my claim that all current
> > (and future) paths that end up modifying these structures do so under
> > the irq_domain_mutex instead.
> >
> >> Your race fixes change the locking and you want to ensure that all
> >> callers comply right there, no?
> >
> > I want to make sure that all callers of these function comply, yes.
> > That's why the asserts belong in this patch.
> 
> You can do this in a two step approach.
> 
>     1) Add the new locking and ensure that the lock is held when
>        the functions are called

But the new locking has nothing to do with these functions. They are
added because they fix various races elsewhere. Adding lockdep
assertions in unrelated function as part of those fixes doesn't really
make much sense.

>     2) Safely remove the revmap_mutex because you already established
>        that revmap is protected by some other means

I still think it belongs in this patch.

Johan
