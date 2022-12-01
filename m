Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8A63FB26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiLAW6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiLAW5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:57:40 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8164A1B7;
        Thu,  1 Dec 2022 14:57:38 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 266CF5FD10;
        Fri,  2 Dec 2022 01:57:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669935453;
        bh=nLy/4b8i+xMemeS4hoDjkYNxHQBeN/nSL76OykbPHmM=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=RXK5VNxFeGUkUgpr/1p32w/BEOuGguD/Jkj6QIAutFore0z29ROYG48QCdgVHTy3w
         GEiFA97xM/JMM9uiq1wA7mE+Six3c4IftH8cuKhO4if13/7XEHS9sC/PVsIsb1zjNC
         0XVDuoKap+rzv/FTrHVvbmtr8Ihkraxk+bCficfezNsu3xDZMiNLKMmQjH/qN74PRw
         jknvsLUqSr0+W8UK1y/CwV32Pi03UchJ/BjjZpH6MrYSMdt49dNtG1Oxww6PnttyCW
         N8La6v4MrpzzpXRlYgt08hvCCyaUmvpNYWxmGE/4chbVSlvkgPlzhsRDAxoj0vEDXB
         ysORhjsnCjFsg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 01:57:33 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v8 06/11] clk: meson: introduce a1-clkc common driver for all A1 clock controllers
Date:   Fri, 2 Dec 2022 01:56:58 +0300
Message-ID: <20221201225703.6507-7-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/01 20:49:00 #20634374
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, A1 SoC has four clock controllers on the board: PLL,
Peripherals, CPU, and Audio. The audio clock controller is different
from others, but the rest are very similar from a functional and regmap
point of view. So a it's good idea to generalize some routines for all
of them. Exactly, meson-a1-clkc driver contains the common probe() flow.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/clk/meson/Kconfig         |  4 ++
 drivers/clk/meson/Makefile        |  1 +
 drivers/clk/meson/meson-a1-clkc.c | 63 +++++++++++++++++++++++++++++++
 drivers/clk/meson/meson-a1-clkc.h | 25 ++++++++++++
 4 files changed, 93 insertions(+)
 create mode 100644 drivers/clk/meson/meson-a1-clkc.c
 create mode 100644 drivers/clk/meson/meson-a1-clkc.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index bd44ba47200e..1c885541c3a9 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -43,6 +43,10 @@ config COMMON_CLK_MESON_CPU_DYNDIV
 	tristate
 	select COMMON_CLK_MESON_REGMAP
 
+config COMMON_CLK_MESON_A1_CLKC
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
 config COMMON_CLK_MESON8B
 	bool "Meson8 SoC Clock controller support"
 	depends on ARM
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 0e6f293c05d4..15136d861a65 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
 obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
 obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
+obj-$(CONFIG_COMMON_CLK_MESON_A1_CLKC) += meson-a1-clkc.o
 
 # Amlogic Clock controllers
 
diff --git a/drivers/clk/meson/meson-a1-clkc.c b/drivers/clk/meson/meson-a1-clkc.c
new file mode 100644
index 000000000000..2fe320a0e16e
--- /dev/null
+++ b/drivers/clk/meson/meson-a1-clkc.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Amlogic Meson-A1 Clock Controller Driver
+ *
+ * Copyright (c) 2022, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#include <linux/of_device.h>
+#include "meson-a1-clkc.h"
+
+static struct regmap_config clkc_regmap_config = {
+	.reg_bits   = 32,
+	.val_bits   = 32,
+	.reg_stride = 4,
+};
+
+int meson_a1_clkc_probe(struct platform_device *pdev)
+{
+	struct meson_a1_clkc_data *clkc;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+	struct regmap *map;
+	int clkid, i, err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return dev_err_probe(dev, -ENXIO, "can't get IO resource\n");
+
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "can't ioremap resource %pr\n", res);
+
+	map = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "can't init regmap mmio region\n");
+
+	clkc = (struct meson_a1_clkc_data *)of_device_get_match_data(dev);
+	if (!clkc)
+		return dev_err_probe(dev, -ENODEV,
+				     "can't get A1 clkc driver data\n");
+
+	/* Populate regmap for the regmap backed clocks */
+	for (i = 0; i < clkc->num_regs; i++)
+		clkc->regs[i]->map = map;
+
+	for (clkid = 0; clkid < clkc->hw->num; clkid++) {
+		err = devm_clk_hw_register(dev, clkc->hw->hws[clkid]);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "clock registration failed\n");
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   (void *)clkc->hw);
+}
+EXPORT_SYMBOL_GPL(meson_a1_clkc_probe);
+
+MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/meson-a1-clkc.h b/drivers/clk/meson/meson-a1-clkc.h
new file mode 100644
index 000000000000..503eca0f6cb5
--- /dev/null
+++ b/drivers/clk/meson/meson-a1-clkc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Amlogic Meson-A1 Clock Controller driver
+ *
+ * Copyright (c) 2022, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#ifndef __MESON_A1_CLKC_H__
+#define __MESON_A1_CLKC_H__
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "clk-regmap.h"
+
+struct meson_a1_clkc_data {
+	const struct clk_hw_onecell_data *hw;
+	struct clk_regmap *const *regs;
+	size_t num_regs;
+};
+
+int meson_a1_clkc_probe(struct platform_device *pdev);
+#endif
-- 
2.36.0

