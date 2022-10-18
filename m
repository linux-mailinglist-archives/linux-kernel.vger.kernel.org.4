Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC926032E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJRSzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJRSzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:55:16 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C578E0DF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:55:13 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id krk4o4LYpJvOZkrk4odlCd; Tue, 18 Oct 2022 20:55:12 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Oct 2022 20:55:12 +0200
X-ME-IP: 86.243.100.34
Message-ID: <15ebc256-1855-7720-05e1-6673b1da7d93@wanadoo.fr>
Date:   Tue, 18 Oct 2022 20:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/2] media: i2c: add support for OV4689
To:     mike.rudenko@gmail.com
Cc:     arec.kao@intel.com, c.hemp@phytec.de,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        hverkuil@xs4all.nl, jimmy.su@intel.com,
        krzysztof.kozlowski+dt@linaro.org,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        marex@denx.de, mchehab@kernel.org, rdunlap@infradead.org,
        robh+dt@kernel.org, sakari.ailus@linux.intel.com,
        shawnx.tu@intel.com, tommaso.merciai@amarulasolutions.com
References: <20220927222152.132951-1-mike.rudenko@gmail.com>
 <20220927222152.132951-3-mike.rudenko@gmail.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220927222152.132951-3-mike.rudenko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/09/2022 à 00:21, Mikhail Rudenko a écrit :
> Add a V4L2 sub-device driver for OmniVision OV4689 image sensor. This
> is a 4 Mpx image sensor using the I2C bus for control and the CSI-2
> bus for data.
> 
> This driver supports following features:
> - manual exposure and analog gain control support
> - test pattern support
> - media controller support
> - runtime PM support
> - support following resolutions:
>    + 2688x1520 at 30 fps
> 
> The driver provides all mandatory V4L2 controls for compatibility with
> libcamera. The sensor supports 1/2/4-lane CSI-2 modes, but the driver
> implements 4 lane mode only at this moment.

Hi,

a few nitpick below.

CJ

> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

[...]

> +static int ov4689_check_sensor_id(struct ov4689 *ov4689,
> +				  struct i2c_client *client)
> +{
> +	struct device *dev = &ov4689->client->dev;
> +	u32 id = 0;
> +	int ret;
> +
> +	ret = ov4689_read_reg(client, OV4689_REG_CHIP_ID,
> +			      OV4689_REG_VALUE_16BIT, &id);
> +	if (id != CHIP_ID) {
> +		dev_err(dev, "Unexpected sensor id(%06x), ret(%d)\n", id, ret);
> +		return -ENODEV;

return ret?
(otherwise what is the point of -EINVAL and -EIO in ov4689_read_reg()?)

> +	}
> +
> +	dev_info(dev, "Detected OV%06x sensor\n", CHIP_ID);
> +
> +	return 0;
> +}

[...]

> +static int ov4689_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct v4l2_subdev *sd;
> +	struct ov4689 *ov4689;
> +	int ret;
> +
> +	ret = ov4689_check_hwcfg(dev);
> +	if (ret)
> +		return ret;
> +
> +	ov4689 = devm_kzalloc(dev, sizeof(*ov4689), GFP_KERNEL);
> +	if (!ov4689)
> +		return -ENOMEM;
> +
> +	ov4689->client = client;
> +	ov4689->cur_mode = &supported_modes[OV4689_MODE_2688_1520];
> +
> +	ov4689->xvclk = devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(ov4689->xvclk)) {
> +		return dev_err_probe(dev, PTR_ERR(ov4689->xvclk),
> +				     "Failed to get external clock\n");
> +	}
> +
> +	if (!ov4689->xvclk) {
> +		dev_dbg(dev,
> +			"No clock provided, using clock-frequency property\n");
> +		device_property_read_u32(dev, "clock-frequency", &ov4689->clock_rate);
> +	} else {
> +		ov4689->clock_rate = clk_get_rate(ov4689->xvclk);
> +	}
> +
> +	if (ov4689->clock_rate != OV4689_XVCLK_FREQ) {
> +		dev_err(dev,
> +			"External clock rate mismatch: got %d Hz, expected %d Hz\n",
> +			ov4689->clock_rate, OV4689_XVCLK_FREQ);
> +		return -EINVAL;
> +	}
> +
> +	ov4689->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						     GPIOD_OUT_LOW);
> +	if (IS_ERR(ov4689->reset_gpio)) {
> +		dev_err(dev, "Failed to get reset-gpios\n");
> +		return PTR_ERR(ov4689->reset_gpio);
> +	}
> +
> +	ov4689->pwdn_gpio = devm_gpiod_get_optional(dev, "pwdn", GPIOD_OUT_LOW);
> +	if (IS_ERR(ov4689->pwdn_gpio)) {
> +		dev_err(dev, "Failed to get pwdn-gpios\n");
> +		return PTR_ERR(ov4689->pwdn_gpio);
> +	}
> +
> +	ret = ov4689_configure_regulators(ov4689);
> +	if (ret) {
> +		dev_err(dev, "Failed to get power regulators\n");

dev_err_probe()?
I think that devm_regulator_bulk_get() can return -EPROBE_DEFER)

> +		return ret;
> +	}
> +
> +	mutex_init(&ov4689->mutex);
> +
> +	sd = &ov4689->subdev;
> +	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
> +	ret = ov4689_initialize_controls(ov4689);
> +	if (ret)
> +		goto err_destroy_mutex;
> +
> +	ret = ov4689_power_on(dev);
> +	if (ret)
> +		goto err_free_handler;
> +
> +	ret = ov4689_check_sensor_id(ov4689, client);
> +	if (ret)
> +		goto err_power_off;
> +
> +#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
> +	sd->internal_ops = &ov4689_internal_ops;
> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +#endif
> +#if defined(CONFIG_MEDIA_CONTROLLER)
> +	ov4689->pad.flags = MEDIA_PAD_FL_SOURCE;
> +	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
> +	ret = media_entity_pads_init(&sd->entity, 1, &ov4689->pad);
> +	if (ret < 0)
> +		goto err_power_off;
> +#endif
> +
> +	ret = v4l2_async_register_subdev_sensor(sd);
> +	if (ret) {
> +		dev_err(dev, "v4l2 async register subdev failed\n");
> +		goto err_clean_entity;
> +	}
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_idle(dev);
> +
> +	return 0;
> +
> +err_clean_entity:
> +	media_entity_cleanup(&sd->entity);
> +err_power_off:
> +	ov4689_power_off(dev);
> +err_free_handler:
> +	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
> +err_destroy_mutex:
> +	mutex_destroy(&ov4689->mutex);
> +
> +	return ret;
> +}

[...]

