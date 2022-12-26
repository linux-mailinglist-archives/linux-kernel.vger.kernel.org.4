Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1E65619C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiLZJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLZJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:43:02 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E12AF9;
        Mon, 26 Dec 2022 01:42:58 -0800 (PST)
X-UUID: 6cc92d9aafb14f38aeebc36d9b14a1ad-20221226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XbLSD0m8UcVGxdlXuSCfKFo4OXf234fq1MYeOoIQl8Q=;
        b=S0v03NkumULDXKwEq1ndz2ycvorW5SdRqAAsWHMTMzKMEVI76VXhojk+77jR0RfvXyS4NdvM/rxPsxixmnzxW9VtoTBjRgB8RBJ8W2z7Rl0zj/W4mpVenpvr8uLt/TutYIhVG+um+RRxyhG6TDE9CzBC3KbUYoVb/oYapGjQt9s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:76e6faff-8892-499e-8b64-7cc3975b4a7b,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:f9166a8a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6cc92d9aafb14f38aeebc36d9b14a1ad-20221226
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1200770205; Mon, 26 Dec 2022 17:42:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Dec 2022 17:42:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 26 Dec 2022 17:42:49 +0800
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
Subject: [PATCH v1 03/13] soc: mediatek: mtk-svs: improve readability of platform_probe
Date:   Mon, 26 Dec 2022 17:42:38 +0800
Message-ID: <20221226094248.4506-4-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221226094248.4506-1-roger.lu@mediatek.com>
References: <20221226094248.4506-1-roger.lu@mediatek.com>
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

If a compatible misses a match data entry, then something is wrong in
the development phase, we don't need to check for that at runtime.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 38dcee9c9c04..63ad9160a305 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2332,10 +2332,6 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
 	int ret;
 
 	svsp_data = of_device_get_match_data(&pdev->dev);
-	if (!svsp_data) {
-		dev_err(&pdev->dev, "no svs platform data?\n");
-		return ERR_PTR(-EPERM);
-	}
 
 	svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
 	if (!svsp)
-- 
2.18.0

