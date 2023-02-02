Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639C687E07
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBBM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBBM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:56:33 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F7C457ED;
        Thu,  2 Feb 2023 04:56:26 -0800 (PST)
X-UUID: dd01f6cea2f611ed945fc101203acc17-20230202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=f+xt4bcbFiz4Lh0mpdZVAB1dKu8+XdSuSho8xqSktpI=;
        b=hddLKCzykIibfzu6QJ0HjLH+JHZbVDAqrbVzxaNfv6gD375T9ccub0QanqinD9tTv/O3zmOD2kAJOZZOojLfPpt2QMN1cw/c/olY5ZYcrix5McmRK66gv2PVGapMBDx3FMpNgJ9WU09gzz274FqEGEMSNvohZWz19DtjcaJzOgo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:a50ac5e0-698f-4714-bcfb-41da3adb4993,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:a50ac5e0-698f-4714-bcfb-41da3adb4993,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:b0f71b56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230202204108QDICUXC0,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: dd01f6cea2f611ed945fc101203acc17-20230202
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 451315629; Thu, 02 Feb 2023 20:41:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 2 Feb 2023 20:41:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 2 Feb 2023 20:41:06 +0800
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
Subject: [PATCH v5 3/3] soc: mediatek: mtk-svs: add thermal voltage compensation if needed
Date:   Thu, 2 Feb 2023 20:41:04 +0800
Message-ID: <20230202124104.16504-4-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230202124104.16504-1-roger.lu@mediatek.com>
References: <20230202124104.16504-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some extreme test environment may keep IC temperature very low or very high
during system boot stage. For stability concern, we add thermal voltage
compenstation if needed no matter svs bank phase is in init02 or mon mode.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 299f580847bd..e104866d1ab5 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -558,7 +558,7 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 	}
 
 	/* Get thermal effect */
-	if (svsb->phase == SVSB_PHASE_MON) {
+	if (!IS_ERR_OR_NULL(svsb->tzd)) {
 		ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
 		if (ret || (svsb->temp > SVSB_TEMP_UPPER_BOUND &&
 			    svsb->temp < SVSB_TEMP_LOWER_BOUND)) {
@@ -573,7 +573,8 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 			temp_voffset += svsb->tzone_ltemp_voffset;
 
 		/* 2-line bank update all opp volts when running mon mode */
-		if (svsb->type == SVSB_HIGH || svsb->type == SVSB_LOW) {
+		if (svsb->phase == SVSB_PHASE_MON && (svsb->type == SVSB_HIGH ||
+						      svsb->type == SVSB_LOW)) {
 			opp_start = 0;
 			opp_stop = svsb->opp_count;
 		}
@@ -589,11 +590,6 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 			/* do nothing */
 			goto unlock_mutex;
 		case SVSB_PHASE_INIT02:
-			svsb_volt = max(svsb->volt[i], svsb->vmin);
-			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
-							     svsb->volt_step,
-							     svsb->volt_base);
-			break;
 		case SVSB_PHASE_MON:
 			svsb_volt = max(svsb->volt[i] + temp_voffset, svsb->vmin);
 			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
@@ -1683,7 +1679,7 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 			}
 		}
 
-		if (svsb->mode_support & SVSB_MODE_MON) {
+		if (!IS_ERR_OR_NULL(svsb->tzone_name)) {
 			svsb->tzd = thermal_zone_get_zone_by_name(svsb->tzone_name);
 			if (IS_ERR(svsb->tzd)) {
 				dev_err(svsb->dev, "cannot get \"%s\" thermal zone\n",
@@ -2127,6 +2123,7 @@ static struct svs_bank svs_mt8192_banks[] = {
 		.type			= SVSB_LOW,
 		.set_freq_pct		= svs_set_bank_freq_pct_v3,
 		.get_volts		= svs_get_bank_volts_v3,
+		.tzone_name		= "gpu1",
 		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
 		.mode_support		= SVSB_MODE_INIT02,
 		.opp_count		= MAX_OPP_ENTRIES,
@@ -2144,6 +2141,10 @@ static struct svs_bank svs_mt8192_banks[] = {
 		.core_sel		= 0x0fff0100,
 		.int_st			= BIT(0),
 		.ctl0			= 0x00540003,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 0,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 7,
 	},
 	{
 		.sw_id			= SVSB_GPU,
-- 
2.18.0

