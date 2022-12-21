Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24629652BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiLUDo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUDoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:44:22 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01831EAD7;
        Tue, 20 Dec 2022 19:44:17 -0800 (PST)
X-UUID: 3e33cd9b3f5944c9893ba0809ab23b7c-20221221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hkqKJdQLfbeXJfgg20ZloYGxwStSpQ6SVH54+huC6OI=;
        b=l2D9/fKDrDYlugATadHgbJ6T09SuL7pJBY6DYSfiAySEaM3KcFXUyw+c++wKqK7zf/AobGb0zE46+TXvgSA+m2gjAQjuML6s+8NB402uXfVmOlTugfmVvKFzjyqy3oiK61jml9CnWlDWgbm6Riwq/bp9scQoKgI54Jgfw0XgEBY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:3eb1bf69-2683-45d2-af77-a1ef8eb70a0a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:3eb1bf69-2683-45d2-af77-a1ef8eb70a0a,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:1f3283f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:221221114413EKZW7EKR,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3e33cd9b3f5944c9893ba0809ab23b7c-20221221
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1098570935; Wed, 21 Dec 2022 11:44:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 21 Dec 2022 11:44:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 21 Dec 2022 11:44:10 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 1/6] soc: mediatek: pm-domains: Add buck isolation offset and mask to power domain data
Date:   Wed, 21 Dec 2022 11:44:02 +0800
Message-ID: <20221221034407.19605-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
References: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add buck isolation offset and mask to power domain data.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 drivers/soc/mediatek/mtk-pm-domains.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 7d3c0c36316c..a5f24c58e35a 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -81,6 +81,8 @@ struct scpsys_bus_prot_data {
  * @ctl_offs: The offset for main power control register.
  * @sram_pdn_bits: The mask for sram power control bits.
  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
+ * @ext_buck_iso_offs: The offset for external buck isolation
+ * @ext_buck_iso_mask: The mask for external buck isolation
  * @caps: The flag for active wake-up action.
  * @bp_infracfg: bus protection for infracfg subsystem
  * @bp_smi: bus protection for smi subsystem
@@ -91,6 +93,8 @@ struct scpsys_domain_data {
 	int ctl_offs;
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
+	int ext_buck_iso_offs;
+	u32 ext_buck_iso_mask;
 	u8 caps;
 	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
 	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
-- 
2.18.0

