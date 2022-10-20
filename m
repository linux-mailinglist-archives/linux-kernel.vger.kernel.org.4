Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C99605840
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJTHSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJTHSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:18:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD216E2A0;
        Thu, 20 Oct 2022 00:18:16 -0700 (PDT)
X-UUID: 30801a809907421980614ac785b065f5-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oyQcrxZYCAvggulovd4FRHdXOU2WjZQVKRd7NG1+zj8=;
        b=ByhDzTpYCFzjWm1qSQJjbRkLtm2f8JTZfj4d6d1o8DPc4UaTRpqRfpVDCYZYSgHyLbkMLSRX9uxPcGd70Q0iTA8nkVUlTF37BsC2cjuy4IUXTxDNdPZGyE9Ap9RF7J4/KY1qrg5Oh1W7Y5qoHnfVWWeL/u6hxwq0q0IYwxn3Fyc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:e6256586-8665-42f6-9e5d-9e85b35cc3bd,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:62cd327,CLOUDID:3a4fe0ee-314c-4293-acb8-ca4299dd021f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 30801a809907421980614ac785b065f5-20221020
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1287693578; Thu, 20 Oct 2022 15:18:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 20 Oct 2022 15:18:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 20 Oct 2022 15:18:02 +0800
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
Subject: [PATCH v3 3/3] media: platform: mtk-mdp3: fix error handling in mdp_probe()
Date:   Thu, 20 Oct 2022 15:18:00 +0800
Message-ID: <20221020071800.20487-4-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221020071800.20487-1-moudy.ho@mediatek.com>
References: <20221020071800.20487-1-moudy.ho@mediatek.com>
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

Adjust label "err_return" order to avoid double freeing, and
add two labels for easy traceability.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c  | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index c413e59d4286..2d1f6ae9f080 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -196,27 +196,27 @@ static int mdp_probe(struct platform_device *pdev)
 	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_MMSYS);
 	if (!mm_pdev) {
 		ret = -ENODEV;
-		goto err_return;
+		goto err_destroy_device;
 	}
 	mdp->mdp_mmsys = &mm_pdev->dev;
 
 	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_MUTEX);
 	if (WARN_ON(!mm_pdev)) {
 		ret = -ENODEV;
-		goto err_return;
+		goto err_destroy_device;
 	}
 	for (i = 0; i < MDP_PIPE_MAX; i++) {
 		mdp->mdp_mutex[i] = mtk_mutex_get(&mm_pdev->dev);
 		if (!mdp->mdp_mutex[i]) {
 			ret = -ENODEV;
-			goto err_return;
+			goto err_free_mutex;
 		}
 	}
 
 	ret = mdp_comp_config(mdp);
 	if (ret) {
 		dev_err(dev, "Failed to config mdp components\n");
-		goto err_return;
+		goto err_free_mutex;
 	}
 
 	mdp->job_wq = alloc_workqueue(MDP_MODULE_NAME, WQ_FREEZABLE, 0);
@@ -287,11 +287,12 @@ static int mdp_probe(struct platform_device *pdev)
 	destroy_workqueue(mdp->job_wq);
 err_deinit_comp:
 	mdp_comp_destroy(mdp);
-err_return:
+err_free_mutex:
 	for (i = 0; i < MDP_PIPE_MAX; i++)
-		if (mdp)
-			mtk_mutex_put(mdp->mdp_mutex[i]);
+		mtk_mutex_put(mdp->mdp_mutex[i]);
+err_destroy_device:
 	kfree(mdp);
+err_return:
 	dev_dbg(dev, "Errno %d\n", ret);
 	return ret;
 }
-- 
2.18.0

