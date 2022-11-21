Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD98631B17
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKUIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUIOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:14:43 -0500
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 00:14:40 PST
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E8F5A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:14:40 -0800 (PST)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id A31092F5F567
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:07:23 +0100 (CET)
Received: from s979.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 949642E2BDE1;
        Mon, 21 Nov 2022 09:07:23 +0100 (CET)
Received: from s898.loopia.se (unknown [172.22.191.6])
        by s979.loopia.se (Postfix) with ESMTP id 928F710BC45C;
        Mon, 21 Nov 2022 09:07:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from s899.loopia.se ([172.22.191.6])
        by s898.loopia.se (s898.loopia.se [172.22.190.17]) (amavisd-new, port 10024)
        with LMTP id B5vEprsRdhwL; Mon, 21 Nov 2022 09:07:23 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: richard@bit42.se
X-Loopia-Originating-IP: 178.174.130.84
Received: from hypercube.. (h-178-174-130-84.A444.priv.bahnhof.se [178.174.130.84])
        (Authenticated sender: richard@bit42.se)
        by s899.loopia.se (Postfix) with ESMTPSA id 02B032C8BAD4;
        Mon, 21 Nov 2022 09:07:22 +0100 (CET)
From:   Richard Alpe <richard@bit42.se>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Alpe <richard@bit42.se>
Subject: [PATCH v1] nvmem: add new NXP QorIQ eFuse driver
Date:   Mon, 21 Nov 2022 09:06:12 +0100
Message-Id: <20221121080612.11485-1-richard@bit42.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SFP (Security Fuse Processor) read support for NXP (Freescale)
QorIQ series SOC's.

This patch adds support for the T1023 SOC using the SFP offset from
the existing T1023 device tree. In theory this should also work for
T1024, T1014 and T1013 which uses the same SFP base offset.

Signed-off-by: Richard Alpe <richard@bit42.se>
---
 drivers/nvmem/Kconfig       | 12 ++++++
 drivers/nvmem/Makefile      |  2 +
 drivers/nvmem/qoriq-efuse.c | 80 +++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/nvmem/qoriq-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 755f551426b5..6907b0b68b3f 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -367,4 +367,16 @@ config NVMEM_ZYNQMP
 
 	  If sure, say yes. If unsure, say no.
 
+config NVMEM_QORIQ_EFUSE
+	tristate "NXP QorIQ eFuse support"
+	depends on PPC_85xx || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver provides read support for the eFuses (SFP) on NXP QorIQ
+	  series SoC's. This includes secure boot settings, the globally unique
+	  NXP ID 'FUIDR' and the OEM unique ID 'OUIDR'.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_qoriq_efuse.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index fa80fe17e567..635a5c03274b 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -73,3 +73,5 @@ obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
 nvmem-vf610-ocotp-y			:= vf610-ocotp.o
 obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
+obj-$(CONFIG_NVMEM_QORIQ_EFUSE)		+= nvmem-qoriq-efuse.o
+nvmem-qoriq-efuse-y			:= qoriq-efuse.o
diff --git a/drivers/nvmem/qoriq-efuse.c b/drivers/nvmem/qoriq-efuse.c
new file mode 100644
index 000000000000..a332bb603e7a
--- /dev/null
+++ b/drivers/nvmem/qoriq-efuse.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2022  Westermo Network Technologies AB
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+
+struct qoriq_efuse_priv {
+	void __iomem *base;
+};
+
+static int qoriq_efuse_read(void *context, unsigned int offset, void *val,
+			  size_t bytes)
+{
+	struct qoriq_efuse_priv *priv = context;
+	u32 *_val = val;
+
+	while (bytes >= sizeof(u32)) {
+		*_val++ = readl_relaxed(priv->base + offset);
+		offset += sizeof(u32);
+		bytes -= sizeof(u32);
+	}
+
+	return 0;
+}
+
+static int qoriq_efuse_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.dev = &pdev->dev,
+		.read_only = true,
+		.reg_read = qoriq_efuse_read,
+		.stride = sizeof(u32),
+		.word_size = sizeof(u32),
+		.name = "qoriq_efuse_read",
+		.id = NVMEM_DEVID_AUTO,
+		.root_only = true,
+	};
+	struct qoriq_efuse_priv *priv;
+	struct nvmem_device *nvmem;
+	struct resource *res;
+
+	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	config.size = resource_size(res);
+	config.priv = priv;
+	nvmem = devm_nvmem_register(config.dev, &config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id qoriq_efuse_of_match[] = {
+	{ .compatible = "fsl,t1023-sfp", },
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, qoriq_efuse_of_match);
+
+static struct platform_driver qoriq_efuse_driver = {
+	.probe = qoriq_efuse_probe,
+	.driver = {
+		.name = "qoriq-efuse",
+		.of_match_table = qoriq_efuse_of_match,
+	},
+};
+module_platform_driver(qoriq_efuse_driver);
+
+MODULE_AUTHOR("Richard Alpe <richard.alpe@bit42.se>");
+MODULE_DESCRIPTION("NXP QorIQ Security Fuse Processor (SFP) Reader");
+MODULE_LICENSE("GPL");
-- 
2.34.1

