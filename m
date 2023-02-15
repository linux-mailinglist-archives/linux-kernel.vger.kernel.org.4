Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B075F697DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBONsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBONsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:48:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF02BF2E;
        Wed, 15 Feb 2023 05:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9788F61BC5;
        Wed, 15 Feb 2023 13:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B81C433D2;
        Wed, 15 Feb 2023 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676468928;
        bh=FzvkYPFoxRq+Z4v9Y8PUVdK4V34sY3UHMMFGmRaXddQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADp7m1Q4bYp7mRRdjkHUB5BmeDWxR/jpcLcUdwZ0JIQLgfQ2FHETCIFNwftmpEk+L
         oBEjxrj2zHfgWWr3amY42rmHd7+uYHuOqwF1NeIPAtqc4PU4GzHx+ezUDG6hOwo9qX
         mhh2qadjl3I+aCAv442px05C1tRdDQL+DGRLwOs4=
Date:   Wed, 15 Feb 2023 14:48:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCR0LXQu9C+0LLQsA==?= 
        <abelova@astralinux.ru>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] goku_udc: Add check for NULL in goku_irq
Message-ID: <Y+zivah57216KcuB@kroah.com>
References: <20230203101828.14799-1-abelova@astralinux.ru>
 <Y9zly1vrj9z4c1qT@kroah.com>
 <39993564-7310-a2e0-8139-14ccb9a03ba9@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39993564-7310-a2e0-8139-14ccb9a03ba9@astralinux.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 04:39:56PM +0300, Анастасия Белова wrote:
> 
> 03.02.2023 13:45, Greg Kroah-Hartman пишет:
> > On Fri, Feb 03, 2023 at 01:18:28PM +0300, Anastasia Belova wrote:
> > > Before dereferencing dev->driver check it for NULL.
> > > 
> > > If an interrupt handler is called after assigning
> > > NULL to dev->driver, but before resetting dev->int_enable,
> > > NULL-pointer will be dereferenced.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> > > ---
> > >   drivers/usb/gadget/udc/goku_udc.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
> > > index bdc56b24b5c9..896bba8b47f1 100644
> > > --- a/drivers/usb/gadget/udc/goku_udc.c
> > > +++ b/drivers/usb/gadget/udc/goku_udc.c
> > > @@ -1616,8 +1616,9 @@ static irqreturn_t goku_irq(int irq, void *_dev)
> > >   pm_next:
> > >   		if (stat & INT_USBRESET) {		/* hub reset done */
> > >   			ACK(INT_USBRESET);
> > > -			INFO(dev, "USB reset done, gadget %s\n",
> > > -				dev->driver->driver.name);
> > > +			if (dev->driver)
> > > +				INFO(dev, "USB reset done, gadget %s\n",
> > > +					dev->driver->driver.name);
> > How can this ever happen?  Can you trigger this somehow?  If not, I
> > don't think this is going to be possible (also what's up with printk
> > from an irq handler???)
> 
> Unfortunately, I can't find the way to trigger this at the moment.

Then the change should not be made.

> What about printk, should trace_printk be used instead?

Why?

> > Odds are, no one actually has this hardware anymore, right?
> 
> Despite of this, such vulnerability should be fixed because
> there is a possibility to exploit it.

How can this be "exploited" if it can not ever be triggered?

Also, this would cause a NULL dereference in an irq handler, how can you
"exploit" that?

Please only submit patches that actually do something.  It is getting
very hard to want to even review patches from this "project" based on
the recent submissions.

thanks,

greg k-h
