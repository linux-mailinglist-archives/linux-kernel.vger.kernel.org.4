Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44475F0974
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiI3LFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiI3LFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:05:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC81A9A78;
        Fri, 30 Sep 2022 03:42:21 -0700 (PDT)
X-UUID: 55ed115861054af7a5d0543c0e88b55e-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VCeIfBYJvbHF9N/yTcdYAzolGLjNoSJfm/NyFwIg6fg=;
        b=lpojIz3Du4WTNvq97yMniY4UnZ8wf+AExImO969wL6oPz/dNWrrw3ywTjjmgAOVGMziuezAA0xxjudgsDjIySXsQgNvLyu1jarpVUaFuvDatRMbwUBoErn+k4/kAbA+i5OY5q+9I+IspaEcus+D4ADuJDPLyVwPmJAKMJ3nZkQA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:57402be2-8e77-43c6-a3fd-1ec0d5790f8d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:57402be2-8e77-43c6-a3fd-1ec0d5790f8d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:2f4dc8e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:2209301823115VTNFMG1,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 55ed115861054af7a5d0543c0e88b55e-20220930
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1753874022; Fri, 30 Sep 2022 18:23:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 30 Sep 2022 18:23:08 +0800
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
Subject: [PATCH v1 2/2] media: platform: mtk-mdp3: fix error handling about components clock_on
Date:   Fri, 30 Sep 2022 18:23:06 +0800
Message-ID: <20220930102306.13201-3-moudy.ho@mediatek.com>
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

Add goto statement in mdp_comp_clock_on() to avoid error code not being
propagated or returning positive values.
This change also performs a well-timed clock_off when an error occurs, and
reduces unnecessary error logging in mdp_cmdq_send().

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |  4 +---
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 24 ++++++++++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index e194dec8050a..124c1b96e96b 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -433,10 +433,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	cmd->mdp_ctx = param->mdp_ctx;
 
 	ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd->comps, cmd->num_comps);
-	if (ret) {
-		dev_err(dev, "comp %d failed to enable clock!\n", ret);
+	if (ret)
 		goto err_free_path;
-	}
 
 	dma_sync_single_for_device(mdp->cmdq_clt->chan->mbox->dev,
 				   cmd->pkt.pa_base, cmd->pkt.cmd_buf_size,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index d3eaf8884412..fe6a39315e88 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -699,12 +699,22 @@ int mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp)
 			dev_err(dev,
 				"Failed to enable clk %d. type:%d id:%d\n",
 				i, comp->type, comp->id);
-			pm_runtime_put(comp->comp_dev);
-			return ret;
+			goto err_unwind;
 		}
 	}
 
 	return 0;
+
+err_unwind:
+	while (--i >= 0) {
+		if (IS_ERR_OR_NULL(comp->clks[i]))
+			continue;
+		clk_disable_unprepare(comp->clks[i]);
+	}
+	if (comp->comp_dev)
+		pm_runtime_put_sync(comp->comp_dev);
+
+	return ret;
 }
 
 void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp)
@@ -723,11 +733,13 @@ void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp)
 
 int mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int num)
 {
-	int i;
+	int i, ret;
 
-	for (i = 0; i < num; i++)
-		if (mdp_comp_clock_on(dev, &comps[i]) != 0)
-			return ++i;
+	for (i = 0; i < num; i++) {
+		ret = mdp_comp_clock_on(dev, &comps[i]);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.18.0

