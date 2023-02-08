Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E5B68EB4E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjBHJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBHJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:24:01 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D546709;
        Wed,  8 Feb 2023 01:22:20 -0800 (PST)
X-UUID: 119cea2aa79211ed945fc101203acc17-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OxUrd9T90yaWUigTdea53Igb3acRv4QvsSj9Gg61xY0=;
        b=djHp8p3LKPGYcmEMvBrZqCNi/O/4XtOczCgaR2W1WVrii6jKG27PggwJx2vAJRzoIkvbKsXlzodl4v0kAJy/NTv6kaykA3/oly0xROU+OQGvIia2X4Zvm/ag6XOWC73nMjQQI6Q3/aqsfn370ovENxO9/Ezw6ozmzpQdhQDQiFg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:792adc32-821b-46d3-a806-f307c756ec2c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:a4d7aa56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 119cea2aa79211ed945fc101203acc17-20230208
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1655103570; Wed, 08 Feb 2023 17:22:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 17:22:11 +0800
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
Subject: [PATCH v4 06/16] media: platform: mtk-mdp3: add support second sets of MUTEX
Date:   Wed, 8 Feb 2023 17:21:59 +0800
Message-ID: <20230208092209.19472-7-moudy.ho@mediatek.com>
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

After configuring the second set of MMSYS (VPPSYS1), a corresponding
second set of MUTEX (MUTEX2) is required to help handle SOF/EOF

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 64 ++++++++++++-------
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 30 +++++++--
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  2 +
 3 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 3177592490be..606651687465 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -44,15 +44,28 @@ static bool is_output_disabled(int p_id, const struct img_compparam *param, u32
 	return (count < num) ? (dis_output || dis_tile) : true;
 }
 
+static struct mtk_mutex *__get_mutex(const struct mdp_dev *mdp_dev,
+				     const struct mdp_pipe_info *p)
+{
+	struct mtk_mutex *m;
+
+	if (p->mmsys_id)
+		m = mdp_dev->mdp_mutex2[p->mutex_id];
+	else
+		m = mdp_dev->mdp_mutex[p->mutex_id];
+
+	return m;
+}
+
 static int mdp_path_subfrm_require(const struct mdp_path *path,
 				   struct mdp_cmdq_cmd *cmd,
-				   s32 *mutex_id, u32 count)
+				   struct mdp_pipe_info *p, u32 count)
 {
 	const int p_id = path->mdp_dev->mdp_data->mdp_plat_id;
 	const struct mdp_comp_ctx *ctx;
 	const struct mtk_mdp_driver_data *data = path->mdp_dev->mdp_data;
 	struct device *dev = &path->mdp_dev->pdev->dev;
-	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
+	struct mtk_mutex *mutex;
 	int id, index;
 	u32 num_comp = 0;
 
@@ -77,7 +90,8 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 		dev_err(dev, "Unknown pipeline and no mutex is assigned");
 		return -EINVAL;
 	}
-	*mutex_id = data->pipe_info[index].mutex_id;
+	memcpy(p, &data->pipe_info[index], sizeof(struct mdp_pipe_info));
+	mutex = __get_mutex(path->mdp_dev, p);
 
 	/* Set mutex mod */
 	for (index = 0; index < num_comp; index++) {
@@ -85,29 +99,28 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 		if (is_output_disabled(p_id, ctx->param, count))
 			continue;
 		id = ctx->comp->public_id;
-		mtk_mutex_write_mod(mutex[*mutex_id],
-				    data->mdp_mutex_table_idx[id], false);
+		mtk_mutex_write_mod(mutex, data->mdp_mutex_table_idx[id], false);
+
 	}
 
-	mtk_mutex_write_sof(mutex[*mutex_id],
-			    MUTEX_SOF_IDX_SINGLE_MODE);
+	mtk_mutex_write_sof(mutex, MUTEX_SOF_IDX_SINGLE_MODE);
 
 	return 0;
 }
 
 static int mdp_path_subfrm_run(const struct mdp_path *path,
 			       struct mdp_cmdq_cmd *cmd,
-			       s32 *mutex_id, u32 count)
+			       struct mdp_pipe_info *p, u32 count)
 {
 	const int p_id = path->mdp_dev->mdp_data->mdp_plat_id;
 	const struct mdp_comp_ctx *ctx;
 	struct device *dev = &path->mdp_dev->pdev->dev;
-	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
+	struct mtk_mutex *mutex;
 	int index;
 	u32 num_comp = 0;
 	s32 event;
 
-	if (-1 == *mutex_id) {
+	if (-1 == p->mutex_id) {
 		dev_err(dev, "Incorrect mutex id");
 		return -EINVAL;
 	}
@@ -127,7 +140,8 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 	}
 
 	/* Enable the mutex */
-	mtk_mutex_enable_by_cmdq(mutex[*mutex_id], (void *)&cmd->pkt);
+	mutex = __get_mutex(path->mdp_dev, p);
+	mtk_mutex_enable_by_cmdq(mutex, (void *)&cmd->pkt);
 
 	/* Wait SOF events and clear mutex modules (optional) */
 	for (index = 0; index < num_comp; index++) {
@@ -174,7 +188,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	const struct img_mmsys_ctrl *ctrl = NULL;
 	const struct img_mux *set;
 	struct mdp_comp_ctx *ctx;
-	s32 mutex_id;
+	struct mdp_pipe_info pipe;
 	int index, ret;
 	u32 num_comp = 0;
 
@@ -185,7 +199,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 		ctrl = CFG_ADDR(MT8183, path->config, ctrls[count]);
 
 	/* Acquire components */
-	ret = mdp_path_subfrm_require(path, cmd, &mutex_id, count);
+	ret = mdp_path_subfrm_require(path, cmd, &pipe, count);
 	if (ret)
 		return ret;
 	/* Enable mux settings */
@@ -204,7 +218,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 			return ret;
 	}
 	/* Run components */
-	ret = mdp_path_subfrm_run(path, cmd, &mutex_id, count);
+	ret = mdp_path_subfrm_run(path, cmd, &pipe, count);
 	if (ret)
 		return ret;
 	/* Wait components done */
@@ -328,13 +342,13 @@ static void mdp_auto_release_work(struct work_struct *work)
 {
 	struct mdp_cmdq_cmd *cmd;
 	struct mdp_dev *mdp;
-	int id;
+	struct mtk_mutex *mutex;
 
 	cmd = container_of(work, struct mdp_cmdq_cmd, auto_release_work);
 	mdp = cmd->mdp;
 
-	id = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-	mtk_mutex_unprepare(mdp->mdp_mutex[id]);
+	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
+	mtk_mutex_unprepare(mutex);
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 
@@ -354,7 +368,6 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	struct cmdq_cb_data *data;
 	struct mdp_dev *mdp;
 	struct device *dev;
-	int id;
 
 	if (!mssg) {
 		pr_info("%s:no callback data\n", __func__);
@@ -379,9 +392,11 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 
 	INIT_WORK(&cmd->auto_release_work, mdp_auto_release_work);
 	if (!queue_work(mdp->clock_wq, &cmd->auto_release_work)) {
+		struct mtk_mutex *mutex;
+
 		dev_err(dev, "%s:queue_work fail!\n", __func__);
-		id = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-		mtk_mutex_unprepare(mdp->mdp_mutex[id]);
+		mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
+		mtk_mutex_unprepare(mutex);
 		mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 				    cmd->num_comps);
 
@@ -403,6 +418,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	struct mdp_comp *comps = NULL;
 	struct device *dev = &mdp->pdev->dev;
 	const int p_id = mdp->mdp_data->mdp_plat_id;
+	struct mtk_mutex *mutex = NULL;
 	int i, ret;
 	u32 num_comp = 0;
 
@@ -440,8 +456,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_free_comps;
 	}
 
-	i = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-	ret = mtk_mutex_prepare(mdp->mdp_mutex[i]);
+	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
+	ret = mtk_mutex_prepare(mutex);
 	if (ret) {
 		dev_err(dev, "Fail to enable mutex clk\n");
 		goto err_free_path;
@@ -506,8 +522,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 err_free_path:
-	i = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-	mtk_mutex_unprepare(mdp->mdp_mutex[i]);
+	if (mutex)
+		mtk_mutex_unprepare(mutex);
 	kfree(path);
 err_free_comps:
 	kfree(comps);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 773a928e32d1..bf64f88c29fe 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -146,8 +146,10 @@ void mdp_video_device_release(struct video_device *vdev)
 	vb2_dma_contig_clear_max_seg_size(&mdp->pdev->dev);
 
 	mdp_comp_destroy(mdp);
-	for (i = 0; i < MDP_PIPE_MAX; i++)
+	for (i = 0; i < MDP_PIPE_MAX; i++) {
 		mtk_mutex_put(mdp->mdp_mutex[i]);
+		mtk_mutex_put(mdp->mdp_mutex2[i]);
+	}
 
 	mdp_vpu_shared_mem_free(&mdp->vpu);
 	v4l2_m2m_release(mdp->m2m_dev);
@@ -190,12 +192,28 @@ static int mdp_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto err_destroy_device;
 	}
+	mm2_pdev = __get_pdev_by_id(pdev, mm_pdev, MDP_INFRA_MUTEX2);
+	/* MUTEX2 must works with MMSYS2 */
+	if ((IS_ERR(mm2_pdev)) ||
+	    (mm2_pdev && IS_ERR_OR_NULL(mdp->mdp_mmsys2))) {
+		ret = -ENODEV;
+		goto err_destroy_device;
+	}
 	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++) {
+		struct platform_device *p;
+		struct mtk_mutex **m;
+		u32 id;
+
 		mutex_id = mdp->mdp_data->pipe_info[i].mutex_id;
-		if (mdp->mdp_mutex[mutex_id])
+		id = mdp->mdp_data->pipe_info[i].mmsys_id;
+		p = (id && mm2_pdev) ? mm2_pdev : mm_pdev;
+		m = (id && mm2_pdev) ?
+			mdp->mdp_mutex2 : mdp->mdp_mutex;
+
+		if (m[mutex_id])
 			continue;
-		mdp->mdp_mutex[mutex_id] = mtk_mutex_get(&mm_pdev->dev);
-		if (!mdp->mdp_mutex[mutex_id]) {
+		m[mutex_id] = mtk_mutex_get(&p->dev);
+		if (!m[mutex_id]) {
 			ret = -ENODEV;
 			goto err_free_mutex;
 		}
@@ -276,8 +294,10 @@ static int mdp_probe(struct platform_device *pdev)
 err_deinit_comp:
 	mdp_comp_destroy(mdp);
 err_free_mutex:
-	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++)
+	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++) {
 		mtk_mutex_put(mdp->mdp_mutex[i]);
+		mtk_mutex_put(mdp->mdp_mutex2[i]);
+	}
 err_destroy_device:
 	kfree(mdp);
 err_return:
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 0434b70e1fc9..725f5a803406 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -22,6 +22,7 @@ enum mdp_infra_id {
 	MDP_INFRA_MMSYS,
 	MDP_INFRA_MMSYS2,
 	MDP_INFRA_MUTEX,
+	MDP_INFRA_MUTEX2,
 	MDP_INFRA_SCP,
 	MDP_INFRA_MAX
 };
@@ -71,6 +72,7 @@ struct mdp_dev {
 	struct device				*mdp_mmsys;
 	struct device				*mdp_mmsys2;
 	struct mtk_mutex			*mdp_mutex[MDP_PIPE_MAX];
+	struct mtk_mutex			*mdp_mutex2[MDP_PIPE_MAX];
 	struct mdp_comp				*comp[MDP_MAX_COMP_COUNT];
 	const struct mtk_mdp_driver_data	*mdp_data;
 
-- 
2.18.0

