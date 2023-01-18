Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3455671F25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjAROOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjARONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:13:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBAE8F6C0;
        Wed, 18 Jan 2023 05:54:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso2134342pjb.0;
        Wed, 18 Jan 2023 05:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+r6NsqjJy/Q9VoBENkEZ3oFBqNlBJncY3i637FLawW8=;
        b=K6HhsSyWOLzi+YwjTDlPKiGOw7Rh1cnA7O/9vbxmV+93WJ2IQeL5WMgsQDzIRNOtsa
         VdJBmlAyvIrRXhIJHg+s+yJgJ5ef4SZZIQyXgePSamtc/zSBZKZGVFRxgcvHjDUKzhxy
         xzz3wDg96yWu7+FSs68wcwmg5uCMKXNlpqV2MIbEzA+b2zQ5gN1tzAkJtEF839igd5PM
         MsG7mxU057b9DUpjxpT0JpsrcJNErp582mVfb5qlA/QOzc6dOpR6SJqM4QLeLfP07q4n
         vB8qtksnMo2ZiiKzAemCQ2iGYnoQAiE2Vm/7/sOcDxbCUHXBXVIMgURxgme0TRgsh9mC
         nr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r6NsqjJy/Q9VoBENkEZ3oFBqNlBJncY3i637FLawW8=;
        b=WWbupdVBEfiJ8e0Ksr03au2A7FMy5UMBIMj1YRxtQv1rx4SLCsCIODQGJS85xcFVZh
         zpKCd8Xirk5PDF/YyN+xpRNaIpl9RT7JSSCTnIhpSr1MRoQTPy8286yrCaFZfDpUizBT
         ZmtaCzNrfo/UaTt+16+TgJlJwnH+EXi1/6ffAwrkoLGKRjMBZwp+MJ5i6xx2Ov2EjiZ/
         8qsSinec5AdmzCU3K5IhRKO9nw+IJbgHniwpqmaPHardjPEcxQe1SIThxbw8onWUCY9l
         GiN4P6Udc5DFWe+twhzV4ei8o973Sqw8Ut5BnvjY/xr8POYt8Z232cwORWF/55+dtbLD
         DQCA==
X-Gm-Message-State: AFqh2kp6Qnn3Ido7QHEOtj0Ve6qRI4qF6c0KUEb42oh05d6EZPMgl0Yk
        GWN1MjalP6AlXG4QEIhwPiRMWdNExExJ/g==
X-Google-Smtp-Source: AMrXdXv7go5ZmYRaaThzqSp9P3VM/d8adZt0xj7zwl8qec5wu7E6mDrbo2P4LmCHCtqIS+SzV5iQrw==
X-Received: by 2002:a17:90a:fc91:b0:226:a617:44c1 with SMTP id ci17-20020a17090afc9100b00226a61744c1mr6825927pjb.13.1674050040249;
        Wed, 18 Jan 2023 05:54:00 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id az13-20020a17090b028d00b00218cd71781csm1352734pjb.51.2023.01.18.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:53:59 -0800 (PST)
Date:   Wed, 18 Jan 2023 21:53:53 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 2/2] backlight: ktz8866: Add support for Kinetic
 KTZ8866 backlight
Message-ID: <Y8f58c5jLm/voJag@Gentoo>
References: <20230118131002.15453-1-lujianhua000@gmail.com>
 <20230118131002.15453-2-lujianhua000@gmail.com>
 <8349dd70-c383-8339-841a-1b440049debb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8349dd70-c383-8339-841a-1b440049debb@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:39:15PM +0100, Krzysztof Kozlowski wrote:
> On 18/01/2023 14:10, Jianhua Lu wrote:
> > Add support for Kinetic KTZ8866 backlight, which is used in
> > Xiaomi tablet, Mi Pad 5 series. This driver lightly based on
> > downstream implementation [1].
> > [1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/elish-r-oss/drivers/video/backlight/ktz8866.c
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Add missing staitc modifier to ktz8866_write function.
> > 
> > Changes in v3:
> >   - Add 2022 to Copyright line.
> >   - Sort headers.
> >   - Remove meaningless comment.
> >   - Use definitions instead of hardcoding.
> >   - Add missing maintainer info.
> > 
> > Changes in v4:
> >   - Change 2022 to 2023.
> >   - Remove useless macro and enum.
> >   - Describe settings by devicetree.
> >   - Move header file to C file.
> > 
> > Changes in v5:
> >   - Change "2023" to "2022, 2023" in Copyright line.
> >   - Set scale property for backlight.
> > 
> > Changes in v6:
> >   - Correct devicetree property name.
> > 
> >  MAINTAINERS                       |   6 +
> >  drivers/video/backlight/Kconfig   |   8 ++
> >  drivers/video/backlight/Makefile  |   1 +
> >  drivers/video/backlight/ktz8866.c | 205 ++++++++++++++++++++++++++++++
> >  4 files changed, 220 insertions(+)
> >  create mode 100644 drivers/video/backlight/ktz8866.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 42fc47c6edfd..2084e74e1b58 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11674,6 +11674,12 @@ M:	John Hawley <warthog9@eaglescrag.net>
> >  S:	Maintained
> >  F:	tools/testing/ktest
> >  
> > +KTZ8866 BACKLIGHT DRIVER
> > +M:	Jianhua Lu <lujianhua000@gmail.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > +F:	drivers/video/backlight/ktz8866.c
> > +
> >  L3MDEV
> >  M:	David Ahern <dsahern@kernel.org>
> >  L:	netdev@vger.kernel.org
> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> > index 936ba1e4d35e..f7113ceb264a 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> > @@ -190,6 +190,14 @@ config BACKLIGHT_KTD253
> >  	  which is a 1-wire GPIO-controlled backlight found in some mobile
> >  	  phones.
> >  
> > +config BACKLIGHT_KTZ8866
> > +	tristate "Backlight Driver for Kinetic KTZ8866"
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +		Say Y to enable the backlight driver for the Kinetic KTZ8866
> > +		found in Xiaomi Mi Pad 5 series.
> > +
> >  config BACKLIGHT_LM3533
> >  	tristate "Backlight Driver for LM3533"
> >  	depends on MFD_LM3533
> > diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> > index e815f3f1deff..f70a819c304c 100644
> > --- a/drivers/video/backlight/Makefile
> > +++ b/drivers/video/backlight/Makefile
> > @@ -36,6 +36,7 @@ obj-$(CONFIG_BACKLIGHT_HP680)		+= hp680_bl.o
> >  obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
> >  obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
> >  obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
> > +obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
> >  obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
> >  obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
> >  obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
> > diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
> > new file mode 100644
> > index 000000000000..ca3ac349cd10
> > --- /dev/null
> > +++ b/drivers/video/backlight/ktz8866.c
> > @@ -0,0 +1,205 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Backlight driver for the Kinetic KTZ8866
> > + *
> > + * Copyright (C) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
> > + */
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +
> > +#define DEFAULT_BRIGHTNESS 1500
> > +#define MAX_BRIGHTNESS 2047
> > +#define REG_MAX 0x15
> > +
> > +/* reg */
> > +#define DEVICE_ID 0x01
> > +#define BL_CFG1 0x02
> > +#define BL_CFG2 0x03
> > +#define BL_BRT_LSB 0x04
> > +#define BL_BRT_MSB 0x05
> > +#define BL_EN 0x08
> > +#define LCD_BIAS_CFG1 0x09
> > +#define LCD_BIAS_CFG2 0x0A
> > +#define LCD_BIAS_CFG3 0x0B
> > +#define LCD_BOOST_CFG 0x0C
> > +#define OUTP_CFG 0x0D
> > +#define OUTN_CFG 0x0E
> > +#define FLAG 0x0F
> > +#define BL_OPTION1 0x10
> > +#define BL_OPTION2 0x11
> > +#define PWM2DIG_LSBs 0x12
> > +#define PWM2DIG_MSBs 0x13
> > +#define BL_DIMMING 0x14
> > +#define PWM_RAMP_TIME 0x15
> > +
> > +/* definition */
> > +#define BL_EN_BIT BIT(6)
> > +#define LCD_BIAS_EN 0x9F
> > +#define PWM_HYST 0x5
> > +
> > +struct ktz8866 {
> > +	struct i2c_client *client;
> > +	struct regmap *regmap;
> > +	bool led_on;
> > +};
> > +
> > +static const struct regmap_config ktz8866_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = REG_MAX,
> > +};
> > +
> > +static int ktz8866_write(struct ktz8866 *ktz, unsigned int reg,
> > +			 unsigned int val)
> > +{
> > +	return regmap_write(ktz->regmap, reg, val);
> > +}
> > +
> > +static int ktz8866_update_bits(struct ktz8866 *ktz, unsigned int reg,
> > +			       unsigned int mask, unsigned int val)
> > +{
> > +	return regmap_update_bits(ktz->regmap, reg, mask, val);
> > +}
> > +
> > +static int ktz8866_backlight_update_status(struct backlight_device *backlight_dev)
> > +{
> > +	struct ktz8866 *ktz = bl_get_data(backlight_dev);
> > +	unsigned int brightness = backlight_get_brightness(backlight_dev);
> > +
> > +	if (!ktz->led_on && brightness > 0) {
> > +		ktz8866_update_bits(ktz, BL_EN, BL_EN_BIT, BL_EN_BIT);
> > +		ktz->led_on = true;
> > +	} else if (brightness == 0) {
> > +		ktz8866_update_bits(ktz, BL_EN, BL_EN_BIT, 0);
> > +		ktz->led_on = false;
> > +		msleep(10);
> 
> Why 10 ms? Document magic values. Their need, reason behind.
> 
> > +	}
> > +
> > +	/* Set brightness */
> > +	ktz8866_write(ktz, BL_BRT_LSB, brightness & 0x7);
> > +	ktz8866_write(ktz, BL_BRT_MSB, (brightness >> 3) & 0xFF);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct backlight_ops ktz8866_backlight_ops = {
> > +	.options = BL_CORE_SUSPENDRESUME,
> > +	.update_status = ktz8866_backlight_update_status,
> > +};
> > +
> > +static void ktz8866_init(struct ktz8866 *ktz)
> > +{
> > +	unsigned int val;
> > +
> > +	if(of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
> 
> Here and in other places - not conforming to coding style. Missing space
> before (.
> 
> Be sure you run checkpatch --strict and fix all relevant errors.
> 
> > +		ktz8866_write(ktz, BL_EN, BIT(val) - 1);
> > +	else
> > +		/* Enable all 6 current sinks if the number of current sinks isn't specifed. */
> > +		ktz8866_write(ktz, BL_EN, BIT(6) - 1);
> > +
> > +	if(of_property_read_u32(ktz->client->dev.of_node, "current-ramping-time-ms", &val)) {
> > +		if(val <= 128) {
> > +			ktz8866_write(ktz, BL_CFG2, BIT(7) | (ilog2(val) << 3) | PWM_HYST);
> > +		} else {
> > +			ktz8866_write(ktz, BL_CFG2, BIT(7) | ((5 + val / 64) << 3) | PWM_HYST);
> > +		}
> > +	}
> > +
> > +	if(of_property_read_u32(ktz->client->dev.of_node, "led-ramping-time-ms", &val)) {
> > +		if(val == 0) {
> > +			ktz8866_write(ktz, BL_DIMMING, 0);
> > +		} else {
> > +			unsigned int ramp_off_time = ilog2(val) + 1;
> > +			unsigned int ramp_on_time = ramp_off_time << 4;
> > +			ktz8866_write(ktz, BL_DIMMING, ramp_on_time | ramp_off_time);
> > +		}
> > +	}
> > +
> > +	if(of_property_read_bool(ktz->client->dev.of_node, "enable-lcd-bias"))
> > +		ktz8866_write(ktz, LCD_BIAS_CFG1, LCD_BIAS_EN);
> > +}
> > +
> > +static int ktz8866_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	struct backlight_device *backlight_dev;
> > +	struct backlight_properties props;
> > +	struct ktz8866 *ktz;
> > +
> > +	ktz = devm_kzalloc(&client->dev, sizeof(*ktz), GFP_KERNEL);
> > +	if (!ktz)
> > +		return -ENOMEM;
> > +
> > +	ktz->client = client;
> > +	ktz->regmap = devm_regmap_init_i2c(client, &ktz8866_regmap_config);
> > +
> 
> Drop blank line
> 
> > +	if (IS_ERR(ktz->regmap)) {
> > +		dev_err(&client->dev, "failed to init regmap\n");
> 
> dev_err_probe
> 
> > +		return PTR_ERR(ktz->regmap);
> > +	}
> > +
> > +	memset(&props, 0, sizeof(props));
> > +	props.type = BACKLIGHT_RAW;
> > +	props.max_brightness = MAX_BRIGHTNESS;
> > +	props.brightness = DEFAULT_BRIGHTNESS;
> > +	props.scale = BACKLIGHT_SCALE_LINEAR;
> > +
> > +	backlight_dev = devm_backlight_device_register(
> > +		&client->dev, "ktz8866-backlight", &client->dev, ktz,> +		&ktz8866_backlight_ops, &props);
> > +
> 
> Drop blank line
> 
> > +	if (IS_ERR(backlight_dev)) {
> > +		dev_err(&client->dev, "failed to register backlight device\n");
> 
> dev_err_probe
> 
> > +		return PTR_ERR(backlight_dev);
> > +	}
> > +
> > +	ktz8866_init(ktz);
> > +
> > +	i2c_set_clientdata(client, backlight_dev);
> > +	backlight_update_status(backlight_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static void ktz8866_remove(struct i2c_client *client)
> > +{
> > +	struct backlight_device *backlight_dev = i2c_get_clientdata(client);
> > +
> > +	backlight_dev->props.brightness = 0;
> > +	backlight_update_status(backlight_dev);
> > +}
> > +
> > +static const struct i2c_device_id ktz8866_ids[] = {
> > +	{ "ktz8866", 0 },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ktz8866_ids);
> > +
> > +static const struct of_device_id ktz8866_match_table[] = {
> > +	{
> > +		.compatible = "kinetic,ktz8866",
> > +	},
> > +	{},
> > +};
> > +
> > +static struct i2c_driver ktz8866_driver = {
> > +	.driver = {
> > +		.name = "ktz8866",
> > +		.of_match_table = ktz8866_match_table,
> > +	},
> > +	.probe = ktz8866_probe,
> > +	.remove = ktz8866_remove,
> > +	.id_table = ktz8866_ids,
> > +};
> > +
> > +module_i2c_driver(ktz8866_driver);
> > +
> > +MODULE_DESCRIPTION("Kinetic KTZ8866 Backlight Driver");
> > +MODULE_AUTHOR("Jianhua Lu <lujianhua000@gmail.com>");
> > +MODULE_LICENSE("GPL");
> 
> Best regards,
> Krzysztof
> 
I will send new version patches, thanks.
