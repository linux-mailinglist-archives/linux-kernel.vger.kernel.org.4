Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B162E819
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiKQWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbiKQWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:18:40 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C27AF52;
        Thu, 17 Nov 2022 14:18:02 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2AE5C240003;
        Thu, 17 Nov 2022 22:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668723480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PMEGGaHv4ym/vEJJOXTPs/ct/uPum/odo/7JSOnoUdo=;
        b=Cn6U+mATiVHhbL+s2mlEZZ7jPclAmYenakyRH+5WOfTRV+2HpobwF3xdZRV5fKgDa9v8f3
        fzfh4gotM4jMZDcjTfL6cdXGkdPOB3ItNowG1EW8cJy7bNlSlA2zfj0Jex23Ip7ojh2Q34
        BaMi4pamR4/H7v79LFIbAHZ+juHCtpcPdTG7MxFQdSnbjolpT/YjwjvpkC0YC0CyXvhD4S
        z29FFI3o4ZviVWkKZrx6AXHnehgKc22WVsb3EOA1JuwLrw3QCTENvOOKeyH/o3HsWr5Vas
        AGuGLe6NVFf4LZBMJ9UTm+57Cho5Ipf/8QEyX5/IcwhZVMZTiwMMzZkby1ePHg==
Date:   Thu, 17 Nov 2022 23:17:59 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rtc: max31329: Add Maxim max31329 real time clock
Message-ID: <Y3azF55qLiH3uaH7@mail.local>
References: <20220923185358.11023-1-jagathjog1996@gmail.com>
 <20220923185358.11023-3-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923185358.11023-3-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a few small comments:

On 24/09/2022 00:23:58+0530, Jagath Jog J wrote:
> +static int max31329_get_osc_status(struct device *dev)

This function should be folded in its only call site, this will reduce
the size of the code.

> +{
> +	struct max31329_data *max31329 = dev_get_drvdata(dev);
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(max31329->regmap, MAX31329_STATUS_REG, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status & MAX31329_STATUS_OSF)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +

[...]

> +static int max31329_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct max31329_data *max31329 = dev_get_drvdata(dev);
> +	const struct rtc_time *tm = &alrm->time;
> +	u8 regs[6], year;
> +	int ret;
> +
> +	regs[REG_TO_OFFSET(MAX31329_SECONDS_REG)] = bin2bcd(tm->tm_sec) & 0x7F;
> +	regs[REG_TO_OFFSET(MAX31329_MINUTES_REG)] = bin2bcd(tm->tm_min) & 0x7f;
> +	regs[REG_TO_OFFSET(MAX31329_HOURS_REG)] = bin2bcd(tm->tm_hour) & 0x3f;
> +	regs[REG_TO_OFFSET(MAX31329_DATE_REG) - 1] = bin2bcd(tm->tm_mday) & 0x3f;
> +	regs[REG_TO_OFFSET(MAX31329_MONTH_REG) - 1] = bin2bcd(tm->tm_mon + 1) & 0x1f;
> +
> +	if (tm->tm_year >= 200)
> +		return -EINVAL;
> +
This check is unnecessary.

> +	year = bin2bcd(tm->tm_year - 100);
> +	regs[REG_TO_OFFSET(MAX31329_YEAR_REG) - 1] = year;
> +
> +	ret = regmap_bulk_write(max31329->regmap, MAX31329_ALM1_SEC_REG, regs,
> +				MAX31329_ALM1_SEC_LEN);
> +	if (ret)
> +		return ret;
> +
> +	return max31329_alarm_irq_enable(dev, alrm->enabled);
> +}

[...]

> +static int max31329_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
> +		if (rate == clkout_rates[i])
> +			return regmap_update_bits(max31329->regmap,
> +						  MAX31329_RTC_CONFIG2_REG,
> +						  MAX31329_RTC_CFG2_CLKOHZ_MSK,
> +						  FIELD_PREP(MAX31329_RTC_CFG2_CLKOHZ_MSK,
> +							     i));

Doesn't that i fit on the previous line?

> +	return -EINVAL;
> +}
> +
> +static int max31329_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)

Doesn't that fit on one line?

> +{
> +	struct max31329_data *max31329;
> +	int ret;
> +	struct nvmem_config nvmem_cfg = {
> +		.name = "max31329_nvram",
> +		.word_size = 1,
> +		.stride = 1,
> +		.size = 64,
> +		.type = NVMEM_TYPE_BATTERY_BACKED,
> +		.reg_read = max31329_nvram_read,
> +		.reg_write = max31329_nvram_write,
> +	};
> +
> +	max31329 = devm_kzalloc(&client->dev, sizeof(*max31329), GFP_KERNEL);
> +	if (!max31329)
> +		return -ENOMEM;
> +
> +	max31329->regmap = devm_regmap_init_i2c(client, &config);
> +	if (IS_ERR(max31329->regmap))
> +		return PTR_ERR(max31329->regmap);
> +
> +	dev_set_drvdata(&client->dev, max31329);
> +
> +	max31329->rtc = devm_rtc_allocate_device(&client->dev);
> +	if (IS_ERR(max31329->rtc))
> +		return PTR_ERR(max31329->rtc);
> +
> +	max31329->rtc->ops = &max31329_rtc_ops;
> +	max31329->irq = client->irq;
> +	max31329->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	max31329->rtc->range_max = RTC_TIMESTAMP_END_2199;
> +
> +	if (max31329->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, max31329->irq,
> +						NULL, max31329_irq_handler,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						"max31329", &client->dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		clear_bit(RTC_FEATURE_ALARM, max31329->rtc->features);
> +		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, max31329->rtc->features);
> +	}
> +
> +	if (max31329->irq || device_property_read_bool(&client->dev,
> +						       "wakeup-source"))
> +		device_init_wakeup(&client->dev, true);
> +
> +	ret = devm_rtc_register_device(max31329->rtc);
> +	if (ret)
> +		return ret;
> +
> +	max31329_trickle_config(&client->dev);
> +
> +	nvmem_cfg.priv = max31329->regmap;
> +	devm_rtc_nvmem_register(max31329->rtc, &nvmem_cfg);
> +
> +#ifdef CONFIG_COMMON_CLK
> +	max31329_clkout_register_clk(max31329, client);
> +#endif
> +
> +	return 0;
> +}
> +
> +static const __maybe_unused struct of_device_id max31329_of_match[] = {
> +	{ .compatible = "maxim,max31329", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max31329_of_match);
> +
> +static struct i2c_driver max31329_driver = {
> +	.driver = {
> +		.name = "rtc-max31329",
> +		.of_match_table = of_match_ptr(max31329_of_match),
> +	},
> +	.probe = max31329_probe,
> +};
> +module_i2c_driver(max31329_driver);
> +
> +MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
> +MODULE_DESCRIPTION("Maxim MAX31329 RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
