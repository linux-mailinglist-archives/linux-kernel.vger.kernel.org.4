Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5C36EEEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbjDZG7Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 02:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbjDZG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:59:06 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4779A26B8;
        Tue, 25 Apr 2023 23:59:02 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1B05924E1EF;
        Wed, 26 Apr 2023 14:59:01 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 14:59:01 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 14:58:57 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v6 2/4] crypto: starfive - Add crypto engine support
Date:   Wed, 26 Apr 2023 14:58:46 +0800
Message-ID: <20230426065848.842221-3-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230426065848.842221-1-jiajie.ho@starfivetech.com>
References: <20230426065848.842221-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding device probe and DMA init for StarFive cryptographic module.

Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 MAINTAINERS                           |   7 +
 drivers/crypto/Kconfig                |   1 +
 drivers/crypto/Makefile               |   1 +
 drivers/crypto/starfive/Kconfig       |  17 +++
 drivers/crypto/starfive/Makefile      |   4 +
 drivers/crypto/starfive/jh7110-cryp.c | 199 ++++++++++++++++++++++++++
 drivers/crypto/starfive/jh7110-cryp.h |  63 ++++++++
 7 files changed, 292 insertions(+)
 create mode 100644 drivers/crypto/starfive/Kconfig
 create mode 100644 drivers/crypto/starfive/Makefile
 create mode 100644 drivers/crypto/starfive/jh7110-cryp.c
 create mode 100644 drivers/crypto/starfive/jh7110-cryp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 65140500d9f8..a6f7677db4db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19609,6 +19609,13 @@ F:	Documentation/devicetree/bindings/clock/starfive*
 F:	drivers/clk/starfive/
 F:	include/dt-bindings/clock/starfive*
 
+STARFIVE CRYPTO DRIVER
+M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
+M:	William Qiu <william.qiu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/crypto/starfive*
+F:	drivers/crypto/starfive/
+
 STARFIVE PINCTRL DRIVER
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Jianlong Huang <jianlong.huang@starfivetech.com>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 55e75fbb658e..64b94376601c 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -817,5 +817,6 @@ config CRYPTO_DEV_SA2UL
 
 source "drivers/crypto/keembay/Kconfig"
 source "drivers/crypto/aspeed/Kconfig"
+source "drivers/crypto/starfive/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 116de173a66c..212931c84412 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -53,3 +53,4 @@ obj-y += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += keembay/
+obj-y += starfive/
diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
new file mode 100644
index 000000000000..73f39b6bc09f
--- /dev/null
+++ b/drivers/crypto/starfive/Kconfig
@@ -0,0 +1,17 @@
+#
+# StarFive crypto drivers configuration
+#
+
+config CRYPTO_DEV_JH7110
+	tristate "StarFive JH7110 cryptographic engine driver"
+	depends on SOC_STARFIVE
+	select CRYPTO_ENGINE
+	select ARM_AMBA
+	select DMADEVICES
+	select AMBA_PL08X
+	help
+	  Support for StarFive JH7110 crypto hardware acceleration engine.
+	  This module provides acceleration for public key algo,
+	  skciphers, AEAD and hash functions.
+
+	  If you choose 'M' here, this module will be called starfive-crypto.
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
new file mode 100644
index 000000000000..41221acaee39
--- /dev/null
+++ b/drivers/crypto/starfive/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
+jh7110-crypto-objs := jh7110-cryp.o
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
new file mode 100644
index 000000000000..a944897609a2
--- /dev/null
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cryptographic API.
+ *
+ * Support for StarFive hardware cryptographic engine.
+ * Copyright (c) 2022 StarFive Technology
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#include "jh7110-cryp.h"
+
+#define DRIVER_NAME             "starfive-crypto"
+
+struct starfive_dev_list {
+	struct list_head        dev_list;
+	spinlock_t              lock; /* protect dev_list */
+};
+
+static struct starfive_dev_list dev_list = {
+	.dev_list = LIST_HEAD_INIT(dev_list.dev_list),
+	.lock     = __SPIN_LOCK_UNLOCKED(dev_list.lock),
+};
+
+struct starfive_cryp_dev *starfive_cryp_find_dev(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = NULL, *tmp;
+
+	spin_lock_bh(&dev_list.lock);
+	if (!ctx->cryp) {
+		list_for_each_entry(tmp, &dev_list.dev_list, list) {
+			cryp = tmp;
+			break;
+		}
+		ctx->cryp = cryp;
+	} else {
+		cryp = ctx->cryp;
+	}
+
+	spin_unlock_bh(&dev_list.lock);
+
+	return cryp;
+}
+
+static int starfive_dma_init(struct starfive_cryp_dev *cryp)
+{
+	dma_cap_mask_t mask;
+
+	cryp->tx = NULL;
+	cryp->rx = NULL;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	cryp->tx = dma_request_chan(cryp->dev, "tx");
+	if (IS_ERR(cryp->tx))
+		return dev_err_probe(cryp->dev, PTR_ERR(cryp->tx),
+				     "Error requesting tx dma channel.\n");
+
+	cryp->rx = dma_request_chan(cryp->dev, "rx");
+	if (IS_ERR(cryp->rx)) {
+		dma_release_channel(cryp->tx);
+		return dev_err_probe(cryp->dev, PTR_ERR(cryp->rx),
+				     "Error requesting rx dma channel.\n");
+	}
+
+	return 0;
+}
+
+static void starfive_dma_cleanup(struct starfive_cryp_dev *cryp)
+{
+	dma_release_channel(cryp->tx);
+	dma_release_channel(cryp->rx);
+}
+
+static int starfive_cryp_probe(struct platform_device *pdev)
+{
+	struct starfive_cryp_dev *cryp;
+	struct resource *res;
+	int ret;
+
+	cryp = devm_kzalloc(&pdev->dev, sizeof(*cryp), GFP_KERNEL);
+	if (!cryp)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, cryp);
+	cryp->dev = &pdev->dev;
+
+	cryp->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(cryp->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->base),
+				     "Error remapping memory for platform device\n");
+
+	cryp->phys_base = res->start;
+	cryp->dma_maxburst = 32;
+
+	cryp->hclk = devm_clk_get(&pdev->dev, "hclk");
+	if (IS_ERR(cryp->hclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->hclk),
+				     "Error getting hardware reference clock\n");
+
+	cryp->ahb = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(cryp->ahb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->ahb),
+				     "Error getting ahb reference clock\n");
+
+	cryp->rst = devm_reset_control_get_shared(cryp->dev, NULL);
+	if (IS_ERR(cryp->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cryp->rst),
+				     "Error getting hardware reset line\n");
+
+	clk_prepare_enable(cryp->hclk);
+	clk_prepare_enable(cryp->ahb);
+	reset_control_deassert(cryp->rst);
+
+	spin_lock(&dev_list.lock);
+	list_add(&cryp->list, &dev_list.dev_list);
+	spin_unlock(&dev_list.lock);
+
+	ret = starfive_dma_init(cryp);
+	if (ret)
+		goto err_dma_init;
+
+	/* Initialize crypto engine */
+	cryp->engine = crypto_engine_alloc_init(&pdev->dev, 1);
+	if (!cryp->engine) {
+		ret = -ENOMEM;
+		goto err_engine;
+	}
+
+	ret = crypto_engine_start(cryp->engine);
+	if (ret)
+		goto err_engine_start;
+
+	return 0;
+
+err_engine_start:
+	crypto_engine_exit(cryp->engine);
+err_engine:
+	starfive_dma_cleanup(cryp);
+err_dma_init:
+	spin_lock(&dev_list.lock);
+	list_del(&cryp->list);
+	spin_unlock(&dev_list.lock);
+
+	return ret;
+}
+
+static int starfive_cryp_remove(struct platform_device *pdev)
+{
+	struct starfive_cryp_dev *cryp = platform_get_drvdata(pdev);
+
+	if (!cryp)
+		return -ENODEV;
+
+	crypto_engine_stop(cryp->engine);
+	crypto_engine_exit(cryp->engine);
+
+	starfive_dma_cleanup(cryp);
+
+	spin_lock(&dev_list.lock);
+	list_del(&cryp->list);
+	spin_unlock(&dev_list.lock);
+
+	clk_disable_unprepare(cryp->hclk);
+	clk_disable_unprepare(cryp->ahb);
+	reset_control_assert(cryp->rst);
+
+	return 0;
+}
+
+static const struct of_device_id starfive_dt_ids[] __maybe_unused = {
+	{ .compatible = "starfive,jh7110-crypto", .data = NULL},
+	{},
+};
+MODULE_DEVICE_TABLE(of, starfive_dt_ids);
+
+static struct platform_driver starfive_cryp_driver = {
+	.probe  = starfive_cryp_probe,
+	.remove = starfive_cryp_remove,
+	.driver = {
+		.name           = DRIVER_NAME,
+		.of_match_table = starfive_dt_ids,
+	},
+};
+
+module_platform_driver(starfive_cryp_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("StarFive Cryptographic Module");
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
new file mode 100644
index 000000000000..393efd38b098
--- /dev/null
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __STARFIVE_STR_H__
+#define __STARFIVE_STR_H__
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+
+#include <crypto/engine.h>
+
+#define STARFIVE_ALG_CR_OFFSET			0x0
+#define STARFIVE_ALG_FIFO_OFFSET		0x4
+#define STARFIVE_IE_MASK_OFFSET			0x8
+#define STARFIVE_IE_FLAG_OFFSET			0xc
+#define STARFIVE_DMA_IN_LEN_OFFSET		0x10
+#define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
+
+#define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
+
+union starfive_alg_cr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 aes_dma_en			:1;
+		u32 rsvd_0			:1;
+		u32 hash_dma_en			:1;
+		u32 alg_done			:1;
+		u32 rsvd_1			:3;
+		u32 clear			:1;
+		u32 rsvd_2			:23;
+	};
+};
+
+struct starfive_cryp_ctx {
+	struct crypto_engine_ctx		enginectx;
+	struct starfive_cryp_dev		*cryp;
+};
+
+struct starfive_cryp_dev {
+	struct list_head			list;
+	struct device				*dev;
+
+	struct clk				*hclk;
+	struct clk				*ahb;
+	struct reset_control			*rst;
+
+	void __iomem				*base;
+	phys_addr_t				phys_base;
+
+	u32					dma_maxburst;
+	struct dma_chan				*tx;
+	struct dma_chan				*rx;
+	struct dma_slave_config			cfg_in;
+	struct dma_slave_config			cfg_out;
+
+	struct crypto_engine			*engine;
+
+	union starfive_alg_cr			alg_cr;
+};
+
+struct starfive_cryp_dev *starfive_cryp_find_dev(struct starfive_cryp_ctx *ctx);
+
+#endif
-- 
2.25.1

