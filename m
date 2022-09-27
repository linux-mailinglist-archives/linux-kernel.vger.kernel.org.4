Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A95EC74B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiI0PMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiI0PL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:11:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E28100395
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:11:50 -0700 (PDT)
X-UUID: 5123190f57b04aac8915a50865dc35ab-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9tjx5t8k5Luxw2O54U9tC1FC5+hKWB1/DzXaoINrLXE=;
        b=GM3RIT9OpYSuKnPaqG9AWeo7d2qcRYKpeX4zfRzCi5JhE2D+XFKiHO2uYc8Xc1V5+2beI8LoEsXXGzqxufq4ivMffKvWcJ/W9SNiPDehAu8J9HOiJ4H/6kbdQ1LIGgcTeGAweF1gGbCf7bwhhIzzVeybFNYRh1oCgft6XJ+/NfU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:ed2a5966-de9d-4aa5-a0ce-70977a3e2cd6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:ed2a5966-de9d-4aa5-a0ce-70977a3e2cd6,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:f22d40a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:220927231145B3R6UNXY,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 5123190f57b04aac8915a50865dc35ab-20220927
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 474841654; Tue, 27 Sep 2022 23:11:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Sep 2022 23:11:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Sep 2022 23:11:44 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: mediatek: mt8195: update audio tuner settings
Date:   Tue, 27 Sep 2022 23:11:41 +0800
Message-ID: <20220927151141.11846-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio tuner is used to handle clock drift between 26M and APLL domain.

It's expected when abs(chg_cnt) equals to upper bound, tuner updates pcw
setting automatically, and then abs(chg_cnt) decreases.
In the stress test, we found abs(chg_cnt) possibly equals to 2 at the
unexpected timing. This results in wrong pcw updating.
Finally, abs(chg_cnt) will always be larger than upper bound,

As a result, we update the upper bound to 3 to handle the corner case.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
index 2ee3872c83c3..9ca2cb8c8a9c 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
@@ -117,7 +117,7 @@ static struct mt8195_afe_tuner_cfg mt8195_afe_tuner_cfgs[MT8195_AUD_PLL_NUM] = {
 		.upper_bound_reg = AFE_APLL_TUNER_CFG,
 		.upper_bound_shift = 8,
 		.upper_bound_maskbit = 0xff,
-		.upper_bound_default = 0x2,
+		.upper_bound_default = 0x3,
 	},
 	[MT8195_AUD_PLL2] = {
 		.id = MT8195_AUD_PLL2,
@@ -135,7 +135,7 @@ static struct mt8195_afe_tuner_cfg mt8195_afe_tuner_cfgs[MT8195_AUD_PLL_NUM] = {
 		.upper_bound_reg = AFE_APLL_TUNER_CFG1,
 		.upper_bound_shift = 8,
 		.upper_bound_maskbit = 0xff,
-		.upper_bound_default = 0x2,
+		.upper_bound_default = 0x3,
 	},
 	[MT8195_AUD_PLL3] = {
 		.id = MT8195_AUD_PLL3,
-- 
2.18.0

