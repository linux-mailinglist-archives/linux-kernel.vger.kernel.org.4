Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E645E6BD2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjCPPFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjCPPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:05:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7C3B9531;
        Thu, 16 Mar 2023 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678979117; x=1710515117;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/lKBXE6NMg4dM03Mb8QnXmlt4juzkr2o8eLsDDIEdAw=;
  b=CWNVCgxcsYHEYWzrf7bR144mIl7JDQnshGm86/AeAY+b0Icb36vOu8m7
   2QkjkMABYSRtutvWWUS3ElTAyUotU2aoMjQK8G/QATqGb8IZQmzHAIe9q
   dSXYEHKN632Pksf9iLnjWsD7EE7NyHsOK2xUqW9uXnTx8dSGsEMVjxOIU
   wpZ9EAYoN5Ubwd42WcIeiJKVEV1nE1U6Pcqb7+kzU38CqQXMahl0ASG8o
   qGqu/nHGIPYr0poFX85fXCn3xjtrpcHSO3S3mDC2lUr4wUKgGK6FJk0Ns
   3uAZlwR8qTRNbTnZkeLp6CB+Tjso5xQVsjknh7OjVDZL5dLGhbB3Mm6K9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="336707384"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="336707384"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="768988962"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="768988962"
Received: from trybicki-mobl1.ger.corp.intel.com ([10.252.63.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:05:12 -0700
Date:   Thu, 16 Mar 2023 17:05:10 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 13/15] reset: Add Nuvoton ma35d1 reset driver support
In-Reply-To: <20230315072902.9298-14-ychuang570808@gmail.com>
Message-ID: <1c943355-e9c0-3b23-4437-4040fa18b9fa@linux.intel.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com> <20230315072902.9298-14-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This driver supports individual IP reset for ma35d1. The reset
> control registers is a subset of system control registers.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/reset/Kconfig        |   6 ++
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-ma35d1.c | 152 +++++++++++++++++++++++++++++++++++
>  3 files changed, 159 insertions(+)
>  create mode 100644 drivers/reset/reset-ma35d1.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2a52c990d4fe..47671060d259 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -143,6 +143,12 @@ config RESET_NPCM
>  	  This enables the reset controller driver for Nuvoton NPCM
>  	  BMC SoCs.
>  
> +config RESET_NUVOTON_MA35D1
> +	bool "Nuvton MA35D1 Reset Driver"
> +	default ARCH_NUVOTON
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
> index 000000000000..bdd39483ca4e
> --- /dev/null
> +++ b/drivers/reset/reset-ma35d1.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/mfd/ma35d1-sys.h>
> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +#include <linux/regmap.h>
> +#include <linux/reboot.h>
> +
> +#define RST_PRE_REG	32
> +
> +struct ma35d1_reset_data {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *regmap;
> +};
> +
> +struct ma35d1_reboot_data {
> +	struct notifier_block restart_handler;
> +	struct regmap *regmap;
> +};
> +
> +static int ma35d1_restart_handler(struct notifier_block *this,
> +				  unsigned long mode, void *cmd)
> +{
> +	struct ma35d1_reboot_data *data =
> +			container_of(this, struct ma35d1_reboot_data,
> +				     restart_handler);
> +	regmap_write(data->regmap, REG_SYS_IPRST0, 1 << MA35D1_RESET_CHIP);
> +	return -EAGAIN;

This results -EAGAIN always???

> +}
> +
> +static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
> +			      unsigned long id, bool assert)
> +{
> +	int reg;
> +	int offset = (id / RST_PRE_REG) * 4;
> +	struct ma35d1_reset_data *data =
> +			container_of(rcdev, struct ma35d1_reset_data, rcdev);
> +
> +	regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
> +	if (assert)
> +		reg |= 1 << (id % RST_PRE_REG);
> +	else
> +		reg &= ~(1 << (id % RST_PRE_REG));
> +
> +	regmap_write(data->regmap, REG_SYS_IPRST0 + offset, reg);
> +	return 0;

This returns always 0. What about regmap_read/write() errors, should the 
be returned?

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
> +			      unsigned long id)
> +{
> +	int reg;
> +	int offset = id / RST_PRE_REG;
> +	struct ma35d1_reset_data *data =
> +			container_of(rcdev, struct ma35d1_reset_data, rcdev);
> +
> +	regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);

Error handling?

> +	return !!(reg & BIT(id % RST_PRE_REG));
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
> +	struct device *dev = &pdev->dev;
> +	struct ma35d1_reset_data *reset_data;
> +	struct ma35d1_reboot_data *reboot_data;
> +	int err;
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
> +	reboot_data = devm_kzalloc(dev, sizeof(*reboot_data), GFP_KERNEL);
> +	if (!reboot_data) {
> +		devm_kfree(dev, reset_data);

Unnecessary.

> +		return -ENOMEM;
> +	}
> +
> +	reset_data->regmap  = syscon_regmap_lookup_by_phandle(
> +			      pdev->dev.of_node, "regmap");
> +	if (IS_ERR(reset_data->regmap)) {
> +		dev_err(&pdev->dev, "Failed to get SYS register base\n");
> +		err = PTR_ERR(reset_data->regmap);
> +		goto err_out;
> +	}
> +	reset_data->rcdev.owner = THIS_MODULE;
> +	reset_data->rcdev.nr_resets = MA35D1_RESET_COUNT;
> +	reset_data->rcdev.ops = &ma35d1_reset_ops;
> +	reset_data->rcdev.of_node = dev->of_node;
> +
> +	reboot_data->regmap = reset_data->regmap;
> +	reboot_data->restart_handler.notifier_call = ma35d1_restart_handler;
> +	reboot_data->restart_handler.priority = 192;
> +
> +	err = register_restart_handler(&reboot_data->restart_handler);
> +	if (err)
> +		dev_warn(&pdev->dev, "failed to register restart handler\n");
> +
> +	return devm_reset_controller_register(dev, &reset_data->rcdev);
> +
> +err_out:
> +	devm_kfree(dev, reset_data);
> +	devm_kfree(dev, reboot_data);

These are unnecessary since the probe is failing.

> +	return err;
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

