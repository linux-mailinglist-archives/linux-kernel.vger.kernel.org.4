Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4551B7498F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGFKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGFKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:04:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC61DDD;
        Thu,  6 Jul 2023 03:04:43 -0700 (PDT)
X-UUID: 844ca40e1be411ee9cb5633481061a41-20230706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TS+0nfycyMyZboLtN8mtKKdv0Ar+eMXmyw7XCZMA2LM=;
        b=fJiHurZXnnY+Lx6TfYtKU5N9yAVtg4kPU60MYMbHE+FqvFav2JzXuC7wRap1ytOAmVhpZigstnjRiFDC3Cer7+mgJ559SiDzZ0nVlIrMax4is+kLdeUeW2zgmjBxVRHIQM/mGQOTUeyGIAcD+XbpzQARdMJ44N1/w67IVy8cVJ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:dc2f369f-25e0-4dda-b1cc-f807240d32cb,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.27,REQID:dc2f369f-25e0-4dda-b1cc-f807240d32cb,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:01c9525,CLOUDID:4396ee0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230706180438HVKI64YI,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: 844ca40e1be411ee9cb5633481061a41-20230706
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 986363233; Thu, 06 Jul 2023 18:04:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jul 2023 18:04:36 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jul 2023 18:04:36 +0800
From:   Shuijing Li <shuijing.li@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Shuijing Li <shuijing.li@mediatek.com>
Subject: [PATCH] pwm: mtk_disp: fix disp_pwm coverity issue
Date:   Thu, 6 Jul 2023 18:04:54 +0800
Message-ID: <20230706100454.28998-1-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a coverity issue in the original mtk_disp_pwm_get_state()
function. In function call DIV64_U64_ROUND_UP, division by expression
Which may be zero has undefined behavior.
Fix this accordingly.

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
---
 drivers/pwm/pwm-mtk-disp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 79e321e96f56..ca00058a6ef4 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -196,6 +196,14 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 		return err;
 	}
 
+	rate = clk_get_rate(mdp->clk_main);
+	if (rate <= 0) {
+		dev_err(chip->dev, "Can't get rate: %pe\n", ERR_PTR(rate));
+		clk_disable_unprepare(mdp->clk_mm);
+		clk_disable_unprepare(mdp->clk_main);
+		return err;
+	}
+
 	/*
 	 * Apply DISP_PWM_DEBUG settings to choose whether to enable or disable
 	 * registers double buffer and manual commit to working register before
@@ -206,7 +214,6 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 					 mdp->data->bls_debug_mask,
 					 mdp->data->bls_debug_mask);
 
-	rate = clk_get_rate(mdp->clk_main);
 	con0 = readl(mdp->base + mdp->data->con0);
 	con1 = readl(mdp->base + mdp->data->con1);
 	pwm_en = readl(mdp->base + DISP_PWM_EN);
-- 
2.40.1

