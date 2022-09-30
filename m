Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31195F095F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiI3Kzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiI3Kyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:54:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB615EE16;
        Fri, 30 Sep 2022 03:34:42 -0700 (PDT)
X-UUID: 3bba1492c8d249119da9aba2240de3fe-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5uwNZqnaq1ccbDTcWvY36ezPqqwuQtAzcWb1OYfNQLM=;
        b=P7az/Av8d0BbnRj5qJSFIf+6zmwLM8KbvC/bPlbvW3EYFU2Rsj8txQmAk7gsOgAp6V5IF1AhJ6J2URI5DKYNFLQ+46b9alifB+Ha9Afr9kZYl1/VD4Dy2AVA/u3q/8t/r8HtgQem92P9FEb7+Bi6DxWZ9Gkz3Ye+21LhQBKES5M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:9730b829-2025-4025-9b34-cb0bf7cc0c3e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.11,REQID:9730b829-2025-4025-9b34-cb0bf7cc0c3e,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:39a5ff1,CLOUDID:314dc8e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:2209301823119D9J86ZH,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3bba1492c8d249119da9aba2240de3fe-20220930
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 812717708; Fri, 30 Sep 2022 18:23:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 18:23:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Sep 2022 18:23:07 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v1 1/2] media: platform: mtk-mdp3: fix error handling in mdp_cmdq_send()
Date:   Fri, 30 Sep 2022 18:23:05 +0800
Message-ID: <20220930102306.13201-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220930102306.13201-1-moudy.ho@mediatek.com>
References: <20220930102306.13201-1-moudy.ho@mediatek.com>
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

Increase and refine the goto label in mdp_cmdq_send() to avoid
double free and facilitate traceability.
Also, remove redundant work queue event in blocking function
mdp_cmdq_send().

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
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

