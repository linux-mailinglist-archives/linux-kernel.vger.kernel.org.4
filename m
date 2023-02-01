Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C658A67C659
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjAZIx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbjAZIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:53:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED139CE2;
        Thu, 26 Jan 2023 00:53:43 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C48F6602E8A;
        Thu, 26 Jan 2023 08:53:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674723213;
        bh=pKMGoeKu4m5DJFVWyByEtDagZ1PUSFRsRa3TlZzOsdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJ7Dp18rXaD2PV9bjGm7alMnY0xRZiSN3N9p5TcIvxR5VTV6i/O0VR+aW99bNveuH
         rTOTug+CjPQAiqqtDJnpikOkJhiCASTHZQhE8ag9xqZG7HiicGlxXwsmC3lPov0GGl
         Xtg9SRAFsWqIEL6k489ZSK0lyk4a59UNiUUK2eeVz4THuLbt59UMsGeHFkQxJKJvKY
         EDsHuPUxrxA3OKTERdnc9iVpJXPN15DG8KD2sh9347lNgShJeiAez4AxXnZZ7UHC39
         3NQPW93pbcQnloqQ7M1jgxqy7TaNABbCDWN93ke7i707wJK89rUp0DzU7YEgiuu/jg
         E4NW9pyHuFVGg==
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
Subject: [PATCH v2 6/6] clk: mediatek: mt8195: Add support for frequency hopping through FHCTL
Date:   Thu, 26 Jan 2023 09:53:21 +0100
Message-Id: <20230126085321.87267-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126085321.87267-1-angelogioacchino.delregno@collabora.com>
References: <20230126085321.87267-1-angelogioacchino.delregno@collabora.com>
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
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 69 +++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 1bc917f2667e..c0db31ce0741 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -3,9 +3,11 @@
 // Copyright (c) 2021 MediaTek Inc.
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
+#include "clk-fhctl.h"
 #include "clk-gate.h"
 #include "clk-mtk.h"
 #include "clk-pll.h"
+#include "clk-pllfh.h"
 
 #include <dt-bindings/clock/mt8195-clk.h>
 #include <linux/of_device.h>
@@ -105,6 +107,61 @@ static const struct mtk_pll_data plls[] = {
 	    0, 0, 22, 0x0158, 24, 0, 0, 0, 0x0158, 0, 0x0158, 0, 9),
 };
 
+enum fh_pll_id {
+	FH_ARMPLL_LL,
+	FH_ARMPLL_BL,
+	FH_MEMPLL,
+	FH_ADSPPLL,
+	FH_NNAPLL,
+	FH_CCIPLL,
+	FH_MFGPLL,
+	FH_TVDPLL2,
+	FH_MPLL,
+	FH_MMPLL,
+	FH_MAINPLL,
+	FH_MSDCPLL,
+	FH_IMGPLL,
+	FH_VDECPLL,
+	FH_TVDPLL1,
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
+	FH(CLK_APMIXED_ADSPPLL, FH_ADSPPLL, 0x78),
+	FH(CLK_APMIXED_NNAPLL, FH_NNAPLL, 0x8c),
+	FH(CLK_APMIXED_MFGPLL, FH_MFGPLL, 0xb4),
+	FH(CLK_APMIXED_TVDPLL2, FH_TVDPLL2, 0xc8),
+	FH(CLK_APMIXED_MMPLL, FH_MMPLL, 0xf0),
+	FH(CLK_APMIXED_MAINPLL, FH_MAINPLL, 0x104),
+	FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x118),
+	FH(CLK_APMIXED_IMGPLL, FH_IMGPLL, 0x12c),
+	FH(CLK_APMIXED_VDECPLL, FH_VDECPLL, 0x140),
+	FH(CLK_APMIXED_TVDPLL2, FH_TVDPLL1, 0x154),
+};
+
 static const struct of_device_id of_match_clk_mt8195_apmixed[] = {
 	{ .compatible = "mediatek,mt8195-apmixedsys", },
 	{}
@@ -114,13 +171,17 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
+	const u8 *fhctl_node = "mediatek,mt8195-fhctl";
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
+
+	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
+				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
 	if (r)
 		goto free_apmixed_data;
 
@@ -140,7 +201,8 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 unregister_gates:
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
 free_apmixed_data:
 	mtk_free_clk_data(clk_data);
 	return r;
@@ -153,7 +215,8 @@ static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
 
 	return 0;
-- 
2.39.0

