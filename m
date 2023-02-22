Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D169F16B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjBVJ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjBVJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:26:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA96037543;
        Wed, 22 Feb 2023 01:26:06 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 889CF66021C8;
        Wed, 22 Feb 2023 09:26:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677057965;
        bh=PZs5wdP/t1w765jNm6To6HjMlHPQzqqkeY9IbGaKLfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iD6IGv7aRsA1jjsBXyn7Mwnk78AyqBq+vEJsL++fQUdBDv7lRMV6zCxx4tAiPkns/
         56p9dIZd+MHst2l5Y8jyQcSJYB9vLpvBeL3tLsPbV5xDIjx/MiUt9APAXB7V7ryJkZ
         +S630AO3Hc6M/xyo2TM+T2axd3tRv6EiFVTTvZBNMK15uNJdORQMq4zOHnX/E/BKWN
         le0FGHg7eP/vD1Uzj83FA9DI+wXjRRMBdtTe+rcdpuvzOu/2WsjPTb6JO2sMR4vpGX
         P0U2aGKXQTz/qNY0wr4OhhojmPlt1ZcPPR/goalFTfwdGmuVis5Cv91q46m7ALSnvi
         ylcuJOXlpMvew==
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
Subject: [PATCH v5 07/54] clk: mediatek: mt2712: Add error handling to clk_mt2712_apmixed_probe()
Date:   Wed, 22 Feb 2023 10:24:56 +0100
Message-Id: <20230222092543.19187-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com>
References: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com>
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

This function was completely missing error handling: add it.

Fixes: e2f744a82d72 ("clk: mediatek: Add MT2712 clock support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt2712.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index ce28ee47f5cf..8aa361f0fa13 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1091,15 +1091,25 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (r)
+		goto free_clk_data;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r) {
+		dev_err(&pdev->dev, "Cannot register clock provider: %d\n", r);
+		goto unregister_plls;
+	}
 
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+	return 0;
 
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
 	return r;
 }
 
-- 
2.39.2

