Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E2063B8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiK2ECl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiK2ECg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:02:36 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B4C4E405;
        Mon, 28 Nov 2022 20:02:35 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so8324141otl.10;
        Mon, 28 Nov 2022 20:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdBZso3Vwpsp74oXRRyRaVCc75oEZpB0IFHYzSgMfQ4=;
        b=mqOJlPqOG4YRJeReE/QpFo1T0BieGLHmqCIgckZ0wDKo0GJSAbwH4t07hqcjBpl5mu
         +eYcKugVKP8J1QvqgUqWXqV4s/9Uue/Z8E9h+YHk+Ka4aBvcmtPCxaocxlMIe08KUNak
         rZUPSkFt695ps6/MZn/4WiJRORCjhoeUvu10t/mowfgX6nFdHgaBP0GGLuWS+vWPrELZ
         5dz0WqUgFcPNz04/h7/GgIkUeojgk5k3jTr06zPvLmZjGY72WmGwZpSF1fiDuVFPuqqX
         AOVDB2AsMj95sg1Pot2lPoEpchQeO7F+G4Df5MjVJVygNJMBKBY6izsweSHz8sMtW6I5
         DQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdBZso3Vwpsp74oXRRyRaVCc75oEZpB0IFHYzSgMfQ4=;
        b=tw1OL8O/tx1RQqlHMdMU85IvkMQJn9VHhxD6X/NpgYw8YyDYIOB7kO78cxjmONTtsO
         48kIc0/+YInBAePrOvTxqfEpEM0bbu9wBaZX/VWJ8cckFWTzjQHGnGuSEMYv2ZmRlC7X
         i/nnUC7N8YlPcO1ijG2XlollGdnzm9NRJu++2VikboYp0VQPylDq1KlxzdChR/Nozi6u
         0NyloDGfY/1DQkKZLup9SEgQMv3cdLOzKLKR3dzgOJRHd7/fSLMUTdmMqSZgxkmaP//J
         NEu5zXA8GJ6NGAqZSoyeH6obxuOPLuT2VI9pB0ChKWGiGSD20Y9Ufcxne8AccNmdF3xw
         UCeA==
X-Gm-Message-State: ANoB5pns9qaYaYjO1Ix2O29DpRHxODGEHRN7ZKipa6moVARllv5Q5ywN
        Tffh9T52cujnS+jqd3fKp3U=
X-Google-Smtp-Source: AA0mqf5YHo27FVxUjCeQsfIU+jZLSL3Byyl+i+kAU1cnB2LHq3b76WRLMW7Fg3zOhdsUE3mZAcF8Iw==
X-Received: by 2002:a9d:6244:0:b0:66c:e574:8a6b with SMTP id i4-20020a9d6244000000b0066ce5748a6bmr26533398otk.183.1669694554282;
        Mon, 28 Nov 2022 20:02:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d23-20020a4aba97000000b0049ea9654facsm5052682oop.32.2022.11.28.20.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 20:02:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Nov 2022 20:02:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Message-ID: <20221129040232.GA1901150@roeck-us.net>
References: <20221128230219.39537-1-nick.hawkins@hpe.com>
 <20221128230219.39537-2-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128230219.39537-2-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:02:14PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP SoC can support up to 16 fans through the interface provided by
> the CPLD. The current support is limited to 8 fans. The fans speeds are
> controlled via 8 different PWMs which can vary in value from  0-255. The
> fans are also capable of reporting if they have failed to the CPLD which
> in turn reports the status to the GXP SoC.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
> 
> v2:
>  *Changed number of supported fans from 16 to 8 in code
>  *Remove last sentence of commit description
>  *Removed support for fan[0-15]_input in code and documentation
>  *Changed documentation to limit fan count to 7
>  *Changed documentation license
>  *Removed PWM defines
>  *Added gxp-fan-ctrl to hwmon's index.rst
>  *Removed mutex
>  *Added fan_enable support to report if the fan is enabled
>  *Changed presents to present
>  *Removed unnecessary ()
>  *Add comment for plreg reads and calculations
>  *Add comment for the use of platform power state in code
>  *Removed use of variable offsets and went with hardcoding instead
>  *Rewrote driver to use devm_hwmon_device_register_with_info()
>  *Remove unused header files
>  *Fix GPL header
>  *Changed module description
>  *Add kfree in case of failure to get regmaps or resource
> ---
>  Documentation/hwmon/gxp-fan-ctrl.rst |  28 +++
>  Documentation/hwmon/index.rst        |   1 +
>  drivers/hwmon/Kconfig                |   9 +
>  drivers/hwmon/Makefile               |   1 +
>  drivers/hwmon/gxp-fan-ctrl.c         | 305 +++++++++++++++++++++++++++
>  5 files changed, 344 insertions(+)
>  create mode 100644 Documentation/hwmon/gxp-fan-ctrl.rst
>  create mode 100644 drivers/hwmon/gxp-fan-ctrl.c
> 
> diff --git a/Documentation/hwmon/gxp-fan-ctrl.rst b/Documentation/hwmon/gxp-fan-ctrl.rst
> new file mode 100644
> index 000000000000..ae3397e81c04
> --- /dev/null
> +++ b/Documentation/hwmon/gxp-fan-ctrl.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver gxp-fan-ctrl
> +==========================
> +
> +Supported chips:
> +
> +  * HPE GXP SOC
> +
> +Author: Nick Hawkins <nick.hawkins@hpe.com>
> +
> +
> +Description
> +-----------
> +
> +gxp-fan-ctrl is a driver which provides fan control for the hpe gxp soc.
> +The driver allows the gathering of fan status and the use of fan
> +PWM control.
> +
> +
> +Sysfs attributes
> +----------------
> +
> +======================= ===========================================================
> +pwm[0-7]		Fan 0 to 7 respective PWM value (0-255)
> +fan[0-7]_fault		Fan 0 to 7 respective fault status: 1 fail, 0 ok
> +fan[0-7]_enable         Fan 0 to 7 respective enabled status: 1 enabled, 0 disabled
> +======================= ===========================================================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index f7113b0f8b2a..b319ab173d1d 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -73,6 +73,7 @@ Hardware Monitoring Kernel Drivers
>     g762
>     gsc-hwmon
>     gl518sm
> +   gxp-fan-ctrl
>     hih6130
>     ibmaem
>     ibm-cffps
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e70d9614bec2..9e0427f20141 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -705,6 +705,15 @@ config SENSORS_GPIO_FAN
>  	  This driver can also be built as a module. If so, the module
>  	  will be called gpio-fan.
>  
> +config SENSORS_GXP_FAN_CTRL
> +	tristate "HPE GXP fan controller"
> +	depends on ARCH_HPE_GXP || COMPILE_TEST
> +	help
> +	  If you say yes here you get support for GXP fan control functionality.
> +
> +	  The GXP controls fan function via the CPLD through the use of PWM
> +	  registers. This driver reports status and pwm setting of the fans.
> +
>  config SENSORS_HIH6130
>  	tristate "Honeywell Humidicon HIH-6130 humidity/temperature sensor"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 007e829d1d0d..b474dcc708c4 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
> +obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
>  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
>  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
>  obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
> diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
> new file mode 100644
> index 000000000000..0b03d33a3a7b
> --- /dev/null
> +++ b/drivers/hwmon/gxp-fan-ctrl.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define OFS_FAN_INST 0 /* Is 0 because plreg base will be set at INST */
> +#define OFS_FAN_FAIL 2 /* Is 2 bytes after base */
> +#define OFS_SEVSTAT 0 /* Is 0 because fn2 base will be set at SEVSTAT */
> +#define POWER_BIT 24
> +
> +struct gxp_fan_ctrl_drvdata {
> +	struct device	*dev;
> +	struct device	*hwmon_dev;

Both dev and hwmon_dev are unused and thus pointless.

> +	struct regmap	*plreg_map; /* Programmable logic register regmap */
> +	struct regmap	*fn2_map; /* Function 2 regmap */
> +	void __iomem	*base;
> +};
> +
> +static bool fan_installed(struct device *dev, int fan)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	regmap_read(drvdata->plreg_map, OFS_FAN_INST, &val);
> +	if (val & BIT(fan))
> +		return 1;
> +	else
> +		return 0;

else after return is unnecessary, and 
	return !!(val & BIT(fan));
would avoid the conditional.

> +}
> +
> +static long fan_failed(struct device *dev, int fan)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	/*
> +	 * The offset for fan fail is 2 which is not word aligned.
> +	 * Read from fan installed which is 0 and shift value.
> +	 */
> +
> +	regmap_read(drvdata->plreg_map, OFS_FAN_INST, &val);
> +
> +	if ((val >> (8 * OFS_FAN_FAIL)) & BIT(fan))
> +		return 1;
> +	else
> +		return 0;

else after return is pointless, and this can be written as

	return !!((val >> (8 * OFS_FAN_FAIL)) & BIT(fan));

to avoid the conditional.

> +}
> +
> +static long fan_enabled(struct device *dev, int fan)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +	unsigned int reg;
> +
> +	/*
> +	 * Check the power status as if the platform is off the value
> +	 * reported for the PWM will be incorrect. Report fan as
> +	 * disabled.
> +	 */
> +	regmap_read(drvdata->fn2_map, OFS_SEVSTAT, &reg);
> +
> +	/* If Fan is installed and the system is on it is enabled */
> +	if ((reg & BIT(POWER_BIT)) && fan_installed(dev, fan))
> +		return  1;
> +
> +	/* Platform power is off, fan is disabled */
> +	return 0;

Same as above.

> +}
> +
> +static int gxp_pwm_write(struct device *dev, u32 attr, int channel, long val)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		if (val > 255)
> +			return -EINVAL;

Should also check for values < 0.

> +		writeb(val, drvdata->base + channel);

The mixed use of direct writes and regmap is odd and confusing.
Why use regmap for plreg_map and for fn2_map but not for base ?
Can this be unified ? If not, why ?

> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int gxp_fan_ctrl_write(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		return gxp_pwm_write(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int gxp_fan_read(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	switch (attr) {
> +	case hwmon_fan_enable:
> +		*val = fan_enabled(dev, channel);
> +		return 0;
> +	case hwmon_fan_fault:
> +		*val = fan_failed(dev, channel);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int gxp_pwm_read(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +	unsigned int reg;
> +
> +	/*
> +	 * Check the power status of the platform. If the platform is off
> +	 * the value reported for the PWM will be incorrect. In this case
> +	 * report a PWM of zero.
> +	 */
> +	regmap_read(drvdata->fn2_map, 0, &reg);
> +	if (reg & BIT(POWER_BIT)) {
> +		/* If Fan present, then read it. */
> +		*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
> +	} else {
> +		*val = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gxp_fan_ctrl_read(struct device *dev, enum hwmon_sensor_types type,
> +			     u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return gxp_fan_read(dev, attr, channel, val);
> +	case hwmon_pwm:
> +		return gxp_pwm_read(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t gxp_fan_ctrl_is_visible(const void *_data,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr, int channel)
> +{
> +	umode_t mode = 0;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_enable:
> +		case hwmon_fan_fault:
> +			mode = 0444;

break; missing. Otherwise static analyzers will complain.

> +		default:
> +			break;
> +		}

Same as above (and, in this case, prove in point why break;
should always be added even if it seems unnecessary).

> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			mode = 0644;

Same as above.

> +		default:
> +			break;
> +		}

Same as above.

> +	default:
> +		break;
> +	}
> +
> +	return mode;
> +}
> +
> +static const struct hwmon_ops gxp_fan_ctrl_ops = {
> +	.is_visible = gxp_fan_ctrl_is_visible,
> +	.read = gxp_fan_ctrl_read,
> +	.write = gxp_fan_ctrl_write,
> +};
> +
> +static const struct hwmon_channel_info *gxp_fan_ctrl_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_FAULT | HWMON_F_ENABLE),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info gxp_fan_ctrl_chip_info = {
> +	.ops = &gxp_fan_ctrl_ops,
> +	.info = gxp_fan_ctrl_info,
> +
> +};
> +
> +static struct regmap *gxp_fan_ctrl_init_regmap(struct platform_device *pdev, char *reg_name)
> +{
> +	struct regmap_config regmap_config = {
> +		.reg_bits = 32,
> +		.reg_stride = 4,
> +		.val_bits = 32,
> +	};
> +	void __iomem *base;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, reg_name);
> +	if (IS_ERR(base))
> +		return ERR_CAST(base);
> +
> +	regmap_config.name = reg_name;
> +
> +	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
> +}
> +
> +static int gxp_fan_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct gxp_fan_ctrl_drvdata *drvdata;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	int error;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_fan_ctrl_drvdata),
> +			       GFP_KERNEL);

There is a local variable (dev) pointing to &pdev->dev.
I would suggest to use it.

> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->dev = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, drvdata);

There is no platform_get_drvdata() in this code, meaning
platform_set_drvdata() is unnecessary.

> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(drvdata->base)) {
> +		error = dev_err_probe(dev, PTR_ERR(drvdata->base),
> +				      "failed to map base\n");
> +		goto free_mem;
> +	}
> +	drvdata->plreg_map = gxp_fan_ctrl_init_regmap(pdev, "pl");
> +	if (IS_ERR(drvdata->plreg_map)) {
> +		error = dev_err_probe(dev, PTR_ERR(drvdata->plreg_map),
> +				      "failed to map plreg_handle\n");
> +		goto free_mem;
> +	}
> +
> +	drvdata->fn2_map = gxp_fan_ctrl_init_regmap(pdev, "fn2");
> +	if (IS_ERR(drvdata->fn2_map)) {
> +		error = dev_err_probe(dev, PTR_ERR(drvdata->fn2_map),
> +				      "failed to map fn2_handle\n");
> +		goto free_mem;
> +	}
> +
> +	drvdata->hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +								  "fan_ctrl",

fan_ctrl is a bit generic. Normally this reflects the driver name.

> +								  drvdata,
> +								  &gxp_fan_ctrl_chip_info,
> +								  NULL);
> +
> +	if (IS_ERR(drvdata->hwmon_dev)) {
> +		error = dev_err_probe(dev, PTR_ERR(drvdata->hwmon_dev),
> +				      "failed to register fan ctrl\n");
> +
> +		goto free_mem;
> +	}
> +
> +	return 0;
> +
> +free_mem:
> +	kfree(drvdata);

drvdata was allocated with a devm function. Releasing it with kfree
results in a double free. This goto and error handling is not only
unnecessary but wrong.

> +	return error;
> +}
> +
> +static const struct of_device_id gxp_fan_ctrl_of_match[] = {
> +	{ .compatible = "hpe,gxp-fan-ctrl", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gxp_fan_ctrl_of_match);
> +
> +static struct platform_driver gxp_fan_ctrl_driver = {
> +	.probe		= gxp_fan_ctrl_probe,
> +	.driver = {
> +		.name	= "gxp-fan-ctrl",
> +		.of_match_table = gxp_fan_ctrl_of_match,
> +	},
> +};
> +module_platform_driver(gxp_fan_ctrl_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_DESCRIPTION("HPE GXP fan controller");
> +MODULE_LICENSE("GPL");
