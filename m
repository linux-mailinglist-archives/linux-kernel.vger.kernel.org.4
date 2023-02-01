Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0FF686787
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjBANwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjBANvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:51:53 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDE627D5C;
        Wed,  1 Feb 2023 05:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259512; x=1706795512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6ldfuDtGgWudw4cWPfGQYg4+8zcxX7nAHF3frtvbQ0=;
  b=Eit4k8SL/3+gtmS/fJSV2NAJKt7WMFWYBnlLbWYnpG5MG/VJa+omxuGX
   DjCNOCU4k57STqN99+dalQUkJ35g1QsKFZYnYnAeI1eA4rEDlTQXkKzf6
   U3aV2PsM/P1t5YNaJW9F/GrVTYjbifTbYEwOHXlJ3DqzKSCLOwvwL6wIr
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:51:52 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:51:51 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:51:46 -0800
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
Subject: [PATCH 04/14] ASoC: q6dsp: audioreach: Add support for compress offload commands
Date:   Wed, 1 Feb 2023 19:19:37 +0530
Message-ID: <20230201134947.1638197-5-quic_mohs@quicinc.com>
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

Add functions to send commands to the ADSP for supporting compressed
offload playback.
This includes functions to enable module ID, to remove trailing and
initial silence.
Also add functionality to send 32 bit parameter to ADSP.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 56 +++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h |  7 ++++
 sound/soc/qcom/qdsp6/q6apm.c      | 39 +++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h      |  3 ++
 4 files changed, 105 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 6d3d2a04ffe8..a11bab69a676 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -1258,3 +1258,59 @@ int audioreach_shared_memory_send_eos(struct q6apm_graph *graph)
 	return rc;
 }
 EXPORT_SYMBOL_GPL(audioreach_shared_memory_send_eos);
+
+int audioreach_send_u32_param(struct q6apm *apm, struct audioreach_module *module,
+			      uint32_t param_id, uint32_t param_val)
+{
+	struct apm_module_param_data *param_data;
+	struct gpr_pkt *pkt;
+	uint32_t *param;
+	int rc, payload_size;
+	void *p;
+
+	payload_size = sizeof(uint32_t) + APM_MODULE_PARAM_DATA_SIZE;
+	p = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
+	if (IS_ERR(p))
+		return -ENOMEM;
+
+	pkt = p;
+	p = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
+
+	param_data = p;
+	param_data->module_instance_id = module->instance_id;
+	param_data->error_code = 0;
+	param_data->param_id = param_id;
+	param_data->param_size = payload_size - APM_MODULE_PARAM_DATA_SIZE;
+
+	p = p + APM_MODULE_PARAM_DATA_SIZE;
+	param = p;
+	*param = param_val;
+	rc = q6apm_send_cmd_sync(apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(audioreach_send_u32_param);
+
+int audioreach_remove_trailing_silence(struct q6apm *apm, struct audioreach_module *module,
+				       uint32_t trailing_samples)
+{
+	return audioreach_send_u32_param(apm, module, PARAM_ID_REMOVE_TRAILING_SILENCE,
+					 trailing_samples);
+}
+EXPORT_SYMBOL_GPL(audioreach_remove_trailing_silence);
+
+int audioreach_remove_initial_silence(struct q6apm *apm, struct audioreach_module *module,
+				      uint32_t initial_samples)
+{
+	return audioreach_send_u32_param(apm, module, PARAM_ID_REMOVE_INITIAL_SILENCE,
+					 initial_samples);
+}
+EXPORT_SYMBOL_GPL(audioreach_remove_initial_silence);
+
+int audioreach_enable_module(struct q6apm *apm, struct audioreach_module *module, bool en)
+{
+	return audioreach_send_u32_param(apm, module, PARAM_ID_MODULE_ENABLE, en);
+}
+EXPORT_SYMBOL_GPL(audioreach_enable_module);
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index b78fd9bc8eb3..76dea97773cc 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -629,6 +629,8 @@ struct param_id_vol_ctrl_master_gain {
 } __packed;
 
 
+#define PARAM_ID_REMOVE_INITIAL_SILENCE		0x0800114B
+#define PARAM_ID_REMOVE_TRAILING_SILENCE	0x0800115D
 
 #define PARAM_ID_REAL_MODULE_ID	0x0800100B
 
@@ -779,4 +781,9 @@ int audioreach_set_media_format(struct q6apm_graph *graph,
 int audioreach_shared_memory_send_eos(struct q6apm_graph *graph);
 int audioreach_gain_set_vol_ctrl(struct q6apm *apm,
 				 struct audioreach_module *module, int vol);
+int audioreach_enable_module(struct q6apm *apm, struct audioreach_module *module, bool en);
+int audioreach_remove_initial_silence(struct q6apm *apm, struct audioreach_module *module,
+				uint32_t initial_samples);
+int audioreach_remove_trailing_silence(struct q6apm *apm, struct audioreach_module *module,
+				uint32_t trailing_samples);
 #endif /* __AUDIOREACH_H__ */
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 8a7dfd27d3c5..78c1a7c13348 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -297,6 +297,45 @@ int q6apm_unmap_memory_regions(struct q6apm_graph *graph, unsigned int dir)
 }
 EXPORT_SYMBOL_GPL(q6apm_unmap_memory_regions);
 
+int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples)
+{
+	struct q6apm *apm = dev_get_drvdata(dev->parent);
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_remove_initial_silence(apm, module, samples);
+}
+EXPORT_SYMBOL_GPL(q6apm_remove_initial_silence);
+
+int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples)
+{
+	struct q6apm *apm = dev_get_drvdata(dev->parent);
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_remove_trailing_silence(apm, module, samples);
+}
+EXPORT_SYMBOL_GPL(q6apm_remove_trailing_silence);
+
+int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph, bool en)
+{
+	struct q6apm *apm = dev_get_drvdata(dev->parent);
+	struct audioreach_module *module;
+
+	module = q6apm_find_module_by_mid(graph, MODULE_ID_PLACEHOLDER_DECODER);
+	if (!module)
+		return -ENODEV;
+
+	return audioreach_enable_module(apm, module, en);
+}
+EXPORT_SYMBOL_GPL(q6apm_enable_compress_module);
+
 int q6apm_graph_media_format_pcm(struct q6apm_graph *graph, struct audioreach_module_config *cfg)
 {
 	struct audioreach_graph_info *info = graph->info;
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 7005be9b63e3..08b64f78c750 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -147,4 +147,7 @@ int q6apm_graph_get_rx_shmem_module_iid(struct q6apm_graph *graph);
 
 bool q6apm_is_adsp_ready(void);
 
+int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph, bool en);
+int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
+int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
 #endif /* __APM_GRAPH_ */
-- 
2.25.1

