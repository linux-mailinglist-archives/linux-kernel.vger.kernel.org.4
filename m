Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929A169DFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjBUL7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjBUL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:58:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117328D04;
        Tue, 21 Feb 2023 03:57:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2ABEA66021E2;
        Tue, 21 Feb 2023 11:56:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676980596;
        bh=1YakjwGq+YZL7clOL4YsZ5ydzdoPF893Eh3JT3wYxho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIEyzdHTQgpmdiUE63UKRBQxk3BRnWeZkNUIa4bHPfunoX6W/nVa94TaT0oexf+VA
         QGp5iu9QjZ3II1ZUOKvxppWfpqZHj4p2VEQpRFRUEd0RpZSo4/WRE3OdlziKe1NBl5
         QC7lZVTIKz6Q1fQlSn2usy3+Ug1bBXKWSvMPaiy43Ofa8SOlTVDMaiqlByPOiD/ljI
         Oazqqw/HXUGXCFBrn3rHkZC61PrbCowoP2nm6BJeZ4WaNXmexqmM2swcdfcRs/aOPz
         FSWC8Y/xAbK8UOhLXLb5QrSNSMBag/ZYKI6MNC/56QQHcMh4u73TP/KAamoU4r98hN
         aMLblGBU3fZAg==
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
Subject: [PATCH v4 31/54] clk: mediatek: Propagate struct device with mtk_clk_register_dividers()
Date:   Tue, 21 Feb 2023 12:55:26 +0100
Message-Id: <20230221115549.360132-32-angelogioacchino.delregno@collabora.com>
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

Propagate struct device for divider clocks registered through clk-mtk
helpers to be able to get runtime PM support for MTK clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt2701.c            | 2 +-
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-mtk.c               | 8 +++++---
 drivers/clk/mediatek/clk-mtk.h               | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index dfe328f7a44b..e9c27b1364b6 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -681,7 +681,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 				    ARRAY_SIZE(top_muxes), base,
 				    &mt2701_clk_lock, clk_data);
 
-	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
+	mtk_clk_register_dividers(&pdev->dev, top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt2701_clk_lock, clk_data);
 
 	mtk_clk_register_gates(&pdev->dev, node, top_clks,
diff --git a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
index ebd90365be5f..27597fdeb6e9 100644
--- a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
@@ -109,7 +109,7 @@ static int clk_mt8167_apmixed_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = mtk_clk_register_dividers(adj_divs, ARRAY_SIZE(adj_divs), base,
+	ret = mtk_clk_register_dividers(dev, adj_divs, ARRAY_SIZE(adj_divs), base,
 					&mt8167_apmixed_clk_lock, clk_data);
 	if (ret)
 		goto unregister_plls;
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 01224cfbcc79..fd2214c3242f 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -393,7 +393,8 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_composites);
 
-int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
+int mtk_clk_register_dividers(struct device *dev,
+			      const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
 			      struct clk_hw_onecell_data *clk_data)
 {
@@ -412,7 +413,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			continue;
 		}
 
-		hw = clk_hw_register_divider(NULL, mcd->name, mcd->parent_name,
+		hw = clk_hw_register_divider(dev, mcd->name, mcd->parent_name,
 			mcd->flags, base +  mcd->div_reg, mcd->div_shift,
 			mcd->div_width, mcd->clk_divider_flags, lock);
 
@@ -535,7 +536,8 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	}
 
 	if (mcd->divider_clks) {
-		r = mtk_clk_register_dividers(mcd->divider_clks,
+		r = mtk_clk_register_dividers(&pdev->dev,
+					      mcd->divider_clks,
 					      mcd->num_divider_clks,
 					      base, mcd->clk_lock, clk_data);
 		if (r)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 554aecdc1015..b7a751861fce 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -202,7 +202,8 @@ struct mtk_clk_divider {
 		.div_width = _width,				\
 }
 
-int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
+int mtk_clk_register_dividers(struct device *dev,
+			      const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
 			      struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
-- 
2.39.1

