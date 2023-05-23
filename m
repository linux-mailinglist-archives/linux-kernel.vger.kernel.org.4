Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDC70DD90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjEWNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjEWNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:37:04 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5685EFD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:37:02 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id e485e3fa-f96e-11ed-b972-005056bdfda7;
        Tue, 23 May 2023 16:37:00 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 16:36:59 +0300
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, u-kumar1@ti.com
Subject: Re: [PATCH v5 1/3] rtc: tps6594: Add driver for TPS6594 RTC
Message-ID: <ZGzBe6O_mw_pdSkH@surfacebook>
References: <20230522163115.2592883-1-eblanc@baylibre.com>
 <20230522163115.2592883-2-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522163115.2592883-2-eblanc@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 06:31:13PM +0200, Esteban Blanc kirjoitti:
> TPS6594 PMIC is a MFD. This patch adds support for
> the RTC found inside TPS6594 family of PMIC.
> 
> Alarm is also supported.

...

> +	help
> +	  TI Power Management IC TPS6594 supports RTC functionality
> +	  along with alarm. This driver supports the RTC driver for
> +	  the TPS6594 RTC module.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called tps6594-rtc

Grammar period at the end?

...

> +#define TPS6594_GET_TIME_ON TPS6594_BIT_GET_TIME
> +#define TPS6594_GET_TIME_OFF 0

Not used.

> +#define TPS6594_IT_ALARM_ON TPS6594_BIT_IT_ALARM
> +#define TPS6594_IT_ALARM_OFF 0

Used only once.

> +#define TPS6594_AUTO_COMP_ON TPS6594_BIT_IT_ALARM

No _OFF counterpart.

That said the _OFF can be dropped completely. And the rest I see no value to
have, just use those bit definitions directly?

...

> +static int tps6594_rtc_alarm_irq_enable(struct device *dev,
> +					unsigned int enabled)
> +{
> +	struct tps6594 *tps = dev_get_drvdata(dev->parent);
> +	u8 val = 0;

Redundant assignment.

> +	val = enabled ? TPS6594_IT_ALARM_ON : TPS6594_IT_ALARM_OFF;
> +
> +	return regmap_update_bits(tps->regmap, TPS6594_REG_RTC_INTERRUPTS,
> +				  TPS6594_BIT_IT_ALARM, val);
> +}

...

> +	// Read shadowed RTC registers.
> +	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
> +			       NUM_TIME_REGS);
> +	if (ret < 0)
> +		return ret;
> +
> +	tm->tm_sec = bcd2bin(rtc_data[0]);
> +	tm->tm_min = bcd2bin(rtc_data[1]);
> +	tm->tm_hour = bcd2bin(rtc_data[2]);
> +	tm->tm_mday = bcd2bin(rtc_data[3]);
> +	tm->tm_mon = bcd2bin(rtc_data[4]) - 1;
> +	tm->tm_year = bcd2bin(rtc_data[5]) + 100;
> +	tm->tm_wday = bcd2bin(rtc_data[6]);
> +
> +	return ret;

	return 0;

No?

...

> +static int tps6594_rtc_set_calibration(struct device *dev, int calibration)
> +{
> +	unsigned char comp_data[NUM_COMP_REGS];
> +	struct tps6594 *tps = dev_get_drvdata(dev->parent);
> +	__le16 value;
> +	int ret;
> +
> +	/*
> +	 * TPS6594 uses two's complement 16 bit value for compensation of RTC
> +	 * crystal inaccuracies. One time every hour when seconds counter
> +	 * increments from 0 to 1 compensation value will be added to internal
> +	 * RTC counter value.
> +	 *
> +	 * Valid range for compensation value: [-32767 .. 32767].

This is defined naturally by the bits available, correct?

> +	 */
> +	if (calibration < -32767 || calibration > 32767) {

So, this can be S16_MIN / S16_MAX range. The question here is what the
-32768 meaning is and why it can't be used.

> +		dev_err(dev, "RTC calibration value out of range: %d\n",
> +			calibration);
> +		return -EINVAL;

-ERANGE

> +	}

> +	value = (__le16)calibration;
> +
> +	comp_data[0] = value & 0xFF;
> +	comp_data[1] = (value >> 8) & 0xFF;

Of course these three lines is not what expected.

	value = cpu_to_le16();

> +	// Update all the compensation registers in one shot.
> +	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_COMP_LSB,
> +				comp_data, NUM_COMP_REGS);

				&value, sizeof(value) ?

> +	if (ret < 0)
> +		return ret;
> +
> +	// Enable automatic compensation.
> +	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> +			       TPS6594_BIT_AUTO_COMP);
> +}

...

> +	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_COMP_LSB, comp_data,
> +			       NUM_COMP_REGS);
> +	if (ret < 0)
> +		return ret;
> +
> +	value = (__le16)comp_data[0] | ((__le16)comp_data[1] << 8);
> +
> +	*calibration = value;

In the similar (complementary API) way as above.

...

> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,

Having

	struct device *dev = &pdev->dev;

might make this and other lines shorter / neater.

> +					tps6594_rtc_interrupt, IRQF_ONESHOT,
> +					TPS6594_IRQ_NAME_ALARM, &pdev->dev);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to request_threaded_irq\n");

-- 
With Best Regards,
Andy Shevchenko


