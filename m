Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71505699508
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBPNAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBPNA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F43D093
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:28 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0F9C466021A7;
        Thu, 16 Feb 2023 13:00:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552427;
        bh=aV8H9evkGIGxgmY7AlHOpoZNvivT9tsnpJVfzGVs75w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdPuBjf4bPrNG7JbHkJR4OiT3AqdweyqmhRhYHQ7lQiOEsWfOmWcD9duf+J3dwrqQ
         MifxDGSWB3HSp4XMwNSJjDwuocPYq/KNhK1Lxf5aWChmOSiUjm4TYNe02lo0fxdFN0
         6XzukJfWHcHBrJIPtR82ecAMuz4fAcolfWLff3Pt2qUCTIGt3Ff1I3nRaIdBmtz+OH
         in37bheZb2yMsiPh/wMqjDxWhh3YnHlm2gqEwewthh2Jx3ESC1xLMzgZEk2PrFDpvK
         XqBKPp8LT9iFcr6YMmTEbjJ2O5zbU/9Ak8up0tGT31ZkBza/T9peOyaf6UPTruhrBZ
         oaYZbUzM2E2HQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 1/9] soc: mediatek: mtk-mmsys: Add .remove() callback
Date:   Thu, 16 Feb 2023 14:00:13 +0100
Message-Id: <20230216130021.64875-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
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

Add a .remove() callback to correctly unregister the multimedia clocks
and DRM drivers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index eb4c7e57896c..af22f3490034 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -121,6 +121,8 @@ static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
 struct mtk_mmsys {
 	void __iomem *regs;
 	const struct mtk_mmsys_driver_data *data;
+	struct platform_device *clks_pdev;
+	struct platform_device *drm_pdev;
 	spinlock_t lock; /* protects mmsys_sw_rst_b reg */
 	struct reset_controller_dev rcdev;
 	struct cmdq_client_reg cmdq_base;
@@ -342,6 +344,7 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 					     PLATFORM_DEVID_AUTO, NULL, 0);
 	if (IS_ERR(clks))
 		return PTR_ERR(clks);
+	mmsys->clks_pdev = clks;
 
 	if (mmsys->data->is_vppsys)
 		goto out_probe_done;
@@ -352,11 +355,22 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		platform_device_unregister(clks);
 		return PTR_ERR(drm);
 	}
+	mmsys->drm_pdev = drm;
 
 out_probe_done:
 	return 0;
 }
 
+static int mtk_mmsys_remove(struct platform_device *pdev)
+{
+	struct mtk_mmsys *mmsys = platform_get_drvdata(pdev);
+
+	platform_device_unregister(mmsys->drm_pdev);
+	platform_device_unregister(mmsys->clks_pdev);
+
+	return 0;
+}
+
 static const struct of_device_id of_match_mtk_mmsys[] = {
 	{
 		.compatible = "mediatek,mt2701-mmsys",
@@ -431,6 +445,7 @@ static struct platform_driver mtk_mmsys_drv = {
 		.of_match_table = of_match_mtk_mmsys,
 	},
 	.probe = mtk_mmsys_probe,
+	.remove = mtk_mmsys_remove,
 };
 
 static int __init mtk_mmsys_init(void)
-- 
2.39.1

