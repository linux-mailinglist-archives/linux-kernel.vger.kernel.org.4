Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5C35EF9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiI2QIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiI2QIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:08:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDDD1D263E;
        Thu, 29 Sep 2022 09:08:05 -0700 (PDT)
X-QQ-Spam: true
X-QQ-mid: bizesmtp84t1664461982tyvda2ps
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Sep 2022 22:33:00 +0800 (CST)
X-QQ-SSF: 01000000002000201000B00A0000000
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
Subject: [PATCH v1 08/30] reset: starfive: jh7100: Use regmap APIs to operate registers
Date:   Thu, 29 Sep 2022 22:32:03 +0800
Message-Id: <20220929143225.17907-9-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset registers address region is shared with clock controller
on the new StarFive JH7110 SoC. Change to use regmap framework
to allow base address sharing and preparation for JH7110 reset
support.

Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 drivers/reset/reset-starfive-jh7100.c | 61 +++++++++++++++------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/reset-starfive-jh7100.c
index a6e0945071e9..8cba62348a16 100644
--- a/drivers/reset/reset-starfive-jh7100.c
+++ b/drivers/reset/reset-starfive-jh7100.c
@@ -3,15 +3,14 @@
  * Reset driver for the StarFive JH7100 SoC
  *
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
+ * Copyright (C) 2021-2022 StarFive Technology Co., Ltd.
  */
 
-#include <linux/bitmap.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
-#include <linux/mod_devicetable.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
-#include <linux/spinlock.h>
 
 #include <dt-bindings/reset/starfive-jh7100.h>
 
@@ -49,9 +48,7 @@ static const u32 jh7100_reset_asserted[4] = {
 
 struct jh7100_reset {
 	struct reset_controller_dev rcdev;
-	/* protect registers against concurrent read-modify-write */
-	spinlock_t lock;
-	void __iomem *base;
+	struct regmap *regmap;
 };
 
 static inline struct jh7100_reset *
@@ -64,31 +61,34 @@ static int jh7100_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
 	struct jh7100_reset *data = jh7100_reset_from(rcdev);
-	unsigned long offset = id / 32;
+	u32 offset = id / 32;
 	u32 mask = BIT(id % 32);
-	void __iomem *reg_assert = data->base + JH7100_RESET_ASSERT0 + offset * sizeof(u32);
-	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u32);
+	u32 reg_assert = JH7100_RESET_ASSERT0 + offset * sizeof(u32);
+	u32 reg_status = JH7100_RESET_STATUS0 + offset * sizeof(u32);
 	u32 done = jh7100_reset_asserted[offset] & mask;
 	u32 value;
-	unsigned long flags;
 	int ret;
 
 	if (!assert)
 		done ^= mask;
 
-	spin_lock_irqsave(&data->lock, flags);
-
-	value = readl(reg_assert);
 	if (assert)
-		value |= mask;
+		ret = regmap_update_bits(data->regmap, reg_assert, mask, mask);
 	else
-		value &= ~mask;
-	writel(value, reg_assert);
+		ret = regmap_update_bits(data->regmap, reg_assert, mask, 0);
+
+	if (ret)
+		return ret;
 
 	/* if the associated clock is gated, deasserting might otherwise hang forever */
-	ret = readl_poll_timeout_atomic(reg_status, value, (value & mask) == done, 0, 1000);
+	ret = regmap_read_poll_timeout_atomic(data->regmap,
+					      reg_status,
+					      value, (value & mask) == done,
+					      0, 1000);
+	if (ret)
+		dev_warn(rcdev->dev, "id:%ld bank:%d, mask:%#x assert:%#x status:%#x ret:%d\n",
+			 id, offset, mask, reg_assert, reg_status, ret);
 
-	spin_unlock_irqrestore(&data->lock, flags);
 	return ret;
 }
 
@@ -120,10 +120,15 @@ static int jh7100_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
 	struct jh7100_reset *data = jh7100_reset_from(rcdev);
-	unsigned long offset = id / 32;
+	u32 offset = id / 32;
 	u32 mask = BIT(id % 32);
-	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u32);
-	u32 value = readl(reg_status);
+	u32 reg_status = JH7100_RESET_STATUS0 + offset * sizeof(u32);
+	u32 value;
+	int ret;
+
+	ret = regmap_read(data->regmap, reg_status, &value);
+	if (ret)
+		return ret;
 
 	return !((value ^ jh7100_reset_asserted[offset]) & mask);
 }
@@ -143,16 +148,18 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->base))
-		return PTR_ERR(data->base);
+	data->regmap = device_node_to_regmap(pdev->dev.of_node);
+	if (IS_ERR(data->regmap)) {
+		dev_err(&pdev->dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(data->regmap));
+		return PTR_ERR(data->regmap);
+	}
 
 	data->rcdev.ops = &jh7100_reset_ops;
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.nr_resets = JH7100_RSTN_END;
 	data->rcdev.dev = &pdev->dev;
 	data->rcdev.of_node = pdev->dev.of_node;
-	spin_lock_init(&data->lock);
 
 	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
 }
-- 
2.17.1

