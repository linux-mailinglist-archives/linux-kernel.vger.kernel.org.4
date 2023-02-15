Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337A697D61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjBON3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjBON31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:29:27 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004939B9F;
        Wed, 15 Feb 2023 05:29:10 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pSHq4-0005qU-1f;
        Wed, 15 Feb 2023 14:28:48 +0100
Date:   Wed, 15 Feb 2023 13:27:11 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Sean Wang <sean.wang@mediatek.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mingming Su <Mingming.Su@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwrng: add driver for MediaTek TRNG SMC
Message-ID: <89865515728cb937b6591160ad9c30b4bcc8dd41.1676467500.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver providing kernel-side support for the Random Number
Generator hardware found on Mediatek SoCs which have a driver in ARM
TrustedFirmware-A allowing Linux to read random numbers using a
non-standard vendor-defined Secure Monitor Call.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 MAINTAINERS                         |  1 +
 drivers/char/hw_random/Kconfig      | 16 +++++++
 drivers/char/hw_random/Makefile     |  1 +
 drivers/char/hw_random/mtk-rng-v2.c | 74 +++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)
 create mode 100644 drivers/char/hw_random/mtk-rng-v2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index be167c695c64..90d82aba6d73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13148,6 +13148,7 @@ F:	drivers/leds/leds-mt6323.c
 MEDIATEK RANDOM NUMBER GENERATOR SUPPORT
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
+F:	drivers/char/hw_random/mtk-rng-v2.c
 F:	drivers/char/hw_random/mtk-rng.c
 
 MEDIATEK SMI DRIVER
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 4fdf07ae3c54..7c900185486d 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -439,6 +439,22 @@ config HW_RANDOM_MTK
 
 	  If unsure, say Y.
 
+config HW_RANDOM_MTK_V2
+	tristate "Mediatek Random Number Generator support (v2/SMC)"
+	depends on HW_RANDOM
+	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
+	default y
+	help
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Mediatek SoCs which have a driver
+	  in ARM TrustedFirmware-A allowing Linux to read using a non-
+	  standard vendor-defined Secure Monitor Call.
+
+	  To compile this driver as a module, choose M here. the
+	  module will be called mtk-rng-v2.
+
+	  If unsure, say Y.
+
 config HW_RANDOM_S390
 	tristate "S390 True Random Number Generator support"
 	depends on S390
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 09bde4a0f971..ba319c509e86 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_HW_RANDOM_PIC32) += pic32-rng.o
 obj-$(CONFIG_HW_RANDOM_MESON) += meson-rng.o
 obj-$(CONFIG_HW_RANDOM_CAVIUM) += cavium-rng.o cavium-rng-vf.o
 obj-$(CONFIG_HW_RANDOM_MTK)	+= mtk-rng.o
+obj-$(CONFIG_HW_RANDOM_MTK_V2)	+= mtk-rng-v2.o
 obj-$(CONFIG_HW_RANDOM_S390) += s390-trng.o
 obj-$(CONFIG_HW_RANDOM_KEYSTONE) += ks-sa-rng.o
 obj-$(CONFIG_HW_RANDOM_OPTEE) += optee-rng.o
diff --git a/drivers/char/hw_random/mtk-rng-v2.c b/drivers/char/hw_random/mtk-rng-v2.c
new file mode 100644
index 000000000000..6e61f4361d9e
--- /dev/null
+++ b/drivers/char/hw_random/mtk-rng-v2.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Mediatek Hardware Random Number Generator (v2/SMCC)
+ *
+ * Copyright (C) 2023 Daniel Golle <daniel@makrotopia.org>
+ * based on patch from Mingming Su <Mingming.Su@mediatek.com>
+ */
+#define MTK_RNG_DEV KBUILD_MODNAME
+
+#include <linux/arm-smccc.h>
+#include <linux/err.h>
+#include <linux/hw_random.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/soc/mediatek/mtk_sip_svc.h>
+
+#define MTK_SIP_KERNEL_GET_RND		MTK_SIP_SMC_CMD(0x550)
+
+static int mtk_rng_v2_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	struct arm_smccc_res res;
+	int retval = 0;
+
+	while (max >= sizeof(u32)) {
+		arm_smccc_smc(MTK_SIP_KERNEL_GET_RND, 0, 0, 0, 0, 0, 0, 0,
+			      &res);
+		if (res.a0)
+			break;
+
+		*(u32 *)buf = res.a1;
+		retval += sizeof(u32);
+		buf += sizeof(u32);
+		max -= sizeof(u32);
+	}
+
+	return retval || !wait ? retval : -EIO;
+}
+
+static int mtk_rng_v2_probe(struct platform_device *pdev)
+{
+	struct hwrng *trng;
+
+	trng = devm_kzalloc(&pdev->dev, sizeof(*trng), GFP_KERNEL);
+	if (!trng)
+		return -ENOMEM;
+
+	trng->name = pdev->name;
+	trng->read = mtk_rng_v2_read;
+	trng->quality = 900;
+
+	return devm_hwrng_register(&pdev->dev, trng);
+}
+
+static const struct of_device_id mtk_rng_v2_match[] = {
+	{ .compatible = "mediatek,mt7981-rng" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_rng_v2_match);
+
+static struct platform_driver mtk_rng_v2_driver = {
+	.probe          = mtk_rng_v2_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = mtk_rng_v2_match,
+	},
+};
+module_platform_driver(mtk_rng_v2_driver);
+
+MODULE_DESCRIPTION("Mediatek Random Number Generator Driver (v2/SMC)");
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
+MODULE_LICENSE("GPL");

base-commit: 9d9019bcea1aac7eed64a1a4966282b6b7b141c8
-- 
2.39.1

