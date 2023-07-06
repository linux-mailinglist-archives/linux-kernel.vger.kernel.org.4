Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB52749BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGFMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjGFMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:30:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EC519B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:30:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A3DC6606FC5;
        Thu,  6 Jul 2023 13:30:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688646633;
        bh=eiF+MPOcDv9CDEFKbz/2nzTwuFjo2RNY4YZzBre0LbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQNqTl/1PE5lx6QecqCAcVKxRo9TdiDhT7DlARV+Z4YqyJ/ya30FTg+bdZdACDtsm
         7e0moLQLKsb/m+Dj3P5R/vDXNkajz/e2UAQmmftQqiWrvuDsa1knmlOROGvvaBvqpN
         +2b5RROPznSuNeEFgL6CiSMwS6FndbuqHMifS2bx6egNtX7FMOaONukVQihSbkgXT3
         KyUV8J7lylA+JV3qCTzARcLcThNe0r8FFdJ3HIQlcucYV17LRFWeCWskyNwH9S1kyE
         tPndYj+Dzlhap/boYAmt5uvxAwzuiYmdd21EtyKNq6eT6XigOxydQti+tx22ScBvx2
         7+ZjXq2nSSkqw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v4 3/9] drm/mediatek: dp: Always return connected status for eDP in .detect()
Date:   Thu,  6 Jul 2023 14:30:19 +0200
Message-Id: <20230706123025.208408-4-angelogioacchino.delregno@collabora.com>
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

If this is an eDP panel it's not removable, hence it's always connected:
as a shortcut, always return connector_status_connected in the .detect()
callback for eDP connector, avoiding a poweron, a check for sink count
and a poweroff.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 8f7d4af7076f..5b35a2e23896 100644
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
2.40.1

