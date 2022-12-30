Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5F656AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiL0MKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiL0MJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:09:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F72C74;
        Tue, 27 Dec 2022 04:09:29 -0800 (PST)
X-UUID: b35a70be08d4479691b14978edd7a41f-20221227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=egOl5iq5coPFCtNJCs9nRdOS8+zQru1z7+L5Cup8Vb0=;
        b=FkDQKcBOAY6BZ8lO5wWELl+Nly7XOR7thNOIHN+xrxOVoEGTmG9tQULqwPxVPE7KI4adGD0TTO8tp7+G46vzBMKET2DhOYnNIOpr1cSQXFDptKRTrO52wlMS038mFD2TngYUsriUrGQEWz29CNyyD7OF+vdEalM/OUhQMudNIyU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:e6935c66-e605-469d-a4f6-154dc40939a0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:059cee52-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b35a70be08d4479691b14978edd7a41f-20221227
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1677478592; Tue, 27 Dec 2022 20:09:20 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Dec 2022 20:09:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Dec 2022 20:09:18 +0800
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
Subject: [PATCH v2 13/13] soc: mediatek: mtk-svs: keep svs alive even though debug cmd create fail
Date:   Tue, 27 Dec 2022 20:09:14 +0800
Message-ID: <20221227120914.11346-14-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221227120914.11346-1-roger.lu@mediatek.com>
References: <20221227120914.11346-1-roger.lu@mediatek.com>
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

Some projects might not support DEBUG_FS but still needs svs to be
supported. Therefore, keep svs alive even though debug cmd create fail.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 8ef330175d39..89579276c09c 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -806,7 +806,7 @@ static int svs_status_debug_show(struct seq_file *m, void *v)
 
 debug_fops_ro(status);
 
-static int svs_create_debug_cmds(struct svs_platform *svsp)
+static void svs_create_debug_cmds(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
 	struct dentry *svs_dir, *svsb_dir, *file_entry;
@@ -831,7 +831,7 @@ static int svs_create_debug_cmds(struct svs_platform *svsp)
 	if (IS_ERR(svs_dir)) {
 		dev_err(svsp->dev, "cannot create %s: %ld\n",
 			d, PTR_ERR(svs_dir));
-		return PTR_ERR(svs_dir);
+		return;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(svs_entries); i++) {
@@ -841,7 +841,7 @@ static int svs_create_debug_cmds(struct svs_platform *svsp)
 		if (IS_ERR(file_entry)) {
 			dev_err(svsp->dev, "cannot create %s/%s: %ld\n",
 				d, svs_entries[i].name, PTR_ERR(file_entry));
-			return PTR_ERR(file_entry);
+			return;
 		}
 	}
 
@@ -855,7 +855,7 @@ static int svs_create_debug_cmds(struct svs_platform *svsp)
 		if (IS_ERR(svsb_dir)) {
 			dev_err(svsp->dev, "cannot create %s/%s: %ld\n",
 				d, svsb->name, PTR_ERR(svsb_dir));
-			return PTR_ERR(svsb_dir);
+			return;
 		}
 
 		for (i = 0; i < ARRAY_SIZE(svsb_entries); i++) {
@@ -866,12 +866,10 @@ static int svs_create_debug_cmds(struct svs_platform *svsp)
 				dev_err(svsp->dev, "no %s/%s/%s?: %ld\n",
 					d, svsb->name, svsb_entries[i].name,
 					PTR_ERR(file_entry));
-				return PTR_ERR(file_entry);
+				return;
 			}
 		}
 	}
-
-	return 0;
 }
 
 static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
@@ -2417,11 +2415,7 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_iounmap;
 	}
 
-	ret = svs_create_debug_cmds(svsp);
-	if (ret) {
-		dev_err(svsp->dev, "svs create debug cmds fail: %d\n", ret);
-		goto svs_probe_iounmap;
-	}
+	svs_create_debug_cmds(svsp);
 
 	return 0;
 
-- 
2.18.0

