Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1917F60384A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJSCys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJSCyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:54:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2E43EA44
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:54:43 -0700 (PDT)
X-UUID: c40f0c2c4c9d474bbd785da69ebdb6f6-20221019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cZEO+e77VsgRhmatF/YbgQRz+vdFCefQ7R/Rivk44C8=;
        b=XcsjvCgEjd4VcCeWlusDMOT+l4tBSR8mZHsCjHa3miS7HvhnvOClgDT7hiidwy6AIyITA9Jpec+less1T2Tk5GzhcDLqV6bMRUedzlmHWEli2MI7wGvHojmvmWoI5xyftgi7dWYDfEDbWRX4YhLJwGJs0PHh8AxnZMU6lwpPPaU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3b02aba7-f5e1-411b-bf6e-5450356087bf,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:25cd3ba3-73e4-48dd-a911-57b5d5484f14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c40f0c2c4c9d474bbd785da69ebdb6f6-20221019
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1658625720; Wed, 19 Oct 2022 10:54:34 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 19 Oct 2022 10:54:33 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 19 Oct 2022 10:54:32 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <jitao.shi@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v2] drm: mediatek: Modify dpi power on/off sequence.
Date:   Wed, 19 Oct 2022 10:54:30 +0800
Message-ID: <1666148070-30209-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Modify dpi power on/off sequence so that the first gpio operation will take effect.

Fixes: 6bd4763fd532 ("drm/mediatek: set dpi pin mode to gpio low to avoid leakage current")

Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
change note:
v1: Rebase on linus/master v6.1-rc1. Change nothing.

Because dpi power_on/off is protected by dpi->refcount, the first time
it cannot be powered on and off successfully, it will cause leakage.
---
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 508a6d994e83..f83cf64c2828 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -461,9 +461,6 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 	if (--dpi->refcount != 0)
 		return;
 
-	if (dpi->pinctrl && dpi->pins_gpio)
-		pinctrl_select_state(dpi->pinctrl, dpi->pins_gpio);
-
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
 	clk_disable_unprepare(dpi->engine_clk);
@@ -488,9 +485,6 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 		goto err_pixel;
 	}
 
-	if (dpi->pinctrl && dpi->pins_dpi)
-		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
-
 	return 0;
 
 err_pixel:
@@ -720,6 +714,9 @@ static void mtk_dpi_bridge_disable(struct drm_bridge *bridge)
 {
 	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
 
+	if (dpi->pinctrl && dpi->pins_gpio)
+		pinctrl_select_state(dpi->pinctrl, dpi->pins_gpio);
+
 	mtk_dpi_power_off(dpi);
 }
 
@@ -727,6 +724,9 @@ static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
 {
 	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
 
+	if (dpi->pinctrl && dpi->pins_dpi)
+		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
+
 	mtk_dpi_power_on(dpi);
 	mtk_dpi_set_display_mode(dpi, &dpi->mode);
 	mtk_dpi_enable(dpi);
-- 
2.18.0

