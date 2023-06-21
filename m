Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095EB738A55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjFUQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjFUQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F41BD0;
        Wed, 21 Jun 2023 08:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB684615D1;
        Wed, 21 Jun 2023 15:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021D6C433C8;
        Wed, 21 Jun 2023 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687363161;
        bh=2Ze8HUxaIR1pjHExyMgnxzUkH8NIRpvWbQ5QDE3U2DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpql9chfrRr0qLA0W1y38ZTzwuOPlt1pVkiwfymxOZO24UyxVEPbs9L2ChpZdnF9H
         V+6u+lcdJs3gpNb3cWtAltPszahuzY0QExG6NF3+pSf3RxDCyMzZP/jBZNYyPaqrRQ
         Ufe7490JYMe1iff993VCRu+UV2266OhUibm08M4k=
Date:   Wed, 21 Jun 2023 17:59:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] usb: misc: onboard-hub: resort by VID and PID
Message-ID: <2023062136-subgroup-aground-01e2@gregkh>
References: <20230620-hx3-v1-0-3a649b34c85b@skidata.com>
 <20230620-hx3-v1-1-3a649b34c85b@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-hx3-v1-1-3a649b34c85b@skidata.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 12:38:00PM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Resort the existing entries by VID and then by PID to be able to find
> entries easier.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 12 ++++++------
>  drivers/usb/misc/onboard_usb_hub.h |  8 ++++----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index 12fc6eb67c3b..94006714c273 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -329,10 +329,10 @@ static struct platform_driver onboard_hub_driver = {
>  
>  /************************** USB driver **************************/
>  
> -#define VENDOR_ID_GENESYS	0x05e3
>  #define VENDOR_ID_MICROCHIP	0x0424
> -#define VENDOR_ID_REALTEK	0x0bda
>  #define VENDOR_ID_TI		0x0451
> +#define VENDOR_ID_GENESYS	0x05e3
> +#define VENDOR_ID_REALTEK	0x0bda
>  #define VENDOR_ID_VIA		0x2109

This is fine, but:

>  
>  /*
> @@ -407,16 +407,16 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
>  }
>  
>  static const struct usb_device_id onboard_hub_id_table[] = {
> -	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
> -	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
> +	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
> +	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
> +	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
> +	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
> -	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
> -	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 */
>  	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 */
>  	{}

This does nothing except make backports harder over time :(



> diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> index aca5f50eb0da..ff8925aa6d3a 100644
> --- a/drivers/usb/misc/onboard_usb_hub.h
> +++ b/drivers/usb/misc/onboard_usb_hub.h
> @@ -14,10 +14,6 @@ static const struct onboard_hub_pdata microchip_usb424_data = {
>  	.reset_us = 1,
>  };
>  
> -static const struct onboard_hub_pdata realtek_rts5411_data = {
> -	.reset_us = 0,
> -};
> -
>  static const struct onboard_hub_pdata ti_tusb8041_data = {
>  	.reset_us = 3000,
>  };
> @@ -30,6 +26,10 @@ static const struct onboard_hub_pdata genesys_gl852g_data = {
>  	.reset_us = 50,
>  };
>  
> +static const struct onboard_hub_pdata realtek_rts5411_data = {
> +	.reset_us = 0,
> +};

And this also does nothing to help really, so it's not needed, sorry.

thanks,

greg k-h
