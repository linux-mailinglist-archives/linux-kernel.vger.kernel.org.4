Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EFA6EEE00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbjDZGG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbjDZGGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:06:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B842134;
        Tue, 25 Apr 2023 23:06:46 -0700 (PDT)
X-UUID: 629c9b6ee3f611eda9a90f0bb45854f4-20230426
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=F/Yw6OHKAu10IOjEUM87CTc8nWP90wVs74g53jQNKRU=;
        b=B4D8nURqIgUXurwUeLxDqlNtsADrhTyuAz8VAjR9WkyeRU6NIOzVQfd4R6kK+sw9mJDcXEEZjjXq3UdZZI97l/9JBKrDb4gj1PjSkA3JZRSE+EFBwOnF40hgUce9lctgFK1VWz6zLtogvfY4k3Ud1rXNkkIU/8zyKZDIlKn4bGg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:ffe0e4cb-e3c0-4323-87be-771b12e8c958,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.22,REQID:ffe0e4cb-e3c0-4323-87be-771b12e8c958,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:120426c,CLOUDID:23ae4685-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230426135130124GY5IY,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 629c9b6ee3f611eda9a90f0bb45854f4-20230426
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 3227872; Wed, 26 Apr 2023 13:51:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 26 Apr 2023 13:51:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 26 Apr 2023 13:51:26 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 4/7] ASoC: mediatek: mt8188: refine APLL control
Date:   Wed, 26 Apr 2023 13:51:21 +0800
Message-ID: <20230426055124.16529-5-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230426055124.16529-1-trevor.wu@mediatek.com>
References: <20230426055124.16529-1-trevor.wu@mediatek.com>
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

Currently, APLL is only used in ETDM module, so APLL and APLL tuner
don't need to be enabled when AFE is used. Integrate APLL control into
ETDM DAPM routes, so that APLL can be enabled when it is really required.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c  | 138 ++++++++++++++++----
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h  |  11 ++
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c | 115 ++++++++++++++++
 3 files changed, 241 insertions(+), 23 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
index 743d6a162cb9..02411be93900 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
@@ -24,6 +24,7 @@ static const char *aud_clks[MT8188_CLK_NUM] = {
 	[MT8188_CLK_APMIXED_APLL2] = "apll2",
 
 	/* divider */
+	[MT8188_CLK_TOP_APLL1_D4] = "apll1_d4",
 	[MT8188_CLK_TOP_APLL12_DIV0] = "apll12_div0",
 	[MT8188_CLK_TOP_APLL12_DIV1] = "apll12_div1",
 	[MT8188_CLK_TOP_APLL12_DIV2] = "apll12_div2",
@@ -378,6 +379,19 @@ int mt8188_afe_get_default_mclk_source_by_rate(int rate)
 		MT8188_MCK_SEL_APLL1 : MT8188_MCK_SEL_APLL2;
 }
 
+int mt8188_get_apll_by_rate(struct mtk_base_afe *afe, int rate)
+{
+	return ((rate % 8000) == 0) ? MT8188_AUD_PLL1 : MT8188_AUD_PLL2;
+}
+
+int mt8188_get_apll_by_name(struct mtk_base_afe *afe, const char *name)
+{
+	if (strcmp(name, APLL1_W_NAME) == 0)
+		return MT8188_AUD_PLL1;
+
+	return MT8188_AUD_PLL2;
+}
+
 int mt8188_afe_init_clock(struct mtk_base_afe *afe)
 {
 	struct mt8188_afe_private *afe_priv = afe->platform_priv;
@@ -477,8 +491,8 @@ int mt8188_afe_set_clk_parent(struct mtk_base_afe *afe, struct clk *clk,
 	if (clk && parent) {
 		ret = clk_set_parent(clk, parent);
 		if (ret) {
-			dev_dbg(afe->dev, "%s(), failed to set clk parent\n",
-				__func__);
+			dev_dbg(afe->dev, "%s(), failed to set clk parent %d\n",
+				__func__, ret);
 			return ret;
 		}
 	}
@@ -605,54 +619,132 @@ static int mt8188_afe_disable_afe_on(struct mtk_base_afe *afe)
 	return 0;
 }
 
-static int mt8188_afe_enable_timing_sys(struct mtk_base_afe *afe)
+static int mt8188_afe_enable_a1sys(struct mtk_base_afe *afe)
 {
 	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	int ret;
 
-	mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A1SYS]);
-	mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A2SYS]);
+	ret = mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A1SYS]);
+	if (ret)
+		return ret;
 
-	mt8188_afe_enable_top_cg(afe, MT8188_TOP_CG_A1SYS_TIMING);
-	mt8188_afe_enable_top_cg(afe, MT8188_TOP_CG_A2SYS_TIMING);
-	mt8188_afe_enable_top_cg(afe, MT8188_TOP_CG_26M_TIMING);
+	return mt8188_afe_enable_top_cg(afe, MT8188_TOP_CG_A1SYS_TIMING);
+}
+
+static int mt8188_afe_disable_a1sys(struct mtk_base_afe *afe)
+{
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
 
+	mt8188_afe_disable_top_cg(afe, MT8188_TOP_CG_A1SYS_TIMING);
+	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A1SYS]);
 	return 0;
 }
 
-static int mt8188_afe_disable_timing_sys(struct mtk_base_afe *afe)
+static int mt8188_afe_enable_a2sys(struct mtk_base_afe *afe)
 {
 	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	int ret;
 
-	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A1SYS]);
-	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A2SYS]);
+	ret = mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A2SYS]);
+	if (ret)
+		return ret;
 
-	mt8188_afe_disable_top_cg(afe, MT8188_TOP_CG_26M_TIMING);
-	mt8188_afe_disable_top_cg(afe, MT8188_TOP_CG_A2SYS_TIMING);
-	mt8188_afe_disable_top_cg(afe, MT8188_TOP_CG_A1SYS_TIMING);
+	return mt8188_afe_enable_top_cg(afe, MT8188_TOP_CG_A2SYS_TIMING);
+}
+
+static int mt8188_afe_disable_a2sys(struct mtk_base_afe *afe)
+{
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
 
+	mt8188_afe_disable_top_cg(afe, MT8188_TOP_CG_A2SYS_TIMING);
+	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_A2SYS]);
 	return 0;
 }
 
-int mt8188_afe_enable_main_clock(struct mtk_base_afe *afe)
+int mt8188_apll1_enable(struct mtk_base_afe *afe)
 {
-	mt8188_afe_enable_timing_sys(afe);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	int ret;
 
-	mt8188_afe_enable_afe_on(afe);
+	ret = mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_TOP_APLL1_D4]);
+	if (ret)
+		return ret;
+
+	ret = mt8188_afe_set_clk_parent(afe, afe_priv->clk[MT8188_CLK_TOP_A1SYS_HP_SEL],
+					afe_priv->clk[MT8188_CLK_TOP_APLL1_D4]);
+	if (ret)
+		goto err_clk_parent;
 
-	mt8188_afe_enable_apll_tuner(afe, MT8188_AUD_PLL1);
-	mt8188_afe_enable_apll_tuner(afe, MT8188_AUD_PLL2);
+	ret = mt8188_afe_enable_apll_tuner(afe, MT8188_AUD_PLL1);
+	if (ret)
+		goto err_apll_tuner;
+
+	ret = mt8188_afe_enable_a1sys(afe);
+	if (ret)
+		goto err_a1sys;
 
 	return 0;
+
+err_a1sys:
+	mt8188_afe_disable_apll_tuner(afe, MT8188_AUD_PLL1);
+err_apll_tuner:
+	mt8188_afe_set_clk_parent(afe, afe_priv->clk[MT8188_CLK_TOP_A1SYS_HP_SEL],
+				  afe_priv->clk[MT8188_CLK_XTAL_26M]);
+err_clk_parent:
+	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_TOP_APLL1_D4]);
+
+	return ret;
 }
 
-int mt8188_afe_disable_main_clock(struct mtk_base_afe *afe)
+int mt8188_apll1_disable(struct mtk_base_afe *afe)
 {
-	mt8188_afe_disable_apll_tuner(afe, MT8188_AUD_PLL2);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+
+	mt8188_afe_disable_a1sys(afe);
 	mt8188_afe_disable_apll_tuner(afe, MT8188_AUD_PLL1);
+	mt8188_afe_set_clk_parent(afe, afe_priv->clk[MT8188_CLK_TOP_A1SYS_HP_SEL],
+				  afe_priv->clk[MT8188_CLK_XTAL_26M]);
+	mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_TOP_APLL1_D4]);
 
-	mt8188_afe_disable_afe_on(afe);
+	return 0;
+}
+
+int mt8188_apll2_enable(struct mtk_base_afe *afe)
+{
+	int ret;
 
-	mt8188_afe_disable_timing_sys(afe);
+	ret = mt8188_afe_enable_apll_tuner(afe, MT8188_AUD_PLL2);
+	if (ret)
+		return ret;
 
+	ret =  mt8188_afe_enable_a2sys(afe);
+	if (ret)
+		goto err_a2sys;
+
+	return 0;
+err_a2sys:
+	mt8188_afe_disable_apll_tuner(afe, MT8188_AUD_PLL2);
+
+	return ret;
+}
+
+int mt8188_apll2_disable(struct mtk_base_afe *afe)
+{
+	mt8188_afe_disable_a2sys(afe);
+	mt8188_afe_disable_apll_tuner(afe, MT8188_AUD_PLL2);
+	return 0;
+}
+
+int mt8188_afe_enable_main_clock(struct mtk_base_afe *afe)
+{
+	mt8188_afe_enable_top_cg(afe, MT8188_TOP_CG_26M_TIMING);
+	mt8188_afe_enable_afe_on(afe);
+	return 0;
+}
+
+int mt8188_afe_disable_main_clock(struct mtk_base_afe *afe)
+{
+	mt8188_afe_disable_afe_on(afe);
+	mt8188_afe_disable_top_cg(afe, MT8188_TOP_CG_26M_TIMING);
 	return 0;
 }
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
index 084fdfb1d877..04cb476f0bcb 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.h
@@ -11,6 +11,10 @@
 #ifndef _MT8188_AFE_CLK_H_
 #define _MT8188_AFE_CLK_H_
 
+/* APLL */
+#define APLL1_W_NAME "APLL1"
+#define APLL2_W_NAME "APLL2"
+
 enum {
 	/* xtal */
 	MT8188_CLK_XTAL_26M,
@@ -18,6 +22,7 @@ enum {
 	MT8188_CLK_APMIXED_APLL1,
 	MT8188_CLK_APMIXED_APLL2,
 	/* divider */
+	MT8188_CLK_TOP_APLL1_D4,
 	MT8188_CLK_TOP_APLL12_DIV0,
 	MT8188_CLK_TOP_APLL12_DIV1,
 	MT8188_CLK_TOP_APLL12_DIV2,
@@ -99,6 +104,8 @@ struct mtk_base_afe;
 int mt8188_afe_get_mclk_source_clk_id(int sel);
 int mt8188_afe_get_mclk_source_rate(struct mtk_base_afe *afe, int apll);
 int mt8188_afe_get_default_mclk_source_by_rate(int rate);
+int mt8188_get_apll_by_rate(struct mtk_base_afe *afe, int rate);
+int mt8188_get_apll_by_name(struct mtk_base_afe *afe, const char *name);
 int mt8188_afe_init_clock(struct mtk_base_afe *afe);
 void mt8188_afe_deinit_clock(void *priv);
 int mt8188_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk);
@@ -107,6 +114,10 @@ int mt8188_afe_set_clk_rate(struct mtk_base_afe *afe, struct clk *clk,
 			    unsigned int rate);
 int mt8188_afe_set_clk_parent(struct mtk_base_afe *afe, struct clk *clk,
 			      struct clk *parent);
+int mt8188_apll1_enable(struct mtk_base_afe *afe);
+int mt8188_apll1_disable(struct mtk_base_afe *afe);
+int mt8188_apll2_enable(struct mtk_base_afe *afe);
+int mt8188_apll2_disable(struct mtk_base_afe *afe);
 int mt8188_afe_enable_main_clock(struct mtk_base_afe *afe);
 int mt8188_afe_disable_main_clock(struct mtk_base_afe *afe);
 int mt8188_afe_enable_reg_rw_clk(struct mtk_base_afe *afe);
diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
index fd6e39a1e4c1..16440dd0a89c 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
@@ -22,6 +22,7 @@
 #define ENUM_TO_STR(x)	#x
 
 enum {
+	SUPPLY_SEQ_APLL,
 	SUPPLY_SEQ_ETDM_MCLK,
 	SUPPLY_SEQ_ETDM_CG,
 	SUPPLY_SEQ_DPTX_EN,
@@ -95,6 +96,7 @@ struct mtk_dai_etdm_priv {
 	bool slave_mode;
 	bool lrck_inv;
 	bool bck_inv;
+	unsigned int rate;
 	unsigned int format;
 	unsigned int slots;
 	unsigned int lrck_width;
@@ -360,6 +362,10 @@ static int get_etdm_id_by_name(struct mtk_base_afe *afe,
 		return MT8188_AFE_IO_ETDM1_OUT;
 	else if (!strncmp(name, "ETDM2_OUT", strlen("ETDM2_OUT")))
 		return MT8188_AFE_IO_ETDM2_OUT;
+	else if (!strncmp(name, "ETDM3_OUT", strlen("ETDM3_OUT")))
+		return MT8188_AFE_IO_ETDM3_OUT;
+	else if (!strncmp(name, "DPTX", strlen("DPTX")))
+		return MT8188_AFE_IO_ETDM3_OUT;
 	else
 		return -EINVAL;
 }
@@ -445,6 +451,44 @@ static int mtk_dai_etdm_disable_mclk(struct mtk_base_afe *afe, int dai_id)
 	return 0;
 }
 
+static int mtk_afe_etdm_apll_connect(struct snd_soc_dapm_widget *source,
+				     struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget *w = sink;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_dai_etdm_priv *etdm_priv;
+	int cur_apll;
+	int need_apll;
+
+	etdm_priv = get_etdm_priv_by_name(afe, w->name);
+	if (!etdm_priv) {
+		dev_dbg(afe->dev, "etdm_priv == NULL\n");
+		return 0;
+	}
+
+	cur_apll = mt8188_get_apll_by_name(afe, source->name);
+	need_apll = mt8188_get_apll_by_rate(afe, etdm_priv->rate);
+
+	return (need_apll == cur_apll) ? 1 : 0;
+}
+
+static int mtk_afe_mclk_apll_connect(struct snd_soc_dapm_widget *source,
+				     struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget *w = sink;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_dai_etdm_priv *etdm_priv;
+	int cur_apll;
+
+	etdm_priv = get_etdm_priv_by_name(afe, w->name);
+
+	cur_apll = mt8188_get_apll_by_name(afe, source->name);
+
+	return (etdm_priv->mclk_apll == cur_apll) ? 1 : 0;
+}
+
 static int mtk_etdm_mclk_connect(struct snd_soc_dapm_widget *source,
 				 struct snd_soc_dapm_widget *sink)
 {
@@ -520,6 +564,36 @@ static int mtk_etdm_cowork_connect(struct snd_soc_dapm_widget *source,
 	return 0;
 }
 
+static int mtk_apll_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_dbg(cmpnt->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (strcmp(w->name, APLL1_W_NAME) == 0)
+			mt8188_apll1_enable(afe);
+		else
+			mt8188_apll2_enable(afe);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (strcmp(w->name, APLL1_W_NAME) == 0)
+			mt8188_apll1_disable(afe);
+		else
+			mt8188_apll2_disable(afe);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int mtk_etdm_mclk_event(struct snd_soc_dapm_widget *w,
 			       struct snd_kcontrol *kcontrol,
 			       int event)
@@ -1231,6 +1305,16 @@ static const struct snd_soc_dapm_widget mtk_dai_etdm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("DPTX_EN", SUPPLY_SEQ_DPTX_EN,
 			      AFE_DPTX_CON, AFE_DPTX_CON_ON_SHIFT, 0, NULL, 0),
 
+	/* apll */
+	SND_SOC_DAPM_SUPPLY_S(APLL1_W_NAME, SUPPLY_SEQ_APLL,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_apll_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY_S(APLL2_W_NAME, SUPPLY_SEQ_APLL,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_apll_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
 	SND_SOC_DAPM_INPUT("ETDM_INPUT"),
 	SND_SOC_DAPM_OUTPUT("ETDM_OUTPUT"),
 };
@@ -1259,6 +1343,21 @@ static const struct snd_soc_dapm_route mtk_dai_etdm_routes[] = {
 
 	{"DPTX", NULL, "DPTX_MCLK"},
 
+	{"ETDM1_IN_MCLK", NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{"ETDM1_IN_MCLK", NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
+	{"ETDM2_IN_MCLK", NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{"ETDM2_IN_MCLK", NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
+	{"ETDM1_OUT_MCLK", NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{"ETDM1_OUT_MCLK", NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
+	{"ETDM2_OUT_MCLK", NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{"ETDM2_OUT_MCLK", NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
+	{"DPTX_MCLK", NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{"DPTX_MCLK", NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
 	/* cg */
 	{"ETDM1_IN", NULL, "ETDM1_IN_CG"},
 	{"ETDM1_IN", NULL, "ETDM2_IN_CG", mtk_etdm_cowork_connect},
@@ -1308,6 +1407,21 @@ static const struct snd_soc_dapm_route mtk_dai_etdm_routes[] = {
 	{"DPTX", NULL, "ETDM3_OUT_EN"},
 	{"DPTX", NULL, "DPTX_EN"},
 
+	{"ETDM1_IN_EN", NULL, APLL1_W_NAME, mtk_afe_etdm_apll_connect},
+	{"ETDM1_IN_EN", NULL, APLL2_W_NAME, mtk_afe_etdm_apll_connect},
+
+	{"ETDM2_IN_EN", NULL, APLL1_W_NAME, mtk_afe_etdm_apll_connect},
+	{"ETDM2_IN_EN", NULL, APLL2_W_NAME, mtk_afe_etdm_apll_connect},
+
+	{"ETDM1_OUT_EN", NULL, APLL1_W_NAME, mtk_afe_etdm_apll_connect},
+	{"ETDM1_OUT_EN", NULL, APLL2_W_NAME, mtk_afe_etdm_apll_connect},
+
+	{"ETDM2_OUT_EN", NULL, APLL1_W_NAME, mtk_afe_etdm_apll_connect},
+	{"ETDM2_OUT_EN", NULL, APLL2_W_NAME, mtk_afe_etdm_apll_connect},
+
+	{"ETDM3_OUT_EN", NULL, APLL1_W_NAME, mtk_afe_etdm_apll_connect},
+	{"ETDM3_OUT_EN", NULL, APLL2_W_NAME, mtk_afe_etdm_apll_connect},
+
 	{"I012", NULL, "ETDM2_IN"},
 	{"I013", NULL, "ETDM2_IN"},
 	{"I014", NULL, "ETDM2_IN"},
@@ -2004,6 +2118,7 @@ static int mtk_dai_etdm_configure(struct mtk_base_afe *afe,
 		return -EINVAL;
 	etdm_data = afe_priv->dai_priv[dai_id];
 	slave_mode = etdm_data->slave_mode;
+	etdm_data->rate = rate;
 
 	ret = get_etdm_reg(dai_id, &etdm_reg);
 	if (ret < 0)
-- 
2.18.0

