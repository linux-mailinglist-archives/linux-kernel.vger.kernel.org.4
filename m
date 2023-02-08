Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E568EAA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBHJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBHJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:09:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE9457E2;
        Wed,  8 Feb 2023 01:09:05 -0800 (PST)
X-UUID: 397958e6a79011ed945fc101203acc17-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ax2XuNfUBHBtpr8vujDc9/6SPxBC3TVYTjEygh12S44=;
        b=imAsgPsT3+EQk9JCEFOVoPcey86vG+6uh95u4453Pcq45t3R4d98WUUSIa4hgow1EyHkaZACFsTz4G5TkOwbdxNWacIem1WjaW0YjmBuwHwG+mKR2ZaGsVOr6dwCWqDehKtRdbfp+uaSgRNCd9VNxiMvtM3dAMq7NrucxdYWWAU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:ac9706ec-6042-4778-ac72-499cc7a65a09,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.19,REQID:ac9706ec-6042-4778-ac72-499cc7a65a09,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:885ddb2,CLOUDID:ff72aa56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230208170900S5227Y1W,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 397958e6a79011ed945fc101203acc17-20230208
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 114881155; Wed, 08 Feb 2023 17:08:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Feb 2023 17:08:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:08:58 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Ping-Hsun Wu" <ping-hsun.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 12/12] media: platform: mtk-mdp3: reconfigure shared memory
Date:   Wed, 8 Feb 2023 17:08:55 +0800
Message-ID: <20230208090855.18934-13-moudy.ho@mediatek.com>
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

For performance and multi-chip support, use dynamic layout instead of
statically configured pools.
Divide the shared memory into the 3 64-bit aligned layouts listed below:

    vpu->param_addr  -> +-----------------------------------------+
                        |                                         |
                        | To SCP : Input frame parameters         |
                        |          (struct img_ipi_frameparam)    |
                        |                                         |
                        +-----------------------------------------+

    vpu->work_addr   -> +-----------------------------------------+
                        |                                         |
                        | In SCP : Reserve for SCP calculation    |
                        |                                         |
                        +-----------------------------------------+

    vpu->config_addr -> +-----------------------------------------+
                        |                                         |
                        | From SCP : Output component config      |
                        |            (struct img_config)          |
                        |                                         |
                        +-----------------------------------------+

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mdp_sm_mt8183.h    |   4 +-
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  13 +-
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.h     |   1 -
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     | 193 ++++++++----------
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.h     |  29 +--
 5 files changed, 95 insertions(+), 145 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_sm_mt8183.h b/drivers/media/platform/mediatek/mdp3/mdp_sm_mt8183.h
index effc75615af9..85637084520f 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_sm_mt8183.h
+++ b/drivers/media/platform/mediatek/mdp3/mdp_sm_mt8183.h
@@ -11,8 +11,8 @@
 
 /*
  * ISP-MDP generic output information
- * MD5 of the target SCP blob:
- *     6da52bdcf4bf76a0983b313e1d4745d6
+ * MD5 of the target SCP prebuild:
+ *     2d995ddb5c3b0cf26e96d6a823481886
  */
 
 #define IMG_MAX_SUBFRAMES_8183      14
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
index eba181fa50ad..f0a293ab0688 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
@@ -87,14 +87,14 @@ static void mdp_m2m_device_run(void *priv)
 	dst_vb = v4l2_m2m_next_dst_buf(ctx->m2m_ctx);
 	mdp_set_dst_config(&param.outputs[0], frame, &dst_vb->vb2_buf);
 
-	ret = mdp_vpu_process(&ctx->vpu, &param);
+	ret = mdp_vpu_process(&ctx->mdp_dev->vpu, &param);
 	if (ret) {
 		dev_err(&ctx->mdp_dev->pdev->dev,
 			"VPU MDP process failed: %d\n", ret);
 		goto worker_end;
 	}
 
-	task.config = ctx->vpu.config;
+	task.config = ctx->mdp_dev->vpu.config;
 	task.param = &param;
 	task.composes[0] = &frame->compose;
 	task.cmdq_cb = NULL;
@@ -150,11 +150,6 @@ static int mdp_m2m_start_streaming(struct vb2_queue *q, unsigned int count)
 
 	if (!mdp_m2m_ctx_is_state_set(ctx, MDP_VPU_INIT)) {
 		ret = mdp_vpu_get_locked(ctx->mdp_dev);
-		if (ret)
-			return ret;
-
-		ret = mdp_vpu_ctx_init(&ctx->vpu, &ctx->mdp_dev->vpu,
-				       MDP_DEV_M2M);
 		if (ret) {
 			dev_err(&ctx->mdp_dev->pdev->dev,
 				"VPU init failed %d\n", ret);
@@ -635,10 +630,8 @@ static int mdp_m2m_release(struct file *file)
 
 	mutex_lock(&mdp->m2m_lock);
 	v4l2_m2m_ctx_release(ctx->m2m_ctx);
-	if (mdp_m2m_ctx_is_state_set(ctx, MDP_VPU_INIT)) {
-		mdp_vpu_ctx_deinit(&ctx->vpu);
+	if (mdp_m2m_ctx_is_state_set(ctx, MDP_VPU_INIT))
 		mdp_vpu_put_locked(mdp);
-	}
 
 	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
 	v4l2_fh_del(&ctx->fh);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.h
index 61ddbaf1bf13..dfc59e5b3b87 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.h
@@ -33,7 +33,6 @@ struct mdp_m2m_ctx {
 	struct v4l2_ctrl_handler	ctrl_handler;
 	struct mdp_m2m_ctrls		ctrls;
 	struct v4l2_m2m_ctx		*m2m_ctx;
-	struct mdp_vpu_ctx		vpu;
 	u32				frame_count[MDP_M2M_MAX];
 
 	struct mdp_frameparam		curr_param;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
index a72bed927bb6..49fc2e9d45dd 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
@@ -10,7 +10,6 @@
 #include "mtk-mdp3-core.h"
 
 #define MDP_VPU_MESSAGE_TIMEOUT 500U
-#define vpu_alloc_size		0x600000
 
 static inline struct mdp_dev *vpu_to_mdp(struct mdp_vpu_dev *vpu)
 {
@@ -19,23 +18,63 @@ static inline struct mdp_dev *vpu_to_mdp(struct mdp_vpu_dev *vpu)
 
 static int mdp_vpu_shared_mem_alloc(struct mdp_vpu_dev *vpu)
 {
-	if (vpu->work && vpu->work_addr)
-		return 0;
+	struct device *dev;
 
-	vpu->work = dma_alloc_coherent(scp_get_device(vpu->scp), vpu_alloc_size,
-				       &vpu->work_addr, GFP_KERNEL);
+	if (IS_ERR_OR_NULL(vpu))
+		goto err_return;
 
-	if (!vpu->work)
-		return -ENOMEM;
-	else
-		return 0;
+	dev = scp_get_device(vpu->scp);
+
+	if (!vpu->param) {
+		vpu->param = dma_alloc_wc(dev, vpu->param_size,
+					  &vpu->param_addr, GFP_KERNEL);
+		if (!vpu->param)
+			goto err_return;
+	}
+
+	if (!vpu->work) {
+		vpu->work = dma_alloc_wc(dev, vpu->work_size,
+					 &vpu->work_addr, GFP_KERNEL);
+		if (!vpu->work)
+			goto err_free_param;
+	}
+
+	if (!vpu->config) {
+		vpu->config = dma_alloc_wc(dev, vpu->config_size,
+					   &vpu->config_addr, GFP_KERNEL);
+		if (!vpu->config)
+			goto err_free_work;
+	}
+
+	return 0;
+
+err_free_work:
+	dma_free_wc(dev, vpu->work_size, vpu->work, vpu->work_addr);
+	vpu->work = NULL;
+err_free_param:
+	dma_free_wc(dev, vpu->param_size, vpu->param, vpu->param_addr);
+	vpu->param = NULL;
+err_return:
+	return -ENOMEM;
 }
 
 void mdp_vpu_shared_mem_free(struct mdp_vpu_dev *vpu)
 {
+	struct device *dev;
+
+	if (IS_ERR_OR_NULL(vpu))
+		return;
+
+	dev = scp_get_device(vpu->scp);
+
+	if (vpu->param && vpu->param_addr)
+		dma_free_wc(dev, vpu->param_size, vpu->param, vpu->param_addr);
+
 	if (vpu->work && vpu->work_addr)
-		dma_free_coherent(scp_get_device(vpu->scp), vpu_alloc_size,
-				  vpu->work, vpu->work_addr);
+		dma_free_wc(dev, vpu->work_size, vpu->work, vpu->work_addr);
+
+	if (vpu->config && vpu->config_addr)
+		dma_free_wc(dev, vpu->config_size, vpu->config, vpu->config_addr);
 }
 
 static void mdp_vpu_ipi_handle_init_ack(void *data, unsigned int len,
@@ -69,16 +108,16 @@ static void mdp_vpu_ipi_handle_frame_ack(void *data, unsigned int len,
 	struct img_sw_addr *addr = (struct img_sw_addr *)data;
 	struct img_ipi_frameparam *param =
 		(struct img_ipi_frameparam *)(unsigned long)addr->va;
-	struct mdp_vpu_ctx *ctx =
-		(struct mdp_vpu_ctx *)(unsigned long)param->drv_data;
+	struct mdp_vpu_dev *vpu =
+		(struct mdp_vpu_dev *)(unsigned long)param->drv_data;
 
 	if (param->state) {
-		struct mdp_dev *mdp = vpu_to_mdp(ctx->vpu_dev);
+		struct mdp_dev *mdp = vpu_to_mdp(vpu);
 
 		dev_err(&mdp->pdev->dev, "VPU MDP failure:%d\n", param->state);
 	}
-	ctx->vpu_dev->status = param->state;
-	complete(&ctx->vpu_dev->ipi_acked);
+	vpu->status = param->state;
+	complete(&vpu->ipi_acked);
 }
 
 int mdp_vpu_register(struct mdp_dev *mdp)
@@ -157,9 +196,6 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 	struct mdp_ipi_init_msg msg = {
 		.drv_data = (unsigned long)vpu,
 	};
-	size_t mem_size;
-	phys_addr_t pool;
-	const size_t pool_size = sizeof(struct mdp_config_pool);
 	struct mdp_dev *mdp = vpu_to_mdp(vpu);
 	int err;
 
@@ -172,34 +208,29 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 		goto err_work_size;
 	/* vpu work_size was set in mdp_vpu_ipi_handle_init_ack */
 
-	mem_size = vpu_alloc_size;
+	mutex_lock(vpu->lock);
+	vpu->work_size = ALIGN(vpu->work_size, 64);
+	vpu->param_size = ALIGN(sizeof(struct img_ipi_frameparam), 64);
+	vpu->config_size = ALIGN(sizeof(struct img_config), 64);
 	err = mdp_vpu_shared_mem_alloc(vpu);
+	mutex_unlock(vpu->lock);
 	if (err) {
 		dev_err(&mdp->pdev->dev, "VPU memory alloc fail!");
 		goto err_mem_alloc;
 	}
 
-	pool = ALIGN((uintptr_t)vpu->work + vpu->work_size, 8);
-	if (pool + pool_size - (uintptr_t)vpu->work > mem_size) {
-		dev_err(&mdp->pdev->dev,
-			"VPU memory insufficient: %zx + %zx > %zx",
-			vpu->work_size, pool_size, mem_size);
-		err = -ENOMEM;
-		goto err_mem_size;
-	}
-
 	dev_dbg(&mdp->pdev->dev,
-		"VPU work:%pK pa:%pad sz:%zx pool:%pa sz:%zx (mem sz:%zx)",
+		"VPU param:%pK pa:%pad sz:%zx, work:%pK pa:%pad sz:%zx, config:%pK pa:%pad sz:%zx",
+		vpu->param, &vpu->param_addr, vpu->param_size,
 		vpu->work, &vpu->work_addr, vpu->work_size,
-		&pool, pool_size, mem_size);
-	vpu->pool = (struct mdp_config_pool *)(uintptr_t)pool;
+		vpu->config, &vpu->config_addr, vpu->config_size);
+
 	msg.work_addr = vpu->work_addr;
 	msg.work_size = vpu->work_size;
 	err = mdp_vpu_sendmsg(vpu, SCP_IPI_MDP_INIT, &msg, sizeof(msg));
 	if (err)
 		goto err_work_size;
 
-	memset(vpu->pool, 0, sizeof(*vpu->pool));
 	return 0;
 
 err_work_size:
@@ -212,7 +243,6 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 		break;
 	}
 	return err;
-err_mem_size:
 err_mem_alloc:
 	return err;
 }
@@ -227,88 +257,31 @@ int mdp_vpu_dev_deinit(struct mdp_vpu_dev *vpu)
 	return mdp_vpu_sendmsg(vpu, SCP_IPI_MDP_DEINIT, &msg, sizeof(msg));
 }
 
-static struct img_config *mdp_config_get(struct mdp_vpu_dev *vpu,
-					 enum mdp_config_id id, uint32_t *addr)
+int mdp_vpu_process(struct mdp_vpu_dev *vpu, struct img_ipi_frameparam *param)
 {
-	struct img_config *config;
-
-	if (id < 0 || id >= MDP_CONFIG_POOL_SIZE)
-		return ERR_PTR(-EINVAL);
+	struct mdp_dev *mdp = vpu_to_mdp(vpu);
+	struct img_sw_addr addr;
 
 	mutex_lock(vpu->lock);
-	vpu->pool->cfg_count[id]++;
-	config = &vpu->pool->configs[id];
-	*addr = vpu->work_addr + ((uintptr_t)config - (uintptr_t)vpu->work);
-	mutex_unlock(vpu->lock);
-
-	return config;
-}
-
-static int mdp_config_put(struct mdp_vpu_dev *vpu,
-			  enum mdp_config_id id,
-			  const struct img_config *config)
-{
-	int err = 0;
-
-	if (id < 0 || id >= MDP_CONFIG_POOL_SIZE)
-		return -EINVAL;
-	if (vpu->lock)
-		mutex_lock(vpu->lock);
-	if (!vpu->pool->cfg_count[id] || config != &vpu->pool->configs[id])
-		err = -EINVAL;
-	else
-		vpu->pool->cfg_count[id]--;
-	if (vpu->lock)
+	if (mdp_vpu_shared_mem_alloc(vpu)) {
+		dev_err(&mdp->pdev->dev, "VPU memory alloc fail!");
 		mutex_unlock(vpu->lock);
-	return err;
-}
-
-int mdp_vpu_ctx_init(struct mdp_vpu_ctx *ctx, struct mdp_vpu_dev *vpu,
-		     enum mdp_config_id id)
-{
-	ctx->config = mdp_config_get(vpu, id, &ctx->inst_addr);
-	if (IS_ERR(ctx->config)) {
-		int err = PTR_ERR(ctx->config);
-
-		ctx->config = NULL;
-		return err;
+		return -ENOMEM;
 	}
-	ctx->config_id = id;
-	ctx->vpu_dev = vpu;
-	return 0;
-}
 
-int mdp_vpu_ctx_deinit(struct mdp_vpu_ctx *ctx)
-{
-	int err = mdp_config_put(ctx->vpu_dev, ctx->config_id, ctx->config);
+	memset(vpu->param, 0, vpu->param_size);
+	memset(vpu->work, 0, vpu->work_size);
+	memset(vpu->config, 0, vpu->config_size);
 
-	ctx->config_id = 0;
-	ctx->config = NULL;
-	ctx->inst_addr = 0;
-	return err;
-}
+	param->self_data.va = (unsigned long)vpu->work;
+	param->self_data.pa = vpu->work_addr;
+	param->config_data.va = (unsigned long)vpu->config;
+	param->config_data.pa = vpu->config_addr;
+	param->drv_data = (unsigned long)vpu;
+	memcpy(vpu->param, param, sizeof(*param));
 
-int mdp_vpu_process(struct mdp_vpu_ctx *ctx, struct img_ipi_frameparam *param)
-{
-	struct mdp_vpu_dev *vpu = ctx->vpu_dev;
-	struct mdp_dev *mdp = vpu_to_mdp(vpu);
-	struct img_sw_addr addr;
-
-	if (!ctx->vpu_dev->work || !ctx->vpu_dev->work_addr) {
-		if (mdp_vpu_shared_mem_alloc(vpu)) {
-			dev_err(&mdp->pdev->dev, "VPU memory alloc fail!");
-			return -ENOMEM;
-		}
-	}
-	memset((void *)ctx->vpu_dev->work, 0, ctx->vpu_dev->work_size);
-	memset(ctx->config, 0, sizeof(*ctx->config));
-	param->config_data.va = (unsigned long)ctx->config;
-	param->config_data.pa = ctx->inst_addr;
-	param->drv_data = (unsigned long)ctx;
-
-	memcpy((void *)ctx->vpu_dev->work, param, sizeof(*param));
-	addr.pa = ctx->vpu_dev->work_addr;
-	addr.va = (uintptr_t)ctx->vpu_dev->work;
-	return mdp_vpu_sendmsg(ctx->vpu_dev, SCP_IPI_MDP_FRAME,
-		&addr, sizeof(addr));
+	addr.pa = vpu->param_addr;
+	addr.va = (unsigned long)vpu->param;
+	mutex_unlock(vpu->lock);
+	return mdp_vpu_sendmsg(vpu, SCP_IPI_MDP_FRAME, &addr, sizeof(addr));
 }
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h
index 244b3a32d689..ad3551bc0730 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h
@@ -37,42 +37,27 @@ struct mdp_ipi_deinit_msg {
 	u32	work_addr;
 } __packed;
 
-enum mdp_config_id {
-	MDP_DEV_M2M = 0,
-	MDP_CONFIG_POOL_SIZE	/* ALWAYS keep at the end */
-};
-
-struct mdp_config_pool {
-	u64			cfg_count[MDP_CONFIG_POOL_SIZE];
-	struct img_config	configs[MDP_CONFIG_POOL_SIZE];
-};
-
 struct mdp_vpu_dev {
 	/* synchronization protect for accessing vpu working buffer info */
 	struct mutex		*lock;
 	struct mtk_scp		*scp;
 	struct completion	ipi_acked;
+	void			*param;
+	dma_addr_t		param_addr;
+	size_t			param_size;
 	void			*work;
 	dma_addr_t		work_addr;
 	size_t			work_size;
-	struct mdp_config_pool	*pool;
+	void			*config;
+	dma_addr_t		config_addr;
+	size_t			config_size;
 	u32			status;
 };
 
-struct mdp_vpu_ctx {
-	struct mdp_vpu_dev	*vpu_dev;
-	u32			config_id;
-	struct img_config	*config;
-	u32			inst_addr;
-};
-
 void mdp_vpu_shared_mem_free(struct mdp_vpu_dev *vpu);
 int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 		     struct mutex *lock /* for sync */);
 int mdp_vpu_dev_deinit(struct mdp_vpu_dev *vpu);
-int mdp_vpu_ctx_init(struct mdp_vpu_ctx *ctx, struct mdp_vpu_dev *vpu,
-		     enum mdp_config_id id);
-int mdp_vpu_ctx_deinit(struct mdp_vpu_ctx *ctx);
-int mdp_vpu_process(struct mdp_vpu_ctx *vpu, struct img_ipi_frameparam *param);
+int mdp_vpu_process(struct mdp_vpu_dev *vpu, struct img_ipi_frameparam *param);
 
 #endif  /* __MTK_MDP3_VPU_H__ */
-- 
2.18.0

