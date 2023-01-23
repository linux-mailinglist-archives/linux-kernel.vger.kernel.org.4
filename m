Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F66780C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjAWQDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjAWQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:02:58 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EF7A80;
        Mon, 23 Jan 2023 08:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xSsPSjH5SJVobCbUIuXD6PKgYe4WCpQpK8haTcH3jf8=; b=mpnjWkKdvg89MGW78tS9i0FUcH
        YCfvsbQpibVEBNUdV4Qi8hI8f2vwoU0nlkOo40GnZJoxllAptqsf34nDx9ICmPY62dKG0CVAus45f
        Jm0X7ZbYB7Iu00vcHmYyfQyhB27Fn+NIDems19E6KII2AGdQM53NcQT1cYBUrkvlk3ZU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41488 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pJzHY-0002Mt-KU; Mon, 23 Jan 2023 11:02:53 -0500
Date:   Mon, 23 Jan 2023 11:02:52 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230123110252.c883b73e4cf733bb2aaa7253@hugovil.com>
In-Reply-To: <Y8rLDHBgaULi+PBt@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-4-hugo@hugovil.com>
        <Y8rLDHBgaULi+PBt@mail.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 03/14] rtc: pcf2127: adapt for alarm registers at any
 offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 18:10:36 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 15/12/2022 10:02:04-0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > This will simplify the implementation of new variants into this driver.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 42 ++++++++++++++++++++++-----------------
> >  1 file changed, 24 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index fb0caacaabee..db0cb784c0c9 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -56,11 +56,14 @@
> >  /* Time and date registers bits */
> >  #define PCF2127_BIT_SC_OSF			BIT(7)
> >  /* Alarm registers */
> > -#define PCF2127_REG_ALARM_SC		0x0A
> > -#define PCF2127_REG_ALARM_MN		0x0B
> > -#define PCF2127_REG_ALARM_HR		0x0C
> > -#define PCF2127_REG_ALARM_DM		0x0D
> > -#define PCF2127_REG_ALARM_DW		0x0E
> > +#define PCF2127_REG_ALARM_BASE		0x0A
> > +/* Alarm registers offsets (starting from base register) */
> > +#define PCF2127_OFFSET_ALARM_SC		0
> > +#define PCF2127_OFFSET_ALARM_MN		1
> > +#define PCF2127_OFFSET_ALARM_HR		2
> > +#define PCF2127_OFFSET_ALARM_DM		3
> > +#define PCF2127_OFFSET_ALARM_DW		4
> > +/* Alarm bits */
> >  #define PCF2127_BIT_ALARM_AE			BIT(7)
> >  /* CLKOUT control register */
> >  #define PCF2127_REG_CLKOUT		0x0f
> > @@ -110,6 +113,7 @@ struct pcf21xx_config {
> >  	unsigned int has_nvmem:1;
> >  	unsigned int has_bit_wd_ctl_cd0:1;
> >  	u8 regs_td_base; /* Time/data base registers. */
> > +	u8 regs_alarm_base; /* Alarm function base registers. */
> >  };
> >  
> >  struct pcf2127 {
> > @@ -402,18 +406,18 @@ static int pcf2127_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_ALARM_SC, buf,
> > -			       sizeof(buf));
> > +	ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->regs_alarm_base,
> > +			       buf, sizeof(buf));
> >  	if (ret)
> >  		return ret;
> >  
> >  	alrm->enabled = ctrl2 & PCF2127_BIT_CTRL2_AIE;
> >  	alrm->pending = ctrl2 & PCF2127_BIT_CTRL2_AF;
> >  
> > -	alrm->time.tm_sec = bcd2bin(buf[0] & 0x7F);
> > -	alrm->time.tm_min = bcd2bin(buf[1] & 0x7F);
> > -	alrm->time.tm_hour = bcd2bin(buf[2] & 0x3F);
> > -	alrm->time.tm_mday = bcd2bin(buf[3] & 0x3F);
> > +	alrm->time.tm_sec = bcd2bin(buf[PCF2127_OFFSET_ALARM_SC] & 0x7F);
> > +	alrm->time.tm_min = bcd2bin(buf[PCF2127_OFFSET_ALARM_MN] & 0x7F);
> > +	alrm->time.tm_hour = bcd2bin(buf[PCF2127_OFFSET_ALARM_HR] & 0x3F);
> > +	alrm->time.tm_mday = bcd2bin(buf[PCF2127_OFFSET_ALARM_DM] & 0x3F);
> 
> I feel like this is adding defines for the sake of having defines. I
> don't think this is particularly useful.

Ok, done.

> 
> 
> >  
> >  	return 0;
> >  }
> > @@ -447,14 +451,14 @@ static int pcf2127_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> >  	if (ret)
> >  		return ret;
> >  
> > -	buf[0] = bin2bcd(alrm->time.tm_sec);
> > -	buf[1] = bin2bcd(alrm->time.tm_min);
> > -	buf[2] = bin2bcd(alrm->time.tm_hour);
> > -	buf[3] = bin2bcd(alrm->time.tm_mday);
> > -	buf[4] = PCF2127_BIT_ALARM_AE; /* Do not match on week day */
> > +	buf[PCF2127_OFFSET_ALARM_SC] = bin2bcd(alrm->time.tm_sec);
> > +	buf[PCF2127_OFFSET_ALARM_MN] = bin2bcd(alrm->time.tm_min);
> > +	buf[PCF2127_OFFSET_ALARM_HR] = bin2bcd(alrm->time.tm_hour);
> > +	buf[PCF2127_OFFSET_ALARM_DM] = bin2bcd(alrm->time.tm_mday);
> > +	buf[PCF2127_OFFSET_ALARM_DW] = PCF2127_BIT_ALARM_AE; /* Do not match on week day */
> >  
> > -	ret = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_ALARM_SC, buf,
> > -				sizeof(buf));
> > +	ret = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_alarm_base,
> > +				buf, sizeof(buf));
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -659,12 +663,14 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >  		.has_nvmem = 1,
> >  		.has_bit_wd_ctl_cd0 = 1,
> >  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> > +		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
> >  	},
> >  	[PCF2129] = {
> >  		.max_register = 0x19,
> >  		.has_nvmem = 0,
> >  		.has_bit_wd_ctl_cd0 = 0,
> >  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> > +		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
> >  	},
> >  };
> >  
> > -- 
> > 2.30.2
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
