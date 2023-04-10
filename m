Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B607D6DC441
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDJIVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDJIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:21:46 -0400
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB522105
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:21:45 -0700 (PDT)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id E13C82F5D93D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:21:43 +0200 (CEST)
Received: from s979.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id D1D0C2E27E3A;
        Mon, 10 Apr 2023 10:21:43 +0200 (CEST)
Received: from s474.loopia.se (unknown [172.22.191.6])
        by s979.loopia.se (Postfix) with ESMTP id CAC2610BC48E;
        Mon, 10 Apr 2023 10:21:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from s899.loopia.se ([172.22.191.6])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with LMTP id emeHnmFmr4ku; Mon, 10 Apr 2023 10:21:43 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: richard@bit42.se
X-Loopia-Originating-IP: 178.174.130.84
Received: from hypercube.. (h-178-174-130-84.A444.priv.bahnhof.se [178.174.130.84])
        (Authenticated sender: richard@bit42.se)
        by s899.loopia.se (Postfix) with ESMTPSA id 23BA42C8BA9A;
        Mon, 10 Apr 2023 10:21:43 +0200 (CEST)
From:   Richard Alpe <richard@bit42.se>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se,
        Richard Alpe <richard@bit42.se>
Subject: [PATCH v5 2/2] nvmem: add new NXP QorIQ eFuse driver
Date:   Mon, 10 Apr 2023 10:20:51 +0200
Message-Id: <20230410082051.2948510-2-richard@bit42.se>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410082051.2948510-1-richard@bit42.se>
References: <20230410082051.2948510-1-richard@bit42.se>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4155; h=from:subject; bh=+qAKOzP+YseS0DJfXUHuVNxeIJgGIlZKKrwySn5vQFE=; b=owEBbQKS/ZANAwAKAaR4ncy5pstaAcsmYgBkM8bihXgj51SD9+f+Di7wBKOqNtqO97XSi10HyscC UTzagHeJAjMEAAEKAB0WIQQsEvAKF4GLpV03omKkeJ3MuabLWgUCZDPG4gAKCRCkeJ3MuabLWtEiEA CIIaWL48jxcE2N0dBgr9Go1JRqCuWZf9vz0T2ZCbtutN6Vj9Pmderbj+B3vB6wax3wW7uDz3O68zps Ny+nIH4SqCOgZgCxP6LDesbF0CQsZOZWPzIUr915vRm1XhWJaaySyQuJTEWSyMwSukeEfzcCVr5nR/ muaFXkBxtLiFAMd+uG4Qa7BYpJXZvMepLNdJBAmJElxzmnJ5aF7ZzojBBfGyyvXv2H+hYpIgMsbEV8 2Bv4DeCJFVmapGTm1jWZtEeGBeaFNLuUpNHUbV3V4P6hkrL9wprHsjWV9osSrC0Bm+LKzbysQxK+8o RPab1lA+/UH6he5NmaoVKOW/apfUmQmOBbiNbL/ze6ID4GnIGgeYAdWuXU7JQVFLi3dt8SgV/zF9ZX F+2f8Q/hVRY9on1q4bwoOEKu2YGrKokQei9dL+Dg86ggCY4XUAblP6qQKYJaVcqt2posVVaSb1ebig u/pmoPNHCWQL6uYPfM8svaGoUZAOZfcjig9NmWnsm8UK5381TpzPMWs88ZvTFJyaVZL9nSFOv42gIl yljWktWCKWNDUFggGfy2CYe87Ew1SLmvftivKiri7N3C4+CoXTFH+GKTh1mNtq03JFhp8PVeUo4squ NraygGnNMGxh5FBQb2BPa7adApNjhlCM4qgLzwZJI1x8rmIozZlpVuWHr5rA==
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
v2: Rebase.
v3: Updates according to feedback from Srinivas.
v4,v5: No changes to this patch.

 drivers/nvmem/Kconfig       | 12 ++++++
 drivers/nvmem/Makefile      |  2 +
 drivers/nvmem/qoriq-efuse.c | 78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
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
index 000000000000..e7fd04d6dd94
--- /dev/null
+++ b/drivers/nvmem/qoriq-efuse.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2023  Westermo Network Technologies AB
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
+			    size_t bytes)
+{
+	struct qoriq_efuse_priv *priv = context;
+
+	/* .stride = 4 so offset is guaranteed to be aligned */
+	__ioread32_copy(val, priv->base + offset, bytes / 4);
+
+	/* Ignore trailing bytes (there shouldn't be any) */
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

