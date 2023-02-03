Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C674689C18
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjBCOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjBCOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:44:01 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6D051D7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:44:00 -0800 (PST)
Received: (qmail 562952 invoked by uid 1000); 3 Feb 2023 09:43:59 -0500
Date:   Fri, 3 Feb 2023 09:43:59 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] goku_udc: Add check for NULL in goku_irq
Message-ID: <Y90dr0zSxfpeteey@rowland.harvard.edu>
References: <20230203101828.14799-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203101828.14799-1-abelova@astralinux.ru>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 01:18:28PM +0300, Anastasia Belova wrote:
> Before dereferencing dev->driver check it for NULL.
> 
> If an interrupt handler is called after assigning
> NULL to dev->driver, but before resetting dev->int_enable,
> NULL-pointer will be dereferenced.

Wouldn't it be better just to set dev->driver to NULL _after_ resetting 
dev->int_enable?

Alan Stern

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/usb/gadget/udc/goku_udc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
> index bdc56b24b5c9..896bba8b47f1 100644
> --- a/drivers/usb/gadget/udc/goku_udc.c
> +++ b/drivers/usb/gadget/udc/goku_udc.c
> @@ -1616,8 +1616,9 @@ static irqreturn_t goku_irq(int irq, void *_dev)
>  pm_next:
>  		if (stat & INT_USBRESET) {		/* hub reset done */
>  			ACK(INT_USBRESET);
> -			INFO(dev, "USB reset done, gadget %s\n",
> -				dev->driver->driver.name);
> +			if (dev->driver)
> +				INFO(dev, "USB reset done, gadget %s\n",
> +					dev->driver->driver.name);
>  		}
>  		// and INT_ERR on some endpoint's crc/bitstuff/... problem
>  	}
> -- 
> 2.30.2
> 
