Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38F61D8B1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKEIWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKEIV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:21:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822592C644;
        Sat,  5 Nov 2022 01:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00741B815BE;
        Sat,  5 Nov 2022 08:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458B8C433D6;
        Sat,  5 Nov 2022 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667636514;
        bh=B/n86Fu5nZ0M00dp4LuImX4DmzO0wAHJcu1Fk9hDp0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z0slTixcG9ka+pwYPB9PBhs92nXnj3XD+tFZkfvXQLQuTdmzwBL+lJye096IGx4OJ
         qbis+cFKr9DrZqCdQZEYmNClhdrTLFzwVk1mmX67gQ0fjPy4ZPELmWZ/1881G1f4RD
         Je+5ZhVQ7lcI1pty+wB29LT0qsGIUjH0CfzQ655o=
Date:   Sat, 5 Nov 2022 09:21:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/3] can: etas_es58x: use usb_cache_string() to
 retrieve the product info string
Message-ID: <Y2YdH4dd8u/eUEXg@kroah.com>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-3-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104171604.24052-3-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 02:16:03AM +0900, Vincent Mailhol wrote:
> Instead of allocating memory ourselves and doing all the error
> handling, rely on usb_cache_string(). This results in simpler code.
> 
> Make es58x_get_product_info() return void. The reason is double:
> 
>   1/ by using usb_cache_string() we do not know anymore the root cause
>      (is it an allocation issue or input/output issue?)
> 
>   2/ Failling to get the product info is not critical. So it is OK to
>      continue.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 33 +++------------------
>  drivers/net/can/usb/etas_es58x/es58x_core.h |  3 ++
>  2 files changed, 7 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index 51294b717040..1a17aadfc1dc 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -2124,41 +2124,18 @@ static void es58x_free_netdevs(struct es58x_device *es58x_dev)
>   * @es58x_dev: ES58X device.
>   *
>   * Do a synchronous call to get the product information.
> - *
> - * Return: zero on success, errno when any error occurs.
>   */
> -static int es58x_get_product_info(struct es58x_device *es58x_dev)
> +static void es58x_get_product_info(struct es58x_device *es58x_dev)
>  {
> -	struct usb_device *udev = es58x_dev->udev;
> -	const int es58x_prod_info_idx = 6;
> -	/* Empirical tests show a prod_info length of maximum 83,
> -	 * below should be more than enough.
> -	 */
> -	const size_t prod_info_len = 127;
>  	char *prod_info;
> -	int ret;
>  
> -	prod_info = kmalloc(prod_info_len, GFP_KERNEL);
> +	prod_info = usb_cache_string(es58x_dev->udev, ES58X_PROD_INFO_IDX);
>  	if (!prod_info)
> -		return -ENOMEM;
> +		return;
>  
> -	ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
> -	if (ret < 0) {
> -		dev_err(es58x_dev->dev,
> -			"%s: Could not read the product info: %pe\n",
> -			__func__, ERR_PTR(ret));
> -		goto out_free;
> -	}
> -	if (ret >= prod_info_len - 1) {
> -		dev_warn(es58x_dev->dev,
> -			 "%s: Buffer is too small, result might be truncated\n",
> -			 __func__);
> -	}
>  	dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);

Wait, why is this driver spamming the kernel log with this information
in the first place?  That should not be happening as when drivers work
properly, they are quiet.

Can you just delete this entirely?  Bonus is that device discovery is
now even faster as you drop the useless "get me the product string" USB
transactions.

And all of that info is in userspace today if userspace really wants it
(through libusb, usbutils, or just reading from a sysfs file.)  There is
no need to add this to individual drivers as well.

So no, please don't do this, just remove this code entirely.

Also note that the USB core can, and will, provide this info if the
kernel is configured to do so, just enable
CONFIG_USB_ANNOUNCE_NEW_DEVICES.  This should not be a per-driver thing
to do.

thanks,

greg k-h
