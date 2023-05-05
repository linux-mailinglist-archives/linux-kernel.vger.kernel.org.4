Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BD36F886C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjEESI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjEESI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:08:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3353E1A1FD;
        Fri,  5 May 2023 11:08:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64115eef620so21468643b3a.1;
        Fri, 05 May 2023 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683310135; x=1685902135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jmjCmOGhJKcTExgQHxoFdrZdNhIimvrG1KlJ+O2CnA=;
        b=K0PiobN2K0CD1x/aK0LGxU/27Ndiiy3fP21rS2BmtRQcHEefRBzEKjTsRLJYEahi6T
         0p6efnM3dGeXACImp1TH/0sv7ROoQguhATGB15wUfaJqt6NnRkN4yS4tvwXkq6JfGvKb
         d6QPkljAU+BM2MzUZJLhEOlAA23YvvJKD6IPmyzANrbKlv6Vcsq1o67/Z2h4ICSmHJU9
         pZmZk0xCt3FMh5MDlyo49MrZFNEQ6eoBpv4J2oFk+YjFJpqrfuLYbhBguRIZm3bztujZ
         wSGZQkiG5PKBU9dUjNN//Zm+y0wc6Jj3mMr45r8z60uFXLcgftWIyJIku59qkOuRtlg/
         3Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310135; x=1685902135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jmjCmOGhJKcTExgQHxoFdrZdNhIimvrG1KlJ+O2CnA=;
        b=KhGL17LwJmYny7XEnOb3tueFnBGnYJnfnZhT2tdbZ7ceccVBXYobc/4QVk/OGH5+yr
         KmCHTeMdU5qRftI/3q7nGulUxMaZBTpr7RCfK+25X89OuR900aOj2mCtHC/ikb57VpSl
         fLyL2R5ECGp0zq8KKFEWcgm5mcs7UaTxhe0MTOJ+pKHIYxdcAv05yvEPiiUgHeOsZExT
         ECR7F4Hp4iX6LXC9hbtCJSXvwwY/JY8NlkLwv0v/TV8gCkZLkg/8BKTVQJGP1oEOeYwh
         GdfgEVm86MxvEqeO8XDEEBDYoeIs4xBebr2g/tPC4GksLorqL0TYuKtMVhbGSaF7tP5l
         6ubA==
X-Gm-Message-State: AC+VfDyqxIWRBJH0F0XSXxTqNMmTo8nSILW2l5e8zYQO4iG+GWu2Iki3
        tPwyMIG38m4Kssyhfs4s3WCbq+GsIpI=
X-Google-Smtp-Source: ACHHUZ7Li5NhkqOE1+eiPls/+snjqcBfxl+Gcf+qRka4n1VUPtkhMwlUzgkzNuivRGulByJQdOt0tA==
X-Received: by 2002:a17:90a:a595:b0:247:14ac:4d3a with SMTP id b21-20020a17090aa59500b0024714ac4d3amr2917795pjq.20.1683310135403;
        Fri, 05 May 2023 11:08:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5658:95c:e1cf:a1b0])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090aeb0600b002500df72713sm3186230pjz.7.2023.05.05.11.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:08:54 -0700 (PDT)
Date:   Fri, 5 May 2023 11:08:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Input: ads7846 - Convert to use software nodes
Message-ID: <ZFVGMiuRT+e2eVXw@google.com>
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-1-a6d0a89ffa8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v3-1-a6d0a89ffa8b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
On Fri, May 05, 2023 at 01:16:55PM +0200, Linus Walleij wrote:
> 
> Populate the devices on the Nokia 770 CBUS I2C using software
> nodes instead of platform data quirks. This includes the LCD
> and the ADS7846 touchscreen so the conversion just brings the LCD
> along with it as software nodes is an all-or-nothing design
> pattern.

Wow, so that worked , awesome!

> +static const struct property_entry nokia770_ads7846_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 4096),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 4096),
> +	PROPERTY_ENTRY_U32("touchscreen-max-pressure", 256),
> +	PROPERTY_ENTRY_U32("touchscreen-average-samples", 10),
> +	PROPERTY_ENTRY_U16("ti,x-plate-ohms", 180),
> +	PROPERTY_ENTRY_U16("ti,debounce-tol", 3),
> +	PROPERTY_ENTRY_U16("ti,debounce-rep", 1),
> +	PROPERTY_ENTRY_GPIO("pendown-gpios", &nokia770_gpiochip1_node,
> +			    ADS7846_PENDOWN_GPIO, GPIO_ACTIVE_HIGH),

Looking at the driver this actually needs to be GPIO_ACTIVE_LOW.

>  
> +static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
> +	.dev_id = "spi2.0",
> +	.table = {
> +		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_TP_INT,
> +			    "pendown", GPIO_ACTIVE_HIGH),

GPIO_ACTIVE_LOW here too.

> +static struct gpiod_lookup_table db1100_touch_gpio_table = {
> +	.dev_id = "spi0.0",
> +	.table = {
> +		GPIO_LOOKUP("alchemy-gpio2", 21,
> +			    "pendown", GPIO_ACTIVE_HIGH),

And here as well.

> @@ -223,7 +220,7 @@ static int get_pendown_state(struct ads7846 *ts)
>  	if (ts->get_pendown_state)
>  		return ts->get_pendown_state();
>  
> -	return !gpio_get_value(ts->gpio_pendown);
> +	return !gpiod_get_value(ts->gpio_pendown);

This needs to be

	return !gpiod_get_value_raw(ts->gpio_pendown);

I looked at various DTSes we have and they use a mix of active high and
active low annotations, so we have to go with the "raw" variant for now,
and then update to normal one once we update bad DTSes.

Thanks!

-- 
Dmitry
