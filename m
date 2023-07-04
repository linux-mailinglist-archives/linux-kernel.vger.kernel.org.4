Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB017474B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGDPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjGDPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:03:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26D10CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:03:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31441bc0092so629528f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688482992; x=1691074992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcaXmJ0ZrICymslbk6PHQsJRg8vS8+RojA0LAwyT/zQ=;
        b=KouPo65iu0hK7fuVBBpGDmUPRt2tU/GtFDp4hNAhFyjGhVMSOnJO3v6UetUjJ/p6pN
         N8SQknxPbCQOi66PLf7HcR5rUk41b3iuIwxQxNbtNXOqNFljVaaYzrqHRE/72sEhfIPM
         w5BUNfb19B9J+TNm12rbC8YqvK+khMGgHMxXq+5vjRVdGA7cCtuuyJYHA1UuJuIIAI3M
         D5Afj5+LBOeCDk2+TNC53DYEYHk3VXgtWQqAM4rcOZgCWGp24zcOk7P9qUgsG7Bq/Cv3
         xIlgpdiKy+I3gRN7OOKSAThu3oVLP/QMr4VVZrdYJWu7zargCQEIZ25aCQ275/O3Njct
         wELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688482992; x=1691074992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcaXmJ0ZrICymslbk6PHQsJRg8vS8+RojA0LAwyT/zQ=;
        b=kGDzvXe0y9xwk/DhiTGZokYhkPUzQp1Y+AE5eOV9KUkGcfOkYR/VKNS5o3HEUiqLZY
         EDPR1pyzCRIOoznAanLG9byYsTupDVekcSxPaJTs5ZPbv35v7DlWEe7MZfYYVpRZ3wjK
         7VHk4pHoDO6SEivRJHyUVB4sLBaABhILtLGLj/Jq3ryhD9A7foQRzMraDVg0Jo7JuB02
         JvO0EWEl40wak/VljDVw4bn2wtLsWf9ibgNmBzCULyanF++eZrNvYwjPzdDFtNJu7MzC
         F0yuEBE0HiofZIlBUCZIX2g5vidsiWlVt8udqgoKDTJ9G9uuMdyGgaNSPgm6m2SGqttb
         zbzg==
X-Gm-Message-State: ABy/qLZ8SQqITicxkhBYe3cDIObsBCULbSzckwKwFniAxr8BI+jGyeCt
        pRVVCk0UszUL2Fdu056tAheRjTQMyi5/LzpqrooH5A==
X-Google-Smtp-Source: APBJJlFlpjmrGdYueJJZlk/MoDzzq+L7FJYJ5eNl3AHPcCI5YjZgfpfSpd50V3Uqhy3K7ai28M4Z/Q==
X-Received: by 2002:a5d:6850:0:b0:313:eb4d:6a0e with SMTP id o16-20020a5d6850000000b00313eb4d6a0emr11332569wrw.9.1688482992243;
        Tue, 04 Jul 2023 08:03:12 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d54c2000000b003142439c7bcsm11555831wrv.80.2023.07.04.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:03:11 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:03:10 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: fix initial power state
Message-ID: <20230704150310.GA385243@aspen.lan>
References: <20230704140750.25799-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704140750.25799-1-mans@mansr.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 03:07:50PM +0100, Mans Rullgard wrote:
> The condition for the initial power state based on the default
> brightness value is reversed.  Fix it.
>
> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/video/backlight/led_bl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index 3259292fda76..28e83618a296 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -200,8 +200,8 @@ static int led_bl_probe(struct platform_device *pdev)
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = priv->max_brightness;
>  	props.brightness = priv->default_brightness;
> -	props.power = (priv->default_brightness > 0) ? FB_BLANK_POWERDOWN :
> -		      FB_BLANK_UNBLANK;
> +	props.power = (priv->default_brightness > 0) ? FB_BLANK_UNBLANK :
> +		      FB_BLANK_POWERDOWN;

The logic was wrong before but I think will still be wrong after the
change too (e.g. the bogus logic is probably avoiding backlight flicker
in some use cases).

The logic here needs to be similar to what pwm_bl.c implements in
pwm_backlight_initial_power_state(). Whilst it might be better
to implement this in led_bl_get_leds() let me show what I mean
in code that fits in the current line:

	/*
	 * Activate the backlight if the LEDs are already lit *or*
	 * there is no phandle link (meaning the backlight power
	 * state cannot be synced with the display state).
	 */
	props.power = (active_at_boot || !dev->node->phandle) ?
			FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;

Note that active_at_boot is not the same as (priv->default_brightness > 0)
since the value read by led_bl_get_leds() can be clobbered when we
parse the properties.


Daniel.
