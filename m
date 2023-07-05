Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD57485AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGEOJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGEOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:09:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA801E57
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:09:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so66662135e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688566185; x=1691158185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Izz7ihe7+cPV8NfKfF0xuM/ZXdOZCR9uthmt7NZp1VA=;
        b=mTtlv8+nZvnL92HQWPsRJTB05DIhfhfELlpD2EDBYSb0MJ8tI/emN1nJKIUPn3cuRS
         YCejqc3xaIyC0bMfc+RPkAP2wAlvY1omsda8SNPbTMqUJto5GlROzx9GU2KHf6uT0sJx
         ILeRngMRHIlGAh9kx6durc/VMQ2hVoXyh9PnW2Olx3kSw3tn8fX7+zGo3oglw4+yvpgo
         Sw4tPXRd5TkSQhYBM9RUnONf1+OYgBAmRSzTpxh5IVdUpLlRXYfp+mlXYYijT0S62nNg
         SJ0BhOq4+vhv+xrdM/EOI/BcLpGDy9Zzzf5SYHOJan1XUkm2/NrfbmyYT0oNVX6k2nan
         9Apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688566185; x=1691158185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izz7ihe7+cPV8NfKfF0xuM/ZXdOZCR9uthmt7NZp1VA=;
        b=ZTQuz0ONrRNhXdUB6t+S/fTIHRoFrE2/+VJ24etnkXh5tAj8ZEndYabMdpPJphrnZY
         p+pw0p3yi4ebs+chqjcV/pAY8TYGbQqz8PmH8tjO0SShgiTHnUhWeTGRzNbJnZq/u/jt
         0AZiAQMzXxP3zC9c8dsVBNP/beUNJzO9Z2yVpBtNidq5dbb0IxDa8u1rxwd6uHhImsW2
         0Jz1okClwWzoCIF5mp1x6mffE4ov0D8TRV85/bXIXdxP1jmwXFqehAmysDMWphx3eyNm
         2kn+7q0VfzcPBusAW2mgc99t4K7HgeA0b9waabjTIW+XCSwehS7KOuNrThJM5JJDvl7D
         IGhQ==
X-Gm-Message-State: AC+VfDyK7I6mvOGrdl6qiLzhQepQlwQW3c5oLvdsEj8b6a+O270W1Yv0
        slyh3fKqvXuEhmFbgBku1TkIxA==
X-Google-Smtp-Source: ACHHUZ6IS2TiOtorETud8FSgZjhyqs6fHCpyhU040q30QB6W7Fho8aNZcui+S/8puhB0PsO+VzM0wQ==
X-Received: by 2002:a1c:7412:0:b0:3fa:98c3:7db6 with SMTP id p18-20020a1c7412000000b003fa98c37db6mr14857204wmc.38.1688566185061;
        Wed, 05 Jul 2023 07:09:45 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n23-20020a1c7217000000b003fae92e7a8dsm2244468wmc.27.2023.07.05.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:09:44 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:09:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: led_bl: fix initial power state
Message-ID: <20230705140943.GC6265@aspen.lan>
References: <20230704163013.21097-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704163013.21097-1-mans@mansr.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:19:52PM +0100, Mans Rullgard wrote:
> The condition for the initial power state based on the default
> brightness value is reversed.  Fix it.
>
> Furthermore, use the actual state of the LEDs rather than the default
> brightness specified in the devicetree as the latter should not cause
> the backlight to be automatically turned on.
>
> If the backlight device is not linked to any display, set the initial
> power to on unconditionally.
>
> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> Changes in v2:
> - Use the reported LED state to set initial power state
> - Always power on if no phandle in DT
> ---
>  drivers/video/backlight/led_bl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index 3259292fda76..bbf1673b1fb0 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -176,6 +176,7 @@ static int led_bl_probe(struct platform_device *pdev)
>  {
>  	struct backlight_properties props;
>  	struct led_bl_data *priv;
> +	int init_brightness;
>  	int ret, i;
>
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> @@ -190,6 +191,8 @@ static int led_bl_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	init_brightness = priv->default_brightness;
> +
>  	ret = led_bl_parse_levels(&pdev->dev, priv);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to parse DT data\n");
> @@ -200,8 +203,8 @@ static int led_bl_probe(struct platform_device *pdev)
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = priv->max_brightness;
>  	props.brightness = priv->default_brightness;
> -	props.power = (priv->default_brightness > 0) ? FB_BLANK_POWERDOWN :
> -		      FB_BLANK_UNBLANK;
> +	props.power = (init_brightness || !pdev->dev.of_node->phandle) ?
> +		FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;

I was rather expecting to see a comment in the code here... it's super
hard to figure out the purpose of the phandle check otherwise.


Daniel.
