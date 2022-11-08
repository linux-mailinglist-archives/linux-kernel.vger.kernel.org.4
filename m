Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335E621195
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiKHM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiKHM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:57:14 -0500
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE57613F74
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:57:11 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id sOA7o2YX9XaejsOA7odE9X; Tue, 08 Nov 2022 13:57:09 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 08 Nov 2022 13:57:09 +0100
X-ME-IP: 86.243.100.34
Message-ID: <482e8394-ceac-658f-7a69-29033f805440@wanadoo.fr>
Date:   Tue, 8 Nov 2022 13:57:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
To:     ibrahim.tilki@analog.com
Cc:     Zeynep.Arslanbenzer@analog.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux@roeck-us.net, robh+dt@kernel.org
References: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
 <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/11/2022 à 13:22, Ibrahim Tilki a écrit :
> Adding support for Analog Devices MAX313XX series RTCs.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---

[...]

> +static int max313xx_clkout_register(struct device *dev)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!device_property_present(dev, "#clock-cells"))
> +		return 0;
> +
> +	max313xx_clk_init.name = rtc->chip->clkout_name;
> +	device_property_read_string(dev, "clock-output-names",
> +				    &max313xx_clk_init.name);
> +	rtc->clkout.init = &max313xx_clk_init;
> +
> +	ret = devm_clk_hw_register(dev, &rtc->clkout);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot register clock\n");
> +
> +	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
> +				   rtc->clkout.clk);

Hi,

No devm like functionality here?

devm_of_clk_add_hw_provider()? (not sure of the impact or not of the 
"_hw_" in the function name)

> +}

[...]

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
> +
> +	if (rtc->irq > 0) {
> +		ret = devm_request_threaded_irq(dev, rtc->irq, NULL,
> +						&max313xx_irq, IRQF_ONESHOT,
> +						devname, rtc);
> +		if (ret)
> +			return ret;
> +
> +		wakeup = device_property_read_bool(dev, "wakeup-source");
> +		return device_init_wakeup(dev, wakeup);
> +	}
> +
> +	__clear_bit(RTC_FEATURE_ALARM, rtc->rtc->features);

Is it safe? Does it worth it to use __clear_bit() instead of clear_bit() 
here?

> +
> +	return 0;
> +}

[...]


