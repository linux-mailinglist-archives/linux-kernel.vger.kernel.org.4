Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6362D60C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbiKQJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiKQJLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:11:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9206B59171
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:11:24 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gv23so3520295ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2kfn5b4knzE1+oQl9jwi6wbBS5Fy4A8mt/gKYPzDDY=;
        b=I1BLtoq75dsLJakBJStQd2/w0ENDCPXS+L+xq1pB4I9guAn6qlcm88vjGVcjgJnxZb
         QW+yP9nFhTTqUNrhbGDxFeJF+k1MKSu5GMT2upczZt4walVJtMB2r5llNOgeFYroAzfl
         QPnEMw7mmn3bYkZn7JD4337mmunWQ266bJ1EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2kfn5b4knzE1+oQl9jwi6wbBS5Fy4A8mt/gKYPzDDY=;
        b=K5rlYQ8uMc+OIwTrwmTpt3yTLI9nc2Vf+uW8IiqOa/qRPzNlJsPnIbo2sizDd4yx+T
         9kz+eYykk/q7Dz/0ODdXFicbRtgC4ukefLc8qOEcyAG6Ktn3hI27/ObRAl8cYLLzS03m
         LC4pxAK0rHUnrYVFP3HJ+yfoBHGJAPjFmJq9YKdJHffngp5H8QqW/LvX5CGvWOIStkEx
         yfHOYugcIXl+8N3W5mNyk3zXxIJ9id6CV6YRZyrWXvL1EJSk1fRCK2ZZaljmr9Rbch5L
         hk3hibnaTlyv9W3ubRY/hth3GdtUtKMyPzaBr9w670wC+wcYnQ9DVMGP/88CtaPzP21v
         j/IA==
X-Gm-Message-State: ANoB5pmgdSiak7TSRehr4G44/5v86UW4pmU2hoQrb7JDVbBCxrp4zBli
        m1/AyofRp1VVCFbvhriE4vb+/w==
X-Google-Smtp-Source: AA0mqf5qcvcHpVnnzYypXRCSlUwa0bOZTJnMKZcv3zxTRnMxqPi8rz92yOtpchQ4rvn3UxUG9pT7zA==
X-Received: by 2002:a17:907:778c:b0:7ad:79c0:4669 with SMTP id ky12-20020a170907778c00b007ad79c04669mr1387919ejc.395.1668676283087;
        Thu, 17 Nov 2022 01:11:23 -0800 (PST)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-54-207.cust.vodafonedsl.it. [188.217.54.207])
        by smtp.gmail.com with ESMTPSA id n23-20020a05640204d700b0045c47b2a800sm257929edw.67.2022.11.17.01.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 01:11:22 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:11:20 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/4] media: i2c: s5k6a3: switch to using gpiod API
Message-ID: <20221117091120.GA2725180@tom-ThinkPad-T14s-Gen-2i>
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Nov 15, 2022 at 02:11:42PM -0800, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes one of the last uses of of_get_gpio_flags().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/media/i2c/s5k6a3.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/i2c/s5k6a3.c b/drivers/media/i2c/s5k6a3.c
> index a4efd6d10b43..ef6673b10580 100644
> --- a/drivers/media/i2c/s5k6a3.c
> +++ b/drivers/media/i2c/s5k6a3.c
> @@ -9,12 +9,12 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -59,7 +59,7 @@ struct s5k6a3 {
>  	struct v4l2_subdev subdev;
>  	struct media_pad pad;
>  	struct regulator_bulk_data supplies[S5K6A3_NUM_SUPPLIES];
> -	int gpio_reset;
> +	struct gpio_desc *gpio_reset;
>  	struct mutex lock;
>  	struct v4l2_mbus_framefmt format;
>  	struct clk *clock;
> @@ -216,11 +216,11 @@ static int __s5k6a3_power_on(struct s5k6a3 *sensor)
>  			goto error_clk;
>  	}
>  
> -	gpio_set_value(sensor->gpio_reset, 1);
> +	gpiod_set_value_cansleep(sensor->gpio_reset, 0);
>  	usleep_range(600, 800);
> -	gpio_set_value(sensor->gpio_reset, 0);
> +	gpiod_set_value_cansleep(sensor->gpio_reset, 1);
>  	usleep_range(600, 800);
> -	gpio_set_value(sensor->gpio_reset, 1);
> +	gpiod_set_value_cansleep(sensor->gpio_reset, 0);
>  
>  	/* Delay needed for the sensor initialization */
>  	msleep(20);
> @@ -240,7 +240,7 @@ static int __s5k6a3_power_off(struct s5k6a3 *sensor)
>  {
>  	int i;
>  
> -	gpio_set_value(sensor->gpio_reset, 0);
> +	gpiod_set_value_cansleep(sensor->gpio_reset, 1);
>  
>  	for (i = S5K6A3_NUM_SUPPLIES - 1; i >= 0; i--)
>  		regulator_disable(sensor->supplies[i].consumer);
> @@ -285,32 +285,24 @@ static int s5k6a3_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct s5k6a3 *sensor;
>  	struct v4l2_subdev *sd;
> -	int gpio, i, ret;
> +	int i, ret;
>  
>  	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
>  	if (!sensor)
>  		return -ENOMEM;
>  
>  	mutex_init(&sensor->lock);
> -	sensor->gpio_reset = -EINVAL;
> -	sensor->clock = ERR_PTR(-EINVAL);
>  	sensor->dev = dev;
>  
>  	sensor->clock = devm_clk_get(sensor->dev, S5K6A3_CLK_NAME);
>  	if (IS_ERR(sensor->clock))
>  		return PTR_ERR(sensor->clock);
>  
> -	gpio = of_get_gpio_flags(dev->of_node, 0, NULL);
> -	if (!gpio_is_valid(gpio))
> -		return gpio;
> -
> -	ret = devm_gpio_request_one(dev, gpio, GPIOF_OUT_INIT_LOW,
> -						S5K6A3_DRV_NAME);
> -	if (ret < 0)
> +	sensor->gpio_reset = devm_gpiod_get(dev, NULL, GPIOD_OUT_HIGH);
> +	ret = PTR_ERR_OR_ZERO(sensor->gpio_reset);
> +	if (ret)
>  		return ret;

Patch looks good to me!
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

For the future I think would be nice use "reset-gpios" name in dts.
Then call:

	devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);

But this is a todo :)

Regards,
Tommaso

>  
> -	sensor->gpio_reset = gpio;
> -
>  	if (of_property_read_u32(dev->of_node, "clock-frequency",
>  				 &sensor->clock_frequency)) {
>  		sensor->clock_frequency = S5K6A3_DEFAULT_CLK_FREQ;
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
