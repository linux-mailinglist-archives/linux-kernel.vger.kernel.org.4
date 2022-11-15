Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90A629A33
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKON2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiKON2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:28:15 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38801742B;
        Tue, 15 Nov 2022 05:28:14 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v3so13259533pgh.4;
        Tue, 15 Nov 2022 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDnTGPXbiNm6zj2g2lfuoOgHIS/mKdTIcYS5ODDQhN0=;
        b=IZM31JUNAUnPN8ywsJvYDfWRzgM3rYMxXwe9VbxpzoczUs9CejS3PeqLZdnIYzq1wB
         TwZmVVEFmBvQdX7JvtA+6JqT7XBBD5ueFFjEc1QwifInVbyXjB3AMp53Esc+WxpVftL9
         m5X26FBwJY4FkQ6EI0Bexj/rUTwU3zK0NhPo7IRJ20zOLscmBir+icovtVdbzrU71ezm
         Zi3kHeS4Kqe6au4cxCQ/kWg1Q08Ty3Ohyv4EMXWBaIe8TZnt9pEmZUuPUGnUSt/zCT7q
         bUASzBpWohvT5jRLmcJMgE/skcPdcveO2OVL7s836sZUKdOJfxj5ez5JGhSKqNtd2vTN
         +Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDnTGPXbiNm6zj2g2lfuoOgHIS/mKdTIcYS5ODDQhN0=;
        b=aUUhXUKfjhqJ9IqROIad3O3oGC4TRRj9Mjr54gP6fPopSj+dAVnUW4E1hYWRC9N2oS
         rxeMFFlPYcpmcOOGtIr2ge4v3hH65LYe2Bq+LhpJpwqnGYFhETiZPD6v2c0S5yG4fa7t
         F+IJ13zoy1y3AJOuZw4ACihoijq99qAysqLOtxbfbt4LPVg0ve1yjXM48nC9nFf2Kf0P
         swsurc89bDKWttlKWJWB77SbaBZq3TJJntW3wIG3WGIdJYXY3l61J6k+ACKmIzJNgB6C
         +y6EhOAJQqAgR6dFfPq+Q3gIms7GakoPJ0UVZIQMe1c6XWUKlqz7W4nXJehm8t+cGUAT
         Yf3w==
X-Gm-Message-State: ANoB5pkFABTXRR1jdE2i5i4Icane8K0cfjM3WrYMOOcC2+3E9tWyfOEr
        VEizurwi23Cls32nvShtrvE=
X-Google-Smtp-Source: AA0mqf4Y/3ch9qkD8DDhjGKMRkGfi9QznTy8MWijwOVsKAB0hsSRqvWD8XmyAR+/LYENpxjzMLFusg==
X-Received: by 2002:a62:506:0:b0:56d:4b31:c4d9 with SMTP id 6-20020a620506000000b0056d4b31c4d9mr18626216pff.44.1668518894253;
        Tue, 15 Nov 2022 05:28:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001868ed86a95sm9909550plg.174.2022.11.15.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:28:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Nov 2022 05:28:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
Message-ID: <20221115132811.GA4189373@roeck-us.net>
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
 <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:39:54PM +0000, Fabrizio Castro wrote:
> The setting for the RZ/V2M watchdog cannot be changed once
> the watchdog has been enabled, unless the IP gets reset.
> The current implementation of the restart callback assumes
> that the watchdog is not enabled, but that's not always the
> case, and it leads to longer than necessary reboot times if
> the watchdog is already running.
> 
> Always reset the RZ/V2M watchdog first, so that we can always
> restart quickly.
> 
> Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 974a4194a8fd..00438ceed17a 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -145,10 +145,10 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>  {
>  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>  
> -	clk_prepare_enable(priv->pclk);
> -	clk_prepare_enable(priv->osc_clk);
> -
>  	if (priv->devtype == WDT_RZG2L) {
> +		clk_prepare_enable(priv->pclk);
> +		clk_prepare_enable(priv->osc_clk);
> +
>  		/* Generate Reset (WDTRSTB) Signal on parity error */
>  		rzg2l_wdt_write(priv, 0, PECR);
>  
> @@ -157,6 +157,11 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>  	} else {
>  		/* RZ/V2M doesn't have parity error registers */
>  
> +		reset_control_reset(priv->rstc);
> +
> +		clk_prepare_enable(priv->pclk);
> +		clk_prepare_enable(priv->osc_clk);
> +
>  		wdev->timeout = 0;
>  
>  		/* Initialize time out */
> -- 
> 2.34.1
> 
