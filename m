Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4E6E7611
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjDSJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjDSJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:16:30 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20A4EF8;
        Wed, 19 Apr 2023 02:16:29 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzcv-3yyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4505:1fdc::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Q1Zsk15Tgz49Q4Z;
        Wed, 19 Apr 2023 12:16:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1681895786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2LY+RBYRhEfFEBxdIxnQuuY3qVdb+sRdne7QwMMnnbY=;
        b=S4smR7C3+XOFxbX2e1hJnQjC9NL6IVlTtM6cdG+XB+gcINhpjMRf1gb2P8BfbVw/T/g2rV
        DWFGjE717iapZ1/bCZBhVK99qAc9z2CcYbrU9x3JUIY1MpS2aX3HGWmRrEKrZBf7BkanK6
        eJMg55oOuz0gKxQR0FXnc2WkrNMl+oAJaH7tnkPcRjdUdbCIbDQpgslkUPCnnUrKtVxCzO
        VaSiNpUtsqmb1U5VaQQbyaJn8uyIUMsRLSaFukrt0YY50hA8SsJ+AkUF15mxvV9SawzjKK
        Bq0Pxp39lO5GqZllGlWM3+ida3yvkCyRE1riWmqSr1pWkhJ+Zqp9lVvy/XQuUg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1681895786; a=rsa-sha256;
        cv=none;
        b=N++s37r4siitRMm/FRTTXvgJcbbU5EFV69xOChn1O6qsRDNnuHL+mJAGwWWfjkwENArqeT
        5qZRTLeeX7Ixuo1RclnM4r8AzyP1rt1Rnae/OBbDvUcpAus7QBNKMp9u/OpZwx/fy3WSp6
        GRVarc9USP3VDQG/+8v20XIDaabX0gnNsY0IOfj25FY74GyFX6pvCNovSC75/cOa4pspt2
        WPq+kVBH+boY2w54bV5YHH5hBXzZF5ICodhImcR5tEzYeDGpfxMuLquC34aAcBtUL4b6/i
        GAdGFvTSqAyQkGnSv8SmSwD6YwZtlr6/X5Vg3vqHSoaF5CFtovr9vHsPuIiwgA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1681895786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2LY+RBYRhEfFEBxdIxnQuuY3qVdb+sRdne7QwMMnnbY=;
        b=TuKjyY+aRGHYx9IWVAEvefxTF21qU60kOPHGTH/DLHo5H+h9Xmm3cm0VAsgBz4vjvGCGi9
        0/SHC/W1Istg9pYfLVs0H6azCr0Zg1La/DBuV88FVI2f1VjwL/fkWvGnLjxGsE5j/fpbog
        TEbQpVCj03mcyPdX5QndwbXOWLq/rf6YfWybusILnWh8+5uqSfb4amxtmy7i/dJRNslcfn
        avC7pg2piCSIMZ2O2RjbrlZ7DXmOyiKSGwlSVyBoCfyMszugdyizaqU8YCeHsULkDt1Swy
        5MMVJXq8uRJID4q0jeIM0eKwDlEgU7uXOxXJf7KUR1LgVWod0eaYb0+Q2y5+dw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id AD76C634C91;
        Wed, 19 Apr 2023 12:12:48 +0300 (EEST)
Date:   Wed, 19 Apr 2023 12:12:48 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Subject: Re: [PATCH] uvc: Intel PID enabling UVC Metadata attributes
Message-ID: <ZD+wkCz+kiWAkH2e@valkosipuli.retiisi.eu>
References: <9001ccdec3e3234253cf2f93ea39745ed6f525f1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9001ccdec3e3234253cf2f93ea39745ed6f525f1.camel@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Sun, Jan 29, 2023 at 03:43:38PM +0200, Dmitry Perchanov wrote:
> Intel RealSense UVC cameras Metadata support.

Could you list the individual devices here, and what does this metadata
contain?

> 
> Co-developed-by: Yu MENG <yu1.meng@intel.com>
> Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 72 ++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e4bcb5011360..955f67d9a993 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3000,6 +3000,78 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D410/ASR depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0ad2,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D415/ASRC depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0ad3,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D430/AWG depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0ad4,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel Fallback USB2 Descriptor */

Which device uses this?

> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0ad6,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D435/AWGC depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0b07,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D435i depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0b3a,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D405 Depth Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0b5b,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D455 Depth Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0b5c,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
>  	/* Generic USB Video Class */
>  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
>  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },

-- 
Kind regards,

Sakari Ailus
