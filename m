Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27D568679D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjBANxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjBANwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:52:31 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6584166ECF;
        Wed,  1 Feb 2023 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259546; x=1706795546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fx8eUSWeP9jdx2AoQEHNg/mpJumHcAAPsJfotX19Rso=;
  b=IOodKrHBMsstESZoK5YD9VhHaH5Z0dVzqGDUvkotl9Mga9arBT4X5Gxu
   +G6wVLGQpDmClIsruwEOC5DbTzPViE+fs88SBqhIZTRblykWJzgAyJClI
   vRcSsG/JQJYj6q1+zYDKgLncrml2sBpxg5ezraLufyqpEcFVv/2iypQig
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:52:26 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:52:25 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:52:20 -0800
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
Subject: [PATCH 10/14] ASoC: q6dsp: q6apm-dai: Add trigger/pointer compress DAI callbacks
Date:   Wed, 1 Feb 2023 19:19:43 +0530
Message-ID: <20230201134947.1638197-11-quic_mohs@quicinc.com>
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

Add q6apm trigger and pointer compress DAI callbacks to support
compress offload playback.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 68 ++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h     |  1 +
 2 files changed, 69 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 54e1aca61e4c..f43b60742e2f 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -556,11 +556,79 @@ static int q6apm_dai_compr_get_codec_caps(struct snd_soc_component *component,
 
 	return 0;
 }
+
+static int q6apm_dai_compr_pointer(struct snd_soc_component *component,
+				   struct snd_compr_stream *stream,
+				   struct snd_compr_tstamp *tstamp)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+	tstamp->copied_total = prtd->copied_total;
+	tstamp->byte_offset = prtd->copied_total % prtd->pcm_size;
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return 0;
+}
+
+int q6apm_dai_compr_trigger(struct snd_soc_component *component,
+			    struct snd_compr_stream *stream, int cmd)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = q6apm_write_async_compr(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+	case SND_COMPR_TRIGGER_NEXT_TRACK:
+		prtd->next_track = true;
+		prtd->next_track_stream_id = (prtd->graph->id == 1 ? 2 : 1);
+		break;
+	case SND_COMPR_TRIGGER_DRAIN:
+	case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
+		prtd->notify_on_drain = true;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int q6apm_dai_compr_ack(struct snd_soc_component *component, struct snd_compr_stream *stream,
+			size_t count)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+	prtd->bytes_received += count;
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return count;
+}
+
 static const struct snd_compress_ops q6apm_dai_compress_ops = {
 	.open		= q6apm_dai_compr_open,
 	.free		= q6apm_dai_compr_free,
 	.get_caps	= q6apm_dai_compr_get_caps,
 	.get_codec_caps	= q6apm_dai_compr_get_codec_caps,
+	.pointer	= q6apm_dai_compr_pointer,
+	.trigger	= q6apm_dai_compr_trigger,
+	.ack		= q6apm_dai_compr_ack,
 };
 
 static const struct snd_soc_component_driver q6apm_fe_dai_component = {
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 630c2bca0f06..e0247e6e4fd2 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -46,6 +46,7 @@
 
 #define APM_MAX_SESSIONS			8
 #define APM_LAST_BUFFER_FLAG			BIT(30)
+#define NO_TIMESTAMP				0xFF00
 
 struct q6apm {
 	struct device *dev;
-- 
2.25.1

