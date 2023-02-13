Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3D694500
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBMMAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBMMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:00:08 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB76118AA6;
        Mon, 13 Feb 2023 04:00:04 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31DBxwCZ124580;
        Mon, 13 Feb 2023 05:59:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676289598;
        bh=+HZAOdrDmkXz7cerDG2MTsBjz2lXq2xdUsMnIIjLfRM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iVKcruqycmOrnZvhKu+jV8pRCGdy2cZMfN5SS85bBP0a6vffik3KFKFzRXLjX2rno
         VhOV07vIp327qSkQwC63dRxSkzDCpmY8yKlYNqrHpQcs9Iee+qB0IyI0MJ9pRSmEZp
         dIiibafHJ9RM0A+R/r5DZLBLI5ZdYYSk51MVDn7Q=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31DBxwQa021365
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Feb 2023 05:59:58 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Feb 2023 05:59:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Feb 2023 05:59:58 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31DBxvfa056766;
        Mon, 13 Feb 2023 05:59:57 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v2 2/2] clk: keystone: Add support AM62 DSS clock divider
Date:   Mon, 13 Feb 2023 17:29:54 +0530
Message-ID: <20230213115954.553-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213115954.553-1-a-bhatia1@ti.com>
References: <20230213115954.553-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TI's AM62 Family of SoCs, the pixel frequency of the DSS Video Port 0
comes from a by-7 clock divider. This is done to support the clock for
OLDI transmitters that need serial clock 7 times the pixel frequency.

A clock set request on this clock, is forwarded to its parent clock by
default, using the SET_RATE_PARENT flag. The PLL (in this case the
parent) generates serial clock for OLDI, which is then also fed to DSS
using this clock divider.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/clk/keystone/Kconfig        |   9 ++
 drivers/clk/keystone/Makefile       |   1 +
 drivers/clk/keystone/clk-am62-dss.c | 164 ++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/keystone/clk-am62-dss.c

diff --git a/drivers/clk/keystone/Kconfig b/drivers/clk/keystone/Kconfig
index e64d6726048f..543314ddfd2c 100644
--- a/drivers/clk/keystone/Kconfig
+++ b/drivers/clk/keystone/Kconfig
@@ -34,3 +34,12 @@ config TI_SYSCON_CLK
 	help
 	  This adds clock driver support for syscon based gate
 	  clocks on TI's K2 and K3 SoCs.
+
+config TI_AM62_DSS_CLK
+	tristate "Clock Divider for DSS VP0 of AM62 Family of SoCs"
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+	default TI_SCI_CLK
+	help
+	  This adds clock divider driver support for Video Port 0 of Display
+	  SubSystems (DSS) under AM62 Family of SoCs. This clock divider
+	  forwards a seventh (1/7) of the incoming clock.
diff --git a/drivers/clk/keystone/Makefile b/drivers/clk/keystone/Makefile
index 0e426e648f7c..3a683d622a60 100644
--- a/drivers/clk/keystone/Makefile
+++ b/drivers/clk/keystone/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= pll.o gate.o
 obj-$(CONFIG_TI_SCI_CLK)		+= sci-clk.o
 obj-$(CONFIG_TI_SYSCON_CLK)		+= syscon-clk.o
+obj-$(CONFIG_TI_AM62_DSS_CLK)		+= clk-am62-dss.o
diff --git a/drivers/clk/keystone/clk-am62-dss.c b/drivers/clk/keystone/clk-am62-dss.c
new file mode 100644
index 000000000000..2c9fc4bc89e3
--- /dev/null
+++ b/drivers/clk/keystone/clk-am62-dss.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+#include <linux/module.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+struct ti_am62_dss_clk {
+	struct clk_hw	hw;
+	unsigned int	div;
+};
+
+#define to_ti_am62_dss_clk(_hw) \
+	container_of(_hw, struct ti_am62_dss_clk, hw)
+
+static unsigned long ti_am62_dss_clk_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct ti_am62_dss_clk *priv = to_ti_am62_dss_clk(hw);
+	unsigned long rate;
+
+	rate = parent_rate;
+	do_div(rate, priv->div);
+	return (unsigned long)rate;
+}
+
+static long ti_am62_dss_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	struct ti_am62_dss_clk *priv = to_ti_am62_dss_clk(hw);
+
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+		unsigned long best_parent;
+
+		best_parent = rate * priv->div;
+		*prate = clk_hw_round_rate(clk_hw_get_parent(hw), best_parent);
+	}
+
+	return (*prate / priv->div);
+}
+
+static int ti_am62_dss_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	/*
+	 * We must report success but we can do so unconditionally because
+	 * ti_am62_dss_clk_round_rate returns values that ensure this call is a
+	 * nop.
+	 */
+
+	return 0;
+}
+
+static const struct clk_ops ti_am62_dss_clk_ops = {
+	.round_rate = ti_am62_dss_clk_round_rate,
+	.set_rate = ti_am62_dss_clk_set_rate,
+	.recalc_rate = ti_am62_dss_clk_recalc_rate,
+};
+
+static struct clk_hw *
+clk_hw_register_am62_dss_clk(struct device *dev, const char *name,
+			     unsigned long flags, unsigned int div)
+{
+	struct ti_am62_dss_clk *priv;
+	struct clk_init_data init = { };
+	struct clk_parent_data pdata = { .index = 0 };
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	/* struct ti_am62_dss_clk assignments */
+	priv->div = div;
+	priv->hw.init = &init;
+
+	init.name = name;
+	init.ops = &ti_am62_dss_clk_ops;
+	init.flags = flags;
+	init.parent_names = NULL;
+	init.parent_data = &pdata;
+	init.num_parents = 1;
+
+	ret = devm_clk_hw_register(dev, &priv->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &priv->hw;
+}
+
+static void clk_hw_unregister_am62_dss_clk(struct clk_hw *hw)
+{
+	struct ti_am62_dss_clk *priv;
+
+	priv = to_ti_am62_dss_clk(hw);
+
+	clk_hw_unregister(hw);
+	kfree(priv);
+}
+
+static int ti_am62_dss_clk_remove(struct platform_device *pdev)
+{
+	struct clk_hw *hw = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+	clk_hw_unregister_am62_dss_clk(hw);
+
+	return 0;
+}
+
+static int ti_am62_dss_clk_probe(struct platform_device *pdev)
+{
+	struct clk_hw *hw;
+	const char *clk_name = pdev->name;
+	struct device *dev = &pdev->dev;
+	unsigned long flags = 0;
+	u32 div;
+	int ret;
+
+	if (of_property_read_u32(dev->of_node, "clock-div", &div)) {
+		dev_err(dev, "%s: TI AM62 DSS clock must have a clock-div property.\n",
+			__func__);
+		return -EIO;
+	}
+
+	flags |= CLK_SET_RATE_PARENT;
+
+	hw = clk_hw_register_am62_dss_clk(dev, clk_name, flags, div);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "%s: failed to register %s\n", __func__, clk_name);
+		return PTR_ERR(hw);
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+	if (ret) {
+		clk_hw_unregister_am62_dss_clk(hw);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, hw);
+
+	return 0;
+}
+
+static const struct of_device_id ti_am62_dss_clk_ids[] = {
+	{ .compatible = "ti,am62-dss-vp0-div-clk" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_am62_dss_clk_ids);
+
+static struct platform_driver ti_am62_dss_clk_driver = {
+	.driver = {
+		.name = "ti_am62_dss_clk",
+		.of_match_table = ti_am62_dss_clk_ids,
+	},
+	.probe = ti_am62_dss_clk_probe,
+	.remove = ti_am62_dss_clk_remove,
+};
+module_platform_driver(ti_am62_dss_clk_driver);
+
+MODULE_AUTHOR("Aradhya Bhatia <a-bhatia1@ti.com>");
+MODULE_DESCRIPTION("TI AM62 DSS - OLDI Fixed Clock Divider driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

