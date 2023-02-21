Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC1C69DFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjBUL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjBUL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:58:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790E2916D;
        Tue, 21 Feb 2023 03:57:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C28166021E0;
        Tue, 21 Feb 2023 11:56:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676980593;
        bh=mBi2vu9zK6J7OK8kzMEo2QXJSnqtMODi1D3E+PXa/E0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvvLa0wkXOTwGlSI6o4SJwmW0I8LTkykVjTN5rmmeZU0eVeetJexacg3CpegoTLT4
         qoZFzPClUq52L9zIOzFTblIIjS+9gGWiTFF+zB5Je1hlTwTufDQ3P8Gd7rJf6RJLJI
         KktKLR2q4Mv1CqZMT+r8ONoV8tFM828O9UvfMkVWK0N/ipbyzraE5jkvgh1mzcB5TM
         KQN12lgr06Td0cOAbf2JiRnD1OYTW/sVlO86P82Ns2TAjDUWnFFdj7dK84MQPc4VQZ
         WAmw4TSXB8XSdl31GGLSb/UbVQ24nuaKtQO3BOCWI2Nirs4aWsWEiOpwqeuWQUFsg9
         tKI1VP9ZHrY2w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 29/54] clk: mediatek: mt8516: Convert to platform driver and simple probe
Date:   Tue, 21 Feb 2023 12:55:24 +0100
Message-Id: <20230221115549.360132-30-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221115549.360132-1-angelogioacchino.delregno@collabora.com>
References: <20230221115549.360132-1-angelogioacchino.delregno@collabora.com>
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

Convert the MT8516 clock drivers to be platform drivers and use the
common probe mechanism.

Thanks to the conversion, more error handling was added to the clocks
registration.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8516-aud.c | 35 ++++++-----
 drivers/clk/mediatek/clk-mt8516.c     | 88 +++++++++++----------------
 2 files changed, 57 insertions(+), 66 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index a6ae8003b9ff..119dbbd0c3e0 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2019 MediaTek Inc.
  * Author: James Liao <jamesjj.liao@mediatek.com>
  *         Fabien Parent <fparent@baylibre.com>
+ * Copyright (c) 2023 Collabora Ltd.
  */
 
 #include <linux/clk-provider.h>
@@ -25,7 +26,7 @@ static const struct mtk_gate_regs aud_cg_regs = {
 #define GATE_AUD(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &aud_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-static const struct mtk_gate aud_clks[] __initconst = {
+static const struct mtk_gate aud_clks[] = {
 	GATE_AUD(CLK_AUD_AFE, "aud_afe", "clk26m_ck", 2),
 	GATE_AUD(CLK_AUD_I2S, "aud_i2s", "i2s_infra_bck", 6),
 	GATE_AUD(CLK_AUD_22M, "aud_22m", "rg_aud_engen1", 8),
@@ -41,19 +42,25 @@ static const struct mtk_gate aud_clks[] __initconst = {
 	GATE_AUD(CLK_AUD_TML, "aud_tml", "aud_afe", 27),
 };
 
-static void __init mtk_audsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
+static const struct mtk_clk_desc aud_desc = {
+	.clks = aud_clks,
+	.num_clks = ARRAY_SIZE(aud_clks),
+};
 
-	mtk_clk_register_gates(NULL, node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+static const struct of_device_id of_match_clk_mt8516_aud[] = {
+	{ .compatible = "mediatek,mt8516-audsys", .data = &aud_desc },
+	{ /* sentinel */ }
+};
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+static struct platform_driver clk_mt8516_aud_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8516-aud",
+		.of_match_table = of_match_clk_mt8516_aud,
+	},
+};
+builtin_platform_driver(clk_mt8516_aud_drv);
 
-}
-CLK_OF_DECLARE(mtk_audsys, "mediatek,mt8516-audsys", mtk_audsys_init);
+MODULE_DESCRIPTION("MediaTek MT8516 audiosys clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 51e6948cb54b..ad59e932d4aa 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2019 MediaTek Inc.
  * Author: James Liao <jamesjj.liao@mediatek.com>
  *         Fabien Parent <fparent@baylibre.com>
+ * Copyright (c) 2023 Collabora Ltd.
  */
 
 #include <linux/delay.h>
@@ -10,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
 
 #include "clk-gate.h"
 #include "clk-mtk.h"
@@ -638,59 +640,41 @@ static const struct mtk_gate top_clks[] __initconst = {
 	GATE_TOP5(CLK_TOP_APLL12_DIV6, "apll12_div6", "apll12_ck_div6", 8),
 };
 
-static void __init mtk_topckgen_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	void __iomem *base;
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
+static const struct mtk_clk_desc topck_desc = {
+	.clks = top_clks,
+	.num_clks = ARRAY_SIZE(top_clks),
+	.fixed_clks = fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.composite_clks = top_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_muxes),
+	.divider_clks = top_adj_divs,
+	.num_divider_clks = ARRAY_SIZE(top_adj_divs),
+	.clk_lock = &mt8516_clk_lock,
+};
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+static const struct mtk_clk_desc infra_desc = {
+	.composite_clks = ifr_muxes,
+	.num_composite_clks = ARRAY_SIZE(ifr_muxes),
+	.clk_lock = &mt8516_clk_lock,
+};
 
-	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
-				    clk_data);
-	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+static const struct of_device_id of_match_clk_mt8516[] = {
+	{ .compatible = "mediatek,mt8516-topckgen", .data = &topck_desc },
+	{ .compatible = "mediatek,mt8516-infracfg", .data = &infra_desc },
+	{ /* sentinel */ }
+};
 
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(NULL, top_muxes,
-				    ARRAY_SIZE(top_muxes), base,
-				    &mt8516_clk_lock, clk_data);
-	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
-				base, &mt8516_clk_lock, clk_data);
+static struct platform_driver clk_mt8516_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8516",
+		.of_match_table = of_match_clk_mt8516,
+	},
+};
+module_platform_driver(clk_mt8516_drv);
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-}
-CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8516-topckgen", mtk_topckgen_init);
-
-static void __init mtk_infracfg_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	void __iomem *base;
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
-
-	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
-
-	mtk_clk_register_composites(NULL, ifr_muxes,
-				    ARRAY_SIZE(ifr_muxes), base,
-				    &mt8516_clk_lock, clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-}
-CLK_OF_DECLARE(mtk_infracfg, "mediatek,mt8516-infracfg", mtk_infracfg_init);
+MODULE_DESCRIPTION("MediaTek MT8516 clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

