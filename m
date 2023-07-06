Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F134E7495D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjGFGlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjGFGlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:41:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3F1B6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:41:30 -0700 (PDT)
X-UUID: 2175edac1bc811eeb20a276fd37b9834-20230706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=At6v0JUxdW/mbpvlVAB9IxicW+zOqiOwDYu6Cx8kM+g=;
        b=RW1HkGZXY/Ztro2DUnL2l8uaScZKyqWjs3/nLAMRVmtRt4c6d0g8e5LY0Ca3Qhy3d/DMfECKl/+y8vPxtKxwcwxNyTJL81KH7nwzHJnMaHSA7zf/xuegt7IiIczg9/QGXNQtxI8AUCB60VcA6AL/SCUdB4IFvo2CUyGNt06Iof4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:dadce778-47c4-42dc-b6ec-5f39e6b2c3cb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:8898c282-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2175edac1bc811eeb20a276fd37b9834-20230706
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1342812932; Thu, 06 Jul 2023 14:41:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jul 2023 14:41:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jul 2023 14:41:25 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: mediatek: mt8188: DPCM used FE and BE merged parameters
Date:   Thu, 6 Jul 2023 14:41:23 +0800
Message-ID: <20230706064123.29790-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure that DPCM takes into account the backend hardware limitations
when user space queries the hw_params of a device, we need to add
dpcm_merged_format, dpcm_merged_chan, and dpcm_merged_rate to the FE
dai_links.

This patch includes only stereo FE dai_links, since multi-channel FEs
may be reserved for specific purposes. Therefore, it may not be
appropriate to consider BE conditions.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index ac69c23e0da1..7c9e08e6a4f5 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -723,6 +723,9 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 		},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.dpcm_merged_format = 1,
 		SND_SOC_DAILINK_REG(playback2),
 	},
 	[DAI_LINK_DL3_FE] = {
@@ -734,6 +737,9 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 		},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.dpcm_merged_format = 1,
 		SND_SOC_DAILINK_REG(playback3),
 	},
 	[DAI_LINK_DL6_FE] = {
@@ -745,6 +751,9 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 		},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.dpcm_merged_format = 1,
 		SND_SOC_DAILINK_REG(playback6),
 	},
 	[DAI_LINK_DL7_FE] = {
@@ -833,6 +842,9 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 		},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.dpcm_merged_format = 1,
 		SND_SOC_DAILINK_REG(capture4),
 	},
 	[DAI_LINK_UL5_FE] = {
@@ -844,6 +856,9 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 		},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		.dpcm_merged_chan = 1,
+		.dpcm_merged_rate = 1,
+		.dpcm_merged_format = 1,
 		SND_SOC_DAILINK_REG(capture5),
 	},
 	[DAI_LINK_UL6_FE] = {
-- 
2.18.0

