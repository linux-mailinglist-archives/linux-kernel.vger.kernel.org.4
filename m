Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D734564D740
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiLOH2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLOH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:28:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926224F33
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:28:19 -0800 (PST)
X-UUID: 8ac79201f18848b0a86849314137fd0b-20221215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JMJpgtx2oLuuf8YmaHRZMDw4G3WnkkqwoUzwMwFd+S0=;
        b=QvrlwZG0+cN8lMpbNJrGRq7mQbtIBWdGbnYYKkFIUncaDOte6thFR9DPrhrtO8vrla1NvdoXFDwkX+FHWoKVb/jsiR0F1rCjQHb0zAMFfD7TVOZchS6QsAwXH5ctDTKLPaUQOUDJkBShTjFMNdATyCdIA7SlfpcG5HFjU6NyB00=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:3c4a4e59-038a-4f6f-850a-deefd0528659,IP:0,U
        RL:0,TC:0,Content:44,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:44
X-CID-META: VersionHash:dcaaed0,CLOUDID:a172a9b4-d2e2-434d-b6d3-aeae88dfcc78,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8ac79201f18848b0a86849314137fd0b-20221215
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1033962838; Thu, 15 Dec 2022 15:28:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Dec 2022 15:28:12 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 15 Dec 2022 15:28:11 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v11, 4/4] mailbox: mtk-cmdq: add MT8186 support
Date:   Thu, 15 Dec 2022 15:28:06 +0800
Message-ID: <20221215072806.10224-5-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215072806.10224-1-yongqiang.niu@mediatek.com>
References: <20221215072806.10224-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add MT8186 cmdq support

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 53904511598d..c5229f377c5e 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -694,9 +694,18 @@ static const struct gce_plat gce_plat_v6 = {
 	.gce_num = 2
 };
 
+static const struct gce_plat gce_plat_v7 = {
+	.thread_nr = 24,
+	.shift = 3,
+	.control_by_sw = true,
+	.sw_ddr_en = true,
+	.gce_num = 1
+};
+
 static const struct of_device_id cmdq_of_ids[] = {
 	{.compatible = "mediatek,mt8173-gce", .data = (void *)&gce_plat_v2},
 	{.compatible = "mediatek,mt8183-gce", .data = (void *)&gce_plat_v3},
+	{.compatible = "mediatek,mt8186-gce", .data = (void *)&gce_plat_v7},
 	{.compatible = "mediatek,mt6779-gce", .data = (void *)&gce_plat_v4},
 	{.compatible = "mediatek,mt8192-gce", .data = (void *)&gce_plat_v5},
 	{.compatible = "mediatek,mt8195-gce", .data = (void *)&gce_plat_v6},
-- 
2.25.1

