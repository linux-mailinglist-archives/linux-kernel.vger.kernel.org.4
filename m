Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF4700DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjELRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjELRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:22:48 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F10D852
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:22:46 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 9aaf40ea-f0e9-11ed-abf4-005056bdd08f;
        Fri, 12 May 2023 20:22:44 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 12 May 2023 20:22:43 +0300
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v4 1/3] rtc: tps6594: Add driver for TPS6594 RTC
Message-ID: <ZF514wvUt_xrU1gG@surfacebook>
References: <20230512141755.1712358-1-eblanc@baylibre.com>
 <20230512141755.1712358-2-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512141755.1712358-2-eblanc@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, May 12, 2023 at 04:17:53PM +0200, Esteban Blanc kirjoitti:
> TPS6594 PMIC is a MFD. This patch adds support for
> the RTC found inside TPS6594 family of PMIC.
> 
> Alarm is also supported.

...

> +/*
> + * Min and max values supported with 'offset' interface (swapped sign)
> + * After conversion, the values does not exceed the range [-32767, 33767] which COMP_REG must
> + * conform to

Please, format it better and do not forget to use proper punctuation (commas,
periods, etc.).

> + */
> +#define MIN_OFFSET (-277774)
> +#define MAX_OFFSET (277774)

...

> +/* Multiplier for ppb conversions */
> +#define PPB_MULT (1000000000LL)

We have something in units.h. Can you use generic macro?

...

> +	ret = regmap_update_bits(tps->regmap, TPS6594_REG_RTC_INTERRUPTS,
> +				 TPS6594_BIT_IT_ALARM, val);
> +
> +	return ret;

	return regmap_update_bits(...);

...

> +	/*
> +	 * Set GET_TIME to 0. This way, next time we set GET_TIME to 1 we are sure to store an
> +	 * up-to-date timestamp
> +	 */

Please, check all your multi-line comments for proper punctuation.

...

> +	/* Check if RTC is running. */

Please, keep a single style for the one-line comments (with or without period
at the end).

> +	alm->enabled = int_val & TPS6594_BIT_IT_ALARM ? 1 : 0;

Ternary is reduntand.

> +	return ret;

Why not return 0 explicitly? Or do you return positive value?

...

> +	comp_data[0] = (u16)value & 0xFF;
> +	comp_data[1] = ((u16)value >> 8) & 0xFF;

Use proper bitwise type, i.e. __le16.

...

> +	value = (u16)comp_data[0] | ((u16)comp_data[1] << 8);

Ditto.

...

> +	/* Convert from RTC calibration register format to ppb format */
> +	tmp = calibration * (s64)PPB_MULT;

Is casting really needed?

> +	if (tmp < 0)
> +		tmp -= TICKS_PER_HOUR / 2LL;
> +	else
> +		tmp += TICKS_PER_HOUR / 2LL;

Is it guaranteed to have no overflow here?

> +	tmp = div_s64(tmp, TICKS_PER_HOUR);
> +
> +	/*
> +	 * Offset value operates in negative way, so swap sign.
> +	 * See 8.3.10.5, (32768 - COMP_REG)
> +	 */
> +	*offset = (long)-tmp;
> +
> +	return ret;

ret?!

> +}
> +
> +static int tps6594_rtc_set_offset(struct device *dev, long offset)
> +{
> +	int calibration;
> +	s64 tmp;

Similar questions here as per above routine.

> +	/* Make sure offset value is within supported range */
> +	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
> +		return -ERANGE;
> +
> +	/* Convert from ppb format to RTC calibration register format */
> +	tmp = offset * (s64)TICKS_PER_HOUR;
> +	if (tmp < 0)
> +		tmp -= PPB_MULT / 2LL;
> +	else
> +		tmp += PPB_MULT / 2LL;
> +	tmp = div_s64(tmp, PPB_MULT);
> +
> +	/* Offset value operates in negative way, so swap sign */
> +	calibration = (int)-tmp;
> +
> +	return tps6594_rtc_set_calibration(dev, calibration);
> +}

...

> +static int tps6594_rtc_probe(struct platform_device *pdev)
> +{
> +	struct tps6594 *tps;
> +	struct rtc_device *rtc;
> +	int irq;
> +	int ret;

> +	tps = dev_get_drvdata(pdev->dev.parent);

Can be united with definition of tps above.

...

> +	/* RTC not running */
> +	if (ret == 0) {
> +		/* Start rtc */

RTC for the sake of consistency.

But I think one of the comment is redundant.

...

> +		mdelay(100);

Such long delays have to be explicitly elaborated (in the comment on top).

> +	}

...

> +	irq = platform_get_irq_byname(pdev, TPS6594_IRQ_NAME_ALARM);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq\n");
> +		return irq;

	return dev_err_probe(...);

> +	}

...

> +		dev_err(&pdev->dev, "Failed to request_threaded_irq\n");
> +		return ret;

Ditto.

...

> +		dev_err(&pdev->dev, "Failed to init rtc as wakeup source\n");
> +		return ret;

Ditto.

...

> +

Blank line is not needed.

> +module_platform_driver(tps6594_rtc_driver);

-- 
With Best Regards,
Andy Shevchenko


