Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22196C6D47
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjCWQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjCWQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1DC1BF3;
        Thu, 23 Mar 2023 09:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B167B82163;
        Thu, 23 Mar 2023 16:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34DDC433EF;
        Thu, 23 Mar 2023 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679588430;
        bh=AEB4iYXvdpXySmCuzlr29CsberM1OefUWthPBaLij+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUgLsPngb6h7TU1QNWTTRp6yyCpXADPItOemKR8eowUC5xI7m9+oeBeTrafexT0ra
         kAFW+gBOlLrDC+vtEWrK+bGyRLWqnpOoKnH7+xBy+gdduF4iFD9isJ7laNSnQau6EY
         mb6k5Zmx1qVKkLgHHZ5WaB5Rc/W14YgBpWmoQ4rw=
Date:   Thu, 23 Mar 2023 17:20:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH] USB: gadget: udc: Fix use after free bug in
 udc_plat_remove due to race condition
Message-ID: <ZBx8S0tSz/Ot+xw7@kroah.com>
References: <20230310070039.1288927-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310070039.1288927-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:00:39PM +0800, Zheng Wang wrote:
> In udc_plat_probe, &udc->drd_work is bound with
> udc_drd_work. udc_drd_work may be called by
> usbd_connect_notify to start the work.
> 
> Besides, there is a invoking chain:
> udc_plat_probe
> ->udc_probe
> ->usb_add_gadget_udc_release
> ->usb_add_gadget
> 
> It will add a new gadget to the udc class driver
>  list. In usb_add_gadget, it uses usb_udc_release
>  as its release function, which will kfree(udc)
>  to when destroying the gadget.
> 
> If we remove the module which will call udc_plat_remove
>   to make cleanup, there may be a unfinished work.
> The possible sequence is as follows:
> 
> Fix it by finishing the work before cleanup in the udc_plat_remove
> 
> Fixes: 1b9f35adb0ff ("usb: gadget: udc: Add Synopsys UDC Platform driver")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/usb/gadget/udc/snps_udc_plat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
> index 8bbb89c80348..6228e178cc0a 100644
> --- a/drivers/usb/gadget/udc/snps_udc_plat.c
> +++ b/drivers/usb/gadget/udc/snps_udc_plat.c
> @@ -230,6 +230,7 @@ static int udc_plat_remove(struct platform_device *pdev)
>  	struct udc *dev;
>  
>  	dev = platform_get_drvdata(pdev);
> +	cancel_delayed_work_sync(&dev->drd_work);
>  
>  	usb_del_gadget_udc(&dev->gadget);
>  	/* gadget driver must not be registered */
> -- 
> 2.25.1
> 

Please test this to verify that it actually works.

thanks,

greg k-h
