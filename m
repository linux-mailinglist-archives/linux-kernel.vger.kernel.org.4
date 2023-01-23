Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80121678336
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjAWRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjAWRc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:32:29 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7CB30186;
        Mon, 23 Jan 2023 09:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9mUzZ2pRq14qLCSySucWOb7cYV81m7cHyf4fb1Agy0k=; b=R0bFJvC9cWbboE0TwpMMaqjGWD
        XFIZFUd/qP5K5COnS6/ReDkXyKRTtdDss1c1lTR8njVHsV5MInQBTMPTqpq9kMh/Ppl5MvDrHfbkW
        iwI7ShACwGeEQ2twzDs+4h1P5r0mhiwXPlcDaPaUV8CSTeND/QS/Oek3nsHyCZ6AmsdY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41494 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pK0f8-00032V-HA; Mon, 23 Jan 2023 12:31:19 -0500
Date:   Mon, 23 Jan 2023 12:31:18 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230123123118.39f5a5aab207f5942972b061@hugovil.com>
In-Reply-To: <Y8rI7/umLv/h64cN@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-11-hugo@hugovil.com>
        <Y8rI7/umLv/h64cN@mail.local>
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
Subject: Re: [PATCH v3 10/14] rtc: pcf2127: read and validate PCF2131 device
 signature
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 18:01:35 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 15/12/2022 10:02:11-0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Make sure the device we are probing is really the device we are
> > interested in.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index 241189ee4a05..e4b78b9c03f9 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -193,11 +193,13 @@ struct pcf21xx_config {
> >  	unsigned int has_nvmem:1;
> >  	unsigned int has_bit_wd_ctl_cd0:1;
> >  	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
> > +	unsigned int has_reset_reg:1; /* If variant has a reset register. */
> >  	u8 regs_td_base; /* Time/data base registers. */
> >  	u8 regs_alarm_base; /* Alarm function base registers. */
> >  	u8 reg_wd_ctl; /* Watchdog control register. */
> >  	u8 reg_wd_val; /* Watchdog value register. */
> >  	u8 reg_clkout; /* Clkout register. */
> > +	u8 reg_reset;  /* Reset register if available. */
> >  	unsigned int ts_count;
> >  	struct pcf21xx_ts_config ts[4];
> >  	struct attribute_group attribute_group;
> > @@ -882,6 +884,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >  		.has_nvmem = 1,
> >  		.has_bit_wd_ctl_cd0 = 1,
> >  		.has_int_a_b = 0,
> > +		.has_reset_reg = 0,
> >  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> >  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
> >  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> > @@ -906,6 +909,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >  		.has_nvmem = 0,
> >  		.has_bit_wd_ctl_cd0 = 0,
> >  		.has_int_a_b = 0,
> > +		.has_reset_reg = 0,
> >  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> >  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
> >  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> > @@ -930,11 +934,13 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >  		.has_nvmem = 0,
> >  		.has_bit_wd_ctl_cd0 = 0,
> >  		.has_int_a_b = 1,
> > +		.has_reset_reg = 1,
> >  		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
> >  		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
> >  		.reg_wd_ctl = PCF2131_REG_WD_CTL,
> >  		.reg_wd_val = PCF2131_REG_WD_VAL,
> >  		.reg_clkout = PCF2131_REG_CLKOUT,
> > +		.reg_reset  = PCF2131_REG_SR_RESET,
> >  		.ts_count = 4,
> >  		.ts[0] = {
> >  			.regs_base = PCF2131_REG_TS1_BASE,
> > @@ -1075,6 +1081,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> >  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
> >  	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
> >  
> > +	/* Read device signature if available. */
> > +	if (pcf2127->cfg->has_reset_reg) {
> > +		ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_reset, &val);
> > +		if (ret < 0) {
> > +			dev_err(dev, "reading RESET register failed\n");
> 
> This is too verbose, please cut down on the number of strings you are
> adding.

See comment below.

> 
> > +			return ret;
> > +		}
> > +
> > +		if (val != PCF2131_SR_RESET_READ_PATTERN) {
> > +			dev_err(dev, "invalid device signature: $%02X\n", (u8)val);
> 
> I'm also not convinced this is actually useful. This may have to be
> updated for the next rtc the driver will support and what if this
> contradicts what the device tree is claiming at this address?

I will drop that section.


> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> >  	if (alarm_irq > 0) {
> >  		unsigned long flags;
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
