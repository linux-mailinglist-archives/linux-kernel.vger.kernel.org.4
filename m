Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73407637485
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiKXIy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKXIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:54:51 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7346A10B43C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:54:45 -0800 (PST)
X-UUID: 4eec1624fe3e4ac1bd1052dd37f46a9b-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Se93twhCnANzbyfAp19LflQ7H378k9rkCrI1fa1AgUY=;
        b=kaE5lrXdlSx/NNQjmuyyQJ7mZv2iZcS635v/rxTauMCA/80UDzSNnVpPucgo7AJXsPuck7eaWhnC9RhND4RbsIwvwLuHawXEmuEEYSOfy1a0708AunRnAL0+tmHnMEcRl8P1wRajLKZn7k/8YbZQ8joNfIdgAwmhrItkXahRLWg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:016c2cf5-489e-4d9c-939f-472d708d3b4a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:7bc4b52f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4eec1624fe3e4ac1bd1052dd37f46a9b-20221124
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 177122599; Thu, 24 Nov 2022 16:54:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 16:54:39 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 24 Nov 2022 16:54:38 +0800
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
Subject: [PATCH 1/3] drm: bridge: it6505: bridge to hdmi-codec
Date:   Thu, 24 Nov 2022 16:54:34 +0800
Message-ID: <20221124085436.24900-2-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124085436.24900-1-jiaxin.yu@mediatek.com>
References: <20221124085436.24900-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Bridge to hdmi-codec to support audio feature. At the same time,
   the function of automatically detecting audio is removed.
2. It is observed that some DP-to-HDMI dongles will get into bad
   states if sending InfoFrame without audio data. Defer to enable
   it6505's audio feature when PCM triggers START or RESUME.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 36 ++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index dfe4351c9bdd..f4e1a1d94ed8 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2159,7 +2159,6 @@ static void it6505_stop_link_train(struct it6505 *it6505)
 
 static void it6505_link_train_ok(struct it6505 *it6505)
 {
-	struct device *dev = &it6505->client->dev;
 
 	it6505->link_state = LINK_OK;
 	/* disalbe mute enable avi info frame */
@@ -2167,11 +2166,6 @@ static void it6505_link_train_ok(struct it6505 *it6505)
 	it6505_set_bits(it6505, REG_INFOFRAME_CTRL,
 			EN_VID_CTRL_PKT, EN_VID_CTRL_PKT);
 
-	if (it6505_audio_input(it6505)) {
-		DRM_DEV_DEBUG_DRIVER(dev, "Enable audio!");
-		it6505_enable_audio(it6505);
-	}
-
 	if (it6505->hdcp_desired)
 		it6505_start_hdcp(it6505);
 }
@@ -2823,6 +2817,36 @@ static void __maybe_unused it6505_audio_shutdown(struct device *dev, void *data)
 		it6505_disable_audio(it6505);
 }
 
+static int __maybe_unused it6505_audio_setup_trigger(struct it6505 *it6505, int cmd)
+{
+	struct device *dev = &it6505->client->dev;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "event: %d", cmd);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		queue_delayed_work(system_wq, &it6505->delayed_audio,
+				   msecs_to_jiffies(180));
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		cancel_delayed_work(&it6505->delayed_audio);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused it6505_audio_trigger(struct device *dev, int cmd)
+{
+	struct it6505 *it6505 = dev_get_drvdata(dev);
+
+	return it6505_audio_setup_trigger(it6505, cmd);
+}
+
 static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *dev,
 						       void *data,
 						       hdmi_codec_plugged_cb fn,
-- 
2.18.0

