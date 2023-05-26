Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9D671249B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbjEZK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjEZK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:27:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9FAFB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:27:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so6299445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685096831; x=1687688831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfIXJEMjywgbIaPnMejEqfeJlu29DLDhW+hRk8nBYC4=;
        b=WYZCFJVExeDVYp9MYxoWE58L9LDV10iEHG8v3I8k6jtl930DQwLlq7iZSV6CDtyHdD
         eQoA0t0VfzgWmxBKmXy9SX16Av1QD2N1bSTTCZMqaT6Uz+v+r+FTQhPURpRiSNdKsqiM
         IASMSZDBvGoLIsMDJwg8dCLsh0SulVWbLVni8bJ9S+dCOynjfEyvMiJsxO71uR3xHc/a
         eTz3FbvivrNbYU5oIziujcPbzvWnkd3RhLyVmuYOQLaORhPbmWOBaDpx4D+FxU5p+ig/
         SH0lnSMs+moJ7aH0ytEW+b6cRz2w4Vd5laCpLD9Fq1GFfIhGXa77qlBaKmEmxXmoWEcV
         BMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685096831; x=1687688831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfIXJEMjywgbIaPnMejEqfeJlu29DLDhW+hRk8nBYC4=;
        b=UOKiFSlxyy1GcN9qpI2ebMOJG4IZ7JZ7AX70ED5bPn1ujYJsxP4vjT80T8i8QQnsl5
         WxThxKkY28zfQslggMfLJHGSt02cmLD6VdC7egy+kGcG+oOEFlOUYFKaNnYEnuyGtS2e
         mvlYIBrpaVnRUNRKMcCZhByR8x7rzgVx5QpI8+YOcpLXbBAHT3z4Z9rgluE4bbEIy7wN
         40wCpUXKmbkxObsjPXwGfrIwEuEcVkhw3goJpEhRBjNvD96xKb/0ro5AaMyfCpxqDyzV
         BGX1MzT6e/xdMeG7kYSI5SswGiqDwGdn4vnvtmUFXH7EgmfqXwUeRv6uo4ntA7ONxW2E
         T/6Q==
X-Gm-Message-State: AC+VfDy5uwSmw9HDz/Bs9uBBskMnI928116bPjOkHF9kUcGtmjyrCJtW
        autJEeG2E7l97zZ9+trUXxBwiM+gB9z1gRXHHlJqXg==
X-Google-Smtp-Source: ACHHUZ6IzvKAf5IPmjt8K9b1nutegl78hAyGPJdoaYhRnE2oMuBVUeelQwu3T/SDLVPuKWVVJeKIcQ==
X-Received: by 2002:a05:600c:2042:b0:3f4:2e13:ccdc with SMTP id p2-20020a05600c204200b003f42e13ccdcmr1326649wmg.0.1685096831092;
        Fri, 26 May 2023 03:27:11 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id l22-20020a1c7916000000b003f607875e5csm8452340wme.24.2023.05.26.03.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:27:10 -0700 (PDT)
Date:   Fri, 26 May 2023 11:27:08 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, lee@kernel.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH 1/2] backlight: gpio_backlight: add new property
 default-brightness-level
Message-ID: <20230526102708.GC626291@aspen.lan>
References: <20230519200520.10657-1-alex@shruggie.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519200520.10657-1-alex@shruggie.ro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 11:05:19PM +0300, Alexandru Ardelean wrote:
> From: Yannick Fertre <yannick.fertre@foss.st.com>
>
> Add new property to set a brightness by default at probe.
>
> Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>

Patch order should be reversed for v2. Nevertheless:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
>  	int ret, init_brightness, def_value;
> +	u32 value;
>
>  	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
>  	if (gbl == NULL)
> @@ -93,7 +94,11 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	else
>  		bl->props.power = FB_BLANK_UNBLANK;
>
> -	bl->props.brightness = 1;
> +	ret = device_property_read_u32(dev, "default-brightness-level", &value);
> +	if (!ret && value <= props.max_brightness)
> +		bl->props.brightness = value;
> +	else
> +		bl->props.brightness = 1;
>
>  	init_brightness = backlight_get_brightness(bl);
>  	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
> --
> 2.40.1
>
