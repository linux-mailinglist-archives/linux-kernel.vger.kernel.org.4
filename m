Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965DB612CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ3VFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3VFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:05:06 -0400
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Oct 2022 14:05:00 PDT
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C2A6383
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=57sc1zEaPoN7h4A46eYO7m7OBIbwdsJSNErw2oMh2i8=;
        b=ExNOMhkVFJztTvZcxnvH3h4fqJbsQkgg+bLEfOuaDMvE1gWzf+x03ZVf9gCp8uwhCeU2x+q6nekWi
         UMfVN39ir3tiH2OPaGvcsXRDQvpmQKHK3UuTp6v916Hd3c9eu8BAnGCKfFv5bGKDF/P9k9eqMzKaz3
         YyNUCgEBiiyaZe6hupo2tczx7/snZxgERFISe14rqGEF3MLSehcW6uFvCTvTCzATO0Oq2qKub0zu+2
         134gYtd6AYTmNhA/UKp4zhT678Ud601D0/AsB+uxyLjz/ajF3SKPi0XNAMhnCQdcLYMKT3t0b+QQDh
         m5xZYu4P+05A45nJ0qf/BSXWMKcZ1Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=57sc1zEaPoN7h4A46eYO7m7OBIbwdsJSNErw2oMh2i8=;
        b=tZrknHN/AT+yPRxITfnWcQoHnGW6VCifdzIareCpE0Xor8DK2nixpgY3yVhJk7aPL6M6bl/Bkor4y
         vmrkmxMDQ==
X-HalOne-ID: 43a73db0-5894-11ed-bedf-1b2345786432
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 43a73db0-5894-11ed-bedf-1b2345786432;
        Sun, 30 Oct 2022 20:48:54 +0000 (UTC)
Date:   Sun, 30 Oct 2022 21:48:53 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     antoniospg <antoniospg100@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Adding support to control backlight using
 bl_power for nva3.
Message-ID: <Y17jNddKjZNk59EK@ravnborg.org>
References: <20221029184851.25340-1-antoniospg100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029184851.25340-1-antoniospg100@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 03:48:50PM -0300, antoniospg wrote:
> Test plan:
> 
> * Turn off:
> echo 1 > /sys/class/backlight/nv_backlight/bl_power
> 
> * Turn on:
> echo 0 > /sys/class/backlight/nv_backlight/bl_power
> 
> Signed-off-by: antoniospg <antoniospg100@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index a2141d3d9b1d..855d0ce9f7fa 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -263,7 +263,16 @@ nva3_set_intensity(struct backlight_device *bd)
>  	u32 div, val;
>  
>  	div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
> -	val = (bd->props.brightness * div) / 100;
> +
> +	switch (bd->props.power) {
> +	case FB_BLANK_UNBLANK:
> +		val = (bd->props.brightness * div) / 100;
> +		break;
> +	default:
> +		val = 0;
> +		break;
> +	}
> +

Consider the following change:

	val = backlight_get_brightness(bd);
	if (val)
		val = (val * dev) / 100;

Then you avoid hard coding the use of FB_BLANK_UNBLANK.

	Sam
