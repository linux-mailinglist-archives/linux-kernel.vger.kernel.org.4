Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43F66BAF77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjCOLpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCOLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:45:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B0244AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:45:24 -0700 (PDT)
X-UUID: db3fda9ac32611edbd2e61cc88cc8f98-20230315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8pVoHzcnVsdUKSRmD7CFv1XjbBsBrHZrxHjiGf+h8UI=;
        b=nykKKgERG2vVHmJ7KtUybaAPcrwikTvsfWMgwFnsyvZHbFQbz4G49gSqMbiOAmkzpgm0xhReZhXzh5As8S6s8XoLHvTkQJwrTkf6LVxfE7lANIIjKoHW2eWhA33+ipyL7Gan3zhnsGSG+A7wSzpfrBsKIDQhvkZQ6V8YO+Hui5c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:7aed2d4c-1ef6-4e82-b876-ee196c971db5,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:83295aa,CLOUDID:e1e7e3f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: db3fda9ac32611edbd2e61cc88cc8f98-20230315
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 748479108; Wed, 15 Mar 2023 19:45:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 15 Mar 2023 19:45:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 15 Mar 2023 19:45:15 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH] soc: mediatek: pm-domains: Add buck isolation setting for MT8188
Date:   Wed, 15 Mar 2023 19:45:05 +0800
Message-ID: <20230315114505.25144-1-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ADSP_AO, CAM_VCORE and IMG_VCORE power domains in MT8188,
we have to add the buck isolation setting to make them work properly.

Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 drivers/soc/mediatek/mt8188-pm-domains.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mt8188-pm-domains.h b/drivers/soc/mediatek/mt8188-pm-domains.h
index 0692cb444ed0..e6dbdc0aa684 100644
--- a/drivers/soc/mediatek/mt8188-pm-domains.h
+++ b/drivers/soc/mediatek/mt8188-pm-domains.h
@@ -165,6 +165,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x35C,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(10),
 		.bp_infracfg = {
 			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
@@ -175,7 +177,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
-		.caps = MTK_SCPD_ALWAYS_ON,
+		.caps = MTK_SCPD_ALWAYS_ON | MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_ADSP_INFRA] = {
 		.name = "adsp_infra",
@@ -479,6 +481,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A4,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(12),
 		.bp_infracfg = {
 			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
@@ -493,7 +497,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY |
+			MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_IMG_MAIN] = {
 		.name = "img_main",
@@ -541,6 +546,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A0,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(11),
 		.bp_infracfg = {
 			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
@@ -563,7 +570,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY |
+			MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_CAM_MAIN] = {
 		.name = "cam_main",
-- 
2.18.0

