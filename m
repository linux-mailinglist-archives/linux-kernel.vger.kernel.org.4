Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90C69DF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjBUL5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjBUL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:56:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EC82823C;
        Tue, 21 Feb 2023 03:56:23 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73E0066021CC;
        Tue, 21 Feb 2023 11:56:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676980567;
        bh=offfga6PZ9c2+274J70+ULpaWug3WdJXHOzKf7BLroM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrSXq+I5cglZqDCvJXyUNpQXYXIdwXj1eiY+kQhmMSaAtp5/xPw4r7blQw/E50XhV
         ZBECSfCCamAzpFyLcZFE6OxCXk5GIAWX4mo98JbuqjOc2FnBms3yTCn2zhi8dSBgml
         lLcmrPRwL7gS+6lyR7pul1yv3JfWMixR3jC/b4UfaB6aMlsbYA03D38o+CWjFCUKDS
         WxpKiUN+oZE9V2KHJLJjGLBRpf4YNm7xpRhAAxkiIFTkk0UVX3ub24VSu3ZRod22f1
         wUeQfn/pTnR3H9zbPgw/4BqTShp+nnFwdqS4mK3e8jOv01l5REfs1REo2AVmHh63FB
         reo/+9szrIWSw==
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
Subject: [PATCH v4 09/54] clk: mediatek: mt2712-apmixedsys: Add .remove() callback for module build
Date:   Tue, 21 Feb 2023 12:55:04 +0100
Message-Id: <20230221115549.360132-10-angelogioacchino.delregno@collabora.com>
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

Add a .remove() callback to the apmixedsys driver to allow full module
build; while at it, also change the usage of builtin_platform_driver()
to module_platform_driver() to actually make use of the new callback.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index 1e1a8272a4ac..2f4061c9a59e 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -138,6 +138,18 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
+static int clk_mt2712_apmixed_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
 static const struct of_device_id of_match_clk_mt2712_apmixed[] = {
 	{ .compatible = "mediatek,mt2712-apmixedsys" },
 	{ /* sentinel */ }
@@ -145,9 +157,10 @@ static const struct of_device_id of_match_clk_mt2712_apmixed[] = {
 
 static struct platform_driver clk_mt2712_apmixed_drv = {
 	.probe = clk_mt2712_apmixed_probe,
+	.remove = clk_mt2712_apmixed_remove,
 	.driver = {
 		.name = "clk-mt2712-apmixed",
 		.of_match_table = of_match_clk_mt2712_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt2712_apmixed_drv)
+module_platform_driver(clk_mt2712_apmixed_drv)
-- 
2.39.1

