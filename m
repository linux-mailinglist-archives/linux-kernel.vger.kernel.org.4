Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C5A686791
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjBANwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjBANwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:52:18 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667F66EE6;
        Wed,  1 Feb 2023 05:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259525; x=1706795525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cBi3BvKRnXTZgu2O0Zhf99/PEr4TAL6EjVv9z1gkLTQ=;
  b=HMdLC9ddGLL5M1/5b44Ar4yrqcg5kAbFiVG71oWA+Og6qYoz/Nm9Nezx
   fGlDe3hjk+9FhjqfXXYy1bso+nLeyyLl0KNVhA/JMRu7161i50gPVjnkR
   v4lyi8bon4tBOVGiebTmh3uCOkOzPg3Ob8827GmQeD3juy/FLy7j/VtTV
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:52:04 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:52:04 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:51:57 -0800
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
Subject: [PATCH 06/14] ASoC: q6dsp: audioreach: Add support for sending real module ID to ADSP
Date:   Wed, 1 Feb 2023 19:19:39 +0530
Message-ID: <20230201134947.1638197-7-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201134947.1638197-1-quic_mohs@quicinc.com>
References: <20230201134947.1638197-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Add support for sending the placeholder real module ID to ADSP
for enabling compressed playback. 

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c |  6 ++++++
 sound/soc/qcom/qdsp6/audioreach.h |  1 +
 sound/soc/qcom/qdsp6/q6apm.c      | 29 +++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h      |  1 +
 4 files changed, 37 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index a87df09d187f..e84ccbacc0f7 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -1315,6 +1315,12 @@ int audioreach_enable_module(struct q6apm *apm, struct audioreach_module *module
 }
 EXPORT_SYMBOL_GPL(audioreach_enable_module);
 
+int audioreach_set_real_module_id(struct q6apm *apm, struct audioreach_module *module, uint32_t id)
+{
+	return audioreach_send_u32_param(apm, module, PARAM_ID_REAL_MODULE_ID, id);
+}
+EXPORT_SYMBOL_GPL(audioreach_set_real_module_id);
+
 int audioreach_compr_set_param(struct q6apm_graph *graph, struct audioreach_module_config *mcfg)
 {
 	struct media_format *header;
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 4c4bdff45cf1..0faaf75115fd 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -787,4 +787,5 @@ int audioreach_remove_initial_silence(struct q6apm *apm, struct audioreach_modul
 int audioreach_remove_trailing_silence(struct q6apm *apm, struct audioreach_module *module,
 				uint32_t trailing_samples);
 int audioreach_compr_set_param(struct q6apm_graph *graph, struct audioreach_module_config *mcfg);
+int audioreach_set_real_module_id(struct q6apm *apm, struct audioreach_module *module, uint32_t id);
 #endif /* __AUDIOREACH_H__ */
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 78c1a7c13348..811d86bdc092 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -336,6 +336,35 @@ int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph,
 }
 EXPORT_SYMBOL_GPL(q6apm_enable_compress_module);
 
+int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph,
+			     uint32_t codec_id)
+{
+	struct q6apm *apm = dev_get_drvdata(dev->parent);
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
+	return audioreach_set_real_module_id(apm, module, module_id);
+}
+EXPORT_SYMBOL_GPL(q6apm_set_real_module_id);
+
 int q6apm_graph_media_format_pcm(struct q6apm_graph *graph, struct audioreach_module_config *cfg)
 {
 	struct audioreach_graph_info *info = graph->info;
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 08b64f78c750..87d67faf5f1a 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -150,4 +150,5 @@ bool q6apm_is_adsp_ready(void);
 int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph, bool en);
 int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
 int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
+int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph, uint32_t codec_id);
 #endif /* __APM_GRAPH_ */
-- 
2.25.1

