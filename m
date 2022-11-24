Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5663794C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKXMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKXMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:52:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630EE767E;
        Thu, 24 Nov 2022 04:52:34 -0800 (PST)
X-UUID: e8609f4ff84f46658879a9991f8e17ff-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Jb049zrd2hNJynQl+HJf/yYHcEbSdX0lcrbbz59HJmA=;
        b=V9G+dh9PkvcJVy+7NACDwIbP9DXIQSFc1PP6KtKOJAvSkS+hM0d/M4V5HluvTKmgXVRFDdTIcKyIxHCkkHeAf1TUFzpr72xM2UwYFN9kFWsWXU7JvLuulgj121od59H2XgEF05mk3O+np0QZKJKmji4Dj/rOlFz2lcJavlRhMnY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0829499f-ae89-4b66-8783-a524179dece4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:85b625dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e8609f4ff84f46658879a9991f8e17ff-20221124
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1683606245; Thu, 24 Nov 2022 20:52:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 20:52:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 24 Nov 2022 20:52:27 +0800
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
Subject: [PATCH v1 07/12] media: platform: mtk-mdp3: add checks for dummy components
Date:   Thu, 24 Nov 2022 20:52:20 +0800
Message-ID: <20221124125225.24538-8-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221124125225.24538-1-moudy.ho@mediatek.com>
References: <20221124125225.24538-1-moudy.ho@mediatek.com>
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

Some MDP3 components are only used as bridges and do not require configuration.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 64 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 365efe6a6c92..d22b6a62cf21 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -43,6 +43,13 @@ static bool is_output_disabled(int id, const struct img_compparam *param, u32 co
 	return (count < num) ? (dis_output || dis_tile) : true;
 }
 
+static bool is_dummy_engine(struct mdp_dev *mdp_dev, s32 inner_id)
+{
+	enum mtk_mdp_comp_id public_id = get_comp_public_id(mdp_dev, inner_id);
+
+	return (mdp_dev->mdp_data->comp_data[public_id].match.type == MDP_COMP_TYPE_DUMMY);
+}
+
 static struct mtk_mutex *__get_mutex(const struct mdp_dev *mdp_dev,
 				     const struct mdp_pipe_info *p)
 {
@@ -114,6 +121,12 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 
 	/* Set mutex mod */
 	for (index = 0; index < num_comp; index++) {
+		s32 inner_id = MDP_COMP_NONE;
+
+		if (CFG_CHECK(MT8183, plat_id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		ctx = &path->comps[index];
 		if (is_output_disabled(plat_id, ctx->param, count))
 			continue;
@@ -138,6 +151,7 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 	int index;
 	u32 num_comp = 0;
 	s32 event;
+	s32 inner_id = MDP_COMP_NONE;
 
 	if (-1 == p->mutex_id) {
 		dev_err(dev, "Incorrect mutex id");
@@ -150,6 +164,10 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 	/* Wait WROT SRAM shared to DISP RDMA */
 	/* Clear SOF event for each engine */
 	for (index = 0; index < num_comp; index++) {
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		ctx = &path->comps[index];
 		if (is_output_disabled(id, ctx->param, count))
 			continue;
@@ -164,6 +182,10 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 
 	/* Wait SOF events and clear mutex modules (optional) */
 	for (index = 0; index < num_comp; index++) {
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		ctx = &path->comps[index];
 		if (is_output_disabled(id, ctx->param, count))
 			continue;
@@ -189,6 +211,12 @@ static int mdp_path_ctx_init(struct mdp_dev *mdp, struct mdp_path *path)
 		return -EINVAL;
 
 	for (index = 0; index < num_comp; index++) {
+		s32 inner_id = MDP_COMP_NONE;
+
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		if (CFG_CHECK(MT8183, id))
 			param = (void *)CFG_ADDR(MT8183, path->config, components[index]);
 		ret = mdp_comp_ctx_config(mdp, &path->comps[index],
@@ -210,6 +238,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	struct mdp_pipe_info pipe;
 	int index, ret;
 	u32 num_comp = 0;
+	s32 inner_id = MDP_COMP_NONE;
 
 	if (CFG_CHECK(MT8183, id))
 		num_comp = CFG_GET(MT8183, path->config, num_components);
@@ -229,6 +258,10 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	}
 	/* Config sub-frame information */
 	for (index = (num_comp - 1); index >= 0; index--) {
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		ctx = &path->comps[index];
 		if (is_output_disabled(id, ctx->param, count))
 			continue;
@@ -242,6 +275,10 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 		return ret;
 	/* Wait components done */
 	for (index = 0; index < num_comp; index++) {
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		ctx = &path->comps[index];
 		if (is_output_disabled(id, ctx->param, count))
 			continue;
@@ -251,6 +288,10 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	}
 	/* Advance to the next sub-frame */
 	for (index = 0; index < num_comp; index++) {
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		ctx = &path->comps[index];
 		ret = call_op(ctx, advance_subfrm, cmd, count);
 		if (ret)
@@ -274,6 +315,7 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 	int index, count, ret;
 	u32 num_comp = 0;
 	u32 num_sub = 0;
+	s32 inner_id = MDP_COMP_NONE;
 
 	if (CFG_CHECK(MT8183, id))
 		num_comp = CFG_GET(MT8183, path->config, num_components);
@@ -284,6 +326,10 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 	/* Config path frame */
 	/* Reset components */
 	for (index = 0; index < num_comp; index++) {
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		ctx = &path->comps[index];
 		ret = call_op(ctx, init_comp, cmd);
 		if (ret)
@@ -294,6 +340,11 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 		const struct v4l2_rect *compose;
 		u32 out = 0;
 
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
+
 		if (CFG_CHECK(MT8183, id))
 			out = CFG_COMP(MT8183, ctx->param, outputs[0]);
 
@@ -312,6 +363,10 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 	}
 	/* Post processing information */
 	for (index = 0; index < num_comp; index++) {
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		if (is_dummy_engine(path->mdp_dev, inner_id))
+			continue;
 		ctx = &path->comps[index];
 		ret = call_op(ctx, post_process, cmd);
 		if (ret)
@@ -512,9 +567,16 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	}
 	cmdq_pkt_finalize(&cmd->pkt);
 
-	for (i = 0; i < num_comp; i++)
+	for (i = 0; i < num_comp; i++) {
+		s32 inner_id = MDP_COMP_NONE;
+
+		if (CFG_CHECK(MT8183, id))
+			inner_id = CFG_GET(MT8183, path->config, components[i].type);
+		if (is_dummy_engine(mdp, inner_id))
+			continue;
 		memcpy(&comps[i], path->comps[i].comp,
 		       sizeof(struct mdp_comp));
+	}
 
 	mdp->cmdq_clt->client.rx_callback = mdp_handle_cmdq_callback;
 	cmd->mdp = mdp;
-- 
2.18.0

