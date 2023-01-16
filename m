Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD466B5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjAPDWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjAPDWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:22:04 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD23C7AA1;
        Sun, 15 Jan 2023 19:21:54 -0800 (PST)
X-UUID: e9d64862954c11eda06fc9ecc4dadd91-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n+RUOk3Rle4lLsgGHrL3lemq9bhmr34XSLUuqCNTckc=;
        b=qKzCekHHZQhEOd+Dc5UfHuJCai1y8J4qrSSm1ExAWT/NV9oG2kymQTDZha5VPVmGgbeczKFPxqZhwOh4Mi7HulRP4qyw5eBEmZAVTYDdmHbn9LSe4L+Tpr3W1fLwuvqD9saTbxF4kinv0pqqKZ8M+jp8KM8ndCfdP8yG4dJ8wpA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:1d2dcad2-be1c-4e27-acd2-bf40f2c5e7d9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:c3f5558c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: e9d64862954c11eda06fc9ecc4dadd91-20230116
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1962069436; Mon, 16 Jan 2023 11:21:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 11:21:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 11:21:48 +0800
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
Subject: [RESEND v3 04/13] media: platform: mtk-mdp3: add support second sets of MUTEX
Date:   Mon, 16 Jan 2023 11:21:38 +0800
Message-ID: <20230116032147.23607-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230116032147.23607-1-moudy.ho@mediatek.com>
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
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
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 136 ++++++++++++------
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  30 +++-
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   9 ++
 3 files changed, 123 insertions(+), 52 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index b2ae2f88cbb9..2936701a9cc9 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -43,40 +43,74 @@ static bool is_output_disabled(int p_id, const struct img_compparam *param, u32
 	return (count < num) ? (dis_output || dis_tile) : true;
 }
 
-static int mdp_path_subfrm_require(const struct mdp_path *path,
-				   struct mdp_cmdq_cmd *cmd,
-				   s32 *mutex_id, u32 count)
+static struct mtk_mutex *__get_mutex(const struct mdp_dev *mdp_dev,
+				     const struct mdp_pipe_info *p)
 {
-	const int p_id = path->mdp_dev->mdp_data->mdp_plat_id;
-	const struct mdp_comp_ctx *ctx;
-	const struct mtk_mdp_driver_data *data = path->mdp_dev->mdp_data;
-	struct device *dev = &path->mdp_dev->pdev->dev;
-	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
-	int id, index;
-	u32 num_comp = 0;
+	struct mtk_mutex *m;
 
-	if (CFG_CHECK(MT8183, p_id))
-		num_comp = CFG_GET(MT8183, path->config, num_components);
+	if (p->mmsys_id)
+		m = mdp_dev->mdp_mutex2[p->mutex_id];
+	else
+		m = mdp_dev->mdp_mutex[p->mutex_id];
 
-	/* Decide which mutex to use based on the current pipeline */
-	switch (path->comps[0].comp->public_id) {
+	return m;
+}
+
+static enum mdp_pipe_id __get_pipe(const struct mdp_dev *mdp_dev,
+				   enum mtk_mdp_comp_id id)
+{
+	enum mdp_pipe_id pipe_id;
+
+	switch (id) {
 	case MDP_COMP_RDMA0:
-		index = MDP_PIPE_RDMA0;
+		pipe_id = MDP_PIPE_RDMA0;
 		break;
 	case MDP_COMP_ISP_IMGI:
-		index = MDP_PIPE_IMGI;
+		pipe_id = MDP_PIPE_IMGI;
 		break;
 	case MDP_COMP_WPEI:
-		index = MDP_PIPE_WPEI;
+		pipe_id = MDP_PIPE_WPEI;
 		break;
 	case MDP_COMP_WPEI2:
-		index = MDP_PIPE_WPEI2;
+		pipe_id = MDP_PIPE_WPEI2;
+		break;
+	case MDP_COMP_RDMA1:
+		pipe_id = MDP_PIPE_RDMA1;
+		break;
+	case MDP_COMP_RDMA2:
+		pipe_id = MDP_PIPE_RDMA2;
+		break;
+	case MDP_COMP_RDMA3:
+		pipe_id = MDP_PIPE_RDMA3;
 		break;
 	default:
-		dev_err(dev, "Unknown pipeline and no mutex is assigned");
-		return -EINVAL;
+		/* Avoid exceptions when operating MUTEX */
+		pipe_id = MDP_PIPE_RDMA0;
+		dev_err(&mdp_dev->pdev->dev, "Unknown pipeline id %d", id);
+		break;
 	}
-	*mutex_id = data->pipe_info[index].mutex_id;
+
+	return pipe_id;
+}
+
+static int mdp_path_subfrm_require(const struct mdp_path *path,
+				   struct mdp_cmdq_cmd *cmd,
+				   struct mdp_pipe_info *p, u32 count)
+{
+	const int p_id = path->mdp_dev->mdp_data->mdp_plat_id;
+	const struct mdp_comp_ctx *ctx;
+	const struct mtk_mdp_driver_data *data = path->mdp_dev->mdp_data;
+	struct mtk_mutex *mutex;
+	int id, index;
+	u32 num_comp = 0;
+
+	if (CFG_CHECK(MT8183, p_id))
+		num_comp = CFG_GET(MT8183, path->config, num_components);
+
+	/* Decide which mutex to use based on the current pipeline */
+	index = __get_pipe(path->mdp_dev, path->comps[0].comp->public_id);
+	memcpy(p, &data->pipe_info[index], sizeof(struct mdp_pipe_info));
+	mutex = __get_mutex(path->mdp_dev, p);
 
 	/* Set mutex mod */
 	for (index = 0; index < num_comp; index++) {
@@ -84,29 +118,28 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
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
@@ -126,7 +159,8 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 	}
 
 	/* Enable the mutex */
-	mtk_mutex_enable_by_cmdq(mutex[*mutex_id], (void *)&cmd->pkt);
+	mutex = __get_mutex(path->mdp_dev, p);
+	mtk_mutex_enable_by_cmdq(mutex, (void *)&cmd->pkt);
 
 	/* Wait SOF events and clear mutex modules (optional) */
 	for (index = 0; index < num_comp; index++) {
@@ -173,7 +207,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	const struct img_mmsys_ctrl *ctrl = NULL;
 	const struct img_mux *set;
 	struct mdp_comp_ctx *ctx;
-	s32 mutex_id;
+	struct mdp_pipe_info pipe;
 	int index, ret;
 	u32 num_comp = 0;
 
@@ -184,7 +218,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 		ctrl = CFG_ADDR(MT8183, path->config, ctrls[count]);
 
 	/* Acquire components */
-	ret = mdp_path_subfrm_require(path, cmd, &mutex_id, count);
+	ret = mdp_path_subfrm_require(path, cmd, &pipe, count);
 	if (ret)
 		return ret;
 	/* Enable mux settings */
@@ -203,7 +237,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 			return ret;
 	}
 	/* Run components */
-	ret = mdp_path_subfrm_run(path, cmd, &mutex_id, count);
+	ret = mdp_path_subfrm_run(path, cmd, &pipe, count);
 	if (ret)
 		return ret;
 	/* Wait components done */
@@ -327,13 +361,15 @@ static void mdp_auto_release_work(struct work_struct *work)
 {
 	struct mdp_cmdq_cmd *cmd;
 	struct mdp_dev *mdp;
-	int id;
+	struct mtk_mutex *mutex;
+	enum mdp_pipe_id pipe_id;
 
 	cmd = container_of(work, struct mdp_cmdq_cmd, auto_release_work);
 	mdp = cmd->mdp;
 
-	id = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-	mtk_mutex_unprepare(mdp->mdp_mutex[id]);
+	pipe_id = __get_pipe(mdp, cmd->comps[0].public_id);
+	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[pipe_id]);
+	mtk_mutex_unprepare(mutex);
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 
@@ -353,7 +389,7 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	struct cmdq_cb_data *data;
 	struct mdp_dev *mdp;
 	struct device *dev;
-	int id;
+	enum mdp_pipe_id pipe_id;
 
 	if (!mssg) {
 		pr_info("%s:no callback data\n", __func__);
@@ -378,9 +414,12 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 
 	INIT_WORK(&cmd->auto_release_work, mdp_auto_release_work);
 	if (!queue_work(mdp->clock_wq, &cmd->auto_release_work)) {
+		struct mtk_mutex *mutex;
+
 		dev_err(dev, "%s:queue_work fail!\n", __func__);
-		id = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-		mtk_mutex_unprepare(mdp->mdp_mutex[id]);
+		pipe_id = __get_pipe(mdp, cmd->comps[0].public_id);
+		mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[pipe_id]);
+		mtk_mutex_unprepare(mutex);
 		mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 				    cmd->num_comps);
 
@@ -402,6 +441,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	struct mdp_comp *comps = NULL;
 	struct device *dev = &mdp->pdev->dev;
 	const int p_id = mdp->mdp_data->mdp_plat_id;
+	struct mtk_mutex *mutex = NULL;
+	enum mdp_pipe_id pipe_id;
 	int i, ret;
 	u32 num_comp = 0;
 
@@ -437,13 +478,6 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_free_comps;
 	}
 
-	i = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-	ret = mtk_mutex_prepare(mdp->mdp_mutex[i]);
-	if (ret) {
-		dev_err(dev, "Fail to enable mutex clk\n");
-		goto err_free_path;
-	}
-
 	path->mdp_dev = mdp;
 	path->config = param->config;
 	path->param = param->param;
@@ -463,6 +497,14 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_free_path;
 	}
 
+	pipe_id = __get_pipe(mdp, path->comps[0].comp->public_id);
+	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[pipe_id]);
+	ret = mtk_mutex_prepare(mutex);
+	if (ret) {
+		dev_err(dev, "Fail to enable mutex clk\n");
+		goto err_free_path;
+	}
+
 	ret = mdp_path_config(mdp, cmd, path);
 	if (ret) {
 		dev_err(dev, "mdp_path_config error\n");
@@ -503,8 +545,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
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
index 927d3d65751a..56c42bd3f16b 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -161,8 +161,10 @@ void mdp_video_device_release(struct video_device *vdev)
 	vb2_dma_contig_clear_max_seg_size(&mdp->pdev->dev);
 
 	mdp_comp_destroy(mdp);
-	for (i = 0; i < MDP_PIPE_MAX; i++)
+	for (i = 0; i < MDP_PIPE_MAX; i++) {
 		mtk_mutex_put(mdp->mdp_mutex[i]);
+		mtk_mutex_put(mdp->mdp_mutex2[i]);
+	}
 
 	mdp_vpu_shared_mem_free(&mdp->vpu);
 	v4l2_m2m_release(mdp->m2m_dev);
@@ -205,12 +207,28 @@ static int mdp_probe(struct platform_device *pdev)
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
@@ -291,8 +309,10 @@ static int mdp_probe(struct platform_device *pdev)
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
index 0b40ccfd376c..ce9e2b9850e6 100644
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
@@ -48,6 +49,13 @@ enum mdp_pipe_id {
 	MDP_PIPE_WPEI2,
 	MDP_PIPE_IMGI,
 	MDP_PIPE_RDMA0,
+	MDP_PIPE_RDMA1,
+	MDP_PIPE_RDMA2,
+	MDP_PIPE_RDMA3,
+	MDP_PIPE_SPLIT,
+	MDP_PIPE_SPLIT2,
+	MDP_PIPE_VPP0_SOUT,
+	MDP_PIPE_VPP1_SOUT,
 	MDP_PIPE_MAX
 };
 
@@ -71,6 +79,7 @@ struct mdp_dev {
 	struct device				*mdp_mmsys;
 	struct device				*mdp_mmsys2;
 	struct mtk_mutex			*mdp_mutex[MDP_PIPE_MAX];
+	struct mtk_mutex			*mdp_mutex2[MDP_PIPE_MAX];
 	struct mdp_comp				*comp[MDP_MAX_COMP_COUNT];
 	const struct mtk_mdp_driver_data	*mdp_data;
 
-- 
2.18.0

