Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96F65EBF69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiI0KMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiI0KLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:11:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8494B07C9;
        Tue, 27 Sep 2022 03:11:46 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 551EA660226E;
        Tue, 27 Sep 2022 11:11:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664273505;
        bh=5IWI64htpEUd32LavmbW5vcTEzgbRV3GoZjikO26riQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avjHok5TrFI3/972JFn0CVpzlKvuEqyFdFWvlvd7I+U9ARrLUoA/uhao8tEgHNM0E
         SwfUKz4UcLFxm4XcH9L4zAheamC218jaUOER+Ixa/5demwgbQN1YOvgtDW5dL2Pmu5
         Phz3pBPw1Fpj+q6msB0S80OE8PFfg2nSyvGtT0KJbX/Qq2zyhJPjrUD6puh7yOHqFY
         w46u7ZW+QrIvwUyKEUPc485MWr48eby8CBc/aRS6mqqoQxnsrCsvX2iqhUl783JTzg
         sEBY1R5p4V7e2uu7T5lCJmBllWttBGqVjGZXLBuFB0W5WJSMFGBHiMi99zLAsydqYb
         0B9hvheXY2J4g==
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
Subject: [PATCH v3 10/10] clk: mediatek: clk-mt8192: Add clock mux notifier for mfg_pll_sel
Date:   Tue, 27 Sep 2022 12:11:28 +0200
Message-Id: <20220927101128.44758-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
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

Following the changes that were done for mt8183, add a clock notifier
for the GPU PLL selector mux: this allows safe clock rate changes by
temporarily reparenting the GPU to a safe clock (clk26m) while the
MFGPLL is reprogrammed and stabilizes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8192.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index ebbd2798d9a3..187dbffeb987 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1224,6 +1224,28 @@ static void clk_mt8192_top_init_early(struct device_node *node)
 CLK_OF_DECLARE_DRIVER(mt8192_topckgen, "mediatek,mt8192-topckgen",
 		      clk_mt8192_top_init_early);
 
+/* Register mux notifier for MFG mux */
+static int clk_mt8192_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
+{
+	struct mtk_mux_nb *mfg_mux_nb;
+	int i;
+
+	mfg_mux_nb = devm_kzalloc(dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
+	if (!mfg_mux_nb)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(top_mtk_muxes); i++)
+		if (top_mtk_muxes[i].id == CLK_TOP_MFG_PLL_SEL)
+			break;
+	if (i == ARRAY_SIZE(top_mtk_muxes))
+		return -EINVAL;
+
+	mfg_mux_nb->ops = top_mtk_muxes[i].ops;
+	mfg_mux_nb->bypass_index = 0; /* Bypass to 26M crystal */
+
+	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
+}
+
 static int clk_mt8192_top_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -1247,6 +1269,12 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
+	r = clk_mt8192_reg_mfg_mux_notifier(&pdev->dev,
+					    top_clk_data->hws[CLK_TOP_MFG_PLL_SEL]->clk);
+	if (r)
+		return r;
+
+
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
 				      top_clk_data);
 }
-- 
2.37.2

