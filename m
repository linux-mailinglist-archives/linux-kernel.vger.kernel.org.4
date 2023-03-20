Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874E46C22B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCTUbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCTUbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:31:39 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38A013DD1;
        Mon, 20 Mar 2023 13:31:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f14so6025282iow.5;
        Mon, 20 Mar 2023 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gfYK0bX5S7genRF/sON2o+bfi4WasC/1IzTrYcf/kc=;
        b=Dvf7eQPhkolCQ5nbIMbEajl5tXNAGhCSiOcFD8LL+vgXXem2c9IK0VpXz54xaxJc8U
         erMc7uTuKH8CQecpEms0kUiix+hsSWOm2cOAMLp3sIkTh/+ovJt09lmSruyVoCwyHJX/
         cDLtUwFIyuZHDeWxPoBcSuUwYFZtwwK91VdLzUsmd7i/FIjXnzjYhYSDXMwmu4B8unu9
         cPZPz+NDpvQnyCJ/TcR6KY1oRnMJxWWQaTGSBwYIz/Z3lBvpJWEvkT0fbng4/yo274Cb
         2eKT2IO6lK+MrP6ASxBEtCCZTHIEvXTW5Z4zwi4Wrzm6DJEiCMC1bCWUWlz/0534GMOG
         6d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gfYK0bX5S7genRF/sON2o+bfi4WasC/1IzTrYcf/kc=;
        b=fdtBs77adr3syRgBV0+8V2FAtKswR1/ruLKnoa1q2i4wYwjlM6EIdYE1Xg5kZakC74
         LudY/rLVroofi8HMmifiP8D3QHZ6HjFFZY/yHYl6HnIS0UxYL7zYduMoS0gJlJ0uM/xZ
         4fFNIVhpZjxSu2pAFEoX6Y14Wr/FFIwUvvxrX6Xuhkd+3qCiPOjVpfYYVAAUHJ8cwyRP
         8XXPLlijTmjuaK2Ds/6a54AnLcqNvIrN5zZELyz4hnzsUnwGaPyyzJt9/25yC76sM2UI
         AmCLY2JESxjyrRN2+wUPvGSpnMyghSiwdAQYSrjkyyyD6UGrTAHvZ9poHq9ZJ+KTAEK5
         PbxA==
X-Gm-Message-State: AO0yUKVFv0vV2PED+n/e0jNmAvWFMTzKSZaTsE25qqSTPnTU3USM/8wz
        vNBGpmO9IcnWoiXeMHNNssY=
X-Google-Smtp-Source: AK7set/ruFnR10D4y7bea8W7of8zkR/kM0RzakzIbpmiREdZ4IHlo+AiXbCGaQp5W+iVaOMhunpcLg==
X-Received: by 2002:a5d:8d0b:0:b0:74c:d689:64bd with SMTP id p11-20020a5d8d0b000000b0074cd68964bdmr79548ioj.19.1679344291906;
        Mon, 20 Mar 2023 13:31:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a026646000000b003c488204c6fsm3441356jaf.76.2023.03.20.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:31:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Mar 2023 13:31:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power
 supply driver
Message-ID: <5466e42f-6a3d-4b33-8215-ae374d3d5fc9@roeck-us.net>
References: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
 <20230320154019.1943770-4-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320154019.1943770-4-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:40:17AM -0500, Lakshmi Yadlapati wrote:
> Add the driver to support Acbel CRPS power supply.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
> Changes since V1
> - Removed debugfs stuff.
> - Removed acbel_crps_read_word_data and acbel_crps_read_byte_data.
> - Removed PMBUS_MFR_IIN_MAX.
> - Added validation for the supported power supply.
> - Fix the formatting.
> 
>  drivers/hwmon/pmbus/Kconfig      |  10 +++
>  drivers/hwmon/pmbus/Makefile     |   1 +
>  drivers/hwmon/pmbus/acbel-crps.c | 102 +++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/acbel-crps.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 59d9a7430499..0215709c3dd2 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -27,6 +27,16 @@ config SENSORS_PMBUS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pmbus.
>  
> +config SENSORS_ACBEL_CRPS
> +	tristate "ACBEL CRPS Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for the ACBEL
> +	  Common Redundant Power Supply.
> +

This sounds like there is only one, but ...

> +	  This driver can also be built as a module. If so, the module will
> +	  be called acbel-crps.
> +	  Supported models: FSG032-00xG
> +
... here it says that only one model is (currently) supported.

This should just say "Support for Acbel FSG032-00xG CRPS Power Supply"
and not claim that it supports any others.

I am also not convinced that the Kconfig option driver name should simply
be "crps" There is no guarantee that all crps power supplies from this
vendor will always be supported (supportable) by this driver.


>  config SENSORS_ADM1266
>  	tristate "Analog Devices ADM1266 Sequencer"
>  	select CRC8
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 3ae019916267..39aef0cb9934 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
> +obj-$(CONFIG_SENSORS_ACBEL_CRPS) += acbel-crps.o
>  obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
> diff --git a/drivers/hwmon/pmbus/acbel-crps.c b/drivers/hwmon/pmbus/acbel-crps.c
> new file mode 100644
> index 000000000000..ac281699709f
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/acbel-crps.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2023 IBM Corp.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include <linux/hwmon-sysfs.h>

Unused include

> +#include "pmbus.h"
> +
> +struct acbel_crps {
> +	struct i2c_client *client;
> +};
> +
> +static const struct i2c_device_id acbel_crps_id[] = {
> +	{ "acbel_crps" },
> +	{}
> +};
> +#define to_psu(x, y) container_of((x), struct acbel_crps, debugfs_entries[(y)])
> +
> +static const struct file_operations acbel_crps_fops = {
> +	.llseek = noop_llseek,
> +	.open = simple_open,
> +};

The above code is unused.

> +
> +static struct pmbus_driver_info acbel_crps_info = {
> +	.pages = 1,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +		   PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
> +		   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +		   PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_VOUT |
> +		   PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_TEMP |
> +		   PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_FAN12,
> +};
> +
> +static int acbel_crps_probe(struct i2c_client *client)
> +{
> +	struct acbel_crps *psu;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct device *dev = &client->dev;
> +	int rc;
> +
> +	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read PMBUS_MFR_ID\n");
> +		return rc;
> +	}
> +	if (strncmp(buf, "ACBEL", 5)) {

this also needs to check for rc
	if (rc < 5 || ...)

> +		buf[rc] = '\0';
> +		dev_err(dev, "Manufacturer '%s' not supported\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read PMBUS_MFR_MODEL\n");
> +		return rc;
> +	}
> +
> +	if (strncmp(buf, "FSG032", 6)) {

	if (rc < 6 || ...)

> +		buf[rc] = '\0';
> +		dev_err(dev, "Model '%s' not supported\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	rc = pmbus_do_probe(client, &acbel_crps_info);
> +	if (rc)
> +		return rc;
> +	/*
> +         * Don't fail the probe if there isn't enough memory for debugfs.
> +         */

Formatting

> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu)
> +		return 0;

This code doesn't make any sense.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id acbel_crps_of_match[] = {
> +	{ .compatible = "acbel,crps" },

This is way too generic. What if there is some other Acbel power supply
which needs some other options or supports other attributes ?
This needs to be something like "acbel,fsg032" or similar.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, acbel_crps_of_match);
> +
> +static struct i2c_driver acbel_crps_driver = {
> +	.driver = {
> +		.name = "acbel-crps",
> +		.of_match_table = acbel_crps_of_match,
> +	},
> +	.probe_new = acbel_crps_probe,

I think probe_new may be gone.

> +	.id_table = acbel_crps_id,
> +};
> +
> +module_i2c_driver(acbel_crps_driver);
> +
> +MODULE_AUTHOR("Lakshmi Yadlapati");
> +MODULE_DESCRIPTION("PMBus driver for AcBel Power System power supplies");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
> -- 
> 2.37.2
> 
