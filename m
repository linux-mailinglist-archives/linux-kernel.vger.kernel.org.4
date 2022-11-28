Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB91463A189
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiK1GsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiK1GsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:48:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D47612757;
        Sun, 27 Nov 2022 22:48:02 -0800 (PST)
Received: from [IPV6:2401:4900:1f3f:3634:f7a:4485:ffcd:6086] (unknown [IPv6:2401:4900:1f3f:3634:f7a:4485:ffcd:6086])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EAE12501;
        Mon, 28 Nov 2022 07:47:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669618081;
        bh=pd1CRI9zY886IetD27393HGIIGdEb/SCZqgHWG/FVrE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m/QaDU7AYKyZYRrILRAB1tmbV9aHtUMXzWLui4QchwCJS15alFQ1Sa2YbMwkM9aUs
         bpIx4HZ57MQk9bXByoX2kTj4DUF0ssHQ77jqJTaIukT5wgQv+ZibNG/y8OqPWsO4Z/
         5IRifeCA8VtnTsDTB/CeltwUMlg7eyi6wvyeR/Hc=
Message-ID: <6817bff2-6183-ee22-6492-55f51b98c1d6@ideasonboard.com>
Date:   Mon, 28 Nov 2022 12:17:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] media: i2c: ak7375: Add regulator management
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
 <20220711144039.232196-4-y.oudjana@protonmail.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20220711144039.232196-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yassine,

I have tested this VCM with autofocus algorithm plumbed in libcamera [1]

On 7/11/22 8:10 PM, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Make the driver get needed regulators on probe and enable/disable
> them on runtime PM callbacks.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Tested-by: Umang Jain <umang.jain@ideasonboard.com>

[1] https://patchwork.libcamera.org/project/libcamera/list/?series=3174
> ---
> Changes since v1:
>    - Reorganize variable declaration
>    - Change the power-on delay range to 3000-3500 microseconds.
>
>   drivers/media/i2c/ak7375.c | 39 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>
> diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
> index 40b1a4aa846c..c2b2542a0056 100644
> --- a/drivers/media/i2c/ak7375.c
> +++ b/drivers/media/i2c/ak7375.c
> @@ -6,6 +6,7 @@
>   #include <linux/i2c.h>
>   #include <linux/module.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>   #include <media/v4l2-ctrls.h>
>   #include <media/v4l2-device.h>
>   
> @@ -23,17 +24,32 @@
>    */
>   #define AK7375_CTRL_STEPS	64
>   #define AK7375_CTRL_DELAY_US	1000
> +/*
> + * The vcm takes around 3 ms to power on and start taking
> + * I2C messages. This value was found experimentally due to
> + * lack of documentation.
> + */
> +#define AK7375_POWER_DELAY_US	3000
>   
>   #define AK7375_REG_POSITION	0x0
>   #define AK7375_REG_CONT		0x2
>   #define AK7375_MODE_ACTIVE	0x0
>   #define AK7375_MODE_STANDBY	0x40
>   
> +static const char * const ak7375_supply_names[] = {
> +	"vdd",
> +	"vio",
> +};
> +
> +#define AK7375_NUM_SUPPLIES ARRAY_SIZE(ak7375_supply_names)
> +
>   /* ak7375 device structure */
>   struct ak7375_device {
>   	struct v4l2_ctrl_handler ctrls_vcm;
>   	struct v4l2_subdev sd;
>   	struct v4l2_ctrl *focus;
> +	struct regulator_bulk_data supplies[AK7375_NUM_SUPPLIES];
> +
>   	/* active or standby mode */
>   	bool active;
>   };
> @@ -133,12 +149,24 @@ static int ak7375_probe(struct i2c_client *client)
>   {
>   	struct ak7375_device *ak7375_dev;
>   	int ret;
> +	int i;
>   
>   	ak7375_dev = devm_kzalloc(&client->dev, sizeof(*ak7375_dev),
>   				  GFP_KERNEL);
>   	if (!ak7375_dev)
>   		return -ENOMEM;
>   
> +	for (i = 0; i < AK7375_NUM_SUPPLIES; i++)
> +		ak7375_dev->supplies[i].supply = ak7375_supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(&client->dev, AK7375_NUM_SUPPLIES,
> +				      ak7375_dev->supplies);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get regulators: %pe",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
>   	v4l2_i2c_subdev_init(&ak7375_dev->sd, client, &ak7375_ops);
>   	ak7375_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>   	ak7375_dev->sd.internal_ops = &ak7375_int_ops;
> @@ -210,6 +238,10 @@ static int __maybe_unused ak7375_vcm_suspend(struct device *dev)
>   	if (ret)
>   		dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
>   
> +	ret = regulator_bulk_disable(AK7375_NUM_SUPPLIES, ak7375_dev->supplies);
> +	if (ret)
> +		return ret;
> +
>   	ak7375_dev->active = false;
>   
>   	return 0;
> @@ -230,6 +262,13 @@ static int __maybe_unused ak7375_vcm_resume(struct device *dev)
>   	if (ak7375_dev->active)
>   		return 0;
>   
> +	ret = regulator_bulk_enable(AK7375_NUM_SUPPLIES, ak7375_dev->supplies);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for vcm to become ready */
> +	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 500);
> +
>   	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
>   		AK7375_MODE_ACTIVE, 1);
>   	if (ret) {
>

