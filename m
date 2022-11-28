Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2263A342
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiK1Ikg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiK1Ik3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:40:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813E17ABC;
        Mon, 28 Nov 2022 00:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8E4EB80CA3;
        Mon, 28 Nov 2022 08:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C541C433C1;
        Mon, 28 Nov 2022 08:40:23 +0000 (UTC)
Message-ID: <bd446c0a-ed62-d8b0-e51c-bf4a7ba65aea@xs4all.nl>
Date:   Mon, 28 Nov 2022 09:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20221116194307.164543-1-mairacanal@riseup.net>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/2] media: s5c73m3: Replace legacy gpio interface for
 gpiod
In-Reply-To: <20221116194307.164543-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maíra,

I'm skipping your patch in favor of a similar patch from Linux Walleij:

https://patchwork.linuxtv.org/project/linux-media/patch/20221108100604.1500909-1-linus.walleij@linaro.org/

I will take your 2/2 patch, though. That looks good.

Regards,

	Hans

On 16/11/2022 20:43, Maíra Canal wrote:
> Considering the current transition of the GPIO subsystem, remove all
> dependencies of the legacy GPIO interface (linux/gpio.h and linux
> /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
>  drivers/media/i2c/s5c73m3/s5c73m3-core.c | 95 ++++++++++--------------
>  drivers/media/i2c/s5c73m3/s5c73m3.h      |  9 +--
>  include/media/i2c/s5c73m3.h              | 15 +---
>  3 files changed, 44 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
> index d96ba58ce1e5..77cba5f47364 100644
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
> @@ -1347,22 +1346,26 @@ static int s5c73m3_oif_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
>  	return 0;
>  }
>  
> -static int s5c73m3_gpio_set_value(struct s5c73m3 *priv, int id, u32 val)
> +static int s5c73m3_gpio_set_value(struct gpio_desc *gpio, int val)
>  {
> -	if (!gpio_is_valid(priv->gpio[id].gpio))
> +	if (!gpio)
>  		return 0;
> -	gpio_set_value(priv->gpio[id].gpio, !!val);
> +	gpiod_set_value(gpio, !!val);
>  	return 1;
>  }
>  
> -static int s5c73m3_gpio_assert(struct s5c73m3 *priv, int id)
> +static int s5c73m3_gpio_assert(struct gpio_desc *gpio)
>  {
> -	return s5c73m3_gpio_set_value(priv, id, priv->gpio[id].level);
> +	int val = gpiod_get_value(gpio);
> +
> +	return s5c73m3_gpio_set_value(gpio, val);
>  }
>  
> -static int s5c73m3_gpio_deassert(struct s5c73m3 *priv, int id)
> +static int s5c73m3_gpio_deassert(struct gpio_desc *gpio)
>  {
> -	return s5c73m3_gpio_set_value(priv, id, !priv->gpio[id].level);
> +	int val = gpiod_get_value(gpio);
> +
> +	return s5c73m3_gpio_set_value(gpio, !val);
>  }
>  
>  static int __s5c73m3_power_on(struct s5c73m3 *state)
> @@ -1386,10 +1389,10 @@ static int __s5c73m3_power_on(struct s5c73m3 *state)
>  	v4l2_dbg(1, s5c73m3_dbg, &state->oif_sd, "clock frequency: %ld\n",
>  					clk_get_rate(state->clock));
>  
> -	s5c73m3_gpio_deassert(state, STBY);
> +	s5c73m3_gpio_deassert(state->gpio_stby);
>  	usleep_range(100, 200);
>  
> -	s5c73m3_gpio_deassert(state, RSET);
> +	s5c73m3_gpio_deassert(state->gpio_reset);
>  	usleep_range(50, 100);
>  
>  	return 0;
> @@ -1404,10 +1407,10 @@ static int __s5c73m3_power_off(struct s5c73m3 *state)
>  {
>  	int i, ret;
>  
> -	if (s5c73m3_gpio_assert(state, RSET))
> +	if (s5c73m3_gpio_assert(state->gpio_reset))
>  		usleep_range(10, 50);
>  
> -	if (s5c73m3_gpio_assert(state, STBY))
> +	if (s5c73m3_gpio_assert(state->gpio_stby))
>  		usleep_range(100, 200);
>  
>  	clk_disable_unprepare(state->clock);
> @@ -1545,50 +1548,34 @@ static const struct v4l2_subdev_ops oif_subdev_ops = {
>  
>  static int s5c73m3_configure_gpios(struct s5c73m3 *state)
>  {
> -	static const char * const gpio_names[] = {
> -		"S5C73M3_STBY", "S5C73M3_RST"
> -	};
>  	struct i2c_client *c = state->i2c_client;
> -	struct s5c73m3_gpio *g = state->gpio;
> -	int ret, i;
> +	struct device *dev = &c->dev;
> +	struct device_node *np = dev->of_node;
>  
> -	for (i = 0; i < GPIO_NUM; ++i) {
> -		unsigned int flags = GPIOF_DIR_OUT;
> -		if (g[i].level)
> -			flags |= GPIOF_INIT_HIGH;
> -		ret = devm_gpio_request_one(&c->dev, g[i].gpio, flags,
> -					    gpio_names[i]);
> -		if (ret) {
> -			v4l2_err(c, "failed to request gpio %s\n",
> -				 gpio_names[i]);
> -			return ret;
> -		}
> +	state->gpio_stby = gpiod_get_from_of_node(np, "standby-gpios", 0, GPIOD_ASIS,
> +			"S5C73M3_STBY");
> +
> +	if (IS_ERR(state->gpio_stby)) {
> +		v4l2_err(c, "failed to request gpio S5C73M3_STBY");
> +		return PTR_ERR(state->gpio_stby);
>  	}
> -	return 0;
> -}
>  
> -static int s5c73m3_parse_gpios(struct s5c73m3 *state)
> -{
> -	static const char * const prop_names[] = {
> -		"standby-gpios", "xshutdown-gpios",
> -	};
> -	struct device *dev = &state->i2c_client->dev;
> -	struct device_node *node = dev->of_node;
> -	int ret, i;
> +	if (state->gpio_stby)
> +		gpiod_direction_output(state->gpio_stby,
> +				!gpiod_is_active_low(state->gpio_stby));
>  
> -	for (i = 0; i < GPIO_NUM; ++i) {
> -		enum of_gpio_flags of_flags;
> +	state->gpio_reset = gpiod_get_from_of_node(np, "xshutdown-gpios", 0, GPIOD_ASIS,
> +			"S5C73M3_RST");
>  
> -		ret = of_get_named_gpio_flags(node, prop_names[i],
> -					      0, &of_flags);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to parse %s DT property\n",
> -				prop_names[i]);
> -			return -EINVAL;
> -		}
> -		state->gpio[i].gpio = ret;
> -		state->gpio[i].level = !(of_flags & OF_GPIO_ACTIVE_LOW);
> +	if (IS_ERR(state->gpio_reset)) {
> +		v4l2_err(c, "failed to request gpio S5C73M3_RST");
> +		return PTR_ERR(state->gpio_reset);
>  	}
> +
> +	if (state->gpio_reset)
> +		gpiod_direction_output(state->gpio_reset,
> +				!gpiod_is_active_low(state->gpio_reset));
> +
>  	return 0;
>  }
>  
> @@ -1608,8 +1595,8 @@ static int s5c73m3_get_platform_data(struct s5c73m3 *state)
>  		}
>  
>  		state->mclk_frequency = pdata->mclk_frequency;
> -		state->gpio[STBY] = pdata->gpio_stby;
> -		state->gpio[RSET] = pdata->gpio_reset;
> +		state->gpio_stby = pdata->gpio_stby;
> +		state->gpio_reset = pdata->gpio_reset;
>  		return 0;
>  	}
>  
> @@ -1624,10 +1611,6 @@ static int s5c73m3_get_platform_data(struct s5c73m3 *state)
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
> index c3fcfdd3ea66..f0056ae6e51a 100644
> --- a/drivers/media/i2c/s5c73m3/s5c73m3.h
> +++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
> @@ -351,12 +351,6 @@ struct s5c73m3_ctrls {
>  	struct v4l2_ctrl *scene_mode;
>  };
>  
> -enum s5c73m3_gpio_id {
> -	STBY,
> -	RSET,
> -	GPIO_NUM,
> -};
> -
>  enum s5c73m3_resolution_types {
>  	RES_ISP,
>  	RES_JPEG,
> @@ -383,7 +377,8 @@ struct s5c73m3 {
>  	u32 i2c_read_address;
>  
>  	struct regulator_bulk_data supplies[S5C73M3_MAX_SUPPLIES];
> -	struct s5c73m3_gpio gpio[GPIO_NUM];
> +	struct gpio_desc *gpio_stby;
> +	struct gpio_desc *gpio_reset;
>  
>  	struct clk *clock;
>  
> diff --git a/include/media/i2c/s5c73m3.h b/include/media/i2c/s5c73m3.h
> index a51f1025ba1c..caad855a8394 100644
> --- a/include/media/i2c/s5c73m3.h
> +++ b/include/media/i2c/s5c73m3.h
> @@ -17,19 +17,10 @@
>  #ifndef MEDIA_S5C73M3__
>  #define MEDIA_S5C73M3__
>  
> +#include <linux/gpio/consumer.h>
>  #include <linux/videodev2.h>
>  #include <media/v4l2-mediabus.h>
>  
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
>  /**
>   * struct s5c73m3_platform_data - s5c73m3 driver platform data
>   * @mclk_frequency: sensor's master clock frequency in Hz
> @@ -44,8 +35,8 @@ struct s5c73m3_gpio {
>  struct s5c73m3_platform_data {
>  	unsigned long mclk_frequency;
>  
> -	struct s5c73m3_gpio gpio_reset;
> -	struct s5c73m3_gpio gpio_stby;
> +	struct gpio_desc *gpio_reset;
> +	struct gpio_desc *gpio_stby;
>  
>  	enum v4l2_mbus_type bus_type;
>  	u8 nlanes;

