Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64226ADCEE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCGLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCGLKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:10:48 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847296A42;
        Tue,  7 Mar 2023 03:08:25 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A232A40003;
        Tue,  7 Mar 2023 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678187304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/ZT+fHV0i3BWjuL+daVd6NNe8UoW0Hdg7fXQIX6rHM=;
        b=eLWjn4Ou9/2l1vBB1dkpLuiGW+fp9q5WOKvqARF+4/kiKVVJfx0MIKkNdfFWN3R9tHKDv5
        3bGecloBMLqKRWq3QNEjcDagN+MJFdhF0iWwxL6lzNvURIhjT4+MzS7N+5IAKMSAsegxLX
        181Fho/Pbd1q4OwxUnQk4vkRlCt8migujJKksvyBAmaQk+v9+ZH344VthGvtCFi0slOVm2
        Tj8OpGsgSt95IoWK8babFVGqUQJj6s7hBgDfAh1gpuVXbrZSYkXhNGhdjIalbTzQJ3tqwu
        1MqpxzNckAJidzYzqbKDGIVeFzjX05K3ox3vC8oHuEpvwUiDSz/YYLThtuT5VQ==
Date:   Tue, 7 Mar 2023 12:08:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com
Subject: Re: [PATCH INTERNAL v1 1/3] rtc: tps6594: add driver for TPS6594
 PMIC RTC
Message-ID: <ZAcbJxrNtWTTTSjR@mail.local>
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-2-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224133129.887203-2-eblanc@baylibre.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 24/02/2023 14:31:27+0100, Esteban Blanc wrote:
> +struct tps6594_rtc {
> +	struct rtc_device *rtc;
> +};

Is the struct actually useful?

> +/* Pulse GET_TIME field of RTC_CTRL_1 to store a timestamp in shadow registers */
> +static int tps6594_rtc_shadow_timestamp(struct device *dev, struct tps6594 *tps)
> +{
> +	int ret;
> +
> +	/* Set GET_TIME to 0. This way, next time we set GET_TIME to 1 we are sure to store an
> +	 * up-to-date timestamp
> +	 */
> +	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> +				TPS6594_BIT_GET_TIME);
> +	if (ret < 0) {
> +		dev_err(dev, "RTC CTRL1 reg update failed with err:%d\n", ret);

This is very verbose and the user doesn't have any meaningful action
once this happens. Either remove the dev_err or convert them to dev_dbg.

> +		return ret;
> +	}
> +
> +	/* Copy content of RTC registers to shadow registers or latches to read a coherent
> +	 *  timestamp
> +	 */
> +	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> +			      TPS6594_BIT_GET_TIME);
> +	if (ret < 0) {
> +		dev_err(dev, "RTC CTRL1 reg update failed with err:%d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Gets current tps6594 RTC time and date parameters.
> + *
> + * The RTC's time/alarm representation is not what gmtime(3) requires
> + * Linux to use:
> + *
> + *  - Months are 1..12 vs Linux 0-11
> + *  - Years are 0..99 vs Linux 1900..N (we assume 21st century)
> + */

I don't find this comment to be particularly useful.

> +static int tps6594_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	unsigned char rtc_data[NUM_TIME_REGS];
> +	struct tps6594 *tps = dev_get_drvdata(dev->parent);
> +	int ret;
> +

You could check whether the RTC is actually started here and return
-EINVAL if this is not the case.

> +	ret = tps6594_rtc_shadow_timestamp(dev, tps);
> +	if (ret < 0) {
> +		dev_err(dev,
> +			"failed to store a timestamp in shadow registers:%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Read shadowed RTC registers */
> +	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
> +			       NUM_TIME_REGS);
> +	if (ret < 0) {
> +		dev_err(dev, "rtc_read_time failed with error :%d\n", ret);
> +		return ret;
> +	}
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
> +}
> +
> +/*
> + * Sets current tps6594 RTC time and date parameters.
> + *
> + * The RTC's time/alarm representation is not what gmtime(3) requires
> + * Linux to use:
> + *
> + *  - Months are 1..12 vs Linux 0-11
> + *  - Years are 0..99 vs Linux 1900..N (we assume 21st century)
> + */

Ditto

> +static int tps6594_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	unsigned char rtc_data[NUM_TIME_REGS];
> +	struct tps6594 *tps = dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	rtc_data[0] = bin2bcd(tm->tm_sec);
> +	rtc_data[1] = bin2bcd(tm->tm_min);
> +	rtc_data[2] = bin2bcd(tm->tm_hour);
> +	rtc_data[3] = bin2bcd(tm->tm_mday);
> +	rtc_data[4] = bin2bcd(tm->tm_mon + 1);
> +	rtc_data[5] = bin2bcd(tm->tm_year - 100);
> +	rtc_data[6] = bin2bcd(tm->tm_wday);
> +
> +	/* Stop RTC while updating the RTC time registers */
> +	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> +				TPS6594_BIT_STOP_RTC);
> +	if (ret < 0) {
> +		dev_err(dev, "RTC stop failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Update all the time registers in one shot */
> +	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
> +				NUM_TIME_REGS);
> +	if (ret < 0) {
> +		dev_err(dev, "rtc_set_time failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Start back RTC */
> +	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> +			      TPS6594_BIT_STOP_RTC);
> +	if (ret < 0)
> +		dev_err(dev, "RTC start failed: %d\n", ret);
> +
> +	return ret;
> +}
> +


> +static int tps6594_rtc_probe(struct platform_device *pdev)
> +{
> +	struct tps6594 *tps6594;
> +	struct tps6594_rtc *tps_rtc;
> +	int irq;
> +	int ret;
> +
> +	tps6594 = dev_get_drvdata(pdev->dev.parent);
> +
> +	tps_rtc = devm_kzalloc(&pdev->dev, sizeof(struct tps6594_rtc),
> +			       GFP_KERNEL);
> +	if (!tps_rtc)
> +		return -ENOMEM;
> +
> +	tps_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(tps_rtc->rtc))
> +		return PTR_ERR(tps_rtc->rtc);
> +
> +	/* Enable crystal oscillator */
> +	ret = regmap_set_bits(tps6594->regmap, TPS6594_REG_RTC_CTRL_2,
> +			      TPS6594_BIT_XTAL_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Start rtc */
> +	ret = regmap_set_bits(tps6594->regmap, TPS6594_REG_RTC_CTRL_1,
> +			      TPS6594_BIT_STOP_RTC);
> +	if (ret < 0)
> +		return ret;

Do that (XTAL_EN and clearing STOP) only once the time is known to be
set to a correct value so read_time doesn't have a chance to return a
bogus value.

> +
> +	mdelay(100);
> +
> +	/*
> +	 * RTC should be running now. Check if this is the case.
> +	 * If not it might be a missing oscillator.
> +	 */
> +	ret = regmap_test_bits(tps6594->regmap, TPS6594_REG_RTC_STATUS,
> +			       TPS6594_BIT_RUN);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		return -ENODEV;
> +
> +	platform_set_drvdata(pdev, tps_rtc);
> +
> +	irq = platform_get_irq_byname(pdev, TPS6594_IRQ_NAME_ALARM);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq\n");
> +		return irq;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					tps6594_rtc_interrupt, IRQF_ONESHOT,
> +					TPS6594_IRQ_NAME_ALARM, &pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request_threaded_irq\n");
> +		return ret;
> +	}
> +
> +	tps_rtc->rtc->ops = &tps6594_rtc_ops;
> +	tps_rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	tps_rtc->rtc->range_max = RTC_TIMESTAMP_END_2099;
> +
> +	return devm_rtc_register_device(tps_rtc->rtc);
> +}
> +
> +static struct platform_driver tps6594_rtc_driver = {
> +	.probe		= tps6594_rtc_probe,
> +	.driver		= {
> +		.name	= "tps6594-rtc",
> +	},
> +};
> +
> +module_platform_driver(tps6594_rtc_driver);
> +
> +MODULE_ALIAS("platform:tps6594-rtc");
> +MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
> +MODULE_DESCRIPTION("TPS6594 RTC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.38.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
