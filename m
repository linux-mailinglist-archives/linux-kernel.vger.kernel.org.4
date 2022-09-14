Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0D5B8B81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiINPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiINPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:12:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABBD80E9B;
        Wed, 14 Sep 2022 08:12:33 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2BD6940009;
        Wed, 14 Sep 2022 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663168351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eI5agrplPJnc1LUjt8uZzFc76jZalpws6ww1szcbEto=;
        b=U2WRUD7epWbmeLOCfR8L8eNxdb6IIne0kMwr4bzjoG65yQXmOYztXWku/XyjqbH6Kvv5rn
        RX6znfnzYEXosWTvJxr45wYNilXcUFd21tkC7IrhPkOuAZR2JydB2EeSnCnCFjkPcS2Hau
        dgwK7iY4aquon95jwbT8EOnC1yfcWKqbZyMFpE280JpWAJ04MMQAC2LTDvU+KL0aieVdkf
        uN8NxKMBq+fGLR2in7POCYbUgC90rjEIjDOLGetfz7t54VvaifyaBuq2Ino+TjMrK1P/hI
        u9aatdqWRF/KLrkCVbRDGHzfKIrTPqfNGwn9zz0uDzcjUATPnNUqXDs9KZwKZw==
Date:   Wed, 14 Sep 2022 17:12:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 6/6] rtc: isl12022: add support for temperature sensor
Message-ID: <YyHvXh1Zhy/wsHsD@mail.local>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220830100152.698506-7-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830100152.698506-7-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 12:01:52+0200, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/rtc/rtc-isl12022.c | 81 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index b295ec92ee17..1bd72f436318 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -17,6 +17,8 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

You should keep that list ordered

>  
>  /* ISL register offsets */
>  #define ISL12022_REG_SC		0x00
> @@ -30,6 +32,9 @@
>  #define ISL12022_REG_SR		0x07
>  #define ISL12022_REG_INT	0x08
>  
> +#define ISL12022_REG_BETA	0x0d
> +#define ISL12022_REG_TEMP_L	0x28
> +
>  /* ISL register bits */
>  #define ISL12022_HR_MIL		(1 << 7)	/* military or 24 hour time */
>  
> @@ -38,6 +43,7 @@
>  
>  #define ISL12022_INT_WRTC	(1 << 6)
>  
> +#define ISL12022_BETA_TSE	(1 << 7)
>  
>  static struct i2c_driver isl12022_driver;
>  
> @@ -48,6 +54,79 @@ struct isl12022 {
>  	bool write_enabled;	/* true if write enable is set */
>  };
>  
> +/*
> + * A user-initiated temperature conversion is not started by this function,
> + * so the temperature is updated once every ~60 seconds.
> + */
> +static int isl12022_hwmon_read_temp(struct device *dev, s32 *mC)
> +{
> +	struct isl12022 *isl12022 = dev_get_drvdata(dev);
> +	struct regmap *regmap = isl12022->regmap;
> +	u8 temp_buf[2];
> +	s32 temp;
> +	int ret;
> +
> +	ret = regmap_bulk_read(regmap, ISL12022_REG_TEMP_L,
> +			       temp_buf, sizeof(temp_buf));
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Temperature is represented as a 10-bit number, unit half-Kelvins.
> +	 */
> +	temp = (temp_buf[1] << 8) | temp_buf[0];
> +	temp *= 500;
> +	temp -= 273000;
> +
> +	*mC = temp;
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +isl12022_hwmon_show_temp(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	s32 temp;
> +
> +	ret = isl12022_hwmon_read_temp(dev, &temp);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", temp);
> +}
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, isl12022_hwmon_show_temp,
> +			  NULL, 0);
> +
> +static struct attribute *isl12022_hwmon_attrs[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(isl12022_hwmon);
> +
> +static void isl12022_hwmon_register(struct device *dev)
> +{
> +	struct isl12022 *isl12022;
> +	struct device *hwmon;
> +	int ret;
> +
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return;
> +
> +	isl12022 = dev_get_drvdata(dev);
> +
> +	ret = regmap_update_bits(isl12022->regmap, ISL12022_REG_BETA,
> +				 ISL12022_BETA_TSE, ISL12022_BETA_TSE);
> +	if (ret) {
> +		dev_warn(dev, "unable to enable temperature sensor\n");
> +		return;
> +	}
> +
> +	hwmon = devm_hwmon_device_register_with_groups(dev, "isl12022", isl12022,
> +						       isl12022_hwmon_groups);
> +	if (IS_ERR(hwmon))
> +		dev_warn(dev, "unable to register hwmon device: %pe\n", hwmon);
> +}
> +
>  /*
>   * In the routines that deal directly with the isl12022 hardware, we use
>   * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
> @@ -179,6 +258,8 @@ static int isl12022_probe(struct i2c_client *client)
>  		return PTR_ERR(isl12022->regmap);
>  	}
>  
> +	isl12022_hwmon_register(&client->dev);
> +
>  	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
>  	if (IS_ERR(isl12022->rtc))
>  		return PTR_ERR(isl12022->rtc);
> -- 
> 2.37.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
