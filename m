Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF290729D82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbjFIO4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbjFIO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:56:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF453A86
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:56:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so14125075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322546; x=1688914546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDTHAoTD8UW2CusT+8oVB9TCJ1eQ8kR6GrrvgY5ydt0=;
        b=aipY2JLl8aF3VEwqPW5eGQ7DZc1TockTkm3/IVxpaQoBzqgYHuYkPghfaVRvHlNkcQ
         5PAClx7cGJ+wIxWnjs24kNPL0LxWp79O+jjB7O3eOCpE3uzYOwnwH1VO/8TgfeA8ypgY
         ve0PUnfSDnu1PcfZM4I64BeXjzC1xAZhOVOUOG0iwzqhRW52FqmS002ue8BJGpyntOj4
         vG1L6YUx1SN4zWUua5kyuKEkPbSM42kw2udX06h/gt6QM6Q9M7pZO9hWcwG7oT+iUANY
         NpQyIv307wwMxqLo6fUUqglHtHVRlOW0tXcmr0CBFp7kl+X65XLeRfQNBmNXJZWF3Xjq
         tAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322546; x=1688914546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDTHAoTD8UW2CusT+8oVB9TCJ1eQ8kR6GrrvgY5ydt0=;
        b=LHL7jIOLK4mRmta1X5w5MEge4BvFcdfXDabQpAnfiKVLdQT8UW94Q9Z6FAkTNiEvwn
         Xaz8JrosYNPj8asc2GTZUBKkqWSAxrqkik9YR97zkVegHzOiC8KY8Rb648nqpo5g/wAg
         YfgCrv/2F0RLRjCexm5I5f1TFg80E4uHw6Qfox/a0opRf6qeX551ImeHBYd9fg8O7m/3
         zQAoJEG1OIMX4iol2bhb/i9Pg7nZVQhNB9FtN5t13quL85LUcnY3zibqOMNQ/d2NbO8p
         8d7oG0DB6vyDadHSRHIvo2KdPKyrHYrxtExWrIu+25GpCBQF+Ywm7Pk6lowEwlSDNLWi
         TCMA==
X-Gm-Message-State: AC+VfDw2b4S619eBrAw2CAWO4rh9jfZZUQNussN6a/EJ4PFh8lxnVIxl
        a4/jakrO+zCVGf1JESEotO++PtH/hvVjcqkf4RA=
X-Google-Smtp-Source: ACHHUZ6ZtNL/tW7OcVMfj1SrOwMGTN210HRaFxEhXm8zNWcifVgfdkWsHwmdxU9y8d5IVMVTQqg61Q==
X-Received: by 2002:a05:600c:219a:b0:3f1:9b85:e305 with SMTP id e26-20020a05600c219a00b003f19b85e305mr1145537wme.34.1686322546589;
        Fri, 09 Jun 2023 07:55:46 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:55:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v2 10/11] ASoC: q6dsp: q6apm-dai: Add compress set params and metadata DAI callbacks
Date:   Fri,  9 Jun 2023 15:54:06 +0100
Message-Id: <20230609145407.18774-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
References: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add q6apm compress DAI callbacks for setting params and metadata to support
compress offload playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 107 +++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 9543b79ce83d..c67147e5388b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -76,6 +76,8 @@ struct q6apm_dai_rtd {
 	enum stream_state state;
 	struct q6apm_graph *graph;
 	spinlock_t lock;
+	uint32_t initial_samples_drop;
+	uint32_t trailing_samples_drop;
 	bool notify_on_drain;
 };
 
@@ -632,6 +634,109 @@ static int q6apm_dai_compr_ack(struct snd_soc_component *component, struct snd_c
 	return count;
 }
 
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
+		memcpy(&prtd->codec, codec, sizeof(*codec));
+
+		ret = q6apm_set_real_module_id(component->dev, prtd->graph, codec->id);
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
+
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
@@ -640,6 +745,8 @@ static const struct snd_compress_ops q6apm_dai_compress_ops = {
 	.pointer	= q6apm_dai_compr_pointer,
 	.trigger	= q6apm_dai_compr_trigger,
 	.ack		= q6apm_dai_compr_ack,
+	.set_params	= q6apm_dai_compr_set_params,
+	.set_metadata	= q6apm_dai_compr_set_metadata,
 };
 
 static const struct snd_soc_component_driver q6apm_fe_dai_component = {
-- 
2.21.0

