Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E610365BF12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbjACLag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbjACL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:29:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258DA10042;
        Tue,  3 Jan 2023 03:29:38 -0800 (PST)
X-UUID: f69125d12c6d445197d68a33d7d36f85-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4gNcF7vsUH3TomKrULGmuoGv4uA8ZyTj2XFNqGbNkWo=;
        b=UCyBMSNLCktALEJjdn1Tg5zzc/hJxnJ1IcL+KpwjWAjSO3BQ5MjCfuc5RBqumGSMrOdqaqWRYZYboXrHC9HKBuSiLhEOiOuq3ZBHzXZ6ogAzeO0wnxIskaWvh0IW8FHR41WnKBj6zPLttWqErqNJRxlOnUF1B7DS7Bshw02nz3E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:711e4342-8c0e-47e4-9d64-71e63ffc8008,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.16,REQID:711e4342-8c0e-47e4-9d64-71e63ffc8008,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:09771b1,CLOUDID:719e1b8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230103192931P9V2WQ1E,BulkQuantity:1,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: f69125d12c6d445197d68a33d7d36f85-20230103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1460600979; Tue, 03 Jan 2023 19:29:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 Jan 2023 19:29:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 3 Jan 2023 19:29:27 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
CC:     Fan Chen <fan.chen@mediatek.com>, Roger Lu <roger.lu@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 05/14] soc: mediatek: mtk-svs: move svs_platform_probe into probe
Date:   Tue, 3 Jan 2023 19:29:16 +0800
Message-ID: <20230103112925.16554-6-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230103112925.16554-1-roger.lu@mediatek.com>
References: <20230103112925.16554-1-roger.lu@mediatek.com>
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

From: Matthias Brugger <matthias.bgg@gmail.com>

Moving svs_platform_probe into driver probe function will allow us to
reduce svs_platform members. This will be done in a follow-up patch.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 7fea1a5bb842..bbec96696c55 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2325,17 +2325,17 @@ static const struct of_device_id svs_of_match[] = {
 	},
 };
 
-static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
+static int svs_probe(struct platform_device *pdev)
 {
 	struct svs_platform *svsp;
 	const struct svs_platform_data *svsp_data;
-	int ret;
+	int ret, svsp_irq;
 
 	svsp_data = of_device_get_match_data(&pdev->dev);
 
 	svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
 	if (!svsp)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	svsp->dev = &pdev->dev;
 	svsp->name = svsp_data->name;
@@ -2346,19 +2346,7 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
 
 	ret = svsp_data->probe(svsp);
 	if (ret)
-		return ERR_PTR(ret);
-
-	return svsp;
-}
-
-static int svs_probe(struct platform_device *pdev)
-{
-	struct svs_platform *svsp;
-	int svsp_irq, ret;
-
-	svsp = svs_platform_probe(pdev);
-	if (IS_ERR(svsp))
-		return PTR_ERR(svsp);
+		return ret;
 
 	if (!svs_is_efuse_data_correct(svsp)) {
 		dev_notice(svsp->dev, "efuse data isn't correct\n");
-- 
2.18.0

