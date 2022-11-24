Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427B2637488
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKXIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKXIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:54:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87431A4675
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:54:48 -0800 (PST)
X-UUID: 5a1697d7b01a49778e007fc4272136c7-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vz32to7zdlLJ3qNpyb8VnolqTMd0LD/XvVaG+ohQNDo=;
        b=sup8TiFduXrY0r4zf8XjEecKkTbuO+vMjjII35GMGEZmZ/GPJm1+mboYnNuLrWMhAY+WLUM8swuBkTGoB/KcGvj/PTZujBkLE3crIcchlw5vU51QTsiS/RBzda2osf7NoT1CFG2ZFcgQ/ExU1Uayg30siMrKuNqmH1C8wkd1Omw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a4eda33b-4abd-4ed3-9487-fd23bb665f5c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:826420dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5a1697d7b01a49778e007fc4272136c7-20221124
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 449839032; Thu, 24 Nov 2022 16:54:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 16:54:40 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 24 Nov 2022 16:54:39 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <robert.foss@linaro.org>,
        <Laurent.pinchart@ideasonboard.com>,
        <kuninori.morimoto.gx@renesas.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>
CC:     <chunxu.li@mediatek.com>,
        <ajye_huang@compal.corp-partner.google.com>,
        <allen-kh.cheng@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH 2/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Date:   Thu, 24 Nov 2022 16:54:35 +0800
Message-ID: <20221124085436.24900-3-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124085436.24900-1-jiaxin.yu@mediatek.com>
References: <20221124085436.24900-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If the speaker and hdmi are connect to the same port of I2S,
when try to switch to speaker playback, we will find that hdmi
is always turned on automatically. The way of switching is
through SOC_DAPM_PIN_SWITCH, however, such events can not be
handled in hdmi-codec driver.

So add event handler for hdmi TX to solve the above issue.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 include/sound/hdmi-codec.h    |  6 ++++++
 sound/soc/codecs/hdmi-codec.c | 37 +++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 48ad33aba393..dcbc09254144 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -81,6 +81,12 @@ struct hdmi_codec_ops {
 		       struct hdmi_codec_daifmt *fmt,
 		       struct hdmi_codec_params *hparms);
 
+	/*
+	 * PCM trigger callback.
+	 * Mandatory
+	 */
+	int (*trigger)(struct device *dev, int cmd);
+
 	/*
 	 * Shuts down the audio stream.
 	 * Mandatory
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 0b1cdb2d6049..cb4479372e09 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -276,7 +276,31 @@ struct hdmi_codec_priv {
 	u8 iec_status[AES_IEC958_STATUS_SIZE];
 };
 
+static int hdmi_tx_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (hcp->hcd.ops->trigger)
+			hcp->hcd.ops->trigger(component->dev->parent, SNDRV_PCM_TRIGGER_START);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (hcp->hcd.ops->trigger)
+			hcp->hcd.ops->trigger(component->dev->parent, SNDRV_PCM_TRIGGER_STOP);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
+	SND_SOC_DAPM_OUT_DRV_E("SDB", SND_SOC_NOPM, 0, 0, NULL, 0, hdmi_tx_event,
+			       SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_OUTPUT("TX"),
 	SND_SOC_DAPM_OUTPUT("RX"),
 };
@@ -808,18 +832,23 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 	struct hdmi_codec_daifmt *daifmt;
 	struct snd_soc_dapm_route route[] = {
 		{
-			.sink = "TX",
+			.sink = dai->driver->capture.stream_name,
+			.source = "RX",
+		},
+		{
+			.sink = "SDB",
 			.source = dai->driver->playback.stream_name,
 		},
 		{
-			.sink = dai->driver->capture.stream_name,
-			.source = "RX",
+			.sink = "TX",
+			.source = "SDB",
 		},
+
 	};
 	int ret;
 
 	dapm = snd_soc_component_get_dapm(dai->component);
-	ret = snd_soc_dapm_add_routes(dapm, route, 2);
+	ret = snd_soc_dapm_add_routes(dapm, route, ARRAY_SIZE(route));
 	if (ret)
 		return ret;
 
-- 
2.18.0

