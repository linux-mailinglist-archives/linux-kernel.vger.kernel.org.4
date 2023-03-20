Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC9E6C1492
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCTOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCTOWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:22:18 -0400
X-Greylist: delayed 469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 07:22:11 PDT
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279C1F91B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:22:11 -0700 (PDT)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 59CEC2F8F7CE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:14:19 +0100 (CET)
Received: from s980.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 4AFEA2E28CE3;
        Mon, 20 Mar 2023 15:14:19 +0100 (CET)
Received: from s474.loopia.se (unknown [172.22.191.5])
        by s980.loopia.se (Postfix) with ESMTP id 486332201601;
        Mon, 20 Mar 2023 15:14:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from s979.loopia.se ([172.22.191.5])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with UTF8LMTP id gclQbiXBgMJZ; Mon, 20 Mar 2023 15:14:18 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: richard@bit42.se
X-Loopia-Originating-IP: 178.174.130.84
Received: from hypercube.. (h-178-174-130-84.A444.priv.bahnhof.se [178.174.130.84])
        (Authenticated sender: richard@bit42.se)
        by s979.loopia.se (Postfix) with ESMTPSA id 97A7510BC44E;
        Mon, 20 Mar 2023 15:14:18 +0100 (CET)
From:   Richard Alpe <richard@bit42.se>
To:     srinivas.kandagatla@linaro.org
Cc:     niklas.soderlund@ragnatech.se, linux-kernel@vger.kernel.org,
        Richard Alpe <richard@bit42.se>
Subject: [PATCH v2] nvmem: add new NXP QorIQ eFuse driver
Date:   Mon, 20 Mar 2023 15:14:08 +0100
Message-Id: <20230320141408.1555041-1-richard@bit42.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4067; h=from:subject; bh=NCYlU+yfF0yCzPpDEZJDvuZuSI2doJFdB+ysdVcfRWA=; b=owEBbQKS/ZANAwAKAaR4ncy5pstaAcsmYgBkGGovLrNrlb905458G9mhNjpRr6VFDTRT095Md1sZ bwcctO2JAjMEAAEKAB0WIQQsEvAKF4GLpV03omKkeJ3MuabLWgUCZBhqLwAKCRCkeJ3MuabLWtw7EA DRc6sdIts5YWr26CTgZx5B4KvSyMhYtwNbzRwY92Z5RjgLfZXeMtw1Rpa1YEQQ9RP+VV4aQHVeeaMB VkG8h/gvF6j8BveAU/7J3WChWPHB+OMBL/lZ9U6FI2stejWMdHeRa3cG3rpSB+3lfg3VxNT1RBbSzG WEsLI9pnOzp4B1/euYbzvs4IjSoxRb4ezqiRPL50zdAqjWCnb1IS/S/jJr8Q51OvPmKfI5RCzOtP4J 4a4qxvbbZyierLi2lSZaz8ULFfjwBHDy0RmBW+4uvJdKIYoYHlT5Dr0NEwNJmvZ5VwZv50/HV32htG yR5Wsrclrzk/1cf4drZ8ycZd0Lqbq94KqpS8bMtBgKlVn1W3+KKcCF+uokJGKLaDhIw3AXo/P6zbPG wyBtPR7RMeoUw+YKMUJcS2hXeD9ckpVLW8bMdU2mttnZ0kkd8fAw/TAG8eSi2MsHu7+EuFbob4QCpi WiOBhnAVWnzPPLW00RK64v+4zzdHuZnjcXOF1f8NmtvMQsLnRn4+JMBuhUhma3HPmZhcgKuIuMf7Td wM1wvFRQ/G24dQrIHFvS3hDYM6PKPFtIOgM1nti8EOGDXe5oYqp4ISEFX8oLYGs39QHZceolIIFvjU TNk3PjRujO8/oa5TPKcwTGN/94r+uCgMl7vKyukH/klFvBlZiywGC//it9SQ==
X-Developer-Key: i=richard@bit42.se; a=openpgp; fpr=B1C705C6B1BF719CA5CD67398BEE8379084BC511
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
v2: Rebase on v6.3-rc3

 drivers/nvmem/Kconfig       | 12 ++++++
 drivers/nvmem/Makefile      |  2 +
 drivers/nvmem/qoriq-efuse.c | 80 +++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/nvmem/qoriq-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 6dec38805041..43446e5f7d9b 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -377,4 +377,16 @@ config NVMEM_ZYNQMP
 
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
index 6a1efffa88f0..b8fdf9b51953 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -74,3 +74,5 @@ obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
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

