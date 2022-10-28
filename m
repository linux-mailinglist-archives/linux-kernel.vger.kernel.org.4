Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2895A61097F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ1FFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJ1FFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:05:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CDE96221
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:05:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so3876338plz.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyMK7y8RQqNmNtG3Q5ktkxVubz+gBEtfWLQrdJqX2zo=;
        b=gErV0eXBCE/xHbxTMfsdEvDxGOEn3fGY/8zejUHjfMv3FrLyfBoFOQBzLJJrN1RVYM
         od04CkKdyLcUWs3j/YIrSlhipPOUBVGuJn4oQx3weiiOIniaAYnpn63W/vYVlcrI6w6/
         36zjQjMcGjdOyckUR+WWBGzqp606NphecQkFtF9DQxpHeFNKeq2gLrKmcGpNRCICML9s
         w7YUtbZZTugKuQnEOCAsuef+Sy5mwVZ410aXGsPdulRVPPYPd5wpiBFCoaHoh9MGpwgA
         G59uo4LOug8QZxy9MmSkv7hdFuKWGLnvH5zJCSWboZzRBdSInH304kSDKaVLyk18H8zF
         UKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyMK7y8RQqNmNtG3Q5ktkxVubz+gBEtfWLQrdJqX2zo=;
        b=B/9ogKfyNFyKCk7taYNNjbHtfFTrbJadSBWqp9dlQdfOgFzHmUulpmaX+KzUwhJB5D
         KlwGoD/GS3jrotq412VTm6+LPlnEtanydY/yZ5NqA9ELt4XRhSiNVpqIdKWjuOR6Orw6
         2vym4QheSr7P8Fj92Mdju6SpYS1CVr/PLV/JIpLvJIAERu3px9D99K7fH3lYI3r1eXR1
         8UtCs8ime0A7uljHMywVft1sGZ4QH1ihgpDqL6DGiyKNnlDbyQWS/ELFsYBlIZkvlsKm
         7wc3uT0bUIFIj7roLf36rb3isX+gtR2b1DRJgxq73xx3TmuxlRRylx/jbr4M5mPncnvL
         ZIjQ==
X-Gm-Message-State: ACrzQf0sYURxYBmcGo4s0N/OFz2arWTw6cC76H4KmvGTTal3Pyhdbe2p
        QPTHLie5eIdCDi9aNVHp/ztykiShfno=
X-Google-Smtp-Source: AMsMyM5Hrxu+dB6bgfe7cCuQnitxTrwwQynOFFJMD2+fwZ+wwoOFbwZ6omcSSAE1Uoamrp4D7U57Kg==
X-Received: by 2002:a17:902:ec8e:b0:186:de89:7f66 with SMTP id x14-20020a170902ec8e00b00186de897f66mr11629707plg.160.1666933540074;
        Thu, 27 Oct 2022 22:05:40 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ea9a:801b:ed52:2db1])
        by smtp.gmail.com with ESMTPSA id z12-20020a63b90c000000b004277f43b736sm1829407pge.92.2022.10.27.22.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 22:05:39 -0700 (PDT)
Date:   Thu, 27 Oct 2022 22:05:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/warp: switch to using gpiod API
Message-ID: <Y1tjIOCohHF3faQb@google.com>
References: <YzKSLcrYmV5kjyeX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzKSLcrYmV5kjyeX@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:03:25PM -0700, Dmitry Torokhov wrote:
> This switches PIKA Warp away from legacy gpio API and to newer gpiod
> API, so that we can eventually deprecate the former.
> 
> Because LEDs are normally driven by leds-gpio driver, but the
> platform code also wants to access the LEDs during thermal shutdown,
> and gpiod API does not allow locating GPIO without requesting it,
> the platform code is now responsible for locating GPIOs through device
> tree and requesting them. It then constructs platform data for
> leds-gpio platform device and registers it. This allows platform
> code to retain access to LED GPIO descriptors and use them when needed.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Gentle ping on this... Could I get a feedback if this is acceptable or
if you want me to rework this somehow?

Thanks!

> ---
> 
> Compiled only, no hardware to test this.
> 
>  arch/powerpc/boot/dts/warp.dts    |   4 +-
>  arch/powerpc/platforms/44x/warp.c | 105 ++++++++++++++++++++++++++----
>  2 files changed, 94 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
> index b4f32740870e..aa62d08e97c2 100644
> --- a/arch/powerpc/boot/dts/warp.dts
> +++ b/arch/powerpc/boot/dts/warp.dts
> @@ -258,14 +258,12 @@ GPIO1: gpio@ef600c00 {
>  			};
>  
>  			power-leds {
> -				compatible = "gpio-leds";
> +				compatible = "warp-power-leds";
>  				green {
>  					gpios = <&GPIO1 0 0>;
> -					default-state = "keep";
>  				};
>  				red {
>  					gpios = <&GPIO1 1 0>;
> -					default-state = "keep";
>  				};
>  			};
>  
> diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
> index f03432ef010b..cefa313c09f0 100644
> --- a/arch/powerpc/platforms/44x/warp.c
> +++ b/arch/powerpc/platforms/44x/warp.c
> @@ -5,15 +5,17 @@
>   * Copyright (c) 2008-2009 PIKA Technologies
>   *   Sean MacLennan <smaclennan@pikatech.com>
>   */
> +#include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/of_platform.h>
>  #include <linux/kthread.h>
> +#include <linux/leds.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  
> @@ -92,8 +94,6 @@ static int __init warp_post_info(void)
>  
>  static LIST_HEAD(dtm_shutdown_list);
>  static void __iomem *dtm_fpga;
> -static unsigned green_led, red_led;
> -
>  
>  struct dtm_shutdown {
>  	struct list_head list;
> @@ -101,7 +101,6 @@ struct dtm_shutdown {
>  	void *arg;
>  };
>  
> -
>  int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
>  {
>  	struct dtm_shutdown *shutdown;
> @@ -132,6 +131,35 @@ int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
>  	return -EINVAL;
>  }
>  
> +#define WARP_GREEN_LED	0
> +#define WARP_RED_LED	1
> +
> +static struct gpio_led warp_gpio_led_pins[] = {
> +	[WARP_GREEN_LED] = {
> +		.name		= "green",
> +		.default_state	= LEDS_DEFSTATE_KEEP,
> +		.gpiod		= NULL, /* to be filled by pika_setup_leds() */
> +	},
> +	[WARP_RED_LED] = {
> +		.name		= "red",
> +		.default_state	= LEDS_DEFSTATE_KEEP,
> +		.gpiod		= NULL, /* to be filled by pika_setup_leds() */
> +	},
> +};
> +
> +static struct gpio_led_platform_data warp_gpio_led_data = {
> +	.leds		= warp_gpio_led_pins,
> +	.num_leds	= ARRAY_SIZE(warp_gpio_led_pins),
> +};
> +
> +static struct platform_device warp_gpio_leds = {
> +	.name	= "leds-gpio",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data = &warp_gpio_led_data,
> +	},
> +};
> +
>  static irqreturn_t temp_isr(int irq, void *context)
>  {
>  	struct dtm_shutdown *shutdown;
> @@ -139,7 +167,7 @@ static irqreturn_t temp_isr(int irq, void *context)
>  
>  	local_irq_disable();
>  
> -	gpio_set_value(green_led, 0);
> +	gpiod_set_value(warp_gpio_led_pins[WARP_GREEN_LED].gpiod, 0);
>  
>  	/* Run through the shutdown list. */
>  	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
> @@ -153,7 +181,7 @@ static irqreturn_t temp_isr(int irq, void *context)
>  			out_be32(dtm_fpga + 0x14, reset);
>  		}
>  
> -		gpio_set_value(red_led, value);
> +		gpiod_set_value(warp_gpio_led_pins[WARP_RED_LED].gpiod, value);
>  		value ^= 1;
>  		mdelay(500);
>  	}
> @@ -162,25 +190,78 @@ static irqreturn_t temp_isr(int irq, void *context)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * Because green and red power LEDs are normally driven by leds-gpio driver,
> + * but in case of critical temperature shutdown we want to drive them
> + * ourselves, we acquire both and then create leds-gpio platform device
> + * ourselves, instead of doing it through device tree. This way we can still
> + * keep access to the gpios and use them when needed.
> + */
>  static int pika_setup_leds(void)
>  {
>  	struct device_node *np, *child;
> +	struct gpio_desc *gpio;
> +	struct gpio_led *led;
> +	int led_count = 0;
> +	int error;
> +	int i;
>  
> -	np = of_find_compatible_node(NULL, NULL, "gpio-leds");
> +	np = of_find_compatible_node(NULL, NULL, "warp-power-leds");
>  	if (!np) {
>  		printk(KERN_ERR __FILE__ ": Unable to find leds\n");
>  		return -ENOENT;
>  	}
>  
> -	for_each_child_of_node(np, child)
> -		if (of_node_name_eq(child, "green"))
> -			green_led = of_get_gpio(child, 0);
> -		else if (of_node_name_eq(child, "red"))
> -			red_led = of_get_gpio(child, 0);
> +	for_each_child_of_node(np, child) {
> +		for (i = 0; i < ARRAY_SIZE(warp_gpio_led_pins); i++) {
> +			led = &warp_gpio_led_pins[i];
> +
> +			if (!of_node_name_eq(child, led->name))
> +				continue;
> +
> +			if (led->gpiod) {
> +				printk(KERN_ERR __FILE__ ": %s led has already been defined\n",
> +				       led->name);
> +				continue;
> +			}
> +
> +			gpio = fwnode_gpiod_get_index(of_fwnode_handle(child),
> +						      NULL, 0, GPIOD_ASIS,
> +						      led->name);
> +			error = PTR_ERR_OR_ZERO(gpio);
> +			if (error) {
> +				printk(KERN_ERR __FILE__ ": Failed to get %s led gpio: %d\n",
> +				       led->name, error);
> +				of_node_put(child);
> +				goto err_cleanup_pins;
> +			}
> +
> +			led->gpiod = gpio;
> +			led_count++;
> +		}
> +	}
>  
>  	of_node_put(np);
>  
> +	/* Skip device registration if no leds have been defined */
> +	if (led_count) {
> +		error = platform_device_register(&warp_gpio_leds);
> +		if (error) {
> +			printk(KERN_ERR __FILE__ ": Unable to add leds-gpio: %d\n",
> +			       error);
> +			goto err_cleanup_pins;
> +		}
> +	}
> +
>  	return 0;
> +
> +err_cleanup_pins:
> +	for (i = 0; i < ARRAY_SIZE(warp_gpio_led_pins); i++) {
> +		led = &warp_gpio_led_pins[i];
> +		gpiod_put(led->gpiod);
> +		led->gpiod = NULL;
> +	}
> +	return error;
>  }
>  
>  static void pika_setup_critical_temp(struct device_node *np,
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
> 
> -- 
> Dmitry

-- 
Dmitry
