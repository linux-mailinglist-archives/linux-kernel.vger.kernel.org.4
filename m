Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD365BF11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbjACLbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbjACL3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:29:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC5FAF6;
        Tue,  3 Jan 2023 03:29:34 -0800 (PST)
X-UUID: 35f120e895814bea8a46946f006df901-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7RQEeKIIux1PCUXqzkDn4LBhrz6tKrtyzvHPPUbC6vE=;
        b=d1UgQWq4GLYOAEIDfi53xLwArwSRl7XZrJPp+NyYsgw/Jxflp1ikMhv1OjYcbCkR0BqB4tp/7zY5knMQdLix9/86n/WdA5ZGfewkN/nJs23s94GNYqEtnqicCz6DF5RTuFomcmyzHX05ppcRvBlVNx3NX/KOFDYNJA874a2kKu4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:8906b7f1-2be3-4f50-9bac-2bf33265a314,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:c064aaf4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 35f120e895814bea8a46946f006df901-20230103
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 411707678; Tue, 03 Jan 2023 19:29:28 +0800
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
Subject: [PATCH v3 07/14] soc: mtk-svs: mt8183: refactor o_slope calculation
Date:   Tue, 3 Jan 2023 19:29:18 +0800
Message-ID: <20230103112925.16554-8-roger.lu@mediatek.com>
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

