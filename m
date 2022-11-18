Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2762F21B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbiKRKHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241575AbiKRKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:06:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9F28FB22;
        Fri, 18 Nov 2022 02:06:52 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C7A2E6602AAC;
        Fri, 18 Nov 2022 10:06:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668766011;
        bh=QOSVYgDuSw/AruRHLOIb5Uuh3Eeoa+7i4jEcJJGvLBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4wbd56N6eNhgpRE/cIv/WyvGs2aus9tBoIJQJqYjXuYM4oh0pMn51GNrgIAKwbYJ
         7sLM+S6q5JVe/1Dlx1627E5OUH8Akl0YgrSkm8Ky0MzIfDU41puH3iKP+FrDKtqb7k
         bdk5Szb/jdtgReOvr0mYGORtx0WONiUMt3vQVu1KXGXcTzOYbAhKjTu5zI9OBTVIHI
         H4khL6BEqfKADgALCBlpUcQ80sBtxKa1oFc2LUofjlgL0ZCW1InkRc4oGw9Z4ZW1Gt
         fAvfzRJ1xHqapMi0BhsDZx9no9PLKaD8DgZlRbptNPEBEBRaGNBNvkoV7wesd9KTuR
         KRdC2EAWUDfFA==
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
Subject: [PATCH v1 4/4] irqchip: irq-mtk-cirq: Add support for System CIRQ on MT8192
Date:   Fri, 18 Nov 2022 11:06:39 +0100
Message-Id: <20221118100639.33704-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118100639.33704-1-angelogioacchino.delregno@collabora.com>
References: <20221118100639.33704-1-angelogioacchino.delregno@collabora.com>
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

On some SoCs the System CIRQ register layout is slightly different,
as there are more registers per function and in some cases other
differences later in the layout: this is seen on at least MT8192,
but it's also valid for some other "contemporary" SoCs both for
Chromebooks and for smartphones.

Add the new "v2" register layout and use it if the compatible
"mediatek,mt8192-cirq" is found; to retain compatibility with
older devicetrees and/or with SoCs that don't need any register
layout variation, if no "special" compatible is found, we use
the "v1" register layout by default.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/irqchip/irq-mtk-cirq.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index affbc0f48550..8d6b3d9c40cf 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -40,6 +40,18 @@ static const u32 mtk_cirq_regs_v1[] = {
 	[CIRQ_CONTROL]	= 0x300,
 };
 
+static const u32 mtk_cirq_regs_v2[] = {
+	[CIRQ_STA]	= 0x0,
+	[CIRQ_ACK]	= 0x80,
+	[CIRQ_MASK_SET]	= 0x180,
+	[CIRQ_MASK_CLR]	= 0x200,
+	[CIRQ_SENS_SET]	= 0x300,
+	[CIRQ_SENS_CLR]	= 0x380,
+	[CIRQ_POL_SET]	= 0x480,
+	[CIRQ_POL_CLR]	= 0x500,
+	[CIRQ_CONTROL]	= 0x600,
+};
+
 #define CIRQ_EN	0x1
 #define CIRQ_EDGE	0x2
 #define CIRQ_FLUSH	0x4
@@ -262,12 +274,15 @@ static inline void mtk_cirq_syscore_init(void) {}
 #endif
 
 static const struct of_device_id mtk_cirq_of_match[] = {
-	{ .compatible = "mediatek,
+	{ .compatible = "mediatek,mt8192-cirq", .data = &mtk_cirq_regs_v2 },
+	{ /* sentinel */ }
+};
 
 static int __init mtk_cirq_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
 	struct irq_domain *domain, *domain_parent;
+	const struct of_device_id *match;
 	unsigned int irq_num;
 	int ret;
 
@@ -298,7 +313,11 @@ static int __init mtk_cirq_of_init(struct device_node *node,
 	if (ret)
 		goto out_unmap;
 
-	cirq_data->regs = mtk_cirq_regs_v1;
+	match = of_match_node(mtk_cirq_of_match, node);
+	if (match)
+		cirq_data->regs = match->data;
+	else
+		cirq_data->regs = mtk_cirq_regs_v1;
 
 	irq_num = cirq_data->ext_irq_end - cirq_data->ext_irq_start + 1;
 	domain = irq_domain_add_hierarchy(domain_parent, 0,
-- 
2.38.1

