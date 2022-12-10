Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7666490EC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 23:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLJWB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 17:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJWBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 17:01:25 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA8164BE;
        Sat, 10 Dec 2022 14:01:20 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5906840002;
        Sat, 10 Dec 2022 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670709679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dj66ileNThfbYMkUit2UrNW8iwPVKP+X8giQrCy7hYk=;
        b=LOsJEBmoNQMVozVKAke5k2xsTfc2T3friuiSsL8bqSCRndGE6JkaPSDaoKrkIrOioIA28D
        S8PQI28sNtRiAHEHbWFCEPoKtIu1eDjzndSYZRThOzO4tmvkCKPe7vW64lB+awXa7IfhHL
        M6JmNyq4UZP7thrioBzGFEMJIrriSjJh7qdDSqe8KARVqCQ173pm5tyxRqGpl+0JmymhCx
        j4JkcV50kLR4BAqtzgSqC5ijRaKSvdT5Iu5vkCrW3CNwq/n8DcWAu4GPBWUCTjuFPwmONx
        RIe5+DkCMFhlSeadlqIe35bVZD39RimsthboOojOtNjqjW5jLU+cAdFujQuEcQ==
Date:   Sat, 10 Dec 2022 23:01:18 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     a.zummo@towertech.it, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Message-ID: <Y5UBrivA48RyW6nT@mail.local>
References: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
 <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 15:22:53+0300, Ibrahim Tilki wrote:
> +static int max313xx_trickle_charger_setup(struct device *dev)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	bool diode_disable;
> +	int index, reg;
> +	u32 ohms = 0;
> +	int ret;
> +
> +	device_property_read_u32(dev, "trickle-resistor-ohms", &ohms);
> +	if (!ohms)
> +		return 0;
> +
> +	diode_disable = device_property_read_bool(dev, "trickle-diode-disable");

This property is deprecated, please do not add a new user.

> +static int max313xx_irq_init(struct device *dev, const char *devname)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	bool wakeup;
> +	int ret;
> +
> +	rtc->irq = rtc->irqs[0];
> +
> +	switch (rtc->id) {
> +	case ID_MAX31328:
> +		/* max31328 sqw ant int pin is shared */
> +		if (rtc->id == ID_MAX31328 && rtc->irq > 0 && rtc->clkout.clk)
> +			return dev_err_probe(dev, -EOPNOTSUPP,
> +					     "cannot have both sqw clock output and irq enabled");
> +
> +		break;
> +	case ID_MAX31331:
> +	case ID_MAX31334:
> +		if (rtc->clkout.clk) {
> +			/* clockout needs to be enabled for using INTA pin */
> +			ret = clk_prepare_enable(rtc->clkout.clk);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "cannot enable clkout\n");
> +		} else {
> +			rtc->irq = rtc->irqs[1];
> +		}
> +		break;
> +	default:
> +		if (rtc->clkin) {
> +			rtc->irq = rtc->irqs[1];
> +
> +			/* wrong interrupt specified */
> +			if (rtc->irqs[0] > 0 && rtc->irqs[1] <= 0)
> +				dev_warn(dev, "INTA is specified but INTB required for irq when clkin is enabled\n");
> +
> +			if (rtc->clkout.clk && rtc->irq > 0)
> +				return dev_err_probe(dev, -EOPNOTSUPP,
> +						"irq not possible when both clkin and clkout are configured\n");
> +
> +			if (rtc->irq <= 0)
> +				break;
> +
> +			/* clkout needs to be disabled for using INTB pin */
> +			if (rtc->chip->clkout->en_invert)
> +				ret = regmap_set_bits(rtc->regmap,
> +						      rtc->chip->clkout->reg,
> +						      rtc->chip->clkout->en_bit);
> +			else
> +				ret = regmap_clear_bits(rtc->regmap,
> +							rtc->chip->clkout->reg,
> +							rtc->chip->clkout->en_bit);
> +
> +			if (ret)
> +				return ret;
> +		}
> +		break;
> +	}

I really don't like this logic that relies on interrupt-names.
interrupt-names has to be optional and the interrupt position is
meaningful. You are doing/enforcing pinmuxing on this property which
should really not be done. what you need is rather properties
explicitly telling what is muxed to INTA and INTB.

Your current logic enforces clkout on INTB which may not be what a user
wants.

> +
> +	if (rtc->irq > 0) {
> +		ret = devm_request_threaded_irq(dev, rtc->irq, NULL,
> +						&max313xx_irq, IRQF_ONESHOT,
> +						devname, rtc);
> +		if (ret)
> +			return ret;
> +
> +		wakeup = device_property_read_bool(dev, "wakeup-source");

wakeup-source is only needed when you don't have an interrupt. If an
interrupt is present, it is assumed it is able to wakeup.


> +		return device_init_wakeup(dev, wakeup);
> +	}
> +
> +	__clear_bit(RTC_FEATURE_ALARM, rtc->rtc->features);
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
> +	max313xx = devm_kzalloc(&client->dev, sizeof(*max313xx), GFP_KERNEL);
> +	if (!max313xx)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&client->dev, max313xx);
> +
> +	max313xx->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	if (IS_ERR(max313xx->regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(max313xx->regmap),
> +				     "regmap init failed\n");
> +	}
> +
> +	i2c_set_clientdata(client, max313xx);
> +
> +	match = device_get_match_data(dev);
> +	if (match)
> +		max313xx->id = (enum max313xx_ids)match;
> +	else if (id)
> +		max313xx->id = id->driver_data;
> +	else
> +		return -ENODEV;
> +
> +	max313xx->chip = &chip[max313xx->id];
> +
> +	ret = max313xx_init(max313xx);
> +	if (ret)
> +		return ret;
> +
> +	max313xx->rtc = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(max313xx->rtc))
> +		return PTR_ERR(max313xx->rtc);
> +
> +	max313xx->rtc->ops = &max3133x_rtc_ops;
> +	max313xx->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	max313xx->rtc->range_max = RTC_TIMESTAMP_END_2199;
> +
> +	ret = devm_rtc_register_device(max313xx->rtc);
> +	if (ret)
> +		return ret;
> +
> +	switch (max313xx->id) {
> +	case ID_MAX31328:
> +	case ID_MAX31343:
> +		max313xx->irqs[0] = client->irq;
> +		break;
> +	default:
> +		max313xx->irqs[0] = fwnode_irq_get_byname(dev_fwnode(dev), "INTA");
> +		max313xx->irqs[1] = fwnode_irq_get_byname(dev_fwnode(dev), "INTB");
> +		if (max313xx->irqs[0] <= 0 && max313xx->irqs[1] <= 0 && client->irq)
> +			return dev_err_probe(dev, -ENOENT,
> +					     "interrupt requested but no interrupt name specified\n");
> +
> +		break;
> +	}
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
> +	{ .compatible = "adi,max31328", .data = (void *)ID_MAX31328 },
> +	{ .compatible = "adi,max31329", .data = (void *)ID_MAX31329 },
> +	{ .compatible = "adi,max31331", .data = (void *)ID_MAX31331 },
> +	{ .compatible = "adi,max31334", .data = (void *)ID_MAX31334 },
> +	{ .compatible = "adi,max31341", .data = (void *)ID_MAX31341 },
> +	{ .compatible = "adi,max31342", .data = (void *)ID_MAX31342 },
> +	{ .compatible = "adi,max31343", .data = (void *)ID_MAX31343 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max313xx_of_id);
> +
> +static const struct i2c_device_id max313xx_id[] = {
> +	{ "max31328", ID_MAX31328 },
> +	{ "max31329", ID_MAX31329 },
> +	{ "max31331", ID_MAX31331 },
> +	{ "max31334", ID_MAX31334 },
> +	{ "max31341", ID_MAX31341 },
> +	{ "max31342", ID_MAX31342 },
> +	{ "max31343", ID_MAX31343 },
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
