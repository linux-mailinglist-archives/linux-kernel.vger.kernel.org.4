Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A4865449F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiLVPw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiLVPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:51:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B9326;
        Thu, 22 Dec 2022 07:51:56 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B56126602CD7;
        Thu, 22 Dec 2022 15:51:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671724315;
        bh=e4X/ACfo4PczeBKqlI21xK5AuMzs072mhIO7l0YAHu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xy2WmJAsLPh5m93F5x2b4YkInrqBV+at/WurjEqjm/BMx1Rdb8qlTJAI2Gv3iE493
         TrmkUnl/COnzXJmgqSwCMHp6XftKn9UneCnaFON1id5VabyQ6Q3K0g+/OhFRjRyOYT
         JNHRXLoU6+ZqaeMgHdT2f8auY0sD3xyAFaD+4mP9utrFt8AfBqnnm09iSyCCUAiz5S
         WhoMK7x7txrptSg6yXKk/fW5hUwbGPBLAW39TRG5pyn0YgUh0rxvecpdZRT0eiffZK
         3o030uyy/2j9W8h3bwh6/PoSfKe0JBVyz1RAj5G+8Sivr8zzVYqz5r0vsTjehp2PkJ
         fDMoMNkgAdGog==
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
Subject: [PATCH v1 4/6] clk: mediatek: mt8173: Add support for frequency hopping through FHCTL
Date:   Thu, 22 Dec 2022 16:51:45 +0100
Message-Id: <20221222155147.158837-5-angelogioacchino.delregno@collabora.com>
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
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 65 +++++++++++++++++++-
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index a56c5845d07a..0084203e67ad 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -9,8 +9,10 @@
 #include <linux/of_address.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include "clk-fhctl.h"
 #include "clk-mtk.h"
 #include "clk-pll.h"
+#include "clk-pllfh.h"
 
 #define REGOFF_REF2USB		0x8
 #define REGOFF_HDMI_REF		0x40
@@ -77,6 +79,58 @@ static const struct mtk_pll_data plls[] = {
 	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0, 0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
 };
 
+enum fh_pll_id {
+	FH_ARMCA7PLL,
+	FH_ARMCA15PLL,
+	FH_MAINPLL,
+	FH_MPLL,
+	FH_MSDCPLL,
+	FH_MMPLL,
+	FH_VENCPLL,
+	FH_TVDPLL,
+	FH_VCODECPLL,
+	FH_LVDSPLL,
+	FH_MSDC2PLL,
+	FH_NR_FH,
+};
+
+#define FH(_pllid, _fhid, _offset) {					\
+		.data = {						\
+			.pll_id = _pllid,				\
+			.fh_id = _fhid,					\
+			.fh_ver = FHCTL_PLLFH_V1,			\
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
+	FH(CLK_APMIXED_ARMCA7PLL, FH_ARMCA7PLL, 0x38),
+	FH(CLK_APMIXED_ARMCA15PLL, FH_ARMCA15PLL, 0x4c),
+	FH(CLK_APMIXED_MAINPLL, FH_MAINPLL, 0x60),
+	FH(CLK_APMIXED_MPLL, FH_MPLL, 0x74),
+	FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x88),
+	FH(CLK_APMIXED_MMPLL, FH_MMPLL, 0x9c),
+	FH(CLK_APMIXED_VENCPLL, FH_VENCPLL, 0xb0),
+	FH(CLK_APMIXED_TVDPLL, FH_TVDPLL, 0xc4),
+	FH(CLK_APMIXED_VCODECPLL, FH_VCODECPLL, 0xd8),
+	FH(CLK_APMIXED_LVDSPLL, FH_LVDSPLL, 0xec),
+	FH(CLK_APMIXED_MSDCPLL2, FH_MSDC2PLL, 0x100),
+};
+
 static const struct of_device_id of_match_clk_mt8173_apmixed[] = {
 	{ .compatible = "mediatek,mt8173-apmixedsys" },
 	{ /* sentinel */ }
@@ -84,6 +138,7 @@ static const struct of_device_id of_match_clk_mt8173_apmixed[] = {
 
 static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 {
+	const u8 *fhctl_node = "mediatek,mt8173-fhctl";
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
@@ -98,7 +153,9 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	if (IS_ERR_OR_NULL(clk_data))
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
+	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
+				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -124,7 +181,8 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 unregister_ref2usb:
 	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
 unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
@@ -137,7 +195,8 @@ static int clk_mt8173_apmixed_remove(struct platform_device *pdev)
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
 
 	return 0;
-- 
2.39.0

