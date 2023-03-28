Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A496CB95E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC1I2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjC1I2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:28:07 -0400
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA744AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:28:04 -0700 (PDT)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 923E22F89644
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:28:02 +0200 (CEST)
Received: from s980.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 8247A2E2820E;
        Tue, 28 Mar 2023 10:28:02 +0200 (CEST)
Received: from s475.loopia.se (unknown [172.22.191.6])
        by s980.loopia.se (Postfix) with ESMTP id 7E5112201648;
        Tue, 28 Mar 2023 10:28:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from s980.loopia.se ([172.22.191.6])
        by s475.loopia.se (s475.loopia.se [172.22.190.15]) (amavisd-new, port 10024)
        with LMTP id Zf94KCPoZP9I; Tue, 28 Mar 2023 10:28:02 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: richard@bit42.se
X-Loopia-Originating-IP: 178.174.130.84
Received: from hypercube.. (h-178-174-130-84.A444.priv.bahnhof.se [178.174.130.84])
        (Authenticated sender: richard@bit42.se)
        by s980.loopia.se (Postfix) with ESMTPSA id BA9E6220163E;
        Tue, 28 Mar 2023 10:28:01 +0200 (CEST)
From:   Richard Alpe <richard@bit42.se>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se,
        Richard Alpe <richard@bit42.se>
Subject: [PATCH v3 2/2] nvmem: add new NXP QorIQ eFuse driver
Date:   Tue, 28 Mar 2023 10:27:01 +0200
Message-Id: <20230328082701.2569114-2-richard@bit42.se>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328082701.2569114-1-richard@bit42.se>
References: <20230328082701.2569114-1-richard@bit42.se>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4056; h=from:subject; bh=lsmAMDFDlyAqV1bBxMUumsKynjlY5dnrw1I/LcNTglg=; b=owEBbQKS/ZANAwAKAaR4ncy5pstaAcsmYgBkIqTUYLuMZaRJcvvs9iJJ/S8GMiewSpGk5XGLrNks 9gXzm8WJAjMEAAEKAB0WIQQsEvAKF4GLpV03omKkeJ3MuabLWgUCZCKk1AAKCRCkeJ3MuabLWudKEA CgIU5Z7VAIt2MZce8y4HpH+nxkyJsbC2/DW2h9dX6dQDMmZyiAzPnt/peBnkHpESCeBlBGpmmkpjnH peGNDQTncO3Lq7FK6HfffmQ4n/Fly7F+2TjzmTg1IkBNW8yJ8H9CeiTK14iX2de9EKhQGzO+3jRk7U fPFO13Sf6kKJcfCpjpEd0mMFiBkPBGFKerWY+yJRStDQ7/bdzDh1VFftttPFDVmWOBlR9gejd7vrP4 acMYRTyB8SZ18tjWvs0gccU0BGYXyvG9UyVqAi5gFPAvDF0MP3cbXFQqL+wtnMMD3o+YUdrKrXokhE y0YITzjUj9fXp1jY7CwZwkFxyMAxKOKSFYATROL8/35CDZjiswWx+Ohg55Hho85eKYlTwaJZadUs1O VkWBeiiG7LNOqeHv1MroSa5D/Z96ssT66sqncWVqcl7gC6EgVW8sC1hvq1a1psC+pqQ+aCfmUoykcu ZPwzLOdk112EHrI5KZtg+QeVv2ApP+ODembzPNbKu1MkpVcxHnsJB5eVr1jbS73XAAqmp78DwNuXK6 gHW+bZzy+j6YlzCHx3yDGgBCA6BnqBNEqgOl4T7xKVqlIfdmxCasrJW/qumh/msnFNHL5BWO+f2Y4t 6NIkgdhBB5DvRqM0m4jSD21rSWOuymJ8SiTEGfzhciK7Qn7AUeyUvFs0O8Fw==
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

