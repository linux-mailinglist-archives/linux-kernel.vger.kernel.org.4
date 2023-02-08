Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D468EB45
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBHJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBHJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:24:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F09446708;
        Wed,  8 Feb 2023 01:22:20 -0800 (PST)
X-UUID: 125da76aa79211ed945fc101203acc17-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FT0LWsd9AjDEQ7vWn5+ZXoEKaeXKNpvThm2222pl+LI=;
        b=AP1rhTx589qTdqyf28NkYxh9I17ojNxxYFdG+boFEN6/tG1/yjxT+qe0ONX0vkMaINzAspnVPBEIZZZfnsOY7VL3WX4yyStA34yscC3ajQBXSnWZMGFuuoGKYGL7OpTcFRpcYEwWlRkVp6Wfk4/8XILoLQ8tGJybcqut+fHTJo0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:70d09a6b-189e-4afa-bc2d-512d3be79cbf,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:885ddb2,CLOUDID:ffd7aa56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 125da76aa79211ed945fc101203acc17-20230208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1660909357; Wed, 08 Feb 2023 17:22:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Feb 2023 17:22:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:22:11 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v4 11/16] media: platform: mtk-mdp3: extend GCE event waiting in RDMA and WROT
Date:   Wed, 8 Feb 2023 17:22:04 +0800
Message-ID: <20230208092209.19472-12-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208092209.19472-1-moudy.ho@mediatek.com>
References: <20230208092209.19472-1-moudy.ho@mediatek.com>
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

Support for multiple RDMA/WROT waits for GCE events.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../media/platform/mediatek/mdp3/mdp_cfg_data.c |  2 ++
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c      | 17 +++++++++++------
 .../platform/mediatek/mdp3/mtk-mdp3-core.h      |  2 ++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 0c65b64c6266..eafb0c235867 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -56,8 +56,10 @@ static const struct mdp_platform_config mt8183_plat_cfg = {
 	.rdma_support_10bit		= true,
 	.rdma_rsz1_sram_sharing		= true,
 	.rdma_upsample_repeat_only	= true,
+	.rdma_event_num			= 1,
 	.rsz_disable_dcm_small_sample	= false,
 	.wrot_filter_constraint		= false,
+	.wrot_event_num			= 1,
 };
 
 static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 75c92e282fa2..3d6cf55153f1 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -251,14 +251,17 @@ static int config_rdma_subfrm(struct mdp_comp_ctx *ctx,
 
 static int wait_rdma_event(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
 {
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 	struct device *dev = &ctx->comp->mdp_dev->pdev->dev;
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
 
-	if (ctx->comp->alias_id == 0)
+	if (ctx->comp->alias_id < mdp_cfg->rdma_event_num) {
 		MM_REG_WAIT(cmd, ctx->comp->gce_event[MDP_GCE_EVENT_EOF]);
-	else
-		dev_err(dev, "Do not support RDMA1_DONE event\n");
+	} else {
+		dev_err(dev, "Invalid RDMA event %d\n", ctx->comp->alias_id);
+		return -EINVAL;
+	}
 
 	/* Disable RDMA */
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_EN, 0x0, BIT(0));
@@ -553,10 +556,12 @@ static int wait_wrot_event(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
 
-	if (ctx->comp->alias_id == 0)
+	if (ctx->comp->alias_id < mdp_cfg->wrot_event_num) {
 		MM_REG_WAIT(cmd, ctx->comp->gce_event[MDP_GCE_EVENT_EOF]);
-	else
-		dev_err(dev, "Do not support WROT1_DONE event\n");
+	} else {
+		dev_err(dev, "Invalid WROT event %d!\n", ctx->comp->alias_id);
+		return -EINVAL;
+	}
 
 	if (mdp_cfg && mdp_cfg->wrot_filter_constraint)
 		MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE, 0x0,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index a063a655248c..b2a3e4b2ee1a 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -39,8 +39,10 @@ struct mdp_platform_config {
 	bool	rdma_support_10bit;
 	bool	rdma_rsz1_sram_sharing;
 	bool	rdma_upsample_repeat_only;
+	u32	rdma_event_num;
 	bool	rsz_disable_dcm_small_sample;
 	bool	wrot_filter_constraint;
+	u32	wrot_event_num;
 };
 
 /* indicate which mutex is used by each pipepline */
-- 
2.18.0

