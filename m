Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878156D07E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjC3OQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjC3OQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:16:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A3B761
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:16:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 696766603188;
        Thu, 30 Mar 2023 15:16:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680185799;
        bh=3ZbLGCMsG/gn15JDSWm25FtN0N4B/ueru9VCCfJiapw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3prFSel4ya0ptVFTP/t3CCVEDXD5CPfqu6LP2Idm1G5ho0artipcCQ2GfC454Sy7
         EIZ4hfEH11GN0Uhap+714IMBcw9PbSA/qraXh50zxLr0lEhdpODjwoW2OjkHS1d+/c
         KTMsAvlq0ExWjJpeGvkQK/LAPqjkkGM9mpjLd2KEUZditEbQaGlvqob0dJ2MhhAU86
         Ab1Vu7dDjeaItWiawNG3GTrrm8ZCNjuo7RLS3cF+gDxO/RUizb72gxeqU4WLT3G335
         1AMNT7iLCp7Xw5aWznxtXwJkrb3AaKgh8+AR+d2D3T21+LXsMZkEYrw+Ol3DuW9JEn
         ZSCTYBFt8tWyQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v1 4/8] drm/mediatek: dp: Always set cable_plugged_in at resume for eDP panel
Date:   Thu, 30 Mar 2023 16:16:26 +0200
Message-Id: <20230330141631.190528-5-angelogioacchino.delregno@collabora.com>
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

eDP panels are not removable: at PM resume, the cable will obviously
still be plugged in.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index c82dd1f0675d..ac21eca0e20e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2607,6 +2607,9 @@ static int mtk_dp_resume(struct device *dev)
 	mtk_dp_hwirq_enable(mtk_dp, true);
 	mtk_dp_power_enable(mtk_dp);
 
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP)
+		mtk_dp->train_info.cable_plugged_in = true;
+
 	return 0;
 }
 #endif
-- 
2.40.0

