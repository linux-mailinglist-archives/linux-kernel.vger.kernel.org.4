Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2902A708A52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjERVVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjERVVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:21:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E3E45;
        Thu, 18 May 2023 14:21:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso461863066b.2;
        Thu, 18 May 2023 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684444872; x=1687036872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iUdnG3B6bDinPXQQdTMNWQPFcDR+hVyW1eiXtt7wfo=;
        b=HXMqCulr0NH7kvtItyAe8SCEfLu/LEkiLlkw8VCp6mzMsfa2MrjqIuOGAF9rQrlGSv
         QYNp05dZJHNXaN1ywFXwpSjmMOJejbtyYGsdKaDVWa9NtZTDkBkTwUZJLFR9V/OJu4oi
         Fpzr7zeKT+BI8868Tpd98EeeQaQLDfsRFKTFHFScEKcntw8pbAPIefuwM3NMcV9yHbID
         32+FUUf+QcYH8KU/txsbJxxLV4AtPbLjdnLS28+PyILufsYxCY+cuQocSN/hj4XxS6dP
         2gdqkEf8IU1SlCefQIoSltLQi3CeTgo5G31jeSR3FnKWLnV00vEOCCyEI7qEM4qzs3ES
         5YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684444872; x=1687036872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iUdnG3B6bDinPXQQdTMNWQPFcDR+hVyW1eiXtt7wfo=;
        b=e2AdGPdzgzD9JdKlT2j2IepdsCzF+adz8CrFvGzqXLuhDWH8PewaotJckUeUzz09WT
         oRGz+7IOsV8+W7l7BZnQg1PGoXswzMUgTexfAFV6MfrXAk0TQO5w7M6NH1/aJCR9lRlq
         QgVhi94SJO4bXP4uVjerOTJg9vCa7r/aUgoPb3unh5j8t0XHLGBjHN9z4CYIWTjZeB2u
         kIzQ1vFMauhfBGXSFukZKQBMHk8Dh7Rna4RhYYaRYUZbUqCrDXh28EphCln9IuZ3cxbb
         3k17G5/ay7p7wBC8FzCnyOshEWSCOa2fa9HSE8P/0eRxupmcRwns1JMZFPSi697FHyjA
         SmZQ==
X-Gm-Message-State: AC+VfDxc4U/NGREEH8rk/fSklfHQyD9B2YjI3JZi6Kv9B1SiO8Yj6VlN
        NLhL8ykJIXrSaX/TXzRT9Bg=
X-Google-Smtp-Source: ACHHUZ4DVEeLBoJ3ljcDD6txqqTPOrPhKaAMy3wbbDw7gBrvZEJBms7KoupvsqOZZ2BRvfmUhObApw==
X-Received: by 2002:a17:907:97cf:b0:967:142b:ff07 with SMTP id js15-20020a17090797cf00b00967142bff07mr475021ejc.21.1684444871844;
        Thu, 18 May 2023 14:21:11 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906b19900b0095707b7dd04sm1420365ejy.42.2023.05.18.14.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:21:11 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
        Jonathan McDowell <noodles@earth.li>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] pinctrl: axp209: Add support for GPIO3 on the AXP209
Date:   Thu, 18 May 2023 23:21:08 +0200
Message-ID: <2224092.iZASKD2KPV@jernej-laptop>
In-Reply-To: <dde40307f0ebc23b9841c32e702b481ab5193dc4.1684258957.git.noodles@earth.li>
References: <cover.1683719613.git.noodles@earth.li>
 <cover.1684258957.git.noodles@earth.li>
 <dde40307f0ebc23b9841c32e702b481ab5193dc4.1684258957.git.noodles@earth.li>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 16. maj 2023 ob 19:47:29 CEST je Jonathan McDowell napisal(a):
> The AXP209 device has a 4th GPIO which has a slightly different register
> setup, where the control + status bits are held in a single register
> rather than sharing AXP20X_GPIO20_SS with GPIOs 0-2.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/pinctrl/pinctrl-axp209.c | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
> index 0bc1b381a2b8..b3ba25435c34 100644
> --- a/drivers/pinctrl/pinctrl-axp209.c
> +++ b/drivers/pinctrl/pinctrl-axp209.c
> @@ -30,6 +30,11 @@
>  #define AXP20X_GPIO_FUNCTION_OUT_HIGH	1
>  #define AXP20X_GPIO_FUNCTION_INPUT	2
>  
> +#define AXP20X_GPIO3_FUNCTIONS		GENMASK(2, 1)
> +#define AXP20X_GPIO3_FUNCTION_OUT_LOW	0
> +#define AXP20X_GPIO3_FUNCTION_OUT_HIGH	2
> +#define AXP20X_GPIO3_FUNCTION_INPUT	4
> +
>  #define AXP20X_FUNC_GPIO_OUT		0
>  #define AXP20X_FUNC_GPIO_IN		1
>  #define AXP20X_FUNC_LDO			2
> @@ -73,6 +78,7 @@ static const struct pinctrl_pin_desc axp209_pins[] = {
>  	PINCTRL_PIN(0, "GPIO0"),
>  	PINCTRL_PIN(1, "GPIO1"),
>  	PINCTRL_PIN(2, "GPIO2"),
> +	PINCTRL_PIN(3, "GPIO3"),
>  };
>  
>  static const struct pinctrl_pin_desc axp22x_pins[] = {
> @@ -130,6 +136,14 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
>  	unsigned int val;
>  	int ret;
>  
> +	/* AXP209 has GPIO3 status sharing the settings register */
> +	if (offset == 3) {
> +		ret = regmap_read(pctl->regmap, AXP20X_GPIO3_CTRL, &val);
> +		if (ret)
> +			return ret;
> +		return !!(val & BIT(0));
> +	}
> +
>  	ret = regmap_read(pctl->regmap, AXP20X_GPIO20_SS, &val);
>  	if (ret)
>  		return ret;
> @@ -144,6 +158,17 @@ static int axp20x_gpio_get_direction(struct gpio_chip *chip,
>  	unsigned int val;
>  	int reg, ret;
>  
> +	/* AXP209 GPIO3 settings have a different layout */
> +	if (offset == 3) {
> +		ret = regmap_read(pctl->regmap, AXP20X_GPIO3_CTRL, &val);
> +		if (ret)
> +			return ret;
> +		if (val & AXP20X_GPIO3_FUNCTION_INPUT)
> +			return GPIO_LINE_DIRECTION_IN;
> +
> +		return GPIO_LINE_DIRECTION_OUT;
> +	}
> +
>  	reg = axp20x_gpio_get_reg(offset);
>  	if (reg < 0)
>  		return reg;
> @@ -184,6 +209,15 @@ static void axp20x_gpio_set(struct gpio_chip *chip, unsigned int offset,
>  	struct axp20x_pctl *pctl = gpiochip_get_data(chip);
>  	int reg;
>  
> +	/* AXP209 has GPIO3 status sharing the settings register */
> +	if (offset == 3) {
> +		regmap_update_bits(pctl->regmap, AXP20X_GPIO3_CTRL,
> +				   AXP20X_GPIO3_FUNCTIONS,
> +				   value ? AXP20X_GPIO3_FUNCTION_OUT_HIGH :
> +				   AXP20X_GPIO3_FUNCTION_OUT_LOW);
> +		return;
> +	}
> +
>  	reg = axp20x_gpio_get_reg(offset);
>  	if (reg < 0)
>  		return;
> @@ -200,6 +234,14 @@ static int axp20x_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset,
>  	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
>  	int reg;
>  
> +	/* AXP209 GPIO3 settings have a different layout */
> +	if (offset == 3) {
> +		return regmap_update_bits(pctl->regmap, AXP20X_GPIO3_CTRL,
> +				   AXP20X_GPIO3_FUNCTIONS,
> +				   config == AXP20X_MUX_GPIO_OUT ? AXP20X_GPIO3_FUNCTION_OUT_LOW :
> +				   AXP20X_GPIO3_FUNCTION_INPUT);
> +	}
> +
>  	reg = axp20x_gpio_get_reg(offset);
>  	if (reg < 0)
>  		return reg;
> 




