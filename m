Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F95609EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJXKYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJXKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:23:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCAA5A17A;
        Mon, 24 Oct 2022 03:23:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 46435660282A;
        Mon, 24 Oct 2022 11:23:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666607016;
        bh=OaQQU68d+mZ/y3nMS8j/flqN6YzM2nFoIK5HdQQzj2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRrKMkiYp1k47+EikQmkpcDPo7tWaNomrGUGzd6jDPvV0gt0NT6RypOVrEeJI40Lw
         /4341jLzRNyukSrPxBFAOS+N8peIE9Dg22dAQlIqBleeU62k3lwPIIBlBRFlBlMH4c
         7laxjJj1pcCFsL1uF/5ByXPp6vcVP11iWS8E9C+eNk94BTaXV4LrEx9jcn9wVKQP+z
         wlk4kXEoF2M6w1LGZnSChq+kIV5MIhik61ONVsONdXyyrjpSmSRPzs7xJ8bdTvJXyl
         rz10IeFhHJ88bTC7S/IH1hVNJN+ZyORtPRAaCoFObwVw1y/CvChmAT2ll80IoOeA5P
         A5+UDGYXybUTg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        msp@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] clk: mediatek: mt8186-topckgen: Add GPU clock mux notifier
Date:   Mon, 24 Oct 2022 12:23:07 +0200
Message-Id: <20221024102307.33722-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
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

Following the changes done to MT8183, MT8192, MT8195, register a
clock notifier for MT8186, allowing safe clockrate updates for the
MFG PLL.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8186-topckgen.c | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 62b5ff4a5723..c2beda7ef976 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -689,6 +689,28 @@ static const struct of_device_id of_match_clk_mt8186_topck[] = {
 	{}
 };
 
+/* Register mux notifier for MFG mux */
+static int clk_mt8186_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
+{
+	struct mtk_mux_nb *mfg_mux_nb;
+	int i;
+
+	mfg_mux_nb = devm_kzalloc(dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
+	if (!mfg_mux_nb)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(top_mtk_muxes); i++)
+		if (top_mtk_muxes[i].id == CLK_TOP_MFG)
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
 static int clk_mt8186_topck_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -730,6 +752,11 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_composite_muxes;
 
+	r = clk_mt8186_reg_mfg_mux_notifier(&pdev->dev,
+					    clk_data->hws[CLK_TOP_MFG]->clk);
+	if (r)
+		goto unregister_composite_divs;
+
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_composite_divs;
-- 
2.37.2

