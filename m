Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1471171961D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjFAIyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFAIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5259F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685609632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y85+H09EVrraft6UYcmNFDvtbIuHgYDgtawu93D8ue0=;
        b=KCYoybeT7NYlamLcyOjXIgSsg251BhXf+Fv4msd9MepUk70HlYE2ONXj/BuTiytz+wTmCg
        gkvDlq0V83zQccISsFYhPEsYo4AeoJvdZ1ISoyfEAsaKTh1ASJU8A/cvmB8/kQn5iyW5N2
        4ur2w7tYaPb79XoJpQTVEofnf+bjpkE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-zTH2cRMdOC6Req0WDo0Lug-1; Thu, 01 Jun 2023 04:53:51 -0400
X-MC-Unique: zTH2cRMdOC6Req0WDo0Lug-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34a0b75eso35532866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685609630; x=1688201630;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y85+H09EVrraft6UYcmNFDvtbIuHgYDgtawu93D8ue0=;
        b=mCplt6r+2Jm0axa2j80QZkoLq29AfbVmlxvFMb1GyRcMV8MLwxnd9oWrdfyv26rqxp
         f7WtDpzVZq5ym12l0qlRCHFgHCkhqDNfbE54YhtzSm/Uf9gB/jYewszWlQt6Cr6V0LA9
         PArRoJkPKu4GPlrH6niCC/S/XsUq67qIZHyJoZVBnoBBU+VYobpEDcxRK4OUrfuKH4Gz
         HnTp4vvfJmKmZcbC5IpC6ZC32ode/2/n07c50fiE88h643BLQDaQrx6dE/JeTEAgYcIX
         HViFXFpaQn3QNcMib76GjFmCNcr7AX8CZmGFzrh09PyjWlx3X4BHVpFWPrOC0k2nQly0
         rKyg==
X-Gm-Message-State: AC+VfDwE5paj3jM6CaAc75+dF6hPdub0lhncfQcfJuVQNxzGikGiTEzS
        /pmOCEYE99z1LeRFIMlN2Go2GiE7mVtD5V/uNsYVws0P0rwCy+9qBy90LNBiwnOa64FL0PQOy/q
        uTGHiIxqqzHWMMrSKwHr9IMTi
X-Received: by 2002:a17:907:1c22:b0:94b:cd7c:59f4 with SMTP id nc34-20020a1709071c2200b0094bcd7c59f4mr8343826ejc.16.1685609630053;
        Thu, 01 Jun 2023 01:53:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OwrBwkbyOccrBgx+FBlzOxAlRKDhWvn4BF9AZuUDgZjj/RCQn/C88C7t+iiQLUww1b3i/Yg==
X-Received: by 2002:a17:907:1c22:b0:94b:cd7c:59f4 with SMTP id nc34-20020a1709071c2200b0094bcd7c59f4mr8343810ejc.16.1685609629696;
        Thu, 01 Jun 2023 01:53:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id oq27-20020a170906cc9b00b009662c57b4ffsm10226845ejb.96.2023.06.01.01.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:53:49 -0700 (PDT)
Message-ID: <5109f2da-3b7f-421f-555c-810484d92b4c@redhat.com>
Date:   Thu, 1 Jun 2023 10:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] leds: simatic-ipc-leds-gpio: add new model BX-21A
Content-Language: en-US, nl
To:     Henning Schild <henning.schild@siemens.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230531155457.31632-1-henning.schild@siemens.com>
 <20230531155457.31632-2-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230531155457.31632-2-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/31/23 17:54, Henning Schild wrote:
> This adds support for the Siemens Simatic IPC BX-21A. Its LEDs are
> connected to GPIO pins provided by the Intel Elkhart Lake pinctrl
> driver.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Thank you for the patch.

Since this mostly touches files under drivers/leds I believe it would be best for this to be merged through Lee's LEDs tree.

Here is my ack for merging the pdx86 bits through that tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/leds/simple/Kconfig                   | 13 +++++
>  drivers/leds/simple/Makefile                  |  1 +
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  |  4 ++
>  .../simatic-ipc-leds-gpio-elkhartlake.c       | 57 +++++++++++++++++++
>  drivers/platform/x86/simatic-ipc.c            |  3 +
>  .../platform_data/x86/simatic-ipc-base.h      |  1 +
>  include/linux/platform_data/x86/simatic-ipc.h |  3 +-
>  7 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
> 
> diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
> index 44fa0f93cb3b..626ab18ac09d 100644
> --- a/drivers/leds/simple/Kconfig
> +++ b/drivers/leds/simple/Kconfig
> @@ -34,3 +34,16 @@ config LEDS_SIEMENS_SIMATIC_IPC_F7188X
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called simatic-ipc-leds-gpio-f7188x.
> +
> +config LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE
> +	tristate "LED driver for Siemens Simatic IPCs based on Intel Elkhart Lake GPIO"
> +	depends on LEDS_GPIO
> +	depends on PINCTRL_ELKHARTLAKE
> +	depends on SIEMENS_SIMATIC_IPC
> +	default LEDS_SIEMENS_SIMATIC_IPC
> +	help
> +	  This option enables support for the LEDs of several Industrial PCs
> +	  from Siemens based on Elkhart Lake GPIO i.e. BX-21A.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called simatic-ipc-leds-gpio-elkhartlake.
> diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
> index e3e840cea275..783578f11bb0 100644
> --- a/drivers/leds/simple/Makefile
> +++ b/drivers/leds/simple/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+= simatic-ipc-leds.o
>  obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
>  obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE)	+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-elkhartlake.o
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> index 2a21b663df87..c552ea73ed9d 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> @@ -57,6 +57,7 @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
>  	switch (plat->devmode) {
>  	case SIMATIC_IPC_DEVICE_127E:
>  	case SIMATIC_IPC_DEVICE_227G:
> +	case SIMATIC_IPC_DEVICE_BX_21A:
>  		break;
>  	default:
>  		return -ENODEV;
> @@ -72,6 +73,9 @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
>  		goto out;
>  	}
>  
> +	if (!table_extra)
> +		return 0;
> +
>  	table_extra->dev_id = dev_name(dev);
>  	gpiod_add_lookup_table(table_extra);
>  
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c b/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
> new file mode 100644
> index 000000000000..6ba21dbb3ba0
> --- /dev/null
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Siemens SIMATIC IPC driver for GPIO based LEDs
> + *
> + * Copyright (c) Siemens AG, 2023
> + *
> + * Author:
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/x86/simatic-ipc-base.h>
> +
> +#include "simatic-ipc-leds-gpio.h"
> +
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> +	.dev_id = "leds-gpio",
> +	.table = {
> +		GPIO_LOOKUP_IDX("INTC1020:04", 72, NULL, 0, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("INTC1020:04", 77, NULL, 1, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("INTC1020:04", 78, NULL, 2, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("INTC1020:04", 58, NULL, 3, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("INTC1020:04", 60, NULL, 4, GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP_IDX("INTC1020:04", 62, NULL, 5, GPIO_ACTIVE_HIGH),
> +		{} /* Terminating entry */
> +	},
> +};
> +
> +static int simatic_ipc_leds_gpio_elkhartlake_probe(struct platform_device *pdev)
> +{
> +	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
> +					   NULL);
> +}
> +
> +static int simatic_ipc_leds_gpio_elkhartlake_remove(struct platform_device *pdev)
> +{
> +	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
> +					    NULL);
> +}
> +
> +static struct platform_driver simatic_ipc_led_gpio_elkhartlake_driver = {
> +	.probe = simatic_ipc_leds_gpio_elkhartlake_probe,
> +	.remove = simatic_ipc_leds_gpio_elkhartlake_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +};
> +module_platform_driver(simatic_ipc_led_gpio_elkhartlake_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> +MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core platform:elkhartlake-pinctrl");
> +MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
> diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
> index c773995b230d..4402cd354104 100644
> --- a/drivers/platform/x86/simatic-ipc.c
> +++ b/drivers/platform/x86/simatic-ipc.c
> @@ -48,6 +48,7 @@ static struct {
>  	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E},
>  	{SIMATIC_IPC_IPCBX_39A, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
>  	{SIMATIC_IPC_IPCPX_39A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G},
> +	{SIMATIC_IPC_IPCBX_21A, SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE},
>  };
>  
>  static int register_platform_devices(u32 station_id)
> @@ -72,6 +73,8 @@ static int register_platform_devices(u32 station_id)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
>  		if (ledmode == SIMATIC_IPC_DEVICE_227G)
>  			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
> +		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
> +			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";
>  		platform_data.devmode = ledmode;
>  		ipc_led_platform_device =
>  			platform_device_register_data(NULL,
> diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
> index 57d6a10dfc9e..00bf18ecb160 100644
> --- a/include/linux/platform_data/x86/simatic-ipc-base.h
> +++ b/include/linux/platform_data/x86/simatic-ipc-base.h
> @@ -20,6 +20,7 @@
>  #define SIMATIC_IPC_DEVICE_127E 3
>  #define SIMATIC_IPC_DEVICE_227E 4
>  #define SIMATIC_IPC_DEVICE_227G 5
> +#define SIMATIC_IPC_DEVICE_BX_21A 6
>  
>  struct simatic_ipc_platform {
>  	u8	devmode;
> diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
> index a48bb5240977..1a8e4c1099e3 100644
> --- a/include/linux/platform_data/x86/simatic-ipc.h
> +++ b/include/linux/platform_data/x86/simatic-ipc.h
> @@ -2,7 +2,7 @@
>  /*
>   * Siemens SIMATIC IPC drivers
>   *
> - * Copyright (c) Siemens AG, 2018-2021
> + * Copyright (c) Siemens AG, 2018-2023
>   *
>   * Authors:
>   *  Henning Schild <henning.schild@siemens.com>
> @@ -34,6 +34,7 @@ enum simatic_ipc_station_ids {
>  	SIMATIC_IPC_IPC227G = 0x00000F01,
>  	SIMATIC_IPC_IPCBX_39A = 0x00001001,
>  	SIMATIC_IPC_IPCPX_39A = 0x00001002,
> +	SIMATIC_IPC_IPCBX_21A = 0x00001101,
>  };
>  
>  static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)

