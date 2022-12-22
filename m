Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2CC65449B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiLVPwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiLVPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:51:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD0165AA;
        Thu, 22 Dec 2022 07:51:57 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D31306602CE2;
        Thu, 22 Dec 2022 15:51:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671724316;
        bh=mFHM5xUXIL/UjRznhQq9NsXo12GBCvWaVvgttW9tU1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRbdZMl6+1+qiHN2P0RK14zL20BUwoO8askrrZESJ2j8NnqfGN+TyRbmkB9KCdwnJ
         /B/kLt09Isyf8fe1OLzXT1Hdza48byc7eYs2YKCj547yvXCg+4FH90OPs1IGYLxtec
         oRdK47E0OOLJG5Rz5A68bZlhkQrMh9JvL5t8UzG9dma+9PHRrnAP8osoz5ROYts/9I
         91krZzCtqnrzmn8q1bOnV5NynIQWzhcD6ZUB93v2d/I34fjokoxMdagqRjiJriBw/Z
         hlSa1GKLGg7fTh2ZBGjB07xRoL2m/FlPnMu87ZnLchGUf0NqYL7dNQjOmP5mSkDXAW
         eRC/sCPokF7xg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1 5/6] clk: mediatek: mt8192: Add support for frequency hopping through FHCTL
Date:   Thu, 22 Dec 2022 16:51:46 +0100
Message-Id: <20221222155147.158837-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
References: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
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

Add FHCTL parameters and register PLLs through FHCTL to add support
for frequency hopping and SSC. FHCTL will be enabled only on PLLs
specified in devicetree.

This commit brings functional changes only upon addition of
devicetree configuration.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8192.c | 67 ++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index adde457e6277..648f88d41622 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -12,10 +12,12 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "clk-fhctl.h"
 #include "clk-gate.h"
 #include "clk-mtk.h"
 #include "clk-mux.h"
 #include "clk-pll.h"
+#include "clk-pllfh.h"
 
 #include <dt-bindings/clock/mt8192-clk.h>
 #include <dt-bindings/reset/mt8192-resets.h>
@@ -1042,6 +1044,57 @@ static const struct mtk_pll_data plls[] = {
 	      0, 0, 32, 0x0330, 24, 0, 0, 0, 0x0334, 0),
 };
 
+enum fh_pll_id {
+	FH_ARMPLL_LL,
+	FH_ARMPLL_BL0,
+	FH_ARMPLL_BL1,
+	FH_ARMPLL_BL2,
+	FH_ARMPLL_BL3,
+	FH_CCIPLL,
+	FH_MFGPLL,
+	FH_MEMPLL,
+	FH_MPLL,
+	FH_MMPLL,
+	FH_MAINPLL,
+	FH_MSDCPLL,
+	FH_ADSPPLL,
+	FH_APUPLL,
+	FH_TVDPLL,
+	FH_NR_FH,
+};
+
+#define FH(_pllid, _fhid, _offset) {					\
+		.data = {						\
+			.pll_id = _pllid,				\
+			.fh_id = _fhid,					\
+			.fh_ver = FHCTL_PLLFH_V2,			\
+			.fhx_offset = _offset,				\
+			.dds_mask = GENMASK(21, 0),			\
+			.slope0_value = 0x6003c97,			\
+			.slope1_value = 0x6003c97,			\
+			.sfstrx_en = BIT(2),				\
+			.frddsx_en = BIT(1),				\
+			.fhctlx_en = BIT(0),				\
+			.tgl_org = BIT(31),				\
+			.dvfs_tri = BIT(31),				\
+			.pcwchg = BIT(31),				\
+			.dt_val = 0x0,					\
+			.df_val = 0x9,					\
+			.updnlmt_shft = 16,				\
+			.msk_frddsx_dys = GENMASK(23, 20),		\
+			.msk_frddsx_dts = GENMASK(19, 16),		\
+		},							\
+	}
+
+static struct mtk_pllfh_data pllfhs[] = {
+	FH(CLK_APMIXED_MFGPLL, FH_MFGPLL, 0xb4),
+	FH(CLK_APMIXED_MMPLL, FH_MMPLL, 0xf0),
+	FH(CLK_APMIXED_MAINPLL, FH_MAINPLL, 0x104),
+	FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x118),
+	FH(CLK_APMIXED_ADSPPLL, FH_ADSPPLL, 0x12c),
+	FH(CLK_APMIXED_TVDPLL, FH_TVDPLL, 0x154),
+};
+
 /* Register mux notifier for MFG mux */
 static int clk_mt8192_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
 {
@@ -1068,18 +1121,25 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
+	const u8 *fhctl_node = "mediatek,mt8192-fhctl";
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
+
+	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
+				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
+	if (r)
+		goto free_clk_data;
+
 	r = mtk_clk_register_gates(node, apmixed_clks,
 				   ARRAY_SIZE(apmixed_clks), clk_data,
 				   &pdev->dev);
 	if (r)
-		goto free_clk_data;
+		goto unregister_plls;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1089,6 +1149,9 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 
 unregister_gates:
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+unregister_plls:
+	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
-- 
2.39.0

