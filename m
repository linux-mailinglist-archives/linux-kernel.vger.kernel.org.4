Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295DF73A2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjFVOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFVOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:21:19 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF810F0;
        Thu, 22 Jun 2023 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ch81BQ72g/o2tGuwClpruJM/ZXl6JopSPfu7rFAF3Vw=; b=sNnX5STo8ZEF6x4ng6GtagNsNw
        BI6CSwZkuM4NRo2+lZ2y+YifLfRm8iXx3Jk5x8iNyKlxbeQJ38Tti/Z2zi9dDQhbUbXFc1PX2zu6/
        EvjB0kXfWXRgM53DEqiDzvVnc92Oq4ysyXKvIUiJGWLAAVtGUE3ac2AxC5G+ZndQ+kDs=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:41238 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLBG-0002ET-Jm; Thu, 22 Jun 2023 10:21:06 -0400
Date:   Thu, 22 Jun 2023 10:21:01 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230622102101.32b21e3ba5382128f5f4703e@hugovil.com>
In-Reply-To: <20230621192621619a92eb@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-9-hugo@hugovil.com>
        <Y8rHx8U4peB+fnW8@mail.local>
        <20230123155240.2d55fc2f5874a50e2e6252d2@hugovil.com>
        <20230511131958.fd82402f8ef43dd8690bee78@hugovil.com>
        <2023062119243680b73b71@mail.local>
        <20230621192621619a92eb@mail.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v3 08/14] rtc: pcf2127: add support for PCF2131
 interrupts on output INT_A
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 21:26:21 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 21/06/2023 21:24:37+0200, Alexandre Belloni wrote:
> > On 11/05/2023 13:19:58-0400, Hugo Villeneuve wrote:
> > > On Mon, 23 Jan 2023 15:52:40 -0500
> > > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > 
> > > > On Fri, 20 Jan 2023 17:56:39 +0100
> > > > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > > > 
> > > > > On 15/12/2022 10:02:09-0500, Hugo Villeneuve wrote:
> > > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > 
> > > > > > The PCF2127 and PCF2129 have one output interrupt pin. The PCF2131 has
> > > > > > two, named INT_A and INT_B. The hardware support that any interrupt
> > > > > > source can be routed to either one or both of them.
> > > > > > 
> > > > > > Force all interrupt sources to go to the INT A pin.
> > > > > > 
> > > > > > Support to route any interrupt source to INT A/B pins is not supported
> > > > > > by this driver at the moment.
> > > > > > 
> > > > > 
> > > > > The main issue with this is that this will created a breaking change
> > > > > once someone needs support for INTB
> > > > 
> > > > We already had a discussion about this a while ago:
> > > > 
> > > >     https://lore.kernel.org/linux-rtc/7be3f9541eaed7e17e334267e49665f442b1b458.camel@dimonoff.com/
> > > > 
> > > > What exactly do you suggest? I personnaly don't have any need for INTB at the moment and I would prefer to avoid the great complexity of supporting any combination of routing interrupts to any A ou  pins.
> > > 
> > > Hi Alexandre,
> > > a few months later, and I am still waiting for your feedback on this (and other questions/interrogations I raised for other patches related to this series) to submit the next version of this patch series.
> > > 
> > > Can you have a look at it and provide some answers?
> > > 
> > 
> > I'm very very sorry this takes so long. For this one, I don't have a
> > precise idea. I guess we could have one property per pin with a mask of
> > the interrupts we are interested in. That would cover all the use cases.
> > For example, a PMIC could take the alarms on INTB and the CPU could have
> > alarms, battery low and UIE on INTA.
> 
> As the mask for INTA and INTB are set to have interrupts on both by
> default, maybe you could keep that in a separate series so we can wait
> for the DT maintainer to give their opinion.

Hi Alexandre,
great, this will allow us to focus on closing this current series, and
I will prepare a new series specifically for handling interrupts A and
B after.

I have finished implementing all the changes requested during V3
review, and will submit V4 soon.

Thank you, Hugo.


> > > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > ---
> > > > > >  drivers/rtc/rtc-pcf2127.c | 35 +++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 35 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > > > > index 4148e135f935..68af4d0438b8 100644
> > > > > > --- a/drivers/rtc/rtc-pcf2127.c
> > > > > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > > > > @@ -191,6 +191,7 @@ struct pcf21xx_config {
> > > > > >  	int max_register;
> > > > > >  	unsigned int has_nvmem:1;
> > > > > >  	unsigned int has_bit_wd_ctl_cd0:1;
> > > > > > +	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
> > > > > >  	u8 regs_td_base; /* Time/data base registers. */
> > > > > >  	u8 regs_alarm_base; /* Alarm function base registers. */
> > > > > >  	u8 reg_wd_ctl; /* Watchdog control register. */
> > > > > > @@ -879,6 +880,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> > > > > >  		.max_register = 0x1d,
> > > > > >  		.has_nvmem = 1,
> > > > > >  		.has_bit_wd_ctl_cd0 = 1,
> > > > > > +		.has_int_a_b = 0,
> > > > > >  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> > > > > >  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
> > > > > >  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> > > > > > @@ -902,6 +904,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> > > > > >  		.max_register = 0x19,
> > > > > >  		.has_nvmem = 0,
> > > > > >  		.has_bit_wd_ctl_cd0 = 0,
> > > > > > +		.has_int_a_b = 0,
> > > > > >  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> > > > > >  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
> > > > > >  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> > > > > > @@ -925,6 +928,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> > > > > >  		.max_register = 0x36,
> > > > > >  		.has_nvmem = 0,
> > > > > >  		.has_bit_wd_ctl_cd0 = 0,
> > > > > > +		.has_int_a_b = 1,
> > > > > >  		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
> > > > > >  		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
> > > > > >  		.reg_wd_ctl = PCF2131_REG_WD_CTL,
> > > > > > @@ -1017,6 +1021,28 @@ static int pcf2127_enable_ts(struct device *dev, int ts_id)
> > > > > >  	return ret;
> > > > > >  }
> > > > > >  
> > > > > > +/* Route all interrupt sources to INT A pin. */
> > > > > > +static int pcf2127_configure_interrupt_pins(struct device *dev)
> > > > > > +{
> > > > > > +	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	/* Mask bits need to be cleared to enable corresponding
> > > > > > +	 * interrupt source.
> > > > > > +	 */
> > > > > > +	ret = regmap_write(pcf2127->regmap,
> > > > > > +			   PCF2131_REG_INT_A_MASK1, 0);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret = regmap_write(pcf2127->regmap,
> > > > > > +			   PCF2131_REG_INT_A_MASK2, 0);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > >  static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > > > > >  			 int alarm_irq, const char *name, const struct pcf21xx_config *config)
> > > > > >  {
> > > > > > @@ -1076,6 +1102,15 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > > > > >  		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
> > > > > >  	}
> > > > > >  
> > > > > > +	if (pcf2127->cfg->has_int_a_b) {
> > > > > > +		/* Configure int A/B pins, independently of alarm_irq. */
> > > > > > +		ret = pcf2127_configure_interrupt_pins(dev);
> > > > > > +		if (ret) {
> > > > > > +			dev_err(dev, "failed to configure interrupt pins\n");
> > > > > > +			return ret;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > >  	if (pcf2127->cfg->has_nvmem) {
> > > > > >  		struct nvmem_config nvmem_cfg = {
> > > > > >  			.priv = pcf2127,
> > > > > > -- 
> > > > > > 2.30.2
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > Alexandre Belloni, co-owner and COO, Bootlin
> > > > > Embedded Linux and Kernel engineering
> > > > > https://bootlin.com
> > > > > 
> > > > 
> > > > 
> > > > -- 
> > > > Hugo Villeneuve <hugo@hugovil.com>
> > > 
> > > 
> > > -- 
> > > Hugo Villeneuve
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
