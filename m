Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB8738E72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFUSSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjFUSSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:18:34 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EEE1FCA;
        Wed, 21 Jun 2023 11:18:04 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687371482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M9WcqC3L/r2xVogqbZX9pEKGGecC2b16bWLV6IOADcI=;
        b=kVi+DuO0UvjIRhTl8sfwAPln+/H3wStj6nbVTEUI2KM8nAy39xdsDxH45TDe1fXegwBYAZ
        DJq1N7Q+1mHO4vRwtSewqE9LOmngGK17o4XJ3gYayrGrBCQIJNs+sRIId3mrnTnXky7hSl
        G93NgPdpFCYNgz3kjLOwNlMYHD4cJiZic2n8RzjT7A4R4K17dsgomw6f2/q+fMmfYHdAkd
        P9uj6yFxmlZVx9gm5RgwVh02CpxxJ3+lVtljpSAtjPLGC96ALgM48KjSsBCXcPPiMi92XI
        sSq5dO4W2HgO0aQP79zzM/uJY5+XC5D36+e7KUQlc1glTjYNkBa0JfChXCVwaQ==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33D93E0003;
        Wed, 21 Jun 2023 18:18:01 +0000 (UTC)
Date:   Wed, 21 Jun 2023 20:18:01 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 02/14] rtc: pcf2127: adapt for time/date registers at
 any offset
Message-ID: <202306211818015dbac6b7@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-3-hugo@hugovil.com>
 <Y8rh2SByHp773UXu@mail.local>
 <20230123105457.4e08329422b7e51f870b7315@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123105457.4e08329422b7e51f870b7315@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 10:54:57-0500, Hugo Villeneuve wrote:
> On Fri, 20 Jan 2023 19:47:53 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On 15/12/2022 10:02:03-0500, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > This will simplify the implementation of new variants into this driver.
> > > 
> > > Some variants (PCF2131) have a 100th seconds register. This register is
> > > currently not supported in this driver.
> > > 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  drivers/rtc/rtc-pcf2127.c | 68 ++++++++++++++++++++++-----------------
> > >  1 file changed, 39 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > index b9a5d47a439f..fb0caacaabee 100644
> > > --- a/drivers/rtc/rtc-pcf2127.c
> > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > @@ -44,14 +44,17 @@
> > >  #define PCF2127_BIT_CTRL3_BF			BIT(3)
> > >  #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
> > >  /* Time and date registers */
> > > -#define PCF2127_REG_SC			0x03
> > > +#define PCF2127_REG_TIME_DATE_BASE	0x03
> > > +/* Time and date registers offsets (starting from base register) */
> > > +#define PCF2127_OFFSET_TD_SC		0
> > > +#define PCF2127_OFFSET_TD_MN		1
> > > +#define PCF2127_OFFSET_TD_HR		2
> > > +#define PCF2127_OFFSET_TD_DM		3
> > > +#define PCF2127_OFFSET_TD_DW		4
> > > +#define PCF2127_OFFSET_TD_MO		5
> > > +#define PCF2127_OFFSET_TD_YR		6
> > 
> > Same comment as for the alarms, I would simply remove the defines as
> > they don't really carry any useful information.
> 
> Note that if I remove them, the patch for pcf2127_rtc_read_time() would look like this:
> 
>  	/* Clock integrity is not guaranteed when OSF flag is set. */
> -	if (buf[PCF2127_REG_SC] & PCF2127_BIT_SC_OSF) {
> +	if (buf[0] & PCF2127_BIT_SC_OSF) {
> ...
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
> +		__func__, ctrl3, buf[0],
> +		buf[1], buf[2],
> +		buf[3], buf[4],
> +		buf[5], buf[PCF2127_OFFSET_TD_YR]);
> +
> +	tm->tm_sec = bcd2bin(buf[0] & 0x7F);
> +	tm->tm_min = bcd2bin(buf[1] & 0x7F);
> +	tm->tm_hour = bcd2bin(buf[2] & 0x3F); /* rtc hr 0-23 */
> +	tm->tm_mday = bcd2bin(buf[3] & 0x3F);
> +	tm->tm_wday = buf[4] & 0x07;
> +	tm->tm_mon = bcd2bin(buf[5] & 0x1F) - 1; /* rtc mn 1-12 */
> +	tm->tm_year = bcd2bin(buf[6]);
> 
> Do you still want to remove the defines then?

This is fine, yes.

> 
> 
> > > +/* Time and date registers bits */
> > >  #define PCF2127_BIT_SC_OSF			BIT(7)
> > > -#define PCF2127_REG_MN			0x04
> > > -#define PCF2127_REG_HR			0x05
> > > -#define PCF2127_REG_DM			0x06
> > > -#define PCF2127_REG_DW			0x07
> > > -#define PCF2127_REG_MO			0x08
> > > -#define PCF2127_REG_YR			0x09
> > >  /* Alarm registers */
> > >  #define PCF2127_REG_ALARM_SC		0x0A
> > >  #define PCF2127_REG_ALARM_MN		0x0B
> > > @@ -106,6 +109,7 @@ struct pcf21xx_config {
> > >  	int max_register;
> > >  	unsigned int has_nvmem:1;
> > >  	unsigned int has_bit_wd_ctl_cd0:1;
> > > +	u8 regs_td_base; /* Time/data base registers. */
> > >  };
> > >  
> > >  struct pcf2127 {
> > > @@ -125,27 +129,31 @@ struct pcf2127 {
> > >  static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > >  {
> > >  	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> > > -	unsigned char buf[10];
> > > +	unsigned char buf[7];
> > > +	unsigned int ctrl3;
> > >  	int ret;
> > >  
> > >  	/*
> > >  	 * Avoid reading CTRL2 register as it causes WD_VAL register
> > >  	 * value to reset to 0 which means watchdog is stopped.
> > >  	 */
> > > -	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL3,
> > > -			       (buf + PCF2127_REG_CTRL3),
> > > -			       ARRAY_SIZE(buf) - PCF2127_REG_CTRL3);
> > > -	if (ret) {
> > > -		dev_err(dev, "%s: read error\n", __func__);
> > > +	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &ctrl3);
> > > +	if (ret)
> > >  		return ret;
> > > -	}
> > >  
> > > -	if (buf[PCF2127_REG_CTRL3] & PCF2127_BIT_CTRL3_BLF)
> > > +	if (ctrl3 & PCF2127_BIT_CTRL3_BLF)
> > >  		dev_info(dev,
> > >  			"low voltage detected, check/replace RTC battery.\n");
> > >  
> > > +	ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->regs_td_base,
> > > +			       buf, sizeof(buf));
> > > +	if (ret) {
> > > +		dev_err(dev, "%s: read error\n", __func__);
> > > +		return ret;
> > > +	}
> > > +
> > >  	/* Clock integrity is not guaranteed when OSF flag is set. */
> > > -	if (buf[PCF2127_REG_SC] & PCF2127_BIT_SC_OSF) {
> > > +	if (buf[PCF2127_OFFSET_TD_SC] & PCF2127_BIT_SC_OSF) {
> > >  		/*
> > >  		 * no need clear the flag here,
> > >  		 * it will be cleared once the new date is saved
> > > @@ -158,18 +166,18 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > >  	dev_dbg(dev,
> > >  		"%s: raw data is cr3=%02x, sec=%02x, min=%02x, hr=%02x, "
> > >  		"mday=%02x, wday=%02x, mon=%02x, year=%02x\n",
> > > -		__func__, buf[PCF2127_REG_CTRL3], buf[PCF2127_REG_SC],
> > > -		buf[PCF2127_REG_MN], buf[PCF2127_REG_HR],
> > > -		buf[PCF2127_REG_DM], buf[PCF2127_REG_DW],
> > > -		buf[PCF2127_REG_MO], buf[PCF2127_REG_YR]);
> > > -
> > > -	tm->tm_sec = bcd2bin(buf[PCF2127_REG_SC] & 0x7F);
> > > -	tm->tm_min = bcd2bin(buf[PCF2127_REG_MN] & 0x7F);
> > > -	tm->tm_hour = bcd2bin(buf[PCF2127_REG_HR] & 0x3F); /* rtc hr 0-23 */
> > > -	tm->tm_mday = bcd2bin(buf[PCF2127_REG_DM] & 0x3F);
> > > -	tm->tm_wday = buf[PCF2127_REG_DW] & 0x07;
> > > -	tm->tm_mon = bcd2bin(buf[PCF2127_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
> > > -	tm->tm_year = bcd2bin(buf[PCF2127_REG_YR]);
> > > +		__func__, ctrl3, buf[PCF2127_OFFSET_TD_SC],
> > > +		buf[PCF2127_OFFSET_TD_MN], buf[PCF2127_OFFSET_TD_HR],
> > > +		buf[PCF2127_OFFSET_TD_DM], buf[PCF2127_OFFSET_TD_DW],
> > > +		buf[PCF2127_OFFSET_TD_MO], buf[PCF2127_OFFSET_TD_YR]);
> > > +
> > > +	tm->tm_sec = bcd2bin(buf[PCF2127_OFFSET_TD_SC] & 0x7F);
> > > +	tm->tm_min = bcd2bin(buf[PCF2127_OFFSET_TD_MN] & 0x7F);
> > > +	tm->tm_hour = bcd2bin(buf[PCF2127_OFFSET_TD_HR] & 0x3F); /* rtc hr 0-23 */
> > 
> > You can drop the comment
> 
> Done
> 
> > 
> > > +	tm->tm_mday = bcd2bin(buf[PCF2127_OFFSET_TD_DM] & 0x3F);
> > > +	tm->tm_wday = buf[PCF2127_OFFSET_TD_DW] & 0x07;
> > > +	tm->tm_mon = bcd2bin(buf[PCF2127_OFFSET_TD_MO] & 0x1F) - 1; /* rtc mn 1-12 */
> > 
> > This comment too.
> 
> Done
> 
> > 
> > > +	tm->tm_year = bcd2bin(buf[PCF2127_OFFSET_TD_YR]);
> > >  	tm->tm_year += 100;
> > >  
> > >  	dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
> > > @@ -207,7 +215,7 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > >  	buf[i++] = bin2bcd(tm->tm_year - 100);
> > >  
> > >  	/* write register's data */
> > > -	err = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_SC, buf, i);
> > > +	err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
> > >  	if (err) {
> > >  		dev_err(dev,
> > >  			"%s: err=%d", __func__, err);
> > > @@ -650,11 +658,13 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> > >  		.max_register = 0x1d,
> > >  		.has_nvmem = 1,
> > >  		.has_bit_wd_ctl_cd0 = 1,
> > > +		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> > >  	},
> > >  	[PCF2129] = {
> > >  		.max_register = 0x19,
> > >  		.has_nvmem = 0,
> > >  		.has_bit_wd_ctl_cd0 = 0,
> > > +		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> > >  	},
> > >  };
> > >  
> > > -- 
> > > 2.30.2
> > > 
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 
> 
> 
> -- 
> Hugo Villeneuve <hugo@hugovil.com>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
