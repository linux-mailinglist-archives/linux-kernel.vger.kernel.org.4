Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62886A949F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCCJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCCJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67FF3928C;
        Fri,  3 Mar 2023 01:58:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F166617A5;
        Fri,  3 Mar 2023 09:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E447C433EF;
        Fri,  3 Mar 2023 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677837533;
        bh=COxgWoqtEm0AFHGOR1W4I4K+0GIrgAspJnoVNaR3vyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5MGWw7hhoY1XUVAyhghsRhwNAbv19mArfwQ+hSCdOXJmKnvzzWYoJBPcV0J8pFb9
         PoN66H0RYpcem9xkktOqOfMx62nECaGNWkG0Iagc8B8jrgQuPKS+Eoi/2Hqa25pYwj
         Hx52k13ndzmsdnqZ275JOZBp6f8Uf/Q8AS0l0kD3dg6ZnTVg6jg8jdPlko+xZdUwnK
         sCmRESOGWVSUe5hbRrSbqcIC+QEYrTx7+ALK86fgx8eM4DgjsijAAiis8DBTj1kbn8
         wqNS7S6Ty7eqJdSQm1o5+wSeTTBfvaLXpC01rGxWrChcdbDqZhVv5ueFt4Kq0mcyk1
         bTVxGfL+oNr1w==
Date:   Fri, 3 Mar 2023 09:58:48 +0000
From:   Lee Jones <lee@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: lp55xx: configure internal charge pump
Message-ID: <20230303095848.GK2303077@google.com>
References: <20230213102027.29961-1-maarten.zanders@mind.be>
 <20230213102027.29961-3-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213102027.29961-3-maarten.zanders@mind.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023, Maarten Zanders wrote:

> The LP55xx range of devices have an internal charge pump which
> can (automatically) increase the output voltage towards the
> LED's, boosting the output voltage to 4.5V.
> 
> Implement this option from the devicetree. When the setting
> is not present it will operate in automatic mode as before.
> 
> Tested on LP55231. Datasheet analysis shows that LP5521, LP5523
> and LP8501 are identical in topology and are modified in the
> same way.
> 
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> ---
> 
> Notes:
>     v1: implement as bool to disable charge pump
>     v2: rewrite to use string configuration, supporting all modes
>     v3: simplification by replacing string from DTS by constant
>     v4: added notes
>     v5: property type to u32
> 
>  drivers/leds/leds-lp5521.c                | 12 ++++++------
>  drivers/leds/leds-lp5523.c                | 18 +++++++++++++-----
>  drivers/leds/leds-lp55xx-common.c         | 14 ++++++++++++++
>  drivers/leds/leds-lp8501.c                |  8 ++++++--
>  include/linux/platform_data/leds-lp55xx.h |  3 +++
>  5 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
> index 19478d9c19a7..76c6b81afb38 100644
> --- a/drivers/leds/leds-lp5521.c
> +++ b/drivers/leds/leds-lp5521.c
> @@ -58,14 +58,11 @@
>  /* CONFIG register */
>  #define LP5521_PWM_HF			0x40	/* PWM: 0 = 256Hz, 1 = 558Hz */
>  #define LP5521_PWRSAVE_EN		0x20	/* 1 = Power save mode */
> -#define LP5521_CP_MODE_OFF		0	/* Charge pump (CP) off */
> -#define LP5521_CP_MODE_BYPASS		8	/* CP forced to bypass mode */
> -#define LP5521_CP_MODE_1X5		0x10	/* CP forced to 1.5x mode */
> -#define LP5521_CP_MODE_AUTO		0x18	/* Automatic mode selection */
> +#define LP5521_CP_MODE_MASK		0x18	/* Charge pump mode */
> +#define LP5521_CP_MODE_SHIFT		3
>  #define LP5521_R_TO_BATT		0x04	/* R out: 0 = CP, 1 = Vbat */
>  #define LP5521_CLK_INT			0x01	/* Internal clock */
> -#define LP5521_DEFAULT_CFG		\
> -	(LP5521_PWM_HF | LP5521_PWRSAVE_EN | LP5521_CP_MODE_AUTO)
> +#define LP5521_DEFAULT_CFG		(LP5521_PWM_HF | LP5521_PWRSAVE_EN)
>  
>  /* Status */
>  #define LP5521_EXT_CLK_USED		0x08
> @@ -310,6 +307,9 @@ static int lp5521_post_init_device(struct lp55xx_chip *chip)
>  	if (!lp55xx_is_extclk_used(chip))
>  		val |= LP5521_CLK_INT;
>  
> +	val |= (chip->pdata->charge_pump_mode << LP5521_CP_MODE_SHIFT) &
> +		LP5521_CP_MODE_MASK;
> +
>  	ret = lp55xx_write(chip, LP5521_REG_CONFIG, val);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
> index e08e3de1428d..b5d10d4252e6 100644
> --- a/drivers/leds/leds-lp5523.c
> +++ b/drivers/leds/leds-lp5523.c
> @@ -57,8 +57,12 @@
>  #define LP5523_AUTO_INC			0x40
>  #define LP5523_PWR_SAVE			0x20
>  #define LP5523_PWM_PWR_SAVE		0x04
> -#define LP5523_CP_AUTO			0x18
> +#define LP5523_CP_MODE_MASK		0x18
> +#define LP5523_CP_MODE_SHIFT		3
>  #define LP5523_AUTO_CLK			0x02
> +#define LP5523_DEFAULT_CONFIG	\
> +	(LP5523_AUTO_INC | LP5523_PWR_SAVE |\
> +	 LP5523_AUTO_CLK | LP5523_PWM_PWR_SAVE)
>  
>  #define LP5523_EN_LEDTEST		0x80
>  #define LP5523_LEDTEST_DONE		0x80
> @@ -125,6 +129,7 @@ static void lp5523_set_led_current(struct lp55xx_led *led, u8 led_current)
>  static int lp5523_post_init_device(struct lp55xx_chip *chip)
>  {
>  	int ret;
> +	int val;
>  
>  	ret = lp55xx_write(chip, LP5523_REG_ENABLE, LP5523_ENABLE);
>  	if (ret)
> @@ -133,10 +138,13 @@ static int lp5523_post_init_device(struct lp55xx_chip *chip)
>  	/* Chip startup time is 500 us, 1 - 2 ms gives some margin */
>  	usleep_range(1000, 2000);
>  
> -	ret = lp55xx_write(chip, LP5523_REG_CONFIG,
> -			    LP5523_AUTO_INC | LP5523_PWR_SAVE |
> -			    LP5523_CP_AUTO | LP5523_AUTO_CLK |
> -			    LP5523_PWM_PWR_SAVE);
> +	val = LP5523_DEFAULT_CONFIG;
> +
> +	val |= (chip->pdata->charge_pump_mode << LP5523_CP_MODE_SHIFT) &
> +	       LP5523_CP_MODE_MASK;
> +
> +	ret = lp55xx_write(chip, LP5523_REG_CONFIG, val);
> +
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
> index c1940964067a..5a02c4a4ec98 100644
> --- a/drivers/leds/leds-lp55xx-common.c
> +++ b/drivers/leds/leds-lp55xx-common.c
> @@ -19,6 +19,8 @@
>  #include <linux/slab.h>
>  #include <linux/gpio/consumer.h>
>  
> +#include <dt-bindings/leds/leds-lp55xx.h>
> +
>  #include "leds-lp55xx-common.h"
>  
>  /* External clock rate */
> @@ -691,6 +693,18 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
>  		i++;
>  	}
>  
> +	ret = of_property_read_u32(np, "ti,charge-pump-mode",
> +				   &pdata->charge_pump_mode);
> +	if (ret) {
> +		pdata->charge_pump_mode = LP55XX_CP_AUTO;
> +	} else {

You can clean this up by dropping the else.

> +		if (pdata->charge_pump_mode > LP55XX_CP_AUTO) {
> +			dev_err(dev, "invalid charge pump mode %d\n",
> +				pdata->charge_pump_mode);

Then this can be single line.

> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
>  	of_property_read_string(np, "label", &pdata->label);
>  	of_property_read_u8(np, "clock-mode", &pdata->clock_mode);
>  
> diff --git a/drivers/leds/leds-lp8501.c b/drivers/leds/leds-lp8501.c
> index ae11a02c0ab2..f0e70e116919 100644
> --- a/drivers/leds/leds-lp8501.c
> +++ b/drivers/leds/leds-lp8501.c
> @@ -53,10 +53,11 @@
>  #define LP8501_PWM_PSAVE		BIT(7)
>  #define LP8501_AUTO_INC			BIT(6)
>  #define LP8501_PWR_SAVE			BIT(5)
> -#define LP8501_CP_AUTO			0x18
> +#define LP8501_CP_MODE_MASK		0x18
> +#define LP8501_CP_MODE_SHIFT		3
>  #define LP8501_INT_CLK			BIT(0)
>  #define LP8501_DEFAULT_CFG	\
> -	(LP8501_PWM_PSAVE | LP8501_AUTO_INC | LP8501_PWR_SAVE | LP8501_CP_AUTO)
> +	(LP8501_PWM_PSAVE | LP8501_AUTO_INC | LP8501_PWR_SAVE)
>  
>  #define LP8501_REG_RESET		0x3D
>  #define LP8501_RESET			0xFF
> @@ -102,6 +103,9 @@ static int lp8501_post_init_device(struct lp55xx_chip *chip)
>  	if (chip->pdata->clock_mode != LP55XX_CLOCK_EXT)
>  		val |= LP8501_INT_CLK;
>  
> +	val |= (chip->pdata->charge_pump_mode << LP8501_CP_MODE_SHIFT) &
> +	       LP8501_CP_MODE_MASK;
> +
>  	ret = lp55xx_write(chip, LP8501_REG_CONFIG, val);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/platform_data/leds-lp55xx.h b/include/linux/platform_data/leds-lp55xx.h
> index 3441064713a3..3cc8db0b12b5 100644
> --- a/include/linux/platform_data/leds-lp55xx.h
> +++ b/include/linux/platform_data/leds-lp55xx.h
> @@ -73,6 +73,9 @@ struct lp55xx_platform_data {
>  	/* Clock configuration */
>  	u8 clock_mode;
>  
> +	/* Charge pump mode */
> +	u32 charge_pump_mode;
> +
>  	/* optional enable GPIO */
>  	struct gpio_desc *enable_gpiod;
>  
> -- 
> 2.37.3
> 

-- 
Lee Jones [李琼斯]
