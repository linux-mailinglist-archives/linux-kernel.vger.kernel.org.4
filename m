Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455F3614488
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKAGLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiKAGLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:11:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557713E91;
        Mon, 31 Oct 2022 23:11:44 -0700 (PDT)
X-UUID: 845b764c036743428ea1af133456fa44-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qKVQ5xUvwJLnVjPZU5c5Gw7oruotfGjxaq+qal/96R4=;
        b=GuUVMsDwkmDD7i5cWGFB/69htQfxwCVbR0tMncQU5xKaAHKhq6yFOuc7pscmKfUXtFN5G2HBslg3Cv/T8sS5Krjj1ZCyWPuyKXid8lWw7xrsZImXvY059WXCroPJEKpYYCk0Eo82McZrAq1WHYyDu0C3ejglmq7rv3eEPvNsTSY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:8e59e156-0255-4f9c-a468-7c19a5da7fe8,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.12,REQID:8e59e156-0255-4f9c-a468-7c19a5da7fe8,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:62cd327,CLOUDID:8a6f3e81-3116-4fbc-b86b-83475c3df513,B
        ulkID:221101141141HA5AA7M9,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 845b764c036743428ea1af133456fa44-20221101
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 272453379; Tue, 01 Nov 2022 14:11:40 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 1 Nov 2022 14:11:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 1 Nov 2022 14:11:39 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Yaochun Hung <yc.hung@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 2/2] ASoC: SOF: mediatek: Revise mt8186 ADSP clock driver
Date:   Tue, 1 Nov 2022 14:11:37 +0800
Message-ID: <20221101061137.25731-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221101061137.25731-1-tinghan.shen@mediatek.com>
References: <20221101061137.25731-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the required clocks for mt8186 ADSP. The ADSP core is
expected booting with 26M clock, and using the mainpll_d2_d2 clock
for ADSP bus.

The enable/disable order of clocks is also revised. The clock should
be enabled as mainpll_d2_d2 -> adsp bus -> adsp, and disabled in the
reversed order.

Fixes: 210b3ab932f7 ("ASoC: SOF: mediatek: Add mt8186 dsp clock support")
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186-clk.c | 35 +++++++++++++++++-----
 sound/soc/sof/mediatek/mt8186/mt8186-clk.h |  2 ++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186-clk.c b/sound/soc/sof/mediatek/mt8186/mt8186-clk.c
index 2df3b7ae1c6f..c86391aa7948 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186-clk.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186-clk.c
@@ -20,6 +20,8 @@
 static const char *adsp_clks[ADSP_CLK_MAX] = {
 	[CLK_TOP_AUDIODSP] = "audiodsp",
 	[CLK_TOP_ADSP_BUS] = "adsp_bus",
+	[CLK_TOP_MAINPLL_D2_D2] = "mainpll_d2_d2",
+	[CLK_TOP_CLK26M] = "clk26m",
 };
 
 int mt8186_adsp_init_clock(struct snd_sof_dev *sdev)
@@ -48,18 +50,36 @@ static int adsp_enable_all_clock(struct snd_sof_dev *sdev)
 	struct device *dev = sdev->dev;
 	int ret;
 
-	ret = clk_prepare_enable(priv->clk[CLK_TOP_AUDIODSP]);
+	ret = clk_set_parent(priv->clk[CLK_TOP_AUDIODSP], priv->clk[CLK_TOP_CLK26M]);
+	if (ret) {
+		dev_err(dev, "set audiodsp clock fail %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_set_parent(priv->clk[CLK_TOP_ADSP_BUS], priv->clk[CLK_TOP_MAINPLL_D2_D2]);
+	if (ret) {
+		dev_err(dev, "set adsp bus clock fail %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_MAINPLL_D2_D2]);
 	if (ret) {
-		dev_err(dev, "%s clk_prepare_enable(audiodsp) fail %d\n",
-			__func__, ret);
+		dev_err(dev, "clk_prepare_enable(mainpll_d2_d2) fail %d\n", ret);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(priv->clk[CLK_TOP_ADSP_BUS]);
 	if (ret) {
-		dev_err(dev, "%s clk_prepare_enable(adsp_bus) fail %d\n",
-			__func__, ret);
-		clk_disable_unprepare(priv->clk[CLK_TOP_AUDIODSP]);
+		dev_err(dev, "clk_prepare_enable(adsp_bus) fail %d\n", ret);
+		clk_disable_unprepare(priv->clk[CLK_TOP_MAINPLL_D2_D2]);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_AUDIODSP]);
+	if (ret) {
+		dev_err(dev, "clk_prepare_enable(audiodsp) fail %d\n", ret);
+		clk_disable_unprepare(priv->clk[CLK_TOP_MAINPLL_D2_D2]);
+		clk_disable_unprepare(priv->clk[CLK_TOP_ADSP_BUS]);
 		return ret;
 	}
 
@@ -70,8 +90,9 @@ static void adsp_disable_all_clock(struct snd_sof_dev *sdev)
 {
 	struct adsp_priv *priv = sdev->pdata->hw_pdata;
 
-	clk_disable_unprepare(priv->clk[CLK_TOP_ADSP_BUS]);
 	clk_disable_unprepare(priv->clk[CLK_TOP_AUDIODSP]);
+	clk_disable_unprepare(priv->clk[CLK_TOP_ADSP_BUS]);
+	clk_disable_unprepare(priv->clk[CLK_TOP_MAINPLL_D2_D2]);
 }
 
 int mt8186_adsp_clock_on(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/mediatek/mt8186/mt8186-clk.h b/sound/soc/sof/mediatek/mt8186/mt8186-clk.h
index 89c23caf0fee..37f5cfa2b230 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186-clk.h
+++ b/sound/soc/sof/mediatek/mt8186/mt8186-clk.h
@@ -15,6 +15,8 @@ struct snd_sof_dev;
 enum adsp_clk_id {
 	CLK_TOP_AUDIODSP,
 	CLK_TOP_ADSP_BUS,
+	CLK_TOP_MAINPLL_D2_D2,
+	CLK_TOP_CLK26M,
 	ADSP_CLK_MAX
 };
 
-- 
2.18.0

