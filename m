Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F286069F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJTVB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJTVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:01:49 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1991D5869;
        Thu, 20 Oct 2022 14:01:47 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D8A8F40005;
        Thu, 20 Oct 2022 21:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666299705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAioOkHX/l8yWrqfHFpnxAMqognQ7v1zu2QhYwdycTY=;
        b=GZtmZZyeDRBTXDZzIyF/JrX7Ymr6OpHhR6IPaCDUCTxIkdhtjsfUeRMNZGKOzBgUOFwA39
        8YfocEkDVJuJuewB+ysBKXpRwNt/zI3yklXUqVJVK0rC3L31NGOtRyKwgyjP0wf/NANnFE
        SMbLGCLM2aAX9tjCwIIM7+pwNUoG4qUzxpnPS/TbNBaR6mxr4UmngIOghQDxZpsf24B9Ui
        Y30jPqLN708R6Vn21vt5wGkVLAHpDpgDTGwdpswy61L4aPkiheEMhauZeu/E1eDRkomYYM
        UReZ5BDtLsEhZQGXUza7E4Dt1ibVA/wwcdsis0nEdieKa/uMWQJC8D6nMQR7ow==
Date:   Thu, 20 Oct 2022 23:01:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     a.zummo@towertech.it, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH 1/2] drivers: rtc: add max313xx series rtc driver
Message-ID: <Y1G3OA068WKbz3ED@mail.local>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
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

On 19/10/2022 16:39:09+0300, Ibrahim Tilki wrote:
> +static int max313xx_set_time(struct device *dev, struct rtc_time *t)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	u8 regs[7];
> +	int ret;
> +
> +	if (t->tm_year < 100 || t->tm_year >= 300)
> +		return -EINVAL;

This is unnecessary

> +
> +	regs[0] = bin2bcd(t->tm_sec);
> +	regs[1] = bin2bcd(t->tm_min);
> +	regs[2] = bin2bcd(t->tm_hour);
> +	regs[3] = bin2bcd(t->tm_wday + 1);
> +	regs[4] = bin2bcd(t->tm_mday);
> +	regs[5] = bin2bcd(t->tm_mon + 1);
> +
> +	if (t->tm_year >= 200) {
> +		regs[5] |= FIELD_PREP(MAX313XX_MONTH_CENTURY, 1);
> +		regs[6] = bin2bcd(t->tm_year - 200);
> +	} else {
> +		regs[6] = bin2bcd(t->tm_year - 100);
> +	}

regs[6] = bin2bcd(t->tm_year % 100); would be simpler

> +static int max313xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
> +{
> +	struct max313xx *rtc = dev_get_drvdata(dev);
> +	struct rtc_time time;
> +	unsigned int reg;
> +	u8 regs[6];
> +	int ret;
> +
> +	regs[0] = bin2bcd(t->time.tm_sec);
> +	regs[1] = bin2bcd(t->time.tm_min);
> +	regs[2] = bin2bcd(t->time.tm_hour);
> +	regs[3] = bin2bcd(t->time.tm_mday);
> +	regs[4] = bin2bcd(t->time.tm_mon + 1);
> +
> +	if (t->time.tm_year >= 200) {
> +		/*
> +		 * Century bit is shared between time and alarm registers so
> +		 * make sure that new alarm and RTC time is in the same century.
> +		 */
> +		ret = max313xx_read_time(dev, &time);
> +		if (ret)
> +			return ret;
> +
> +		if (time.tm_year < 200)
> +			return -EINVAL;
> +

This doesn't feel right and it seems you are losing a whole range of
alarm years. The correct thing to do is to check whether the alarm is in
the same 100 years range.


> +	/* Convert to 24Hr */
> +	hour = bcd2bin(reg[MAX313XX_REG_HOUR] & 0x1f);
> +	if (hour == 12)
> +		hour = 0;

I'm not sure this is worth it, you should probably instead support
reading both formats and setting only 24h
> +
> +	if (FIELD_GET(MAX313XX_HRS_F_AM_PM, reg[MAX313XX_REG_HOUR]))
> +		hour += 12;
> +
> +	reg[MAX313XX_REG_HOUR] = bin2bcd(hour);
> +	/*
> +	 * If minute is 59, write all registers in case hour register
> +	 * gets updated during read-write cycle
> +	 */
> +	if (reg[MAX313XX_REG_MINUTE] == 0x59)
> +		return regmap_bulk_write(rtc->regmap, rtc->chip->sec_reg, reg, 7);
> +
> +	return regmap_write(rtc->regmap, rtc->chip->sec_reg + MAX313XX_REG_HOUR,
> +			    reg[MAX313XX_REG_HOUR]);

You should probably reuse .set_time here

> +/* Some devices require initialization */
> +static int max313xx_init(struct max313xx *rtc)
> +{
> +	switch (rtc->id) {
> +	case ID_MAX31341:
> +	case ID_MAX31342:
> +		return regmap_update_bits(rtc->regmap, MAX3134X_CFG_REG,
> +					  MAX3134X_CFG_INIT_MASK,
> +					  MAX3134X_CFG_INIT_VALUE);

The comment is not really useful and now I'm intrigued and want to know
what this does!


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
