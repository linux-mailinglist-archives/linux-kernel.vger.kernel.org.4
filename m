Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01495710B82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbjEYLxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbjEYLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:53:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81797
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:53:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E43E966059A5;
        Thu, 25 May 2023 12:53:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685015585;
        bh=WbEXo3O6eq8DNbznstqMaJK9I2AdQzGF7reesP/HlpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObeEAKew/EV4k/4CVn0x6SQOFrwwbDVAZ+FzbB0+wvCKGDBeg/9srQrx0mOXI+ckk
         5POE11Zgw03CbyOWK3pRg5RpWyU0uLBALigsVQ1Dr63r8pCbG24+5HACVAyjRiKwWa
         +6XxDcIxkgnIEvkLe3u4APBEPIjTaaF8CPTnFkEAyTOt1dbh0AWwOfFjGuWDwpDlNi
         8aKtkrokLq701yCDGSKAV79QoO9IlZcGaFEBUFZP1hqLz8ETJvLP7vV+NyJtVRryUX
         4J6axsXdvNOStwOzSEONcc3M9M6ulB/qPzNREHy4RS5DMc9BRehDp5DE674Q6skiHT
         UWM7nCvMnHhuQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 2/3] phy: mediatek: mipi-dsi: Use devm variant for of_clk_add_hw_provider()
Date:   Thu, 25 May 2023 13:52:57 +0200
Message-Id: <20230525115258.90091-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525115258.90091-1-angelogioacchino.delregno@collabora.com>
References: <20230525115258.90091-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm_of_clk_add_hw_provider() in the probe function: this
also allows to entirely remove the .remove_new() callback, as its
only task was to unregister the clock provider.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index 362145198ff5..4e75c34c819b 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -176,12 +176,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 
 	mtk_mipi_tx_get_calibration_datal(mipi_tx);
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get, &mipi_tx->pll_hw);
-}
-
-static void mtk_mipi_tx_remove(struct platform_device *pdev)
-{
-	of_clk_del_provider(pdev->dev.of_node);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &mipi_tx->pll_hw);
 }
 
 static const struct of_device_id mtk_mipi_tx_match[] = {
@@ -197,7 +192,6 @@ MODULE_DEVICE_TABLE(of, mtk_mipi_tx_match);
 
 static struct platform_driver mtk_mipi_tx_driver = {
 	.probe = mtk_mipi_tx_probe,
-	.remove_new = mtk_mipi_tx_remove,
 	.driver = {
 		.name = "mediatek-mipi-tx",
 		.of_match_table = mtk_mipi_tx_match,
-- 
2.40.1

