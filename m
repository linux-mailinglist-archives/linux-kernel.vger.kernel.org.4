Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C26ED543
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjDXTWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjDXTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:21:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390F19A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:21:56 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pr1kq-0002nz-SE; Mon, 24 Apr 2023 21:21:40 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pr1kn-000254-GY; Mon, 24 Apr 2023 21:21:37 +0200
Date:   Mon, 24 Apr 2023 21:21:37 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v7 10/12] reset: Add Nuvoton ma35d1 reset driver support
Message-ID: <20230424192137.GB30248@pengutronix.de>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-11-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412053824.106-11-ychuang570808@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

On Wed, Apr 12, 2023 at 05:38:22AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This driver supports individual IP reset for ma35d1. The reset
> control registers is a subset of system control registers.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/reset/Kconfig        |   6 +
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-ma35d1.c | 255 +++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
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
> index 000000000000..57ed710c10f4
> --- /dev/null
> +++ b/drivers/reset/reset-ma35d1.c
> @@ -0,0 +1,255 @@
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
> +	void __iomem *base;
> +};
> +
> +struct ma35d1_reboot_data {
> +	struct notifier_block restart_handler;
> +	void __iomem *base;
> +};

These two structs can be combined into one, no need to duplicate the
iomem base.

> +
> +static const struct {
> +	unsigned long id;

Why store the id? ids should be contiguous and should start at 0,
so the id could just be an index into the array.

> +	u32 reg_ofs;
> +	u32 bit;
> +} ma35d1_reset_map[] = {
> +	{ MA35D1_RESET_CHIP,    0x20, 0  },
> +	{ MA35D1_RESET_CA35CR0,	0x20, 1  },
> +	{ MA35D1_RESET_CA35CR1, 0x20, 2  },
> +	{ MA35D1_RESET_CM4,     0x20, 3  },
> +	{ MA35D1_RESET_PDMA0,   0x20, 4  },
> +	{ MA35D1_RESET_PDMA1,   0x20, 5  },
> +	{ MA35D1_RESET_PDMA2,   0x20, 6  },
> +	{ MA35D1_RESET_PDMA3,   0x20, 7  },
> +	{ MA35D1_RESET_DISP,    0x20, 9  },
> +	{ MA35D1_RESET_VCAP0,   0x20, 10 },
> +	{ MA35D1_RESET_VCAP1,   0x20, 11 },
> +	{ MA35D1_RESET_GFX,     0x20, 12 },
> +	{ MA35D1_RESET_VDEC,    0x20, 13 },
> +	{ MA35D1_RESET_WHC0,    0x20, 14 },
> +	{ MA35D1_RESET_WHC1,    0x20, 15 },
> +	{ MA35D1_RESET_GMAC0,   0x20, 16 },
> +	{ MA35D1_RESET_GMAC1,   0x20, 17 },
> +	{ MA35D1_RESET_HWSEM,   0x20, 18 },
> +	{ MA35D1_RESET_EBI,     0x20, 19 },
> +	{ MA35D1_RESET_HSUSBH0, 0x20, 20 },
> +	{ MA35D1_RESET_HSUSBH1, 0x20, 21 },
> +	{ MA35D1_RESET_HSUSBD,  0x20, 22 },
> +	{ MA35D1_RESET_USBHL,   0x20, 23 },
> +	{ MA35D1_RESET_SDH0,    0x20, 24 },
> +	{ MA35D1_RESET_SDH1,    0x20, 25 },
> +	{ MA35D1_RESET_NAND,    0x20, 26 },
> +	{ MA35D1_RESET_GPIO,    0x20, 27 },
> +	{ MA35D1_RESET_MCTLP,   0x20, 28 },
> +	{ MA35D1_RESET_MCTLC,   0x20, 29 },
> +	{ MA35D1_RESET_DDRPUB,  0x20, 30 },
> +	{ MA35D1_RESET_TMR0,    0x24, 2  },
> +	{ MA35D1_RESET_TMR1,    0x24, 3  },
> +	{ MA35D1_RESET_TMR2,    0x24, 4  },
> +	{ MA35D1_RESET_TMR3,    0x24, 5  },
> +	{ MA35D1_RESET_I2C0,    0x24, 8  },
> +	{ MA35D1_RESET_I2C1,    0x24, 9  },
> +	{ MA35D1_RESET_I2C2,    0x24, 10 },
> +	{ MA35D1_RESET_I2C3,    0x24, 11 },
> +	{ MA35D1_RESET_QSPI0,   0x24, 12 },
> +	{ MA35D1_RESET_SPI0,    0x24, 13 },
> +	{ MA35D1_RESET_SPI1,    0x24, 14 },
> +	{ MA35D1_RESET_SPI2,    0x24, 15 },
> +	{ MA35D1_RESET_UART0,   0x24, 16 },
> +	{ MA35D1_RESET_UART1,   0x24, 17 },
> +	{ MA35D1_RESET_UART2,   0x24, 18 },
> +	{ MA35D1_RESET_UAER3,   0x24, 19 },
> +	{ MA35D1_RESET_UART4,   0x24, 20 },
> +	{ MA35D1_RESET_UART5,   0x24, 21 },
> +	{ MA35D1_RESET_UART6,   0x24, 22 },
> +	{ MA35D1_RESET_UART7,   0x24, 23 },
> +	{ MA35D1_RESET_CANFD0,  0x24, 24 },
> +	{ MA35D1_RESET_CANFD1,  0x24, 25 },
> +	{ MA35D1_RESET_EADC0,   0x24, 28 },
> +	{ MA35D1_RESET_I2S0,    0x24, 29 },
> +	{ MA35D1_RESET_SC0,     0x28, 0  },
> +	{ MA35D1_RESET_SC1,     0x28, 1  },
> +	{ MA35D1_RESET_QSPI1,   0x28, 4  },
> +	{ MA35D1_RESET_SPI3,    0x28, 6  },
> +	{ MA35D1_RESET_EPWM0,   0x28, 16 },
> +	{ MA35D1_RESET_EPWM1,   0x28, 17 },
> +	{ MA35D1_RESET_QEI0,    0x28, 22 },
> +	{ MA35D1_RESET_QEI1,    0x28, 23 },
> +	{ MA35D1_RESET_ECAP0,   0x28, 26 },
> +	{ MA35D1_RESET_ECAP1,   0x28, 27 },
> +	{ MA35D1_RESET_CANFD2,  0x28, 28 },
> +	{ MA35D1_RESET_ADC0,    0x28, 31 },
> +	{ MA35D1_RESET_TMR4,    0x2C, 0  },
> +	{ MA35D1_RESET_TMR5,    0x2C, 1  },
> +	{ MA35D1_RESET_TMR6,    0x2C, 2  },
> +	{ MA35D1_RESET_TMR7,    0x2C, 3  },
> +	{ MA35D1_RESET_TMR8,    0x2C, 4  },
> +	{ MA35D1_RESET_TMR9,    0x2C, 5  },
> +	{ MA35D1_RESET_TMR10,   0x2C, 6  },
> +	{ MA35D1_RESET_TMR11,   0x2C, 7  },
> +	{ MA35D1_RESET_UART8,   0x2C, 8  },
> +	{ MA35D1_RESET_UART9,   0x2C, 9  },
> +	{ MA35D1_RESET_UART10,  0x2C, 10 },
> +	{ MA35D1_RESET_UART11,  0x2C, 11 },
> +	{ MA35D1_RESET_UART12,  0x2C, 12 },
> +	{ MA35D1_RESET_UART13,  0x2C, 13 },
> +	{ MA35D1_RESET_UART14,  0x2C, 14 },
> +	{ MA35D1_RESET_UART15,  0x2C, 15 },
> +	{ MA35D1_RESET_UART16,  0x2C, 16 },
> +	{ MA35D1_RESET_I2S1,    0x2C, 17 },
> +	{ MA35D1_RESET_I2C4,    0x2C, 18 },
> +	{ MA35D1_RESET_I2C5,    0x2C, 19 },
> +	{ MA35D1_RESET_EPWM2,   0x2C, 20 },
> +	{ MA35D1_RESET_ECAP2,   0x2C, 21 },
> +	{ MA35D1_RESET_QEI2,    0x2C, 22 },
> +	{ MA35D1_RESET_CANFD3,  0x2C, 23 },
> +	{ MA35D1_RESET_KPI,     0x2C, 24 },
> +	{ MA35D1_RESET_GIC,     0x2C, 28 },
> +	{ MA35D1_RESET_SSMCC,   0x2C, 30 },
> +	{ MA35D1_RESET_SSPCC,   0x2C, 31 }
> +};
> +
> +static u32 ma35d1_reset_map_lookup(unsigned long id)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ma35d1_reset_map); i++) {
> +		if (ma35d1_reset_map[i].id == id)
> +			break;
> +	}
> +	return i;
> +}

If you use the id as a look up into the mapping array, this lookup
function wouldn't be necessary.

> +static int ma35d1_restart_handler(struct notifier_block *this,
> +				  unsigned long mode, void *cmd)
> +{
> +	u32 i;
> +	struct ma35d1_reboot_data *data = container_of(this,
> +						       struct ma35d1_reboot_data,
> +						       restart_handler);
> +
> +	i = ma35d1_reset_map_lookup(MA35D1_RESET_CHIP);
> +	writel_relaxed(BIT(ma35d1_reset_map[i].bit),
> +		       data->base + ma35d1_reset_map[i].reg_ofs);
> +	return 0;
> +}
> +
> +static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
> +			       unsigned long id, bool assert)
> +{
> +	u32 i, reg;
> +	struct ma35d1_reset_data *data = container_of(rcdev,
> +						      struct ma35d1_reset_data,
> +						      rcdev);
> +
> +	i = ma35d1_reset_map_lookup(id);
> +	reg = readl_relaxed(data->base + ma35d1_reset_map[i].reg_ofs);
> +	if (assert)
> +		reg |= BIT(ma35d1_reset_map[i].bit);
> +	else
> +		reg &= ~(BIT(ma35d1_reset_map[i].bit));
> +	writel_relaxed(reg, data->base + ma35d1_reset_map[i].reg_ofs);

This requires a spinlock to protect the register from simultaneous
read-modify-writes.

[...]
> +static int ma35d1_reset_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct ma35d1_reset_data *reset_data;
> +	struct ma35d1_reboot_data *reboot_data;
> +
> +	if (!pdev->dev.of_node) {
> +		dev_err(&pdev->dev, "Device tree node not found\n");

The driver is only probed via OF, so this isn't reachable and can be
dropped.

regards
Philipp
