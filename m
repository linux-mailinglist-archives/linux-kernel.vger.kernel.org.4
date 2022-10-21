Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00774607D16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJUQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiJUQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:57:08 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CBB290E1A;
        Fri, 21 Oct 2022 09:56:54 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1364357a691so4261876fac.7;
        Fri, 21 Oct 2022 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zo7dyrvMcPcl4NiHW+MnUrTQJVTlfdJVx4mAsdOPepk=;
        b=CLFsr7rjk4KmpDAj9et7MXXutVkJocGiMMXh9xK7iCSXjESDIntSjLuvtzHZO1vHt3
         WVy64/E4Bh/qAXrhMDyBw8QYTEULYWubdfOqqeiX/fE0jkSqYw3ogw8e7mqnuE20XvB5
         xV+oEwXujJKc+uUWrwstm93aI3Fp64coAHuTegFwBvuSgqXl32By5tTkImM3oUw8Hj/V
         FIhVWYYsyCOqaJ5HxCaB1JyCB+NxbusZjPp3N0g7scR2jfMtCXtUa5WgfDvKKNRpbSDK
         zQDe8qbAILdoj64LttcbwMj/M2UYnVbMTYh5o+lBOzd/gsjPbecnwFFS6b2s4fTaNSTg
         1Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo7dyrvMcPcl4NiHW+MnUrTQJVTlfdJVx4mAsdOPepk=;
        b=s6p0YmJFgVOxzssQqLSKwpnSmERlVbvh9BspijCkYQ8pd1gYCjc+CnBAQF7HAF4RY6
         R4enpJ0O4K+PiA0rKWUrUMilbSqWnn5Ve0WNEgOcwZ5obUPvx3jV/dWwPFkJIzaXIYhx
         drM4Rj7r46LdEk8TDTWCxE3cmBo55mFVT1nm1FwbuwfOOWX0aMm/KVt9HQFNnZmBzbWj
         m4A2s0tgjmxcfihR9sdXSzzMDOU/r0hxRm1ubahU4oO5jpvbHI4t6ybyD4YnDbXUM57D
         BOXenr3oMAqhjDsV0o27SPAlbMNeK8+Ije0qFHbmEm7xmRORF8yl9G+dtJgwLxXot9xS
         JfMw==
X-Gm-Message-State: ACrzQf2f1l6Oi0a2mcNo57AOhReZz+i3IQ6/I9k9mLE3Qc8NcmM1SgMN
        pisbPcj6hhqvK7l5zZ/cluM=
X-Google-Smtp-Source: AMsMyM5/BK/sbLQBlXVzk5HF2eMhMeYeMbv0zFMLgzeR44gvXmpwZliT5lhOZsrwOYZQshsR01h2CQ==
X-Received: by 2002:a05:6870:5804:b0:12b:10f5:da57 with SMTP id r4-20020a056870580400b0012b10f5da57mr29042551oap.135.1666371413395;
        Fri, 21 Oct 2022 09:56:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ca11-20020a056830610b00b0063696cbb6bdsm1272624otb.62.2022.10.21.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:56:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Oct 2022 09:56:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: aspeed: Add pre-timeout interrupt support
Message-ID: <20221021165650.GA1888515@roeck-us.net>
References: <20221021151559.781983-1-eajames@linux.ibm.com>
 <20221021151559.781983-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021151559.781983-2-eajames@linux.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:15:58AM -0500, Eddie James wrote:
> Enable the pre-timeout interrupt if requested by device property.
> 

I am not inclined to accept this patch without detailed explanation.
Why would it make sense and/or be desirable to completely bypass the
watchdog core with this pretimeout support ?

Thanks,
Guenter

> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 53 +++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 0cff2adfbfc9..8e12181a827e 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -5,11 +5,14 @@
>   * Joel Stanley <joel@jms.id.au>
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
>  
> @@ -26,20 +29,32 @@ struct aspeed_wdt {
>  
>  struct aspeed_wdt_config {
>  	u32 ext_pulse_width_mask;
> +	u32 irq_shift;
> +	u32 irq_mask;
>  };
>  
>  static const struct aspeed_wdt_config ast2400_config = {
>  	.ext_pulse_width_mask = 0xff,
> +	.irq_shift = 0,
> +	.irq_mask = 0,
>  };
>  
>  static const struct aspeed_wdt_config ast2500_config = {
>  	.ext_pulse_width_mask = 0xfffff,
> +	.irq_shift = 12,
> +	.irq_mask = GENMASK(31, 12),
> +};
> +
> +static const struct aspeed_wdt_config ast2600_config = {
> +	.ext_pulse_width_mask = 0xfffff,
> +	.irq_shift = 0,
> +	.irq_mask = GENMASK(31, 10),
>  };
>  
>  static const struct of_device_id aspeed_wdt_of_table[] = {
>  	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
>  	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
> -	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2500_config },
> +	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
> @@ -58,6 +73,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>  #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
>  #define   WDT_CTRL_ENABLE		BIT(0)
>  #define WDT_TIMEOUT_STATUS	0x10
> +#define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
>  #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
>  #define WDT_CLEAR_TIMEOUT_STATUS	0x14
>  #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
> @@ -243,6 +259,17 @@ static const struct watchdog_info aspeed_wdt_info = {
>  	.identity	= KBUILD_MODNAME,
>  };
>  
> +static irqreturn_t aspeed_wdt_irq(int irq, void *arg)
> +{
> +	struct aspeed_wdt *wdt = arg;
> +	u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> +
> +	if (status & WDT_TIMEOUT_STATUS_IRQ)
> +		panic("Watchdog pre-timeout IRQ");
> +
> +	return IRQ_NONE;
> +}
> +
>  static int aspeed_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -253,6 +280,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	const char *reset_type;
>  	u32 duration;
>  	u32 status;
> +	u32 timeout = 0;
>  	int ret;
>  
>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> @@ -291,6 +319,27 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(np, "aspeed,ast2400-wdt"))
>  		wdt->ctrl = WDT_CTRL_1MHZ_CLK;
>  
> +	if (config->irq_mask) {
> +		if (!of_property_read_u32(np, "aspeed,pre-timeout-irq-us", &timeout) && timeout) {
> +			int irq =  platform_get_irq(pdev, 0);
> +
> +			if (irq < 0) {
> +				dev_warn(dev, "Couldn't find IRQ: %d\n", irq);
> +				timeout = 0;
> +			} else {
> +				ret = devm_request_irq(dev, irq, aspeed_wdt_irq, IRQF_SHARED,
> +						       dev_name(dev), wdt);
> +				if (ret) {
> +					dev_warn(dev, "Couldn't request IRQ:%d\n", ret);
> +					timeout = 0;
> +				} else {
> +					wdt->ctrl |= ((timeout << config->irq_shift) &
> +						      config->irq_mask) | WDT_CTRL_WDT_INTR;
> +				}
> +			}
> +		}
> +	}
> +
>  	/*
>  	 * Control reset on a per-device basis to ensure the
>  	 * host is not affected by a BMC reboot
> @@ -308,7 +357,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  		else if (!strcmp(reset_type, "system"))
>  			wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
>  				     WDT_CTRL_RESET_SYSTEM;
> -		else if (strcmp(reset_type, "none"))
> +		else if (strcmp(reset_type, "none") && !timeout)
>  			return -EINVAL;
>  	}
>  	if (of_property_read_bool(np, "aspeed,external-signal"))
> -- 
> 2.31.1
> 
