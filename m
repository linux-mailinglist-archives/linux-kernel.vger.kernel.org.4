Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AAA6821BA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjAaCAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjAaB7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:59:43 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319682686B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:59:30 -0800 (PST)
X-UUID: e493b4d8a10a11ed945fc101203acc17-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BoWoQMdNfjipELBRS3LNoduY6UIoypqp210tmpmIGPc=;
        b=RH9r+iTh0e3vkkQw9TUn+sauGOAeqXhE6xAkv7t9YgzfL+wW5a6OSBoJJ1moDGNdf8t4PtpDWvsD/nGpnSRK8LqFgKgTZWoocTtd/q4QEMl8LYiszr6C15fimPHJKTo2whodsE7xa/OyBLKy0aqYvpaVmBXM7NsN2w7tmw2adrI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:85b23dd6-524d-4ef6-b124-cee6ed76b900,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.18,REQID:85b23dd6-524d-4ef6-b124-cee6ed76b900,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:3ca2d6b,CLOUDID:c56b678d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:23013109592761N1B6JK,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: e493b4d8a10a11ed945fc101203acc17-20230131
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1148795063; Tue, 31 Jan 2023 09:59:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 31 Jan 2023 09:59:26 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 09:59:25 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <jitao.shi@mediatek.com>, <thierry.reding@gmail.com>,
        <sam@ravnborg.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v3 2/2] drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence
Date:   Tue, 31 Jan 2023 09:59:19 +0800
Message-ID: <1675130359-24459-3-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1675130359-24459-1-git-send-email-xinlei.lee@mediatek.com>
References: <1675130359-24459-1-git-send-email-xinlei.lee@mediatek.com>
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

For "boe,tv105wum-nw0" this special panel, it is stipulated in
the panel spec that MIPI needs to keep the LP11 state before
the lcm_reset pin is pulled high.

Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index f0093035f1ff..67df61de64ae 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -36,6 +36,7 @@ struct panel_desc {
 	const struct panel_init_cmd *init_cmds;
 	unsigned int lanes;
 	bool discharge_on_disable;
+	bool lp11_before_reset;
 };
 
 struct boe_panel {
@@ -1261,6 +1262,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
 
 	usleep_range(10000, 11000);
 
+	if (boe->desc->lp11_before_reset) {
+		mipi_dsi_dcs_nop(boe->dsi);
+		usleep_range(1000, 2000);
+	}
 	gpiod_set_value(boe->enable_gpio, 1);
 	usleep_range(1000, 2000);
 	gpiod_set_value(boe->enable_gpio, 0);
@@ -1487,6 +1492,7 @@ static const struct panel_desc boe_tv105wum_nw0_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.init_cmds = boe_init_cmd,
+	.lp11_before_reset = true,
 };
 
 static int boe_panel_get_modes(struct drm_panel *panel,
-- 
2.18.0

