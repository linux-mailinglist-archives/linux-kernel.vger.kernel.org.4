Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396FB727C75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjFHKM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjFHKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:12:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB071FE9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:12:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71D4E6606F1A;
        Thu,  8 Jun 2023 11:12:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686219136;
        bh=GF4tnzCtxsr9pdT5eSOLmXcycHAMUaVktq69YdpqlWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E29PLG/Tj1opqJNtGeFTedq78BigBGJIcADohPpl9ZRpudFoszPwXsWSDTV5lM0Kv
         j+QQFw5bR7W44IW9Y7cPpEc0XSDJJbbKeFInwunr4XtKULug914RAv4RtxLXcPhk2k
         K1ES4eZ0h0Kayu3bsvMtfYXRQgt32Y7ZIUKBgWh13JHDbj7IdXISbRiv9tvm3YC6Dk
         cxS2Sq56DztBFW2+7ZS0/pOc+M7Pz2y6zeuhBl4XB8RqSMiJI21IodfPoIgfRCex/N
         r4oRj7T1yA3B28K1LlYka+mCw5HsGFSplBNWZM5ONI+kmv/HrlHgbLHqkHbumg+dbs
         a4350tnuOQXDA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 3/3] drm/mediatek: Use devm variant for pm_runtime_enable() when possible
Date:   Thu,  8 Jun 2023 12:12:09 +0200
Message-Id: <20230608101209.126499-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608101209.126499-1-angelogioacchino.delregno@collabora.com>
References: <20230608101209.126499-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the error path of return functions and drop the call to
pm_runtime_disable() in remove functions by switching to
devm_pm_runtime_enable() where possible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c |  9 ++++-----
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c        | 11 ++++-------
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         | 10 +++++-----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 1993b688befa..14e8ad6c78c3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -519,13 +519,13 @@ static int mtk_disp_ovl_adaptor_probe(struct platform_device *pdev)
 
 	component_master_add_with_match(dev, &mtk_disp_ovl_adaptor_master_ops, match);
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	ret = component_add(dev, &mtk_disp_ovl_adaptor_comp_ops);
-	if (ret) {
-		pm_runtime_disable(dev);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add component\n");
-	}
 
 	return 0;
 }
@@ -533,7 +533,6 @@ static int mtk_disp_ovl_adaptor_probe(struct platform_device *pdev)
 static int mtk_disp_ovl_adaptor_remove(struct platform_device *pdev)
 {
 	component_master_del(&pdev->dev, &mtk_disp_ovl_adaptor_master_ops);
-	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 307be35b59fc..5e90b6d593f5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -361,13 +361,13 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	ret = component_add(dev, &mtk_disp_rdma_component_ops);
-	if (ret) {
-		pm_runtime_disable(dev);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add component\n");
-	}
 
 	return 0;
 }
@@ -375,9 +375,6 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 static int mtk_disp_rdma_remove(struct platform_device *pdev)
 {
 	component_del(&pdev->dev, &mtk_disp_rdma_component_ops);
-
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index ed519b5a3273..93ef05ec9720 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -300,20 +300,20 @@ static int mtk_mdp_rdma_probe(struct platform_device *pdev)
 #endif
 	platform_set_drvdata(pdev, priv);
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	ret = component_add(dev, &mtk_mdp_rdma_component_ops);
-	if (ret) {
-		pm_runtime_disable(dev);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add component\n");
-	}
+
 	return 0;
 }
 
 static int mtk_mdp_rdma_remove(struct platform_device *pdev)
 {
 	component_del(&pdev->dev, &mtk_mdp_rdma_component_ops);
-	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
-- 
2.40.1

