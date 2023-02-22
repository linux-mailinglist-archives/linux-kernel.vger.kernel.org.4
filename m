Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD569F236
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjBVJwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjBVJvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:51:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CC33756A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:50:09 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ECD2B66021B6;
        Wed, 22 Feb 2023 09:42:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058980;
        bh=ZVUGUSkQPIkJqJdXlquYlMTH70M4rX6hh28fX2ZpB5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icQqmQC1NwhnkaUQUa+HJKbglRLmbx/Cj2SKtRtzcRiAcaZ6bhD1Me/eThlsET4+i
         ujYA1sNyAbC9oPZFJYpa9XFob5Sx/YjCt4ShTyTalCwsz2Er43whYGhep8a2lvMUUH
         RyGA+0aIlYplbyCeYhJGCZ15xq/YKNHkZvkZNmAwwiDj5hAtK6901UscTnn1KpS865
         S9bZSHyzPYmPHneLMLyiUwBFEEO2/IJPz4qE7tZTzZHGDdA944Hwwowg+WftffoDX6
         nft5SV61zPfGuvYbc23A5utu3uh/YnAq0yL3fSR7UgphZZV1u2sJ93YcCnYJF9oBpi
         5G644Bm21xEWw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 1/9] soc: mediatek: mtk-mmsys: Add .remove() callback
Date:   Wed, 22 Feb 2023 10:42:45 +0100
Message-Id: <20230222094253.23678-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
References: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
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
2.39.2

