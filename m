Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFDF652FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLUKth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiLUKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:49:15 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A9209B1;
        Wed, 21 Dec 2022 02:49:09 -0800 (PST)
X-UUID: 24f6f9947fe34c098e3b59af11ad9144-20221221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WGKJaH848FGT7UtQn20Dr3WfdpVLLB256AUCWfX5JE0=;
        b=sTn9dEBbUF9nuUb0rDR930bfLu/TVD/R29ozestib63cxf/xmEletrmDRhUjxpSESBCmr3edJwn2Hbz8GsjcaJVCstoc+VUmDi6q7NS/7qOGhsGF84IQ4nacVOQLbvIFj/gF41zAYjgBP4xiRzyqiH0vflefkWr77sEwCo+2gPQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:5ad6ecc7-bb00-48bb-bb61-3132d956d20a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:5ad6ecc7-bb00-48bb-bb61-3132d956d20a,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:c75c008a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:221221184901LOP7S5AQ,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 24f6f9947fe34c098e3b59af11ad9144-20221221
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1725570560; Wed, 21 Dec 2022 18:48:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 21 Dec 2022 18:48:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 21 Dec 2022 18:48:57 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH] arm64: dts: mediatek: mt8186: Add crypto support for eMMC controller
Date:   Wed, 21 Dec 2022 18:48:56 +0800
Message-ID: <20221221104856.28770-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

For crypto support, add a crypto clock of the inline crypto engine and
expand the register size in the eMMC controller.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index c326aeb33a10..88b6191e1aa0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -662,12 +662,13 @@
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8186-mmc",
 				     "mediatek,mt8183-mmc";
-			reg = <0 0x11230000 0 0x1000>,
+			reg = <0 0x11230000 0 0x10000>,
 			      <0 0x11cd0000 0 0x1000>;
 			clocks = <&topckgen CLK_TOP_MSDC50_0>,
 				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
-				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
-			clock-names = "source", "hclk", "source_cg";
+				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDCFDE>;
+			clock-names = "source", "hclk", "source_cg", "crypto";
 			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
 			assigned-clocks = <&topckgen CLK_TOP_MSDC50_0>;
 			assigned-clock-parents = <&apmixedsys CLK_APMIXED_MSDCPLL>;
-- 
2.18.0

