Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E37351CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjFSKRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjFSKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:17:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7010C1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so3247034f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169828; x=1689761828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jmFbS7HPXuVPo+Ttg6W++jAmeGcDWis3QnGP8fIhMU=;
        b=wy9CQ5VTjjJKyhnudYc6Tzx0GC4cGmsexR7mqUP65SLBywiqJeqPlYkCZKqkRYGmGj
         0euK9Yci70dqdesZoqJLE7SugOZ8j+XtrLvOckhbq+9HDgCnzD8gIgpaj3b6QaDG1LOl
         rZE7jRUXsNsaSyip7hcbTs28iOcLP2MHCQwCXhZdI4WbvJOAWX9kpb6/q4r/mHQwCj4G
         4Piq+qWW9ZFQT8bgNPIUxPLBbmBsCviWql/+64tHy6PcmD36aEOBESy8qK168mbm6eEM
         Lq+ofnZA+GveTZ2EyLonzWe2QvWPFYzMNey/tDyzjpioMu+8Lyst9HYnyMiSLhZlGCBL
         w1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169828; x=1689761828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jmFbS7HPXuVPo+Ttg6W++jAmeGcDWis3QnGP8fIhMU=;
        b=g8KGMnyzIZmyoAcnUrsLiUxiFG0TvTrTQRNfaKohu7pZXLJzzEuC27vfwjN6v+lzkH
         cYp3Pb1J9HWHEJ16PZ4Kit3mg2l+/gUkRkkWriQpUskpIVzJp9uO/84hRTO381lT0NrS
         Zr+PlFSNbHjMYVcCH8oQBYh/+CvbHalOdiZuqBpYD4chPUnE8Ds+xAfMn5xpjb47dqTY
         XdQi52P0HYIM8UoM8d32LAxsdUwXAiJoc4Tpz4QpXAOhgRmMBMgk94Rtqx10/3cW/x2a
         VuUXkJ3Mcak9XsAP5LbOvAbe6I4CjW/FsrGrcmEvQNkpWH7u3Mx/2dacpTupT70SvorF
         ik6Q==
X-Gm-Message-State: AC+VfDx4IHEtxiFBT3OhgL3Wu8CSgD6GA/Cbk8h4mZ51DC0nth+j4ZRY
        /V3luRmRpwyPAIZ5t/ml1pfoyg==
X-Google-Smtp-Source: ACHHUZ79GAF/rMepsxEO8EbbcqC5rfSTBEWArAY5CuoL4lXM+FTQV0Ep868fL2F2hoL5TNbq1ev8/g==
X-Received: by 2002:a5d:595a:0:b0:311:1a91:cdac with SMTP id e26-20020a5d595a000000b003111a91cdacmr7112812wri.57.1687169827878;
        Mon, 19 Jun 2023 03:17:07 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:17:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v3 10/11] ASoC: q6dsp: q6apm-dai: Add compress set params and metadata DAI callbacks
Date:   Mon, 19 Jun 2023 11:16:52 +0100
Message-Id: <20230619101653.9750-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
References: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add q6apm compress DAI callbacks for setting params and metadata to support
compress offload playback.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

