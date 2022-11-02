Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C18615B3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKBDzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiKBDzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:55:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CDDD27161;
        Tue,  1 Nov 2022 20:55:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Cxrrcs6mFjhu4DAA--.9095S3;
        Wed, 02 Nov 2022 11:55:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxd1cl6mFjHqgJAA--.11222S2;
        Wed, 02 Nov 2022 11:55:22 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v4 1/2] soc: loongson: add GUTS driver for loongson-2 platforms
Date:   Wed,  2 Nov 2022 11:55:10 +0800
Message-Id: <20221102035511.19972-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxd1cl6mFjHqgJAA--.11222S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3AF4xKw1kuFWUuw1UKFyDKFg_yoWfCw47pa
        1fC34rGrWUJF45urs8Ja48uFyY9a4xCasruF4Igwn8ur97A34UXas7JFyUZrs7ArykAw12
        qF95GayjkFWUAaDanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r1q6r43M2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28Icx
        kI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7
        JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0pMKJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global utilities block controls PCIE device enabling, alternate
function selection for multiplexed signals, consistency of HDA, USB
and PCIE, configuration of memory controller, rtc controller, lio
controller, and clock control.

This patch adds a driver to manage and access global utilities block
for loongarch architecture Loongson-2 SoCs. Initially only reading SVR
and registering soc device are supported. Other guts accesses, such
as reading PMON configuration by default, should eventually be added
into this driver as well.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v4:
		1. Remove menu information in Kconfig.

 MAINTAINERS                           |   6 +
 drivers/soc/Kconfig                   |   1 +
 drivers/soc/Makefile                  |   1 +
 drivers/soc/loongson/Kconfig          |  18 +++
 drivers/soc/loongson/Makefile         |   6 +
 drivers/soc/loongson/loongson2_guts.c | 189 ++++++++++++++++++++++++++
 6 files changed, 221 insertions(+)
 create mode 100644 drivers/soc/loongson/Kconfig
 create mode 100644 drivers/soc/loongson/Makefile
 create mode 100644 drivers/soc/loongson/loongson2_guts.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c9dc5ddbd9fe..20ce056ae207 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12041,6 +12041,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
 F:	drivers/pinctrl/pinctrl-loongson2.c
 
+LOONGSON-2 SOC SERIES GUTS DRIVER
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	loongarch@lists.linux.dev
+S:	Maintained
+F:	drivers/soc/loongson/loongson2_guts.c
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index e461c071189b..5dbb09f843f7 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -13,6 +13,7 @@ source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
+source "drivers/soc/loongson/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/microchip/Kconfig"
 source "drivers/soc/pxa/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 69ba6508cf2c..fff513bd522d 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -18,6 +18,7 @@ obj-y				+= imx/
 obj-y				+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
+obj-y				+= loongson/
 obj-y				+= mediatek/
 obj-y				+= microchip/
 obj-y				+= pxa/
diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
new file mode 100644
index 000000000000..c60119b9d247
--- /dev/null
+++ b/drivers/soc/loongson/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Loongson-2 series SoC drivers
+#
+
+config LOONGSON2_GUTS
+	tristate "Loongson-2 GUTS"
+	depends on LOONGARCH || COMPILE_TEST
+	select SOC_BUS
+	help
+	  The global utilities block controls PCIE device enabling, alternate
+	  function selection for multiplexed signals, consistency of HDA, USB
+	  and PCIE, configuration of memory controller, rtc controller, lio
+	  controller, and clock control. This patch adds a driver to manage
+	  and access global utilities block for loongarch architecture Loongson-2
+	  SoCs. Initially only reading SVR and registering soc device are
+	  supported. Other guts accesses, such as reading PMON configuration by
+	  default, should eventually be added into this driver as well.
diff --git a/drivers/soc/loongson/Makefile b/drivers/soc/loongson/Makefile
new file mode 100644
index 000000000000..263c486df638
--- /dev/null
+++ b/drivers/soc/loongson/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Makefile for the Linux Kernel SoC Loongson-2 specific device drivers
+#
+
+obj-$(CONFIG_LOONGSON2_GUTS)		+= loongson2_guts.o
diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
new file mode 100644
index 000000000000..8f3d5465c7e8
--- /dev/null
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
+ * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/of_fdt.h>
+#include <linux/sys_soc.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+static struct soc_device_attribute soc_dev_attr;
+static struct soc_device *soc_dev;
+
+/*
+ * Global Utility Registers.
+ *
+ * Not all registers defined in this structure are available on all chips, so
+ * you are expected to know whether a given register actually exists on your
+ * chip before you access it.
+ *
+ * Also, some registers are similar on different chips but have slightly
+ * different names.  In these cases, one name is chosen to avoid extraneous
+ * #ifdefs.
+ */
+struct scfg_guts {
+	u32     svr;            /* Version Register */
+	u8      res0[4];
+	u16     feature;        /* Feature Register */
+	u32     vendor;         /* Vendor Register */
+	u8      res1[6];
+	u32     id;
+	u8      res2[0x3ff8 - 0x18];
+	u32     chip;
+};
+
+static struct guts {
+	struct scfg_guts __iomem *regs;
+	bool little_endian;
+} *guts;
+
+struct loongson2_soc_die_attr {
+	char	*die;
+	u32	svr;
+	u32	mask;
+};
+
+/* SoC die attribute definition for Loongson-2 platform */
+static const struct loongson2_soc_die_attr loongson2_soc_die[] = {
+
+	/*
+	 * LA-based SoCs Loongson-2 Series
+	 */
+
+	/* Die: 2k1000la, SoC: 2k1000la */
+	{ .die		= "2K1000LA",
+	  .svr		= 0x00000013,
+	  .mask		= 0x000000ff,
+	},
+	{ },
+};
+
+static const struct loongson2_soc_die_attr *loongson2_soc_die_match(
+	u32 svr, const struct loongson2_soc_die_attr *matches)
+{
+	while (matches->svr) {
+		if (matches->svr == (svr & matches->mask))
+			return matches;
+		matches++;
+	};
+
+	return NULL;
+}
+
+static u32 loongson2_guts_get_svr(void)
+{
+	u32 svr = 0;
+
+	if (!guts || !guts->regs)
+		return svr;
+
+	if (guts->little_endian)
+		svr = ioread32(&guts->regs->svr);
+	else
+		svr = ioread32be(&guts->regs->svr);
+
+	return svr;
+}
+
+static int loongson2_guts_probe(struct platform_device *pdev)
+{
+	struct device_node *root, *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	const struct loongson2_soc_die_attr *soc_die;
+	const char *machine;
+	u32 svr;
+
+	/* Initialize guts */
+	guts = devm_kzalloc(dev, sizeof(*guts), GFP_KERNEL);
+	if (!guts)
+		return -ENOMEM;
+
+	guts->little_endian = of_property_read_bool(np, "little-endian");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	guts->regs = ioremap(res->start, res->end - res->start + 1);
+	if (IS_ERR(guts->regs))
+		return PTR_ERR(guts->regs);
+
+	/* Register soc device */
+	root = of_find_node_by_path("/");
+	if (of_property_read_string(root, "model", &machine))
+		of_property_read_string_index(root, "compatible", 0, &machine);
+	of_node_put(root);
+	if (machine)
+		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+
+	svr = loongson2_guts_get_svr();
+	soc_die = loongson2_soc_die_match(svr, loongson2_soc_die);
+	if (soc_die) {
+		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL,
+						     "Loongson %s", soc_die->die);
+	} else {
+		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL, "Loongson");
+	}
+	if (!soc_dev_attr.family)
+		return -ENOMEM;
+	soc_dev_attr.soc_id = devm_kasprintf(dev, GFP_KERNEL,
+					     "svr:0x%08x", svr);
+	if (!soc_dev_attr.soc_id)
+		return -ENOMEM;
+	soc_dev_attr.revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
+					       (svr >>  4) & 0xf, svr & 0xf);
+	if (!soc_dev_attr.revision)
+		return -ENOMEM;
+
+	soc_dev = soc_device_register(&soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	pr_info("Machine: %s\n", soc_dev_attr.machine);
+	pr_info("SoC family: %s\n", soc_dev_attr.family);
+	pr_info("SoC ID: %s, Revision: %s\n",
+		soc_dev_attr.soc_id, soc_dev_attr.revision);
+
+	return 0;
+}
+
+static int loongson2_guts_remove(struct platform_device *dev)
+{
+	soc_device_unregister(soc_dev);
+
+	return 0;
+}
+
+/*
+ * Table for matching compatible strings, for device tree
+ * guts node, for Loongson-2 SoCs.
+ */
+static const struct of_device_id loongson2_guts_of_match[] = {
+	{ .compatible = "loongson,ls2k-chipid", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, loongson2_guts_of_match);
+
+static struct platform_driver loongson2_guts_driver = {
+	.driver = {
+		.name = "loongson2-guts",
+		.of_match_table = loongson2_guts_of_match,
+	},
+	.probe = loongson2_guts_probe,
+	.remove = loongson2_guts_remove,
+};
+
+static int __init loongson2_guts_init(void)
+{
+	return platform_driver_register(&loongson2_guts_driver);
+}
+core_initcall(loongson2_guts_init);
+
+static void __exit loongson2_guts_exit(void)
+{
+	platform_driver_unregister(&loongson2_guts_driver);
+}
+module_exit(loongson2_guts_exit);
-- 
2.33.0

