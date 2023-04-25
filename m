Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77746EE0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjDYK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjDYK5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:57:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00E40EC;
        Tue, 25 Apr 2023 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682420233; x=1713956233;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CTvshU3JWVoVJwwI7FYpM3f/eI/ZQ/U++dCfjJ+PJk8=;
  b=kUKWA0Wq8gYOodYLMaN7DFrcLWoIWKzCpQgKG8VHlNLVARxHq7HaHRD3
   ESjBMp1b4qQyDRgcii89Os79iIY+KqOrAcf/6XNCAY52l1V2iA4Nmh1s6
   eQyUnuZDnHOesLToVMw6VCQNh+DIL6enGXskmt75Pf7KEQxZZNfLaPbYG
   w50PtINnWOz7jpe4WJXobwD3eZV4MmXOqpaUZV40S3qZk7pOTjpUX14LI
   31XJJoL+lhtUb1VXowYWVX6q//YnKuG/idWQFipDzPThURnNf+QZkvku2
   3kH5+5G2KsWQvFVN3b8mJttDyNrBIJr8fbNYmAl/W6UVPeurK6YA0UWOR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="327034309"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="327034309"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 03:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="939729574"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="939729574"
Received: from rolfneux-mobl.ger.corp.intel.com ([10.252.34.113])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 03:57:07 -0700
Date:   Tue, 25 Apr 2023 13:57:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v8 09/11] reset: Add Nuvoton ma35d1 reset driver
 support
In-Reply-To: <20230425102418.185783-10-ychuang570808@gmail.com>
Message-ID: <17afcef9-39ff-ef25-6c24-38726b30cf90@linux.intel.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com> <20230425102418.185783-10-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This driver supports individual IP reset for ma35d1. The reset
> control registers is a subset of system control registers.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/reset/Kconfig        |   6 +
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-ma35d1.c | 229 +++++++++++++++++++++++++++++++++++
>  3 files changed, 236 insertions(+)
>  create mode 100644 drivers/reset/reset-ma35d1.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2a52c990d4fe..58477c6ca9b8 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -143,6 +143,12 @@ config RESET_NPCM
>  	  This enables the reset controller driver for Nuvoton NPCM
>  	  BMC SoCs.
>  
> +config RESET_NUVOTON_MA35D1
> +	bool "Nuvton MA35D1 Reset Driver"
> +	default ARCH_NUVOTON || COMPILE_TEST
> +	help
> +	  This enables the reset controller driver for Nuvoton MA35D1 SoC.
> +
>  config RESET_OXNAS
>  	bool
>  
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 3e7e5fd633a8..fd52dcf66a99 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>  obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
> +obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>  obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>  obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o
> diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
> new file mode 100644
> index 000000000000..648b380becf7
> --- /dev/null
> +++ b/drivers/reset/reset-ma35d1.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/reset-controller.h>
> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +struct ma35d1_reset_data {
> +	struct reset_controller_dev rcdev;
> +	struct notifier_block restart_handler;
> +	void __iomem *base;
> +};
> +
> +static const struct {
> +	u32 reg_ofs;
> +	u32 bit;
> +} ma35d1_reset_map[] = {
> +	[MA35D1_RESET_CHIP] =    {0x20, 0},
> +	[MA35D1_RESET_CA35CR0] = {0x20, 1},
> +	[MA35D1_RESET_CA35CR1] = {0x20, 2},
> +	[MA35D1_RESET_CM4] =     {0x20, 3},
> +	[MA35D1_RESET_PDMA0] =   {0x20, 4},
> +	[MA35D1_RESET_PDMA1] =   {0x20, 5},
> +	[MA35D1_RESET_PDMA2] =   {0x20, 6},
> +	[MA35D1_RESET_PDMA3] =   {0x20, 7},
> +	[MA35D1_RESET_DISP] =    {0x20, 9},
> +	[MA35D1_RESET_VCAP0] =   {0x20, 10},
> +	[MA35D1_RESET_VCAP1] =   {0x20, 11},
> +	[MA35D1_RESET_GFX] =     {0x20, 12},
> +	[MA35D1_RESET_VDEC] =    {0x20, 13},
> +	[MA35D1_RESET_WHC0] =    {0x20, 14},
> +	[MA35D1_RESET_WHC1] =    {0x20, 15},
> +	[MA35D1_RESET_GMAC0] =   {0x20, 16},
> +	[MA35D1_RESET_GMAC1] =   {0x20, 17},
> +	[MA35D1_RESET_HWSEM] =   {0x20, 18},
> +	[MA35D1_RESET_EBI] =     {0x20, 19},
> +	[MA35D1_RESET_HSUSBH0] = {0x20, 20},
> +	[MA35D1_RESET_HSUSBH1] = {0x20, 21},
> +	[MA35D1_RESET_HSUSBD] =  {0x20, 22},
> +	[MA35D1_RESET_USBHL] =   {0x20, 23},
> +	[MA35D1_RESET_SDH0] =    {0x20, 24},
> +	[MA35D1_RESET_SDH1] =    {0x20, 25},
> +	[MA35D1_RESET_NAND] =    {0x20, 26},
> +	[MA35D1_RESET_GPIO] =    {0x20, 27},
> +	[MA35D1_RESET_MCTLP] =   {0x20, 28},
> +	[MA35D1_RESET_MCTLC] =   {0x20, 29},
> +	[MA35D1_RESET_DDRPUB] =  {0x20, 30},
> +	[MA35D1_RESET_TMR0] =    {0x24, 2},
> +	[MA35D1_RESET_TMR1] =    {0x24, 3},
> +	[MA35D1_RESET_TMR2] =    {0x24, 4},
> +	[MA35D1_RESET_TMR3] =    {0x24, 5},
> +	[MA35D1_RESET_I2C0] =    {0x24, 8},
> +	[MA35D1_RESET_I2C1] =    {0x24, 9},
> +	[MA35D1_RESET_I2C2] =    {0x24, 10},
> +	[MA35D1_RESET_I2C3] =    {0x24, 11},
> +	[MA35D1_RESET_QSPI0] =   {0x24, 12},
> +	[MA35D1_RESET_SPI0] =    {0x24, 13},
> +	[MA35D1_RESET_SPI1] =    {0x24, 14},
> +	[MA35D1_RESET_SPI2] =    {0x24, 15},
> +	[MA35D1_RESET_UART0] =   {0x24, 16},
> +	[MA35D1_RESET_UART1] =   {0x24, 17},
> +	[MA35D1_RESET_UART2] =   {0x24, 18},
> +	[MA35D1_RESET_UART3] =   {0x24, 19},
> +	[MA35D1_RESET_UART4] =   {0x24, 20},
> +	[MA35D1_RESET_UART5] =   {0x24, 21},
> +	[MA35D1_RESET_UART6] =   {0x24, 22},
> +	[MA35D1_RESET_UART7] =   {0x24, 23},
> +	[MA35D1_RESET_CANFD0] =  {0x24, 24},
> +	[MA35D1_RESET_CANFD1] =  {0x24, 25},
> +	[MA35D1_RESET_EADC0] =   {0x24, 28},
> +	[MA35D1_RESET_I2S0] =    {0x24, 29},
> +	[MA35D1_RESET_SC0] =     {0x28, 0},
> +	[MA35D1_RESET_SC1] =     {0x28, 1},
> +	[MA35D1_RESET_QSPI1] =   {0x28, 4},
> +	[MA35D1_RESET_SPI3] =    {0x28, 6},
> +	[MA35D1_RESET_EPWM0] =   {0x28, 16},
> +	[MA35D1_RESET_EPWM1] =   {0x28, 17},
> +	[MA35D1_RESET_QEI0] =    {0x28, 22},
> +	[MA35D1_RESET_QEI1] =    {0x28, 23},
> +	[MA35D1_RESET_ECAP0] =   {0x28, 26},
> +	[MA35D1_RESET_ECAP1] =   {0x28, 27},
> +	[MA35D1_RESET_CANFD2] =  {0x28, 28},
> +	[MA35D1_RESET_ADC0] =    {0x28, 31},
> +	[MA35D1_RESET_TMR4] =    {0x2C, 0},
> +	[MA35D1_RESET_TMR5] =    {0x2C, 1},
> +	[MA35D1_RESET_TMR6] =    {0x2C, 2},
> +	[MA35D1_RESET_TMR7] =    {0x2C, 3},
> +	[MA35D1_RESET_TMR8] =    {0x2C, 4},
> +	[MA35D1_RESET_TMR9] =    {0x2C, 5},
> +	[MA35D1_RESET_TMR10] =   {0x2C, 6},
> +	[MA35D1_RESET_TMR11] =   {0x2C, 7},
> +	[MA35D1_RESET_UART8] =   {0x2C, 8},
> +	[MA35D1_RESET_UART9] =   {0x2C, 9},
> +	[MA35D1_RESET_UART10] =  {0x2C, 10},
> +	[MA35D1_RESET_UART11] =  {0x2C, 11},
> +	[MA35D1_RESET_UART12] =  {0x2C, 12},
> +	[MA35D1_RESET_UART13] =  {0x2C, 13},
> +	[MA35D1_RESET_UART14] =  {0x2C, 14},
> +	[MA35D1_RESET_UART15] =  {0x2C, 15},
> +	[MA35D1_RESET_UART16] =  {0x2C, 16},
> +	[MA35D1_RESET_I2S1] =    {0x2C, 17},
> +	[MA35D1_RESET_I2C4] =    {0x2C, 18},
> +	[MA35D1_RESET_I2C5] =    {0x2C, 19},
> +	[MA35D1_RESET_EPWM2] =   {0x2C, 20},
> +	[MA35D1_RESET_ECAP2] =   {0x2C, 21},
> +	[MA35D1_RESET_QEI2] =    {0x2C, 22},
> +	[MA35D1_RESET_CANFD3] =  {0x2C, 23},
> +	[MA35D1_RESET_KPI] =     {0x2C, 24},
> +	[MA35D1_RESET_GIC] =     {0x2C, 28},
> +	[MA35D1_RESET_SSMCC] =   {0x2C, 30},
> +	[MA35D1_RESET_SSPCC] =   {0x2C, 31}
> +};
> +
> +static int ma35d1_restart_handler(struct notifier_block *this,
> +				  unsigned long mode, void *cmd)
> +{
> +	u32 id = MA35D1_RESET_CHIP;
> +	struct ma35d1_reset_data *data = container_of(this,
> +						      struct ma35d1_reset_data,
> +						      restart_handler);

Reverse xmas tree order.

Try to fit declarations with container_of() to single line, if they fit <= 
100 chars, avoid the line splits.

Missing #include for container_of().

> +
> +	writel_relaxed(BIT(ma35d1_reset_map[id].bit),

Missing #include for BIT().

> +		       data->base + ma35d1_reset_map[id].reg_ofs);
> +	return 0;
> +}
> +
> +static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
> +			       unsigned long id, bool assert)
> +{
> +	u32 reg;
> +	struct ma35d1_reset_data *data = container_of(rcdev,
> +						      struct ma35d1_reset_data,
> +						      rcdev);

Reverse xmas tree.

Add an array size trap to detect potential id bugs:
	if (WARN_ON_ONCE(id >= ARRAY_SIZE(ma35d1_reset_map)))
		return -EINVAL;

> +	reg = readl_relaxed(data->base + ma35d1_reset_map[id].reg_ofs);
> +	if (assert)
> +		reg |= BIT(ma35d1_reset_map[id].bit);
> +	else
> +		reg &= ~(BIT(ma35d1_reset_map[id].bit));
> +	writel_relaxed(reg, data->base + ma35d1_reset_map[id].reg_ofs);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_reset_assert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	return ma35d1_reset_update(rcdev, id, true);
> +}
> +
> +static int ma35d1_reset_deassert(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
> +{
> +	return ma35d1_reset_update(rcdev, id, false);
> +}
> +
> +static int ma35d1_reset_status(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	u32 reg;
> +	struct ma35d1_reset_data *data = container_of(rcdev,
> +						      struct ma35d1_reset_data,
> +						      rcdev);

Reverse xmas tree.

Add ARRAY_SIZE trap here too.

> +	reg = readl_relaxed(data->base + ma35d1_reset_map[id].reg_ofs);
> +	return !!(reg & BIT(ma35d1_reset_map[id].bit));
> +}
> +
> +static const struct reset_control_ops ma35d1_reset_ops = {
> +	.assert = ma35d1_reset_assert,
> +	.deassert = ma35d1_reset_deassert,
> +	.status = ma35d1_reset_status,
> +};
> +
> +static const struct of_device_id ma35d1_reset_dt_ids[] = {
> +	{ .compatible = "nuvoton,ma35d1-reset" },
> +	{ },
> +};
> +
> +static int ma35d1_reset_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct ma35d1_reset_data *reset_data;

Reverse xmas tree order.

> +
> +	if (!pdev->dev.of_node) {
> +		dev_err(&pdev->dev, "Device tree node not found\n");
> +		return -EINVAL;
> +	}
> +
> +	reset_data = devm_kzalloc(dev, sizeof(*reset_data), GFP_KERNEL);
> +	if (!reset_data)
> +		return -ENOMEM;
> +
> +	reset_data->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reset_data->base))

Missing include for IS_ERR()

> +		return PTR_ERR(reset_data->base);
> +
> +	reset_data->rcdev.owner = THIS_MODULE;
> +	reset_data->rcdev.nr_resets = MA35D1_RESET_COUNT;
> +	reset_data->rcdev.ops = &ma35d1_reset_ops;
> +	reset_data->rcdev.of_node = dev->of_node;
> +	reset_data->restart_handler.notifier_call = ma35d1_restart_handler;
> +	reset_data->restart_handler.priority = 192;
> +
> +	err = register_restart_handler(&reset_data->restart_handler);
> +	if (err)
> +		dev_warn(&pdev->dev, "failed to register restart handler\n");
> +
> +	return devm_reset_controller_register(dev, &reset_data->rcdev);
> +}
> +
> +static struct platform_driver ma35d1_reset_driver = {
> +	.probe = ma35d1_reset_probe,
> +	.driver = {
> +		.name = "ma35d1-reset",
> +		.of_match_table	= ma35d1_reset_dt_ids,
> +	},
> +};
> +
> +builtin_platform_driver(ma35d1_reset_driver);
> 

-- 
 i.

