Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47168675A95
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjATQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjATQ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:57:17 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A8D7B2CC;
        Fri, 20 Jan 2023 08:56:52 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 17A60100007;
        Fri, 20 Jan 2023 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674233801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HF1zcyrDbSQAeGSxKbh2vrY+GncQaEmDCUhB8D21gCo=;
        b=MI7kNqGSatGfQSpefBSK3zCXWaWNQXihqIOmpuEQjTfhLCjwYTwJ6M1OBo2RVKK80IcOkz
        5qzrFwsRv9Ictyt5oBJh1tOCcxvQbUbUwKboBTxDEukZ9mS18HTUD1F/ecpRnG9q/G6kr1
        XEXu6vLMbEEos5+cRvqrQjHS3DZ10Or29DIJHj+wbOX4ueyXKfDuSYDBPLFUpPcgUdMCue
        /AEEuBob4VCgXeapkpHVMljQuzlyLeaxxlxtRtVjvJI1ebgT0p006gLf0IYJNHVEQSlj7m
        GCgdImiae0MPlZVrSr9r0+NzqFrTL22auiZ3IqFv0K6zk5OOcEmPuLiri0/7dQ==
Date:   Fri, 20 Jan 2023 17:56:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 08/14] rtc: pcf2127: add support for PCF2131
 interrupts on output INT_A
Message-ID: <Y8rHx8U4peB+fnW8@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-9-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215150214.1109074-9-hugo@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2022 10:02:09-0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The PCF2127 and PCF2129 have one output interrupt pin. The PCF2131 has
> two, named INT_A and INT_B. The hardware support that any interrupt
> source can be routed to either one or both of them.
> 
> Force all interrupt sources to go to the INT A pin.
> 
> Support to route any interrupt source to INT A/B pins is not supported
> by this driver at the moment.
> 

The main issue with this is that this will created a breaking change
once someone needs support for INTB

> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 4148e135f935..68af4d0438b8 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -191,6 +191,7 @@ struct pcf21xx_config {
>  	int max_register;
>  	unsigned int has_nvmem:1;
>  	unsigned int has_bit_wd_ctl_cd0:1;
> +	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
>  	u8 regs_td_base; /* Time/data base registers. */
>  	u8 regs_alarm_base; /* Alarm function base registers. */
>  	u8 reg_wd_ctl; /* Watchdog control register. */
> @@ -879,6 +880,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>  		.max_register = 0x1d,
>  		.has_nvmem = 1,
>  		.has_bit_wd_ctl_cd0 = 1,
> +		.has_int_a_b = 0,
>  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
>  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> @@ -902,6 +904,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>  		.max_register = 0x19,
>  		.has_nvmem = 0,
>  		.has_bit_wd_ctl_cd0 = 0,
> +		.has_int_a_b = 0,
>  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
>  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> @@ -925,6 +928,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>  		.max_register = 0x36,
>  		.has_nvmem = 0,
>  		.has_bit_wd_ctl_cd0 = 0,
> +		.has_int_a_b = 1,
>  		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
>  		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
>  		.reg_wd_ctl = PCF2131_REG_WD_CTL,
> @@ -1017,6 +1021,28 @@ static int pcf2127_enable_ts(struct device *dev, int ts_id)
>  	return ret;
>  }
>  
> +/* Route all interrupt sources to INT A pin. */
> +static int pcf2127_configure_interrupt_pins(struct device *dev)
> +{
> +	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Mask bits need to be cleared to enable corresponding
> +	 * interrupt source.
> +	 */
> +	ret = regmap_write(pcf2127->regmap,
> +			   PCF2131_REG_INT_A_MASK1, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(pcf2127->regmap,
> +			   PCF2131_REG_INT_A_MASK2, 0);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
>  static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  			 int alarm_irq, const char *name, const struct pcf21xx_config *config)
>  {
> @@ -1076,6 +1102,15 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
>  	}
>  
> +	if (pcf2127->cfg->has_int_a_b) {
> +		/* Configure int A/B pins, independently of alarm_irq. */
> +		ret = pcf2127_configure_interrupt_pins(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to configure interrupt pins\n");
> +			return ret;
> +		}
> +	}
> +
>  	if (pcf2127->cfg->has_nvmem) {
>  		struct nvmem_config nvmem_cfg = {
>  			.priv = pcf2127,
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
