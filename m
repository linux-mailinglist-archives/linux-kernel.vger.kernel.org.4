Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7718865BF04
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbjACLaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbjACL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:29:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A334FCFC;
        Tue,  3 Jan 2023 03:29:35 -0800 (PST)
X-UUID: e186cd90ce6b4bbd87325d0a4340e1c7-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QANQRcbabz/e5AjGyrQQSnGD8OTyugIT5m3Sn9VmQA0=;
        b=jm3Af5jRZXxLBJkPUb3avxeNITJekXai7qCZSdvvHdPAn4rLasVzeiyQhP0bh6KPdPSyHQLH7jMPjg1CHGo0un2icSjCbjZoKBMSNONvshkV9y8wzCSYNoN19xLaSCw4/boHYUJ4bt1GgtInD6QC7Zm2B7xv/OaNxXebgGLRBgM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:42b10e33-bc9f-49fd-895f-05cb432e4a44,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:bf64aaf4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: e186cd90ce6b4bbd87325d0a4340e1c7-20230103
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 73559374; Tue, 03 Jan 2023 19:29:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
Subject: [PATCH v3 10/14] soc: mediatek: mtk-svs: reset svs when svs_resume() fail
Date:   Tue, 3 Jan 2023 19:29:21 +0800
Message-ID: <20230103112925.16554-11-roger.lu@mediatek.com>
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

Reset svs when svs_resume() fail.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index d8b759897fec..567536e32a46 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1621,12 +1621,16 @@ static int svs_resume(struct device *dev)
 
 	ret = svs_init02(svsp);
 	if (ret)
-		goto svs_resume_clk_disable;
+		goto svs_resume_reset_assert;
 
 	svs_mon_mode(svsp);
 
 	return 0;
 
+svs_resume_reset_assert:
+	dev_info(svsp->dev, "assert reset %d\n",
+		 reset_control_assert(svsp->rst));
+
 svs_resume_clk_disable:
 	svs_clk_disable(svsp);
 
-- 
2.18.0

