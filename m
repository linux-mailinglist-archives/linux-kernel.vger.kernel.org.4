Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD343654EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiLWJoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiLWJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:44:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA1B37F8A;
        Fri, 23 Dec 2022 01:43:25 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 560B36602D04;
        Fri, 23 Dec 2022 09:43:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671788604;
        bh=LQTkPfhVODN4AyLDwNy5hfClKpPsqVhoNw8nfI4XDTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtuCNgqwEsOL7RxQ+jh48BlNfrXGFoMwF1wIkI+84NA6nULHRRaQnUBKRn6Ff8RYs
         IZ0xpUd/3VpDV/mJtavptCWdye/sSrOkSHeSsfhhr2AfKH1NGivBBD79hEP6fHepcn
         ckxhhjF0170/U7G1A5/9uz0kQLzZO9m/BtsKpM9lcC0Ah3XzACUlK6J04ZIUN39mFA
         nHL2dZxXkoSmvcwIJ5jRQ+O/hFG6L023huwrD+afr2qgISXpHfq70DLCgPuD/aH5gO
         lYfoXkLNl35LS4ue8QfTXk49NB8XCIgYquZzFQNILtKFnXvl4AfXlhu83qFgdDACKQ
         C41ODKaK8ZavA==
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
Subject: [PATCH v2 12/23] clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()
Date:   Fri, 23 Dec 2022 10:42:48 +0100
Message-Id: <20221223094259.87373-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
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
---
 drivers/clk/mediatek/clk-mtk.c | 101 ++++++++++++++++++++++++++++++---
 drivers/clk/mediatek/clk-mtk.h |  10 ++++
 2 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d05364e17e95..b0a6225cd7b2 100644
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
 
@@ -465,20 +467,71 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
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
 
-	r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks,
-				   clk_data, &pdev->dev);
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
+		r = mtk_clk_register_muxes(mcd->mux_clks, mcd->num_mux_clks,
+					   node, mcd->clk_lock, clk_data,
+					   &pdev->dev);
+		if (r)
+			goto unregister_factors;
+	};
+
+	if (mcd->composite_clks) {
+		/* We don't check composite_lock because it's optional */
+		r = mtk_clk_register_composites(mcd->composite_clks,
+						mcd->num_composite_clks,
+						base, mcd->clk_lock,
+						clk_data, &pdev->dev);
+		if (r)
+			goto unregister_muxes;
+	}
+
+	if (mcd->clks) {
+		r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks,
+					   clk_data, &pdev->dev);
+		if (r)
+			goto unregister_composites;
+	}
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -496,9 +549,28 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
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
@@ -510,7 +582,20 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
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
index dd43235285db..1d036ba6ca07 100644
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

