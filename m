Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486E5B954E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiIOHZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIOHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:25:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF15257E35;
        Thu, 15 Sep 2022 00:25:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A469C6601FC7;
        Thu, 15 Sep 2022 08:25:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663226710;
        bh=78egXpcwYI0LobAOtW6zrOMH4zDX0mRd/unB/BTkHWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcqqYUxd23wXDO/PMP8P6pVxTGqgIjbg8z3+BjTYLRW2FTWRiL+2EHxxwgMLA3xrQ
         WFYcsBZipLCSHQH7lFEEQHD9gGSaGX26S55KaS+z+C3JikynwGn4yNhP3YLJbobcsS
         Z4kUG/lvZHwGvuR6753SXtR1ScX3fcJH1CrVw8e5x2fLtyJHaikVA8ZwtYrDj9mQQv
         qr084HTM9O1TBoKYCatkqxuk8lYj5ih04h3lX1CV7wwdUi121d3W4s6DpF/Z53Wzrr
         3Q+kjdFiOpeZ6SeIG7bnHYKaeV3v3xlf21Dyp641hSUGp8MG8T66AIlo571mVoYLH4
         Mzw8Yw7aX9ilg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 04/10] clk: mediatek: mt8183: Add clk mux notifier for MFG mux
Date:   Thu, 15 Sep 2022 09:24:52 +0200
Message-Id: <20220915072458.18232-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com>
References: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wenst@chromium.org>

When the MFG PLL clock, which is upstream of the MFG clock, is changed,
the downstream clock and consumers need to be switched away from the PLL
over to a stable clock to avoid glitches.

This is done through the use of the newly added clk mux notifier. The
notifier is set on the mux itself instead of the upstream PLL, but in
practice this works, as the rate change notifitcations are propogated
throughout the sub-tree hanging off the PLL. Just before rate changes,
the MFG mux is temporarily and transparently switched to the 26 MHz
main crystal. After the rate change, the mux is switched back.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[Angelo: Rebased to assign clk_ops in mtk_mux_nb]
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 8512101e1189..1860a35a723a 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1198,10 +1198,33 @@ static void clk_mt8183_top_init_early(struct device_node *node)
 CLK_OF_DECLARE_DRIVER(mt8183_topckgen, "mediatek,mt8183-topckgen",
 			clk_mt8183_top_init_early);
 
+/* Register mux notifier for MFG mux */
+static int clk_mt8183_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
+{
+	struct mtk_mux_nb *mfg_mux_nb;
+	int i;
+
+	mfg_mux_nb = devm_kzalloc(dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
+	if (!mfg_mux_nb)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(top_muxes); i++)
+		if (top_muxes[i].id == CLK_TOP_MUX_MFG)
+			break;
+	if (i == ARRAY_SIZE(top_muxes))
+		return -EINVAL;
+
+	mfg_mux_nb->ops = top_muxes[i].ops;
+	mfg_mux_nb->bypass_index = 0; /* Bypass to 26M crystal */
+
+	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
+}
+
 static int clk_mt8183_top_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
+	int ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -1227,6 +1250,11 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 		top_clk_data);
 
+	ret = clk_mt8183_reg_mfg_mux_notifier(&pdev->dev,
+					      top_clk_data->hws[CLK_TOP_MUX_MFG]->clk);
+	if (ret)
+		return ret;
+
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
 				      top_clk_data);
 }
-- 
2.37.2

