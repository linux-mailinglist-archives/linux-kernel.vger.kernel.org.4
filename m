Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8C60F517
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiJ0K2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiJ0K1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:27:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42CE22508
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j15so1408812wrq.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRksJXQbYrRhqCpyqmwfEWWPK1xGzs4Mo3xZYXwQ8qI=;
        b=f/fmha2i9p6KmSlokHd/hMBPFW6SAgl0PFNlWcJ4nEkGm20pZSQJXenfEJEcEHuLlm
         6ZP4/qQy5iLUJBfGCqaND/KY+y2CUqDlKqti0B7zr2sWuyOfH6SaRU51YcpATNIKNumZ
         Ce+yLpP9wBBn8RFE9HDi1mkhCoXtdPG0L1Uh0lNXoQ6i7pKtsyekb9Ak7UQfNpSAPHNk
         xhg7S7aBV+jP8CvrR1TkwgHho3M6uhm6ytah8H6e5g+/DJoFl+z+EjMvnE7LUSrdiPG9
         ZwcgfyIr9AJ6x7G82/pnt9zk3felswollEp8bJno0RkB4mXxIF8PWLwX3QwCKTCC/zq5
         /LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRksJXQbYrRhqCpyqmwfEWWPK1xGzs4Mo3xZYXwQ8qI=;
        b=eWGse7km2VRsScO3+HAW9P/Yihy+04PsadV/TnFcCiYn3jCrkmP0hRvPGYjNDJ2gK6
         OruQnW0UJcY+27DpThQ9qmZpoYz0nsAKAot6utEHolHqyBNeDMFJnkEeHzSeJzIVWHZZ
         EUzV0Qyut/4rdvE67SlbEQJXNbVLqnOYHRiNV8nxkiVTPyrNjTHIYNsRIuToBY3wtog+
         EGuvX5UfgOH2s7WuU0O3T3H93A+l5j49tJLo9+9Gp5zAIp2zgdBmw7jTUToQfrrkp7u3
         rEBjKB8St7//5YVBdkuBJgOCydltSPMPAJ6KJerV3e7d3TIlZEQUZALpCeKU9SHSlS62
         qCBA==
X-Gm-Message-State: ACrzQf3xIvGPUxd/YFS9xmSQMSGPFO7/Zia+Bgx8CRvYDxVqVBnfacUC
        j/6gZvlyx48zT7EQdEFyVCqzCQ==
X-Google-Smtp-Source: AMsMyM6pc1chA1bRxJ6xEZf1ooe1oXo97K30OmXVvaQEhM4IL6eIDQ49o5kWt5LbqOn7iKpTLTq3gQ==
X-Received: by 2002:adf:fc12:0:b0:236:9b2e:4843 with SMTP id i18-20020adffc12000000b002369b2e4843mr658925wrr.620.1666866469328;
        Thu, 27 Oct 2022 03:27:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003b505d26776sm5088674wmb.5.2022.10.27.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 03:27:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 8/9] ASoC: qdsp6: audioreach: add support for MFC Module
Date:   Thu, 27 Oct 2022 11:27:09 +0100
Message-Id: <20221027102710.21407-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221027102710.21407-1-srinivas.kandagatla@linaro.org>
References: <20221027102710.21407-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to enable and configure Media Format Converter (MFC) Module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 53 ++++++++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/audioreach.h |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index be7068742fe4..1338b99f37e1 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -159,6 +159,8 @@ struct apm_module_hw_ep_mf_cfg {
 
 #define APM_HW_EP_CFG_PSIZE ALIGN(sizeof(struct apm_module_hw_ep_mf_cfg), 8)
 
+#define APM_MFC_CFG_PSIZE(p, n) ALIGN(struct_size(p, channel_mapping, n), 4)
+
 struct apm_module_frame_size_factor_cfg {
 	struct apm_module_param_data param_data;
 	uint32_t frame_size_factor;
@@ -729,6 +731,53 @@ static int audioreach_sal_set_media_format(struct q6apm_graph *graph,
 	return rc;
 }
 
+static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
+					   struct audioreach_module *module,
+					   struct audioreach_module_config *cfg)
+{
+	struct apm_module_param_data *param_data;
+	struct param_id_mfc_media_format *media_format;
+	uint32_t num_channels = cfg->num_channels;
+	int payload_size;
+	struct gpr_pkt *pkt;
+	int rc;
+	void *p;
+
+	payload_size = APM_MFC_CFG_PSIZE(media_format, num_channels) +
+		APM_MODULE_PARAM_DATA_SIZE;
+
+	pkt = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
+	if (IS_ERR(pkt))
+		return PTR_ERR(pkt);
+
+	p = (void *)pkt + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
+
+	param_data = p;
+	param_data->module_instance_id = module->instance_id;
+	param_data->error_code = 0;
+	param_data->param_id = PARAM_ID_MFC_OUTPUT_MEDIA_FORMAT;
+	param_data->param_size = APM_MFC_CFG_PSIZE(media_format, num_channels);
+	p = p + APM_MODULE_PARAM_DATA_SIZE;
+	media_format = p;
+
+	media_format->sample_rate = cfg->sample_rate;
+	media_format->bit_width = cfg->bit_width;
+	media_format->num_channels = cfg->num_channels;
+
+	if (num_channels == 1) {
+		media_format->channel_mapping[0] = PCM_CHANNEL_L;
+	} else if (num_channels == 2) {
+		media_format->channel_mapping[0] = PCM_CHANNEL_L;
+		media_format->channel_mapping[1] = PCM_CHANNEL_R;
+	}
+
+	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
+
 static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 					   struct audioreach_module *module,
 					   struct audioreach_module_config *cfg)
@@ -1054,7 +1103,9 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 		if (!rc)
 			rc = audioreach_sal_limiter_enable(graph, module, true);
 		break;
-
+	case MODULE_ID_MFC:
+		rc = audioreach_mfc_set_media_format(graph, module, cfg);
+		break;
 	default:
 		rc = 0;
 	}
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index f2b51d8fc718..707dfbdbc156 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -16,6 +16,7 @@ struct q6apm_graph;
 #define MODULE_ID_PCM_ENC		0x07001004
 #define MODULE_ID_PCM_DEC		0x07001005
 #define MODULE_ID_SAL			0x07001010
+#define MODULE_ID_MFC			0x07001015
 #define MODULE_ID_CODEC_DMA_SINK	0x07001023
 #define MODULE_ID_CODEC_DMA_SOURCE	0x07001024
 #define MODULE_ID_I2S_SINK		0x0700100A
-- 
2.21.0

