Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F3562BC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiKPLq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiKPLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:45:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21622264E;
        Wed, 16 Nov 2022 03:31:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAB26B81D17;
        Wed, 16 Nov 2022 11:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E9AC433C1;
        Wed, 16 Nov 2022 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668598264;
        bh=jMy+pbYoyh3Lnh03LWljYYbTRmgjdFA6MlxJlcf8gEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ytyQCtzg1QjgVVLm2nK5gZ94G3EReVcbLUOn15D9vJhdzUe16+haDrdCSuN8/Cy1g
         6iNBhHP+Shi7lRumkQ4/sI1wjcgc7ZCzHhFmUZYCH5Grh/XhG8+S2dvuqmpayFZ0kw
         N/pcc915C/mgKYmJ1tlBYj63zA5jySA9KpwRf498=
Date:   Wed, 16 Nov 2022 12:31:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duke Xin <duke_xinanwen@163.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jerry.meng@quectel.com,
        duke.xin@quectel.com
Subject: Re: [PATCH] USB: serial: option: add Quectel EM05-G modem
Message-ID: <Y3TJ9aDKXgssyKG9@kroah.com>
References: <20221116105554.329246-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116105554.329246-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 06:55:54PM +0800, Duke Xin wrote:
> The EM05-G modem has 2 USB configurations that are configurable via the AT
> command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
> the following interfaces, respectively:
> 
> "RMNET" : AT + DIAG + NMEA + Modem + QMI
> "MBIM"  : MBIM + AT + DIAG + NMEA + Modem
> 
> The detailed description of the USB configuration for each mode as follows:
> 
> RMNET Mode
> --------------
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0311 Rev= 3.18
> S:  Manufacturer=Quectel
> S:  Product=Quectel EM05-G
> C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> MBIM Mode
> --------------
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0311 Rev= 3.18
> S:  Manufacturer=Quectel
> S:  Product=Quectel EM05-G
> C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Duke Xin <duke_xinanwen@163.com>
> ---
>  drivers/usb/serial/option.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 2a0d8fc9af91..b740672be0cd 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -253,6 +253,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_BG96			0x0296
>  #define QUECTEL_PRODUCT_EP06			0x0306
>  #define QUECTEL_PRODUCT_EM05G			0x030a
> +#define QUECTEL_PRODUCT_EM05G_SG		0x0311
>  #define QUECTEL_PRODUCT_EM060K			0x030b
>  #define QUECTEL_PRODUCT_EM12			0x0512
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
> @@ -1151,6 +1152,8 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
>  	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G, 0xff),
>  	  .driver_info = RSVD(6) | ZLP },
> +	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_SG, 0xff),/* Quectel EM05G  smart gateway*/
> +	  .driver_info = RSVD(6) | ZLP },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
> @@ -2170,7 +2173,6 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x010a, 0xff) },			/* Fibocom MA510 (ECM mode) */
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
> -	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
