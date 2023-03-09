Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938E6B215B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCIK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjCIK01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:26:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20BF62312
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:26:24 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13C866603054;
        Thu,  9 Mar 2023 10:26:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678357583;
        bh=gUunv/EcOHFtFDQHosEszweFGXYKJo+Qxwm9e5tgDK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFQjt7Nt3VV33wLDJnIDEHUq9cZ64qD7KMR68RpQhK0+8xOCXDcDLbyc6agKE7Crr
         Too/qCOHCpxUcafXfijL8czDm5WxJVkGbjP5bOrUMohi2AUO0N0ppjKWWeHacFFkr/
         Y9Y7cZATRKWRfLtvtUWYfdcA+egpN2uZLlzsmJpejqoKLH8Ybjdj1GHeaMfjUQFOMq
         pVC++sat6e1YO5tlS7dU108rmzHYMqJNKiLhUPbKndu5V5bfexrTUufKQV0GiPp3bG
         hCktQr4fntPXZ/MAlnctsTUamAsXxVGhy8QfPr3KI3ghTIxDLFQjdyWjtPJqufRO5Z
         tpeEcldG/hjKA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 3/3] soc: mediatek: mtk-mmsys: Add support for MT6795 Helio X10
Date:   Thu,  9 Mar 2023 11:26:18 +0100
Message-Id: <20230309102618.114157-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309102618.114157-1-angelogioacchino.delregno@collabora.com>
References: <20230309102618.114157-1-angelogioacchino.delregno@collabora.com>
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

Add MMSYS support for the MT6795 SoC using the same mmsys routing
table as MT8173 as, for the currently supported usecases (DSI0, DPI0
with no WDMA), these are identical.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index c4eeab99756b..9619faa796e8 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -41,6 +41,14 @@ static const struct mtk_mmsys_driver_data mt6779_mmsys_driver_data = {
 	.clk_driver = "clk-mt6779-mm",
 };
 
+static const struct mtk_mmsys_driver_data mt6795_mmsys_driver_data = {
+	.clk_driver = "clk-mt6795-mm",
+	.routes = mt8173_mmsys_routing_table,
+	.num_routes = ARRAY_SIZE(mt8173_mmsys_routing_table),
+	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
+	.num_resets = 64,
+};
+
 static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
 	.clk_driver = "clk-mt6797-mm",
 };
@@ -416,6 +424,7 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 	{ .compatible = "mediatek,mt2701-mmsys", .data = &mt2701_mmsys_driver_data },
 	{ .compatible = "mediatek,mt2712-mmsys", .data = &mt2712_mmsys_driver_data },
 	{ .compatible = "mediatek,mt6779-mmsys", .data = &mt6779_mmsys_driver_data },
+	{ .compatible = "mediatek,mt6795-mmsys", .data = &mt6795_mmsys_driver_data },
 	{ .compatible = "mediatek,mt6797-mmsys", .data = &mt6797_mmsys_driver_data },
 	{ .compatible = "mediatek,mt8167-mmsys", .data = &mt8167_mmsys_driver_data },
 	{ .compatible = "mediatek,mt8173-mmsys", .data = &mt8173_mmsys_driver_data },
-- 
2.39.2

