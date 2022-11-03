Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3D617C67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKCMTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKCMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:19:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A13278;
        Thu,  3 Nov 2022 05:19:44 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N32mv4S8nzJnL4;
        Thu,  3 Nov 2022 20:16:47 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 20:19:42 +0800
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <yangyicong@hisilicon.com>, <robh+dt@kernel.org>,
        <xuwei5@huawei.com>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH next v3 1/2] gpio: hisi: Add initial device tree support
To:     Weilong Chen <chenweilong@huawei.com>, <f.fangjian@huawei.com>
References: <20221101082442.263448-1-chenweilong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <bb081979-10d6-5d6e-8e87-9a317fb09455@huawei.com>
Date:   Thu, 3 Nov 2022 20:19:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20221101082442.263448-1-chenweilong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/1 16:24, Weilong Chen wrote:
> Add support for HiSilicon GPIO controller in embedded platform, which
> boot from devicetree.
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
> Change since v2:
> - Drop wrong use ACPI_PTR/of_match_ptr
> Link: https://lore.kernel.org/lkml/20221028022453.163186-1-chenweilong@huawei.com/
> 
>  drivers/gpio/Kconfig     | 2 +-
>  drivers/gpio/gpio-hisi.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
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
> index 3caabef5c7a2..55bd69043bf4 100644
> --- a/drivers/gpio/gpio-hisi.c
> +++ b/drivers/gpio/gpio-hisi.c
> @@ -221,6 +221,12 @@ static const struct acpi_device_id hisi_gpio_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, hisi_gpio_acpi_match);
>  
> +static const struct of_device_id hisi_gpio_dts_match[] = {
> +	{ .compatible = "hisilicon,ascend910-gpio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hisi_gpio_dts_match);
> +
>  static void hisi_gpio_get_pdata(struct device *dev,
>  				struct hisi_gpio *hisi_gpio)
>  {
> @@ -311,6 +317,7 @@ static struct platform_driver hisi_gpio_driver = {
>  	.driver		= {
>  		.name	= HISI_GPIO_DRIVER_NAME,
>  		.acpi_match_table = hisi_gpio_acpi_match,
> +		.of_match_table = hisi_gpio_dts_match,
>  	},
>  	.probe		= hisi_gpio_probe,
>  };
> 
