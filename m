Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB66D81B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbjDEP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjDEP0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019E8F;
        Wed,  5 Apr 2023 08:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF76062A09;
        Wed,  5 Apr 2023 15:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0ECC433EF;
        Wed,  5 Apr 2023 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680708392;
        bh=0gWPsu8zx6e+L9d6iu1LdOwDdK1z4ksztY8G66Oq1Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8pOcUOoeVsKAarNKNqUYLlHOYbXF/Evwq2imgtj0KSPCB0Zjt7vVonl0awasdHyP
         HWR6cx0a2EmPZEr2jvmSMdjc2NMqKyAzlSpjxJYaMAO3RNO4K9n2CMuAyRS43YTRVr
         aEkt7u6v+Z7pMCsAPFhY9ZweEVHY+gIebf64wPELJqnL73qs2AtOVldc3D/5cmxXvu
         mILJdFrnlJJ+PkrB5Pvvne/zvI9105Vcqio3fCL/muFN9vzhe3MuhR5oTWO12jNBqx
         lAbySwA68WOpzB1soleUUivndIWObogzp9hiHRs4sFJp3Pz5KmXgPiBHGXIn1AVKAb
         tQxxoZodcmm9w==
Date:   Wed, 5 Apr 2023 16:26:27 +0100
From:   Lee Jones <lee@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] leds: lp55xx: configure internal charge pump
Message-ID: <20230405152627.GO8371@google.com>
References: <20230331114610.48111-1-maarten.zanders@mind.be>
 <20230331114610.48111-3-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230331114610.48111-3-maarten.zanders@mind.be>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023, Maarten Zanders wrote:

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
>     v6: cleanup parsing of DT paramter

Sorry Maarten, just a couple of small nits.

>  drivers/leds/leds-lp5521.c                | 12 ++++++------
>  drivers/leds/leds-lp5523.c                | 18 +++++++++++++-----
>  drivers/leds/leds-lp55xx-common.c         | 14 ++++++++++++++
>  drivers/leds/leds-lp8501.c                |  8 ++++++--
>  include/linux/platform_data/leds-lp55xx.h |  3 +++
>  5 files changed, 39 insertions(+), 13 deletions(-)
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

This fits on one line, no?  < 100-chars?

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

Space after the | please.

Perhaps even tab the '\'s out to align.

Or perhaps the below line can go on the one above.

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

One line.

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

This can be part of the main block.

> +
>  #include "leds-lp55xx-common.h"
>
>  /* External clock rate */
> @@ -691,6 +693,16 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
>  		i++;
>  	}
>
> +	if (of_property_read_u32(np, "ti,charge-pump-mode",
> +				 &pdata->charge_pump_mode))

One line?

> +		pdata->charge_pump_mode = LP55XX_CP_AUTO;
> +
> +	if (pdata->charge_pump_mode > LP55XX_CP_AUTO) {
> +		dev_err(dev, "invalid charge pump mode %d\n",
> +			pdata->charge_pump_mode);

As above.

> +		return ERR_PTR(-EINVAL);
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

As above.

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

That's a lot of data.  Does it need to be u32?

> +
>  	/* optional enable GPIO */
>  	struct gpio_desc *enable_gpiod;
>
> --
> 2.37.3
>

--
Lee Jones [李琼斯]
