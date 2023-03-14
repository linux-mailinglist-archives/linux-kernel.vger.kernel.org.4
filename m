Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD36B90E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCNLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCNLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:01:52 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83FC74DE3;
        Tue, 14 Mar 2023 04:01:49 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PbVvs1B6QzyQx;
        Tue, 14 Mar 2023 13:01:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678791706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1h6tYodatFLzfE0ast1Inp6RrLfiG9v5fLVwKJIT+MQ=;
        b=VgPHk5tyg/IrDSjWlu9IibBHCme1uMmKZ8u8doFH+J/00L0z1QEhR4igIMNEYPqUOVKM22
        2uY5rPP+4/FzKcIdYwPD8wSPx0DG416WjiXHsOUkvYuVGtsMnBCzPK48o0h0OoUAGIexek
        3MFu5DGjkH1d/020JX4G2DCz+UfHzVk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678791706; a=rsa-sha256; cv=none;
        b=FFTDadmhNKPt5Pu1UVnTloLJGXnaJ2bum9SyG+W0bqgZwz9rsl3F3aON6mBqyT+5/fohTD
        9AstyZCCgWjWFV8b2d6sdm8Pu2IRTIAnKR8F7qH1sBS+Vssz/N08pQN17Wpt+BPKkPgTK0
        ogyGmtDUvUyDr5snLAnh/wn/S8wjiiE=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678791706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1h6tYodatFLzfE0ast1Inp6RrLfiG9v5fLVwKJIT+MQ=;
        b=ck6F+ovTtTDK5aG69CKNh7dI1vcOadrSt/RRirqpIaqe0WU3h+EK+2faDbdfGMkKQAsrIF
        Va3dhB813L1iTa05J7tGd6qLQBEOuwC3rsGf7uzcWqS/j36cT/z+yUyEGAgVHhDFGikxAb
        h2CBbrm2K3kFrf0fMmWsHYbmf8JgEfY=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 80EB1634C91;
        Tue, 14 Mar 2023 13:00:41 +0200 (EET)
Date:   Tue, 14 Mar 2023 13:00:41 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jean Delvare <jdelvare@suse.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Ldd-Mlp <ldd-mlp@list.ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] media: lm3560: convent to OF
Message-ID: <ZBBT2WM2lWz2Ab7u@valkosipuli.retiisi.eu>
References: <20230308095209.14700-1-clamor95@gmail.com>
 <20230308095209.14700-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308095209.14700-3-clamor95@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

Thanks for the patch.

On Wed, Mar 08, 2023 at 11:52:09AM +0200, Svyatoslav Ryhel wrote:
> If no pdata is available, try to read from device tree.

I think platform data support could be even dropped these days. But it
should probably be a separate patch. I think either before or after this
one would be fine.

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/media/i2c/lm3560.c | 128 +++++++++++++++++++++++++++----------
>  1 file changed, 93 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
> index 5ef613604be7..5541051616b7 100644
> --- a/drivers/media/i2c/lm3560.c
> +++ b/drivers/media/i2c/lm3560.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> @@ -22,16 +23,16 @@
>  
>  /* registers definitions */
>  #define REG_ENABLE		0x10
> -#define REG_TORCH_BR	0xa0
> -#define REG_FLASH_BR	0xb0
> -#define REG_FLASH_TOUT	0xc0
> +#define REG_TORCH_BR		0xa0
> +#define REG_FLASH_BR		0xb0
> +#define REG_FLASH_TOUT		0xc0
>  #define REG_FLAG		0xd0
>  #define REG_CONFIG1		0xe0
>  
>  /* fault mask */
> -#define FAULT_TIMEOUT	(1<<0)
> -#define FAULT_OVERTEMP	(1<<1)
> -#define FAULT_SHORT_CIRCUIT	(1<<2)
> +#define FAULT_TIMEOUT		BIT(0)
> +#define FAULT_OVERTEMP		BIT(1)
> +#define FAULT_SHORT_CIRCUIT	BIT(2)
>  
>  enum led_enable {
>  	MODE_SHDN = 0x0,
> @@ -54,6 +55,7 @@ struct lm3560_flash {
>  	struct device *dev;
>  	struct lm3560_platform_data *pdata;
>  	struct regmap *regmap;
> +	struct gpio_desc *hwen_gpio;
>  	struct mutex lock;
>  
>  	enum v4l2_flash_led_mode led_mode;
> @@ -356,12 +358,19 @@ static int lm3560_subdev_init(struct lm3560_flash *flash,
>  	flash->subdev_led[led_no].flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>  	strscpy(flash->subdev_led[led_no].name, led_name,
>  		sizeof(flash->subdev_led[led_no].name));
> +
>  	rval = lm3560_init_controls(flash, led_no);
> -	if (rval)
> +	if (rval) {
> +		dev_err(flash->dev, "failed to init controls: %d\n", rval);
>  		goto err_out;
> +	}
> +
>  	rval = media_entity_pads_init(&flash->subdev_led[led_no].entity, 0, NULL);
> -	if (rval < 0)
> +	if (rval < 0) {
> +		dev_err(flash->dev, "failed to init media entity pads: %d\n", rval);
>  		goto err_out;
> +	}
> +
>  	flash->subdev_led[led_no].entity.function = MEDIA_ENT_F_FLASH;
>  
>  	return rval;
> @@ -391,6 +400,49 @@ static int lm3560_init_device(struct lm3560_flash *flash)
>  	return rval;
>  }
>  
> +static int lm3560_of_probe(struct lm3560_flash *flash)
> +{
> +	struct lm3560_platform_data *pdata;
> +	struct fwnode_handle *node;
> +	int ret, reg;
> +
> +	pdata = devm_kzalloc(flash->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENODEV;
> +
> +	ret = device_property_read_u32(flash->dev,
> +				       "ti,peak-current", &pdata->peak);
> +	if (ret)
> +		pdata->peak = LM3560_PEAK_3600mA;
> +
> +	ret = device_property_read_u32(flash->dev,
> +				       "ti,max-flash-timeout",
> +				       &pdata->max_flash_timeout);
> +	if (ret)
> +		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MAX;
> +
> +	device_for_each_child_node(flash->dev, node) {
> +		fwnode_property_read_u32(node, "reg", &reg);
> +
> +		if (reg == LM3560_LED0 || reg == LM3560_LED1) {
> +			ret = device_property_read_u32(flash->dev,
> +						       "ti,max-flash-current",
> +						       &pdata->max_flash_brt[reg]);
> +			if (ret)
> +				pdata->max_flash_brt[reg] = LM3560_FLASH_TOUT_MAX;
> +
> +			ret = device_property_read_u32(flash->dev,
> +						       "ti,max-torch-current",
> +						       &pdata->max_torch_brt[reg]);
> +			if (ret)
> +				pdata->max_torch_brt[reg] = LM3560_TORCH_BRT_MAX;
> +		}
> +	}
> +	flash->pdata = pdata;
> +
> +	return 0;
> +}
> +
>  static int lm3560_probe(struct i2c_client *client)
>  {
>  	struct lm3560_flash *flash;
> @@ -398,44 +450,41 @@ static int lm3560_probe(struct i2c_client *client)
>  	int rval;
>  
>  	flash = devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
> -	if (flash == NULL)
> +	if (!flash)
>  		return -ENOMEM;
>  
>  	flash->regmap = devm_regmap_init_i2c(client, &lm3560_regmap);
> -	if (IS_ERR(flash->regmap)) {
> -		rval = PTR_ERR(flash->regmap);
> -		return rval;
> -	}
> +	if (IS_ERR(flash->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(flash->regmap),
> +				     "failed to init regmap\n");
>  
> -	/* if there is no platform data, use chip default value */
> -	if (pdata == NULL) {
> -		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> -		if (pdata == NULL)
> -			return -ENODEV;
> -		pdata->peak = LM3560_PEAK_3600mA;
> -		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MAX;
> -		/* led 1 */
> -		pdata->max_flash_brt[LM3560_LED0] = LM3560_FLASH_BRT_MAX;
> -		pdata->max_torch_brt[LM3560_LED0] = LM3560_TORCH_BRT_MAX;
> -		/* led 2 */
> -		pdata->max_flash_brt[LM3560_LED1] = LM3560_FLASH_BRT_MAX;
> -		pdata->max_torch_brt[LM3560_LED1] = LM3560_TORCH_BRT_MAX;
> -	}
> -	flash->pdata = pdata;
>  	flash->dev = &client->dev;
>  	mutex_init(&flash->lock);
>  
> +	/* if there is no platform data, try to read from device tree */
> +	if (!pdata)
> +		lm3560_of_probe(flash);
> +
> +	flash->hwen_gpio = devm_gpiod_get_optional(flash->dev, "enable",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(flash->hwen_gpio))
> +		return dev_err_probe(&client->dev, PTR_ERR(flash->hwen_gpio),
> +				     "failed to get hwen gpio\n");
> +
>  	rval = lm3560_subdev_init(flash, LM3560_LED0, "lm3560-led0");
>  	if (rval < 0)
> -		return rval;
> +		return dev_err_probe(&client->dev, rval,
> +				     "failed to init led0 subdev\n");
>  
>  	rval = lm3560_subdev_init(flash, LM3560_LED1, "lm3560-led1");
>  	if (rval < 0)
> -		return rval;
> +		return dev_err_probe(&client->dev, rval,
> +				     "failed to init led1 subdev\n");
>  
>  	rval = lm3560_init_device(flash);
>  	if (rval < 0)
> -		return rval;
> +		return dev_err_probe(&client->dev, rval,
> +				     "failed to init device\n");
>  
>  	i2c_set_clientdata(client, flash);
>  
> @@ -452,21 +501,30 @@ static void lm3560_remove(struct i2c_client *client)
>  		v4l2_ctrl_handler_free(&flash->ctrls_led[i]);
>  		media_entity_cleanup(&flash->subdev_led[i].entity);
>  	}
> +
> +	gpiod_set_value_cansleep(flash->hwen_gpio, 0);
>  }
>  
> +static const struct of_device_id lm3560_match[] = {
> +	{ .compatible = "ti,lm3559" },
> +	{ .compatible = "ti,lm3560" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lm3560_match);
> +
>  static const struct i2c_device_id lm3560_id_table[] = {
>  	{LM3559_NAME, 0},
>  	{LM3560_NAME, 0},
>  	{}
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, lm3560_id_table);
>  
>  static struct i2c_driver lm3560_i2c_driver = {
>  	.driver = {
> -		   .name = LM3560_NAME,
> -		   .pm = NULL,
> -		   },
> +		.name = LM3560_NAME,
> +		.pm = NULL,
> +		.of_match_table = lm3560_match,
> +	},
>  	.probe_new = lm3560_probe,
>  	.remove = lm3560_remove,
>  	.id_table = lm3560_id_table,

-- 
Kind regards,

Sakari Ailus
