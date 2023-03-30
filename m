Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFF6D07E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjC3OQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjC3OQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:16:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93CFB440
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:16:39 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A63066603189;
        Thu, 30 Mar 2023 15:16:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680185798;
        bh=l7DxgZbkLf1a/NAX8ACnOYom2qi3A95N4rbvhFxlUX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kok26pBYezCXLsDqlPBv2AAuuArwPCPm1egmztLbAPV5WKAfc+jLvl0aZaf7UVrMA
         l/Zhteq7VX7hcsoAwMknWLdZJSAi0O4Fio6waFY2Pr41THlth0BFXPi7deedr5xEPx
         63S5QwMCvF8YA8KpXRt4nGT2Bbp9ceXaYVJWGp0vlqzDh7pToyaxp32L6x/UyxUfqA
         fyP/CP3Dd38Pm2kh/s0Kc5VQgkfuSADcIxGEzExSKXZ5eri9mqF5FyFPQFjDsvy8As
         aVx2r8UUvdYP8QRJJQzMoOvO7cYfz8rI5M7yGvor11hIymYm9ybjXMJMXn6rqzRX0K
         C6cNQX6P9RCxQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v1 3/8] drm/mediatek: dp: Always return connected status for eDP in .detect()
Date:   Thu, 30 Mar 2023 16:16:25 +0200
Message-Id: <20230330141631.190528-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230330141631.190528-1-angelogioacchino.delregno@collabora.com>
References: <20230330141631.190528-1-angelogioacchino.delregno@collabora.com>
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

If this is an eDP panel it's not removable, hence it's always connected:
as a shortcut, always return connector_status_connected in the .detect()
callback for eDP connector, avoiding a poweron, a check for sink count
and a poweroff.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 76ea94167531..c82dd1f0675d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1957,6 +1957,9 @@ static enum drm_connector_status mtk_dp_bdg_detect(struct drm_bridge *bridge)
 	bool enabled = mtk_dp->enabled;
 	u8 sink_count = 0;
 
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP)
+		return connector_status_connected;
+
 	if (!mtk_dp->train_info.cable_plugged_in)
 		return ret;
 
-- 
2.40.0

