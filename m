Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126745B9A82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIOMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIOMKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:10:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27AB645A;
        Thu, 15 Sep 2022 05:09:49 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C22C56601FC5;
        Thu, 15 Sep 2022 13:09:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663243769;
        bh=RK8hmnYA9/Ua/srvkkHpq1mJKE2UO3eoI+MSMmIYKB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCZJp/IOyMypPw8N/qUi9fJT0Krp1rDKzMSHjICELzdlUL4h/nzpMg7gXLJYarmwN
         SUepuoiK6cRqq6MVxnNgPTjOj7djmsaI3lHs9m4WZobEuZFrvv6lRcR162qpalOqCc
         kD0XYHoB2BBmlnrjtGxVEvE1JxPjDK5sr2dJQYhvWoNxq+hkhJPM0IA351M+9MU4rx
         yuDR3XkYYmcMq3nekkPRBIwyqn0Wd8ugdSh+26IdkPQ5gzhh+roNX/DUP4cUbj+fJN
         nQM3wQnU379YAHeDQ6nmf31qlmPdT7AlUXMaoqxM0tHv80n4RSKF9zs8Cc5xhpEFiz
         28ILISpWrCt9A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] mmc: mtk-sd: Add support for MT6795 Helio X10
Date:   Thu, 15 Sep 2022 14:09:23 +0200
Message-Id: <20220915120923.86038-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
References: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
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

Add support for MT6795 with a new compatible string and platform data.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 572eb5d48813..df941438aef5 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -513,6 +513,19 @@ static const struct mtk_mmc_compatible mt6779_compat = {
 	.support_64g = true,
 };
 
+static const struct mtk_mmc_compatible mt6795_compat = {
+	.clk_div_bits = 8,
+	.recheck_sdio_irq = false,
+	.hs400_tune = true,
+	.pad_tune_reg = MSDC_PAD_TUNE,
+	.async_fifo = false,
+	.data_tune = false,
+	.busy_check = false,
+	.stop_clk_fix = false,
+	.enhance_rx = false,
+	.support_64g = false,
+};
+
 static const struct mtk_mmc_compatible mt7620_compat = {
 	.clk_div_bits = 8,
 	.recheck_sdio_irq = true,
@@ -593,6 +606,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
 	{ .compatible = "mediatek,mt6779-mmc", .data = &mt6779_compat},
+	{ .compatible = "mediatek,mt6795-mmc", .data = &mt6795_compat},
 	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
 	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
-- 
2.37.2

