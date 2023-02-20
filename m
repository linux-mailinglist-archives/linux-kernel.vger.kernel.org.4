Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6416969CFDC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjBTPBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjBTPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:01:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E4F1D90A;
        Mon, 20 Feb 2023 07:01:19 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F54F6602166;
        Mon, 20 Feb 2023 15:01:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905277;
        bh=l5BdwmfyxbZlaujYTSJF7PTIlSpQy1drDejxx2IavtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9k3WpRwohnh0ddpZBv2F8RzE2vZ8ybMmqPZ3Ol+zbDQ8DevqOR15+5wuoRGu/L/X
         hOowa9m7SNzaY51EuCVlT17vgVyhGWbWGEogWs076oXe6Fp21dWj576jUOFVaMM1ed
         Q+Xtl27e0I5oWtH+ZWCh3up7LxbSqAYsYP2Py3Vdho7H+U8/i4U12Xel5vfX90Vx3f
         V7z4B1Et8q3j86dr5yXgY/udJTrGa8IxpG7LWaLjbpoxpKa8GnNzvGvcPhSVHHy9YN
         Y6nkeZvlH0yQxC/e0dzYE+QibiSHiWAUaMteXYqnTUrU+MtAGyPuavQk3xIhYmDEci
         3f7vka0niC4xg==
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
Subject: [PATCH v3 01/55] clk: mediatek: clk-mtk: Switch to device_get_match_data()
Date:   Mon, 20 Feb 2023 16:00:17 +0100
Message-Id: <20230220150111.77897-2-angelogioacchino.delregno@collabora.com>
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

Instead of using of_device_get_match_data(), switch to the generic
device_get_match_data().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index c90c0a6b501b..71eb591cd00c 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -471,7 +470,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int num_clks, r;
 
-	mcd = of_device_get_match_data(&pdev->dev);
+	mcd = device_get_match_data(&pdev->dev);
 	if (!mcd)
 		return -EINVAL;
 
@@ -586,7 +585,7 @@ EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
 
 int mtk_clk_simple_remove(struct platform_device *pdev)
 {
-	const struct mtk_clk_desc *mcd = of_device_get_match_data(&pdev->dev);
+	const struct mtk_clk_desc *mcd = device_get_match_data(&pdev->dev);
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
-- 
2.39.1

