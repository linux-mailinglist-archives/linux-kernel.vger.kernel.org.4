Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A186867A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBANxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjBANxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:53:12 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222AB65EDE;
        Wed,  1 Feb 2023 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259564; x=1706795564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yIIgPFIFODAxKPkgPqqwq+s+KBvSCKTf+wd3Xgqe4g=;
  b=k5qJyAvnNxhxwVZEVLu6tlFPaVpXorWpxy2+IBxlxBeJ/nGGZPrU5Ycl
   MRo3Ab0JnWuoNW36XyvJMCBZi5VRkcc6qLGWWNmqmtzRePm+PcbNSriP7
   zEk15D2lRbeA7JAz36ljUNCFyGMIimBA2GQgBtT2CV/tHcsA/TCghxYeM
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:52:44 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:52:43 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:52:37 -0800
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
Subject: [PATCH 13/14] ASoC: qdsp6: audioreach: Add MP3, AAC and FLAC compress format support
Date:   Wed, 1 Feb 2023 19:19:46 +0530
Message-ID: <20230201134947.1638197-14-quic_mohs@quicinc.com>
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

Add support for handling compressed formats such as MP3, AAC and FLAC.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 106 ++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 20 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 7c45c36e9156..250ed828c7d3 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -852,6 +852,68 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	return rc;
 }
 
+static int  audioreach_set_compr_media_format(struct media_format *media_fmt_hdr,
+					      void *p, struct audioreach_module_config *mcfg)
+{
+	struct payload_media_fmt_aac_t *aac_cfg;
+	struct payload_media_fmt_pcm *mp3_cfg;
+	struct payload_media_fmt_flac_t *flac_cfg;
+	int ret = 0;
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
+	return ret;
+}
+
 static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 					   struct audioreach_module *module,
 					   struct audioreach_module_config *cfg)
@@ -1055,26 +1117,29 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 	p = p + APM_MODULE_PARAM_DATA_SIZE;
 
 	header = p;
-	header->data_format = DATA_FORMAT_FIXED_POINT;
-	header->fmt_id = MEDIA_FMT_ID_PCM;
-	header->payload_size = payload_size - sizeof(*header);
+	if (mcfg->fmt == SND_AUDIOCODEC_PCM) {
+		header->data_format = DATA_FORMAT_FIXED_POINT;
+		header->fmt_id =  MEDIA_FMT_ID_PCM;
+		header->payload_size = payload_size - sizeof(*header);
 
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
-	}
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
+	} else
+		audioreach_set_compr_media_format(header, p, mcfg);
 
 	rc = audioreach_graph_send_cmd_sync(graph, pkt, 0);
 
@@ -1401,7 +1466,8 @@ int audioreach_compr_set_param(struct q6apm_graph *graph, struct audioreach_modu
 			cfg->channel_mapping[0] =  PCM_CHANNEL_L;
 			cfg->channel_mapping[1] =  PCM_CHANNEL_R;
 		}
-	}
+	} else
+		audioreach_set_compr_media_format(header, p, mcfg);
 
 	rc = gpr_send_port_pkt(graph->port, pkt);
 	kfree(pkt);
-- 
2.25.1

