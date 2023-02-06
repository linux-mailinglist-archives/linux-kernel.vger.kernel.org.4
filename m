Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4468C158
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBFPaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjBFP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:29:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3412E394;
        Mon,  6 Feb 2023 07:29:50 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 233C26602EC7;
        Mon,  6 Feb 2023 15:29:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697389;
        bh=G0HG+qmJYUnrLYagRyzBUPOwUKMEZtk1j8rbZWXyBs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7QLPL3EqbrOzlJkD2NFey8aGJzodmydXiBPpvSF8AsXToiZo67/zcvph6KLTes2a
         dkiC5ACX5E5uPvyJue9zRl5KX0gTcL9Qo978KA82Ii7vW0mK4ntSP3Tfl2nh1UrDkQ
         x10zY8yW5hZUV1jR1xM5Eg1jzW2v8E/g7mc4RmajgJGm/Ytabd9TCojdpNX8oJX3Qq
         wI+EGq4z2OM2N7qeaxvW9GXPGt6D79wBusrijofgyskTrXPMPYA8fa8iZhAO8pmBig
         nSgFvEURSTmSd229XPgQ/5iPWuzTgwz/cSpn8zSvvOkmELyLVSFsdxTsL0ZJooBJax
         EvX8SBNVR6sLg==
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
Subject: [PATCH v1 02/45] clk: mediatek: clk-mtk: Introduce clk_mtk_pdev_{probe,remove}()
Date:   Mon,  6 Feb 2023 16:28:45 +0100
Message-Id: <20230206152928.918562-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
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

Introduce functions clk_mtk_pdev_probe() and clk_mtk_pdev_remove():
these will be useful to commonize the probe and remove handlers for
multimedia (clk-mtxxxx-mm) drivers as these are registered by the
mtk-mmsys driver instead of having their own devicetree compatible.

In order to do this, the main logic of clk_mtk_simple{probe,remove}()
was moved to new static __clk_mtk_simple_{probe,remove}() functions
that take as parameter a pointer to struct device_node because when
registering the clocks from mtk-mmsys we want to pass a pointer to
the clock driver's parent (which is, obviously, mtk-mmsys) struct
device_node instead.

As for the clock driver's platform data: for the devicetree case, we
keep using the standard match_data mechanism, else we retrieve it
from an id_table.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.c | 54 +++++++++++++++++++++++++++++-----
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 71eb591cd00c..a69d3f0a38c7 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -462,17 +462,25 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_dividers);
 
-int mtk_clk_simple_probe(struct platform_device *pdev)
+static int __mtk_clk_simple_probe(struct platform_device *pdev,
+				  struct device_node *node)
 {
+	const struct platform_device_id *id;
 	const struct mtk_clk_desc *mcd;
 	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
 	int num_clks, r;
 
 	mcd = device_get_match_data(&pdev->dev);
-	if (!mcd)
-		return -EINVAL;
+	if (!mcd) {
+		/* Clock driver wasn't registered from devicetree */
+		id = platform_get_device_id(pdev);
+		if (id)
+			mcd = (const struct mtk_clk_desc *)id->driver_data;
+
+		if (!mcd)
+			return -EINVAL;
+	}
 
 	/* Composite clocks needs us to pass iomem pointer */
 	if (mcd->composite_clks) {
@@ -581,13 +589,12 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 		iounmap(base);
 	return r;
 }
-EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
 
-int mtk_clk_simple_remove(struct platform_device *pdev)
+static int __mtk_clk_simple_remove(struct platform_device *pdev,
+				   struct device_node *node)
 {
-	const struct mtk_clk_desc *mcd = device_get_match_data(&pdev->dev);
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
+	const struct mtk_clk_desc *mcd = device_get_match_data(&pdev->dev);
 
 	of_clk_del_provider(node);
 	if (mcd->clks)
@@ -608,6 +615,37 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
 
 	return 0;
 }
+
+int mtk_clk_pdev_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+
+	return __mtk_clk_simple_probe(pdev, node);
+}
+EXPORT_SYMBOL_GPL(mtk_clk_pdev_probe);
+
+int mtk_clk_simple_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+
+	return __mtk_clk_simple_probe(pdev, node);
+}
+EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
+
+int mtk_clk_pdev_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+
+	return __mtk_clk_simple_remove(pdev, node);
+}
+EXPORT_SYMBOL_GPL(mtk_clk_pdev_remove);
+
+int mtk_clk_simple_remove(struct platform_device *pdev)
+{
+	return __mtk_clk_simple_remove(pdev, pdev->dev.of_node);
+}
 EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 41f4fa3b0c21..b8e0ff8f52fa 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -236,6 +236,8 @@ struct mtk_clk_desc {
 	unsigned int mfg_clk_idx;
 };
 
+int mtk_clk_pdev_probe(struct platform_device *pdev);
+int mtk_clk_pdev_remove(struct platform_device *pdev);
 int mtk_clk_simple_probe(struct platform_device *pdev);
 int mtk_clk_simple_remove(struct platform_device *pdev);
 
-- 
2.39.1

