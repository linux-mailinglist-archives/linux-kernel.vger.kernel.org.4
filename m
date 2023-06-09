Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B229A729D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbjFIOyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbjFIOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:54:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569FA3A80
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:54:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso2414997e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322466; x=1688914466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BtEBe2KiptIwTf8OQC3A599yqS9fPvPypfh6VxvoyE=;
        b=BwMDi6ucjw7EI9vmSDPSly0MyfJynfVsfquS5N/1+eXdBT9lxlub2WxQaChzZ6Zalf
         a4d1BHgOBD0LKxR8H5VAft8j18rvi8a7odq6I7ybEjANYsJgnD/A4eRN8Cra/3ho+YBa
         T4/VzDyM7t5exFA0fR5cXTArHIZJjocNUhneCyHy6bpWFBcX25d7NFLN7q06ky14vKGT
         f1cM5Z+4do+wlw826xymWNp1aiGGEeL7M2j1domlnxXwh61Vt5a2zyWRyigad6JwasN1
         t3tE900VgWWIPLgd9pJKUF1qFiVGntyhPK1bR9NWxEXVHML7bZo3uKEOB5Q4hQF2YbGU
         sG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322466; x=1688914466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BtEBe2KiptIwTf8OQC3A599yqS9fPvPypfh6VxvoyE=;
        b=lojO5qTS8BKZux6BuESAxPKXd8eiMwuSt83S5fpWzjswNq6XWXs9odDvINfN5cC5Mc
         nPihYwb0QA+vCglDFFYgLuOtL/ERqzLGQJun9O71c2ei/H6ghSgzKRFhE2hSk6yii/I8
         J+JJC1wxOQ/jGuhfQHoyIpd4/inCc8XIkEWT4CUkBJUU1tYgKKVw/O5YTGyByInF8Aa5
         ZKo+Yew4vy70McXV7WWcB3bjAVcal9PLPyb4pSkb6fN/OPTMRLoFxyaxNTL/QW4rEWV7
         4tw7Q+5ntuCXB5LJdaEagaQ9BUsh5EfiMDDLtsZr3BngIg+2LwXXIhd3vO4B3dL1Qj4e
         VfAQ==
X-Gm-Message-State: AC+VfDyKIGIB2iV5NHfjP16bEytX8NC8JwZSeJ6+VDSw7mOXglj1fAXO
        9jj0f2Gw5ofusI/xEWfhpSidMw==
X-Google-Smtp-Source: ACHHUZ5xAWwhl1lYGznngZ2YV3gAxOGrpQF8T5BCtHwbZZN+DOxnsvCsL1MRjJd9p4IQcYzOrAGr8A==
X-Received: by 2002:a05:6512:328c:b0:4f2:53ab:8a2d with SMTP id p12-20020a056512328c00b004f253ab8a2dmr1157879lfe.4.1686322466679;
        Fri, 09 Jun 2023 07:54:26 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:54:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 05/11] ASoC: q6dsp: audioreach: Add support to set compress format params
Date:   Fri,  9 Jun 2023 15:54:01 +0100
Message-Id: <20230609145407.18774-6-srinivas.kandagatla@linaro.org>
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
index 0acd4a75d5cd..6d0f4c8505f1 100644
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

