Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68637351C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjFSKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFSKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:17:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451E113D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3110a5f2832so3191624f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169821; x=1689761821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYs30udEL8nhpF3tCDr6b0n4CbAIdCAeMZJMw59Oucc=;
        b=s5rAk5fL+527HFVNAUOWsp4wnKx2MX4c5Ul3TFnLxc2r6hC5E7Suq4kRZ3BkXk7D7M
         4YqEHVF7V3hIZEPybDue4dVIWh1Z/bPtVCMIwx0a01MUnhW4SBE3POPkfTrsJKxUN1K5
         eQAewL53ELoqd/vJ5FbJz3KDRdEGCRc2hwxXHY+EnM4/8DMzWqUzV3yns/QAbb7w2vrH
         8B+w9gImVo8ecwTqyxwuJ+7rMnQln+YBBlzz8ACN9hioq01NI0yGV8vK++nEu83mT2nv
         JXIHaLezqLjr5Vx7/DX6GwBit2pVg8XeM3DIxXWucZRJCpB7jYi2eue1QC30UJ6uQ5YG
         vZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169821; x=1689761821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYs30udEL8nhpF3tCDr6b0n4CbAIdCAeMZJMw59Oucc=;
        b=Lo+fdVY+fHxk7I2Zs5cF1hVVUE6kitGlpPS7jOvy89TfThjsFszbGzUj74QRcKkBBo
         VDVkBYfycLZvqz3zm1ZVQPPTVMkDebe9R1hwL2ocrGP8sOQCkdP0HXzZcVNoSaOJC7Ub
         RDjIcHf9UnCAcV13pAt+WmaO15ITL40DQnuP1c7uvxMPzILaI0SwvciAtVrBoBJde+hS
         eE4mQbNOkamdkPvoDGuGlXThMGU+K4eyQNVdpKK+43VIbIqJs/Tr98yQ1EIXHRV4XW9S
         256wmDGgTnD2Sy0pOvehep/VMoqtvTuFlxN7YIMLmztR2wXHrhi2SH2q3a/hN7ps4j1T
         Q8Qg==
X-Gm-Message-State: AC+VfDw2g6pxXjknnMCQMy66JXXiFWkPTZ8ipMWhCB1WP8IMMADNm4RM
        BfhGWf4IrpSZZ1OEpespisl9kw==
X-Google-Smtp-Source: ACHHUZ5nlFKBSPgL2hxULeGcw8a0m8INaIQY81kSCHA7LcAiEOx0bFvbB+1yAnBnYTWsi0BaY1MqlA==
X-Received: by 2002:adf:f1c5:0:b0:307:7959:6461 with SMTP id z5-20020adff1c5000000b0030779596461mr8136462wro.31.1687169821671;
        Mon, 19 Jun 2023 03:17:01 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:17:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 05/11] ASoC: q6dsp: audioreach: Add support to set compress format params
Date:   Mon, 19 Jun 2023 11:16:47 +0100
Message-Id: <20230619101653.9750-6-srinivas.kandagatla@linaro.org>
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

From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

Add function for setting compress params.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 139 ++++++++++++++++++++++++++----
 sound/soc/qcom/qdsp6/audioreach.h |  28 ++++++
 sound/soc/qcom/qdsp6/q6apm-dai.c  |   1 +
 3 files changed, 149 insertions(+), 19 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 34cbc4d05918..ba262408b27a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -834,6 +834,99 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	return rc;
 }
 
+static int audioreach_set_compr_media_format(struct media_format *media_fmt_hdr,
+					     void *p, struct audioreach_module_config *mcfg)
+{
+	struct payload_media_fmt_aac_t *aac_cfg;
+	struct payload_media_fmt_pcm *mp3_cfg;
+	struct payload_media_fmt_flac_t *flac_cfg;
+
+	switch (mcfg->fmt) {
+	case SND_AUDIOCODEC_MP3:
+		media_fmt_hdr->data_format = DATA_FORMAT_RAW_COMPRESSED;
+		media_fmt_hdr->fmt_id = MEDIA_FMT_ID_MP3;
+		media_fmt_hdr->payload_size = 0;
+		p = p + sizeof(*media_fmt_hdr);
+		mp3_cfg = p;
+		mp3_cfg->sample_rate = mcfg->sample_rate;
+		mp3_cfg->bit_width = mcfg->bit_width;
+		mp3_cfg->alignment = PCM_LSB_ALIGNED;
+		mp3_cfg->bits_per_sample = mcfg->bit_width;
+		mp3_cfg->q_factor = mcfg->bit_width - 1;
+		mp3_cfg->endianness = PCM_LITTLE_ENDIAN;
+		mp3_cfg->num_channels = mcfg->num_channels;
+
+		if (mcfg->num_channels == 1) {
+			mp3_cfg->channel_mapping[0] =  PCM_CHANNEL_L;
+		} else if (mcfg->num_channels == 2) {
+			mp3_cfg->channel_mapping[0] =  PCM_CHANNEL_L;
+			mp3_cfg->channel_mapping[1] =  PCM_CHANNEL_R;
+		}
+		break;
+	case SND_AUDIOCODEC_AAC:
+		media_fmt_hdr->data_format = DATA_FORMAT_RAW_COMPRESSED;
+		media_fmt_hdr->fmt_id = MEDIA_FMT_ID_AAC;
+		media_fmt_hdr->payload_size = sizeof(struct payload_media_fmt_aac_t);
+		p = p + sizeof(*media_fmt_hdr);
+		aac_cfg = p;
+		aac_cfg->aac_fmt_flag = 0;
+		aac_cfg->audio_obj_type = 5;
+		aac_cfg->num_channels = mcfg->num_channels;
+		aac_cfg->total_size_of_PCE_bits = 0;
+		aac_cfg->sample_rate = mcfg->sample_rate;
+		break;
+	case SND_AUDIOCODEC_FLAC:
+		media_fmt_hdr->data_format = DATA_FORMAT_RAW_COMPRESSED;
+		media_fmt_hdr->fmt_id = MEDIA_FMT_ID_FLAC;
+		media_fmt_hdr->payload_size = sizeof(struct payload_media_fmt_flac_t);
+		p = p + sizeof(*media_fmt_hdr);
+		flac_cfg = p;
+		flac_cfg->sample_size = mcfg->codec.options.flac_d.sample_size;
+		flac_cfg->num_channels = mcfg->num_channels;
+		flac_cfg->min_blk_size = mcfg->codec.options.flac_d.min_blk_size;
+		flac_cfg->max_blk_size = mcfg->codec.options.flac_d.max_blk_size;
+		flac_cfg->sample_rate = mcfg->sample_rate;
+		flac_cfg->min_frame_size = mcfg->codec.options.flac_d.min_frame_size;
+		flac_cfg->max_frame_size = mcfg->codec.options.flac_d.max_frame_size;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int audioreach_compr_set_param(struct q6apm_graph *graph, struct audioreach_module_config *mcfg)
+{
+	struct media_format *header;
+	struct gpr_pkt *pkt;
+	int iid, payload_size, rc;
+	void *p;
+
+	payload_size = sizeof(struct apm_sh_module_media_fmt_cmd);
+
+	iid = q6apm_graph_get_rx_shmem_module_iid(graph);
+	pkt = audioreach_alloc_cmd_pkt(payload_size, DATA_CMD_WR_SH_MEM_EP_MEDIA_FORMAT,
+			0, graph->port->id, iid);
+
+	if (IS_ERR(pkt))
+		return -ENOMEM;
+
+	p = (void *)pkt + GPR_HDR_SIZE;
+	header = p;
+	rc = audioreach_set_compr_media_format(header, p, mcfg);
+	if (rc) {
+		kfree(pkt);
+		return rc;
+	}
+
+	rc = gpr_send_port_pkt(graph->port, pkt);
+	kfree(pkt);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(audioreach_compr_set_param);
+
 static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 					   struct audioreach_module *module,
 					   struct audioreach_module_config *cfg)
@@ -1037,25 +1130,33 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 	p = p + APM_MODULE_PARAM_DATA_SIZE;
 
 	header = p;
-	header->data_format = DATA_FORMAT_FIXED_POINT;
-	header->fmt_id = MEDIA_FMT_ID_PCM;
-	header->payload_size = payload_size - sizeof(*header);
-
-	p = p + sizeof(*header);
-	cfg = p;
-	cfg->sample_rate = mcfg->sample_rate;
-	cfg->bit_width = mcfg->bit_width;
-	cfg->alignment = PCM_LSB_ALIGNED;
-	cfg->bits_per_sample = mcfg->bit_width;
-	cfg->q_factor = mcfg->bit_width - 1;
-	cfg->endianness = PCM_LITTLE_ENDIAN;
-	cfg->num_channels = mcfg->num_channels;
-
-	if (mcfg->num_channels == 1) {
-		cfg->channel_mapping[0] =  PCM_CHANNEL_L;
-	} else if (num_channels == 2) {
-		cfg->channel_mapping[0] =  PCM_CHANNEL_L;
-		cfg->channel_mapping[1] =  PCM_CHANNEL_R;
+	if (mcfg->fmt == SND_AUDIOCODEC_PCM) {
+		header->data_format = DATA_FORMAT_FIXED_POINT;
+		header->fmt_id =  MEDIA_FMT_ID_PCM;
+		header->payload_size = payload_size - sizeof(*header);
+
+		p = p + sizeof(*header);
+		cfg = p;
+		cfg->sample_rate = mcfg->sample_rate;
+		cfg->bit_width = mcfg->bit_width;
+		cfg->alignment = PCM_LSB_ALIGNED;
+		cfg->bits_per_sample = mcfg->bit_width;
+		cfg->q_factor = mcfg->bit_width - 1;
+		cfg->endianness = PCM_LITTLE_ENDIAN;
+		cfg->num_channels = mcfg->num_channels;
+
+		if (mcfg->num_channels == 1)
+			cfg->channel_mapping[0] =  PCM_CHANNEL_L;
+		else if (num_channels == 2) {
+			cfg->channel_mapping[0] =  PCM_CHANNEL_L;
+			cfg->channel_mapping[1] =  PCM_CHANNEL_R;
+		}
+	} else {
+		rc = audioreach_set_compr_media_format(header, p, mcfg);
+		if (rc) {
+			kfree(pkt);
+			return rc;
+		}
 	}
 
 	rc = audioreach_graph_send_cmd_sync(graph, pkt, 0);
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index c4e03a49ac82..dc089879b501 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -148,12 +148,15 @@ struct param_id_enc_bitrate_param {
 } __packed;
 
 #define DATA_FORMAT_FIXED_POINT		1
+#define DATA_FORMAT_GENERIC_COMPRESSED	5
+#define DATA_FORMAT_RAW_COMPRESSED	6
 #define PCM_LSB_ALIGNED			1
 #define PCM_MSB_ALIGNED			2
 #define PCM_LITTLE_ENDIAN		1
 #define PCM_BIT_ENDIAN			2
 
 #define MEDIA_FMT_ID_PCM	0x09001000
+#define MEDIA_FMT_ID_MP3	0x09001009
 #define PCM_CHANNEL_L		1
 #define PCM_CHANNEL_R		2
 #define SAMPLE_RATE_48K		48000
@@ -231,6 +234,28 @@ struct apm_media_format {
 	uint32_t payload_size;
 } __packed;
 
+#define MEDIA_FMT_ID_FLAC	0x09001004
+
+struct payload_media_fmt_flac_t {
+	uint16_t num_channels;
+	uint16_t sample_size;
+	uint16_t min_blk_size;
+	uint16_t max_blk_size;
+	uint32_t sample_rate;
+	uint32_t min_frame_size;
+	uint32_t max_frame_size;
+} __packed;
+
+#define MEDIA_FMT_ID_AAC	0x09001001
+
+struct payload_media_fmt_aac_t {
+	uint16_t aac_fmt_flag;
+	uint16_t audio_obj_type;
+	uint16_t num_channels;
+	uint16_t total_size_of_PCE_bits;
+	uint32_t sample_rate;
+} __packed;
+
 #define DATA_CMD_WR_SH_MEM_EP_EOS			0x04001002
 #define WR_SH_MEM_EP_EOS_POLICY_LAST	1
 #define WR_SH_MEM_EP_EOS_POLICY_EACH	2
@@ -730,6 +755,7 @@ struct audioreach_module_config {
 	u32	channel_allocation;
 	u32	sd_line_mask;
 	int	fmt;
+	struct snd_codec codec;
 	u8 channel_map[AR_PCM_MAX_NUM_CHANNEL];
 };
 
@@ -768,4 +794,6 @@ int audioreach_gain_set_vol_ctrl(struct q6apm *apm,
 				 struct audioreach_module *module, int vol);
 int audioreach_send_u32_param(struct q6apm_graph *graph, struct audioreach_module *module,
 			      uint32_t param_id, uint32_t param_val);
+int audioreach_compr_set_param(struct q6apm_graph *graph, struct audioreach_module_config *mcfg);
+
 #endif /* __AUDIOREACH_H__ */
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 7f02f5b2c33f..9fff41ee98eb 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -155,6 +155,7 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	cfg.sample_rate = runtime->rate;
 	cfg.num_channels = runtime->channels;
 	cfg.bit_width = prtd->bits_per_sample;
+	cfg.fmt = SND_AUDIOCODEC_PCM;
 
 	if (prtd->state) {
 		/* clear the previous setup if any  */
-- 
2.21.0

