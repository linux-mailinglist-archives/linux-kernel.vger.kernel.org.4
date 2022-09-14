Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00375B89B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiINOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiINOBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:01:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6929A1CB0E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:00:39 -0700 (PDT)
X-UUID: 4a42c3792f96464299de123730c8ac07-20220914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Wy5CZ7whd4Um5NV5JQOHZfdTnoxxIEcuBpfmElqhC5s=;
        b=E+A3eU8DGU1Q/RIEZp2Yev0oa5jAvLZ0L6rArb8Pk9Gq4/sgyxQAXWMJje0Ctw28mCjAQZDWKItcJbpqcks2ygtu/UfgrjiPaJO9IhLu8AsLao2tj4qNCGzD3rTu8NM4Mx8hJt3nzVg6/n1fwQf4baxgxnQ4YD6ABvqBHV2/TEU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:8ae5156e-af4b-4551-a9c1-679e1eae0475,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:39a5ff1,CLOUDID:59e16cec-2856-4fce-b125-09d4c7ebe045,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4a42c3792f96464299de123730c8ac07-20220914
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1613845095; Wed, 14 Sep 2022 22:00:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 14 Sep 2022 22:00:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 14 Sep 2022 22:00:34 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2] drm: mediatek: Fix display vblank timeout when disable dsi
Date:   Wed, 14 Sep 2022 22:00:31 +0800
Message-ID: <20220914140031.18578-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Dsi is turned off at bridge.disable, causing crtc to wait for vblank
timeout. It is necessary to add count protection to turn off dsi and
turn off at post_disable.

Fixes: cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from enable/disable and define new funcs")
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
Change in v1:
  * Rebase to kernel/git/chunkuang.hu/linux.git, mediatek-drm-fixes
    [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
---
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5b624e0f5b0a..e30f4244c001 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -768,14 +768,6 @@ static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	drm_display_mode_to_videomode(adjusted, &dsi->vm);
 }
 
-static void mtk_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
-					  struct drm_bridge_state *old_bridge_state)
-{
-	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
-
-	mtk_output_dsi_disable(dsi);
-}
-
 static void mtk_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
 					 struct drm_bridge_state *old_bridge_state)
 {
@@ -803,13 +795,15 @@ static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
 
+	if (dsi->refcount == 1)
+		mtk_output_dsi_disable(dsi);
+
 	mtk_dsi_poweroff(dsi);
 }
 
 static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
 	.attach = mtk_dsi_bridge_attach,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_disable = mtk_dsi_bridge_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_enable = mtk_dsi_bridge_atomic_enable,
 	.atomic_pre_enable = mtk_dsi_bridge_atomic_pre_enable,
@@ -829,6 +823,9 @@ void mtk_dsi_ddp_stop(struct device *dev)
 {
 	struct mtk_dsi *dsi = dev_get_drvdata(dev);
 
+	if (dsi->refcount == 1)
+		mtk_output_dsi_disable(dsi);
+
 	mtk_dsi_poweroff(dsi);
 }
 
-- 
2.18.0

