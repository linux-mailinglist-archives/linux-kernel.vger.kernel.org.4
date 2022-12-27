Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A28656A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiL0MK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiL0MJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:09:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290FFB21;
        Tue, 27 Dec 2022 04:09:26 -0800 (PST)
X-UUID: 8ab763d5cf6c4e0ab4a8b3ade7ad0898-20221227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7RQEeKIIux1PCUXqzkDn4LBhrz6tKrtyzvHPPUbC6vE=;
        b=hJM6U/N8DLquBh44OLPFFCMebmpkmKSGCZmO84n0P2n7jnugOYHCMDvSLwSjcok77+qHNBG3kmMDIhxa5MPn3f94lgqs9SrNGQal9vZQ7XGTZn0aMWnikpLcA4y7dm3PgVa2/+dWlviedNrGclgYdfzBJsQO3Drtt16DjJBh5lw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:49954a1c-363a-490a-9c03-48219d5bfe04,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:49954a1c-363a-490a-9c03-48219d5bfe04,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:e69bee52-dd49-462e-a4be-2143a3ddc739,B
        ulkID:221227200919IX8Q1CLJ,BulkQuantity:1,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 8ab763d5cf6c4e0ab4a8b3ade7ad0898-20221227
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 857690495; Tue, 27 Dec 2022 20:09:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Dec 2022 20:09:18 +0800
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
Subject: [PATCH v2 07/13] soc: mtk-svs: mt8183: refactor o_slope calculation
Date:   Tue, 27 Dec 2022 20:09:08 +0800
Message-ID: <20221227120914.11346-8-roger.lu@mediatek.com>
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

The o_slope value is dependent of the o_slope_sign, refactor code to get
rid of unnecessary if constructs.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 51 +++++++++++++++-------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 308cd36a23fc..9578baf3d9a7 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1893,26 +1893,27 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 	o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
 
 	ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
-	o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
-
-	if (adc_cali_en_t == 1) {
-		if (!ts_id)
-			o_slope = 0;
-
-		if (adc_ge_t < 265 || adc_ge_t > 758 ||
-		    adc_oe_t < 265 || adc_oe_t > 758 ||
-		    o_vtsmcu[0] < -8 || o_vtsmcu[0] > 484 ||
-		    o_vtsmcu[1] < -8 || o_vtsmcu[1] > 484 ||
-		    o_vtsmcu[2] < -8 || o_vtsmcu[2] > 484 ||
-		    o_vtsmcu[3] < -8 || o_vtsmcu[3] > 484 ||
-		    o_vtsmcu[4] < -8 || o_vtsmcu[4] > 484 ||
-		    o_vtsabb < -8 || o_vtsabb > 484 ||
-		    degc_cali < 1 || degc_cali > 63) {
-			dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
-			goto remove_mt8183_svsb_mon_mode;
-		}
+	if (!ts_id) {
+		o_slope = 1534;
 	} else {
-		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
+		o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
+		if (!o_slope_sign)
+			o_slope = 1534 + o_slope * 10;
+		else
+			o_slope = 1534 - o_slope * 10;
+	}
+
+	if (adc_cali_en_t == 0 ||
+	    adc_ge_t < 265 || adc_ge_t > 758 ||
+	    adc_oe_t < 265 || adc_oe_t > 758 ||
+	    o_vtsmcu[0] < -8 || o_vtsmcu[0] > 484 ||
+	    o_vtsmcu[1] < -8 || o_vtsmcu[1] > 484 ||
+	    o_vtsmcu[2] < -8 || o_vtsmcu[2] > 484 ||
+	    o_vtsmcu[3] < -8 || o_vtsmcu[3] > 484 ||
+	    o_vtsmcu[4] < -8 || o_vtsmcu[4] > 484 ||
+	    o_vtsabb < -8 || o_vtsabb > 484 ||
+	    degc_cali < 1 || degc_cali > 63) {
+		dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
 		goto remove_mt8183_svsb_mon_mode;
 	}
 
@@ -1931,11 +1932,7 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / gain;
 
 	temp0 = (10000 * 100000 / gain) * 15 / 18;
-
-	if (!o_slope_sign)
-		mts = (temp0 * 10) / (1534 + o_slope * 10);
-	else
-		mts = (temp0 * 10) / (1534 - o_slope * 10);
+	mts = (temp0 * 10) / o_slope;
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
@@ -1962,11 +1959,7 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		temp0 = (degc_cali * 10 / 2);
 		temp1 = ((10000 * 100000 / 4096 / gain) *
 			 oe + tb_roomt * 10) * 15 / 18;
-
-		if (!o_slope_sign)
-			temp2 = temp1 * 100 / (1534 + o_slope * 10);
-		else
-			temp2 = temp1 * 100 / (1534 - o_slope * 10);
+		temp2 = temp1 * 100 / o_slope;
 
 		svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
 	}
-- 
2.18.0

