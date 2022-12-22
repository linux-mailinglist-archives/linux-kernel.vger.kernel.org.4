Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50D653E46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiLVK3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiLVK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:29:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B01F9E0;
        Thu, 22 Dec 2022 02:28:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87F56B81CF9;
        Thu, 22 Dec 2022 10:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC6C433D2;
        Thu, 22 Dec 2022 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671704936;
        bh=jYTXu0mr+Iq6KsQjoUZEPTS0lZzRoJQ5HbdtWQnEvNg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uMSR+36hRVEFMyTqZxJsZ/l5MIb9nLJOET4nlj/5d5nB6WKNS2Zrpeqv9PMiIvD04
         86mk2UNDKtXLANDCgEJ4k329aEkoC0DM6yWIFDOTTgVSeaFY8B+QODruD65AneFLiz
         Tbbh/muKl2qef7TVbkYIANwjITxBmz/nu+JscetuzodGJOjec5lmO+vWTPNTpvhIX7
         CK8pUYzURAWR+G28q4CnZY4AcV/7C83IXrktDaBhhbD3F5yinAq4K0+8fP+RpLSEdw
         sObXujqJv8rZyaPOpWwfhpzlIj8kzK3vW8tPk7x7S6aWXZ0OmgQTcRLJuVhHvOBwxO
         LcVUpJ9kR4RFg==
Message-ID: <ed8aa4d3-9570-eb72-a7d4-3b690adc3a6d@kernel.org>
Date:   Thu, 22 Dec 2022 11:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 5/7] bus: stm32_sys_bus: add support for STM32MP15 and
 STM32MP13 system bus
Content-Language: en-US
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-6-gatien.chevallier@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221221173055.11719-6-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 18:30, Gatien Chevallier wrote:
> This driver is checking the access rights of the different
> peripherals connected to the system bus. If access is denied,
> the associated device tree node is skipped so the platform bus
> does not probe it.
> 
> Signed-off-by: Loic PALLARDY <loic.pallardy@st.com>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  MAINTAINERS                 |   6 ++
>  drivers/bus/Kconfig         |   9 ++
>  drivers/bus/Makefile        |   1 +
>  drivers/bus/stm32_sys_bus.c | 180 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/bus/stm32_sys_bus.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 886d3f69ee64..768a8272233e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19522,6 +19522,12 @@ L:	linux-spi@vger.kernel.org
>  S:	Maintained
>  F:	drivers/spi/spi-stm32.c
>  
> +ST STM32 SYS BUS DRIVER
> +M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/bus/st,sys-bus.yaml
> +F:	drivers/bus/stm32_sys_bus.c
> +
>  ST STPDDC60 DRIVER
>  M:	Daniel Nilsson <daniel.nilsson@flex.com>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 7bfe998f3514..638bf5839cb0 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -163,6 +163,15 @@ config QCOM_SSC_BLOCK_BUS
>  	  i2c/spi/uart controllers, a hexagon core, and a clock controller
>  	  which provides clocks for the above.
>  
> +config STM32_SYS_BUS
> +	bool "STM32 System bus controller"
> +	depends on ARCH_STM32

|| COMPILE_TEST

> +	default MACH_STM32MP157 || MACH_STM32MP13
> +	help
> +	  Say y to enable device access right verification before device probing.
> +	  If access not granted, device won't be probed and an error message will
> +	  provide the reason.

(...)

> +
> +static int stm32_sys_bus_probe(struct platform_device *pdev)
> +{
> +	struct sys_bus_data *pdata;
> +	struct resource *res;
> +	void __iomem *mmio;
> +	struct stm32_sys_bus_match_data *mdata;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mmio = devm_ioremap_resource(&pdev->dev, res);

Use helper for these two.

> +	if (IS_ERR(mmio))
> +		return PTR_ERR(mmio);
> +
> +	pdata->sys_bus_base = mmio;
> +
> +	mdata = (struct stm32_sys_bus_match_data *)of_device_get_match_data(&pdev->dev);

Why do you need the cast?

> +	if (!mdata)

Can you explain the case when this can actually happen? If it can, you
have bug in ID table.

> +		return -EINVAL;
> +
> +	pdata->pconf = mdata;
> +	pdata->dev = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, pdata);
> +
> +	stm32_sys_bus_populate(pdata);
> +
> +	/* Populate all available nodes */
> +	return of_platform_populate(np, NULL, NULL, &pdev->dev);
> +}
> +
> +static const struct stm32_sys_bus_match_data stm32mp15_sys_bus_data = {
> +	.max_entries = STM32MP15_ETZPC_ENTRIES,
> +	.sys_bus_get_access = stm32_etzpc_get_access,
> +};
> +
> +static const struct stm32_sys_bus_match_data stm32mp13_sys_bus_data = {
> +	.max_entries = STM32MP13_ETZPC_ENTRIES,
> +	.sys_bus_get_access = stm32_etzpc_get_access,

It's the same as previous, drop.

> +};
> +
> +static const struct of_device_id stm32_sys_bus_of_match[] = {
> +	{ .compatible = "st,stm32mp15-sys-bus", .data = &stm32mp15_sys_bus_data },
> +	{ .compatible = "st,stm32mp13-sys-bus", .data = &stm32mp13_sys_bus_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, stm32_sys_bus_of_match);
> +
> +static struct platform_driver stm32_sys_bus_driver = {
> +	.probe  = stm32_sys_bus_probe,
> +	.driver = {
> +		.name = "stm32-sys-bus",
> +		.of_match_table = stm32_sys_bus_of_match,
> +	},
> +};
> +
> +static int __init stm32_sys_bus_init(void)
> +{
> +	return platform_driver_register(&stm32_sys_bus_driver);
> +}
> +arch_initcall(stm32_sys_bus_init);
> +

Best regards,
Krzysztof

