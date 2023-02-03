Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26E689730
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjBCKpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBCKpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:45:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3C4DE34;
        Fri,  3 Feb 2023 02:45:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C9FFB82911;
        Fri,  3 Feb 2023 10:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CBBC433EF;
        Fri,  3 Feb 2023 10:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675421134;
        bh=SuTJEMBQVNWW0UtXQvJqhKD+s4e//c7KXMNI8Q4O34Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hyyt9W04xaKg7rchWtQze8rvUrIjdOIcesKEd0Blet3yknX8Egp/TT4nEcnycyCX4
         KdfVLUwLcqYy8QuQv/yc4opy3hYcj3L6irucvuh0gpGTiE16FgGsVBccOAIWuub1wc
         bqJVq/l3NNbSCSYnnS3dEdbz7+UzI3JrwxOH7rK4=
Date:   Fri, 3 Feb 2023 11:45:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] goku_udc: Add check for NULL in goku_irq
Message-ID: <Y9zly1vrj9z4c1qT@kroah.com>
References: <20230203101828.14799-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203101828.14799-1-abelova@astralinux.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> 
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

How can this ever happen?  Can you trigger this somehow?  If not, I
don't think this is going to be possible (also what's up with printk
from an irq handler???)

Odds are, no one actually has this hardware anymore, right?

thanks,

greg k-h
