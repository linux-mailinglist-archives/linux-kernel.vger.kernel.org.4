Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9267566B61B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjAPDWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjAPDWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:22:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C1E76A4;
        Sun, 15 Jan 2023 19:22:03 -0800 (PST)
X-UUID: eadb59e6954c11ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yI0/MJ3SDEiuC4nBdoUnbCOoT52f/xg0zqsHGYfXxCA=;
        b=RZ7AdPJ2HVb/nYpzY4w+lMukIsUh+Cq2ewruTTfKTBukTLoyRPWOtBARkzUHMvqjMK0k/wQwPao4/w0WcuKwY61EEqG6TOUrww/ISPt8U8GBXUNnUTy4bNurfwKXOzJFNwA/yqcD25qb1/9zIE1eRvgd2FfkvdOzTpwf8Dy757o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:1530d215-57fd-4a6e-b831-798c40af4386,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.17,REQID:1530d215-57fd-4a6e-b831-798c40af4386,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:543e81c,CLOUDID:46f6558c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230113170357QD90ASW0,BulkQuantity:6,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0
X-UUID: eadb59e6954c11ed945fc101203acc17-20230116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 694426333; Mon, 16 Jan 2023 11:21:50 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 11:21:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 11:21:49 +0800
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
Subject: [RESEND v3 13/13] media: platform: mtk-mdp3: add support for parallel pipe to improve FPS
Date:   Mon, 16 Jan 2023 11:21:47 +0800
Message-ID: <20230116032147.23607-14-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230116032147.23607-1-moudy.ho@mediatek.com>
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
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

In advanced chips, MDP3 has the ability to have multiple pipelines
process the same frame in parallel.
In order to implement it, multiple CMDQ clients and packets need to
be configured simultaneously.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../mediatek/mdp3/mt8195/mdp3-plat-mt8195.h   |   5 +
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 194 +++++++++++++-----
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  21 +-
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  12 +-
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  15 ++
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  18 ++
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |   3 +-
 9 files changed, 208 insertions(+), 62 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mt8195/mdp3-plat-mt8195.h b/drivers/media/platform/mediatek/mdp3/mt8195/mdp3-plat-mt8195.h
index 48bb4d2401cf..340a976360d1 100644
--- a/drivers/media/platform/mediatek/mdp3/mt8195/mdp3-plat-mt8195.h
+++ b/drivers/media/platform/mediatek/mdp3/mt8195/mdp3-plat-mt8195.h
@@ -661,4 +661,9 @@ static const struct mdp_limit mt8195_mdp_def_limit = {
 	.v_scale_down_max = 128,
 };
 
+static const struct v4l2_rect mt8195_mdp_pp_criteria = {
+	.width = 1920,
+	.height = 1080,
+};
+
 #endif  /* __MDP3_PLAT_MT8195_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 9b65e653cae6..9b555548bed8 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -67,6 +67,16 @@ static struct mtk_mutex *__get_mutex(const struct mdp_dev *mdp_dev,
 	return m;
 }
 
+static u8 __get_pp_num(enum mdp_stream_type type)
+{
+	switch (type) {
+	case MDP_STREAM_TYPE_DUAL_BITBLT:
+		return MDP_PP_USED_2;
+	default:
+		return MDP_PP_USED_1;
+	}
+}
+
 static enum mdp_pipe_id __get_pipe(const struct mdp_dev *mdp_dev,
 				   enum mtk_mdp_comp_id id)
 {
@@ -104,6 +114,44 @@ static enum mdp_pipe_id __get_pipe(const struct mdp_dev *mdp_dev,
 	return pipe_id;
 }
 
+static struct img_config *__get_config_offset(struct mdp_dev *mdp,
+					      struct mdp_cmdq_param *param,
+					      u8 pp_idx)
+{
+	const int p_id = mdp->mdp_data->mdp_plat_id;
+	struct device *dev = &mdp->pdev->dev;
+	void *cfg_c, *cfg_n;
+	long bound = mdp->vpu.config_size;
+
+	if (pp_idx >= mdp->mdp_data->pp_used)
+		goto err_param;
+
+	if (CFG_CHECK(MT8183, p_id))
+		cfg_c = CFG_OFST(MT8183, param->config, pp_idx);
+	else if (CFG_CHECK(MT8195, p_id))
+		cfg_c = CFG_OFST(MT8195, param->config, pp_idx);
+	else
+		goto err_param;
+
+	if (CFG_CHECK(MT8183, p_id))
+		cfg_n = CFG_OFST(MT8183, param->config, pp_idx + 1);
+	else if (CFG_CHECK(MT8195, p_id))
+		cfg_n = CFG_OFST(MT8195, param->config, pp_idx + 1);
+	else
+		goto err_param;
+
+	if ((long)cfg_n - (long)mdp->vpu.config > bound) {
+		dev_err(dev, "config offset %ld OOB %ld\n", (long)cfg_n, bound);
+		cfg_c = ERR_PTR(-EFAULT);
+	}
+
+	return (struct img_config *)cfg_c;
+
+err_param:
+	cfg_c = ERR_PTR(-EINVAL);
+	return (struct img_config *)cfg_c;
+}
+
 static int mdp_path_subfrm_require(const struct mdp_path *path,
 				   struct mdp_cmdq_cmd *cmd,
 				   struct mdp_pipe_info *p, u32 count)
@@ -486,8 +534,19 @@ static void mdp_auto_release_work(struct work_struct *work)
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 
-	atomic_dec(&mdp->job_count);
-	wake_up(&mdp->callback_wq);
+	if (atomic_dec_and_test(&mdp->job_count)) {
+		if (cmd->mdp_ctx)
+			mdp_m2m_job_finish(cmd->mdp_ctx);
+
+		if (cmd->user_cmdq_cb) {
+			struct cmdq_cb_data user_cb_data;
+
+			user_cb_data.sta = cmd->data->sta;
+			user_cb_data.pkt = cmd->data->pkt;
+			cmd->user_cmdq_cb(user_cb_data);
+		}
+		wake_up(&mdp->callback_wq);
+	}
 
 	mdp_cmdq_pkt_destroy(&cmd->pkt);
 	kfree(cmd->comps);
@@ -511,20 +570,10 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 
 	data = (struct cmdq_cb_data *)mssg;
 	cmd = container_of(data->pkt, struct mdp_cmdq_cmd, pkt);
+	cmd->data = data;
 	mdp = cmd->mdp;
 	dev = &mdp->pdev->dev;
 
-	if (cmd->mdp_ctx)
-		mdp_m2m_job_finish(cmd->mdp_ctx);
-
-	if (cmd->user_cmdq_cb) {
-		struct cmdq_cb_data user_cb_data;
-
-		user_cb_data.sta = data->sta;
-		user_cb_data.pkt = data->pkt;
-		cmd->user_cmdq_cb(user_cb_data);
-	}
-
 	INIT_WORK(&cmd->auto_release_work, mdp_auto_release_work);
 	if (!queue_work(mdp->clock_wq, &cmd->auto_release_work)) {
 		struct mtk_mutex *mutex;
@@ -536,8 +585,8 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 		mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 				    cmd->num_comps);
 
-		atomic_dec(&mdp->job_count);
-		wake_up(&mdp->callback_wq);
+		if (atomic_dec_and_test(&mdp->job_count))
+			wake_up(&mdp->callback_wq);
 
 		mdp_cmdq_pkt_destroy(&cmd->pkt);
 		kfree(cmd->comps);
@@ -547,40 +596,44 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	}
 }
 
-int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
+static struct mdp_cmdq_cmd *mdp_cmdq_prepare(struct mdp_dev *mdp,
+					     struct mdp_cmdq_param *param,
+					     u8 pp_idx)
 {
 	struct mdp_path *path = NULL;
 	struct mdp_cmdq_cmd *cmd = NULL;
 	struct mdp_comp *comps = NULL;
 	struct device *dev = &mdp->pdev->dev;
 	const int p_id = mdp->mdp_data->mdp_plat_id;
+	struct img_config *config;
 	struct mtk_mutex *mutex = NULL;
 	enum mdp_pipe_id pipe_id;
-	int i, ret;
-	u32 num_comp = 0;
+	int i, ret = -ECANCELED;
+	u32 num_comp;
 
-	atomic_inc(&mdp->job_count);
-	if (atomic_read(&mdp->suspended)) {
-		atomic_dec(&mdp->job_count);
-		return -ECANCELED;
+	config = __get_config_offset(mdp, param, pp_idx);
+	if (IS_ERR(config)) {
+		ret = PTR_ERR(config);
+		goto err_uninit;
 	}
 
+	if (CFG_CHECK(MT8183, p_id))
+		num_comp = CFG_GET(MT8183, config, num_components);
+	else if (CFG_CHECK(MT8195, p_id))
+		num_comp = CFG_GET(MT8195, config, num_components);
+	else
+		goto err_uninit;
+
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd) {
 		ret = -ENOMEM;
-		goto err_cancel_job;
+		goto err_uninit;
 	}
 
-	ret = mdp_cmdq_pkt_create(mdp->cmdq_clt, &cmd->pkt, SZ_16K);
+	ret = mdp_cmdq_pkt_create(mdp->cmdq_clt[pp_idx], &cmd->pkt, SZ_16K);
 	if (ret)
 		goto err_free_cmd;
 
-	if (CFG_CHECK(MT8183, p_id))
-		num_comp = CFG_GET(MT8183, param->config, num_components);
-	else if (CFG_CHECK(MT8195, p_id))
-		num_comp = CFG_GET(MT8195, param->config, num_components);
-	else
-		goto err_destroy_pkt;
 	comps = kcalloc(num_comp, sizeof(*comps), GFP_KERNEL);
 	if (!comps) {
 		ret = -ENOMEM;
@@ -594,7 +647,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	}
 
 	path->mdp_dev = mdp;
-	path->config = param->config;
+	path->config = config;
 	path->param = param->param;
 	for (i = 0; i < param->param->num_outputs; i++) {
 		path->bounds[i].left = 0;
@@ -608,7 +661,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	}
 	ret = mdp_path_ctx_init(mdp, path);
 	if (ret) {
-		dev_err(dev, "mdp_path_ctx_init error\n");
+		dev_err(dev, "mdp_path_ctx_init error %d\n", pp_idx);
 		goto err_free_path;
 	}
 
@@ -616,13 +669,13 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[pipe_id]);
 	ret = mtk_mutex_prepare(mutex);
 	if (ret) {
-		dev_err(dev, "Fail to enable mutex clk\n");
+		dev_err(dev, "Fail to enable mutex %d clk\n", pp_idx);
 		goto err_free_path;
 	}
 
 	ret = mdp_path_config(mdp, cmd, path);
 	if (ret) {
-		dev_err(dev, "mdp_path_config error\n");
+		dev_err(dev, "mdp_path_config error %d\n", pp_idx);
 		goto err_free_path;
 	}
 	cmdq_pkt_finalize(&cmd->pkt);
@@ -641,7 +694,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		       sizeof(struct mdp_comp));
 	}
 
-	mdp->cmdq_clt->client.rx_callback = mdp_handle_cmdq_callback;
+	mdp->cmdq_clt[pp_idx]->client.rx_callback = mdp_handle_cmdq_callback;
 	cmd->mdp = mdp;
 	cmd->user_cmdq_cb = param->cmdq_cb;
 	cmd->user_cb_data = param->cb_data;
@@ -649,26 +702,9 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	cmd->num_comps = num_comp;
 	cmd->mdp_ctx = param->mdp_ctx;
 
-	ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd->comps, cmd->num_comps);
-	if (ret)
-		goto err_free_path;
-
-	dma_sync_single_for_device(mdp->cmdq_clt->chan->mbox->dev,
-				   cmd->pkt.pa_base, cmd->pkt.cmd_buf_size,
-				   DMA_TO_DEVICE);
-	ret = mbox_send_message(mdp->cmdq_clt->chan, &cmd->pkt);
-	if (ret < 0) {
-		dev_err(dev, "mbox send message fail %d!\n", ret);
-		goto err_clock_off;
-	}
-	mbox_client_txdone(mdp->cmdq_clt->chan, 0);
-
 	kfree(path);
-	return 0;
+	return cmd;
 
-err_clock_off:
-	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
-			    cmd->num_comps);
 err_free_path:
 	if (mutex)
 		mtk_mutex_unprepare(mutex);
@@ -679,8 +715,58 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	mdp_cmdq_pkt_destroy(&cmd->pkt);
 err_free_cmd:
 	kfree(cmd);
+err_uninit:
+	return ERR_PTR(ret);
+}
+
+int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
+{
+	struct mdp_cmdq_cmd *cmd[MDP_PP_MAX] = {NULL};
+	struct device *dev = &mdp->pdev->dev;
+	int i, ret;
+	u8 pp_used = __get_pp_num(param->param->type);
+
+	atomic_set(&mdp->job_count, pp_used);
+	if (atomic_read(&mdp->suspended)) {
+		atomic_set(&mdp->job_count, 0);
+		return -ECANCELED;
+	}
+
+	for (i = 0; i < pp_used; i++) {
+		cmd[i] = mdp_cmdq_prepare(mdp, param, i);
+		if (IS_ERR_OR_NULL(cmd[i])) {
+			ret = PTR_ERR(cmd[i]);
+			goto err_cancel_job;
+		}
+	}
+
+	for (i = 0; i < pp_used; i++) {
+		ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd[i]->comps, cmd[i]->num_comps);
+		if (ret)
+			goto err_clock_off;
+	}
+
+	for (i = 0; i < pp_used; i++) {
+		dma_sync_single_for_device(mdp->cmdq_clt[i]->chan->mbox->dev,
+					   cmd[i]->pkt.pa_base, cmd[i]->pkt.cmd_buf_size,
+					   DMA_TO_DEVICE);
+
+		ret = mbox_send_message(mdp->cmdq_clt[i]->chan, &cmd[i]->pkt);
+		if (ret < 0) {
+			dev_err(dev, "mbox send message fail %d!\n", ret);
+			i = pp_used;
+			goto err_clock_off;
+		}
+		mbox_client_txdone(mdp->cmdq_clt[i]->chan, 0);
+	}
+	return 0;
+
+err_clock_off:
+	while (--i >= 0)
+		mdp_comp_clocks_off(&mdp->pdev->dev, cmd[i]->comps,
+				    cmd[i]->num_comps);
 err_cancel_job:
-	atomic_dec(&mdp->job_count);
+	atomic_set(&mdp->job_count, 0);
 
 	return ret;
 }
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
index 43475b862ddb..53a30ad7e0b0 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
@@ -29,6 +29,7 @@ struct mdp_cmdq_cmd {
 	struct cmdq_pkt pkt;
 	s32 *event;
 	struct mdp_dev *mdp;
+	struct cmdq_cb_data *data;
 	void (*user_cmdq_cb)(struct cmdq_cb_data data);
 	void *user_cb_data;
 	struct mdp_comp *comps;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 1699da1c684b..948c0bf183ca 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -31,6 +31,7 @@ static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.format = mt8183_formats,
 	.format_len = ARRAY_SIZE(mt8183_formats),
 	.def_limit = &mt8183_mdp_def_limit,
+	.pp_used = MDP_PP_USED_1,
 };
 
 static const struct mtk_mdp_driver_data mt8195_mdp_driver_data = {
@@ -46,6 +47,8 @@ static const struct mtk_mdp_driver_data mt8195_mdp_driver_data = {
 	.format = mt8195_formats,
 	.format_len = ARRAY_SIZE(mt8195_formats),
 	.def_limit = &mt8195_mdp_def_limit,
+	.pp_criteria = &mt8195_mdp_pp_criteria,
+	.pp_used = MDP_PP_USED_2,
 };
 
 static const struct of_device_id mdp_of_ids[] = {
@@ -170,6 +173,10 @@ void mdp_video_device_release(struct video_device *vdev)
 	struct mdp_dev *mdp = (struct mdp_dev *)video_get_drvdata(vdev);
 	int i;
 
+	for (i = 0; i < mdp->mdp_data->pp_used; i++)
+		if (mdp->cmdq_clt[i])
+			cmdq_mbox_destroy(mdp->cmdq_clt[i]);
+
 	scp_put(mdp->scp);
 
 	destroy_workqueue(mdp->job_wq);
@@ -291,10 +298,12 @@ static int mdp_probe(struct platform_device *pdev)
 	mutex_init(&mdp->vpu_lock);
 	mutex_init(&mdp->m2m_lock);
 
-	mdp->cmdq_clt = cmdq_mbox_create(dev, 0);
-	if (IS_ERR(mdp->cmdq_clt)) {
-		ret = PTR_ERR(mdp->cmdq_clt);
-		goto err_put_scp;
+	for (i = 0; i < mdp->mdp_data->pp_used; i++) {
+		mdp->cmdq_clt[i] = cmdq_mbox_create(dev, i);
+		if (IS_ERR(mdp->cmdq_clt[i])) {
+			ret = PTR_ERR(mdp->cmdq_clt[i]);
+			goto err_mbox_destroy;
+		}
 	}
 
 	init_waitqueue_head(&mdp->callback_wq);
@@ -323,8 +332,8 @@ static int mdp_probe(struct platform_device *pdev)
 err_unregister_device:
 	v4l2_device_unregister(&mdp->v4l2_dev);
 err_mbox_destroy:
-	cmdq_mbox_destroy(mdp->cmdq_clt);
-err_put_scp:
+	while (--i >= 0)
+		cmdq_mbox_destroy(mdp->cmdq_clt[i]);
 	scp_put(mdp->scp);
 err_destroy_clock_wq:
 	destroy_workqueue(mdp->clock_wq);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 24d2ec5b52da..3d5e98f215da 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -68,6 +68,14 @@ enum mdp_pipe_id {
 	MDP_PIPE_MAX
 };
 
+/* MDP parallel pipe control */
+enum {
+	MDP_PP_USED_1 = 1,
+	MDP_PP_USED_2 = 2,
+};
+
+#define MDP_PP_MAX MDP_PP_USED_2
+
 struct mtk_mdp_driver_data {
 	const int mdp_plat_id;
 	const struct of_device_id *mdp_probe_infra;
@@ -78,6 +86,8 @@ struct mtk_mdp_driver_data {
 	unsigned int comp_data_len;
 	const struct mdp_pipe_info *pipe_info;
 	unsigned int pipe_info_len;
+	const struct v4l2_rect *pp_criteria;
+	const u8 pp_used;
 	const struct mdp_format *format;
 	unsigned int format_len;
 	const struct mdp_limit *def_limit;
@@ -102,7 +112,7 @@ struct mdp_dev {
 	s32					vpu_count;
 	u32					id_count;
 	struct ida				mdp_ida;
-	struct cmdq_client			*cmdq_clt;
+	struct cmdq_client			*cmdq_clt[MDP_PP_MAX];
 	wait_queue_head_t			callback_wq;
 
 	struct v4l2_device			v4l2_dev;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
index f0a293ab0688..24ca33f59d73 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
@@ -87,6 +87,9 @@ static void mdp_m2m_device_run(void *priv)
 	dst_vb = v4l2_m2m_next_dst_buf(ctx->m2m_ctx);
 	mdp_set_dst_config(&param.outputs[0], frame, &dst_vb->vb2_buf);
 
+	if (mdp_check_pp_enable(ctx->mdp_dev, frame))
+		param.type = MDP_STREAM_TYPE_DUAL_BITBLT;
+
 	ret = mdp_vpu_process(&ctx->mdp_dev->vpu, &param);
 	if (ret) {
 		dev_err(&ctx->mdp_dev->pdev->dev,
@@ -101,6 +104,18 @@ static void mdp_m2m_device_run(void *priv)
 	task.cb_data = NULL;
 	task.mdp_ctx = ctx;
 
+	if (atomic_read(&ctx->mdp_dev->job_count)) {
+		ret = wait_event_timeout(ctx->mdp_dev->callback_wq,
+					 !atomic_read(&ctx->mdp_dev->job_count),
+					 2 * HZ);
+		if (ret == 0) {
+			dev_err(&ctx->mdp_dev->pdev->dev,
+				"%d jobs not yet done\n",
+				atomic_read(&ctx->mdp_dev->job_count));
+			goto worker_end;
+		}
+	}
+
 	ret = mdp_cmdq_send(ctx->mdp_dev, &task);
 	if (ret) {
 		dev_err(&ctx->mdp_dev->pdev->dev,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
index 39093180b98d..9f11ed7e68f7 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
@@ -302,6 +302,24 @@ int mdp_check_scaling_ratio(const struct v4l2_rect *crop,
 	return 0;
 }
 
+bool mdp_check_pp_enable(struct mdp_dev *mdp, struct mdp_frame *frame)
+{
+	u32 s, r1, r2;
+
+	if (!mdp || !frame)
+		return false;
+
+	if (!mdp->mdp_data->pp_criteria)
+		return false;
+
+	s = mdp->mdp_data->pp_criteria->width *
+		mdp->mdp_data->pp_criteria->height;
+	r1 = frame->crop.c.width * frame->crop.c.height;
+	r2 = frame->compose.width * frame->compose.height;
+
+	return (r1 >= s || r2 >= s);
+}
+
 /* Stride that is accepted by MDP HW */
 static u32 mdp_fmt_get_stride(const struct mdp_format *fmt,
 			      u32 bytesperline, unsigned int plane)
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
index e9ab8ac2c0e8..b0c8f9f00820 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
@@ -368,6 +368,7 @@ int mdp_try_crop(struct mdp_m2m_ctx *ctx, struct v4l2_rect *r,
 int mdp_check_scaling_ratio(const struct v4l2_rect *crop,
 			    const struct v4l2_rect *compose, s32 rotation,
 	const struct mdp_limit *limit);
+bool mdp_check_pp_enable(struct mdp_dev *mdp, struct mdp_frame *frame);
 void mdp_set_src_config(struct img_input *in,
 			struct mdp_frame *frame, struct vb2_buffer *vb);
 void mdp_set_dst_config(struct img_output *out,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
index f3cef77720a2..af148006164b 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
@@ -198,6 +198,7 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 	};
 	struct mdp_dev *mdp = vpu_to_mdp(vpu);
 	int err;
+	u8 pp_num = mdp->mdp_data->pp_used;
 
 	init_completion(&vpu->ipi_acked);
 	vpu->scp = scp;
@@ -211,7 +212,7 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 	mutex_lock(vpu->lock);
 	vpu->work_size = ALIGN(vpu->work_size, 64);
 	vpu->param_size = ALIGN(sizeof(struct img_ipi_frameparam), 64);
-	vpu->config_size = ALIGN(sizeof(struct img_config), 64);
+	vpu->config_size = ALIGN(sizeof(struct img_config) * pp_num, 64);
 	err = mdp_vpu_shared_mem_alloc(vpu);
 	mutex_unlock(vpu->lock);
 	if (err) {
-- 
2.18.0

