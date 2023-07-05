Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAEB74813A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGEJmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjGEJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:42:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006E1713
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:42:43 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8EA8C6606FAF;
        Wed,  5 Jul 2023 10:42:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688550162;
        bh=ZA49h1P49IwOFaurPRFCaUbkBJXDbiP3QFwn/8w9YXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mV4KH6Tik3DJS6rQUo6x4eQBUvBlEjRnSNfVO1frmedsbfOBDMoo2yxZK0XyKrfdt
         lYTtOyvhF3QKiYdLAHENTAEMBmU1tcWRJi+VWgda/IyKk1aDeRunniLePfLUpNz3op
         alYtJ0kzCTgh0xRek8LIexewmkpnf8dWwhrc+x3WSchMIKG/P1gZMl5UuTua+0YxvV
         YrezsM7OTDUARq6baWioqk9TM2w/tFLb2rM7bntHXP35Nkgh792soERTl2XlSYwlia
         IKFRxUKrYcuTe66eXCsogXK3DP+90qICQ7Y6RRA4GmNDo3W7eQbJEAzPYLyaa2jMZ/
         ELOF2YTBuf7xQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Alexandre Mergnat <amergnat@baylibre.com>,
        CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v2 3/3] drm/mediatek: Use devm variant for pm_runtime_enable() when possible
Date:   Wed,  5 Jul 2023 11:42:32 +0200
Message-Id: <20230705094232.75904-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705094232.75904-1-angelogioacchino.delregno@collabora.com>
References: <20230705094232.75904-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the error path of return functions and drop the call to
pm_runtime_disable() in remove functions by switching to
devm_pm_runtime_enable() where possible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
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
index cfbc037a0f6d..0469076cf715 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -360,13 +360,13 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 
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
@@ -374,9 +374,6 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 static int mtk_disp_rdma_remove(struct platform_device *pdev)
 {
 	component_del(&pdev->dev, &mtk_disp_rdma_component_ops);
-
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index ae05d9660592..a5d811c37207 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -299,20 +299,20 @@ static int mtk_mdp_rdma_probe(struct platform_device *pdev)
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

