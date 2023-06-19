Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629E57351CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjFSKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjFSKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:17:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBAB9B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31122c346f4so3660215f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169820; x=1689761820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CabZ5vNQt3fVXdlNPDIEC+PWoUnQG/H1hmXckZrPM8=;
        b=AzTtw+9+OUva2zMO/PcC0xBcgizEGMiUVI50VujU1VYB05v5Dzq4eRlkcJ2dIYv2k+
         /1/lMRyuYR/k90XvAXTO/D3k25ZQpKbI5hn7FCRBak847FNQKM935eES7MRVL2xT79lx
         2sFr3cLMDPGm6h2cWg+NVwKTD6xhxK22ri2OzYlG0xMvaWtpkV70IqmMY0gXzkoGfWTH
         X9JkKTxDwEcuicg5w8bv4yQQ4FiZbCUsQjKrfKf/4ZCBlBloXtrZef0DQObhJTbH5EkO
         EtWMttc5hc6CJJeDgzzJrsWy9qhQJyOndYeEVO8Assi0bxvD7FrgrlO3Q27TeWFDXZx3
         si1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169820; x=1689761820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CabZ5vNQt3fVXdlNPDIEC+PWoUnQG/H1hmXckZrPM8=;
        b=esPJe2w0ogUAzvfYNbiZZBTw3XTMJfOdGyCVA/TIIK8hm1XJ2Do6uAIsw5WnooDAQn
         YxyQYRBdyYqod2VPXnffhxugVIY/d9es2l/1q+i4GFXfNjgkBOEcQu/0D25gttecw/aK
         vdg1nzYtA/0dd34XXz97mhpRPxcvWWU/q9vRJrRMkR/61AoABWbFadCdCYL2K8twVfho
         KwOE5IVkZ4lM5ozxXBba3jC+n3LRRAsLnZf5l/VQgiJu/20eb+HiweJdcZQgbqT7D9lY
         /+EqU5p1puN4L17vGt/JWcaeU6wLQiR8+v5dSHtAokMpNu6QaL3jipOcDw6pxEYk137r
         v40g==
X-Gm-Message-State: AC+VfDz1GEQ7JPwGBNELO65IWMo1v+zL419O1P58Itd3E+hHuiVVM0f1
        zdlODPNN35d8N/Fn0wrNZAP2BQ==
X-Google-Smtp-Source: ACHHUZ6KsV55NlY81gGBGHo2bEA1KQrWMXPjeGpRaR//1XJ+7ISXhnxwMCwVtTf6VOzqvIsOWMG9ww==
X-Received: by 2002:a5d:58d1:0:b0:30f:bcfd:c690 with SMTP id o17-20020a5d58d1000000b0030fbcfdc690mr8514768wrf.38.1687169820608;
        Mon, 19 Jun 2023 03:17:00 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:16:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v3 04/11] ASoC: q6dsp: audioreach: Add placeholder decoder for compress playback
Date:   Mon, 19 Jun 2023 11:16:46 +0100
Message-Id: <20230619101653.9750-5-srinivas.kandagatla@linaro.org>
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

Add placeholder decoder graph module for compressed playback feature.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c |  2 +
 sound/soc/qcom/qdsp6/audioreach.h | 14 +++++++
 sound/soc/qcom/qdsp6/q6apm.c      | 65 +++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h      |  4 ++
 4 files changed, 85 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 0acd4a75d5cd..34cbc4d05918 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -1140,6 +1140,8 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 	case MODULE_ID_PCM_DEC:
 	case MODULE_ID_PCM_ENC:
 	case MODULE_ID_PCM_CNV:
+	case MODULE_ID_PLACEHOLDER_DECODER:
+	case MODULE_ID_PLACEHOLDER_ENCODER:
 		rc = audioreach_pcm_set_media_format(graph, module, cfg);
 		break;
 	case MODULE_ID_DISPLAY_PORT_SINK:
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 18d8d243b06b..c4e03a49ac82 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -15,6 +15,8 @@ struct q6apm_graph;
 #define MODULE_ID_PCM_CNV		0x07001003
 #define MODULE_ID_PCM_ENC		0x07001004
 #define MODULE_ID_PCM_DEC		0x07001005
+#define MODULE_ID_PLACEHOLDER_ENCODER	0x07001008
+#define MODULE_ID_PLACEHOLDER_DECODER	0x07001009
 #define MODULE_ID_SAL			0x07001010
 #define MODULE_ID_MFC			0x07001015
 #define MODULE_ID_CODEC_DMA_SINK	0x07001023
@@ -22,6 +24,9 @@ struct q6apm_graph;
 #define MODULE_ID_I2S_SINK		0x0700100A
 #define MODULE_ID_I2S_SOURCE		0x0700100B
 #define MODULE_ID_DATA_LOGGING		0x0700101A
+#define MODULE_ID_AAC_DEC		0x0700101F
+#define MODULE_ID_FLAC_DEC		0x0700102F
+#define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
@@ -608,6 +613,15 @@ struct param_id_vol_ctrl_master_gain {
 } __packed;
 
 
+#define PARAM_ID_REMOVE_INITIAL_SILENCE		0x0800114B
+#define PARAM_ID_REMOVE_TRAILING_SILENCE	0x0800115D
+
+#define PARAM_ID_REAL_MODULE_ID	0x0800100B
+
+struct param_id_placeholder_real_module_id {
+	uint32_t real_module_id;
+} __packed;
+
 /* Graph */
 struct audioreach_connection {
 	/* Connections */
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index b07fee8ccac1..7bfac9492ab5 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -298,6 +298,71 @@ int q6apm_unmap_memory_regions(struct q6apm_graph *graph, unsigned int dir)
 }
 EXPORT_SYMBOL_GPL(q6apm_unmap_memory_regions);
 
+int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples)
+{
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_send_u32_param(graph, module, PARAM_ID_REMOVE_INITIAL_SILENCE, samples);
+}
+EXPORT_SYMBOL_GPL(q6apm_remove_initial_silence);
+
+int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples)
+{
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_send_u32_param(graph, module, PARAM_ID_REMOVE_TRAILING_SILENCE, samples);
+}
+EXPORT_SYMBOL_GPL(q6apm_remove_trailing_silence);
+
+int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph, bool en)
+{
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_send_u32_param(graph, module, PARAM_ID_MODULE_ENABLE, en);
+}
+EXPORT_SYMBOL_GPL(q6apm_enable_compress_module);
+
+int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph,
+			     uint32_t codec_id)
+{
+	struct audioreach_module *module;
+	uint32_t module_id;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	switch (codec_id) {
+	case SND_AUDIOCODEC_MP3:
+		module_id = MODULE_ID_MP3_DECODE;
+		break;
+	case SND_AUDIOCODEC_AAC:
+		module_id = MODULE_ID_AAC_DEC;
+		break;
+	case SND_AUDIOCODEC_FLAC:
+		module_id = MODULE_ID_FLAC_DEC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return audioreach_send_u32_param(graph, module, PARAM_ID_REAL_MODULE_ID,
+					 module_id);
+}
+EXPORT_SYMBOL_GPL(q6apm_set_real_module_id);
+
 int q6apm_graph_media_format_pcm(struct q6apm_graph *graph, struct audioreach_module_config *cfg)
 {
 	struct audioreach_graph_info *info = graph->info;
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 7005be9b63e3..87d67faf5f1a 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -147,4 +147,8 @@ int q6apm_graph_get_rx_shmem_module_iid(struct q6apm_graph *graph);
 
 bool q6apm_is_adsp_ready(void);
 
+int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph, bool en);
+int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
+int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
+int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph, uint32_t codec_id);
 #endif /* __APM_GRAPH_ */
-- 
2.21.0

