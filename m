Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BEA62D8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiKQLHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiKQLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:07:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19F338
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:06:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id i10so4157958ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKgM/zNKWqUVK/YS7AkDwIL3bJeOo4TqqMJYYRq727w=;
        b=AYxzsJDSiH+j6k7CwbxoeqAntrb08MZIJ5uTgtkViVaKHEQ2WyfKAL/n4i5KPYEXO9
         NyRznaDGMnxvPXfDRviVzMTlsJGsSXVETfcdxqOE9S6IXDxrJGe72xavLN0akwXl9nCH
         cr2olyOizUHHxWO5oHxN4m09UJCQCGDFSu8VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKgM/zNKWqUVK/YS7AkDwIL3bJeOo4TqqMJYYRq727w=;
        b=P5iuDFhSqbjAs2QEtBQRXqG5rRevzx7r68uL0aFxZgCtIphjRZUNIuOoWraEgDwM6/
         WFuEEM3EkAEMjOXv/ub3VTR58OZKGHNIJRPtuEMJ/vurb1nYMxbO2pD6ptyotpr76s1o
         fb3bMxlyEqbEZAHEQ6O1+PkAtWINEEGQob09RLRI47vB7DxH3TLYhUVSHrkzmMdcMlcy
         vfF4qCb7EK2ARyrLL3Aq9RX0zY9aXX1Fr62qfmo3pWFNYRflUL7omMt6cEToXvcsy3WA
         4nQ3S9LNWrg+l/BN/NdPQW16qOz4TncA44/MF4ALKiPKW8hka2KFXTL9B1ulA3NN9O2R
         zF5g==
X-Gm-Message-State: ANoB5pmwl0bQ9il+e1vtgdzqKem2wzh/kUsqUiNNU1GYkiINyWPamwoK
        AjSrwsXDgWgc6dCwSSv46rkbTQ==
X-Google-Smtp-Source: AA0mqf5T7UE7o4mqOu7ortU1b6vQCQCGCiFs0l8Rvuz/T+s4FRiG/+MZ2rp39BO4cBZASzARaZQ41g==
X-Received: by 2002:a17:907:1183:b0:7ae:25ba:5e4b with SMTP id uz3-20020a170907118300b007ae25ba5e4bmr1710068ejb.724.1668683216078;
        Thu, 17 Nov 2022 03:06:56 -0800 (PST)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-54-207.cust.vodafonedsl.it. [188.217.54.207])
        by smtp.gmail.com with ESMTPSA id s19-20020aa7cb13000000b0045cf4f72b04sm378233edt.94.2022.11.17.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:06:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 12:06:53 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 4/4] media: i2c: s5c73m3: switch to using gpiod API
Message-ID: <20221117110653.GD2725180@tom-ThinkPad-T14s-Gen-2i>
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
 <20221115221145.2550572-4-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115221145.2550572-4-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:11:45PM -0800, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/media/i2c/s5c73m3/s5c73m3-core.c | 63 +++++++-----------------
>  drivers/media/i2c/s5c73m3/s5c73m3.h      |  7 +--
>  2 files changed, 20 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> index 561c1a1583ac..f1e073ed5f99 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> @@ -10,12 +10,11 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/media.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_graph.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sizes.h>
> @@ -1348,20 +1347,20 @@ static int s5c73m3_oif_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
>  
>  static int s5c73m3_gpio_set_value(struct s5c73m3 *priv, int id, u32 val)
>  {
> -	if (!gpio_is_valid(priv->gpio[id].gpio))
> +	if (!priv->gpio[id])
>  		return 0;
> -	gpio_set_value(priv->gpio[id].gpio, !!val);
> +	gpiod_set_value_cansleep(priv->gpio[id], val);
>  	return 1;
>  }
>  
>  static int s5c73m3_gpio_assert(struct s5c73m3 *priv, int id)
>  {
> -	return s5c73m3_gpio_set_value(priv, id, priv->gpio[id].level);
> +	return s5c73m3_gpio_set_value(priv, id, 1);
>  }
>  
>  static int s5c73m3_gpio_deassert(struct s5c73m3 *priv, int id)
>  {
> -	return s5c73m3_gpio_set_value(priv, id, !priv->gpio[id].level);
> +	return s5c73m3_gpio_set_value(priv, id, 0);
>  }
>  
>  static int __s5c73m3_power_on(struct s5c73m3 *state)
> @@ -1544,49 +1543,29 @@ static const struct v4l2_subdev_ops oif_subdev_ops = {
>  
>  static int s5c73m3_configure_gpios(struct s5c73m3 *state)
>  {
> -	static const char * const gpio_names[] = {
> -		"S5C73M3_STBY", "S5C73M3_RST"
> -	};
> +	static const char * const name[] = { "standby", "xshutdown" };
> +	static const char * const label[] = { "S5C73M3_STBY", "S5C73M3_RST" };
>  	struct i2c_client *c = state->i2c_client;
> -	struct s5c73m3_gpio *g = state->gpio;
> +	struct gpio_desc *gpio;
>  	int ret, i;
>  
>  	for (i = 0; i < GPIO_NUM; ++i) {
> -		unsigned int flags = GPIOF_DIR_OUT;
> -		if (g[i].level)
> -			flags |= GPIOF_INIT_HIGH;
> -		ret = devm_gpio_request_one(&c->dev, g[i].gpio, flags,
> -					    gpio_names[i]);
> +		gpio = devm_gpiod_get(&c->dev, name[i], GPIOD_OUT_HIGH);
> +		ret = PTR_ERR_OR_ZERO(gpio);
>  		if (ret) {
> -			v4l2_err(c, "failed to request gpio %s\n",
> -				 gpio_names[i]);
> +			v4l2_err(c, "failed to request gpio %s: %d\n",
> +				 name[i], ret);
>  			return ret;
>  		}
> -	}
> -	return 0;
> -}
> -
> -static int s5c73m3_parse_gpios(struct s5c73m3 *state)
> -{
> -	static const char * const prop_names[] = {
> -		"standby-gpios", "xshutdown-gpios",
> -	};
> -	struct device *dev = &state->i2c_client->dev;
> -	struct device_node *node = dev->of_node;
> -	int ret, i;
>  
> -	for (i = 0; i < GPIO_NUM; ++i) {
> -		enum of_gpio_flags of_flags;
> -
> -		ret = of_get_named_gpio_flags(node, prop_names[i],
> -					      0, &of_flags);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to parse %s DT property\n",
> -				prop_names[i]);
> -			return -EINVAL;
> +		ret = gpiod_set_consumer_name(gpio, label[i]);
> +		if (ret) {
> +			v4l2_err(c, "failed to set up name for gpio %s: %d\n",
> +				 name[i], ret);
> +			return ret;
>  		}
> -		state->gpio[i].gpio = ret;
> -		state->gpio[i].level = !(of_flags & OF_GPIO_ACTIVE_LOW);
> +
> +		state->gpio[i] = gpio;
>  	}
>  	return 0;
>  }
> @@ -1613,10 +1592,6 @@ static int s5c73m3_get_dt_data(struct s5c73m3 *state)
>  					state->mclk_frequency);
>  	}
>  
> -	ret = s5c73m3_parse_gpios(state);
> -	if (ret < 0)
> -		return -EINVAL;
> -
>  	node_ep = of_graph_get_next_endpoint(node, NULL);
>  	if (!node_ep) {
>  		dev_warn(dev, "no endpoint defined for node: %pOF\n", node);
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3.h b/drivers/media/i2c/s5c73m3/s5c73m3.h
> index d68528898249..9887d03fcdeb 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3.h
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
> @@ -356,11 +356,6 @@ enum s5c73m3_gpio_id {
>  	GPIO_NUM,
>  };
>  
> -struct s5c73m3_gpio {
> -	int gpio;
> -	int level;
> -};
> -
>  enum s5c73m3_resolution_types {
>  	RES_ISP,
>  	RES_JPEG,
> @@ -387,7 +382,7 @@ struct s5c73m3 {
>  	u32 i2c_read_address;
>  
>  	struct regulator_bulk_data supplies[S5C73M3_MAX_SUPPLIES];
> -	struct s5c73m3_gpio gpio[GPIO_NUM];
> +	struct gpio_desc *gpio[GPIO_NUM];
>  
>  	struct clk *clock;
>  
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

Looks good to me.
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

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
