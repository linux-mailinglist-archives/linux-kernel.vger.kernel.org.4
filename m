Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08556C9A06
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjC0DOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjC0DN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:13:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375964EF8;
        Sun, 26 Mar 2023 20:13:46 -0700 (PDT)
X-UUID: 5dedcab8cc4d11edb6b9f13eb10bd0fe-20230327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=O8crC6JDN1PDEzgJDHyrRI9+0OjAu60qsAfWD7/5X4k=;
        b=AcWWF9n3+0l0/h3Q6BfVnQHz8Gk7XOnazVDM82CGFzJkGWdBnUdiZNxzaZ9+2PJ4ku8dpOxXsy6Mbz0WuqxEseNGehanNv0L8+X5d4vBjpfGsKJBzr/VeSPPw+4o50GamCgu/JVpoDpvpBP4qM9dicC7rakGIZLuQfkeq/GLoCg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:0a4f5521-33da-451f-aa39-c32e202670cb,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:0a4f5521-33da-451f-aa39-c32e202670cb,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:baf870b4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:23032711134027KRD96O,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5dedcab8cc4d11edb6b9f13eb10bd0fe-20230327
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 41898669; Mon, 27 Mar 2023 11:13:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 27 Mar 2023 11:13:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 27 Mar 2023 11:13:36 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v7 04/12] media: platform: mtk-mdp3: chip config split about subcomponents
Date:   Mon, 27 Mar 2023 11:13:27 +0800
Message-ID: <20230327031335.9663-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230327031335.9663-1-moudy.ho@mediatek.com>
References: <20230327031335.9663-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate subcomponent related information into specific config file for
further multi-chip compatibility.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../media/platform/mediatek/mdp3/mdp_cfg_data.c    | 12 ++++++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   | 14 ++------------
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 4bf721957937..82e2e690a767 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -144,12 +144,24 @@ static const struct mdp_comp_data mt8183_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
 	},
 };
 
+static const struct of_device_id mt8183_sub_comp_dt_ids[] = {
+	{
+		.compatible = "mediatek,mt8183-mdp3-wdma",
+		.data = (void *)MDP_COMP_TYPE_PATH,
+	}, {
+		.compatible = "mediatek,mt8183-mdp3-wrot",
+		.data = (void *)MDP_COMP_TYPE_PATH,
+	},
+	{}
+};
+
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
 	.mdp_cfg = &mt8183_plat_cfg,
 	.mdp_mutex_table_idx = mt8183_mutex_idx,
 	.comp_data = mt8183_mdp_comp_data,
 	.comp_data_len = ARRAY_SIZE(mt8183_mdp_comp_data),
+	.mdp_sub_comp_dt_ids = mt8183_sub_comp_dt_ids,
 };
 
 s32 mdp_cfg_get_id_inner(struct mdp_dev *mdp_dev, enum mtk_mdp_comp_id id)
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 86aa031789d6..49bfe0094b19 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -610,17 +610,6 @@ static const struct of_device_id mdp_comp_dt_ids[] = {
 	{}
 };
 
-static const struct of_device_id mdp_sub_comp_dt_ids[] = {
-	{
-		.compatible = "mediatek,mt8183-mdp3-wdma",
-		.data = (void *)MDP_COMP_TYPE_PATH,
-	}, {
-		.compatible = "mediatek,mt8183-mdp3-wrot",
-		.data = (void *)MDP_COMP_TYPE_PATH,
-	},
-	{}
-};
-
 static inline bool is_dma_capable(const enum mdp_comp_type type)
 {
 	return (type == MDP_COMP_TYPE_RDMA ||
@@ -871,6 +860,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 {
 	struct device *dev = &mdp->pdev->dev;
 	struct device_node *node, *parent;
+	const struct mtk_mdp_driver_data *data = mdp->mdp_data;
 
 	parent = dev->of_node->parent;
 
@@ -880,7 +870,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 		int id, alias_id;
 		struct mdp_comp *comp;
 
-		of_id = of_match_node(mdp_sub_comp_dt_ids, node);
+		of_id = of_match_node(data->mdp_sub_comp_dt_ids, node);
 		if (!of_id)
 			continue;
 		if (!of_device_is_available(node)) {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 0c398ef75616..41eeba49fb42 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -56,6 +56,7 @@ struct mtk_mdp_driver_data {
 	const u32 *mdp_mutex_table_idx;
 	const struct mdp_comp_data *comp_data;
 	unsigned int comp_data_len;
+	const struct of_device_id *mdp_sub_comp_dt_ids;
 };
 
 struct mdp_dev {
-- 
2.18.0

