Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7920E6750D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjATJWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjATJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:22:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B717695178;
        Fri, 20 Jan 2023 01:21:25 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 470976602EE6;
        Fri, 20 Jan 2023 09:21:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206479;
        bh=Hzd4ZCV3hbu/y9AeR6NdpNg7TukN9MbTEJnGSGiCBhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4DG2KuNiFzsYstHxJJXutDMOtjXjYREM4/d1pQZiHQvQmIZGNpbrjD6MUVGUMxo9
         DWuzuZF7EvxDtUd/L7e+AdGZqVOf3CDyX+xlH8eJ+UXQLNnCiLZpYq+AUv65nXgEbE
         ryWIM00sGKIZl3xI9Gz6+qt0dizIFNy7Ms4GXkcYlhxOuFyVHMN4W+WGU7p2iabYsY
         FTkIma5GevA8NwHFSIlR1RpXBhkh/khFC0VzCQEAQViWw9YVdYUmb3aqe+HIeJjf0i
         tZJ2pDLH3POo6Xbq7XBGobwrWoeU9X8wCdlR4gOHW6mOraAr+U5vXLs7aBHiDCax2N
         51+rOlnYrGfVQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v4 12/23] clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()
Date:   Fri, 20 Jan 2023 10:20:42 +0100
Message-Id: <20230120092053.182923-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com>
References: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com>
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

As a preparation to increase probe functions commonization across
various MediaTek SoC clock controller drivers, extend function
mtk_clk_simple_probe() to be able to register not only gates, but
also fixed clocks, factors, muxes and composites.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 101 ++++++++++++++++++++++++++++++---
 drivers/clk/mediatek/clk-mtk.h |  10 ++++
 2 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index ca9aa24e769c..281d30d6cb2b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -11,12 +11,14 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-mux.h"
 
 const struct mtk_gate_regs cg_regs_dummy = { 0, 0, 0 };
 EXPORT_SYMBOL_GPL(cg_regs_dummy);
@@ -466,20 +468,71 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	const struct mtk_clk_desc *mcd;
 	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
-	int r;
+	void __iomem *base;
+	int num_clks, r;
 
 	mcd = of_device_get_match_data(&pdev->dev);
 	if (!mcd)
 		return -EINVAL;
 
-	clk_data = mtk_alloc_clk_data(mcd->num_clks);
+	/* Composite clocks needs us to pass iomem pointer */
+	if (mcd->composite_clks) {
+		if (!mcd->shared_io)
+			base = devm_platform_ioremap_resource(pdev, 0);
+		else
+			base = of_iomap(node, 0);
+
+		if (IS_ERR_OR_NULL(base))
+			return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
+	}
+
+	/* Calculate how many clk_hw_onecell_data entries to allocate */
+	num_clks = mcd->num_clks + mcd->num_composite_clks;
+	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
+	num_clks += mcd->num_mux_clks;
+
+	clk_data = mtk_alloc_clk_data(num_clks);
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks, mcd->num_clks,
-				   clk_data);
-	if (r)
-		goto free_data;
+	if (mcd->fixed_clks) {
+		r = mtk_clk_register_fixed_clks(mcd->fixed_clks,
+						mcd->num_fixed_clks, clk_data);
+		if (r)
+			goto free_data;
+	}
+
+	if (mcd->factor_clks) {
+		r = mtk_clk_register_factors(mcd->factor_clks,
+					     mcd->num_factor_clks, clk_data);
+		if (r)
+			goto unregister_fixed_clks;
+	}
+
+	if (mcd->mux_clks) {
+		r = mtk_clk_register_muxes(&pdev->dev, mcd->mux_clks,
+					   mcd->num_mux_clks, node,
+					   mcd->clk_lock, clk_data);
+		if (r)
+			goto unregister_factors;
+	};
+
+	if (mcd->composite_clks) {
+		/* We don't check composite_lock because it's optional */
+		r = mtk_clk_register_composites(&pdev->dev,
+						mcd->composite_clks,
+						mcd->num_composite_clks,
+						base, mcd->clk_lock, clk_data);
+		if (r)
+			goto unregister_muxes;
+	}
+
+	if (mcd->clks) {
+		r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks,
+					   mcd->num_clks, clk_data);
+		if (r)
+			goto unregister_composites;
+	}
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -497,9 +550,28 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	return r;
 
 unregister_clks:
-	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+	if (mcd->clks)
+		mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+unregister_composites:
+	if (mcd->composite_clks)
+		mtk_clk_unregister_composites(mcd->composite_clks,
+					      mcd->num_composite_clks, clk_data);
+unregister_muxes:
+	if (mcd->mux_clks)
+		mtk_clk_unregister_muxes(mcd->mux_clks,
+					 mcd->num_mux_clks, clk_data);
+unregister_factors:
+	if (mcd->factor_clks)
+		mtk_clk_unregister_factors(mcd->factor_clks,
+					   mcd->num_factor_clks, clk_data);
+unregister_fixed_clks:
+	if (mcd->fixed_clks)
+		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
+					      mcd->num_fixed_clks, clk_data);
 free_data:
 	mtk_free_clk_data(clk_data);
+	if (mcd->shared_io && base)
+		iounmap(base);
 	return r;
 }
 EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
@@ -511,7 +583,20 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+	if (mcd->clks)
+		mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+	if (mcd->composite_clks)
+		mtk_clk_unregister_composites(mcd->composite_clks,
+					      mcd->num_composite_clks, clk_data);
+	if (mcd->mux_clks)
+		mtk_clk_unregister_muxes(mcd->mux_clks,
+					 mcd->num_mux_clks, clk_data);
+	if (mcd->factor_clks)
+		mtk_clk_unregister_factors(mcd->factor_clks,
+					   mcd->num_factor_clks, clk_data);
+	if (mcd->fixed_clks)
+		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
+					      mcd->num_fixed_clks, clk_data);
 	mtk_free_clk_data(clk_data);
 
 	return 0;
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index ed329d8d7349..1bdaa0acb909 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -220,7 +220,17 @@ void mtk_clk_unregister_ref2usb_tx(struct clk_hw *hw);
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
 	size_t num_clks;
+	const struct mtk_composite *composite_clks;
+	size_t num_composite_clks;
+	const struct mtk_fixed_clk *fixed_clks;
+	size_t num_fixed_clks;
+	const struct mtk_fixed_factor *factor_clks;
+	size_t num_factor_clks;
+	const struct mtk_mux *mux_clks;
+	size_t num_mux_clks;
 	const struct mtk_clk_rst_desc *rst_desc;
+	spinlock_t *clk_lock;
+	bool shared_io;
 };
 
 int mtk_clk_simple_probe(struct platform_device *pdev);
-- 
2.39.0

