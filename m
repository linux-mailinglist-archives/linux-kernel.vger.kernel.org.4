Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB86058D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJTHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiJTHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:39:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D5017535D;
        Thu, 20 Oct 2022 00:39:16 -0700 (PDT)
X-UUID: 3b59d222064940e08aaedeef1dc11401-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=o9KXsCPHxObZrokcC9WCGtTnB8eScgVMKcD5db6TzyY=;
        b=sB5ilkdcBqw9vZbVleafp/zHeBbox1jVtVXu8e51eHJOoQC+MyL3ck7DvGITO/FmTdeJIZAP4jQu0XfUsA56VDkW6/z6dun7boKefM8PqKh0nxxqDyizfZPT3poG5BcL4dlrRNnRhCKAwVUBo54ZRuYt3LQWNxDxxdxm/mxsjr8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:6ee77a60-46c7-427e-9490-cd2b11368e9f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.12,REQID:6ee77a60-46c7-427e-9490-cd2b11368e9f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:62cd327,CLOUDID:ccf9e0ee-314c-4293-acb8-ca4299dd021f,B
        ulkID:221020153912U0BY8C6Z,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3b59d222064940e08aaedeef1dc11401-20221020
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 754382788; Thu, 20 Oct 2022 15:39:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 20 Oct 2022 15:39:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 20 Oct 2022 15:39:09 +0800
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
Subject: [PATCH v2 6/9] media: platform: mtk-mdp3: chip config split about pipe info
Date:   Thu, 20 Oct 2022 15:38:59 +0800
Message-ID: <20221020073902.21039-7-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221020073902.21039-1-moudy.ho@mediatek.com>
References: <20221020073902.21039-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

More pipes will be introduced in future chip for applications such as
higher frame rate frequency, which should move the relevant information
into the chip configuration header file.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../mediatek/mdp3/mt8183/mdp3-plat-mt8183.h   |  7 ++++
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 38 +++++++++++++++----
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 15 +++++---
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  7 ++++
 4 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
index c541176780aa..670dca4a127c 100644
--- a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
+++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
@@ -21,6 +21,13 @@ static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
 	[MDP_INFRA_SCP] = { .compatible = "mediatek,mt8183-scp" }
 };
 
+static const struct mdp_pipe_info mt8183_pipe_info[] = {
+	{MDP_PIPE_IMGI, 0},
+	{MDP_PIPE_RDMA0, 1},
+	{MDP_PIPE_WPEI, 2},
+	{MDP_PIPE_WPEI2, 3}
+};
+
 static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_RDMA0] = MUTEX_MOD_IDX_MDP_RDMA0,
 	[MDP_COMP_RSZ0] = MUTEX_MOD_IDX_MDP_RSZ0,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index dcd77f65b0e3..0ce291760acb 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -36,6 +36,18 @@ static bool is_output_disabled(const struct img_compparam *param, u32 count)
 		true;
 }
 
+static int mdp_get_pipe_idx(const struct mtk_mdp_driver_data *data,
+			    enum mdp_pipe_id pipe_id)
+{
+	int i;
+
+	for (i = 0; i < data->pipe_info_len; i++)
+		if (pipe_id == data->pipe_info[i].pipe_id)
+			return i;
+
+	return -ENODEV;
+}
+
 static int mdp_path_subfrm_require(const struct mdp_path *path,
 				   struct mdp_cmdq_cmd *cmd,
 				   s32 *mutex_id, u32 count)
@@ -50,16 +62,20 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 	/* Decide which mutex to use based on the current pipeline */
 	switch (path->comps[0].comp->public_id) {
 	case MDP_COMP_RDMA0:
-		*mutex_id = MDP_PIPE_RDMA0;
+		index = mdp_get_pipe_idx(data, MDP_PIPE_RDMA0);
+		*mutex_id = data->pipe_info[index].mutex_id;
 		break;
 	case MDP_COMP_ISP_IMGI:
-		*mutex_id = MDP_PIPE_IMGI;
+		index = mdp_get_pipe_idx(data, MDP_PIPE_IMGI);
+		*mutex_id = data->pipe_info[index].mutex_id;
 		break;
 	case MDP_COMP_WPEI:
-		*mutex_id = MDP_PIPE_WPEI;
+		index = mdp_get_pipe_idx(data, MDP_PIPE_WPEI);
+		*mutex_id = data->pipe_info[index].mutex_id;
 		break;
 	case MDP_COMP_WPEI2:
-		*mutex_id = MDP_PIPE_WPEI2;
+		index = mdp_get_pipe_idx(data, MDP_PIPE_WPEI2);
+		*mutex_id = data->pipe_info[index].mutex_id;
 		break;
 	default:
 		dev_err(dev, "Unknown pipeline and no mutex is assigned");
@@ -286,11 +302,13 @@ static void mdp_auto_release_work(struct work_struct *work)
 {
 	struct mdp_cmdq_cmd *cmd;
 	struct mdp_dev *mdp;
+	int idx;
 
 	cmd = container_of(work, struct mdp_cmdq_cmd, auto_release_work);
 	mdp = cmd->mdp;
 
-	mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+	idx = mdp_get_pipe_idx(mdp->mdp_data, MDP_PIPE_RDMA0);
+	mtk_mutex_unprepare(mdp->mdp_mutex[mdp->mdp_data->pipe_info[idx].mutex_id]);
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 
@@ -310,6 +328,7 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	struct cmdq_cb_data *data;
 	struct mdp_dev *mdp;
 	struct device *dev;
+	int idx;
 
 	if (!mssg) {
 		pr_info("%s:no callback data\n", __func__);
@@ -335,7 +354,8 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	INIT_WORK(&cmd->auto_release_work, mdp_auto_release_work);
 	if (!queue_work(mdp->clock_wq, &cmd->auto_release_work)) {
 		dev_err(dev, "%s:queue_work fail!\n", __func__);
-		mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+		idx = mdp_get_pipe_idx(mdp->mdp_data, MDP_PIPE_RDMA0);
+		mtk_mutex_unprepare(mdp->mdp_mutex[mdp->mdp_data->pipe_info[idx].mutex_id]);
 		mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 				    cmd->num_comps);
 
@@ -387,7 +407,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_free_comps;
 	}
 
-	ret = mtk_mutex_prepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+	i = mdp_get_pipe_idx(mdp->mdp_data, MDP_PIPE_RDMA0);
+	ret = mtk_mutex_prepare(mdp->mdp_mutex[mdp->mdp_data->pipe_info[i].mutex_id]);
 	if (ret) {
 		dev_err(dev, "Fail to enable mutex clk\n");
 		goto err_free_path;
@@ -453,7 +474,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 err_free_path:
-	mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+	i = mdp_get_pipe_idx(mdp->mdp_data, MDP_PIPE_RDMA0);
+	mtk_mutex_unprepare(mdp->mdp_mutex[mdp->mdp_data->pipe_info[i].mutex_id]);
 	kfree(path);
 err_free_comps:
 	kfree(comps);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 4b02c135b631..79acdccd0b60 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -24,6 +24,8 @@ static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_mutex_table_idx = mt8183_mutex_idx,
 	.comp_data = mt8183_mdp_comp_data,
 	.comp_data_len = ARRAY_SIZE(mt8183_mdp_comp_data),
+	.pipe_info = mt8183_pipe_info,
+	.pipe_info_len = ARRAY_SIZE(mt8183_pipe_info),
 	.format = mt8183_formats,
 	.format_len = ARRAY_SIZE(mt8183_formats),
 	.def_limit = &mt8183_mdp_def_limit,
@@ -165,7 +167,7 @@ static int mdp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mdp_dev *mdp;
 	struct platform_device *mm_pdev;
-	int ret, i;
+	int ret, i, mutex_id;
 
 	mdp = kzalloc(sizeof(*mdp), GFP_KERNEL);
 	if (!mdp) {
@@ -188,9 +190,12 @@ static int mdp_probe(struct platform_device *pdev)
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
@@ -271,7 +276,7 @@ static int mdp_probe(struct platform_device *pdev)
 err_deinit_comp:
 	mdp_comp_destroy(mdp);
 err_free_mutex:
-	for (i = 0; i < MDP_PIPE_MAX; i++)
+	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++)
 		mtk_mutex_put(mdp->mdp_mutex[i]);
 err_destroy_device:
 	kfree(mdp);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 52f87e59ba9e..30f22bee89e6 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -57,6 +57,8 @@ struct mtk_mdp_driver_data {
 	const u32 *mdp_mutex_table_idx;
 	const struct mdp_comp_data *comp_data;
 	unsigned int comp_data_len;
+	const struct mdp_pipe_info *pipe_info;
+	unsigned int pipe_info_len;
 	const struct mdp_format *format;
 	unsigned int format_len;
 	const struct mdp_limit *def_limit;
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

