Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B710D675D02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjATSsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjATSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:48:17 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA89754;
        Fri, 20 Jan 2023 10:47:59 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 375F7E0004;
        Fri, 20 Jan 2023 18:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674240478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qYYcMi8M2SstQ9kQS8OvJk5vcsSwdKVjKYpbhTa3riA=;
        b=TuKOMCa1+/AyB41Jnwlt/qvw9K1FxPNLSWr8Q4UxXFos7tOohVCi81FbYdQhkStarOaY5Y
        Mn0Mh8BVQltI0xt157IKYThdI+B18IPkI8uBc+fdWdeZpv19h6LUwvzupzStE4wKNTeTC+
        8zADLxwfcKY4ziezobvD9e4OvQlVgsdjXVnzD/evSo8H6a94gZPh1oUUavJIc7vNg5qM/K
        knGrzsqQzdfH0Q/8H/D4bi2jJMHFLblU4VliooKmqkGCA7GjFAFJsbU4lEtmxf3xFO+3IE
        uUEq78Yp+XzGTW0BMeYeIFX/sPyA0WnG+QMcvFAEG0oO70mNWUPX74TmTAj1SA==
Date:   Fri, 20 Jan 2023 19:47:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 02/14] rtc: pcf2127: adapt for time/date registers at
 any offset
Message-ID: <Y8rh2SByHp773UXu@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-3-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215150214.1109074-3-hugo@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2022 10:02:03-0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> This will simplify the implementation of new variants into this driver.
> 
> Some variants (PCF2131) have a 100th seconds register. This register is
> currently not supported in this driver.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 68 ++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index b9a5d47a439f..fb0caacaabee 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -44,14 +44,17 @@
>  #define PCF2127_BIT_CTRL3_BF			BIT(3)
>  #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
>  /* Time and date registers */
> -#define PCF2127_REG_SC			0x03
> +#define PCF2127_REG_TIME_DATE_BASE	0x03
> +/* Time and date registers offsets (starting from base register) */
> +#define PCF2127_OFFSET_TD_SC		0
> +#define PCF2127_OFFSET_TD_MN		1
> +#define PCF2127_OFFSET_TD_HR		2
> +#define PCF2127_OFFSET_TD_DM		3
> +#define PCF2127_OFFSET_TD_DW		4
> +#define PCF2127_OFFSET_TD_MO		5
> +#define PCF2127_OFFSET_TD_YR		6

Same comment as for the alarms, I would simply remove the defines as
they don't really carry any useful information.

> +/* Time and date registers bits */
>  #define PCF2127_BIT_SC_OSF			BIT(7)
> -#define PCF2127_REG_MN			0x04
> -#define PCF2127_REG_HR			0x05
> -#define PCF2127_REG_DM			0x06
> -#define PCF2127_REG_DW			0x07
> -#define PCF2127_REG_MO			0x08
> -#define PCF2127_REG_YR			0x09
>  /* Alarm registers */
>  #define PCF2127_REG_ALARM_SC		0x0A
>  #define PCF2127_REG_ALARM_MN		0x0B
> @@ -106,6 +109,7 @@ struct pcf21xx_config {
>  	int max_register;
>  	unsigned int has_nvmem:1;
>  	unsigned int has_bit_wd_ctl_cd0:1;
> +	u8 regs_td_base; /* Time/data base registers. */
>  };
>  
>  struct pcf2127 {
> @@ -125,27 +129,31 @@ struct pcf2127 {
>  static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> -	unsigned char buf[10];
> +	unsigned char buf[7];
> +	unsigned int ctrl3;
>  	int ret;
>  
>  	/*
>  	 * Avoid reading CTRL2 register as it causes WD_VAL register
>  	 * value to reset to 0 which means watchdog is stopped.
>  	 */
> -	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL3,
> -			       (buf + PCF2127_REG_CTRL3),
> -			       ARRAY_SIZE(buf) - PCF2127_REG_CTRL3);
> -	if (ret) {
> -		dev_err(dev, "%s: read error\n", __func__);
> +	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &ctrl3);
> +	if (ret)
>  		return ret;
> -	}
>  
> -	if (buf[PCF2127_REG_CTRL3] & PCF2127_BIT_CTRL3_BLF)
> +	if (ctrl3 & PCF2127_BIT_CTRL3_BLF)
>  		dev_info(dev,
>  			"low voltage detected, check/replace RTC battery.\n");
>  
> +	ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->regs_td_base,
> +			       buf, sizeof(buf));
> +	if (ret) {
> +		dev_err(dev, "%s: read error\n", __func__);
> +		return ret;
> +	}
> +
>  	/* Clock integrity is not guaranteed when OSF flag is set. */
> -	if (buf[PCF2127_REG_SC] & PCF2127_BIT_SC_OSF) {
> +	if (buf[PCF2127_OFFSET_TD_SC] & PCF2127_BIT_SC_OSF) {
>  		/*
>  		 * no need clear the flag here,
>  		 * it will be cleared once the new date is saved
> @@ -158,18 +166,18 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	dev_dbg(dev,
>  		"%s: raw data is cr3=%02x, sec=%02x, min=%02x, hr=%02x, "
>  		"mday=%02x, wday=%02x, mon=%02x, year=%02x\n",
> -		__func__, buf[PCF2127_REG_CTRL3], buf[PCF2127_REG_SC],
> -		buf[PCF2127_REG_MN], buf[PCF2127_REG_HR],
> -		buf[PCF2127_REG_DM], buf[PCF2127_REG_DW],
> -		buf[PCF2127_REG_MO], buf[PCF2127_REG_YR]);
> -
> -	tm->tm_sec = bcd2bin(buf[PCF2127_REG_SC] & 0x7F);
> -	tm->tm_min = bcd2bin(buf[PCF2127_REG_MN] & 0x7F);
> -	tm->tm_hour = bcd2bin(buf[PCF2127_REG_HR] & 0x3F); /* rtc hr 0-23 */
> -	tm->tm_mday = bcd2bin(buf[PCF2127_REG_DM] & 0x3F);
> -	tm->tm_wday = buf[PCF2127_REG_DW] & 0x07;
> -	tm->tm_mon = bcd2bin(buf[PCF2127_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
> -	tm->tm_year = bcd2bin(buf[PCF2127_REG_YR]);
> +		__func__, ctrl3, buf[PCF2127_OFFSET_TD_SC],
> +		buf[PCF2127_OFFSET_TD_MN], buf[PCF2127_OFFSET_TD_HR],
> +		buf[PCF2127_OFFSET_TD_DM], buf[PCF2127_OFFSET_TD_DW],
> +		buf[PCF2127_OFFSET_TD_MO], buf[PCF2127_OFFSET_TD_YR]);
> +
> +	tm->tm_sec = bcd2bin(buf[PCF2127_OFFSET_TD_SC] & 0x7F);
> +	tm->tm_min = bcd2bin(buf[PCF2127_OFFSET_TD_MN] & 0x7F);
> +	tm->tm_hour = bcd2bin(buf[PCF2127_OFFSET_TD_HR] & 0x3F); /* rtc hr 0-23 */

You can drop the comment

> +	tm->tm_mday = bcd2bin(buf[PCF2127_OFFSET_TD_DM] & 0x3F);
> +	tm->tm_wday = buf[PCF2127_OFFSET_TD_DW] & 0x07;
> +	tm->tm_mon = bcd2bin(buf[PCF2127_OFFSET_TD_MO] & 0x1F) - 1; /* rtc mn 1-12 */

This comment too.

> +	tm->tm_year = bcd2bin(buf[PCF2127_OFFSET_TD_YR]);
>  	tm->tm_year += 100;
>  
>  	dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
> @@ -207,7 +215,7 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	buf[i++] = bin2bcd(tm->tm_year - 100);
>  
>  	/* write register's data */
> -	err = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_SC, buf, i);
> +	err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
>  	if (err) {
>  		dev_err(dev,
>  			"%s: err=%d", __func__, err);
> @@ -650,11 +658,13 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>  		.max_register = 0x1d,
>  		.has_nvmem = 1,
>  		.has_bit_wd_ctl_cd0 = 1,
> +		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>  	},
>  	[PCF2129] = {
>  		.max_register = 0x19,
>  		.has_nvmem = 0,
>  		.has_bit_wd_ctl_cd0 = 0,
> +		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>  	},
>  };
>  
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
