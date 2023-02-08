Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A55768EAA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBHJJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBHJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:09:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9938D2F7B9;
        Wed,  8 Feb 2023 01:09:07 -0800 (PST)
X-UUID: 38882674a79011eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Psco9otWfPZGFGZ//xLO6jrRtyy0L0FihrkDoRsQh0I=;
        b=WVhLrqBWkd+9ITSJXzqF960OhDx4QOa3//Ov3vytN4HDf2XJtfMX98bc2us2zqJ2J7QTXxiVKW8VWJ3XpGx9ZdHHm+RM1ODs8yLdp7GYTkd8lmGUNEWAicQvQh15R4I6fPttslR4w4Rj1rGfPHEqz4mrsKWwVT3ICm8A3On3AOQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:ac22fd18-912f-46c3-93c2-aaa5115e2ade,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:d972aa56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 38882674a79011eda06fc9ecc4dadd91-20230208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 43930625; Wed, 08 Feb 2023 17:08:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 17:08:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:08:57 +0800
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
Subject: [PATCH v6 07/12] media: platform: mtk-mdp3: chip config split about pipe info
Date:   Wed, 8 Feb 2023 17:08:50 +0800
Message-ID: <20230208090855.18934-8-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208090855.18934-1-moudy.ho@mediatek.com>
References: <20230208090855.18934-1-moudy.ho@mediatek.com>
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

In MDP3, a pipe is used to represent a data path which
consisting of different components and MUTEX, as shown in
the following diagram:

                     +----------------------------+
                     |           MUTEX [*1]       |
                     +----------------------------+
                        S ^ S ^  S ^  S ^  S ^
                        | | | |  | |  | |  | |
                        | | | |  | |  | |  | |
         +--------------+ | | |  | |  | |  | +-------------+
         | +--------------+ | |  | |  | |  +-------------+ |
         | |         +------+ |  | |  | +------+         | |
         | |         | +------+  | |  +------+ |         | |
         | |         | |         | |         | |         | |
         | |         | |         | |         | |         | |
         v E         v E         v E         v E         v E
      +-------+    +-----+    +-------+    +-----+    +-------+
B>--->| RDMA0 |>-->| PQ  |>-->| RSZ0  |>-->| PQ  |>-->| WROT0 |>-->B
      +-------+    +-----+    +-------+    +-----+    +-------+

[*1] MUTEX is SOF/EOF signal controller
[*2] S = Start of frame (SOF)
[*3] E = End of frame (EOF)
[*4] B = frame buffer

More pipes will be introduced in future chips for applications such as
higher frame rate frequency, which should integrate and reorder related
information into specific chip config file.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mdp_cfg_data.c     |  9 ++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 23 ++++++++++++-------
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 13 +++++++----
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    | 11 +++++++--
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 6fb8fd6f0bb1..9d1a080d1b65 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -400,6 +400,13 @@ static const struct mdp_limit mt8183_mdp_def_limit = {
 	.v_scale_down_max = 128,
 };
 
+static const struct mdp_pipe_info mt8183_pipe_info[] = {
+	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, 0},
+	[MDP_PIPE_WPEI2] = {MDP_PIPE_WPEI2, 1},
+	[MDP_PIPE_IMGI] = {MDP_PIPE_IMGI, 2},
+	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, 3}
+};
+
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
 	.mdp_cfg = &mt8183_plat_cfg,
@@ -410,6 +417,8 @@ const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.format = mt8183_formats,
 	.format_len = ARRAY_SIZE(mt8183_formats),
 	.def_limit = &mt8183_mdp_def_limit,
+	.pipe_info = mt8183_pipe_info,
+	.pipe_info_len = ARRAY_SIZE(mt8183_pipe_info),
 };
 
 s32 mdp_cfg_get_id_inner(struct mdp_dev *mdp_dev, enum mtk_mdp_comp_id id)
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index dcd77f65b0e3..bff14e4944c5 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -50,21 +50,22 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 	/* Decide which mutex to use based on the current pipeline */
 	switch (path->comps[0].comp->public_id) {
 	case MDP_COMP_RDMA0:
-		*mutex_id = MDP_PIPE_RDMA0;
+		index = MDP_PIPE_RDMA0;
 		break;
 	case MDP_COMP_ISP_IMGI:
-		*mutex_id = MDP_PIPE_IMGI;
+		index = MDP_PIPE_IMGI;
 		break;
 	case MDP_COMP_WPEI:
-		*mutex_id = MDP_PIPE_WPEI;
+		index = MDP_PIPE_WPEI;
 		break;
 	case MDP_COMP_WPEI2:
-		*mutex_id = MDP_PIPE_WPEI2;
+		index = MDP_PIPE_WPEI2;
 		break;
 	default:
 		dev_err(dev, "Unknown pipeline and no mutex is assigned");
 		return -EINVAL;
 	}
+	*mutex_id = data->pipe_info[index].mutex_id;
 
 	/* Set mutex mod */
 	for (index = 0; index < config->num_components; index++) {
@@ -286,11 +287,13 @@ static void mdp_auto_release_work(struct work_struct *work)
 {
 	struct mdp_cmdq_cmd *cmd;
 	struct mdp_dev *mdp;
+	int id;
 
 	cmd = container_of(work, struct mdp_cmdq_cmd, auto_release_work);
 	mdp = cmd->mdp;
 
-	mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+	id = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
+	mtk_mutex_unprepare(mdp->mdp_mutex[id]);
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 
@@ -310,6 +313,7 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	struct cmdq_cb_data *data;
 	struct mdp_dev *mdp;
 	struct device *dev;
+	int id;
 
 	if (!mssg) {
 		pr_info("%s:no callback data\n", __func__);
@@ -335,7 +339,8 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	INIT_WORK(&cmd->auto_release_work, mdp_auto_release_work);
 	if (!queue_work(mdp->clock_wq, &cmd->auto_release_work)) {
 		dev_err(dev, "%s:queue_work fail!\n", __func__);
-		mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+		id = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
+		mtk_mutex_unprepare(mdp->mdp_mutex[id]);
 		mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 				    cmd->num_comps);
 
@@ -387,7 +392,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_free_comps;
 	}
 
-	ret = mtk_mutex_prepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+	i = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
+	ret = mtk_mutex_prepare(mdp->mdp_mutex[i]);
 	if (ret) {
 		dev_err(dev, "Fail to enable mutex clk\n");
 		goto err_free_path;
@@ -453,7 +459,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 err_free_path:
-	mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+	i = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
+	mtk_mutex_unprepare(mdp->mdp_mutex[i]);
 	kfree(path);
 err_free_comps:
 	kfree(comps);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 207b54f84fc0..91fea0c13651 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -153,7 +153,7 @@ static int mdp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mdp_dev *mdp;
 	struct platform_device *mm_pdev;
-	int ret, i;
+	int ret, i, mutex_id;
 
 	mdp = kzalloc(sizeof(*mdp), GFP_KERNEL);
 	if (!mdp) {
@@ -176,9 +176,12 @@ static int mdp_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto err_destroy_device;
 	}
-	for (i = 0; i < MDP_PIPE_MAX; i++) {
-		mdp->mdp_mutex[i] = mtk_mutex_get(&mm_pdev->dev);
-		if (!mdp->mdp_mutex[i]) {
+	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++) {
+		mutex_id = mdp->mdp_data->pipe_info[i].mutex_id;
+		if (mdp->mdp_mutex[mutex_id])
+			continue;
+		mdp->mdp_mutex[mutex_id] = mtk_mutex_get(&mm_pdev->dev);
+		if (!mdp->mdp_mutex[mutex_id]) {
 			ret = -ENODEV;
 			goto err_free_mutex;
 		}
@@ -259,7 +262,7 @@ static int mdp_probe(struct platform_device *pdev)
 err_deinit_comp:
 	mdp_comp_destroy(mdp);
 err_free_mutex:
-	for (i = 0; i < MDP_PIPE_MAX; i++)
+	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++)
 		mtk_mutex_put(mdp->mdp_mutex[i]);
 err_destroy_device:
 	kfree(mdp);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index a312c1007e96..59a1c88d8184 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -43,10 +43,10 @@ struct mdp_platform_config {
 
 /* indicate which mutex is used by each pipepline */
 enum mdp_pipe_id {
-	MDP_PIPE_RDMA0,
-	MDP_PIPE_IMGI,
 	MDP_PIPE_WPEI,
 	MDP_PIPE_WPEI2,
+	MDP_PIPE_IMGI,
+	MDP_PIPE_RDMA0,
 	MDP_PIPE_MAX
 };
 
@@ -60,6 +60,8 @@ struct mtk_mdp_driver_data {
 	const struct mdp_format *format;
 	unsigned int format_len;
 	const struct mdp_limit *def_limit;
+	const struct mdp_pipe_info *pipe_info;
+	unsigned int pipe_info_len;
 };
 
 struct mdp_dev {
@@ -91,6 +93,11 @@ struct mdp_dev {
 	atomic_t				job_count;
 };
 
+struct mdp_pipe_info {
+	enum mdp_pipe_id pipe_id;
+	u32 mutex_id;
+};
+
 int mdp_vpu_get_locked(struct mdp_dev *mdp);
 void mdp_vpu_put_locked(struct mdp_dev *mdp);
 int mdp_vpu_register(struct mdp_dev *mdp);
-- 
2.18.0

