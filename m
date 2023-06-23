Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17C973B41E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjFWJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjFWJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:49:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F610D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:49:56 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31BEE660713C;
        Fri, 23 Jun 2023 10:49:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687513794;
        bh=MkXZsqFyUy7SE+zL4LXq7zo0P/X6WUclHPmpBmU5Bx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F13gIFdQcQLSBbLmWexiyclkOSf+R20PvcbJzY36nEHZa6oJ4OnRECXihRpvwKBxU
         NNLXN4I1msPWgMSIlmY8ix6jZAQA2KaaWOorRGHOBQr5o1zxB5WNPurVT9fzQrfCue
         2s3KNplisoeCl88g/pJklEEyFp9EGj1qzdobDEiM/fX3fASuB4tmo9XyDf1Aq3APjt
         hwku9lE5KVIH3cNgK9RAyLLeuHlYPtrVyPTCBA/UdPjbCWT/vlj7Gc7gUj36BAf16V
         IfELc+74Qr5KCWMVXkWTPV35J5QgFJ7NwJdHLh08jixH+onpudohOn6GDbXfuDI8iL
         DhVEHQpXGafRg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        wenst@chromium.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 3/3] drm/mediatek: Move CMDQ setup to mtk_drm_cmdq_init() function
Date:   Fri, 23 Jun 2023 11:49:31 +0200
Message-Id: <20230623094931.117918-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623094931.117918-1-angelogioacchino.delregno@collabora.com>
References: <20230623094931.117918-1-angelogioacchino.delregno@collabora.com>
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

In order to enhance human readability, separating the optional
CMDQ mailbox initialization from the rest of the CRTC creation
machinery, move it to a new mtk_drm_cmdq_init() function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 83 ++++++++++++++-----------
 1 file changed, 48 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 88c63330a421..bff65c8c6a0e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -826,6 +826,48 @@ struct device *mtk_drm_crtc_dma_dev_get(struct drm_crtc *crtc)
 	return mtk_crtc->dma_dev;
 }
 
+static int mtk_drm_cmdq_init(struct device *dev, struct mtk_drm_private *priv,
+			     struct mtk_drm_crtc *mtk_crtc)
+{
+	int ret;
+
+	mtk_crtc->cmdq_client = cmdq_mbox_create(mtk_crtc->mmsys_dev, priv->mbox_index);
+	if (IS_ERR(mtk_crtc->cmdq_client)) {
+		ret = PTR_ERR(mtk_crtc->cmdq_client);
+		dev_dbg(dev, "Failed to create CMDQ client: %d\n", ret);
+		goto error;
+	}
+
+	/* Setup the CMDQ handler callback */
+	mtk_crtc->cmdq_client->priv = mtk_crtc;
+	mtk_crtc->cmdq_client->client.rx_callback = ddp_cmdq_cb;
+
+	ret = of_property_read_u32_index(priv->mutex_node, "mediatek,gce-events",
+					 priv->mbox_index, &mtk_crtc->cmdq_event);
+	if (ret) {
+		dev_dbg(dev, "Failed to get mediatek,gce-events: %d\n", ret);
+		goto free_mbox;
+	}
+
+	mtk_crtc->cmdq_handle = cmdq_pkt_create(mtk_crtc->cmdq_client, PAGE_SIZE);
+	if (IS_ERR(mtk_crtc->cmdq_handle)) {
+		ret = PTR_ERR(mtk_crtc->cmdq_handle);
+		dev_err(dev, "Failed to create cmdq packet: %d\n", ret);
+		goto free_mbox;
+	}
+
+	/* for sending blocking cmd in crtc disable */
+	init_waitqueue_head(&mtk_crtc->cb_blocking_queue);
+
+	return 0;
+
+free_mbox:
+	cmdq_mbox_destroy(mtk_crtc->cmdq_client);
+error:
+	mtk_crtc->cmdq_client = NULL;
+	return ret;
+}
+
 int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			const unsigned int *path, unsigned int path_len,
 			int priv_data_index)
@@ -942,42 +984,13 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, has_ctm, gamma_lut_size);
 	mutex_init(&mtk_crtc->hw_lock);
 
-	i = priv->mbox_index++;
-
-	mtk_crtc->cmdq_client = cmdq_mbox_create(mtk_crtc->mmsys_dev, i);
-	if (IS_ERR(mtk_crtc->cmdq_client)) {
-		ret = PTR_ERR(mtk_crtc->cmdq_client);
-		dev_dbg(dev, "Failed to create CMDQ client: %d\n", ret);
-		mtk_crtc->cmdq_client = NULL;
-		return 0;
-	}
-
-	/* Setup the CMDQ handler callback */
-	mtk_crtc->cmdq_client->priv = mtk_crtc;
-	mtk_crtc->cmdq_client->client.rx_callback = ddp_cmdq_cb;
+	ret = mtk_drm_cmdq_init(dev, priv, mtk_crtc);
+	if (ret)
+		dev_info(dev, "No CMDQ support for CRTC%d: using CPU writes\n",
+			 drm_crtc_index(&mtk_crtc->base));
 
-	if (mtk_crtc->cmdq_client) {
-		ret = of_property_read_u32_index(priv->mutex_node,
-						 "mediatek,gce-events",
-						 i,
-						 &mtk_crtc->cmdq_event);
-		if (ret) {
-			dev_dbg(dev, "mtk_crtc %d failed to get mediatek,gce-events property\n",
-				drm_crtc_index(&mtk_crtc->base));
-			cmdq_mbox_destroy(mtk_crtc->cmdq_client);
-			mtk_crtc->cmdq_client = NULL;
-		} else {
-			mtk_crtc->cmdq_handle = cmdq_pkt_create(mtk_crtc->cmdq_client, PAGE_SIZE);
-			if (ret) {
-				dev_dbg(dev, "mtk_crtc %d failed to create cmdq packet\n",
-					drm_crtc_index(&mtk_crtc->base));
-				cmdq_mbox_destroy(mtk_crtc->cmdq_client);
-				mtk_crtc->cmdq_client = NULL;
-			}
-		}
+	/* Unconditionally increment mbox_index */
+	priv->mbox_index++;
 
-		/* for sending blocking cmd in crtc disable */
-		init_waitqueue_head(&mtk_crtc->cb_blocking_queue);
-	}
 	return 0;
 }
-- 
2.40.1

