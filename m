Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A216DDF96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjDKPZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjDKPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:25:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C0B4EF3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:25:38 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B5cuXJ012801;
        Tue, 11 Apr 2023 10:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=h7DditDHGmOtptShi/lIy8tnhUVRuZRHJPllhupMv7Y=;
 b=jXi+jFd/d5f6+uOcY0+gYawFBxHSTTPTIen6w0ZT/ClYXA7wZ3r8m5UHnSJIbHIcfoCN
 n2LOtY77XJeakIJO2hGiufJ5BOECLkEGJhrKZkLwGwRZwsbET52duW2Lmy+lRmvd2Q3m
 kiWQHLwNXvvpNL8cAkUefFV0DtppUVuk2VSmLR2IKOLNpz5+fJyuGwTUxMGDnpebeSvI
 DlWnq60ely5Lo0oAegNb1dFrviY3axlRMUzLtVDp1PtFuSuu2HTxbpOSu1Xuk1xPYaKL
 dxhhYSuayXHpr7XVZSCKr45PWTSlqLbbHRSrYjXCwE81ULL7SPT2xJALCYOnH3oSMdHl Fw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq54a3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:25:32 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 11 Apr
 2023 10:25:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Apr 2023 10:25:28 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5EA2515A4;
        Tue, 11 Apr 2023 15:25:28 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/6] ASoC: cs35l56: Use DAPM widget for firmware PLAY/PAUSE
Date:   Tue, 11 Apr 2023 16:25:24 +0100
Message-ID: <20230411152528.329803-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230411152528.329803-1-rf@opensource.cirrus.com>
References: <20230411152528.329803-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7ADj-nRnMCs-naLvQdERRqpVep_mEc0N
X-Proofpoint-ORIG-GUID: 7ADj-nRnMCs-naLvQdERRqpVep_mEc0N
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we use a DAPM widget instead of mute_stream() to send the
PLAY command we can issue the plays to multiple amps in parallel.
With mute_stream each codec driver instance is called one at a
time so we get N * PS0 delay time.

DAPM does each stage on every widget in a card before moving to
the next stage. So all amps will do the PRE_PMU then all will do
the POST_PMU. The PLAY is sent in the PRE_PMU so that they all
power-up in parallel. After the PS0 wait in the first POST_PMU
all the other amps will also be ready so there won't be any extra
delay, or it will be negligible.

There's also no point waiting for the MBOX ack in the PRE_PMU.
We won't see a PS0 state in POST_PMU if it didn't ack the PLAY
command. So we can save a little extra time.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 105 +++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 50 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 675aad8e909f..997a5c5acaab 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -32,6 +32,23 @@
 static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event);
 
+static int cs35l56_mbox_send(struct cs35l56_private *cs35l56, unsigned int command)
+{
+	unsigned int val;
+	int ret;
+
+	regmap_write(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
+	ret = regmap_read_poll_timeout(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+				       val, (val == 0),
+				       CS35L56_MBOX_POLL_US, CS35L56_MBOX_TIMEOUT_US);
+	if (ret) {
+		dev_warn(cs35l56->dev, "MBOX command %#x failed: %d\n", command, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int cs35l56_wait_dsp_ready(struct cs35l56_private *cs35l56)
 {
 	int ret;
@@ -182,10 +199,45 @@ static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx6_enum,
 static const struct snd_kcontrol_new sdw1_tx6_mux =
 	SOC_DAPM_ENUM("SDW1TX6 SRC", cs35l56_sdw1tx6_enum);
 
+static int cs35l56_play_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	unsigned int val;
+	int ret;
+
+	dev_dbg(cs35l56->dev, "play: %d\n", event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Don't wait for ACK, we check in POST_PMU that it completed */
+		return regmap_write(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+				    CS35L56_MBOX_CMD_AUDIO_PLAY);
+	case SND_SOC_DAPM_POST_PMU:
+		/* Wait for firmware to enter PS0 power state */
+		ret = regmap_read_poll_timeout(cs35l56->regmap,
+					       CS35L56_TRANSDUCER_ACTUAL_PS,
+					       val, (val == CS35L56_PS0),
+					       CS35L56_PS0_POLL_US,
+					       CS35L56_PS0_TIMEOUT_US);
+		if (ret)
+			dev_err(cs35l56->dev, "PS0 wait failed: %d\n", ret);
+		return ret;
+	case SND_SOC_DAPM_POST_PMD:
+		return cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_AUDIO_PAUSE);
+	default:
+		return 0;
+	}
+}
+
 static const struct snd_soc_dapm_widget cs35l56_dapm_widgets[] = {
 	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD_B", 0, 0),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD_AMP", 0, 0),
 
+	SND_SOC_DAPM_SUPPLY("PLAY", SND_SOC_NOPM, 0, 0, cs35l56_play_event,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
 	SND_SOC_DAPM_OUT_DRV("AMP", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("SPK"),
 
@@ -252,6 +304,9 @@ static const struct snd_soc_dapm_route cs35l56_audio_map[] = {
 	{ "AMP", NULL, "VDD_B" },
 	{ "AMP", NULL, "VDD_AMP" },
 
+	{ "ASP1 Playback", NULL, "PLAY" },
+	{ "SDW1 Playback", NULL, "PLAY" },
+
 	{ "ASP1RX1", NULL, "ASP1 Playback" },
 	{ "ASP1RX2", NULL, "ASP1 Playback" },
 	{ "DSP1", NULL, "ASP1RX1" },
@@ -288,23 +343,6 @@ static const struct snd_soc_dapm_route cs35l56_audio_map[] = {
 	{ "SDW1 Capture", NULL, "SDW1 TX6 Source" },
 };
 
-static int cs35l56_mbox_send(struct cs35l56_private *cs35l56, unsigned int command)
-{
-	unsigned int val;
-	int ret;
-
-	regmap_write(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
-	ret = regmap_read_poll_timeout(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
-				       val, (val == 0),
-				       CS35L56_MBOX_POLL_US, CS35L56_MBOX_TIMEOUT_US);
-	if (ret) {
-		dev_warn(cs35l56->dev, "MBOX command %#x failed: %d\n", command, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
@@ -611,43 +649,11 @@ static int cs35l56_asp_dai_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int cs35l56_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
-{
-	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
-	unsigned int val;
-	int ret;
-
-	dev_dbg(cs35l56->dev, "%s: %d %s\n", __func__, stream, mute ? "mute" : "unmute");
-
-	if (stream != SNDRV_PCM_STREAM_PLAYBACK)
-		return 0;
-
-	if (mute) {
-		ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_AUDIO_PAUSE);
-	} else {
-		ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_AUDIO_PLAY);
-		if (ret == 0) {
-			/* Wait for firmware to enter PS0 power state */
-			ret = regmap_read_poll_timeout(cs35l56->regmap,
-						       CS35L56_TRANSDUCER_ACTUAL_PS,
-						       val, (val == CS35L56_PS0),
-						       CS35L56_PS0_POLL_US,
-						       CS35L56_PS0_TIMEOUT_US);
-			if (ret)
-				dev_err(cs35l56->dev, "PS0 wait failed: %d\n", ret);
-			ret = 0;
-		}
-	}
-
-	return ret;
-}
-
 static const struct snd_soc_dai_ops cs35l56_ops = {
 	.set_fmt = cs35l56_asp_dai_set_fmt,
 	.set_tdm_slot = cs35l56_asp_dai_set_tdm_slot,
 	.hw_params = cs35l56_asp_dai_hw_params,
 	.set_sysclk = cs35l56_asp_dai_set_sysclk,
-	.mute_stream = cs35l56_mute_stream,
 };
 
 static void cs35l56_sdw_dai_shutdown(struct snd_pcm_substream *substream,
@@ -749,7 +755,6 @@ static const struct snd_soc_dai_ops cs35l56_sdw_dai_ops = {
 	.shutdown = cs35l56_sdw_dai_shutdown,
 	.hw_params = cs35l56_sdw_dai_hw_params,
 	.hw_free = cs35l56_sdw_dai_hw_free,
-	.mute_stream = cs35l56_mute_stream,
 	.set_stream = cs35l56_sdw_dai_set_stream,
 };
 
-- 
2.30.2

