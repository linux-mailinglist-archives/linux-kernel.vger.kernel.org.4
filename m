Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0EB638629
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiKYJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiKYJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:26:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBCA2F389;
        Fri, 25 Nov 2022 01:26:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D572AB829D6;
        Fri, 25 Nov 2022 09:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8593BC433D6;
        Fri, 25 Nov 2022 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669368412;
        bh=YSonbZ7QfNMfE5I8Glcd7Yv/BljaLxFmKhSXX+sWi/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXbDJxKJSFqzTLxcjt1AA8s2heCNWrCSsypga6WKG0GeaZ0gSEgJl3JzhV89i6KCJ
         xMNgiKMfOkmSllGksu4ssV2PqYYIkRRuuMK1vXWO2aQbti0J/tr5oMBhu6eBlX7+sr
         w/odLeNp/0ofxDaQQdrWkUIfrY08I30pbI+vkOv0grV40NAOQnYU48BfxdkXlZMoXS
         4KriOSRpV4W47BKG3EZseEzpBt7PPutronPx1dd0DRs+m/L2r3yfzRo5e/Rw41mYhb
         6xZOw38mk+BnN9SKevowQQ9cwxql7OD+kelNt2hxwxr00Sn8rEJu8S1qmuxJ0pG1u2
         +QQkhDADi6fcQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyUyZ-0008Py-0b; Fri, 25 Nov 2022 10:26:27 +0100
Date:   Fri, 25 Nov 2022 10:26:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Duke Xin <duke_xinanwen@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jerry.meng@quectel.com,
        duke.xin@quectel.com
Subject: Re: [PATCH] USB: serial: option: add Quectel EM05-G modem
Message-ID: <Y4CKQ50Ao9HZ9mbW@hovoldconsulting.com>
References: <20221119094447.874770-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119094447.874770-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 05:44:47PM +0800, Duke Xin wrote:
> The EM05-G modem has 2 USB configurations that are configurable via the AT
> command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
> the following interfaces, respectively:
> 
> "RMNET" : AT + DIAG + NMEA + Modem + QMI
> "MBIM"  : MBIM + AT + DIAG + NMEA + Modem
> 
> The detailed description of the USB configuration for each mode as follows:

...

> Signed-off-by: Duke Xin <duke_xinanwen@163.com>
> ---

This looks much better, thanks!

In the future, when updating a patch you should include a changelog here
below the '---' line and the patch revision should be indicated in the
Subject prefix (e.g. this should have been "[PATCH v3]: USB: serial:
...").

>  drivers/usb/serial/option.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index c3b7f1d98e78..fc14df5033d8 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -254,6 +254,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_BG96			0x0296
>  #define QUECTEL_PRODUCT_EP06			0x0306
>  #define QUECTEL_PRODUCT_EM05G			0x030a
> +#define QUECTEL_PRODUCT_EM05G_SG		0x0311

These defines should be sorted by PID.

>  #define QUECTEL_PRODUCT_EM060K			0x030b
>  #define QUECTEL_PRODUCT_EM12			0x0512
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
> @@ -1160,6 +1161,8 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
>  	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G, 0xff),
>  	  .driver_info = RSVD(6) | ZLP },
> +	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_SG, 0xff),
> +	  .driver_info = RSVD(6) | ZLP },  

And you have some stray whitespace after the comma here, which would
have been picked up by scripts/checkpatch.pl which you should run on
your patches before submitting them.

>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },

I've fixed up the above nits (sort order and white space) and applied
this one for 6.2 now so you don't need to send a v4 this time.

Johan
