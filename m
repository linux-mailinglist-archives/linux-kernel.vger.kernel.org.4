Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3763CEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiK3Fzn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 00:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiK3Fz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:55:29 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620365E60;
        Tue, 29 Nov 2022 21:55:27 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EACD324E2E3;
        Wed, 30 Nov 2022 13:52:24 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:25 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 13:52:20 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>
Subject: [PATCH 1/6] crypto: starfive - Add StarFive crypto engine support
Date:   Wed, 30 Nov 2022 13:52:09 +0800
Message-ID: <20221130055214.2416888-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding device probe and DMA init for StarFive
hardware crypto engine.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
---
 MAINTAINERS                             |   7 +
 drivers/crypto/Kconfig                  |   1 +
 drivers/crypto/Makefile                 |   1 +
 drivers/crypto/starfive/Kconfig         |  20 ++
 drivers/crypto/starfive/Makefile        |   4 +
 drivers/crypto/starfive/starfive-cryp.c | 268 ++++++++++++++++++++++++
 drivers/crypto/starfive/starfive-regs.h |  26 +++
 drivers/crypto/starfive/starfive-str.h  |  74 +++++++
 8 files changed, 401 insertions(+)
 create mode 100644 drivers/crypto/starfive/Kconfig
 create mode 100644 drivers/crypto/starfive/Makefile
 create mode 100644 drivers/crypto/starfive/starfive-cryp.c
 create mode 100644 drivers/crypto/starfive/starfive-regs.h
 create mode 100644 drivers/crypto/starfive/starfive-str.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 65140500d9f8..ca189a563a39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19609,6 +19609,13 @@ F:	Documentation/devicetree/bindings/clock/starfive*
 F:	drivers/clk/starfive/
 F:	include/dt-bindings/clock/starfive*
 
+STARFIVE CRYPTO DRIVER
+M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
+M:	William Qiu <william.qiu@starfivetech.com>
+S:	Maintained
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
index 000000000000..f8a2b6ecbddc
--- /dev/null
+++ b/drivers/crypto/starfive/Kconfig
@@ -0,0 +1,20 @@
+#
+# StarFive crypto drivers configuration
+#
+
+config CRYPTO_DEV_STARFIVE
+	tristate "StarFive cryptographic engine driver"
+	depends on SOC_STARFIVE
+	select CRYPTO_ENGINE
+	select CRYPTO_RSA
+	select CRYPTO_AES
+	select CRYPTO_CCM
+	select ARM_AMBA
+	select DMADEVICES
+	select AMBA_PL08X
+	help
+	  Support for StarFive crypto hardware acceleration engine.
+	  This module provides acceleration for public key algo,
+	  skciphers, AEAD and hash functions.
+
+	  If you choose 'M' here, this module will be called starfive-crypto.
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
new file mode 100644
index 000000000000..5a84f808a671
--- /dev/null
+++ b/drivers/crypto/starfive/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CRYPTO_DEV_STARFIVE) += starfive-crypto.o
+starfive-crypto-objs := starfive-cryp.o
diff --git a/drivers/crypto/starfive/starfive-cryp.c b/drivers/crypto/starfive/starfive-cryp.c
new file mode 100644
index 000000000000..574f9e8f4cc1
--- /dev/null
+++ b/drivers/crypto/starfive/starfive-cryp.c
@@ -0,0 +1,268 @@
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
+#include "starfive-str.h"
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
+struct starfive_sec_dev *starfive_sec_find_dev(struct starfive_sec_ctx *ctx)
+{
+	struct starfive_sec_dev *sdev = NULL, *tmp;
+
+	spin_lock_bh(&dev_list.lock);
+	if (!ctx->sdev) {
+		list_for_each_entry(tmp, &dev_list.dev_list, list) {
+			sdev = tmp;
+			break;
+		}
+		ctx->sdev = sdev;
+	} else {
+		sdev = ctx->sdev;
+	}
+
+	spin_unlock_bh(&dev_list.lock);
+
+	return sdev;
+}
+
+static const struct of_device_id starfive_dt_ids[] = {
+	{ .compatible = "starfive,jh7110-crypto", .data = NULL},
+	{},
+};
+MODULE_DEVICE_TABLE(of, starfive_dt_ids);
+
+static int starfive_dma_init(struct starfive_sec_dev *sdev)
+{
+	dma_cap_mask_t mask;
+	int err;
+
+	sdev->sec_xm_m = NULL;
+	sdev->sec_xm_p = NULL;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	sdev->sec_xm_m = dma_request_chan(sdev->dev, "sec_m");
+	if (IS_ERR(sdev->sec_xm_m)) {
+		dev_err(sdev->dev, "sec_m dma channel request failed.\n");
+		return PTR_ERR(sdev->sec_xm_m);
+	}
+
+	sdev->sec_xm_p = dma_request_chan(sdev->dev, "sec_p");
+	if (IS_ERR(sdev->sec_xm_p)) {
+		dev_err(sdev->dev, "sec_p dma channel request failed.\n");
+		goto err_dma_out;
+	}
+
+	init_completion(&sdev->sec_comp_m);
+	init_completion(&sdev->sec_comp_p);
+
+	return 0;
+
+err_dma_out:
+	dma_release_channel(sdev->sec_xm_m);
+
+	return err;
+}
+
+static void starfive_dma_cleanup(struct starfive_sec_dev *sdev)
+{
+	dma_release_channel(sdev->sec_xm_p);
+	dma_release_channel(sdev->sec_xm_m);
+}
+
+static int starfive_cryp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct starfive_sec_dev *sdev;
+	struct resource *res;
+	int pages = 0;
+	int ret;
+
+	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	sdev->dev = dev;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "secreg");
+	sdev->io_base = devm_ioremap_resource(dev, res);
+
+	if (IS_ERR(sdev->io_base))
+		return PTR_ERR(sdev->io_base);
+
+	sdev->use_side_channel_mitigation =
+		device_property_read_bool(dev, "enable-side-channel-mitigation");
+	sdev->use_dma = device_property_read_bool(dev, "enable-dma");
+	sdev->dma_maxburst = 32;
+
+	sdev->sec_hclk = devm_clk_get(dev, "sec_hclk");
+	if (IS_ERR(sdev->sec_hclk)) {
+		dev_err(dev, "Failed to get sec_hclk.\n");
+		return PTR_ERR(sdev->sec_hclk);
+	}
+
+	sdev->sec_ahb = devm_clk_get(dev, "sec_ahb");
+	if (IS_ERR(sdev->sec_ahb)) {
+		dev_err(dev, "Failed to get sec_ahb.\n");
+		return PTR_ERR(sdev->sec_ahb);
+	}
+
+	sdev->rst_hresetn = devm_reset_control_get_shared(sdev->dev, "sec_hre");
+	if (IS_ERR(sdev->rst_hresetn)) {
+		dev_err(sdev->dev, "Failed to get sec_hre.\n");
+		return PTR_ERR(sdev->rst_hresetn);
+	}
+
+	clk_prepare_enable(sdev->sec_hclk);
+	clk_prepare_enable(sdev->sec_ahb);
+	reset_control_deassert(sdev->rst_hresetn);
+
+	platform_set_drvdata(pdev, sdev);
+
+	spin_lock(&dev_list.lock);
+	list_add(&sdev->list, &dev_list.dev_list);
+	spin_unlock(&dev_list.lock);
+
+	if (sdev->use_dma) {
+		ret = starfive_dma_init(sdev);
+		if (ret) {
+			dev_err(dev, "Failed to initialize DMA channel.\n");
+			goto err_dma_init;
+		}
+	}
+
+	pages = get_order(STARFIVE_MSG_BUFFER_SIZE);
+
+	sdev->pages_count = pages >> 1;
+	sdev->data_buf_len = STARFIVE_MSG_BUFFER_SIZE >> 1;
+
+	/* Initialize crypto engine */
+	sdev->engine = crypto_engine_alloc_init(dev, 1);
+	if (!sdev->engine) {
+		ret = -ENOMEM;
+		goto err_engine;
+	}
+
+	ret = crypto_engine_start(sdev->engine);
+	if (ret)
+		goto err_engine_start;
+
+	dev_info(dev, "Crypto engine started\n");
+
+	return 0;
+
+err_engine_start:
+	crypto_engine_exit(sdev->engine);
+err_engine:
+	starfive_dma_cleanup(sdev);
+err_dma_init:
+	spin_lock(&dev_list.lock);
+	list_del(&sdev->list);
+	spin_unlock(&dev_list.lock);
+
+	return ret;
+}
+
+static int starfive_cryp_remove(struct platform_device *pdev)
+{
+	struct starfive_sec_dev *sdev = platform_get_drvdata(pdev);
+
+	if (!sdev)
+		return -ENODEV;
+
+	crypto_engine_stop(sdev->engine);
+	crypto_engine_exit(sdev->engine);
+
+	starfive_dma_cleanup(sdev);
+
+	spin_lock(&dev_list.lock);
+	list_del(&sdev->list);
+	spin_unlock(&dev_list.lock);
+
+	clk_disable_unprepare(sdev->sec_hclk);
+	clk_disable_unprepare(sdev->sec_ahb);
+	reset_control_assert(sdev->rst_hresetn);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int starfive_cryp_runtime_suspend(struct device *dev)
+{
+	struct starfive_sec_dev *sdev = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(sdev->sec_ahb);
+	clk_disable_unprepare(sdev->sec_hclk);
+
+	return 0;
+}
+
+static int starfive_cryp_runtime_resume(struct device *dev)
+{
+	struct starfive_sec_dev *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(sdev->sec_ahb);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to prepare_enable sec_ahb clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(sdev->sec_hclk);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to prepare_enable sec_hclk clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops starfive_cryp_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(starfive_cryp_runtime_suspend,
+			   starfive_cryp_runtime_resume, NULL)
+};
+
+static struct platform_driver starfive_cryp_driver = {
+	.probe  = starfive_cryp_probe,
+	.remove = starfive_cryp_remove,
+	.driver = {
+		.name           = DRIVER_NAME,
+		.pm		= &starfive_cryp_pm_ops,
+		.of_match_table = starfive_dt_ids,
+	},
+};
+
+module_platform_driver(starfive_cryp_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("StarFive hardware crypto acceleration");
diff --git a/drivers/crypto/starfive/starfive-regs.h b/drivers/crypto/starfive/starfive-regs.h
new file mode 100644
index 000000000000..0d680cb1f502
--- /dev/null
+++ b/drivers/crypto/starfive/starfive-regs.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __STARFIVE_REGS_H__
+#define __STARFIVE_REGS_H__
+
+#define STARFIVE_ALG_CR_OFFSET			0x0
+#define STARFIVE_ALG_FIFO_OFFSET		0x4
+#define STARFIVE_IE_MASK_OFFSET			0x8
+#define STARFIVE_IE_FLAG_OFFSET			0xc
+#define STARFIVE_DMA_IN_LEN_OFFSET		0x10
+#define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
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
+#endif
diff --git a/drivers/crypto/starfive/starfive-str.h b/drivers/crypto/starfive/starfive-str.h
new file mode 100644
index 000000000000..4ba3c56f0573
--- /dev/null
+++ b/drivers/crypto/starfive/starfive-str.h
@@ -0,0 +1,74 @@
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
+#include "starfive-regs.h"
+
+#define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
+
+struct starfive_sec_ctx {
+	struct crypto_engine_ctx		enginectx;
+	struct starfive_sec_dev			*sdev;
+
+	u8					*buffer;
+};
+
+struct starfive_sec_dev {
+	struct list_head			list;
+	struct device				*dev;
+
+	struct clk				*sec_hclk;
+	struct clk				*sec_ahb;
+	struct reset_control			*rst_hresetn;
+
+	void __iomem				*io_base;
+	phys_addr_t				io_phys_base;
+
+	size_t					data_buf_len;
+	int					pages_count;
+	u32					use_side_channel_mitigation;
+	u32					use_dma;
+	u32					dma_maxburst;
+	struct dma_chan				*sec_xm_m;
+	struct dma_chan				*sec_xm_p;
+	struct dma_slave_config			cfg_in;
+	struct dma_slave_config			cfg_out;
+	struct completion			sec_comp_m;
+	struct completion			sec_comp_p;
+
+	struct crypto_engine			*engine;
+
+	union starfive_alg_cr			alg_cr;
+};
+
+static inline u32 starfive_sec_read(struct starfive_sec_dev *sdev, u32 offset)
+{
+	return __raw_readl(sdev->io_base + offset);
+}
+
+static inline u8 starfive_sec_readb(struct starfive_sec_dev *sdev, u32 offset)
+{
+	return __raw_readb(sdev->io_base + offset);
+}
+
+static inline void starfive_sec_write(struct starfive_sec_dev *sdev,
+				      u32 offset, u32 value)
+{
+	__raw_writel(value, sdev->io_base + offset);
+}
+
+static inline void starfive_sec_writeb(struct starfive_sec_dev *sdev,
+				       u32 offset, u8 value)
+{
+	__raw_writeb(value, sdev->io_base + offset);
+}
+
+struct starfive_sec_dev *starfive_sec_find_dev(struct starfive_sec_ctx *ctx);
+
+#endif
-- 
2.25.1

