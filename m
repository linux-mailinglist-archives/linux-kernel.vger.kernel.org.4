Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4453F635B86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiKWLXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiKWLXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:23:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4BB74CF6;
        Wed, 23 Nov 2022 03:23:01 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C0796602ACF;
        Wed, 23 Nov 2022 11:22:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669202580;
        bh=EJD6I92pNgZOKf1m2pbzHsK9AlMSapcDK1LvROWOq0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ya21qjtuxUFM+5FEgG20Rs6g74UDEH3ts3Hd60N6n3REVkhXycLdCqILmpfeK8W1F
         lKc4T8aRIy1/X9JII8eIcGTiAEqYI2l0ifDIoTc95P7m7uU2YrUzdvLmGdXlsVNefS
         Eq8AP362tyBB2/8QMqcRi4v/v4gjsO13RLL1UWfBDqOMlc6/XlI4zyeZSopCYt//8G
         5X+PFZ4e6i890DkG8CFKynvsSopdp90/A5UHo6SJp5xNZgxNM2Ke4ncVfcE36N36Vk
         RZcqnHk8XoXkaEle5+CIUnJWraO6bVeCpQSWQ6HNX8YW09PEWdIMAZ678OguNKv2F8
         F6ZNlwY1AYnfA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 3/4] irqchip: irq-mtk-cirq: Move register offsets to const array
Date:   Wed, 23 Nov 2022 12:22:48 +0100
Message-Id: <20221123112249.98281-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
References: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add support for new SoCs having a different
register layout, add an enumeration that documents register
offsets and move the definitions for the same to a u32 array;

Selecting the right register offsets array is done by adding an
of_device_id array containing all of the currently supported
compatible strings pointing to the "v1" offsets array (as data):
since no devicetree declares the `mediatek,mtk-cirq` compatible
without a SoC-specific one, it wasn't necessary to provide any
legacy fallback.

Every usage of the aforemementioned definitions was changed to
get a register address through a newly introduced `mtk_cirq_reg()`
accessor.

This change brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/irqchip/irq-mtk-cirq.c | 78 ++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 9bca0918078e..4d873d2ba0fd 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -15,14 +15,29 @@
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 
-#define CIRQ_ACK	0x40
-#define CIRQ_MASK_SET	0xc0
-#define CIRQ_MASK_CLR	0x100
-#define CIRQ_SENS_SET	0x180
-#define CIRQ_SENS_CLR	0x1c0
-#define CIRQ_POL_SET	0x240
-#define CIRQ_POL_CLR	0x280
-#define CIRQ_CONTROL	0x300
+enum mtk_cirq_reg_index {
+	CIRQ_STA,
+	CIRQ_ACK,
+	CIRQ_MASK_SET,
+	CIRQ_MASK_CLR,
+	CIRQ_SENS_SET,
+	CIRQ_SENS_CLR,
+	CIRQ_POL_SET,
+	CIRQ_POL_CLR,
+	CIRQ_CONTROL
+};
+
+static const u32 mtk_cirq_regs_v1[] = {
+	[CIRQ_STA]	= 0x0,
+	[CIRQ_ACK]	= 0x40,
+	[CIRQ_MASK_SET]	= 0xc0,
+	[CIRQ_MASK_CLR]	= 0x100,
+	[CIRQ_SENS_SET]	= 0x180,
+	[CIRQ_SENS_CLR]	= 0x1c0,
+	[CIRQ_POL_SET]	= 0x240,
+	[CIRQ_POL_CLR]	= 0x280,
+	[CIRQ_CONTROL]	= 0x300,
+};
 
 #define CIRQ_EN	0x1
 #define CIRQ_EDGE	0x2
@@ -32,18 +47,28 @@ struct mtk_cirq_chip_data {
 	void __iomem *base;
 	unsigned int ext_irq_start;
 	unsigned int ext_irq_end;
+	const u32 *offsets;
 	struct irq_domain *domain;
 };
 
 static struct mtk_cirq_chip_data *cirq_data;
 
-static void mtk_cirq_write_mask(struct irq_data *data, unsigned int offset)
+static inline void __iomem *mtk_cirq_reg(struct mtk_cirq_chip_data *chip_data,
+					 enum mtk_cirq_reg_index idx,
+					 unsigned int cirq_num)
+{
+	void __iomem *reg = chip_data->base + chip_data->offsets[idx];
+
+	return reg + (cirq_num / 32) * 4;
+}
+
+static void mtk_cirq_write_mask(struct irq_data *data, enum mtk_cirq_reg_index idx)
 {
 	struct mtk_cirq_chip_data *chip_data = data->chip_data;
 	unsigned int cirq_num = data->hwirq;
 	u32 mask = 1 << (cirq_num % 32);
 
-	writel_relaxed(mask, chip_data->base + offset + (cirq_num / 32) * 4);
+	writel_relaxed(mask, mtk_cirq_reg(chip_data, idx, cirq_num));
 }
 
 static void mtk_cirq_mask(struct irq_data *data)
@@ -160,6 +185,7 @@ static const struct irq_domain_ops cirq_domain_ops = {
 #ifdef CONFIG_PM_SLEEP
 static int mtk_cirq_suspend(void)
 {
+	void __iomem *reg;
 	u32 value, mask;
 	unsigned int irq, hwirq_num;
 	bool pending, masked;
@@ -200,31 +226,34 @@ static int mtk_cirq_suspend(void)
 				continue;
 		}
 
+		reg = mtk_cirq_reg(cirq_data, CIRQ_ACK, i);
 		mask = 1 << (i % 32);
-		writel_relaxed(mask, cirq_data->base + CIRQ_ACK + (i / 32) * 4);
+		writel_relaxed(mask, reg);
 	}
 
 	/* set edge_only mode, record edge-triggerd interrupts */
 	/* enable cirq */
-	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
+	reg = mtk_cirq_reg(cirq_data, CIRQ_CONTROL, 0);
+	value = readl_relaxed(reg);
 	value |= (CIRQ_EDGE | CIRQ_EN);
-	writel_relaxed(value, cirq_data->base + CIRQ_CONTROL);
+	writel_relaxed(value, reg);
 
 	return 0;
 }
 
 static void mtk_cirq_resume(void)
 {
+	void __iomem *reg = mtk_cirq_reg(cirq_data, CIRQ_CONTROL, 0);
 	u32 value;
 
 	/* flush recorded interrupts, will send signals to parent controller */
-	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
-	writel_relaxed(value | CIRQ_FLUSH, cirq_data->base + CIRQ_CONTROL);
+	value = readl_relaxed(reg);
+	writel_relaxed(value | CIRQ_FLUSH, reg);
 
 	/* disable cirq */
-	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
+	value = readl_relaxed(reg);
 	value &= ~(CIRQ_EDGE | CIRQ_EN);
-	writel_relaxed(value, cirq_data->base + CIRQ_CONTROL);
+	writel_relaxed(value, reg);
 }
 
 static struct syscore_ops mtk_cirq_syscore_ops = {
@@ -240,10 +269,18 @@ static void mtk_cirq_syscore_init(void)
 static inline void mtk_cirq_syscore_init(void) {}
 #endif
 
+static const struct of_device_id mtk_cirq_of_match[] = {
+	{ .compatible = "mediatek,mt2701-cirq", .data = &mtk_cirq_regs_v1 },
+	{ .compatible = "mediatek,mt8135-cirq", .data = &mtk_cirq_regs_v1 },
+	{ .compatible = "mediatek,mt8173-cirq", .data = &mtk_cirq_regs_v1 },
+	{ /* sentinel */ }
+};
+
 static int __init mtk_cirq_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
 	struct irq_domain *domain, *domain_parent;
+	const struct of_device_id *match;
 	unsigned int irq_num;
 	int ret;
 
@@ -274,6 +311,13 @@ static int __init mtk_cirq_of_init(struct device_node *node,
 	if (ret)
 		goto out_unmap;
 
+	match = of_match_node(mtk_cirq_of_match, node);
+	if (!match) {
+		ret = -ENODEV;
+		goto out_unmap;
+	}
+	cirq_data->offsets = match->data;
+
 	irq_num = cirq_data->ext_irq_end - cirq_data->ext_irq_start + 1;
 	domain = irq_domain_add_hierarchy(domain_parent, 0,
 					  irq_num, node,
-- 
2.38.1

