Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5F68679F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBANxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjBANwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:52:37 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EFE67792;
        Wed,  1 Feb 2023 05:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259552; x=1706795552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2RURDEC1UN20Ygm3K2nfRO2TrLKPWktoWePre5C3KU=;
  b=DxG/Sn+qbFrgGfbh2uZ2fRybhoa27XIhTOJKT/qcM8tulTSRphcVIRgL
   TAvNwdzxxkLo5ePs7CNcZvHweMvQ0iAuD4dFH6Ve+bBo6VvSMyuR9bSOC
   Mw8V4pKG2gHTrtoiX6JpMBYSPT0R0Y7iuoV0ax98QCnP8N8FWkjmb92bk
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:52:31 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:52:31 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:52:25 -0800
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
Subject: [PATCH 11/14] ASoC: q6dsp: q6apm-dai: Add compress set params and metadata DAI callbacks
Date:   Wed, 1 Feb 2023 19:19:44 +0530
Message-ID: <20230201134947.1638197-12-quic_mohs@quicinc.com>
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

Add q6apm compress DAI callbacks for setting params and metadata to support
compress offload playback.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 121 +++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index f43b60742e2f..8ee14822362b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -621,6 +621,125 @@ int q6apm_dai_compr_ack(struct snd_soc_component *component, struct snd_compr_st
 	return count;
 }
 
+static int __q6apm_dai_compr_set_codec_params(struct snd_soc_component *component,
+					      struct snd_compr_stream *stream,
+					      struct snd_codec *codec,
+					      int stream_id)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	struct device *dev = component->dev;
+	union snd_codec_options *codec_options;
+
+	codec_options = &(prtd->codec.options);
+
+	memcpy(&prtd->codec, codec, sizeof(*codec));
+	q6apm_set_real_module_id(dev, prtd->graph, codec->id);
+
+	return 0;
+}
+
+static int q6apm_dai_compr_set_params(struct snd_soc_component *component,
+				      struct snd_compr_stream *stream,
+				      struct snd_compr_params *params)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	struct q6apm_dai_data *pdata;
+	struct audioreach_module_config cfg;
+	struct snd_codec *codec = &params->codec;
+	int dir = stream->direction;
+	int ret;
+
+	pdata = snd_soc_component_get_drvdata(component);
+	if (!pdata)
+		return -EINVAL;
+
+	prtd->periods = runtime->fragments;
+	prtd->pcm_count = runtime->fragment_size;
+	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
+	prtd->bits_per_sample = 16;
+
+	prtd->pos = 0;
+
+	if (prtd->next_track != true) {
+		ret = __q6apm_dai_compr_set_codec_params(component, stream,
+				&params->codec, 0);
+		if (ret)
+			return ret;
+
+		cfg.direction = dir;
+		cfg.sample_rate = codec->sample_rate;
+		cfg.num_channels = 2;
+		cfg.bit_width = prtd->bits_per_sample;
+		cfg.fmt = codec->id;
+		memcpy(&cfg.codec, codec, sizeof(*codec));
+
+		ret = q6apm_graph_media_format_shmem(prtd->graph, &cfg);
+		if (ret < 0)
+			return ret;
+
+		ret = q6apm_graph_media_format_pcm(prtd->graph, &cfg);
+		if (ret)
+			return ret;
+
+		ret = q6apm_map_memory_regions(prtd->graph, SNDRV_PCM_STREAM_PLAYBACK,
+					       prtd->phys, (prtd->pcm_size / prtd->periods),
+					       prtd->periods);
+		if (ret < 0)
+			return -ENOMEM;
+
+		ret = q6apm_graph_prepare(prtd->graph);
+		if (ret)
+			return ret;
+		ret = q6apm_graph_start(prtd->graph);
+		if (ret)
+			return ret;
+
+	} else {
+		cfg.direction = dir;
+		cfg.sample_rate = codec->sample_rate;
+		cfg.num_channels = 2;
+		cfg.bit_width = prtd->bits_per_sample;
+		cfg.fmt = codec->id;
+		memcpy(&cfg.codec, codec, sizeof(*codec));
+
+		ret = audioreach_compr_set_param(prtd->graph,  &cfg);
+		if (ret < 0)
+			return ret;
+	}
+	prtd->state = Q6APM_STREAM_RUNNING;
+
+	return 0;
+}
+
+static int q6apm_dai_compr_set_metadata(struct snd_soc_component *component,
+					struct snd_compr_stream *stream,
+					struct snd_compr_metadata *metadata)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	int ret = 0;
+
+	switch (metadata->key) {
+	case SNDRV_COMPRESS_ENCODER_PADDING:
+		prtd->trailing_samples_drop = metadata->value[0];
+		q6apm_remove_trailing_silence(component->dev, prtd->graph,
+					      prtd->trailing_samples_drop);
+		break;
+	case SNDRV_COMPRESS_ENCODER_DELAY:
+		prtd->initial_samples_drop = metadata->value[0];
+		q6apm_remove_initial_silence(component->dev, prtd->graph,
+					     prtd->initial_samples_drop);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static const struct snd_compress_ops q6apm_dai_compress_ops = {
 	.open		= q6apm_dai_compr_open,
 	.free		= q6apm_dai_compr_free,
@@ -629,6 +748,8 @@ static const struct snd_compress_ops q6apm_dai_compress_ops = {
 	.pointer	= q6apm_dai_compr_pointer,
 	.trigger	= q6apm_dai_compr_trigger,
 	.ack		= q6apm_dai_compr_ack,
+	.set_params	= q6apm_dai_compr_set_params,
+	.set_metadata	= q6apm_dai_compr_set_metadata,
 };
 
 static const struct snd_soc_component_driver q6apm_fe_dai_component = {
-- 
2.25.1

