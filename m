Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60C168B953
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBFKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBFKBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:01:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B797AB5;
        Mon,  6 Feb 2023 02:01:20 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B20726602FD2;
        Mon,  6 Feb 2023 10:01:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675677679;
        bh=itE4eZMJemdRprpa0Uu/b/CoO8oJbwlvvA8SntoU+ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2sEzKgKi0MkkbK3EExzgt8lOpClv9E2HO3PrS7AgNDymvkA6yRMluUQN2TQ916l1
         BERfyl7sHBPn6v6SwQmo8K7Qv0PcHTBaL4c2dnpAwBelBBvb0Gao2fyxc5QmoVatYj
         qdAG9lzbLB94NS+krbITDDuRLKjJWEb+DseDGzTs2KC9TkCZEwK9hPYPMN4rSMs6A5
         ubGFwtZJ9LHb64rAXLgvhMBnFwBdMQTZ25gxP44o075u9YZBKvfTgsJxChji8m6WUD
         cjtnAGsRLdJ3YrO2LFeaLJAuF6fof1OjI7ITJTNJj/1bayEOnF/9LGq8HmFSXyXGqE
         W7Fvca9jUAuHA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 4/7] clk: mediatek: mt6795: Add support for frequency hopping through FHCTL
Date:   Mon,  6 Feb 2023 11:01:02 +0100
Message-Id: <20230206100105.861720-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
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
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 63 +++++++++++++++++++-
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
index 59761c72d3bc..03fa30527868 100644
--- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
@@ -7,8 +7,10 @@
 #include <dt-bindings/clock/mediatek,mt6795-clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include "clk-fhctl.h"
 #include "clk-mtk.h"
 #include "clk-pll.h"
+#include "clk-pllfh.h"
 
 #define REG_REF2USB		0x8
 #define REG_AP_PLL_CON7		0x1c
@@ -58,6 +60,56 @@ static const struct mtk_pll_data plls[] = {
 	PLL(CLK_APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0, 0, 31, 0x2b4, 4, 0x2bc, 0x2b8, 0),
 };
 
+enum fh_pll_id {
+	FH_CA53PLL_LL,
+	FH_CA53PLL_BL,
+	FH_MAINPLL,
+	FH_MPLL,
+	FH_MSDCPLL,
+	FH_MMPLL,
+	FH_VENCPLL,
+	FH_TVDPLL,
+	FH_VCODECPLL,
+	FH_NR_FH,
+};
+
+#define _FH(_pllid, _fhid, _slope, _offset) {				\
+		.data = {						\
+			.pll_id = _pllid,				\
+			.fh_id = _fhid,					\
+			.fh_ver = FHCTL_PLLFH_V1,			\
+			.fhx_offset = _offset,				\
+			.dds_mask = GENMASK(21, 0),			\
+			.slope0_value = _slope,				\
+			.slope1_value = _slope,				\
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
+#define FH(_pllid, _fhid, _offset)	_FH(_pllid, _fhid, 0x6003c97, _offset)
+#define FH_M(_pllid, _fhid, _offset)	_FH(_pllid, _fhid, 0x6000140, _offset)
+
+static struct mtk_pllfh_data pllfhs[] = {
+	FH(CLK_APMIXED_ARMCA53PLL, FH_CA53PLL_BL, 0x38),
+	FH(CLK_APMIXED_MAINPLL, FH_MAINPLL, 0x60),
+	FH_M(CLK_APMIXED_MPLL, FH_MPLL, 0x74),
+	FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x88),
+	FH(CLK_APMIXED_MMPLL, FH_MMPLL, 0x9c),
+	FH(CLK_APMIXED_VENCPLL, FH_VENCPLL, 0xb0),
+	FH(CLK_APMIXED_TVDPLL, FH_TVDPLL, 0xc4),
+	FH(CLK_APMIXED_VCODECPLL, FH_VCODECPLL, 0xd8),
+};
+
 static void clk_mt6795_apmixed_setup_md1(void __iomem *base)
 {
 	void __iomem *reg = base + REG_AP_PLL_CON7;
@@ -85,6 +137,7 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 	struct clk_hw_onecell_data *clk_data;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	const u8 *fhctl_node = "mediatek,mt6795-fhctl";
 	void __iomem *base;
 	struct clk_hw *hw;
 	int ret;
@@ -97,7 +150,9 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
+	ret = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
+				      pllfhs, ARRAY_SIZE(pllfhs), clk_data);
 	if (ret)
 		goto free_clk_data;
 
@@ -124,7 +179,8 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 unregister_ref2usb:
 	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
 unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return ret;
@@ -137,7 +193,8 @@ static int clk_mt6795_apmixed_remove(struct platform_device *pdev)
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
 
 	return 0;
-- 
2.39.1

