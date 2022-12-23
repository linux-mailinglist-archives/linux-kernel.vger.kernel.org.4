Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833AC654E97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiLWJn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbiLWJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:43:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D93578D;
        Fri, 23 Dec 2022 01:43:11 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC2996602CE4;
        Fri, 23 Dec 2022 09:43:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671788590;
        bh=X/oZl8ocJQt071EbQHuHIaXUvTU5xZlpFyUlUhGeBQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDtyaEv3S2dKjskptbhe/8wP1Sfd0jjFw2TV26gHba+HAigLa9n2QOudgFaAcwXQf
         oOQ2tPUv5ajYu9c0AFSFbI+A/9NWvVakV6CLROPFxH8QQJCujpLi7c83cjMJ3/6+3m
         /Uie+lHV5M6mde2SZCsmnJkOOOiVCxG7b0EZyXo0eqLnJ+mfpyS+HMNennF5KSTX6I
         8oSB2taVxBGwOoaRz6B84Mh1ysmBvXNpe62AHaX+KBPWw11fFKgFvFYz50msjJ9VOG
         SLs9/yDWEaA3OmwEtkCiKUafMDglozUqUk4By1uDCO1EOhXzILca/b9XUxkwPhHnQO
         rhy6RBORwgE1A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 02/23] clk: mediatek: mt8192: Propagate struct device for gate clocks
Date:   Fri, 23 Dec 2022 10:42:38 +0100
Message-Id: <20221223094259.87373-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
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

Convert instances of mtk_clk_register_gates() to use the newer
mtk_clk_register_gates_with_dev() to propagate struct device to
the clk framework.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8192.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index eff66ca6c6a7..991d78a71644 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1127,7 +1127,8 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_top_composites;
 
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	r = mtk_clk_register_gates_with_dev(node, top_clks, ARRAY_SIZE(top_clks),
+					    top_clk_data, &pdev->dev);
 	if (r)
 		goto unregister_adj_divs_composites;
 
@@ -1167,7 +1168,8 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks), clk_data);
+	r = mtk_clk_register_gates_with_dev(node, infra_clks, ARRAY_SIZE(infra_clks),
+					    clk_data, &pdev->dev);
 	if (r)
 		goto free_clk_data;
 
@@ -1198,7 +1200,8 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks), clk_data);
+	r = mtk_clk_register_gates_with_dev(node, peri_clks, ARRAY_SIZE(peri_clks),
+					    clk_data, &pdev->dev);
 	if (r)
 		goto free_clk_data;
 
@@ -1226,7 +1229,9 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	r = mtk_clk_register_gates_with_dev(node, apmixed_clks,
+					    ARRAY_SIZE(apmixed_clks), clk_data,
+					    &pdev->dev);
 	if (r)
 		goto free_clk_data;
 
-- 
2.39.0

