Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7B7194CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjFAH5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjFAHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:55:00 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95B1A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:49:15 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685605753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8zgnzutmlxoB/RLgH8MCBdqpFZrjqcSK1xpIkDue6o=;
        b=KbeWYcIkRJ1sK7c0UlhKZhnmQ8JZHE5MzAxAfkwMiJ6rsCuqfR7J2qpxuwAwjR4KNy1cKZ
        P4ThP/k9rpHM/5CbGzqogIzEexqvotx5PqMxuOCTOwwS2Y+C557Jba38pbWPXrfpFJ3D8j
        G2yY5ib1G9o12uuxy65gvPoQj6UoYnfmGQ+sIEAEfEpmMwbf4nQ1B8zDAop80MAndIhX3I
        dJQCmb3du9+OmxJPYPcBjWq7UnH2tlTtz++DKJm6pDwu2WBs0TFFixhen7v79PL2IOrMI3
        bz8YCrdizsPVkEja2BkNpTUlNT7unWKk3fYPEAuDTjErhGjeREpdk4v9jU/FSA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DBD640014;
        Thu,  1 Jun 2023 07:49:09 +0000 (UTC)
Date:   Thu, 1 Jun 2023 09:49:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Jean Delvare <jdelvare@suse.de>,
        Liang Yang <liang.yang@amlogic.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 24/43] mtd: nand: add support for ts72xx
Message-ID: <20230601094908.7838ec17@xps-13>
In-Reply-To: <20230601054549.10843-6-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230601054549.10843-6-nikita.shubin@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

nikita.shubin@maquefel.me wrote on Thu,  1 Jun 2023 08:45:29 +0300:

> Technologic Systems has it's own nand controller implementation in CPLD.
>=20
> This patch adds support for TS-72XX boards family.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/mtd/nand/raw/Kconfig                  |   7 +
>  drivers/mtd/nand/raw/Makefile                 |   1 +
>  .../nand/raw/technologic-nand-controller.c    | 151 ++++++++++++++++++
>  3 files changed, 159 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/technologic-nand-controller.c
>=20
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index b523354dfb00..94788da1a169 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -456,6 +456,13 @@ config MTD_NAND_RENESAS
>  	  Enables support for the NAND controller found on Renesas R-Car
>  	  Gen3 and RZ/N1 SoC families.
> =20
> +config MTD_NAND_TS72XX
> +	bool "ts72xx NAND controller"
> +	depends on ARCH_EP93XX && HAS_IOMEM
> +	help
> +	  Enables support for NAND controller on ts72xx SBCs.
> +	  This is a legacy driver based on gen_nand.
> +
>  comment "Misc"
> =20
>  config MTD_SM_COMMON
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 917cdfb815b9..783e990a0078 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -23,6 +23,7 @@ omap2_nand-objs :=3D omap2.o
>  obj-$(CONFIG_MTD_NAND_OMAP2) 		+=3D omap2_nand.o
>  obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+=3D omap_elm.o
>  obj-$(CONFIG_MTD_NAND_MARVELL)		+=3D marvell_nand.o
> +obj-$(CONFIG_MTD_NAND_TS72XX)		+=3D technologic-nand-controller.o
>  obj-$(CONFIG_MTD_NAND_PLATFORM)		+=3D plat_nand.o
>  obj-$(CONFIG_MTD_NAND_PASEMI)		+=3D pasemi_nand.o
>  obj-$(CONFIG_MTD_NAND_ORION)		+=3D orion_nand.o
> diff --git a/drivers/mtd/nand/raw/technologic-nand-controller.c b/drivers=
/mtd/nand/raw/technologic-nand-controller.c
> new file mode 100644
> index 000000000000..09aeada933a1
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/technologic-nand-controller.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Technologic Systems TS72xx NAND controller driver
> + *
> + * Copyright (C) 2023 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * derived: plat_nand.c
> + *  Author: Vitaly Wool <vitalywool@gmail.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/platnand.h>
> +
> +#define TS72XX_NAND_CONTROL_ADDR_LINE	22	/* 0xN0400000 */
> +#define TS72XX_NAND_BUSY_ADDR_LINE	23	/* 0xN0800000 */
> +
> +struct ts72xx_nand_data {
> +	struct nand_controller	controller;
> +	struct nand_chip	chip;
> +	void __iomem		*io_base;
> +};
> +
> +static int ts72xx_nand_attach_chip(struct nand_chip *chip)
> +{
> +	if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_SOFT &&
> +	    chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN)
> +		chip->ecc.algo =3D NAND_ECC_ALGO_HAMMING;

I believe engine_type =3D=3D ON_HOST should return an error.

> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops ts72xx_nand_ops =3D {
> +	.attach_chip =3D ts72xx_nand_attach_chip,
> +};
> +
> +static void ts72xx_nand_hwcontrol(struct nand_chip *chip,
> +				  int cmd, unsigned int ctrl)
> +{
> +	if (ctrl & NAND_CTRL_CHANGE) {
> +		void __iomem *addr =3D chip->legacy.IO_ADDR_R;
> +		unsigned char bits;
> +
> +		addr +=3D (1 << TS72XX_NAND_CONTROL_ADDR_LINE);
> +
> +		bits =3D readb(addr) & ~0x07;
> +		bits |=3D (ctrl & NAND_NCE) << 2;	/* bit 0 -> bit 2 */
> +		bits |=3D (ctrl & NAND_CLE);	/* bit 1 -> bit 1 */
> +		bits |=3D (ctrl & NAND_ALE) >> 2;	/* bit 2 -> bit 0 */
> +
> +		writeb(bits, addr);
> +	}
> +
> +	if (cmd !=3D NAND_CMD_NONE)
> +		writeb(cmd, chip->legacy.IO_ADDR_W);
> +}
> +
> +static int ts72xx_nand_device_ready(struct nand_chip *chip)
> +{
> +	void __iomem *addr =3D chip->legacy.IO_ADDR_R;
> +
> +	addr +=3D (1 << TS72XX_NAND_BUSY_ADDR_LINE);
> +
> +	return !!(readb(addr) & 0x20);
> +}
> +
> +static int ts72xx_nand_probe(struct platform_device *pdev)
> +{
> +	struct ts72xx_nand_data *data;
> +	struct mtd_info *mtd;
> +	int err =3D 0;
> +
> +	/* Allocate memory for the device structure (and zero it) */
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_nand_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->controller.ops =3D &ts72xx_nand_ops;
> +	nand_controller_init(&data->controller);
> +	data->chip.controller =3D &data->controller;
> +
> +	data->io_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(data->io_base))
> +		return PTR_ERR(data->io_base);
> +
> +	nand_set_flash_node(&data->chip, pdev->dev.of_node);
> +	mtd =3D nand_to_mtd(&data->chip);
> +	mtd->dev.parent =3D &pdev->dev;
> +
> +	data->chip.legacy.IO_ADDR_R =3D data->io_base;
> +	data->chip.legacy.IO_ADDR_W =3D data->io_base;
> +	data->chip.legacy.cmd_ctrl =3D ts72xx_nand_hwcontrol;
> +	data->chip.legacy.dev_ready =3D ts72xx_nand_device_ready;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	/*
> +	 * This driver assumes that the default ECC engine should be TYPE_SOFT.
> +	 * Set ->engine_type before registering the NAND devices in order to
> +	 * provide a driver specific default value.
> +	 */
> +	data->chip.ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_SOFT;
> +
> +	/* Scan to find existence of the device */
> +	err =3D nand_scan(&data->chip, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D mtd_device_parse_register(mtd, NULL, NULL,
> +					NULL, 0);

The usual way -and more readable- is to jump to a goto label upon
error, and return 0 in the normal path.
> +
> +	if (!err)
> +		return err;
> +
> +	nand_cleanup(&data->chip);
> +
> +	return 0;
> +}
> +
> +static void ts72xx_nand_remove(struct platform_device *pdev)
> +{
> +	struct ts72xx_nand_data *data =3D platform_get_drvdata(pdev);
> +	struct nand_chip *chip =3D &data->chip;
> +	int ret;
> +
> +	ret =3D mtd_device_unregister(nand_to_mtd(chip));
> +	WARN_ON(ret);
> +	nand_cleanup(chip);
> +}
> +
> +static const struct of_device_id ts72xx_id_table[] =3D {
> +	{ .compatible =3D "technologic,ts7200-nand" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ts72xx_id_table);
> +
> +static struct platform_driver ts72xx_nand_driver =3D {
> +	.driver =3D {
> +		.name =3D "ts72xx-nand",
> +		.of_match_table =3D ts72xx_id_table,
> +	},
> +	.probe =3D ts72xx_nand_probe,
> +	.remove_new =3D ts72xx_nand_remove,
> +};
> +module_platform_driver(ts72xx_nand_driver);
> +


Thanks,
Miqu=C3=A8l
