Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573A85FC183
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJLHy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJLHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:54:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E886F02E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:54:46 -0700 (PDT)
X-UUID: 3db400ae2c3d4cf29138b6d292f21e77-20221012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XPVpe+Og9tsOKwpk+GO3Cxy95U6brI62hoEBipMd8iE=;
        b=apsUzcc5m/Zf/j7rTNNlbgBO94CEiTObIgtI4a2S6vKIsqwjKaG5frDH9dBMpoQEO7tjgegPZLIjuD2mH7QS4iCoL+qB8563knnjPLEudB5vH4EyXyiTa7YNRDHfB9MVyCHN3eqladZyUBgmCt3tKq4Eo7El4X5NmbMh3X9kQhw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:a0db9b01-741a-4141-84f9-2ed2f9d0a6b6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:b61d3c01-cdeb-479d-93af-53f947adce9d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3db400ae2c3d4cf29138b6d292f21e77-20221012
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 924891986; Wed, 12 Oct 2022 15:54:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 12 Oct 2022 15:54:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 12 Oct 2022 15:54:38 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <allen-kh.cheng@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP default power on
Date:   Wed, 12 Oct 2022 15:54:34 +0800
Message-ID: <20221012075434.30009-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the use case of configuring the access permissions of the ADSP core,
the mt8186 SoC ADSP power will be switched on in the bootloader because
the permission control registers are located in the ADSP subsys.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/soc/mediatek/mt8186-pm-domains.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/soc/mediatek/mt8186-pm-domains.h
index 108af61854a3..fce86f79c505 100644
--- a/drivers/soc/mediatek/mt8186-pm-domains.h
+++ b/drivers/soc/mediatek/mt8186-pm-domains.h
@@ -304,7 +304,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.ctl_offs = 0x9FC,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
 	[MT8186_POWER_DOMAIN_ADSP_INFRA] = {
 		.name = "adsp_infra",
@@ -312,7 +311,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.ctl_offs = 0x9F8,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
 	[MT8186_POWER_DOMAIN_ADSP_TOP] = {
 		.name = "adsp_top",
@@ -332,7 +330,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 				MT8186_TOP_AXI_PROT_EN_3_CLR,
 				MT8186_TOP_AXI_PROT_EN_3_STA),
 		},
-		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_ACTIVE_WAKEUP,
 	},
 };
 
-- 
2.18.0

