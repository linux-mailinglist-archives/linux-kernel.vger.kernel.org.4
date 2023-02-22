Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E933469F163
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjBVJ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjBVJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:26:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80536FEA;
        Wed, 22 Feb 2023 01:26:02 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FF0E66021B8;
        Wed, 22 Feb 2023 09:26:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677057961;
        bh=hSGa7szYltNHYfF7VDCLcccXM0USbKMIgzzF1e2tU3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMzcbB8kj1AOWr1f0tho0bJpNhW8V53EeiNPInC4tYfo21ggruN1uyzYDXme9/nlx
         y2V4dmG/NbrrmS3MMK0BecImRB17UncyaGHVMccSZvzIK7nhTK5qWUhC5Iyxxlo5uw
         X+ka9c0ENHgg4ncQTWT1NpqPfu4Mdy+98tM2k4XI34+SoY5Sznv8TgdUW6S6iB8/WR
         qWHYx4+oqmGbgS2H0fpN6YV2S2tM5uergjiDB1NRi+U99nLJlJZgQVlcJeKbFyGaRA
         wrXUfbu84Oke8Oou18waGNcmXopsQj4qSy+CJaH0D638SGmThM9GghKL6Ywcu3p6BM
         PvLzquoQl2Z9Q==
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
Subject: [PATCH v5 04/54] clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()
Date:   Wed, 22 Feb 2023 10:24:53 +0100
Message-Id: <20230222092543.19187-5-angelogioacchino.delregno@collabora.com>
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

Add support for divider clocks register/unregister in the common
mtk_clk_simple_probe() and mtk_clk_simple_remove() functions.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Miles Chen <miles.chen@mediatek.com> 
---
 drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++--
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 990be3d62db2..01224cfbcc79 100644
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
2.39.2

