Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26785F733D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJGDS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJGDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:17:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E88C513A;
        Thu,  6 Oct 2022 20:17:46 -0700 (PDT)
X-UUID: 87fb7487894948fe93521c0f254fdac5-20221007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eVQGziGwWXlyzzyYPltUGjNoQtXRxjY2UTVqN359c2k=;
        b=fxveuMy0ActB/Nu4lwE664uJvsoCUbT6vaYrVIDvc38de4ktEhPbHTsR1qcCP4ZNLefhJa/ubDo62kjIuHsInFlFZqZbF7Xy1N4zRn2Vpz/tpk1jxT4LpP+iJtu0fTdGbprL2evrvle5ko18MWgdUgkEt1uxKJSoogoQKA0SEE8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:69266e81-2f92-450f-bbf7-3c260da6dabf,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.11,REQID:69266e81-2f92-450f-bbf7-3c260da6dabf,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:39a5ff1,CLOUDID:a1f92be1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:221007111742FYVT8YBT,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 87fb7487894948fe93521c0f254fdac5-20221007
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 835497085; Fri, 07 Oct 2022 11:17:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 7 Oct 2022 11:17:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 7 Oct 2022 11:17:38 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v1 5/6] media: platform: mtk-mdp3: chip config split about resolution limitations
Date:   Fri, 7 Oct 2022 11:17:36 +0800
Message-ID: <20221007031737.5125-6-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221007031737.5125-1-moudy.ho@mediatek.com>
References: <20221007031737.5125-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to differences in hardware design, the supported max and min
resolutions and scaling capabilities will vary, and should be
moved and integrated into the chip configuration header file.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../media/platform/mediatek/mdp3/mt8183_mdp.h | 19 +++++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  1 +
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    | 21 +------------------
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mt8183_mdp.h b/drivers/media/platform/mediatek/mdp3/mt8183_mdp.h
index 9679af0aab25..4459b6b3937b 100644
--- a/drivers/media/platform/mediatek/mdp3/mt8183_mdp.h
+++ b/drivers/media/platform/mediatek/mdp3/mt8183_mdp.h
@@ -380,4 +380,23 @@ static const struct mdp_format mt8183_formats[] = {
 	}
 };
 
+static const struct mdp_limit mt8183_mdp_def_limit = {
+	.out_limit = {
+		.wmin	= 16,
+		.hmin	= 16,
+		.wmax	= 8176,
+		.hmax	= 8176,
+	},
+	.cap_limit = {
+		.wmin	= 2,
+		.hmin	= 2,
+		.wmax	= 8176,
+		.hmax	= 8176,
+	},
+	.h_scale_up_max = 32,
+	.v_scale_up_max = 32,
+	.h_scale_down_max = 20,
+	.v_scale_down_max = 128,
+};
+
 #endif  // __MT8183_MDP_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 3e865e3cf64f..58e6fa23ef0c 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -26,6 +26,7 @@ static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.comp_data_len = ARRAY_SIZE(mt8183_mdp_comp_data),
 	.format = mt8183_formats,
 	.format_len = ARRAY_SIZE(mt8183_formats),
+	.def_limit = &mt8183_mdp_def_limit,
 };
 
 static const struct of_device_id mdp_of_ids[] = {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 982438a9ab02..52f87e59ba9e 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -59,6 +59,7 @@ struct mtk_mdp_driver_data {
 	unsigned int comp_data_len;
 	const struct mdp_format *format;
 	unsigned int format_len;
+	const struct mdp_limit *def_limit;
 };
 
 struct mdp_dev {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
index cd6afbf53797..bb833ae27531 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
@@ -11,25 +11,6 @@
 #include "mtk-mdp3-regs.h"
 #include "mtk-mdp3-m2m.h"
 
-static const struct mdp_limit mdp_def_limit = {
-	.out_limit = {
-		.wmin	= 16,
-		.hmin	= 16,
-		.wmax	= 8176,
-		.hmax	= 8176,
-	},
-	.cap_limit = {
-		.wmin	= 2,
-		.hmin	= 2,
-		.wmax	= 8176,
-		.hmax	= 8176,
-	},
-	.h_scale_up_max = 32,
-	.v_scale_up_max = 32,
-	.h_scale_down_max = 20,
-	.v_scale_down_max = 128,
-};
-
 static const struct mdp_format *mdp_find_fmt(const struct mtk_mdp_driver_data *mdp_data,
 					     u32 pixelformat, u32 type)
 {
@@ -485,7 +466,7 @@ int mdp_frameparam_init(struct mdp_dev *mdp, struct mdp_frameparam *param)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&param->list);
-	param->limit = &mdp_def_limit;
+	param->limit = mdp->mdp_data->def_limit;
 	param->type = MDP_STREAM_TYPE_BITBLT;
 
 	frame = &param->output;
-- 
2.18.0

