Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A137E71928C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjFAFqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjFAFqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:31 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17853E5A
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:46:13 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id 7E8E646D04;
        Thu,  1 Jun 2023 08:46:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-YQEzRG2A;
        Thu, 01 Jun 2023 08:46:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598370;
        bh=zUol15piszy0DpHFh7aq9OsjbFQ/XdK+rX3Y5m5Tct8=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=mNLMxmyvWOKZ1qbHS4LNUvJ9HpLHsCg2zDw9xBnBUM2prl7+02tLgazyiAj6qtR8W
         7QWjP3jqwoaGL1EoSjIym8BNdAWIWKPR2pUSN8bdVVxtCnXKiyZ9i0h7B1zS+fBwr6
         bMLabvG2S6I8UOuAk6y/SnBQtGjdPpiZKp+oAzvQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Jean Delvare <jdelvare@suse.de>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Liang Yang <liang.yang@amlogic.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v1 24/43] mtd: nand: add support for ts72xx
Date:   Thu,  1 Jun 2023 08:45:29 +0300
Message-Id: <20230601054549.10843-6-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Technologic Systems has it's own nand controller implementation in CPLD.

This patch adds support for TS-72XX boards family.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/mtd/nand/raw/Kconfig                  |   7 +
 drivers/mtd/nand/raw/Makefile                 |   1 +
 .../nand/raw/technologic-nand-controller.c    | 151 ++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/technologic-nand-controller.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b523354dfb00..94788da1a169 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -456,6 +456,13 @@ config MTD_NAND_RENESAS
 	  Enables support for the NAND controller found on Renesas R-Car
 	  Gen3 and RZ/N1 SoC families.
 
+config MTD_NAND_TS72XX
+	bool "ts72xx NAND controller"
+	depends on ARCH_EP93XX && HAS_IOMEM
+	help
+	  Enables support for NAND controller on ts72xx SBCs.
+	  This is a legacy driver based on gen_nand.
+
 comment "Misc"
 
 config MTD_SM_COMMON
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 917cdfb815b9..783e990a0078 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -23,6 +23,7 @@ omap2_nand-objs := omap2.o
 obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_MARVELL)		+= marvell_nand.o
+obj-$(CONFIG_MTD_NAND_TS72XX)		+= technologic-nand-controller.o
 obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
 obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
 obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
diff --git a/drivers/mtd/nand/raw/technologic-nand-controller.c b/drivers/mtd/nand/raw/technologic-nand-controller.c
new file mode 100644
index 000000000000..09aeada933a1
--- /dev/null
+++ b/drivers/mtd/nand/raw/technologic-nand-controller.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Technologic Systems TS72xx NAND controller driver
+ *
+ * Copyright (C) 2023 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * derived: plat_nand.c
+ *  Author: Vitaly Wool <vitalywool@gmail.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/platnand.h>
+
+#define TS72XX_NAND_CONTROL_ADDR_LINE	22	/* 0xN0400000 */
+#define TS72XX_NAND_BUSY_ADDR_LINE	23	/* 0xN0800000 */
+
+struct ts72xx_nand_data {
+	struct nand_controller	controller;
+	struct nand_chip	chip;
+	void __iomem		*io_base;
+};
+
+static int ts72xx_nand_attach_chip(struct nand_chip *chip)
+{
+	if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_SOFT &&
+	    chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
+		chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
+
+	return 0;
+}
+
+static const struct nand_controller_ops ts72xx_nand_ops = {
+	.attach_chip = ts72xx_nand_attach_chip,
+};
+
+static void ts72xx_nand_hwcontrol(struct nand_chip *chip,
+				  int cmd, unsigned int ctrl)
+{
+	if (ctrl & NAND_CTRL_CHANGE) {
+		void __iomem *addr = chip->legacy.IO_ADDR_R;
+		unsigned char bits;
+
+		addr += (1 << TS72XX_NAND_CONTROL_ADDR_LINE);
+
+		bits = readb(addr) & ~0x07;
+		bits |= (ctrl & NAND_NCE) << 2;	/* bit 0 -> bit 2 */
+		bits |= (ctrl & NAND_CLE);	/* bit 1 -> bit 1 */
+		bits |= (ctrl & NAND_ALE) >> 2;	/* bit 2 -> bit 0 */
+
+		writeb(bits, addr);
+	}
+
+	if (cmd != NAND_CMD_NONE)
+		writeb(cmd, chip->legacy.IO_ADDR_W);
+}
+
+static int ts72xx_nand_device_ready(struct nand_chip *chip)
+{
+	void __iomem *addr = chip->legacy.IO_ADDR_R;
+
+	addr += (1 << TS72XX_NAND_BUSY_ADDR_LINE);
+
+	return !!(readb(addr) & 0x20);
+}
+
+static int ts72xx_nand_probe(struct platform_device *pdev)
+{
+	struct ts72xx_nand_data *data;
+	struct mtd_info *mtd;
+	int err = 0;
+
+	/* Allocate memory for the device structure (and zero it) */
+	data = devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_nand_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->controller.ops = &ts72xx_nand_ops;
+	nand_controller_init(&data->controller);
+	data->chip.controller = &data->controller;
+
+	data->io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->io_base))
+		return PTR_ERR(data->io_base);
+
+	nand_set_flash_node(&data->chip, pdev->dev.of_node);
+	mtd = nand_to_mtd(&data->chip);
+	mtd->dev.parent = &pdev->dev;
+
+	data->chip.legacy.IO_ADDR_R = data->io_base;
+	data->chip.legacy.IO_ADDR_W = data->io_base;
+	data->chip.legacy.cmd_ctrl = ts72xx_nand_hwcontrol;
+	data->chip.legacy.dev_ready = ts72xx_nand_device_ready;
+
+	platform_set_drvdata(pdev, data);
+
+	/*
+	 * This driver assumes that the default ECC engine should be TYPE_SOFT.
+	 * Set ->engine_type before registering the NAND devices in order to
+	 * provide a driver specific default value.
+	 */
+	data->chip.ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
+
+	/* Scan to find existence of the device */
+	err = nand_scan(&data->chip, 1);
+	if (err)
+		return err;
+
+	err = mtd_device_parse_register(mtd, NULL, NULL,
+					NULL, 0);
+
+	if (!err)
+		return err;
+
+	nand_cleanup(&data->chip);
+
+	return 0;
+}
+
+static void ts72xx_nand_remove(struct platform_device *pdev)
+{
+	struct ts72xx_nand_data *data = platform_get_drvdata(pdev);
+	struct nand_chip *chip = &data->chip;
+	int ret;
+
+	ret = mtd_device_unregister(nand_to_mtd(chip));
+	WARN_ON(ret);
+	nand_cleanup(chip);
+}
+
+static const struct of_device_id ts72xx_id_table[] = {
+	{ .compatible = "technologic,ts7200-nand" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ts72xx_id_table);
+
+static struct platform_driver ts72xx_nand_driver = {
+	.driver = {
+		.name = "ts72xx-nand",
+		.of_match_table = ts72xx_id_table,
+	},
+	.probe = ts72xx_nand_probe,
+	.remove_new = ts72xx_nand_remove,
+};
+module_platform_driver(ts72xx_nand_driver);
+
-- 
2.37.4

