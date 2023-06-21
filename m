Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BF6739002
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFUTYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjFUTYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:24:41 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12892E4B;
        Wed, 21 Jun 2023 12:24:38 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687375477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fGxWe+o8GZGt054uxJQ2p4GZXTlfjL+w/uGbGYd3TrI=;
        b=gippwn8R+vQf13Pfu9b6AWCcurpJHfpqFbK5r+BoxSRYvVRlOIfWWNj0X93CY9eh+Bpihy
        IzHBu0eK3NxaAYM011P5AO+kpsiuhAoyz/JZX0ZhfZAaB602vn0fp//Mkvh8BL58+EbKYh
        8ilbTc+uBGqmY3eiypXgIlmXErBYUcnbPREaLBlMGnuKoHrnDJnIanXL8fYcKOh4b0OTHg
        F3VrHUn9KcmUBMkhn4oj4v7jph19lXTH34u9VmVx5BFXZKQRtLYP1GfhWaNI2cz6jarnXO
        zpjQI3hh6dvR2oOB3WmHi7B7uzZGOU2WzzqD93aqmx0mry/yJuPQ+cU4SNojqQ==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C017A1C0005;
        Wed, 21 Jun 2023 19:24:36 +0000 (UTC)
Date:   Wed, 21 Jun 2023 21:24:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 08/14] rtc: pcf2127: add support for PCF2131
 interrupts on output INT_A
Message-ID: <2023062119243680b73b71@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-9-hugo@hugovil.com>
 <Y8rHx8U4peB+fnW8@mail.local>
 <20230123155240.2d55fc2f5874a50e2e6252d2@hugovil.com>
 <20230511131958.fd82402f8ef43dd8690bee78@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511131958.fd82402f8ef43dd8690bee78@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 13:19:58-0400, Hugo Villeneuve wrote:
> On Mon, 23 Jan 2023 15:52:40 -0500
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > On Fri, 20 Jan 2023 17:56:39 +0100
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > 
> > > On 15/12/2022 10:02:09-0500, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > The PCF2127 and PCF2129 have one output interrupt pin. The PCF2131 has
> > > > two, named INT_A and INT_B. The hardware support that any interrupt
> > > > source can be routed to either one or both of them.
> > > > 
> > > > Force all interrupt sources to go to the INT A pin.
> > > > 
> > > > Support to route any interrupt source to INT A/B pins is not supported
> > > > by this driver at the moment.
> > > > 
> > > 
> > > The main issue with this is that this will created a breaking change
> > > once someone needs support for INTB
> > 
> > We already had a discussion about this a while ago:
> > 
> >     https://lore.kernel.org/linux-rtc/7be3f9541eaed7e17e334267e49665f442b1b458.camel@dimonoff.com/
> > 
> > What exactly do you suggest? I personnaly don't have any need for INTB at the moment and I would prefer to avoid the great complexity of supporting any combination of routing interrupts to any A ou  pins.
> 
> Hi Alexandre,
> a few months later, and I am still waiting for your feedback on this (and other questions/interrogations I raised for other patches related to this series) to submit the next version of this patch series.
> 
> Can you have a look at it and provide some answers?
> 

I'm very very sorry this takes so long. For this one, I don't have a
precise idea. I guess we could have one property per pin with a mask of
the interrupts we are interested in. That would cover all the use cases.
For example, a PMIC could take the alarms on INTB and the CPU could have
alarms, battery low and UIE on INTA.


> Thank you,
> Hugo.
> 
> 
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > ---
> > > >  drivers/rtc/rtc-pcf2127.c | 35 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > > 
> > > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > > index 4148e135f935..68af4d0438b8 100644
> > > > --- a/drivers/rtc/rtc-pcf2127.c
> > > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > > @@ -191,6 +191,7 @@ struct pcf21xx_config {
> > > >  	int max_register;
> > > >  	unsigned int has_nvmem:1;
> > > >  	unsigned int has_bit_wd_ctl_cd0:1;
> > > > +	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
> > > >  	u8 regs_td_base; /* Time/data base registers. */
> > > >  	u8 regs_alarm_base; /* Alarm function base registers. */
> > > >  	u8 reg_wd_ctl; /* Watchdog control register. */
> > > > @@ -879,6 +880,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> > > >  		.max_register = 0x1d,
> > > >  		.has_nvmem = 1,
> > > >  		.has_bit_wd_ctl_cd0 = 1,
> > > > +		.has_int_a_b = 0,
> > > >  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> > > >  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
> > > >  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> > > > @@ -902,6 +904,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> > > >  		.max_register = 0x19,
> > > >  		.has_nvmem = 0,
> > > >  		.has_bit_wd_ctl_cd0 = 0,
> > > > +		.has_int_a_b = 0,
> > > >  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> > > >  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
> > > >  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> > > > @@ -925,6 +928,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> > > >  		.max_register = 0x36,
> > > >  		.has_nvmem = 0,
> > > >  		.has_bit_wd_ctl_cd0 = 0,
> > > > +		.has_int_a_b = 1,
> > > >  		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
> > > >  		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
> > > >  		.reg_wd_ctl = PCF2131_REG_WD_CTL,
> > > > @@ -1017,6 +1021,28 @@ static int pcf2127_enable_ts(struct device *dev, int ts_id)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +/* Route all interrupt sources to INT A pin. */
> > > > +static int pcf2127_configure_interrupt_pins(struct device *dev)
> > > > +{
> > > > +	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	/* Mask bits need to be cleared to enable corresponding
> > > > +	 * interrupt source.
> > > > +	 */
> > > > +	ret = regmap_write(pcf2127->regmap,
> > > > +			   PCF2131_REG_INT_A_MASK1, 0);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = regmap_write(pcf2127->regmap,
> > > > +			   PCF2131_REG_INT_A_MASK2, 0);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > > >  			 int alarm_irq, const char *name, const struct pcf21xx_config *config)
> > > >  {
> > > > @@ -1076,6 +1102,15 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > > >  		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
> > > >  	}
> > > >  
> > > > +	if (pcf2127->cfg->has_int_a_b) {
> > > > +		/* Configure int A/B pins, independently of alarm_irq. */
> > > > +		ret = pcf2127_configure_interrupt_pins(dev);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "failed to configure interrupt pins\n");
> > > > +			return ret;
> > > > +		}
> > > > +	}
> > > > +
> > > >  	if (pcf2127->cfg->has_nvmem) {
> > > >  		struct nvmem_config nvmem_cfg = {
> > > >  			.priv = pcf2127,
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > > -- 
> > > Alexandre Belloni, co-owner and COO, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> > > 
> > 
> > 
> > -- 
> > Hugo Villeneuve <hugo@hugovil.com>
> 
> 
> -- 
> Hugo Villeneuve

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
