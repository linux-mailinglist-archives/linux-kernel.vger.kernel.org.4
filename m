Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7762D8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiKQK5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiKQK4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:56:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC126CA26
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:54:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id t25so4051143ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRyvw5LJL7zXFrmXu1AnOvKiQIjeJXswee7X6KYczKg=;
        b=RvclxVPzKg+h5FsO+qDUCl4CHH142sWLYNnEKd1loN4rPirgw5ovI4R8HMSbJSveil
         6FPK3K0tGnvifPQI48H/6XQVdjMhuW7Dau/w1SJ/67PDayTigyAFvMoUrO+8EfmniE6j
         +cvx66TY2PASwlMrSbaRVvaIzMOZKsZVm8Fo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRyvw5LJL7zXFrmXu1AnOvKiQIjeJXswee7X6KYczKg=;
        b=I0EmZ23wcofCVNE5hsA8HcuP2COqSf7CcpBZxQbIjSW/5ScXs+U0GaliXOVlv3sSjF
         1baTR2A/uebzQNJ6/kkQU6ToeBD9ibHzT14/Hc9WcrWxxzP+kQoGdccUkGJP9qqXCinq
         GUWuZF32PjV4LhXJ20RqmjRIPiGmbiRe4q20fOvFfI0AAhn7iyoN5027sVGGgtmjZpiT
         GUK/9vdv6XrRJeYM8mv3CJ9RLuGLcxLNiSI648awL5QW5+D9H9L9aRL3bSEEKuDrJm7k
         QorwILdqYq4IEFWI1j4hDrI45hDADuVo8B64slGS8TtNjboPcFanYDL8ZCYzjuAPgEKP
         YDEw==
X-Gm-Message-State: ANoB5pnJ7JYYPwqbFulOsI8yBhiG6iz7KGd4e5MFq9LPA+4HTqgaP1GB
        qECLcZzWsvu4AhY6x5eedrwWsA==
X-Google-Smtp-Source: AA0mqf43PQ/3oV9rIx9+/z0xzV2B+CkgUuuZog77bDNjg6xTrm6RjqH2CptAUJYTEKEYf/yT0BHKAw==
X-Received: by 2002:a17:906:398b:b0:7ad:b868:f096 with SMTP id h11-20020a170906398b00b007adb868f096mr1673632eje.295.1668682474637;
        Thu, 17 Nov 2022 02:54:34 -0800 (PST)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-54-207.cust.vodafonedsl.it. [188.217.54.207])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090653cc00b0078dd4c89781sm219484ejo.35.2022.11.17.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:54:34 -0800 (PST)
Date:   Thu, 17 Nov 2022 11:54:32 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 2/4] media: i2c: s5k5baf: switch to using gpiod API
Message-ID: <20221117105432.GB2725180@tom-ThinkPad-T14s-Gen-2i>
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
 <20221115221145.2550572-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115221145.2550572-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Nov 15, 2022 at 02:11:43PM -0800, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/media/i2c/s5k5baf.c | 64 +++++++++++--------------------------
>  1 file changed, 18 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/media/i2c/s5k5baf.c b/drivers/media/i2c/s5k5baf.c
> index 5c2253ab3b6f..960fbf6428ea 100644
> --- a/drivers/media/i2c/s5k5baf.c
> +++ b/drivers/media/i2c/s5k5baf.c
> @@ -13,11 +13,10 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/media.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_graph.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -228,11 +227,6 @@ static const char * const s5k5baf_supply_names[] = {
>  };
>  #define S5K5BAF_NUM_SUPPLIES ARRAY_SIZE(s5k5baf_supply_names)
>  
> -struct s5k5baf_gpio {
> -	int gpio;
> -	int level;
> -};
> -
>  enum s5k5baf_gpio_id {
>  	STBY,
>  	RSET,
> @@ -284,7 +278,7 @@ struct s5k5baf_fw {
>  };
>  
>  struct s5k5baf {
> -	struct s5k5baf_gpio gpios[NUM_GPIOS];
> +	struct gpio_desc *gpios[NUM_GPIOS];
>  	enum v4l2_mbus_type bus_type;
>  	u8 nlanes;
>  	struct regulator_bulk_data supplies[S5K5BAF_NUM_SUPPLIES];
> @@ -936,16 +930,12 @@ static void s5k5baf_hw_set_test_pattern(struct s5k5baf *state, int id)
>  
>  static void s5k5baf_gpio_assert(struct s5k5baf *state, int id)
>  {
> -	struct s5k5baf_gpio *gpio = &state->gpios[id];
> -
> -	gpio_set_value(gpio->gpio, gpio->level);
> +	gpiod_set_value_cansleep(state->gpios[id], 1);
>  }
>  
>  static void s5k5baf_gpio_deassert(struct s5k5baf *state, int id)
>  {
> -	struct s5k5baf_gpio *gpio = &state->gpios[id];
> -
> -	gpio_set_value(gpio->gpio, !gpio->level);
> +	gpiod_set_value_cansleep(state->gpios[id], 0);
>  }
>  
>  static int s5k5baf_power_on(struct s5k5baf *state)
> @@ -1799,44 +1789,30 @@ static const struct v4l2_subdev_ops s5k5baf_subdev_ops = {
>  
>  static int s5k5baf_configure_gpios(struct s5k5baf *state)
>  {
> -	static const char * const name[] = { "S5K5BAF_STBY", "S5K5BAF_RST" };
> +	static const char * const name[] = { "stbyn", "rstn" };
> +	static const char * const label[] = { "S5K5BAF_STBY", "S5K5BAF_RST" };
>  	struct i2c_client *c = v4l2_get_subdevdata(&state->sd);
> -	struct s5k5baf_gpio *g = state->gpios;
> +	struct gpio_desc *gpio;
>  	int ret, i;
>  
>  	for (i = 0; i < NUM_GPIOS; ++i) {
> -		int flags = GPIOF_DIR_OUT;
> -		if (g[i].level)
> -			flags |= GPIOF_INIT_HIGH;
> -		ret = devm_gpio_request_one(&c->dev, g[i].gpio, flags, name[i]);
> -		if (ret < 0) {
> -			v4l2_err(c, "failed to request gpio %s\n", name[i]);
> +		gpio = devm_gpiod_get(&c->dev, name[i], GPIOD_OUT_HIGH);
> +		ret = PTR_ERR_OR_ZERO(gpio);
> +		if (ret) {
> +			v4l2_err(c, "failed to request gpio %s: %d\n",
> +				 name[i], ret);
>  			return ret;
>  		}
> -	}
> -	return 0;
> -}
> -
> -static int s5k5baf_parse_gpios(struct s5k5baf_gpio *gpios, struct device *dev)
> -{
> -	static const char * const names[] = {
> -		"stbyn-gpios",
> -		"rstn-gpios",
> -	};
> -	struct device_node *node = dev->of_node;
> -	enum of_gpio_flags flags;
> -	int ret, i;
>  
> -	for (i = 0; i < NUM_GPIOS; ++i) {
> -		ret = of_get_named_gpio_flags(node, names[i], 0, &flags);
> -		if (ret < 0) {
> -			dev_err(dev, "no %s GPIO pin provided\n", names[i]);
> +		ret = gpiod_set_consumer_name(gpio, label[i]);
> +		if (ret) {
> +			v4l2_err(c, "failed to set up name for gpio %s: %d\n",
> +				 name[i], ret);
>  			return ret;
>  		}
> -		gpios[i].gpio = ret;
> -		gpios[i].level = !(flags & OF_GPIO_ACTIVE_LOW);
> -	}
>  
> +		state->gpios[i] = gpio;
> +	}
>  	return 0;
>  }
>  
> @@ -1860,10 +1836,6 @@ static int s5k5baf_parse_device_node(struct s5k5baf *state, struct device *dev)
>  			 state->mclk_frequency);
>  	}
>  
> -	ret = s5k5baf_parse_gpios(state->gpios, dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	node_ep = of_graph_get_next_endpoint(node, NULL);
>  	if (!node_ep) {
>  		dev_err(dev, "no endpoint defined at node %pOF\n", node);
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

Looks good to me.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Regards,
Tommaso

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
