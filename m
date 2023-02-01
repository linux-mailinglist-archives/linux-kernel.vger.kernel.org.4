Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03ED687045
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBAVEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBAVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:04:48 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 302A96B99B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:04:47 -0800 (PST)
Received: (qmail 503928 invoked by uid 1000); 1 Feb 2023 16:04:46 -0500
Date:   Wed, 1 Feb 2023 16:04:46 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT] USB UDC/gadget regression
Message-ID: <Y9rT7irH/d9vd5MQ@rowland.harvard.edu>
References: <20230201192022.GC2415@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201192022.GC2415@darkstar.musicnaut.iki.fi>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 09:20:22PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> After commit fc274c1e9973 ("USB: gadget: Add a new bus for gadgets"),
> g_ether started to crash on modprobe when used with OMAP UDC.
> 
> It seems that because of drv->bus getting set to NULL in the middle of
> bus_add_driver() things go wrong.
> 
> The below simple change seems to fix it, but I'm not sure if this is
> the correct way? Many drivers seem to be doing the same in UDC start -
> are they really all broken?

Gosh, yes... it's pretty surprising.  None of the UDC drivers should 
change driver->driver.bus.  I don't know why they ever did this; you 
would have expected that field to be NULL anyway before the fc274c1e9973 
commit because it would never get set to anything.

> diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
> index 6e9314e95be3..47d83bbb09e3 100644
> --- a/drivers/usb/gadget/udc/omap_udc.c
> +++ b/drivers/usb/gadget/udc/omap_udc.c
> @@ -2062,7 +2062,6 @@ static int omap_udc_start(struct usb_gadget *g,
>  	udc->softconnect = 1;
>  
>  	/* hook up the driver */
> -	driver->driver.bus = NULL;
>  	udc->driver = driver;
>  	spin_unlock_irqrestore(&udc->lock, flags);

If you would like to submit a patch fixing all the UDC drivers that do 
this, it would be great.

Alan Stern
