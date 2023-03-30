Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CA96D07FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjC3OUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjC3OUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:20:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930C114
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:20:42 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7587D6603182;
        Thu, 30 Mar 2023 15:20:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680186041;
        bh=aTfefQf7wUPldM8GfwxyIBQhpoEf1h/RP3aMOHoG5mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPKMaUB9pcKRhv67iSyOx+sUENsvJDupMI3jonnm9Rm8BPcttpu+7x3p4EEQsiW9C
         yz6VK78dYKCALS6f4jauo7bR8O/uLpxVSENMCprMBm9+fYlG0nz2tzq5AYz4owxxX7
         Pp8RicYGQGWQea6wDJ+Qky/Y4617oEjcXcSl2m4KgpTEwhk3i4sAYAtcKVoMlD/rh3
         DXXWsQPAxnj4eXifnCESevLdl9IoUAbJhpPr0gHV5xwdZizK517iTFTDpseamSiYNe
         bj+Z4bQAc5kwvIcmIbH/S2UinzEC+t8iOLv9x20s7RG7wA+wkYliZQv0CSLXX6rw98
         K1iPrA0Y0Vk+w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 1/8] drm/mediatek: dp: Cache EDID for eDP panel
Date:   Thu, 30 Mar 2023 16:20:28 +0200
Message-Id: <20230330142035.191399-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230330142035.191399-1-angelogioacchino.delregno@collabora.com>
References: <20230330142035.191399-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since eDP panels are not removable it is safe to cache the EDID:
this will avoid a relatively long read transaction at every PM
resume that is unnecessary only in the "special" case of eDP,
hence speeding it up a little, as from now on, as resume operation,
we will perform only link training.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 1f94fcc144d3..84f82cc68672 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -118,6 +118,7 @@ struct mtk_dp {
 	const struct mtk_dp_data *data;
 	struct mtk_dp_info info;
 	struct mtk_dp_train_info train_info;
+	struct edid *edid;
 
 	struct platform_device *phy_dev;
 	struct phy *phy;
@@ -1993,7 +1994,11 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge *bridge,
 		usleep_range(2000, 5000);
 	}
 
-	new_edid = drm_get_edid(connector, &mtk_dp->aux.ddc);
+	/* eDP panels aren't removable, so we can return a cached EDID. */
+	if (mtk_dp->edid && mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP)
+		new_edid = drm_edid_duplicate(mtk_dp->edid);
+	else
+		new_edid = drm_get_edid(connector, &mtk_dp->aux.ddc);
 
 	/*
 	 * Parse capability here to let atomic_get_input_bus_fmts and
@@ -2022,6 +2027,10 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge *bridge,
 		drm_atomic_bridge_chain_post_disable(bridge, connector->state->state);
 	}
 
+	/* If this is an eDP panel and the read EDID is good, cache it for later */
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP && !mtk_dp->edid && new_edid)
+		mtk_dp->edid = drm_edid_duplicate(new_edid);
+
 	return new_edid;
 }
 
-- 
2.40.0

