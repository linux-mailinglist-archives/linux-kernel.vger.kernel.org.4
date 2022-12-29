Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47568658DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiL2OCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2OCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:02:01 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C6FED;
        Thu, 29 Dec 2022 06:01:57 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id y194-20020a4a45cb000000b004a08494e4b6so3156138ooa.7;
        Thu, 29 Dec 2022 06:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yioAVI6+zgw454eICpzYlCELxSt3pmYSYWdJrFTwAWk=;
        b=LtPIIBkU9J9lpUOxembRvMJQe9VC6DgVnokGY1mT7P/Jpi6JC4PEgw460skkezm1lv
         mUhfEPlh0EfeU8orpp3jHKacjLqdeGxkgx5fSUia/LtbdBpBu+OnU3zpFpN31eDPKsvA
         nTid/+6AkaxnjaAbl9ttCkrZgTFEB503QObtquyOpP/SD/Z0x08P3MXS+N6htRSeZcGh
         oJgrbz9hO1Kz1mBny1hMl6F7e1YOqJ11oF3vynztkZq3RoZnRpQvo+VI+4A9SkBWpnHZ
         hTbal481rXmC+hS1bDaxuizUXR1dzldU1bnP4RHVIb402emVf5l1NxKMU/5+EAXS8Ofn
         jHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yioAVI6+zgw454eICpzYlCELxSt3pmYSYWdJrFTwAWk=;
        b=TVDkhfeciEf4IJGWB+IWcbOIC+kxwvPTVh2u/yAtMzr7EHkyjwXdLt1bnaYpu1kvgD
         SEnNqXGXwlNaLvPsAgtvyWIOfGZXrMNQXlpdFlWEuiSp18ijKH4cFuTZDmQko2RHZFCI
         3TOxZZSQbbWpB5aUbTY1DftBSMyBpNUL5oO56T151ea4Z58IK46/K43VUdDM3k/ZGvhM
         WzOZM7ld0lkcHd4gwYYgoBnaZopYc7WyPLJrsLYjC2qIu3gxMxrCWKCl6NHzPfQzrmBx
         +qKpDLXZkObJnTOQSD9aKmMNWlKFIhxjZ//q+lF1DdXkFT5eQhGE8utOMlXVRTD39IU8
         VHCQ==
X-Gm-Message-State: AFqh2krFcQVP/baKVlUQ0i5Z46Wjatm6xVMj9WJntekYoJSx9BfwdSMn
        sIN8bDf2igchP27F1jP1VUHAAYte79Y=
X-Google-Smtp-Source: AMrXdXtsV42J5ZWjWQtY7AbZeJs0oQTfJeqpDfewj+Yv49roV9UXlZ/1F/uOmK3xpKTWzGcEhGDDFQ==
X-Received: by 2002:a05:6820:16d:b0:4b9:1b69:579f with SMTP id k13-20020a056820016d00b004b91b69579fmr13629507ood.4.1672322517062;
        Thu, 29 Dec 2022 06:01:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020a4ac546000000b0049fcedf1899sm7477676ooq.3.2022.12.29.06.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:01:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:01:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] hwmon: (pmbus/mpq7932) Add a support for mpq7932
 Power Management IC
Message-ID: <20221229140155.GA17849@roeck-us.net>
References: <20221207173716.123223-1-saravanan@linumiz.com>
 <20221207173716.123223-4-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207173716.123223-4-saravanan@linumiz.com>
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

On Wed, Dec 07, 2022 at 06:37:15PM +0100, Saravanan Sekar wrote:
> The MPQ7932 is a power management IC designed to operate from 5V buses to
> power a variety of Advanced driver-assistance system SOCs. Six integrated
> buck converters with hardware monitoring capability powers a variety of
> target rails configurable over PMBus interface.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>

Applied to hwmon-next, after changing multi-line comments.

Guenter

> ---
>  drivers/hwmon/pmbus/Kconfig   |  16 ++++
>  drivers/hwmon/pmbus/Makefile  |   1 +
>  drivers/hwmon/pmbus/mpq7932.c | 153 ++++++++++++++++++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/mpq7932.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 89668af67206..30448e049486 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -317,6 +317,22 @@ config SENSORS_MP5023
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mp5023.
>  
> +config SENSORS_MPQ7932_REGULATOR
> +	bool "Regulator support for MPQ7932"
> +	depends on SENSORS_MPQ7932 && REGULATOR
> +	help
> +	  If you say yes here you get six integrated buck converter regulator
> +	  support for power management IC MPS MPQ7932.
> +
> +config SENSORS_MPQ7932
> +	tristate "MPS MPQ7932"
> +	help
> +	  If you say yes here you get hardware monitoring functionality support
> +	  for power management IC MPS MPQ7932.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mpq7932.
> +
>  config SENSORS_PIM4328
>  	tristate "Flex PIM4328 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 0002dbe22d52..d9d2fa4bd6f7 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>  obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>  obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> +obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
>  obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
>  obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
> diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
> new file mode 100644
> index 000000000000..1dc1ab71957b
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mpq7932.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * mpq7932.c - hwmon with optional regulator driver for mps mpq7932
> + * Copyright 2022 Monolithic Power Systems, Inc
> + *
> + * Author: Saravanan Sekar <saravanan@linumiz.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +#define MPQ7932_BUCK_UV_MIN		206250
> +#define MPQ7932_UV_STEP			6250
> +#define MPQ7932_N_VOLTAGES		256
> +#define MPQ7932_VOUT_MAX		0xFF
> +#define MPQ7932_NUM_PAGES		6
> +
> +#define MPQ7932_TON_DELAY		0x60
> +#define MPQ7932_VOUT_STARTUP_SLEW	0xA3
> +#define MPQ7932_VOUT_SHUTDOWN_SLEW	0xA5
> +#define MPQ7932_VOUT_SLEW_MASK		GENMASK(1, 0)
> +#define MPQ7932_TON_DELAY_MASK		GENMASK(4, 0)
> +
> +struct mpq7932_data {
> +	struct pmbus_driver_info info;
> +	struct pmbus_platform_data pdata;
> +};
> +
> +#if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
> +static struct regulator_desc mpq7932_regulators_desc[] = {
> +	PMBUS_REGULATOR_STEP("buck", 0, MPQ7932_N_VOLTAGES,
> +			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 1, MPQ7932_N_VOLTAGES,
> +			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 2, MPQ7932_N_VOLTAGES,
> +			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 3, MPQ7932_N_VOLTAGES,
> +			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 4, MPQ7932_N_VOLTAGES,
> +			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 5, MPQ7932_N_VOLTAGES,
> +			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +};
> +#endif
> +
> +static int mpq7932_write_word_data(struct i2c_client *client, int page, int reg,
> +				   u16 word)
> +{
> +	switch (reg) {
> +	/* chip support only byte access for VOUT_COMMAND otherwise
> +	 * results -EREMOTEIO
> +	 */

/*
 * We do not use or accept networking-style multi-line comments in the hwmon
 * subsystem.
 */

> +	case PMBUS_VOUT_COMMAND:
> +		return pmbus_write_byte_data(client, page, reg, word & 0xFF);
> +
> +	default:
> +		return -ENODATA;
> +	}
> +}
> +
> +static int mpq7932_read_word_data(struct i2c_client *client, int page,
> +				  int phase, int reg)
> +{
> +	switch (reg) {
> +	/* chip support neither (PMBUS_VOUT_MARGIN_HIGH, PMBUS_VOUT_MARGIN_LOW)
> +	 * nor (PMBUS_MFR_VOUT_MIN, PMBUS_MFR_VOUT_MAX). As a result set voltage
> +	 * fails due to error in pmbus_regulator_get_low_margin, so faked.
> +	 */
> +	case PMBUS_MFR_VOUT_MIN:
> +		return 0;
> +
> +	case PMBUS_MFR_VOUT_MAX:
> +		return MPQ7932_VOUT_MAX;
> +
> +	/* chip support only byte access for VOUT_COMMAND otherwise
> +	 * results -EREMOTEIO
> +	 */
> +	case PMBUS_READ_VOUT:
> +		return pmbus_read_byte_data(client, page, PMBUS_VOUT_COMMAND);
> +
> +	default:
> +		return -ENODATA;
> +	}
> +}
> +
> +static int mpq7932_probe(struct i2c_client *client)
> +{
> +	struct mpq7932_data *data;
> +	struct pmbus_driver_info *info;
> +	struct device *dev = &client->dev;
> +	int i;
> +
> +	data = devm_kzalloc(dev, sizeof(struct mpq7932_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	info = &data->info;
> +	info->pages = MPQ7932_NUM_PAGES;
> +	info->format[PSC_VOLTAGE_OUT] = direct;
> +	info->m[PSC_VOLTAGE_OUT] = 160;
> +	info->b[PSC_VOLTAGE_OUT] = -33;
> +	for (i = 0; i < info->pages; i++) {
> +		info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +				| PMBUS_HAVE_STATUS_TEMP;
> +	}
> +
> +#if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
> +	info->num_regulators = ARRAY_SIZE(mpq7932_regulators_desc);
> +	info->reg_desc = mpq7932_regulators_desc;
> +#endif
> +
> +	info->read_word_data = mpq7932_read_word_data;
> +	info->write_word_data = mpq7932_write_word_data;
> +
> +	data->pdata.flags = PMBUS_NO_CAPABILITY;
> +	dev->platform_data = &data->pdata;
> +
> +	return pmbus_do_probe(client, info);
> +}
> +
> +static const struct of_device_id mpq7932_of_match[] = {
> +	{ .compatible = "mps,mpq7932"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mpq7932_of_match);
> +
> +static const struct i2c_device_id mpq7932_id[] = {
> +	{ "mpq7932", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, mpq7932_id);
> +
> +static struct i2c_driver mpq7932_regulator_driver = {
> +	.driver = {
> +		.name = "mpq7932",
> +		.of_match_table = mpq7932_of_match,
> +	},
> +	.probe_new = mpq7932_probe,
> +	.id_table = mpq7932_id,
> +};
> +module_i2c_driver(mpq7932_regulator_driver);
> +
> +MODULE_AUTHOR("Saravanan Sekar <saravanan@linumiz.com>");
> +MODULE_DESCRIPTION("MPQ7932 PMIC regulator driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
