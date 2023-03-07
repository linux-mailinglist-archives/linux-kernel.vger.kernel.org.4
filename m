Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC86AD5F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCGEKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCGEJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:09:50 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192823754E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:09:45 -0800 (PST)
X-UUID: e36f8326bc9d11eda06fc9ecc4dadd91-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uX8FTUwRYfAy8w7Dy3s9sKBg/HS7F0rl+yXqTa3r7zY=;
        b=LJOt7XCCC5Sj3WmWSkj0ThTrGiJfwHCmuPBeTLF6IhzqUF/2gUa2lLbNWc3yDam5v0oVHVQuPMBeh7wUZ0ktK0PiRKfphPrS4sTYapKZEcooPt+k2ZMGEA41IFfvyyZz1IYcmTDbMUbdWOCyc4AqrR9pYstf77WrA8YGhC6ZtvE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:6c84d550-f2b4-4b85-b7c2-dbb1518b7854,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.20,REQID:6c84d550-f2b4-4b85-b7c2-dbb1518b7854,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:25b5999,CLOUDID:a0158c27-564d-42d9-9875-7c868ee415ec,B
        ulkID:230307120943G2KIQYNQ,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: e36f8326bc9d11eda06fc9ecc4dadd91-20230307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 69082577; Tue, 07 Mar 2023 12:09:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 12:09:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 12:09:41 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ASoC: mediatek: mt8195: add dai id check before accessing array
Date:   Tue, 7 Mar 2023 12:09:35 +0800
Message-ID: <20230307040938.7484-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230307040938.7484-1-trevor.wu@mediatek.com>
References: <20230307040938.7484-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity shows "afe_priv->dai_priv[dai_id] evaluates to an address that
could be at negative offset of an array.". Add dai id check before
accessing the array element. This ensures that the offset of an array must
be a valid index.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c |  17 +-
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c | 177 +++++++++++++++++---
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c  |  26 ++-
 3 files changed, 185 insertions(+), 35 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-adda.c b/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
index f04bd1781356..0dd35255066b 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-adda.c
@@ -704,13 +704,18 @@ static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_adda_priv *adda_priv = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_adda_priv *adda_priv;
 	unsigned int rate = params_rate(params);
-	int id = dai->id;
-	int ret = 0;
+	int ret;
+
+	if (dai->id != MT8195_AFE_IO_DL_SRC &&
+	    dai->id != MT8195_AFE_IO_UL_SRC1 &&
+	    dai->id != MT8195_AFE_IO_UL_SRC2)
+		return -EINVAL;
+	adda_priv = afe_priv->dai_priv[dai->id];
 
 	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d\n",
-		__func__, id, substream->stream, rate);
+		__func__, dai->id, substream->stream, rate);
 
 	if (rate > ADDA_HIRES_THRES)
 		adda_priv->hires_required = 1;
@@ -718,9 +723,9 @@ static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
 		adda_priv->hires_required = 0;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ret = mtk_dai_da_configure(afe, rate, id);
+		ret = mtk_dai_da_configure(afe, rate, dai->id);
 	else
-		ret = mtk_dai_ad_configure(afe, rate, id);
+		ret = mtk_dai_ad_configure(afe, rate, dai->id);
 
 	return ret;
 }
diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
index f2c9a1fdbe0d..eedb9165f911 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
@@ -137,6 +137,38 @@ static const struct mtk_dai_etdm_rate mt8195_etdm_rates[] = {
 	{ .rate = 352800, .reg_value = 21, },
 };
 
+static bool mt8195_afe_etdm_is_valid(int id)
+{
+	switch (id) {
+	case MT8195_AFE_IO_ETDM1_IN:
+		fallthrough;
+	case MT8195_AFE_IO_ETDM2_IN:
+		fallthrough;
+	case MT8195_AFE_IO_ETDM1_OUT:
+		fallthrough;
+	case MT8195_AFE_IO_ETDM2_OUT:
+		fallthrough;
+	case MT8195_AFE_IO_DPTX:
+		fallthrough;
+	case MT8195_AFE_IO_ETDM3_OUT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mt8195_afe_hdmitx_dptx_is_valid(int id)
+{
+	switch (id) {
+	case MT8195_AFE_IO_DPTX:
+		fallthrough;
+	case MT8195_AFE_IO_ETDM3_OUT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int get_etdm_fs_timing(unsigned int rate)
 {
 	int i;
@@ -236,8 +268,12 @@ static int is_cowork_mode(struct snd_soc_dai *dai)
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_etdm_priv *etdm_data;
 
+	if (!mt8195_afe_etdm_is_valid(dai->id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai->id];
 	return (etdm_data->cowork_slv_count > 0 ||
 		etdm_data->cowork_source_id != COWORK_ETDM_NONE);
 }
@@ -264,8 +300,14 @@ static int get_etdm_cowork_master_id(struct snd_soc_dai *dai)
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
-	int dai_id = etdm_data->cowork_source_id;
+	struct mtk_dai_etdm_priv *etdm_data;
+	int dai_id;
+
+	if (!mt8195_afe_etdm_is_valid(dai->id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai->id];
+	dai_id = etdm_data->cowork_source_id;
 
 	if (dai_id == COWORK_ETDM_NONE)
 		dai_id = dai->id;
@@ -1276,9 +1318,13 @@ static int mt8195_afe_enable_etdm(struct mtk_base_afe *afe, int dai_id)
 	int ret = 0;
 	struct etdm_con_reg etdm_reg;
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai_id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	unsigned long flags;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai_id];
 	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
 	etdm_data->en_ref_cnt++;
 	if (etdm_data->en_ref_cnt == 1) {
@@ -1299,9 +1345,13 @@ static int mt8195_afe_disable_etdm(struct mtk_base_afe *afe, int dai_id)
 	int ret = 0;
 	struct etdm_con_reg etdm_reg;
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai_id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	unsigned long flags;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai_id];
 	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
 	if (etdm_data->en_ref_cnt > 0) {
 		etdm_data->en_ref_cnt--;
@@ -1357,12 +1407,16 @@ static int etdm_cowork_slv_sel(int id, int slave_mode)
 static int mt8195_etdm_sync_mode_configure(struct mtk_base_afe *afe, int dai_id)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai_id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	unsigned int reg = 0;
 	unsigned int mask;
 	unsigned int val;
 	int cowork_source_sel;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai_id];
 	if (etdm_data->cowork_source_id == COWORK_ETDM_NONE)
 		return 0;
 
@@ -1532,8 +1586,10 @@ static int mtk_dai_etdm_startup(struct snd_pcm_substream *substream,
 
 	if (is_cowork_mode(dai)) {
 		mst_dai_id = get_etdm_cowork_master_id(dai);
-		mtk_dai_etdm_enable_mclk(afe, mst_dai_id);
+		if (!mt8195_afe_etdm_is_valid(mst_dai_id))
+			return -EINVAL;
 
+		mtk_dai_etdm_enable_mclk(afe, mst_dai_id);
 		cg_id = mtk_dai_etdm_get_cg_id_by_dai_id(mst_dai_id);
 		if (cg_id >= 0)
 			mt8195_afe_enable_clk(afe, afe_priv->clk[cg_id]);
@@ -1571,6 +1627,9 @@ static void mtk_dai_etdm_shutdown(struct snd_pcm_substream *substream,
 
 	if (is_cowork_mode(dai)) {
 		mst_dai_id = get_etdm_cowork_master_id(dai);
+		if (!mt8195_afe_etdm_is_valid(mst_dai_id))
+			return;
+
 		cg_id = mtk_dai_etdm_get_cg_id_by_dai_id(mst_dai_id);
 		if (cg_id >= 0)
 			mt8195_afe_disable_clk(afe, afe_priv->clk[cg_id]);
@@ -1631,16 +1690,24 @@ static int mtk_dai_etdm_in_configure(struct mtk_base_afe *afe,
 				     int dai_id)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai_id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	struct etdm_con_reg etdm_reg;
-	bool slave_mode = etdm_data->slave_mode;
-	unsigned int data_mode = etdm_data->data_mode;
-	unsigned int lrck_width = etdm_data->lrck_width;
+	bool slave_mode;
+	unsigned int data_mode;
+	unsigned int lrck_width;
 	unsigned int val = 0;
 	unsigned int mask = 0;
 	int i;
 	int ret;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai_id];
+	slave_mode = etdm_data->slave_mode;
+	data_mode = etdm_data->data_mode;
+	lrck_width = etdm_data->lrck_width;
+
 	dev_dbg(afe->dev, "%s rate %u channels %u, id %d\n",
 		__func__, rate, channels, dai_id);
 
@@ -1748,15 +1815,22 @@ static int mtk_dai_etdm_out_configure(struct mtk_base_afe *afe,
 				      int dai_id)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai_id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	struct etdm_con_reg etdm_reg;
-	bool slave_mode = etdm_data->slave_mode;
-	unsigned int lrck_width = etdm_data->lrck_width;
+	bool slave_mode;
+	unsigned int lrck_width;
 	unsigned int val = 0;
 	unsigned int mask = 0;
 	int ret;
 	int fs = 0;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai_id];
+	slave_mode = etdm_data->slave_mode;
+	lrck_width = etdm_data->lrck_width;
+
 	dev_dbg(afe->dev, "%s rate %u channels %u, id %d\n",
 		__func__, rate, channels, dai_id);
 
@@ -1837,7 +1911,7 @@ static int mtk_dai_etdm_out_configure(struct mtk_base_afe *afe,
 static int mtk_dai_etdm_mclk_configure(struct mtk_base_afe *afe, int dai_id)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai_id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	int clk_id = mtk_dai_etdm_get_clk_id_by_dai_id(dai_id);
 	int clkdiv_id = mtk_dai_etdm_get_clkdiv_id_by_dai_id(dai_id);
 	int apll;
@@ -1850,6 +1924,10 @@ static int mtk_dai_etdm_mclk_configure(struct mtk_base_afe *afe, int dai_id)
 	if (clk_id < 0 || clkdiv_id < 0)
 		return 0;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai_id];
 	ret = get_etdm_reg(dai_id, &etdm_reg);
 	if (ret < 0)
 		return ret;
@@ -1888,9 +1966,9 @@ static int mtk_dai_etdm_configure(struct mtk_base_afe *afe,
 				  int dai_id)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai_id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	struct etdm_con_reg etdm_reg;
-	bool slave_mode = etdm_data->slave_mode;
+	bool slave_mode;
 	unsigned int etdm_channels;
 	unsigned int val = 0;
 	unsigned int mask = 0;
@@ -1898,6 +1976,11 @@ static int mtk_dai_etdm_configure(struct mtk_base_afe *afe,
 	unsigned int wlen = get_etdm_wlen(bit_width);
 	int ret;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai_id];
+	slave_mode = etdm_data->slave_mode;
 	ret = get_etdm_reg(dai_id, &etdm_reg);
 	if (ret < 0)
 		return ret;
@@ -1973,6 +2056,8 @@ static int mtk_dai_etdm_hw_params(struct snd_pcm_substream *substream,
 
 	if (is_cowork_mode(dai)) {
 		mst_dai_id = get_etdm_cowork_master_id(dai);
+		if (!mt8195_afe_etdm_is_valid(mst_dai_id))
+			return -EINVAL;
 
 		ret = mtk_dai_etdm_mclk_configure(afe, mst_dai_id);
 		if (ret)
@@ -2024,6 +2109,9 @@ static int mtk_dai_etdm_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 		if (is_cowork_mode(dai)) {
 			mst_dai_id = get_etdm_cowork_master_id(dai);
+			if (!mt8195_afe_etdm_is_valid(mst_dai_id))
+				return -EINVAL;
+
 			mst_etdm_data = afe_priv->dai_priv[mst_dai_id];
 
 			//open master first
@@ -2040,6 +2128,9 @@ static int mtk_dai_etdm_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		if (is_cowork_mode(dai)) {
 			mst_dai_id = get_etdm_cowork_master_id(dai);
+			if (!mt8195_afe_etdm_is_valid(mst_dai_id))
+				return -EINVAL;
+
 			mst_etdm_data = afe_priv->dai_priv[mst_dai_id];
 
 			for (i = 0; i < mst_etdm_data->cowork_slv_count; i++) {
@@ -2061,10 +2152,14 @@ static int mtk_dai_etdm_trigger(struct snd_pcm_substream *substream, int cmd,
 static int mtk_dai_etdm_cal_mclk(struct mtk_base_afe *afe, int freq, int dai_id)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai_id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	int apll;
 	int apll_rate;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai_id];
 	if (freq == 0) {
 		etdm_data->mclk_freq = freq;
 		return 0;
@@ -2104,6 +2199,9 @@ static int mtk_dai_etdm_set_sysclk(struct snd_soc_dai *dai,
 	else
 		dai_id = dai->id;
 
+	if (!mt8195_afe_etdm_is_valid(dai_id))
+		return -EINVAL;
+
 	etdm_data = afe_priv->dai_priv[dai_id];
 	etdm_data->mclk_dir = dir;
 	return mtk_dai_etdm_cal_mclk(afe, freq, dai_id);
@@ -2115,8 +2213,12 @@ static int mtk_dai_etdm_set_tdm_slot(struct snd_soc_dai *dai,
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_etdm_priv *etdm_data;
+
+	if (!mt8195_afe_etdm_is_valid(dai->id))
+		return -EINVAL;
 
+	etdm_data = afe_priv->dai_priv[dai->id];
 	dev_dbg(dai->dev, "%s id %d slot_width %d\n",
 		__func__, dai->id, slot_width);
 
@@ -2129,8 +2231,12 @@ static int mtk_dai_etdm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_etdm_priv *etdm_data;
+
+	if (!mt8195_afe_etdm_is_valid(dai->id))
+		return -EINVAL;
 
+	etdm_data = afe_priv->dai_priv[dai->id];
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		etdm_data->format = MTK_DAI_ETDM_FORMAT_I2S;
@@ -2248,13 +2354,18 @@ static int mtk_dai_hdmitx_dptx_hw_params(struct snd_pcm_substream *substream,
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_etdm_priv *etdm_data;
 	unsigned int rate = params_rate(params);
 	unsigned int channels = params_channels(params);
 	snd_pcm_format_t format = params_format(params);
 	int width = snd_pcm_format_physical_width(format);
 	int ret = 0;
 
+	if (!mt8195_afe_hdmitx_dptx_is_valid(dai->id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai->id];
+
 	/* dptx configure */
 	if (dai->id == MT8195_AFE_IO_DPTX) {
 		regmap_update_bits(afe->regmap, AFE_DPTX_CON,
@@ -2331,7 +2442,12 @@ static int mtk_dai_hdmitx_dptx_set_sysclk(struct snd_soc_dai *dai,
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_etdm_priv *etdm_data;
+
+	if (!mt8195_afe_hdmitx_dptx_is_valid(dai->id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai->id];
 
 	dev_dbg(dai->dev, "%s id %d freq %u, dir %d\n",
 		__func__, dai->id, freq, dir);
@@ -2370,10 +2486,14 @@ static int mtk_dai_etdm_probe(struct snd_soc_dai *dai)
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_etdm_priv *etdm_data = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_etdm_priv *etdm_data;
 
 	dev_dbg(dai->dev, "%s id %d\n", __func__, dai->id);
 
+	if (!mt8195_afe_etdm_is_valid(dai->id))
+		return -EINVAL;
+
+	etdm_data = afe_priv->dai_priv[dai->id];
 	if (etdm_data->mclk_freq) {
 		dev_dbg(afe->dev, "MCLK always on, rate %d\n",
 			etdm_data->mclk_freq);
@@ -2477,6 +2597,11 @@ static void mt8195_etdm_update_sync_info(struct mtk_base_afe *afe)
 		etdm_data = afe_priv->dai_priv[i];
 		if (etdm_data->cowork_source_id != COWORK_ETDM_NONE) {
 			mst_dai_id = etdm_data->cowork_source_id;
+			if (!mt8195_afe_etdm_is_valid(mst_dai_id)) {
+				dev_err(afe->dev, "%s invalid dai id %d\n",
+					__func__, mst_dai_id);
+				return;
+			}
 			mst_data = afe_priv->dai_priv[mst_dai_id];
 			if (mst_data->cowork_source_id != COWORK_ETDM_NONE)
 				dev_info(afe->dev, "%s [%d] wrong sync source\n"
@@ -2513,6 +2638,12 @@ static void mt8195_dai_etdm_parse_of(struct mtk_base_afe *afe)
 
 	for (i = 0; i < MT8195_AFE_IO_ETDM_NUM; i++) {
 		dai_id = ETDM_TO_DAI_ID(i);
+		if (!mt8195_afe_etdm_is_valid(dai_id)) {
+			dev_err(afe->dev, "%s invalid dai id %d\n",
+				__func__, dai_id);
+			return;
+		}
+
 		etdm_data = afe_priv->dai_priv[dai_id];
 
 		ret = snprintf(prop, sizeof(prop),
diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c b/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
index 051433689ff5..6d6d79300d51 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
@@ -122,17 +122,26 @@ static int mtk_dai_pcm_configure(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime * const runtime = substream->runtime;
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_pcmif_priv *pcmif_priv = afe_priv->dai_priv[dai->id];
-	unsigned int slave_mode = pcmif_priv->slave_mode;
-	unsigned int lrck_inv = pcmif_priv->lrck_inv;
-	unsigned int bck_inv = pcmif_priv->bck_inv;
-	unsigned int fmt = pcmif_priv->format;
+	struct mtk_dai_pcmif_priv *pcmif_priv;
+	unsigned int slave_mode;
+	unsigned int lrck_inv;
+	unsigned int bck_inv;
+	unsigned int fmt;
 	unsigned int bit_width = dai->sample_bits;
 	unsigned int val = 0;
 	unsigned int mask = 0;
 	int fs = 0;
 	int mode = 0;
 
+	if (dai->id != MT8195_AFE_IO_PCM)
+		return -EINVAL;
+
+	pcmif_priv = afe_priv->dai_priv[dai->id];
+	slave_mode = pcmif_priv->slave_mode;
+	lrck_inv = pcmif_priv->lrck_inv;
+	bck_inv = pcmif_priv->bck_inv;
+	fmt = pcmif_priv->format;
+
 	/* sync freq mode */
 	fs = mt8195_afe_fs_timing(runtime->rate);
 	if (fs < 0)
@@ -230,10 +239,15 @@ static int mtk_dai_pcm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_dai_pcmif_priv *pcmif_priv = afe_priv->dai_priv[dai->id];
+	struct mtk_dai_pcmif_priv *pcmif_priv;
 
 	dev_dbg(dai->dev, "%s fmt 0x%x\n", __func__, fmt);
 
+	if (dai->id != MT8195_AFE_IO_PCM)
+		return -EINVAL;
+
+	pcmif_priv = afe_priv->dai_priv[dai->id];
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		pcmif_priv->format = MTK_DAI_PCM_FMT_I2S;
-- 
2.18.0

