Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71A5EE104
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiI1P4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiI1Pzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC6C8E982
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DDAF61F0D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D925FC43140;
        Wed, 28 Sep 2022 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380542;
        bh=jBV3cFo8/FqKuJAoNK5rBtzqmrn/4Re6jDWfLVj3+OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEawa4AQdnoU3BNbSaCGJn37XgKksYRDbvOwRr22KLso/LgyBCsWiYjYsuW/C+0j+
         XY9zxznPrZr8l38+KUEPsj0bN2biVPvrDu91/5mDIEO2XNNKlCSoP3bSW9MJj1wjVb
         btUeq7pIDW7L2Asm0lDaa+ri5xep9cwueqb9AVk+Sxilt48XzmDbmN5aQBHCeRNKiC
         G+3KPjA+8H3Y8OUx+lKKEqPSgwJc+vBo5Ft/t7Ngh21nJG/oMxtdl5ktxi3Vib7A1N
         HFMyrjez+XDLKJGEHnRrdd/rxpJtKf1cbTt0BEFjIclhEdb8DFb5o/QKGJ1aSoDr7l
         wRhd4+xh54gMw==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 6/8] soc: mtk-svs: mt8183: Move thermal parsing in new function
Date:   Wed, 28 Sep 2022 17:55:17 +0200
Message-Id: <20220928155519.31977-7-matthias.bgg@kernel.org>
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

We jumpt to lable remove_mt8183_svsb_mon_mode from different error path
in the code. Move the thermal parsing in a new function will allow us to
refactor the code in a subsequent patch. No behavioural changes from
this commit.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/soc/mediatek/mtk-svs-mt8183.c | 183 +++++++++++++-------------
 1 file changed, 95 insertions(+), 88 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs-mt8183.c b/drivers/soc/mediatek/mtk-svs-mt8183.c
index a97fcae59dd7..4b538cdefc86 100644
--- a/drivers/soc/mediatek/mtk-svs-mt8183.c
+++ b/drivers/soc/mediatek/mtk-svs-mt8183.c
@@ -2,94 +2,14 @@
 
 #include "mtk-svs.h"
 
-bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
+static int svs_mt8183_efuse_thermal_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
 	int format[6], x_roomt[6], o_vtsmcu[5], o_vtsabb, tb_roomt = 0;
 	int adc_ge_t, adc_oe_t, ge, oe, gain, degc_cali, adc_cali_en_t;
 	int o_slope, o_slope_sign, ts_id;
-	u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
-	int ret;
-
-	for (i = 0; i < svsp->efuse_max; i++)
-		if (svsp->efuse[i])
-			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
-				 i, svsp->efuse[i]);
-
-	if (!svsp->efuse[2]) {
-		dev_notice(svsp->dev, "svs_efuse[2] = 0x0?\n");
-		return false;
-	}
-
-	/* Svs efuse parsing */
-	ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		if (ft_pgm <= 1)
-			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
+	u32 idx, i, mts, temp0, temp1, temp2;
 
-		switch (svsb->sw_id) {
-		case SVSB_CPU_LITTLE:
-			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
-
-			if (ft_pgm <= 3)
-				svsb->volt_od += 10;
-			else
-				svsb->volt_od += 2;
-			break;
-		case SVSB_CPU_BIG:
-			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
-
-			if (ft_pgm <= 3)
-				svsb->volt_od += 15;
-			else
-				svsb->volt_od += 12;
-			break;
-		case SVSB_CCI:
-			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
-
-			if (ft_pgm <= 3)
-				svsb->volt_od += 10;
-			else
-				svsb->volt_od += 2;
-			break;
-		case SVSB_GPU:
-			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
-
-			if (ft_pgm >= 2) {
-				svsb->freq_base = 800000000; /* 800MHz */
-				svsb->dvt_fixed = 2;
-			}
-			break;
-		default:
-			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
-			return false;
-		}
-	}
-
-	ret = svs_thermal_efuse_get_data(svsp);
-	if (ret)
-		return false;
-
-	/* Thermal efuse parsing */
 	adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
 	adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
 
@@ -121,11 +41,11 @@ bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		    o_vtsabb < -8 || o_vtsabb > 484 ||
 		    degc_cali < 1 || degc_cali > 63) {
 			dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
-			goto remove_mt8183_svsb_mon_mode;
+			return -1;
 		}
 	} else {
 		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
-		goto remove_mt8183_svsb_mon_mode;
+		return -1;
 	}
 
 	ge = ((adc_ge_t - 512) * 10000) / 4096;
@@ -168,7 +88,7 @@ bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 			break;
 		default:
 			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
-			goto remove_mt8183_svsb_mon_mode;
+			return -1;
 		}
 
 		temp0 = (degc_cali * 10 / 2);
@@ -183,12 +103,99 @@ bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
 	}
 
-	return true;
+	return 0;
+}
+
+bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	u32 idx, i, ft_pgm;
+	int ret;
+
+	for (i = 0; i < svsp->efuse_max; i++)
+		if (svsp->efuse[i])
+			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
+				 i, svsp->efuse[i]);
+
+	if (!svsp->efuse[2]) {
+		dev_notice(svsp->dev, "svs_efuse[2] = 0x0?\n");
+		return false;
+	}
+
+	/* Svs efuse parsing */
+	ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
 
-remove_mt8183_svsb_mon_mode:
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
-		svsb->mode_support &= ~SVSB_MODE_MON;
+
+		if (ft_pgm <= 1)
+			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
+
+		switch (svsb->sw_id) {
+		case SVSB_CPU_LITTLE:
+			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
+			svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
+
+			if (ft_pgm <= 3)
+				svsb->volt_od += 10;
+			else
+				svsb->volt_od += 2;
+			break;
+		case SVSB_CPU_BIG:
+			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
+			svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
+
+			if (ft_pgm <= 3)
+				svsb->volt_od += 15;
+			else
+				svsb->volt_od += 12;
+			break;
+		case SVSB_CCI:
+			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
+			svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
+
+			if (ft_pgm <= 3)
+				svsb->volt_od += 10;
+			else
+				svsb->volt_od += 2;
+			break;
+		case SVSB_GPU:
+			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
+			svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
+
+			if (ft_pgm >= 2) {
+				svsb->freq_base = 800000000; /* 800MHz */
+				svsb->dvt_fixed = 2;
+			}
+			break;
+		default:
+			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
+			return false;
+		}
+	}
+
+	ret = svs_thermal_efuse_get_data(svsp);
+	if (ret)
+		return false;
+
+	ret = svs_mt8183_efuse_thermal_parsing(svsp);
+	if (ret) {
+		for (idx = 0; idx < svsp->bank_max; idx++) {
+			svsb = &svsp->banks[idx];
+			svsb->mode_support &= ~SVSB_MODE_MON;
+		}
 	}
 
 	return true;
-- 
2.37.3

