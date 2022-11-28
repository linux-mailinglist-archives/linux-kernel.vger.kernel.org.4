Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5E63A337
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiK1IjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiK1IjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:39:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE29EDF42;
        Mon, 28 Nov 2022 00:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E7EFB80C81;
        Mon, 28 Nov 2022 08:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AE5C433D6;
        Mon, 28 Nov 2022 08:39:05 +0000 (UTC)
Message-ID: <9098a44c-8551-f42c-ac19-15ffa7174e37@xs4all.nl>
Date:   Mon, 28 Nov 2022 09:39:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/4] media: i2c: s5c73m3: remove support for platform data
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
 <20221115221145.2550572-3-dmitry.torokhov@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221115221145.2550572-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I received multiple patches for this driver that switch it to using the gpiod
API. I chose to go with Linus' patch [1]. Primarily because that one was
reviewed/acked by more people.

That means also that this patch that removes the platform data no longer applies
cleanly.

Can you post a v2 of this patch that sits on top of [1]?

Thanks!

	Hans

[1]: https://patchwork.linuxtv.org/project/linux-media/patch/20221108100604.1500909-1-linus.walleij@linaro.org/

On 15/11/2022 23:11, Dmitry Torokhov wrote:
> There are no existing users of s5c73m3_platform_data in the tree, and
> new users shoudl either be using device tree, ACPI, or static device
> properties, so let's remove it from the driver.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/media/i2c/s5c73m3/s5c73m3-core.c  | 19 ++------
>  drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c |  2 -
>  drivers/media/i2c/s5c73m3/s5c73m3.h       |  6 ++-
>  include/media/i2c/s5c73m3.h               | 56 -----------------------
>  4 files changed, 9 insertions(+), 74 deletions(-)
>  delete mode 100644 include/media/i2c/s5c73m3.h
> 
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> index d96ba58ce1e5..561c1a1583ac 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> @@ -27,7 +27,6 @@
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-subdev.h>
>  #include <media/v4l2-mediabus.h>
> -#include <media/i2c/s5c73m3.h>
>  #include <media/v4l2-fwnode.h>
>  
>  #include "s5c73m3.h"
> @@ -1592,26 +1591,16 @@ static int s5c73m3_parse_gpios(struct s5c73m3 *state)
>  	return 0;
>  }
>  
> -static int s5c73m3_get_platform_data(struct s5c73m3 *state)
> +static int s5c73m3_get_dt_data(struct s5c73m3 *state)
>  {
>  	struct device *dev = &state->i2c_client->dev;
> -	const struct s5c73m3_platform_data *pdata = dev->platform_data;
>  	struct device_node *node = dev->of_node;
>  	struct device_node *node_ep;
>  	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
>  	int ret;
>  
> -	if (!node) {
> -		if (!pdata) {
> -			dev_err(dev, "Platform data not specified\n");
> -			return -EINVAL;
> -		}
> -
> -		state->mclk_frequency = pdata->mclk_frequency;
> -		state->gpio[STBY] = pdata->gpio_stby;
> -		state->gpio[RSET] = pdata->gpio_reset;
> -		return 0;
> -	}
> +	if (!node)
> +		return -EINVAL;
>  
>  	state->clock = devm_clk_get(dev, S5C73M3_CLK_NAME);
>  	if (IS_ERR(state->clock))
> @@ -1666,7 +1655,7 @@ static int s5c73m3_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	state->i2c_client = client;
> -	ret = s5c73m3_get_platform_data(state);
> +	ret = s5c73m3_get_dt_data(state);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
> index 141ad0ba7f5a..1c8103670fa2 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
> @@ -10,7 +10,6 @@
>  #include <linux/sizes.h>
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
> -#include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/media.h>
> @@ -24,7 +23,6 @@
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-subdev.h>
>  #include <media/v4l2-mediabus.h>
> -#include <media/i2c/s5c73m3.h>
>  
>  #include "s5c73m3.h"
>  
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3.h b/drivers/media/i2c/s5c73m3/s5c73m3.h
> index c3fcfdd3ea66..d68528898249 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3.h
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
> @@ -15,7 +15,6 @@
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-subdev.h>
> -#include <media/i2c/s5c73m3.h>
>  
>  #define DRIVER_NAME			"S5C73M3"
>  
> @@ -357,6 +356,11 @@ enum s5c73m3_gpio_id {
>  	GPIO_NUM,
>  };
>  
> +struct s5c73m3_gpio {
> +	int gpio;
> +	int level;
> +};
> +
>  enum s5c73m3_resolution_types {
>  	RES_ISP,
>  	RES_JPEG,
> diff --git a/include/media/i2c/s5c73m3.h b/include/media/i2c/s5c73m3.h
> deleted file mode 100644
> index a51f1025ba1c..000000000000
> --- a/include/media/i2c/s5c73m3.h
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -/*
> - * Samsung LSI S5C73M3 8M pixel camera driver
> - *
> - * Copyright (C) 2012, Samsung Electronics, Co., Ltd.
> - * Sylwester Nawrocki <s.nawrocki@samsung.com>
> - * Andrzej Hajda <a.hajda@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -#ifndef MEDIA_S5C73M3__
> -#define MEDIA_S5C73M3__
> -
> -#include <linux/videodev2.h>
> -#include <media/v4l2-mediabus.h>
> -
> -/**
> - * struct s5c73m3_gpio - data structure describing a GPIO
> - * @gpio:  GPIO number
> - * @level: indicates active state of the @gpio
> - */
> -struct s5c73m3_gpio {
> -	int gpio;
> -	int level;
> -};
> -
> -/**
> - * struct s5c73m3_platform_data - s5c73m3 driver platform data
> - * @mclk_frequency: sensor's master clock frequency in Hz
> - * @gpio_reset:  GPIO driving RESET pin
> - * @gpio_stby:   GPIO driving STBY pin
> - * @bus_type:    bus type
> - * @nlanes:      maximum number of MIPI-CSI lanes used
> - * @horiz_flip:  default horizontal image flip value, non zero to enable
> - * @vert_flip:   default vertical image flip value, non zero to enable
> - */
> -
> -struct s5c73m3_platform_data {
> -	unsigned long mclk_frequency;
> -
> -	struct s5c73m3_gpio gpio_reset;
> -	struct s5c73m3_gpio gpio_stby;
> -
> -	enum v4l2_mbus_type bus_type;
> -	u8 nlanes;
> -	u8 horiz_flip;
> -	u8 vert_flip;
> -};
> -
> -#endif /* MEDIA_S5C73M3__ */

