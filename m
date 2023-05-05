Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046466F839B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjEENNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjEENNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:13:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306AD1E986;
        Fri,  5 May 2023 06:13:22 -0700 (PDT)
X-UUID: 99904a7eeb4611ed9cb5633481061a41-20230505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5N66xXPaesJHbEN2e+y1DB+ADmXl9MaI6t+9Chgeapo=;
        b=OQkRgqbdHkkc7frbm6kbSiTyV3VQNxExnAj0CPxedd2DO65Okv7fd15aal45e5EpsFFhHD4sjTtibU1tFliZdISi5vZlRECmIpxd0Y7VrwsDVzxHmK7/dD20vfx9O6eGWN7alsF+S3OfjiBeGY24S53+BZ7FrY0ZKGQ+AaqejhI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:a81fdd2e-07c5-4826-a262-4f6947dfffa9,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:697ab71,CLOUDID:f275e46a-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 99904a7eeb4611ed9cb5633481061a41-20230505
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 924361886; Fri, 05 May 2023 21:13:17 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 5 May 2023 21:13:16 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 May 2023 21:13:15 +0800
From:   Runyang Chen <runyang.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Subject: [PATCH v2 2/2] clk: mediatek: reset: add infra_ao reset support for MT8188
Date:   Fri, 5 May 2023 21:13:08 +0800
Message-ID: <20230505131308.27190-3-runyang.chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20230505131308.27190-1-runyang.chen@mediatek.com>
References: <20230505131308.27190-1-runyang.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infra_ao reset is needed for MT8188.
- Add mtk_clk_rst_desc for MT8188.
- Add register reset controller function for MT8188 infra_ao.
- Add infra_ao_idx_map for MT8188.

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8188-infra_ao.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8188-infra_ao.c b/drivers/clk/mediatek/clk-mt8188-infra_ao.c
index 91c35db40b4e..1d4b27ba06be 100644
--- a/drivers/clk/mediatek/clk-mt8188-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8188-infra_ao.c
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/clock/mediatek,mt8188-clk.h>
+#include <dt-bindings/reset/mt8188-resets.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
@@ -176,9 +177,32 @@ static const struct mtk_gate infra_ao_clks[] = {
 		       "infra_ao_aes_msdcfde_0p", "top_aes_msdcfde", 18),
 };
 
+static u16 infra_ao_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+	INFRA_RST4_SET_OFFSET,
+};
+
+static u16 infra_ao_idx_map[] = {
+	[MT8188_INFRA_RST1_THERMAL_MCU_RST] = 1 * RST_NR_PER_BANK + 2,
+	[MT8188_INFRA_RST1_THERMAL_CTRL_RST] = 1 * RST_NR_PER_BANK + 4,
+	[MT8188_INFRA_RST3_PTP_CTRL_RST] = 3 * RST_NR_PER_BANK + 5,
+};
+
+static struct mtk_clk_rst_desc infra_ao_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
+	.rst_idx_map = infra_ao_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
+};
+
 static const struct mtk_clk_desc infra_ao_desc = {
 	.clks = infra_ao_clks,
 	.num_clks = ARRAY_SIZE(infra_ao_clks),
+	.rst_desc = &infra_ao_rst_desc,
 };
 
 static const struct of_device_id of_match_clk_mt8188_infra_ao[] = {
-- 
2.18.0

