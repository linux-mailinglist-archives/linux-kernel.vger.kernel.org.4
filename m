Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF596AC25C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCFOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCFOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB204303F4;
        Mon,  6 Mar 2023 06:06:50 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDEED6602FA2;
        Mon,  6 Mar 2023 14:06:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111564;
        bh=NtmeE+eeh8ruhnGAQGPiV2EGNcavUpCXpCbwzrlNZiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRL2dSR7IDSYt/yrrk8G3El46IRx+po6ec3c6HXjD2iMP0JNLGquv8QO8p+enmAO2
         ndFNas7+XfoBUxMAxyOosic1C+hIrd3ec7kF6zoi8yAX4Jzo6DFudD0dFKkLVpSmJQ
         dOaBVMylaF56py55B+J7QapWISlY9c/j2f+fyTQowz1qmfW2LjBE1bkYMULQuzesEj
         Cf0WDaZQ9ABgpi47BpPXmZGiXw3EoOmDST14IB6PBLzASgeXiBbsqfX5wQ9pDLV7eX
         V1biF1LYOvFREcy75F/k9/1ZtaGAzxnw8Y5sEZAYTOqgPvLxquXobniGlt7zwYyInx
         d1tYLImkZZLaQ==
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v6 10/54] clk: mediatek: mt2712: Change to use module_platform_driver macro
Date:   Mon,  6 Mar 2023 15:04:59 +0100
Message-Id: <20230306140543.1813621-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
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
While at it, also drop all references to `simple` in the specific
context of mt2712 as that was used in the past only to allow us
to have two platform_driver(s) in one file.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt2712.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index c5fd76d1b9df..937c370d6765 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1020,7 +1020,7 @@ static const struct mtk_clk_desc peri_desc = {
 	.rst_desc = &clk_rst_desc[1],
 };
 
-static const struct of_device_id of_match_clk_mt2712_simple[] = {
+static const struct of_device_id of_match_clk_mt2712[] = {
 	{ .compatible = "mediatek,mt2712-infracfg", .data = &infra_desc },
 	{ .compatible = "mediatek,mt2712-mcucfg", .data = &mcu_desc },
 	{ .compatible = "mediatek,mt2712-pericfg", .data = &peri_desc, },
@@ -1028,18 +1028,12 @@ static const struct of_device_id of_match_clk_mt2712_simple[] = {
 	{ /* sentinel */ }
 };
 
-static struct platform_driver clk_mt2712_simple_drv = {
+static struct platform_driver clk_mt2712_drv = {
 	.probe = mtk_clk_simple_probe,
 	.remove = mtk_clk_simple_remove,
 	.driver = {
-		.name = "clk-mt2712-simple",
-		.of_match_table = of_match_clk_mt2712_simple,
+		.name = "clk-mt2712",
+		.of_match_table = of_match_clk_mt2712,
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
2.39.2

