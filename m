Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDA639E66
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiK1ANO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK1ANN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:13:13 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6710548
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 16:13:10 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 643F0C0009;
        Mon, 28 Nov 2022 00:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669594388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCzuXF5jg/2X3rzSh+BtnoZiy+rOjSXQGCsNdbLLfdA=;
        b=g/9+syeAS/skbDrSeBTY9W7/vpJY7W194kkOP0Ib/tErppv+jFZATEx5Z2dAKvbC4KnI1R
        46fJFopEmb7/O7AmOLtVa+enceSkmsptqDiS2uUGcBc7BhSLvGTcKzY5UP4VUojxiq/Y7F
        QrBQmv5C6y6HXPI5MmP/yeyePUSosELhy4Tq2VqPngIZAJk3IsnuyqpghEilEDHuwdnvi7
        VtT+Zs+PnvoExwgQB/H4PyCcazqPf+ZPWnJSQh/6jrF8iHfcJ6wa/K6MUbbbjR+C9cXMhp
        ENfIL2WxcoWjGmHyfLU0qwK+dF8/xXCJAlAN01vfIzRPUjXi2YwQXgqWgfVwHQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mvebu: switch to using gpiod API in pm-board code
In-Reply-To: <Y3Qc6et/d+vhd71Q@google.com>
References: <Y3Qc6et/d+vhd71Q@google.com>
Date:   Mon, 28 Nov 2022 01:13:08 +0100
Message-ID: <87lenw7x7v.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> This switches PM code to use the newer gpiod API instead of legacy
> gpio API that we want to retire.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/mach-mvebu/pm-board.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
> index 7fa1806acd65..beec22e17e89 100644
> --- a/arch/arm/mach-mvebu/pm-board.c
> +++ b/arch/arm/mach-mvebu/pm-board.c
> @@ -8,19 +8,19 @@
>   */
>  
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_gpio.h>
>  #include <linux/slab.h>
>  #include "common.h"
>  
>  #define ARMADA_PIC_NR_GPIOS 3
>  
>  static void __iomem *gpio_ctrl;
> -static int pic_gpios[ARMADA_PIC_NR_GPIOS];
> +static struct gpio_desc *pic_gpios[ARMADA_PIC_NR_GPIOS];
>  static int pic_raw_gpios[ARMADA_PIC_NR_GPIOS];
>  
>  static void mvebu_armada_pm_enter(void __iomem *sdram_reg, u32 srcmd)
> @@ -90,27 +90,17 @@ static int __init mvebu_armada_pm_init(void)
>  		char *name;
>  		struct of_phandle_args args;
>  
> -		pic_gpios[i] = of_get_named_gpio(np, "ctrl-gpios", i);
> -		if (pic_gpios[i] < 0) {
> -			ret = -ENODEV;
> -			goto out;
> -		}
> -
>  		name = kasprintf(GFP_KERNEL, "pic-pin%d", i);
>  		if (!name) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
>  
> -		ret = gpio_request(pic_gpios[i], name);
> -		if (ret < 0) {
> -			kfree(name);
> -			goto out;
> -		}
> -
> -		ret = gpio_direction_output(pic_gpios[i], 0);
> -		if (ret < 0) {
> -			gpio_free(pic_gpios[i]);
> +		pic_gpios[i] = fwnode_gpiod_get_index(of_fwnode_handle(np),
> +						      "ctrl", i, GPIOD_OUT_HIGH,
> +						      name);
> +		ret = PTR_ERR_OR_ZERO(pic_gpios[i]);
> +		if (ret) {
>  			kfree(name);
>  			goto out;
>  		}
> @@ -118,7 +108,7 @@ static int __init mvebu_armada_pm_init(void)
>  		ret = of_parse_phandle_with_fixed_args(np, "ctrl-gpios", 2,
>  						       i, &args);
>  		if (ret < 0) {
> -			gpio_free(pic_gpios[i]);
> +			gpiod_put(pic_gpios[i]);
>  			kfree(name);
>  			goto out;
>  		}
> -- 
> 2.38.1.431.g37b22c650d-goog
>
>
> -- 
> Dmitry

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
