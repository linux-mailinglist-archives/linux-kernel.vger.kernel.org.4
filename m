Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C970F2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEXJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEXJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:34:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC1CFC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:34:25 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ACF446605907;
        Wed, 24 May 2023 10:34:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684920864;
        bh=2Hsz2EJdS4VRyzmFM2xYr8U8SP0LYcUFtMd/nf9GRoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwUM2x1gqbCnMltEdDDWXJkmqEpaWuDHJ9+w6dLrM2HWUxM9b7/McSlJDGk0gUk7c
         Jbj8aYRiG388X8EhLCNpu8jRi/q7C01Kax39aLm9YxGAUlxq3X59eyp5ftLF6wpmkN
         roYpXEIL8tf1SdPlC/2pnR87JSOTRAvX0YIrNFMAuAV4BIwIHH1C3CkjBc7R71pRjL
         S1oMvYK6SpHtYTNFiGC3xCRuZZeygJzKRYyxSS3SgDKwwToq5RSw5WazR/fzPsX21g
         zOWF+Af22teRcjLBhBXy/T7Sbm+S13nN5IOAPXvDEs0GwPuswuEfW0voB7nrcYH4LM
         ApX7Kynr53w1g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v1 4/4] drm/mediatek: dsi: Replace open-coded instance of HZ_PER_MHZ
Date:   Wed, 24 May 2023 11:34:12 +0200
Message-Id: <20230524093412.92211-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524093412.92211-1-angelogioacchino.delregno@collabora.com>
References: <20230524093412.92211-1-angelogioacchino.delregno@collabora.com>
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

In mtk_dsi_phy_timconfig(), we're dividing the `data_rate` variable,
expressed in Hz to retrieve a value in MHz: instead of open-coding,
use the HZ_PER_MHZ definition, available in linux/units.h.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index fbf1c232107d..19e2b042c9d5 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -12,6 +12,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 #include <video/mipi_display.h>
 #include <video/videomode.h>
@@ -235,7 +236,7 @@ static void mtk_dsi_mask(struct mtk_dsi *dsi, u32 offset, u32 mask, u32 data)
 static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
 {
 	u32 timcon0, timcon1, timcon2, timcon3;
-	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, 1000000);
+	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, HZ_PER_MHZ);
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 
 	timing->lpx = (60 * data_rate_mhz / (8 * 1000)) + 1;
-- 
2.40.1

