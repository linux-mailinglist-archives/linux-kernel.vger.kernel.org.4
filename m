Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863B768C165
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjBFPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjBFPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295D329E33;
        Mon,  6 Feb 2023 07:30:00 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C2CF46602EC7;
        Mon,  6 Feb 2023 15:29:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697399;
        bh=5Dp/IJ01q+sggFHscwN3Jk1mfKjZK08snEDtUhE6fwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkL4AxlfSNtdX//6EQOqDvqYFJG15dVPxKso18vfXyX0qFBchn8YSY3ZldqVnPKV3
         NE4/ESp6wE7tJKZ6Ro1GH7GQYMaMOWTFrakehpw1lHCCoHk4P1vfbuvMHav8glw+Lx
         W6glmLHN+hxw4jjX0PkcnXnkyVs/KToR4xR2eJrCF++xK3JV592qSNjhP8m1iaMK0q
         yrQ2rH/Jij2y4p7TD7jKUiaOJ3bcPVhm0bZnSuym/DxRpi+JlcZ3z1uegUAYc0LaON
         v8hXDt3mP/+wAuVGLepwY2A+Lmy+LqiieyKz5wF6lI5uWLNWlhOkz8tKCmg/iytGUy
         XtAsmePHZpGlA==
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
Subject: [PATCH v1 09/45] clk: mediatek: mt2712: Change to use module_platform_driver macro
Date:   Mon,  6 Feb 2023 16:28:52 +0100
Message-Id: <20230206152928.918562-10-angelogioacchino.delregno@collabora.com>
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

Now that all of the clocks in clk-mt2712.c are using the common
mtk_clk_simple_{probe,remove}() callbacks we can safely migrate
to module_platform_driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt2712.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index c5fd76d1b9df..65c1cbcbd54e 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1028,7 +1028,7 @@ static const struct of_device_id of_match_clk_mt2712_simple[] = {
 	{ /* sentinel */ }
 };
 
-static struct platform_driver clk_mt2712_simple_drv = {
+static struct platform_driver clk_mt2712_drv = {
 	.probe = mtk_clk_simple_probe,
 	.remove = mtk_clk_simple_remove,
 	.driver = {
@@ -1036,10 +1036,4 @@ static struct platform_driver clk_mt2712_simple_drv = {
 		.of_match_table = of_match_clk_mt2712_simple,
 	},
 };
-
-static int __init clk_mt2712_init(void)
-{
-	return platform_driver_register(&clk_mt2712_simple_drv);
-}
-
-arch_initcall(clk_mt2712_init);
+module_platform_driver(clk_mt2712_drv);
-- 
2.39.1

