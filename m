Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203CB647C82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 04:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLIDLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLIDLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:11:14 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2E18D188
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:11:05 -0800 (PST)
X-UUID: 477afe1c999b4addaeae07fecc270c2f-20221209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0IUYP1FMYMYrYJClJDGBDoSMePz+IPYu2tTV/hqTIg4=;
        b=jEcYxOzAoNoSBkLUSERUCtUaMruZag/aG/ZvjITUyuxv6zTVXPoQdFbgwrKyKgZVovE0EW69zY38t+HGVGM1dy70mIvt6RfmJ0xKco38ujCG66VTtvor29grs/RZtFiRZgZnQAE9k8F9T/hlpbdYdUVBEwmBoenK1X8J7lYNXLM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:b2a5f13b-35ac-4432-a0ce-cf9ad2ad1484,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:b2a5f13b-35ac-4432-a0ce-cf9ad2ad1484,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:2d1615d2-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:221209111100ORC5MHTL,BulkQuantity:1,Recheck:0,SF:40|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 477afe1c999b4addaeae07fecc270c2f-20221209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 354103708; Fri, 09 Dec 2022 11:10:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 9 Dec 2022 11:10:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 9 Dec 2022 11:10:58 +0800
From:   YC Hung <yc.hung@mediatek.com>
CC:     <yc.hung@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Curtis Malainey" <cujomalainey@chromium.org>,
        <whalechang@google.com>
Subject: [PATCH] ASoC: mediatek: mt8195: add sof be ops to check audio active
Date:   Fri, 9 Dec 2022 11:10:53 +0800
Message-ID: <20221209031053.8444-1-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MT8195 SOF design, both DSP and audio driver would access audio
registers. Before DSP accesses audio registers, audio power and clock
should be enabled. DSP will hang up if DSP access audio register but
audio power and clock are disabled. Therefore, we add audio pm runtime
active checking before accessing audio registers in SOF BE's callback
hw_params function to avoid this situation.

Signed-off-by: YC Hung <yc.hung@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 61be66f47723..4682748d82be 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -633,6 +633,32 @@ static const struct snd_soc_ops mt8195_rt1011_etdm_ops = {
 	.hw_params = mt8195_rt1011_etdm_hw_params,
 };
 
+static int mt8195_sof_be_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_component *cmpnt_afe = NULL;
+	struct snd_soc_pcm_runtime *runtime;
+
+	/* find afe component */
+	for_each_card_rtds(rtd->card, runtime) {
+		cmpnt_afe = snd_soc_rtdcom_lookup(runtime, AFE_PCM_NAME);
+		if (cmpnt_afe)
+			break;
+	}
+
+	if (cmpnt_afe && !pm_runtime_active(cmpnt_afe->dev)) {
+		dev_err(rtd->dev, "afe pm runtime is not active!!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops mt8195_sof_be_ops = {
+	.hw_params = mt8195_sof_be_hw_params,
+};
+
 static int mt8195_rt1011_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -1272,24 +1298,28 @@ static struct snd_soc_dai_link mt8195_mt6359_dai_links[] = {
 		.name = "AFE_SOF_DL2",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
+		.ops = &mt8195_sof_be_ops,
 		SND_SOC_DAILINK_REG(AFE_SOF_DL2),
 	},
 	[DAI_LINK_SOF_DL3_BE] = {
 		.name = "AFE_SOF_DL3",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
+		.ops = &mt8195_sof_be_ops,
 		SND_SOC_DAILINK_REG(AFE_SOF_DL3),
 	},
 	[DAI_LINK_SOF_UL4_BE] = {
 		.name = "AFE_SOF_UL4",
 		.no_pcm = 1,
 		.dpcm_capture = 1,
+		.ops = &mt8195_sof_be_ops,
 		SND_SOC_DAILINK_REG(AFE_SOF_UL4),
 	},
 	[DAI_LINK_SOF_UL5_BE] = {
 		.name = "AFE_SOF_UL5",
 		.no_pcm = 1,
 		.dpcm_capture = 1,
+		.ops = &mt8195_sof_be_ops,
 		SND_SOC_DAILINK_REG(AFE_SOF_UL5),
 	},
 };
-- 
2.18.0

