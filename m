Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199F16ECA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjDXKVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjDXKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:47 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB46E18C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:20:45 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 8845C5EBF7;
        Mon, 24 Apr 2023 12:35:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-qs8Ysl2n;
        Mon, 24 Apr 2023 12:35:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328957;
        bh=26jP1z6kJxd8ER1tdQvbAbkoWyGDLjC4In1lvVJLLi0=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=sG8MZrtDcSveu1AzqOtwAzYRoYdrobB5Ta8zWmDhb+TvBCgPhPXlAoI1ia0VWrbgP
         DKobaaCytaGR+RiMIBK+PWCikaBjg1Ckrh8ML7KhQbPBo6XIRK8od48iHIZlYjSjyB
         LEQj79fbsT2LZiyJz3r7ghpUMR22Eh97qB5XqjCQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jean Delvare <jdelvare@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 23/43] mtd: ts72xx_nand: add platform helper
Date:   Mon, 24 Apr 2023 15:34:39 +0300
Message-Id: <20230424123522.18302-24-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only purpose of this code to provide platform_nand_data to gen_nand
driver which requires .cmd_ctrl and .dev_ready.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    rfc->v0
    Alexander Sverdlin:
    - platfrom -> platform
    
    Linus Walleij:
    - __raw_read/write[w|l] -> readb/writeb
    
    Arnd Bergmann:
    - name match node ts7250 instead of wildcard

 drivers/mtd/nand/raw/Kconfig       |  8 +++
 drivers/mtd/nand/raw/Makefile      |  1 +
 drivers/mtd/nand/raw/ts72xx_nand.c | 94 ++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/ts72xx_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 170f1185ddc4..08f88c34ce53 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -456,6 +456,14 @@ config MTD_NAND_RENESAS
 	  Enables support for the NAND controller found on Renesas R-Car
 	  Gen3 and RZ/N1 SoC families.
 
+config MTD_NAND_TS72XX
+	bool "ts72xx NAND controller"
+	depends on ARCH_EP93XX && HAS_IOMEM
+	select MTD_NAND_PLATFORM
+	help
+	  Enables support for NAND controller on ts72xx SBCs.
+	  These only set's platform data. The real driver is gen_nand.
+
 comment "Misc"
 
 config MTD_SM_COMMON
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 917cdfb815b9..b1d5cec84519 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -23,6 +23,7 @@ omap2_nand-objs := omap2.o
 obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_MARVELL)		+= marvell_nand.o
+obj-$(CONFIG_MTD_NAND_TS72XX)		+= ts72xx_nand.o
 obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
 obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
 obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
diff --git a/drivers/mtd/nand/raw/ts72xx_nand.c b/drivers/mtd/nand/raw/ts72xx_nand.c
new file mode 100644
index 000000000000..1c1c06c6e71a
--- /dev/null
+++ b/drivers/mtd/nand/raw/ts72xx_nand.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Technologic Systems TS72xx NAND driver platform code
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/platnand.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#define TS72XX_NAND_CONTROL_ADDR_LINE	22	/* 0xN0400000 */
+#define TS72XX_NAND_BUSY_ADDR_LINE	23	/* 0xN0800000 */
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
+static struct platform_nand_data ts72xx_nand_data = {
+	.chip = {
+		.nr_chips	= 1,
+		.chip_offset	= 0,
+		.chip_delay	= 15,
+	},
+	.ctrl = {
+		.cmd_ctrl	= ts72xx_nand_hwcontrol,
+		.dev_ready	= ts72xx_nand_device_ready,
+	},
+};
+
+static int __init ts72xx_nand_setup(void)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+
+	/* Multiplatform guard, only proceed on ts7250 */
+	if (!of_machine_is_compatible("technologic,ts7250"))
+		return 0;
+
+	np = of_find_compatible_node(NULL, NULL, "technologic,ts7200-nand");
+	if (!np) {
+		pr_err("%s : nand device tree node not found.\n", __func__);
+		return -EINVAL;
+	}
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		pr_err("%s : nand device not found.\n", __func__);
+		return -EINVAL;
+	}
+
+	pdev->dev.platform_data = &ts72xx_nand_data;
+	put_device(&pdev->dev);
+	of_node_put(np);
+
+	return 0;
+}
+
+subsys_initcall(ts72xx_nand_setup);
-- 
2.39.2

