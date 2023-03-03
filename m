Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B86AA430
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjCCWWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjCCWWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:22:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686870001;
        Fri,  3 Mar 2023 14:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 737A1CE2299;
        Fri,  3 Mar 2023 21:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA36FC433D2;
        Fri,  3 Mar 2023 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677880783;
        bh=GVhti8Xta9fHGh7MefCvYQ/HItovqz3t4Kc9UJ99gUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3EHce1T6w+JBsGY5In+cbWTPqnaL2tNp8hWvP9wSoh9j/Mk6QhxMiCDgOPFE/OwC
         lRZaPfEYV+ngAmRQ/6VavSYF8nzIuXYEDXKuPZlGFKJ7geQ3CbP5lPMS9BfZHTEkGf
         LWZ3gM+KMdR6/M615p20rC/I7dk+IDAWZzeiOGcy0U3dPPkzCumiYDh9fFMJfLI1KA
         +fAsIT8ZeWg23GtISDvQ5UM0i885juC/TdrnNB9ZeF1WqwB7oKcV9aoDymseMsdvIy
         u6P18o1kHBCWANIVFdN8zBtTLOKe5kc8ntp669ydHLuDFCwgkxAcBeftIAqwX95VUE
         W3mp36WgqqAyw==
Date:   Fri, 3 Mar 2023 21:59:36 +0000
From:   Lee Jones <lee@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net, hdegoede@redhat.com, eric.auger@redhat.com,
        jgg@ziepe.ca, razor@blackwall.org, suma.hegde@amd.com,
        stephen@networkplumber.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: Re: [PATCH v1 3/4] mfd: tps6594-esm: Add driver for TI TPS6594 ESM
Message-ID: <20230303215936.GS2420672@google.com>
References: <20230216114410.183489-1-jpanis@baylibre.com>
 <20230216114410.183489-4-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216114410.183489-4-jpanis@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Julien Panis wrote:

> This patch adds support for TPS6594 ESM (Error Signal Monitor).
> This device monitors the SoC error output signal at its nERR_SOC input pin.
> In error condition, ESM toggles its nRSTOUT_SOC pin to reset the SoC.

This is not an MFD driver.

Please move it somewhere more appropriate.
 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  drivers/mfd/Kconfig       |  10 +++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/tps6594-esm.c | 132 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 drivers/mfd/tps6594-esm.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3d2f5a10f54b..cbf7cfb70879 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1722,6 +1722,16 @@ config MFD_TPS6594_SPI
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps6594-spi.
>  
> +config MFD_TPS6594_ESM
> +	tristate "TI TPS6594 Error Signal Monitor support"
> +	depends on MFD_TPS6594
> +	help
> +	  Support ESM (Error Signal Monitor) on TPS6594 PMIC devices.
> +	  ESM is used typically to reboot the board in error condition.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tps6594-esm.
> +
>  config TWL4030_CORE
>  	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index d2cba7326b07..ae2d404cd6b8 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
>  obj-$(CONFIG_MFD_TPS6594)	+= tps6594-core.o
>  obj-$(CONFIG_MFD_TPS6594_I2C)	+= tps6594-i2c.o
>  obj-$(CONFIG_MFD_TPS6594_SPI)	+= tps6594-spi.o
> +obj-$(CONFIG_MFD_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_MENELAUS)		+= menelaus.o
>  
>  obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
> diff --git a/drivers/mfd/tps6594-esm.c b/drivers/mfd/tps6594-esm.c
> new file mode 100644
> index 000000000000..db242b50846f
> --- /dev/null
> +++ b/drivers/mfd/tps6594-esm.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ESM (Error Signal Monitor) driver for TI TPS6594/TPS6593/LP8764X PMICs
> + *
> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/tps6594.h>
> +
> +static irqreturn_t tps6594_esm_isr(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	int i;
> +
> +	for (i = 0 ; i < pdev->num_resources ; i++) {
> +		if (irq == platform_get_irq_byname(pdev, pdev->resource[i].name)) {
> +			dev_err(pdev->dev.parent, "%s error detected\n", pdev->resource[i].name);
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int tps6594_esm_probe(struct platform_device *pdev)
> +{
> +	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	int irq;
> +	int ret;
> +	int i;
> +
> +	for (i = 0 ; i < pdev->num_resources ; i++) {
> +		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
> +					     pdev->resource[i].name);
> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						tps6594_esm_isr, IRQF_ONESHOT,
> +						pdev->resource[i].name, pdev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request irq\n");
> +	}
> +
> +	ret = regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_MODE_CFG,
> +			      TPS6594_BIT_ESM_SOC_EN | TPS6594_BIT_ESM_SOC_ENDRV);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to configure ESM\n");
> +
> +	ret = regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
> +			      TPS6594_BIT_ESM_SOC_START);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to start ESM\n");
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	return 0;
> +}
> +
> +static int tps6594_esm_remove(struct platform_device *pdev)
> +{
> +	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
> +				TPS6594_BIT_ESM_SOC_START);
> +	if (ret) {
> +		dev_err(dev, "Failed to stop ESM\n");
> +		goto out;
> +	}
> +
> +	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_MODE_CFG,
> +				TPS6594_BIT_ESM_SOC_EN | TPS6594_BIT_ESM_SOC_ENDRV);
> +	if (ret)
> +		dev_err(dev, "Failed to unconfigure ESM\n");
> +
> +out:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static int tps6594_esm_suspend(struct device *dev)
> +{
> +	struct tps6594 *tps = dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
> +				TPS6594_BIT_ESM_SOC_START);
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return ret;
> +}
> +
> +static int tps6594_esm_resume(struct device *dev)
> +{
> +	struct tps6594 *tps = dev_get_drvdata(dev->parent);
> +
> +	pm_runtime_get_sync(dev);
> +
> +	return regmap_set_bits(tps->regmap, TPS6594_REG_ESM_SOC_START_REG,
> +			       TPS6594_BIT_ESM_SOC_START);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(tps6594_esm_pm_ops, tps6594_esm_suspend, tps6594_esm_resume);
> +
> +static struct platform_driver tps6594_esm_driver = {
> +	.driver	= {
> +		.name = "tps6594-esm",
> +		.pm = pm_sleep_ptr(&tps6594_esm_pm_ops),
> +	},
> +	.probe = tps6594_esm_probe,
> +	.remove = tps6594_esm_remove,
> +};
> +
> +module_platform_driver(tps6594_esm_driver);
> +
> +MODULE_ALIAS("platform:tps6594-esm");
> +MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
> +MODULE_DESCRIPTION("TPS6594 Error Signal Monitor Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.3
> 

-- 
Lee Jones [李琼斯]
