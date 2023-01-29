Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE968013F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjA2Tru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjA2Trr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:47:47 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E711C598;
        Sun, 29 Jan 2023 11:47:46 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id a1-20020a056830008100b006864df3b1f8so4019135oto.3;
        Sun, 29 Jan 2023 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVHAZwfBRaITMP5Lu7wSdYtGgYjpcdMTQa5SHgRGH8I=;
        b=Ll26AyUBXHQN9s1Q3fOcS6UGC16cbdEgawag9HG4byplrG67pKNxuOLkBGj12U8vfV
         yfrHb1s/k78soGM6OA43nUpLc6BKFzQR7cU5WP5CxXRc2Gvh0jG094LVBqPpu/b5E6hU
         le862mAymjn6ULwui94U38caqc5kNdkoyi0mCkEmPtOUDKDhIMGKZ8fjFy96p0zwemja
         RGteaQ5LVusaDHfsmG7AKgti68Mb27AiEzVtvnZ2/RlmZL5s4MAVBgrwYcTGCqQ7hGrB
         5pAVP0bz9gCtAg6iNpFjwBMAwxNxP19kI5B6MI37KGBDmIv0BeekT8T4IrrOBt7ilxqm
         bJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVHAZwfBRaITMP5Lu7wSdYtGgYjpcdMTQa5SHgRGH8I=;
        b=2ssaAocsC0DR3UE8/VXNFoxj/RM8j4o2099i80Bn9FbHsAbE2ju0MfLOWN8p0EBrYx
         w+Zap4zrl75syaJBg54URTnpkYQ1d7c9ydr6oEj9/hD5HJj2qs+I/avKF8MUfy/TkDSI
         vCqVyFhT0Kyj5GJ00u9HHJ9zM59Jjup9SLPUPnQ1KVw0AGYuQyQZA29nX3TGrol8aDh/
         Te1qKYUniJjkv+jfH+Io+gZXYuwG7UJxAg7hh2dNpvBYSE3U8TjBtGmAhonuS55fvP2K
         p0k7QXDMhIgfEKhA2GoK6KnDGCh5fXTzu/SbYIPh0VSGwrNnkm24QwF2ej/TVYjd/38j
         iygw==
X-Gm-Message-State: AO0yUKXf4L9PfmiqGUC0CMdn9Tpw/ygSMqbItK8v+DZHyYPaxObM+pDD
        WU0IpDL+GN3ariDuiZTWWrAFTyT8xho=
X-Google-Smtp-Source: AK7set+ASqyZc5nr3PtXEufVrguvWt800lwIOrl4WhwKqqs0zO3ZgSnl94wU1JQcre0PWgMtXUHm8w==
X-Received: by 2002:a9d:6c4:0:b0:68b:ca10:4a0 with SMTP id 62-20020a9d06c4000000b0068bca1004a0mr1748675otx.14.1675021666181;
        Sun, 29 Jan 2023 11:47:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y12-20020a056830070c00b0068bcb290a38sm1360096ots.55.2023.01.29.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 11:47:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Jan 2023 11:47:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        krzysztof.kozlowski@linaro.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: (pmbus/tda38640) Add driver for Infineon
 TDA38640 Voltage Regulator
Message-ID: <20230129194744.GA1418915@roeck-us.net>
References: <20230124202317.3704963-1-Naresh.Solanki@9elements.com>
 <20230124202317.3704963-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124202317.3704963-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:23:17PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add the pmbus driver for the Infineon TDA38640 voltage regulator.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/Kconfig    | 16 ++++++++
>  drivers/hwmon/pmbus/Makefile   |  1 +
>  drivers/hwmon/pmbus/tda38640.c | 74 ++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/tda38640.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 30448e049486..9f4bbb9c487a 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -395,6 +395,22 @@ config SENSORS_STPDDC60
>  	  This driver can also be built as a module. If so, the module will
>  	  be called stpddc60.
>  
> +config SENSORS_TDA38640
> +	tristate "Infineon TDA38640"
> +	help
> +	  If you say yes here you get hardware monitoring support for Infineon
> +	  TDA38640.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called tda38640.
> +
> +config SENSORS_TDA38640_REGULATOR
> +	bool "Regulator support for TDA38640 and compatibles"
> +	depends on SENSORS_TDA38640 && REGULATOR
> +	help
> +	  If you say yes here you get regulator support for Infineon
> +	  TDA38640 as regulator.
> +
>  config SENSORS_TPS40422
>  	tristate "TI TPS40422"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index d9d2fa4bd6f7..3ae019916267 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
>  obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
> +obj-$(CONFIG_SENSORS_TDA38640)	+= tda38640.o
>  obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>  obj-$(CONFIG_SENSORS_TPS546D24)	+= tps546d24.o
> diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
> new file mode 100644
> index 000000000000..c3e781319cd1
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/tda38640.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Infineon TDA38640
> + *
> + * Copyright (c) 2023 9elements GmbH
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/driver.h>
> +#include "pmbus.h"
> +
> +static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
> +	PMBUS_REGULATOR("vout", 0),
> +};
> +
> +static struct pmbus_driver_info tda38640_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> +	    | PMBUS_HAVE_IIN
> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +	    | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN,
> +#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
> +	.num_regulators = 1,
> +	.reg_desc = tda38640_reg_desc,
> +#endif
> +};
> +
> +static int tda38640_probe(struct i2c_client *client)
> +{
> +	return pmbus_do_probe(client, &tda38640_info);
> +}
> +
> +static const struct i2c_device_id tda38640_id[] = {
> +	{"tda38640", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, tda38640_id);
> +
> +static const struct of_device_id __maybe_unused tda38640_of_match[] = {
> +	{ .compatible = "infineon,tda38640"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tda38640_of_match);
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver tda38640_driver = {
> +	.driver = {
> +		.name = "tda38640",
> +		.of_match_table = of_match_ptr(tda38640_of_match),
> +	},
> +	.probe_new = tda38640_probe,
> +	.id_table = tda38640_id,
> +};
> +
> +module_i2c_driver(tda38640_driver);
> +
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("PMBus driver for Infineon TDA38640");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
