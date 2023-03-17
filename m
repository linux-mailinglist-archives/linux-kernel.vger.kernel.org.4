Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477AC6BF49A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCQVvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCQVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:51:37 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B008D2FCF0;
        Fri, 17 Mar 2023 14:51:03 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E784A240003;
        Fri, 17 Mar 2023 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679089818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=RpfUPFa7Pjz3eL1lIlllGYE22+iVyiYtNaJkGf0is+0=;
        b=IPPeK1ehF6ODLo1gc63bn/vkXoF0LZtUcIe3UewPh+/iXUP9alqzFKzqjjoGUwi7JHxbgF
        ATVjETsXgS5oDbRhNj4DbPv8Ky87ZMxle4VM8Vo8DAHJmE95rIiQKlCZ5KDDUlsTfJOK+R
        rrwDKbQ/k+raisljl001CIcf+qaOQq+LHU+1gE7vAdExMqp3vmgnvjjFPs1/QmIUwFw17h
        N3pk8X50PjDeF0RN2nlxqM7MrjbX6cp/bS7OvIiR4QWQ2JmN9q4b8hsvkZtHc/s3pjpM+s
        5/6jQvDZdWWcYzxnnOzVWrn6WpK449mprCcaR8BB7OqJIk37PNl4GTbaYMQeDg==
Date:   Fri, 17 Mar 2023 22:50:16 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     a.zummo@towertech.it, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v4 1/2] drivers: rtc: add max313xx series rtc driver
Message-ID: <202303172150163e1de7e3@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315161626.247-2-Ibrahim.Tilki@analog.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 19:16:25+0300, Ibrahim Tilki wrote:
> +static int max313xx_trickle_charger_setup(struct device *dev)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	bool trickle_diode_en;
> +	u32 charger_en = 0;
> +	int index, reg;
> +	u32 ohms = 0;
> +	int ret;
> +
> +	device_property_read_u32(dev, "aux-voltage-chargeable", &charger_en);
> +	if (charger_en > 1)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "invalid value %d for property aux-voltage-chargeable\n",
> +				     charger_en);

This is too verbose, you can simply return -EINVAL here. dtbs_check will
report the invalid value.

> +
> +	if (!charger_en)
> +		return 0;
> +
> +	trickle_diode_en = device_property_read_bool(dev, "adi,trickle-diode-enable");

There is no point having this property, simply use aux-voltage-chargeable.

> +	device_property_read_u32(dev, "trickle-resistor-ohms", &ohms);
> +
> +	if (!rtc->chip->trickle_reg) {
> +		dev_warn(dev, "device does not have trickle charger\n");

Simply return 0, no string.

> +		return 0;
> +	}
> +
> +	index = find_closest(ohms, max313xx_trickle_ohms,
> +			     ARRAY_SIZE(max313xx_trickle_ohms)) + 1;
> +
> +	switch (rtc->id) {
> +	case ID_MAX31329:
> +		reg = FIELD_PREP(MAX31329_TRICKLE_ENABLE_BIT, 1) |
> +		      FIELD_PREP(MAX31329_43_TRICKLE_RES_MASK, index) |
> +		      FIELD_PREP(MAX31329_43_TRICKLE_DIODE_EN, trickle_diode_en);
> +		break;
> +	case ID_MAX31331:
> +	case ID_MAX31334:
> +		reg = FIELD_PREP(MAX3133X_TRICKLE_ENABLE_BIT, 1) |
> +		      FIELD_PREP(MAX3133X_TRICKLE_RES_MASK, index) |
> +		      FIELD_PREP(MAX3133X_TRICKLE_DIODE_EN, trickle_diode_en);
> +		break;
> +	case ID_MAX31341:
> +		if (index == 1)
> +			index = 0;
> +
> +		reg = FIELD_PREP(MAX31341_TRICKLE_ENABLE_BIT, 1) |
> +		      FIELD_PREP(MAX31341_TRICKLE_RES_MASK, index) |
> +		      FIELD_PREP(MAX31341_TRICKLE_DIODE_EN, trickle_diode_en);
> +
> +		ret = regmap_set_bits(rtc->regmap, MAX31341_POWER_MGMT_REG,
> +				      MAX31341_POWER_MGMT_TRICKLE_BIT);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case ID_MAX31343:
> +		reg = FIELD_PREP(MAX31329_43_TRICKLE_RES_MASK, index) |
> +		      FIELD_PREP(MAX31329_43_TRICKLE_DIODE_EN, trickle_diode_en) |
> +		      FIELD_PREP(MAX31343_TRICKLE_ENABLE_MASK,
> +				 MAX31343_TRICKLE_ENABLE_CODE);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return regmap_write(rtc->regmap, rtc->chip->trickle_reg, reg);
> +}
> +
> +static int max313xx_find_clkin_freq_index(struct clk *clk)
> +{
> +	unsigned long rate = clk_get_rate(clk);
> +	int freq;
> +	int i;
> +
> +	i = find_closest(rate, max313xx_clkin_freq,
> +			 ARRAY_SIZE(max313xx_clkin_freq));
> +	if (max313xx_clkin_freq[i] == rate)
> +		return i;
> +
> +	for (i = ARRAY_SIZE(max313xx_clkin_freq) - 1; i >= 0; i--) {
> +		freq = max313xx_clkin_freq[i];
> +		if (freq == clk_round_rate(clk, freq))
> +			return i;
> +	}
> +
> +	/* supplied clock cannot produce one of desired frequency rate */
> +	return -ENODEV;
> +}
> +
> +static int max313xx_clkin_init(struct device *dev)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	int rate;
> +	int ret;
> +
> +	rtc->clkin = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(rtc->clkin)) {
> +		if (PTR_ERR(rtc->clkin) == -ENOENT)
> +			rtc->clkin = NULL;
> +		else
> +			return dev_err_probe(dev, PTR_ERR(rtc->clkin),
> +					     "error while clkin setup\n");
> +	}
> +
> +	if (!rtc->clkin) {
> +		switch (rtc->id) {
> +		case ID_MAX31329:
> +			return regmap_clear_bits(rtc->regmap,
> +						 MAX31329_CONFIG2_REG,
> +						 MAX31329_CONFIG2_CLKIN_EN);
> +		case ID_MAX31341:
> +		case ID_MAX31342:
> +			return regmap_clear_bits(rtc->regmap,
> +						 MAX31341_42_CONFIG1_REG,
> +						 MAX31341_42_CONFIG1_CLKIN_EN);
> +		default:
> +			return 0;
> +		}
> +	}
> +
> +	rate = max313xx_find_clkin_freq_index(rtc->clkin);
> +	if (rate < 0)
> +		return dev_err_probe(dev, rate,
> +				     "clkin cannot produce required frequency\n");
> +
> +	ret = clk_set_rate(rtc->clkin, max313xx_clkin_freq[rate]);
> +	if (ret)
> +		return ret;
> +
> +	switch (rtc->id) {
> +	case ID_MAX31329:
> +		ret = regmap_update_bits(rtc->regmap, MAX31329_CONFIG2_REG,
> +					 MAX31329_CONFIG2_CLKIN_FREQ, rate);
> +		if (ret)
> +			return ret;
> +
> +		return regmap_set_bits(rtc->regmap, MAX31329_CONFIG2_REG,
> +				       MAX31329_CONFIG2_CLKIN_EN);
> +	case ID_MAX31341:
> +	case ID_MAX31342:
> +		ret = regmap_update_bits(rtc->regmap, MAX31341_42_CONFIG1_REG,
> +					 MAX31341_42_CONFIG1_CLKIN_FREQ,
> +					 FIELD_PREP(MAX31341_42_CONFIG1_CLKIN_FREQ, rate));
> +		if (ret)
> +			return ret;
> +
> +		return regmap_set_bits(rtc->regmap, MAX31341_42_CONFIG1_REG,
> +				       MAX31341_42_CONFIG1_CLKIN_EN);
> +	default:
> +		rtc->clkin = NULL;
> +		dev_warn(dev, "device does not have clock input\n");
> +		return 0;
> +	}
> +}
> +
> +static int max313xx_irq_init(struct device *dev, const char *devname)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	int ret;
> +
> +	switch (rtc->id) {
> +	case ID_MAX31328:
> +		/* max31328 sqw and interrupt pin is shared */
> +		if (rtc->irq > 0 && rtc->clkout.clk)
> +			return dev_err_probe(dev, -EOPNOTSUPP,
> +					     "cannot have both sqw clock output and irq enabled");

This still doesn't work, having a clock registered doesn't mean it is
used or muxed. Also, you want to always register it so it gets disabled
when it is not used.

> +
> +		break;
> +	case ID_MAX31331:
> +	case ID_MAX31334:
> +		if (rtc->clkout.clk) {
> +			/*
> +			 * interrupt muxing depends on clkout so enable clkout
> +			 * if configured before requesting interrupt
> +			 */
> +			ret = clk_prepare_enable(rtc->clkout.clk);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "cannot enable clkout\n");
> +		}
> +		break;
> +	default:
> +		if (rtc->clkin) {
> +			if (rtc->clkout.clk && rtc->irq > 0)
> +				return dev_err_probe(dev, -EOPNOTSUPP,
> +						     "irq not possible when both clkin and clkout are configured\n");
> +
> +			if (rtc->irq <= 0)
> +				break;
> +
> +			/* clkout needs to be disabled for interrupt */
> +			if (rtc->chip->clkout->en_invert)
> +				ret = regmap_set_bits(rtc->regmap,
> +						      rtc->chip->clkout->reg,
> +						      rtc->chip->clkout->en_bit);
> +			else
> +				ret = regmap_clear_bits(rtc->regmap,
> +							rtc->chip->clkout->reg,
> +							rtc->chip->clkout->en_bit);
> +

What if you want alarm1 on INTA without any clkin? This doesn't seem to
be configured.

> +			if (ret)
> +				return ret;
> +		}
> +		break;
> +	}
> +
> +	if (rtc->irq > 0) {
> +		return devm_request_threaded_irq(dev, rtc->irq, NULL,
> +						 &max313xx_irq, IRQF_ONESHOT,
> +						 devname, rtc);
> +	}

You still want to parse wakeup-source in case INTA/INTB is connected
directly to a PMIC for exemple.

> +
> +	clear_bit(RTC_FEATURE_ALARM, rtc->rtc->features);
> +
> +	return 0;
> +}
> +
> +static int max313xx_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct max313xx *max313xx;
> +	struct device *hwmon;
> +	const void *match;
> +	int ret;
> +
> +	max313xx->irq = client->irq;
> +
> +	ret = max313xx_clkout_register(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = max313xx_clkin_init(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* IRQ wiring depends on the clock configuration so parse them first */
> +	ret = max313xx_irq_init(dev, client->name);
> +	if (ret)
> +		return ret;
> +
> +	if (max313xx->chip->ram_size) {
> +		max313xx_nvmem_cfg.size = max313xx->chip->ram_size;
> +		max313xx_nvmem_cfg.priv = max313xx;
> +
> +		ret = devm_rtc_nvmem_register(max313xx->rtc, &max313xx_nvmem_cfg);
> +		if (ret)
> +			dev_warn(dev, "cannot register rtc nvmem\n");
> +	}
> +
> +	if (max313xx->chip->temp_reg) {
> +		hwmon = devm_hwmon_device_register_with_info(dev, client->name,
> +							     max313xx,
> +							     &max313xx_chip_info,
> +							     NULL);
> +		if (IS_ERR(hwmon))
> +			dev_warn(dev, "cannot register hwmon device: %li\n",
> +				 PTR_ERR(hwmon));
> +	}
> +
> +	return max313xx_trickle_charger_setup(dev);
> +}
> +
> +static const struct of_device_id max313xx_of_id[] = {
> +	{ .compatible = "adi,max31328", .data = &chip[ID_MAX31328] },
> +	{ .compatible = "adi,max31329", .data = &chip[ID_MAX31329] },
> +	{ .compatible = "adi,max31331", .data = &chip[ID_MAX31331] },
> +	{ .compatible = "adi,max31334", .data = &chip[ID_MAX31334] },
> +	{ .compatible = "adi,max31341", .data = &chip[ID_MAX31341] },
> +	{ .compatible = "adi,max31342", .data = &chip[ID_MAX31342] },
> +	{ .compatible = "adi,max31343", .data = &chip[ID_MAX31343] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max313xx_of_id);
> +
> +static const struct i2c_device_id max313xx_id[] = {
> +	{ "max31328", (kernel_ulong_t)&chip[ID_MAX31328] },
> +	{ "max31329", (kernel_ulong_t)&chip[ID_MAX31329] },
> +	{ "max31331", (kernel_ulong_t)&chip[ID_MAX31331] },
> +	{ "max31334", (kernel_ulong_t)&chip[ID_MAX31334] },
> +	{ "max31341", (kernel_ulong_t)&chip[ID_MAX31341] },
> +	{ "max31342", (kernel_ulong_t)&chip[ID_MAX31342] },
> +	{ "max31343", (kernel_ulong_t)&chip[ID_MAX31343] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max313xx_id);
> +
> +static struct i2c_driver max313xx_driver = {
> +	.driver = {
> +		.name	= "rtc-max313xx",
> +		.of_match_table = max313xx_of_id,
> +	},
> +	.probe		= max313xx_probe,
> +	.id_table	= max313xx_id,
> +};
> +module_i2c_driver(max313xx_driver);
> +
> +MODULE_DESCRIPTION("Analog Devices MAX313XX RTCs");
> +MODULE_AUTHOR("Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>");
> +MODULE_AUTHOR("Ibrahim Tilki <Ibrahim.Tilki@analog.com>");
> +MODULE_SOFTDEP("pre: regmap-i2c");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
