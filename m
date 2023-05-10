Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C616FD4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbjEJD5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjEJDzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:55:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFB3591;
        Tue,  9 May 2023 20:55:36 -0700 (PDT)
X-UUID: 8174241ceee611ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RI8vc5HHHEzczfqD16t7nOkGfbMNwVJXLerS6sexQ5w=;
        b=WP8p5lVHB2iRhsw3yWoULaQS3ZXl6lJItGTnJN+iS0kfpyDmHfWuDscRoqJs/+ZmfVB/El81tk2tvRs0ie3e02mQVwLioxF0QVUFDX10Iud6mqq5VtrqQgk17YW7fyqrBK5SUqoOFb593RlNbtwpkb0e0bv7HfeMXoKoU11h/DA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:79d321e6-0e29-428b-8150-5748a62a51ec,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:178d4d4,CLOUDID:791d516b-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 8174241ceee611ed9cb5633481061a41-20230510
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1065781609; Wed, 10 May 2023 11:55:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 11:55:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 11:55:29 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 7/9] ASoC: mediatek: mt8188: add required clocks
Date:   Wed, 10 May 2023 11:55:24 +0800
Message-ID: <20230510035526.18137-8-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230510035526.18137-1-trevor.wu@mediatek.com>
References: <20230510035526.18137-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apll2_d4, apll12_div4, top_a2sys and top_aud_iec are possibly used in
the future. To prevent from breaking binding ABI after any mt8188 dts
upstream, add these clocks to clock list in advance.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 4 ++++
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
index 02411be93900..4c24d0b9e90d 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
@@ -25,14 +25,18 @@ static const char *aud_clks[MT8188_CLK_NUM] = {
 
 	/* divider */
 	[MT8188_CLK_TOP_APLL1_D4] = "apll1_d4",
+	[MT8188_CLK_TOP_APLL2_D4] = "apll2_d4",
 	[MT8188_CLK_TOP_APLL12_DIV0] = "apll12_div0",
 	[MT8188_CLK_TOP_APLL12_DIV1] = "apll12_div1",
 	[MT8188_CLK_TOP_APLL12_DIV2] = "apll12_div2",
 	[MT8188_CLK_TOP_APLL12_DIV3] = "apll12_div3",
+	[MT8188_CLK_TOP_APLL12_DIV4] = "apll12_div4",
 	[MT8188_CLK_TOP_APLL12_DIV9] = "apll12_div9",
 
 	/* mux */
 	[MT8188_CLK_TOP_A1SYS_HP_SEL] = "top_a1sys_hp",
+	[MT8188_CLK_TOP_A2SYS_SEL] = "top_a2sys",
+	[MT8188_CLK_TOP_AUD_IEC_SEL] = "top_aud_iec",
 	[MT8188_CLK_TOP_AUD_INTBUS_SEL] = "top_aud_intbus",
 	[MT8188_CLK_TOP_AUDIO_H_SEL] = "top_audio_h",
 	[MT8188_CLK_TOP_AUDIO_LOCAL_BUS_SEL] = "top_audio_local_bus",
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
index 04cb476f0bcb..904505d10841 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
@@ -23,13 +23,17 @@ enum {
 	MT8188_CLK_APMIXED_APLL2,
 	/* divider */
 	MT8188_CLK_TOP_APLL1_D4,
+	MT8188_CLK_TOP_APLL2_D4,
 	MT8188_CLK_TOP_APLL12_DIV0,
 	MT8188_CLK_TOP_APLL12_DIV1,
 	MT8188_CLK_TOP_APLL12_DIV2,
 	MT8188_CLK_TOP_APLL12_DIV3,
+	MT8188_CLK_TOP_APLL12_DIV4,
 	MT8188_CLK_TOP_APLL12_DIV9,
 	/* mux */
 	MT8188_CLK_TOP_A1SYS_HP_SEL,
+	MT8188_CLK_TOP_A2SYS_SEL,
+	MT8188_CLK_TOP_AUD_IEC_SEL,
 	MT8188_CLK_TOP_AUD_INTBUS_SEL,
 	MT8188_CLK_TOP_AUDIO_H_SEL,
 	MT8188_CLK_TOP_AUDIO_LOCAL_BUS_SEL,
-- 
2.18.0

