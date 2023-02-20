Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9369CFDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjBTPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjBTPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:01:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2123D1DB9F;
        Mon, 20 Feb 2023 07:01:23 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6628660216A;
        Mon, 20 Feb 2023 15:01:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905281;
        bh=OUjfvjH+xela87xq+mZBbq7prhZGbEBP6ki4p+S2LtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6aw+B3/fUi/jCcCD66fPPzxu3BDYMORkI9dk4mFLYheFXVX9JJ2yT0PP2tYBIz2g
         hpmbH+IhN0860H2CIXlLxjtFFPScYnP8ZxqftOJjD7bcz6hI+3mJ9FLwA3HUCNdjzz
         om4ZA8ggQXNqG5kcM93La4JPdrBiD1hTSWw43tEtIE18PLDTu0Pc5wTLjaWwZ/Neir
         bMUDK2KWTJk97vEUpZ5aZzkV3hUFhQ8SG8FrtDSugXALEDSSRN2sUC0ldxzr+dYGSY
         Dq6hmoouUM/wDf4re6URRXDunN0R7MTI2ZbXP56SqyrWpBL55NhDHkX2qshOM0u7uJ
         cyR/IuEKmLbgQ==
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
Subject: [PATCH v3 04/55] clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()
Date:   Mon, 20 Feb 2023 16:00:20 +0100
Message-Id: <20230220150111.77897-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
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

Add support for divider clocks register/unregister in the common
mtk_clk_simple_probe() and mtk_clk_simple_remove() functions.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++--
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index a69d3f0a38c7..39bd360aa0c9 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -496,7 +496,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	/* Calculate how many clk_hw_onecell_data entries to allocate */
 	num_clks = mcd->num_clks + mcd->num_composite_clks;
 	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
-	num_clks += mcd->num_mux_clks;
+	num_clks += mcd->num_mux_clks + mcd->num_divider_clks;
 
 	clk_data = mtk_alloc_clk_data(num_clks);
 	if (!clk_data)
@@ -534,11 +534,19 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			goto unregister_muxes;
 	}
 
+	if (mcd->divider_clks) {
+		r = mtk_clk_register_dividers(mcd->divider_clks,
+					      mcd->num_divider_clks,
+					      base, mcd->clk_lock, clk_data);
+		if (r)
+			goto unregister_composites;
+	}
+
 	if (mcd->clks) {
 		r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks,
 					   mcd->num_clks, clk_data);
 		if (r)
-			goto unregister_composites;
+			goto unregister_dividers;
 	}
 
 	if (mcd->clk_notifier_func) {
@@ -567,6 +575,10 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 unregister_clks:
 	if (mcd->clks)
 		mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+unregister_dividers:
+	if (mcd->divider_clks)
+		mtk_clk_unregister_dividers(mcd->divider_clks,
+					    mcd->num_divider_clks, clk_data);
 unregister_composites:
 	if (mcd->composite_clks)
 		mtk_clk_unregister_composites(mcd->composite_clks,
@@ -599,6 +611,9 @@ static int __mtk_clk_simple_remove(struct platform_device *pdev,
 	of_clk_del_provider(node);
 	if (mcd->clks)
 		mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+	if (mcd->divider_clks)
+		mtk_clk_unregister_dividers(mcd->divider_clks,
+					    mcd->num_divider_clks, clk_data);
 	if (mcd->composite_clks)
 		mtk_clk_unregister_composites(mcd->composite_clks,
 					      mcd->num_composite_clks, clk_data);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index b8e0ff8f52fa..554aecdc1015 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -222,6 +222,8 @@ struct mtk_clk_desc {
 	size_t num_clks;
 	const struct mtk_composite *composite_clks;
 	size_t num_composite_clks;
+	const struct mtk_clk_divider *divider_clks;
+	size_t num_divider_clks;
 	const struct mtk_fixed_clk *fixed_clks;
 	size_t num_fixed_clks;
 	const struct mtk_fixed_factor *factor_clks;
-- 
2.39.1

