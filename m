Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109F7613A53
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiJaPk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiJaPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25A65A5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A319612F1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEE8C433C1;
        Mon, 31 Oct 2022 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230806;
        bh=20CiDKyUsGR6BS3eLU7VUNZhLLx9cdC239GNR/hWuj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuwo0S3eIZwXtbNV7Q+HSezRfkaUguuCIWLWWWjRsrbladPXKDTRtHZJnZni0COkt
         UUZ0jtigxeWXs29tGfC0VQHZ1vA1kWZQH3gr+nC3qsDjwsaVGQSmwxEf1kZIq0tVHZ
         hkhrAVcXz+0PP0AVu60kvrWaTfr4O7duE/Yq526gko679kIua2kt1AwmoR0yqM9CoW
         T+pmZ2hel6qqqgWeKQ5TpwXCNfFgLzgTf/hIvln9IkIG9ddx7jhyfJP+8sQOYj64O0
         qAsAFh6OxOFjFlo3OeXoSzvt3yVdqp5JlyNE4fY+TVni1vyfzWWNk7Fi5meSaoJaQd
         ruSPX/rMtensw==
Date:   Mon, 31 Oct 2022 15:40:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
Message-ID: <Y1/sUfeVy1a6EKZQ@google.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221017075702.4182846-1-victor.liu@nxp.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022, Liu Ying wrote:

> Freescale i.MX8qxp Control and Status Registers (CSR) module is a system
> controller. It represents a set of miscellaneous registers of a specific
> subsystem. It may provide control and/or status report interfaces to a
> mix of standalone hardware devices within that subsystem.
> 
> The CSR module in i.MX8qm/qxp SoCs is a child node of a simple power-managed
> bus(i.MX8qxp pixel link MSI bus). To propagate power management operations
> of the CSR module's child devices to that simple power-managed bus, add a
> dedicated driver for the CSR module. Also, the driver would populate the CSR
> module's child devices.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> The Freescale i.MX8qxp CSR DT bindings is at
> Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> 
> Resend the patch based on v6.1-rc1.
> 
>  drivers/mfd/Kconfig           | 10 +++++++
>  drivers/mfd/Makefile          |  1 +
>  drivers/mfd/fsl-imx8qxp-csr.c | 53 +++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b93856de432..966a250d7910 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -499,6 +499,16 @@ config MFD_MX25_TSADC
>  	  i.MX25 processors. They consist of a conversion queue for general
>  	  purpose ADC and a queue for Touchscreens.
>  
> +config MFD_MX8QXP_CSR
> +	tristate "Freescale i.MX8qxp Control and Status Registers (CSR) Module"
> +	depends on (ARCH_MXC && OF) || COMPILE_TEST
> +	help
> +	  Enable support for Freescale i.MX8qm/qxp Control and Status Registers
> +	  (CSR) Module. As a system controller, CSR represents a set of
> +	  miscellaneous registers of a specific subsystem. It may provide
> +	  control and/or status report interfaces to a mix of standalone
> +	  hardware devices within that subsystem.
> +
>  config MFD_HI6421_PMIC
>  	tristate "HiSilicon Hi6421 PMU/Codec IC"
>  	depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7ed3ef4a698c..5c3c13d7ce85 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
>  obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
>  
>  obj-$(CONFIG_MFD_MX25_TSADC)	+= fsl-imx25-tsadc.o
> +obj-$(CONFIG_MFD_MX8QXP_CSR)	+= fsl-imx8qxp-csr.o
>  
>  obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
> diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-imx8qxp-csr.c
> new file mode 100644
> index 000000000000..3915d3d6ca65
> --- /dev/null
> +++ b/drivers/mfd/fsl-imx8qxp-csr.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Copyright 2022 NXP
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +static int imx8qxp_csr_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = devm_of_platform_populate(&pdev->dev);

The use of this API does not constitute a MFD.

Please use "simple-mfd" instead.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to populate sub-devices: %d\n", ret);
> +		pm_runtime_disable(&pdev->dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx8qxp_csr_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id imx8qxp_csr_of_match[] = {
> +	{ .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
> +	{ .compatible = "fsl,imx8qm-lvds-csr", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx8qxp_csr_of_match);
> +
> +static struct platform_driver imx8qxp_csr_driver = {
> +	.probe = imx8qxp_csr_probe,
> +	.remove = imx8qxp_csr_remove,
> +	.driver = {
> +		.name = "imx8qxp-csr",
> +		.of_match_table = imx8qxp_csr_of_match,
> +	},
> +};
> +
> +module_platform_driver(imx8qxp_csr_driver);
> +
> +MODULE_DESCRIPTION("Freescale i.MX8qm/qxp Control and Status Registers Module Driver");
> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
