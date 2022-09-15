Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A885E5B9555
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIOHZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIOHZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:25:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1679243605;
        Thu, 15 Sep 2022 00:25:20 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 175A96602027;
        Thu, 15 Sep 2022 08:25:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663226713;
        bh=P8qf8sm2+n6h5GY24T45/pBhBpIHyvw5DFQp0vf8aik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+5C0XO8SFckKVkPJlLydRIdtoT7zbfiWgCPXNbLHPE9rBQ3BoUqOnVpAOK1l6v+u
         1zcETeVtilR5XvYQuCT2BZC2PwrVQFDVV4Uk/KNKNnFeb86W0zRjqUTjWJH6NT8t7C
         jzNRHW5lcfxmw7B+uiBj4lQNT+af8Z4H4zipgVZ8hudS1CBp/hv3yWt4dBS/cjwCtA
         0iMn8tIq2QeO/X1Rj+WenVBPRnoj7hm7/+uVrFP362rI1GhQ3bT+SMhlA6+WvcnWwv
         DgNGpLaeEypv2hCJgCIpPiQLVeCvLvQrPD7+TSPGT91NsxjpTH/BrMsKsLWsf0YqnJ
         LfeE7iTbB5ZNw==
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
Subject: [PATCH v2 07/10] clk: mediatek: clk-mt8195-topckgen: Add GPU clock mux notifier
Date:   Thu, 15 Sep 2022 09:24:55 +0200
Message-Id: <20220915072458.18232-8-angelogioacchino.delregno@collabora.com>
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

Following the changes done to MT8183, register a similar notifier
for MT8195 as well, allowing safe clockrate updates for the MFGPLL.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index e1c3ab4e146b..4dde23bece66 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1217,6 +1217,21 @@ static const struct of_device_id of_match_clk_mt8195_topck[] = {
 	{}
 };
 
+/* Register mux notifier for MFG mux */
+static int clk_mt8195_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
+{
+	struct mtk_mux_nb *mfg_mux_nb;
+
+	mfg_mux_nb = devm_kzalloc(dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
+	if (!mfg_mux_nb)
+		return -ENOMEM;
+
+	mfg_mux_nb->ops = &clk_mux_ops;
+	mfg_mux_nb->bypass_index = 0; /* Bypass to TOP_MFG_CORE_TMP */
+
+	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
+}
+
 static int clk_mt8195_topck_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *top_clk_data;
@@ -1256,6 +1271,11 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 		goto unregister_muxes;
 	top_clk_data->hws[CLK_TOP_MFG_CK_FAST_REF] = hw;
 
+	r = clk_mt8195_reg_mfg_mux_notifier(&pdev->dev,
+					    top_clk_data->hws[CLK_TOP_MFG_CK_FAST_REF]->clk);
+	if (r)
+		goto unregister_muxes;
+
 	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
 					&mt8195_clk_lock, top_clk_data);
 	if (r)
-- 
2.37.2

