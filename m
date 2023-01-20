Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB1675AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjATRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjATRBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:01:41 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291367B2EF;
        Fri, 20 Jan 2023 09:01:38 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5409EE0006;
        Fri, 20 Jan 2023 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674234097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rWvmXzTww6HxI3gqgU+pPYPa1KXrXgPdl1hicaDAgY=;
        b=Z7E+couE8D+3ZE7aCBPbWVktrn7WmlIFPrx/MpZT0ZD5sm9H+WhU/uHTEnYJYLBeSOtH1L
        Fcg6T3Lzhpmb2krpEBHa5e20SnlMy9oZzurwtLJHUxUp1kn8NGRR4zruzKb37Qp+WZI0El
        6MPKQvt5Ux2hiWhogxZaC5RWIlm4h227178r5wIMHKEGpeChTP9H4lz68CYJpM7028m07n
        i/ukHKQ90qPcT2OJ8v7nNMWZjmmCHXOKog3Rx1uIjDPTRpJ8vb84XbppIdKhfzZ2pbVGai
        F3m+ZMsjsQbxYXWFvQdzQwfFaS3/0Fqxn8DqvVqnmggJgzLGrrPMcKC2l2OfMw==
Date:   Fri, 20 Jan 2023 18:01:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 10/14] rtc: pcf2127: read and validate PCF2131 device
 signature
Message-ID: <Y8rI7/umLv/h64cN@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-11-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215150214.1109074-11-hugo@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2022 10:02:11-0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Make sure the device we are probing is really the device we are
> interested in.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 241189ee4a05..e4b78b9c03f9 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -193,11 +193,13 @@ struct pcf21xx_config {
>  	unsigned int has_nvmem:1;
>  	unsigned int has_bit_wd_ctl_cd0:1;
>  	unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
> +	unsigned int has_reset_reg:1; /* If variant has a reset register. */
>  	u8 regs_td_base; /* Time/data base registers. */
>  	u8 regs_alarm_base; /* Alarm function base registers. */
>  	u8 reg_wd_ctl; /* Watchdog control register. */
>  	u8 reg_wd_val; /* Watchdog value register. */
>  	u8 reg_clkout; /* Clkout register. */
> +	u8 reg_reset;  /* Reset register if available. */
>  	unsigned int ts_count;
>  	struct pcf21xx_ts_config ts[4];
>  	struct attribute_group attribute_group;
> @@ -882,6 +884,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>  		.has_nvmem = 1,
>  		.has_bit_wd_ctl_cd0 = 1,
>  		.has_int_a_b = 0,
> +		.has_reset_reg = 0,
>  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
>  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> @@ -906,6 +909,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>  		.has_nvmem = 0,
>  		.has_bit_wd_ctl_cd0 = 0,
>  		.has_int_a_b = 0,
> +		.has_reset_reg = 0,
>  		.regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>  		.regs_alarm_base = PCF2127_REG_ALARM_BASE,
>  		.reg_wd_ctl = PCF2127_REG_WD_CTL,
> @@ -930,11 +934,13 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>  		.has_nvmem = 0,
>  		.has_bit_wd_ctl_cd0 = 0,
>  		.has_int_a_b = 1,
> +		.has_reset_reg = 1,
>  		.regs_td_base = PCF2131_REG_TIME_DATE_BASE,
>  		.regs_alarm_base = PCF2131_REG_ALARM_BASE,
>  		.reg_wd_ctl = PCF2131_REG_WD_CTL,
>  		.reg_wd_val = PCF2131_REG_WD_VAL,
>  		.reg_clkout = PCF2131_REG_CLKOUT,
> +		.reg_reset  = PCF2131_REG_SR_RESET,
>  		.ts_count = 4,
>  		.ts[0] = {
>  			.regs_base = PCF2131_REG_TS1_BASE,
> @@ -1075,6 +1081,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
>  	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
>  
> +	/* Read device signature if available. */
> +	if (pcf2127->cfg->has_reset_reg) {
> +		ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_reset, &val);
> +		if (ret < 0) {
> +			dev_err(dev, "reading RESET register failed\n");

This is too verbose, please cut down on the number of strings you are
adding.

> +			return ret;
> +		}
> +
> +		if (val != PCF2131_SR_RESET_READ_PATTERN) {
> +			dev_err(dev, "invalid device signature: $%02X\n", (u8)val);

I'm also not convinced this is actually useful. This may have to be
updated for the next rtc the driver will support and what if this
contradicts what the device tree is claiming at this address?

> +			return -ENODEV;
> +		}
> +	}
> +
>  	if (alarm_irq > 0) {
>  		unsigned long flags;
>  
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
