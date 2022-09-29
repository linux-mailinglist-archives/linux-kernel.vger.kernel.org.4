Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB84F5EF7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiI2OiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiI2OiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:38:05 -0400
X-Greylist: delayed 295 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 07:38:02 PDT
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876391BF0C1;
        Thu, 29 Sep 2022 07:38:01 -0700 (PDT)
X-QQ-mid: bizesmtp84t1664461971t2352kc1
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Sep 2022 22:32:49 +0800 (CST)
X-QQ-SSF: 01000000002000201000B00A0000000
X-QQ-FEAT: SFhf6fKhx/8oAqA+xXX7FIVEvIELHkN73OBy0+rHEEM2lFkxEFVw5OIBn4NmG
        2zDsWQpDLqeK++KqYzu5fbIviEMo2hnt3AAY5wVHQHp1Ezfci+CFIB8IDyJWeb8lGNJ9YSF
        D1UEr6wFRaF0VxgMrprepY9D14HFi92e8vcfjNOdEYqSQqF4yriv5Y6PEzn+zYi81LAu2D/
        zmdbOxlZRFTddhT4YHMmWL2qg/IL6x9MwR5eHKO4dxr1VrOO9r/nlzkfQnbfw//xfjs0Bao
        sfgCDyELD2lB7rZyYQkD6BxklUKOsR2zGf9SznLGPfzgidGCV5U7Pax+rBuWV1smgq6JvRH
        Gmns7JGqiXyZydixwie0nY3I/u3MnKdYSAi1tcl+lkx4mpPogqxHbJGJwrfu5NubOu0PXrU
        ouW/Js4BAA+Ew/vQDQNfr3AihJ8ZUEUG
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/30] soc: sifive: l2 cache: Convert to platform driver
Date:   Thu, 29 Sep 2022 22:32:00 +0800
Message-Id: <20220929143225.17907-6-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

This converts the driver to use the builtin_platform_driver_probe macro
to initialize the driver. This macro ends up calling device_initcall as
was used previously, but also allocates a platform device which gives us
access to much nicer APIs such as platform_ioremap_resource,
platform_get_irq and dev_err_probe.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 drivers/soc/sifive/sifive_l2_cache.c | 79 ++++++++++++++--------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index 59640a1d0b28..010d612f7420 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -7,9 +7,9 @@
  */
 #include <linux/debugfs.h>
 #include <linux/interrupt.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <asm/cacheinfo.h>
 #include <soc/sifive/sifive_l2_cache.h>
 
@@ -96,12 +96,6 @@ static void l2_config_read(void)
 	pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
 }
 
-static const struct of_device_id sifive_l2_ids[] = {
-	{ .compatible = "sifive,fu540-c000-ccache" },
-	{ .compatible = "sifive,fu740-c000-ccache" },
-	{ /* end of table */ },
-};
-
 static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
 
 int register_sifive_l2_error_notifier(struct notifier_block *nb)
@@ -192,36 +186,29 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 	return IRQ_HANDLED;
 }
 
-static int __init sifive_l2_init(void)
+static int __init sifive_l2_probe(struct platform_device *pdev)
 {
-	struct device_node *np;
-	struct resource res;
-	int i, rc, intr_num;
-
-	np = of_find_matching_node(NULL, sifive_l2_ids);
-	if (!np)
-		return -ENODEV;
-
-	if (of_address_to_resource(np, 0, &res))
-		return -ENODEV;
-
-	l2_base = ioremap(res.start, resource_size(&res));
-	if (!l2_base)
-		return -ENOMEM;
-
-	intr_num = of_property_count_u32_elems(np, "interrupts");
-	if (!intr_num) {
-		pr_err("L2CACHE: no interrupts property\n");
-		return -ENODEV;
-	}
-
-	for (i = 0; i < intr_num; i++) {
-		g_irq[i] = irq_of_parse_and_map(np, i);
-		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
-		if (rc) {
-			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
-			return rc;
-		}
+	struct device *dev = &pdev->dev;
+	int nirqs;
+	int ret;
+	int i;
+
+	l2_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(l2_base))
+		return PTR_ERR(l2_base);
+
+	nirqs = platform_irq_count(pdev);
+	if (nirqs <= 0)
+		return dev_err_probe(dev, -ENODEV, "no interrupts\n");
+
+	for (i = 0; i < nirqs; i++) {
+		g_irq[i] = platform_get_irq(pdev, i);
+		if (g_irq[i] < 0)
+			return g_irq[i];
+
+		ret = devm_request_irq(dev, g_irq[i], l2_int_handler, 0, pdev->name, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "Could not request IRQ %d\n", g_irq[i]);
 	}
 
 	l2_config_read();
@@ -234,4 +221,18 @@ static int __init sifive_l2_init(void)
 #endif
 	return 0;
 }
-device_initcall(sifive_l2_init);
+
+static const struct of_device_id sifive_l2_match[] = {
+	{ .compatible = "sifive,fu540-c000-ccache" },
+	{ .compatible = "sifive,fu740-c000-ccache" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver sifive_l2_driver = {
+	.driver = {
+		.name = "sifive_l2_cache",
+		.of_match_table = sifive_l2_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(sifive_l2_driver, sifive_l2_probe);
-- 
2.17.1

