Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05757749BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGFMao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGFMag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:30:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09535E72
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:30:35 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 265726606FC6;
        Thu,  6 Jul 2023 13:30:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688646633;
        bh=yC6E/mBM/67sUzeZV3Il3wBBzCtdEOHPS+iJkXdky+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgT/1lsWIVlTK/HPW/RWvCKuOXCXF14NVBF7ybqd8Ohqh6bjDOlSBJEXZOJk3G/9c
         JrVyaPTWeGT9kpcletskQGZpKvWpEATDYQ/vTcYc0sXBxaO2vH/Df1ZElhNxv37IBV
         NyGKvX9xbHkePJ+fnu4nakM8B30WZEjwyqrUAOmYEwyBlBf8hxq/v2qKzeZ97g1FjA
         IzTFX5jqv1IVizB3MQAcy9d9f3SqisJPDgK+j3H1/AZMa8R94sqQyK6qZEpquaia4c
         LpO8cU+TT1Feqyg928pAuxkDTWQnw+/Z9bQOU5pmZDBkwYua2r8ZDM7erYgdeqPeVP
         bNYJ4LCvTGijQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v4 4/9] drm/mediatek: dp: Always set cable_plugged_in at resume for eDP panel
Date:   Thu,  6 Jul 2023 14:30:20 +0200
Message-Id: <20230706123025.208408-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706123025.208408-1-angelogioacchino.delregno@collabora.com>
References: <20230706123025.208408-1-angelogioacchino.delregno@collabora.com>
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

eDP panels are not removable: at PM resume, the cable will obviously
still be plugged in.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 5b35a2e23896..35f3549d258e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2606,6 +2606,9 @@ static int mtk_dp_resume(struct device *dev)
 	mtk_dp_hwirq_enable(mtk_dp, true);
 	mtk_dp_power_enable(mtk_dp);
 
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP)
+		mtk_dp->train_info.cable_plugged_in = true;
+
 	return 0;
 }
 #endif
-- 
2.40.1

