Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E8687A60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBBKhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjBBKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:37:28 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA0C60CA9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:37:17 -0800 (PST)
X-UUID: 8c8a5bdea2e511ed945fc101203acc17-20230202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=g3x9st1cLckpQozblUmO+23e1Rs2Ez5xAw9Nt8F6aEo=;
        b=pQ0gRocQzNTuHVw8JytTA+emifsmsjXq8AivScr1yZRwlkoJ/p4sNkGVVsOutxWwtljjapHx4i5P134px9r7+MmMGFqTj+Wxg3vy0VRGXlLXmMDXM5deQjNJdj2R5zLOh+u9j2JEUHOP2ZGlKYSvaFqMnF6MGUz8t14tXuolGlA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:b3403138-62eb-4712-86fc-ff10243628e9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:9fbb1956-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 8c8a5bdea2e511ed945fc101203acc17-20230202
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2115447088; Thu, 02 Feb 2023 18:37:10 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 2 Feb 2023 18:37:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 2 Feb 2023 18:37:09 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <error27@gmail.com>
Subject: [PATCH] ASoC: mediatek: mt8188: remove etdm dead code
Date:   Thu, 2 Feb 2023 18:37:04 +0800
Message-ID: <20230202103704.15626-1-trevor.wu@mediatek.com>
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

Some Smatch static checker warning like below was found.

sound/soc/mediatek/mt8188/mt8188-dai-etdm.c:2487
mt8188_dai_etdm_parse_of()
warn: 'ret' returned from snprintf() might be larger than 48

    2479         for (i = 0; i < MT8188_AFE_IO_ETDM_NUM; i++) {
    2480                 dai_id = ETDM_TO_DAI_ID(i);
    2481                 etdm_data = afe_priv->dai_priv[dai_id];
    2482
    2483                 ret = snprintf(prop, sizeof(prop),
    2484                                "mediatek,%s-multi-pin-mode",
    2485                                of_afe_etdms[i].name);
    2486                 if (ret < 0) {
--> 2487                         dev_err(afe->dev, "%s snprintf
err=%d\n",
    2488

In linux kernel, snprintf() never returns negatives. On the other hand,
the format string like "mediatek,%s-multi-pin-mode" must be smaller
than sizeof(prop)=48.

After discussing in the mail thread[1], I remove the dead code to fix
the Smatch warnings.

[1]: https://lore.kernel.org/all/Y9EdBg641tJDDrt%2F@kili/

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c | 33 ++++++---------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
index 0b79c1cc293b..071841903c62 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
@@ -2480,24 +2480,14 @@ static void mt8188_dai_etdm_parse_of(struct mtk_base_afe *afe)
 		dai_id = ETDM_TO_DAI_ID(i);
 		etdm_data = afe_priv->dai_priv[dai_id];
 
-		ret = snprintf(prop, sizeof(prop),
-			       "mediatek,%s-multi-pin-mode",
-			       of_afe_etdms[i].name);
-		if (ret < 0) {
-			dev_err(afe->dev, "%s snprintf err=%d\n",
-				__func__, ret);
-			return;
-		}
+		snprintf(prop, sizeof(prop), "mediatek,%s-multi-pin-mode",
+			 of_afe_etdms[i].name);
+
 		etdm_data->data_mode = of_property_read_bool(of_node, prop);
 
-		ret = snprintf(prop, sizeof(prop),
-			       "mediatek,%s-cowork-source",
-			       of_afe_etdms[i].name);
-		if (ret < 0) {
-			dev_err(afe->dev, "%s snprintf err=%d\n",
-				__func__, ret);
-			return;
-		}
+		snprintf(prop, sizeof(prop), "mediatek,%s-cowork-source",
+			 of_afe_etdms[i].name);
+
 		ret = of_property_read_u32(of_node, prop, &sel);
 		if (ret == 0) {
 			if (sel >= MT8188_AFE_IO_ETDM_NUM) {
@@ -2516,14 +2506,9 @@ static void mt8188_dai_etdm_parse_of(struct mtk_base_afe *afe)
 
 	/* etdm in only */
 	for (i = 0; i < 2; i++) {
-		ret = snprintf(prop, sizeof(prop),
-			       "mediatek,%s-chn-disabled",
-			       of_afe_etdms[i].name);
-		if (ret < 0) {
-			dev_err(afe->dev, "%s snprintf err=%d\n",
-				__func__, ret);
-			return;
-		}
+		snprintf(prop, sizeof(prop), "mediatek,%s-chn-disabled",
+			 of_afe_etdms[i].name);
+
 		ret = of_property_read_variable_u8_array(of_node, prop,
 							 disable_chn,
 							 1, max_chn);
-- 
2.18.0

