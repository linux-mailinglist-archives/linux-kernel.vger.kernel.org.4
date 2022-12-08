Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0068647980
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLHXMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHXMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:12:52 -0500
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0442C1DF28
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:12:49 -0800 (PST)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by a.peacevolution.org (Postfix) with ESMTPA id AEF457E1B3;
        Thu,  8 Dec 2022 23:12:47 +0000 (UTC)
Date:   Thu, 8 Dec 2022 18:12:45 -0500
From:   Aren <aren@peacevolution.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megi@xff.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: fix order of pek rise and fall events
Message-ID: <20221208231245.ldrkng64u4m2ty5w@xeez>
References: <20221123230741.2430813-1-aren@peacevolution.org>
 <834c5b42-1992-e444-fe7b-2c0a28d71f60@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834c5b42-1992-e444-fe7b-2c0a28d71f60@sholland.org>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
        s=dkim; t=1670541168;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
        bh=Fy8cTXNjNRRQI0sfMt45Glo1Qy4EM2e1D6nLN8jplC8=;
        b=iD/clXItNxDQBNAwiCWBuqmlLOMnJji+etaZOqZnYRFvnux/PeS9JGtlgpbI7dq5fG5hes
        m4qPHNnTYvpkwWVaWsNkRfNxVBXrr6byVlbt8/PR2U+BoRSdO3j1MLJ88l2BAPu4GCFIyy
        pPqh4k74Erb/oYY+xA7YieoOUzqvqcs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for taking a look at this

On Wed, Nov 30, 2022 at 12:43:15AM -0600, Samuel Holland wrote:
> On 11/23/22 17:07, Aren Moynihan wrote:
> > The power button can get "stuck" if the rising edge and falling edge irq
> > are read in the same pass. This can often be triggered when resuming
> > from suspend if the power button is released before the kernel handles
> > the interrupt.
> >
> > Swapping the order of the rise and fall events makes sure that the press
> > event is handled first, which prevents this situation.
>
> Indeed. This is probably the simplest solution, but I think it deserves
> a comment in at least one place that the order intentionally mismatches
> the order of the bits in the register.

Alright, I've sent a v2 with comments explaining the order
https://lore.kernel.org/lkml/20221208220225.635414-1-aren@peacevolution.org/T/

> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > ---
> >  include/linux/mfd/axp20x.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> > index 9ab0e2fca7ea..a13ba2bdd01f 100644
> > --- a/include/linux/mfd/axp20x.h
> > +++ b/include/linux/mfd/axp20x.h
> > @@ -432,8 +432,8 @@ enum {
> >  	AXP152_IRQ_PEK_SHORT,
> >  	AXP152_IRQ_PEK_LONG,
> >  	AXP152_IRQ_TIMER,
> > -	AXP152_IRQ_PEK_RIS_EDGE,
> >  	AXP152_IRQ_PEK_FAL_EDGE,
> > +	AXP152_IRQ_PEK_RIS_EDGE,
> >  	AXP152_IRQ_GPIO3_INPUT,
> >  	AXP152_IRQ_GPIO2_INPUT,
> >  	AXP152_IRQ_GPIO1_INPUT,
> > @@ -472,8 +472,8 @@ enum {
> >  	AXP20X_IRQ_LOW_PWR_LVL1,
> >  	AXP20X_IRQ_LOW_PWR_LVL2,
> >  	AXP20X_IRQ_TIMER,
> > -	AXP20X_IRQ_PEK_RIS_EDGE,
> >  	AXP20X_IRQ_PEK_FAL_EDGE,
> > +	AXP20X_IRQ_PEK_RIS_EDGE,
> >  	AXP20X_IRQ_GPIO3_INPUT,
> >  	AXP20X_IRQ_GPIO2_INPUT,
> >  	AXP20X_IRQ_GPIO1_INPUT,
> > @@ -502,8 +502,8 @@ enum axp22x_irqs {
> >  	AXP22X_IRQ_LOW_PWR_LVL1,
> >  	AXP22X_IRQ_LOW_PWR_LVL2,
> >  	AXP22X_IRQ_TIMER,
> > -	AXP22X_IRQ_PEK_RIS_EDGE,
> >  	AXP22X_IRQ_PEK_FAL_EDGE,
> > +	AXP22X_IRQ_PEK_RIS_EDGE,
> >  	AXP22X_IRQ_GPIO1_INPUT,
> >  	AXP22X_IRQ_GPIO0_INPUT,
> >  };
> > @@ -571,8 +571,8 @@ enum axp803_irqs {
> >  	AXP803_IRQ_LOW_PWR_LVL1,
> >  	AXP803_IRQ_LOW_PWR_LVL2,
> >  	AXP803_IRQ_TIMER,
> > -	AXP803_IRQ_PEK_RIS_EDGE,
> >  	AXP803_IRQ_PEK_FAL_EDGE,
> > +	AXP803_IRQ_PEK_RIS_EDGE,
> >  	AXP803_IRQ_PEK_SHORT,
> >  	AXP803_IRQ_PEK_LONG,
> >  	AXP803_IRQ_PEK_OVER_OFF,
> > @@ -623,8 +623,8 @@ enum axp809_irqs {
> >  	AXP809_IRQ_LOW_PWR_LVL1,
> >  	AXP809_IRQ_LOW_PWR_LVL2,
> >  	AXP809_IRQ_TIMER,
> > -	AXP809_IRQ_PEK_RIS_EDGE,
> >  	AXP809_IRQ_PEK_FAL_EDGE,
> > +	AXP809_IRQ_PEK_RIS_EDGE,
> >  	AXP809_IRQ_PEK_SHORT,
> >  	AXP809_IRQ_PEK_LONG,
> >  	AXP809_IRQ_PEK_OVER_OFF,
>
> You should also update APX288 and APX806, which name the IRQs "POK"
> instead of "PEK" for some reason.

Thanks for point this out, it looks like these are already in the
correct order.

 - Aren
