Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030A5F28FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 09:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJCHIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 03:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJCHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 03:08:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A48357C4;
        Mon,  3 Oct 2022 00:08:37 -0700 (PDT)
X-UUID: 7eb411ed16584bf38de737cba27ffe54-20221003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=09fqyA4k2RD8tjkCxo1wu/f6mjLilCjhB+OIWkZxcCk=;
        b=pdHklJ7e4BlpKTKYLgwRuKPwsHhN6F1lK0pS5BkMbIZ5k4FuzsKpJGa18DO5woK3MU0QifAZNgGp7/8Od6eof7rsugmWhTe5NOQueGkLdQPukvjZlGr8tYLg7fG7rBwh04+OuApv808Hqz3LnBYhIx3lfSNXvW5sV9sr1ttr8IU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:77a62928-1370-47bc-9f76-0c336526adb2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:816cd6a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7eb411ed16584bf38de737cba27ffe54-20221003
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 896215015; Mon, 03 Oct 2022 15:08:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 3 Oct 2022 15:08:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 3 Oct 2022 15:08:31 +0800
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
Subject: [PATCH v2 1/2] media: platform: mtk-mdp3: fix error handling in mdp_cmdq_send()
Date:   Mon, 3 Oct 2022 15:08:29 +0800
Message-ID: <20221003070830.23697-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221003070830.23697-1-moudy.ho@mediatek.com>
References: <20221003070830.23697-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase and refine the goto label in mdp_cmdq_send() to avoid
double free and facilitate traceability.
Also, remove redundant work queue event in blocking function
mdp_cmdq_send().

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 47 ++++++++++---------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 86c054600a08..e194dec8050a 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -252,10 +252,9 @@ static int mdp_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt,
 	dma_addr_t dma_addr;
 
 	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base) {
-		kfree(pkt);
+	if (!pkt->va_base)
 		return -ENOMEM;
-	}
+
 	pkt->buf_size = size;
 	pkt->cl = (void *)client;
 
@@ -368,25 +367,30 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd) {
 		ret = -ENOMEM;
-		goto err_cmdq_data;
+		goto err_cancel_job;
 	}
 
-	if (mdp_cmdq_pkt_create(mdp->cmdq_clt, &cmd->pkt, SZ_16K)) {
-		ret = -ENOMEM;
-		goto err_cmdq_data;
-	}
+	ret = mdp_cmdq_pkt_create(mdp->cmdq_clt, &cmd->pkt, SZ_16K);
+	if (ret)
+		goto err_free_cmd;
 
 	comps = kcalloc(param->config->num_components, sizeof(*comps),
 			GFP_KERNEL);
 	if (!comps) {
 		ret = -ENOMEM;
-		goto err_cmdq_data;
+		goto err_destroy_pkt;
 	}
 
 	path = kzalloc(sizeof(*path), GFP_KERNEL);
 	if (!path) {
 		ret = -ENOMEM;
-		goto err_cmdq_data;
+		goto err_free_comps;
+	}
+
+	ret = mtk_mutex_prepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
+	if (ret) {
+		dev_err(dev, "Fail to enable mutex clk\n");
+		goto err_free_path;
 	}
 
 	path->mdp_dev = mdp;
@@ -406,15 +410,13 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	ret = mdp_path_ctx_init(mdp, path);
 	if (ret) {
 		dev_err(dev, "mdp_path_ctx_init error\n");
-		goto err_cmdq_data;
+		goto err_free_path;
 	}
 
-	mtk_mutex_prepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
-
 	ret = mdp_path_config(mdp, cmd, path);
 	if (ret) {
 		dev_err(dev, "mdp_path_config error\n");
-		goto err_cmdq_data;
+		goto err_free_path;
 	}
 	cmdq_pkt_finalize(&cmd->pkt);
 
@@ -433,7 +435,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd->comps, cmd->num_comps);
 	if (ret) {
 		dev_err(dev, "comp %d failed to enable clock!\n", ret);
-		goto err_clock_off;
+		goto err_free_path;
 	}
 
 	dma_sync_single_for_device(mdp->cmdq_clt->chan->mbox->dev,
@@ -450,17 +452,20 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	return 0;
 
 err_clock_off:
-	mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
-err_cmdq_data:
+err_free_path:
+	mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
 	kfree(path);
-	atomic_dec(&mdp->job_count);
-	wake_up(&mdp->callback_wq);
-	if (cmd && cmd->pkt.buf_size > 0)
-		mdp_cmdq_pkt_destroy(&cmd->pkt);
+err_free_comps:
 	kfree(comps);
+err_destroy_pkt:
+	mdp_cmdq_pkt_destroy(&cmd->pkt);
+err_free_cmd:
 	kfree(cmd);
+err_cancel_job:
+	atomic_dec(&mdp->job_count);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mdp_cmdq_send);
-- 
2.18.0

