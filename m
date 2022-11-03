Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F486178B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKCIdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:33:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD8B7A;
        Thu,  3 Nov 2022 01:33:10 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N2xj547lVzRnwC;
        Thu,  3 Nov 2022 16:28:09 +0800 (CST)
Received: from [10.40.188.234] (10.40.188.234) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 16:33:08 +0800
Subject: Re: [PATCH next v3 1/2] gpio: hisi: Add initial device tree support
To:     Weilong Chen <chenweilong@huawei.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20221029113542.170210-1-chenweilong@huawei.com>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <a2e03ec4-219d-7587-48a6-d03c2fc1f1cb@huawei.com>
Date:   Thu, 3 Nov 2022 16:33:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221029113542.170210-1-chenweilong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/29 19:35, Weilong Chen wrote:
> Add support for HiSilicon GPIO controller in embedded platform, which
> boot from devicetree.
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---
> Change since v2:
> - No change
> Link: https://lore.kernel.org/lkml/20221028022453.163186-1-chenweilong@huawei.com/#r
> 
>  drivers/gpio/Kconfig     |  2 +-
>  drivers/gpio/gpio-hisi.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index e034f752e7ce..71a7880af59d 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -310,7 +310,7 @@ config GPIO_GRGPIO
>  
>  config GPIO_HISI
>  	tristate "HiSilicon GPIO controller driver"
> -	depends on (ARM64 && ACPI) || COMPILE_TEST
> +	depends on ARM64 || COMPILE_TEST
>  	select GPIO_GENERIC
>  	select GPIOLIB_IRQCHIP
>  	help
> diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
> index 3caabef5c7a2..92cf575f2eab 100644
> --- a/drivers/gpio/gpio-hisi.c
> +++ b/drivers/gpio/gpio-hisi.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2020 HiSilicon Limited. */
> +#include <linux/acpi.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  
> @@ -215,11 +217,21 @@ static void hisi_gpio_init_irq(struct hisi_gpio *hisi_gpio)
>  	hisi_gpio_write_reg(chip, HISI_GPIO_INTCOMB_MASK_WX, 1);
>  }
>  
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id hisi_gpio_acpi_match[] = {
>  	{"HISI0184", 0},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, hisi_gpio_acpi_match);
> +#endif
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id hisi_gpio_dts_match[] = {
> +	{ .compatible = "hisilicon,ascend910-gpio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hisi_gpio_dts_match);
> +#endif
>  
>  static void hisi_gpio_get_pdata(struct device *dev,
>  				struct hisi_gpio *hisi_gpio)
> @@ -310,7 +322,8 @@ static int hisi_gpio_probe(struct platform_device *pdev)
>  static struct platform_driver hisi_gpio_driver = {
>  	.driver		= {
>  		.name	= HISI_GPIO_DRIVER_NAME,
> -		.acpi_match_table = hisi_gpio_acpi_match,
> +		.acpi_match_table = ACPI_PTR(hisi_gpio_acpi_match),
> +		.of_match_table = of_match_ptr(hisi_gpio_dts_match),
>  	},
>  	.probe		= hisi_gpio_probe,
>  };
> 
Acked-by: Jay Fang <f.fangjian@huawei.com>
