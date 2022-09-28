Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E365EE105
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiI1P4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiI1P4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:56:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89041DE0C9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C68A1B82114
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCAAC433D6;
        Wed, 28 Sep 2022 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380545;
        bh=rTxVsRSoNtBqk4DuZJ+tmhjE78RLJzMfTSqldv1r6/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ox+7ChwI3mXjsFhmBD4fmyZMHwVY2fWySreTHkOuzsPQrdskuITrhR1xioh0qD7a2
         BpwKinWMeUQh2AoaNcRUySSMp2p3qUd6aigcV+ss6ECJ4k4iCGq3z0nkBnzV5B//KG
         6SU9d6SwxAuPo5bZDQFlvohqMCBL/qNDa4TMSGKUnwfnSInwdtOmhENDuBFqHqscIl
         QbeS6uLxFEIN9wVnBfr0CcP8RwzW56wB1+nY928+YImUYpGG8WouAtjyTErEdSgBTK
         VfRetoKpTP0RssLig6b2zuHTxbL180tHKJ9YgYj8cAcBl5uGhmJE7pqHxWIKD3K1K3
         Y6OQZTEYgog1w==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 7/8] soc: mtk-svs: mt8183: refactor o_slope calculation
Date:   Wed, 28 Sep 2022 17:55:18 +0200
Message-Id: <20220928155519.31977-8-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220928155519.31977-1-matthias.bgg@kernel.org>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The o_slope value is dependent of the o_slope_sign, refactor code to get
rid of unnecessary if constructs.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/soc/mediatek/mtk-svs-mt8183.c | 54 ++++++++++++---------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs-mt8183.c b/drivers/soc/mediatek/mtk-svs-mt8183.c
index 4b538cdefc86..7f7d5cd6be35 100644
--- a/drivers/soc/mediatek/mtk-svs-mt8183.c
+++ b/drivers/soc/mediatek/mtk-svs-mt8183.c
@@ -25,26 +25,28 @@ static int svs_mt8183_efuse_thermal_parsing(struct svs_platform *svsp)
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
-			return -1;
-		}
-	} else {
-		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
+
+	if (!ts_id)
+		o_slope = 1534;
+	else {
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
 		return -1;
 	}
 
@@ -63,11 +65,7 @@ static int svs_mt8183_efuse_thermal_parsing(struct svs_platform *svsp)
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
@@ -94,11 +92,7 @@ static int svs_mt8183_efuse_thermal_parsing(struct svs_platform *svsp)
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
2.37.3

