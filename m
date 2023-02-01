Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA2686798
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBANxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjBANw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:52:26 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF5965350;
        Wed,  1 Feb 2023 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259540; x=1706795540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJD/2fCmODYcH9KoF3x+TewQn5VG9fepk8yXNyFelww=;
  b=bG+C0MUE27/sNA4zQq/bku5xZPD9h9S6x2giowdpgHfbr6/nrUjlOp8y
   EpCI9oYF0CziJ1DF6xP5xKyO40jFIAwAiY/qacOdS2Q5+bfstlq9JKkAd
   C7fp1to7MWosL3GnTerxfPL4ZP19lyAtdk5FkhJLhbMd9R+6xRHHq5Y4h
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:52:20 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:52:20 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:52:14 -0800
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH 09/14] ASoC: q6dsp: q6apm-dai: Add compress DAI and codec caps get callbacks
Date:   Wed, 1 Feb 2023 19:19:42 +0530
Message-ID: <20230201134947.1638197-10-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201134947.1638197-1-quic_mohs@quicinc.com>
References: <20230201134947.1638197-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add q6apm get compress DAI capabilities and codec capabilities callbacks
to support compress offload playback.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index fd134c268189..54e1aca61e4c 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -29,8 +29,25 @@
 #define BUFFER_BYTES_MIN (PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE)
 #define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
 #define COMPR_PLAYBACK_MAX_NUM_FRAGMENTS (16 * 4)
+#define COMPR_PLAYBACK_MIN_FRAGMENT_SIZE (8 * 1024)
+#define COMPR_PLAYBACK_MIN_NUM_FRAGMENTS (4)
 #define SID_MASK_DEFAULT	0xF
 
+static const struct snd_compr_codec_caps q6apm_compr_caps = {
+	.num_descriptors = 1,
+	.descriptor[0].max_ch = 2,
+	.descriptor[0].sample_rates = {	8000, 11025, 12000, 16000, 22050,
+					24000, 32000, 44100, 48000, 88200,
+					96000, 176400, 192000 },
+	.descriptor[0].num_sample_rates = 13,
+	.descriptor[0].bit_rate[0] = 320,
+	.descriptor[0].bit_rate[1] = 128,
+	.descriptor[0].num_bitrates = 2,
+	.descriptor[0].profiles = 0,
+	.descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO,
+	.descriptor[0].formats = 0,
+};
+
 enum stream_state {
 	Q6APM_STREAM_IDLE = 0,
 	Q6APM_STREAM_STOPPED,
@@ -507,9 +524,43 @@ static int q6apm_dai_compr_free(struct snd_soc_component *component,
 
 	return 0;
 }
+
+static int q6apm_dai_compr_get_caps(struct snd_soc_component *component,
+				    struct snd_compr_stream *stream,
+				    struct snd_compr_caps *caps)
+{
+	caps->direction = SND_COMPRESS_PLAYBACK;
+	caps->min_fragment_size = COMPR_PLAYBACK_MIN_FRAGMENT_SIZE;
+	caps->max_fragment_size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE;
+	caps->min_fragments = COMPR_PLAYBACK_MIN_NUM_FRAGMENTS;
+	caps->max_fragments = COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
+	caps->num_codecs = 3;
+	caps->codecs[0] = SND_AUDIOCODEC_MP3;
+	caps->codecs[1] = SND_AUDIOCODEC_AAC;
+	caps->codecs[2] = SND_AUDIOCODEC_FLAC;
+
+	return 0;
+}
+
+static int q6apm_dai_compr_get_codec_caps(struct snd_soc_component *component,
+					  struct snd_compr_stream *stream,
+					  struct snd_compr_codec_caps *codec)
+{
+	switch (codec->codec) {
+	case SND_AUDIOCODEC_MP3:
+		*codec = q6apm_compr_caps;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
 static const struct snd_compress_ops q6apm_dai_compress_ops = {
 	.open		= q6apm_dai_compr_open,
 	.free		= q6apm_dai_compr_free,
+	.get_caps	= q6apm_dai_compr_get_caps,
+	.get_codec_caps	= q6apm_dai_compr_get_codec_caps,
 };
 
 static const struct snd_soc_component_driver q6apm_fe_dai_component = {
-- 
2.25.1

