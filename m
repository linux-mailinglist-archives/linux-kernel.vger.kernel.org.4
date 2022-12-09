Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9E6484EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiLIPVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiLIPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:21:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07A89AE8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:21:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30478B82880
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 15:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6003AC433D2;
        Fri,  9 Dec 2022 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670599292;
        bh=t0lVAw719wJMGoW0vLiX6pAY3HGPB2w5ghH0QudCZrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXLMahT19SRzq5SXeqdOrCTLPVTCwVLYVO6bMvb5Mv723d57w3y3ktcTjhmObfktj
         yNlpFacLpzJve4Wu9akHnfQ/gl9P1bRd+tcfGLSxEZSaX9Vfh62UbZWK2rouiyaYNG
         Rajq2toj5NXdt9fWjBX5+72du79Vu26prbNJiaNY=
Date:   Fri, 9 Dec 2022 16:21:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] platform: Provide a remove callback that returns no value
Message-ID: <Y5NSevR9kb1UPvtQ@kroah.com>
References: <20221209150914.3557650-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221209150914.3557650-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 04:09:14PM +0100, Uwe Kleine-König wrote:
> struct platform_driver::remove returning an integer made driver authors
> expect that returning an error code was proper error handling. However
> the driver core ignores the error and continues to remove the device
> because there is nothing the core could do anyhow and reentering the
> remove callback again is only calling for trouble.
> 
> So this is an source for errors typically yielding resource leaks in the
> error path.
> 
> As there are too many platform drivers to neatly convert them all to
> return void in a single go, do it in several steps after this patch:
> 
>  a) Convert all drivers to implement .remove_new() returning void instead
>     of .remove() returning int;
>  b) Change struct platform_driver::remove() to return void and so make
>     it identical to .remove_new();
>  c) Change all drivers back to .remove() now with the better prototype;

Change c) seems like it will be just as much work as a), right?

>  d) drop struct platform_driver::remove_new().




> 
> While this touches all drivers eventually twice, steps a) and c) can be
> done one driver after another and so reduces coordination efforts
> immensely and simplifies review.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/base/platform.c         |  4 +++-
>  include/linux/platform_device.h | 11 +++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 968f3d71eeab..a4938d1c8fe1 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1416,7 +1416,9 @@ static void platform_remove(struct device *_dev)
>  	struct platform_driver *drv = to_platform_driver(_dev->driver);
>  	struct platform_device *dev = to_platform_device(_dev);
>  
> -	if (drv->remove) {
> +	if (drv->remove_new) {
> +		drv->remove_new(dev);
> +	} else if (drv->remove) {
>  		int ret = drv->remove(dev);
>  
>  		if (ret)
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index b0d5a253156e..b845fd83f429 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -207,7 +207,18 @@ extern void platform_device_put(struct platform_device *pdev);
>  
>  struct platform_driver {
>  	int (*probe)(struct platform_device *);
> +
> +	/*
> +	 * Traditionally the remove callback returned an int which however is
> +	 * ignored by the driver core. This led to wrong expectations by driver
> +	 * authors who thought returning an error code was a valid error
> +	 * handling strategy. To convert to a callback returning void, new
> +	 * drivers should implement .remove_new() until the conversion it done
> +	 * that eventually makes .remove() return void.
> +	 */
>  	int (*remove)(struct platform_device *);
> +	void (*remove_new)(struct platform_device *);
> +

Who is going to do the work of the conversion to this new prototype?
I'll be glad to take this, but I don't want to see a half-finished
conversion happen and us stuck with a "new" and "old" call, as that
would just be a mess.

thanks,

greg k-h
