Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB55A5BAE16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiIPNZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiIPNYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:24:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9224BF7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:24:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so5355886wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=d8iWZYaJT+rnp0UvauvgX0TvZ6+8AX1ykX2N58BlPI8=;
        b=xex+n6aRK01/zOiRE/HAth4jn7hnfonSLIk3FejGaXEkLSQ+UCJFk9+8kfxCpdCfnU
         JkBH12VfVuRFhCwQlsX9kmSMt4iA6onxkYmWLrDZhzQ8vp26k8p4uGTijOcNTgzZl+8/
         /ic3ge++fPj8tm+SIugYmI1Z+zoCPVxj0lFLoa21JSgMxPO6aWQR7Iq+7bxx4iQZ1Trn
         BmdpL3q5b6umivUTO/AoFtsAJhgQ2PChG69Or7P8IEnAvOeVYJLSEYTdyrZ0Rmjpndg/
         wttof57CiHc6t0PIWeLxbC4Z+iWbacv33NoSyGGf2DD7ySO4eStyVfnP+QYOuri8W+4e
         khFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d8iWZYaJT+rnp0UvauvgX0TvZ6+8AX1ykX2N58BlPI8=;
        b=KHRyKhUNfCMwRt8B5Ftj2bfM9Pg/9NR1ybX6lmbhLysHqzfDdZRIfV7bxvvD/AsabP
         nbggCgpnA8qldAbcMCe1WGRamkOLKVx2g2zHcnUGZOaHZELOz8Wq1sWy2JJbi4ikDRvJ
         QgFHMUWueoPrdwO+8O24+iGIZa25f0Oo+CaoP74mbzr1bTi6iooi8K2LvauvTjuFJ7bl
         S7ebWmXNPxwfleAiUAxJMGQgF+RazfusC/HdrC9zXAaDSWf1ZMbTVnZa5CWcKBJTQZyO
         vuszFPrz2pI43SlXj7Mp7MYxTykDEYX/tYUTwqwUZL6CmsiUffTLdMVh2EeaEWOKYtnP
         OA2A==
X-Gm-Message-State: ACrzQf1aXv6LG+Xz3bdqjXeTY2NNF0T85RvkU24ApsjI6LGQylqZ4uZT
        X9gkg6fuOLTBruJeuY0bsAlJzA==
X-Google-Smtp-Source: AMsMyM7VG9wa/7TpDPzZX3ReblfQ8iFdEAoQBtwKlO4G3CYMe4LsafMBZ+unX3M77L7K4GzCy/8sBQ==
X-Received: by 2002:a05:600c:3b8f:b0:3b4:9cdc:dbd8 with SMTP id n15-20020a05600c3b8f00b003b49cdcdbd8mr3383786wms.148.1663334683021;
        Fri, 16 Sep 2022 06:24:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003a608d69a64sm2387061wmq.21.2022.09.16.06.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:24:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 4/5] ASoC: qcom: sm8250: move some code to common
Date:   Fri, 16 Sep 2022 14:24:26 +0100
Message-Id: <20220916132427.1845-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220916132427.1845-1-srinivas.kandagatla@linaro.org>
References: <20220916132427.1845-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8450 machine driver code can be reused across multiple Qualcomm SoCs,
At least another 2 of them for now (SM8450 and SC8250XP).

Move some of the common SoundWire stream specific code to common file
so that other drivers can use it instead of duplication.

This patch is to prepare the common driver to be able to add new SoCs support
with less dupication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/common.c | 171 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/common.h |  35 ++++++++
 sound/soc/qcom/sm8250.c | 152 ++---------------------------------
 3 files changed, 213 insertions(+), 145 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index e53ad84f8ff5..69dd3b504e20 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -3,6 +3,9 @@
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
 #include <linux/module.h>
+#include <sound/jack.h>
+#include <linux/input-event-codes.h>
+#include "qdsp6/q6afe.h"
 #include "common.h"
 
 int qcom_snd_parse_of(struct snd_soc_card *card)
@@ -177,4 +180,172 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_GPL(qcom_snd_parse_of);
 
+#if IS_ENABLED(CONFIG_SOUNDWIRE)
+int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
+			 struct sdw_stream_runtime *sruntime,
+			 bool *stream_prepared)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	int ret;
+
+	if (!sruntime)
+		return 0;
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+	case RX_CODEC_DMA_RX_0:
+	case RX_CODEC_DMA_RX_1:
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+		break;
+	default:
+		return 0;
+	}
+
+	if (*stream_prepared) {
+		sdw_disable_stream(sruntime);
+		sdw_deprepare_stream(sruntime);
+		*stream_prepared = false;
+	}
+
+	ret = sdw_prepare_stream(sruntime);
+	if (ret)
+		return ret;
+
+	/**
+	 * NOTE: there is a strict hw requirement about the ordering of port
+	 * enables and actual WSA881x PA enable. PA enable should only happen
+	 * after soundwire ports are enabled if not DC on the line is
+	 * accumulated resulting in Click/Pop Noise
+	 * PA enable/mute are handled as part of codec DAPM and digital mute.
+	 */
+
+	ret = sdw_enable_stream(sruntime);
+	if (ret) {
+		sdw_deprepare_stream(sruntime);
+		return ret;
+	}
+	*stream_prepared  = true;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_sdw_prepare);
+
+int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct sdw_stream_runtime **psruntime)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sdw_stream_runtime *sruntime;
+	int i;
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case RX_CODEC_DMA_RX_0:
+	case RX_CODEC_DMA_RX_1:
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+		for_each_rtd_codec_dais(rtd, i, codec_dai) {
+			sruntime = snd_soc_dai_get_stream(codec_dai, substream->stream);
+			if (sruntime != ERR_PTR(-ENOTSUPP))
+				*psruntime = sruntime;
+		}
+		break;
+	}
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_params);
+
+int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
+			 struct sdw_stream_runtime *sruntime, bool *stream_prepared)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+	case RX_CODEC_DMA_RX_0:
+	case RX_CODEC_DMA_RX_1:
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+		if (sruntime && *stream_prepared) {
+			sdw_disable_stream(sruntime);
+			sdw_deprepare_stream(sruntime);
+			*stream_prepared = false;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_free);
+#endif
+
+int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_soc_jack *jack, bool *jack_setup)
+{
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_card *card = rtd->card;
+	int rval, i;
+
+	if (!*jack_setup) {
+		rval = snd_soc_card_jack_new(card, "Headset Jack",
+					     SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					     SND_JACK_MECHANICAL |
+					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+					     SND_JACK_BTN_4 | SND_JACK_BTN_5,
+					     jack);
+
+		if (rval < 0) {
+			dev_err(card->dev, "Unable to add Headphone Jack\n");
+			return rval;
+		}
+
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+		*jack_setup = true;
+	}
+
+	switch (cpu_dai->id) {
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+		for_each_rtd_codec_dais(rtd, i, codec_dai) {
+			rval = snd_soc_component_set_jack(codec_dai->component,
+							  jack, NULL);
+			if (rval != 0 && rval != -ENOTSUPP) {
+				dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+				return rval;
+			}
+		}
+
+		break;
+	default:
+		break;
+	}
+
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_wcd_jack_setup);
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
index f05c05b12bd7..c5472a642de0 100644
--- a/sound/soc/qcom/common.h
+++ b/sound/soc/qcom/common.h
@@ -5,7 +5,42 @@
 #define __QCOM_SND_COMMON_H__
 
 #include <sound/soc.h>
+#include <linux/soundwire/sdw.h>
 
 int qcom_snd_parse_of(struct snd_soc_card *card);
+int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_soc_jack *jack, bool *jack_setup);
 
+#if IS_ENABLED(CONFIG_SOUNDWIRE)
+int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
+			 struct sdw_stream_runtime *runtime,
+			 bool *stream_prepared);
+int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct sdw_stream_runtime **psruntime);
+int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
+			 struct sdw_stream_runtime *sruntime,
+			 bool *stream_prepared);
+#else
+static inline int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
+				       struct sdw_stream_runtime *runtime,
+				       bool *stream_prepared)
+{
+	return -ENOTSUPP;
+}
+
+static inline int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
+					 struct snd_pcm_hw_params *params,
+					 struct sdw_stream_runtime **psruntime)
+{
+	return -ENOTSUPP;
+}
+
+static inline int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
+				       struct sdw_stream_runtime *sruntime,
+				       bool *stream_prepared)
+{
+	return -ENOTSUPP;
+}
+#endif
 #endif
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 98a2fde9e004..8dbe9ef41b1c 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -27,57 +27,8 @@ struct sm8250_snd_data {
 static int sm8250_snd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	struct snd_soc_card *card = rtd->card;
-	int rval, i;
-
-	if (!data->jack_setup) {
-		struct snd_jack *jack;
-
-		rval = snd_soc_card_jack_new(card, "Headset Jack",
-					     SND_JACK_HEADSET | SND_JACK_LINEOUT |
-					     SND_JACK_MECHANICAL |
-					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
-					     SND_JACK_BTN_4 | SND_JACK_BTN_5,
-					     &data->jack);
-
-		if (rval < 0) {
-			dev_err(card->dev, "Unable to add Headphone Jack\n");
-			return rval;
-		}
-
-		jack = data->jack.jack;
-
-		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_MEDIA);
-		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
-		data->jack_setup = true;
-	}
-
-	switch (cpu_dai->id) {
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		for_each_rtd_codec_dais(rtd, i, codec_dai) {
-			rval = snd_soc_component_set_jack(codec_dai->component,
-							  &data->jack, NULL);
-			if (rval != 0 && rval != -ENOTSUPP) {
-				dev_warn(card->dev, "Failed to set jack: %d\n", rval);
-				return rval;
-			}
-		}
-
-		break;
-	default:
-		break;
-	}
 
-
-	return 0;
+	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
 
 static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -121,92 +72,21 @@ static int sm8250_snd_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct sm8250_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime;
-	int i;
-
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		for_each_rtd_codec_dais(rtd, i, codec_dai) {
-			sruntime = snd_soc_dai_get_stream(codec_dai,
-							  substream->stream);
-			if (sruntime != ERR_PTR(-ENOTSUPP))
-				pdata->sruntime[cpu_dai->id] = sruntime;
-		}
-		break;
-	}
-
-	return 0;
 
+	return qcom_snd_sdw_hw_params(substream, params, &pdata->sruntime[cpu_dai->id]);
 }
 
-static int sm8250_snd_wsa_dma_prepare(struct snd_pcm_substream *substream)
+static int sm8250_snd_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
-	int ret;
-
-	if (!sruntime)
-		return 0;
 
-	if (data->stream_prepared[cpu_dai->id]) {
-		sdw_disable_stream(sruntime);
-		sdw_deprepare_stream(sruntime);
-		data->stream_prepared[cpu_dai->id] = false;
-	}
-
-	ret = sdw_prepare_stream(sruntime);
-	if (ret)
-		return ret;
-
-	/**
-	 * NOTE: there is a strict hw requirement about the ordering of port
-	 * enables and actual WSA881x PA enable. PA enable should only happen
-	 * after soundwire ports are enabled if not DC on the line is
-	 * accumulated resulting in Click/Pop Noise
-	 * PA enable/mute are handled as part of codec DAPM and digital mute.
-	 */
-
-	ret = sdw_enable_stream(sruntime);
-	if (ret) {
-		sdw_deprepare_stream(sruntime);
-		return ret;
-	}
-	data->stream_prepared[cpu_dai->id]  = true;
-
-	return ret;
-}
-
-static int sm8250_snd_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case WSA_CODEC_DMA_RX_1:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		return sm8250_snd_wsa_dma_prepare(substream);
-	default:
-		break;
-	}
-
-	return 0;
+	return qcom_snd_sdw_prepare(substream, sruntime,
+				    &data->stream_prepared[cpu_dai->id]);
 }
 
 static int sm8250_snd_hw_free(struct snd_pcm_substream *substream)
@@ -216,26 +96,8 @@ static int sm8250_snd_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
 
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case WSA_CODEC_DMA_RX_1:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		if (sruntime && data->stream_prepared[cpu_dai->id]) {
-			sdw_disable_stream(sruntime);
-			sdw_deprepare_stream(sruntime);
-			data->stream_prepared[cpu_dai->id] = false;
-		}
-		break;
-	default:
-		break;
-	}
-
-	return 0;
+	return qcom_snd_sdw_hw_free(substream, sruntime,
+				    &data->stream_prepared[cpu_dai->id]);
 }
 
 static const struct snd_soc_ops sm8250_be_ops = {
-- 
2.21.0

