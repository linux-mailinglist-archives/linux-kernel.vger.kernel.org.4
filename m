Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26434675628
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjATNzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:55:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391E9BF8A9;
        Fri, 20 Jan 2023 05:55:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7588B82838;
        Fri, 20 Jan 2023 13:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C56C433D2;
        Fri, 20 Jan 2023 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674222948;
        bh=e2V86XBaIn8vu9joVeARD8AhtK3u16VJXZES9v6mJSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARSLq3JIqcxLkdGawxG1mJs0X0Ks7eBKO1iP7sLKjB+/D0GEuTTu+QItW1l0Qbm2L
         KTaGtOK8EDrWEVYFtmy0xBaSZQbA8tOud7/ebkQF5P/uNiAi03yeKPBCNhYiwwJfX+
         CyWayPeiAhHsd6uaElN6dk/wjEAw/ihtchZX7oeqXez3Y0W8ePHXeV2r7zFCbcg8yb
         WfFEGtXyw36NVOIlo8aIVDsw2xbXoheW40LgVkRBioTz/kv0ewGU//nkdr9+3BWRBF
         mjXO2uGcQwZwnNquq+O/GE23iLMhUXGU8kjjIKJosYF3hTPqg5Xb7hjeHcK6NEfekB
         EPpNDyi2g5KHQ==
Date:   Fri, 20 Jan 2023 13:55:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Pavel Machek <pavel@ucw.cz>, krzysztof.kozlowski@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: lp55xx: configure internal charge pump
Message-ID: <Y8qdX7QIQntPWuuA@google.com>
References: <20230110092342.24132-1-maarten.zanders@mind.be>
 <20230110092342.24132-3-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110092342.24132-3-maarten.zanders@mind.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023, Maarten Zanders wrote:

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
>  drivers/leds/leds-lp5521.c                | 12 ++++++------
>  drivers/leds/leds-lp5523.c                | 18 +++++++++++++-----
>  drivers/leds/leds-lp55xx-common.c         | 22 ++++++++++++++++++++++
>  drivers/leds/leds-lp8501.c                |  8 ++++++--
>  include/linux/platform_data/leds-lp55xx.h |  9 +++++++++
>  5 files changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
> index 19478d9c19a7..ee1c72cffdab 100644
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
> +	       LP5521_CP_MODE_MASK;
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
> index c1940964067a..a690a484fd7b 100644
> --- a/drivers/leds/leds-lp55xx-common.c
> +++ b/drivers/leds/leds-lp55xx-common.c
> @@ -653,6 +653,13 @@ static int lp55xx_parse_logical_led(struct device_node *np,
>  	return ret;
>  }
>  
> +static const char * const charge_pump_modes[] = {
> +	[LP55XX_CP_OFF] = "off",
> +	[LP55XX_CP_BYPASS] = "bypass",
> +	[LP55XX_CP_BOOST] = "boost",
> +	[LP55XX_CP_AUTO] = "auto",
> +};
> +
>  struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
>  						      struct device_node *np,
>  						      struct lp55xx_chip *chip)
> @@ -661,6 +668,8 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
>  	struct lp55xx_platform_data *pdata;
>  	struct lp55xx_led_config *cfg;
>  	int num_channels;
> +	enum lp55xx_charge_pump_mode cp_mode;
> +	const char *pm;
>  	int i = 0;
>  	int ret;
>  
> @@ -691,6 +700,19 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
>  		i++;
>  	}
>  
> +	pdata->charge_pump_mode = LP55XX_CP_AUTO;
> +	ret = of_property_read_string(np, "ti,charge-pump-mode", &pm);
> +	if (!ret) {
> +		for (cp_mode = LP55XX_CP_OFF;
> +		     cp_mode < ARRAY_SIZE(charge_pump_modes);
> +		     cp_mode++) {
> +			if (!strcasecmp(pm, charge_pump_modes[cp_mode])) {
> +				pdata->charge_pump_mode = cp_mode;
> +				break;
> +			}
> +		}
> +	}

A little over-engineered, no?

Why not make the property a numerical value, then simply:

  ret = of_property_read_u32(np, "ti,charge-pump-mode", &pdata->charge_pump_mode);
  if (ret)
          data->charge_pump_mode = LP55XX_CP_AUTO;

Elevates the requirement for the crumby indexed array of strings above.

Remainder looks sane enough.

-- 
Lee Jones [李琼斯]
