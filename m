Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125BF6867A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjBANxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjBANxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:53:16 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5346779B;
        Wed,  1 Feb 2023 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259569; x=1706795569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwQIVDLFm5wts9Zpmji6vpaZ2OWNop5ROxZR3n4FmwQ=;
  b=mLHd26+fwtBOypiqdbjlq3TVEeDtMlzefS0xHde/1dBn8b3MMajKcxlS
   T8rtzVLBg7jgtf/l4ktK6BuEkdK9YF6hh9CT2fV3H+gw5X/87qGIPVDcb
   fQBfhN/tH/CbbjWH6MDhwCbV1+wC8A1q2/n6TZvQvZurhZDA+Qy/XNrkf
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:52:48 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:52:48 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:52:42 -0800
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
Subject: [PATCH 14/14] ASoC: q6dsp: audioreach: Add gapless feature support
Date:   Wed, 1 Feb 2023 19:19:47 +0530
Message-ID: <20230201134947.1638197-15-quic_mohs@quicinc.com>
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

Add support for setting EOS delay command and receive the
EOS response from ADSP, for seamless compress offload
playback feature.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 40 +++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h |  6 +++++
 sound/soc/qcom/qdsp6/q6apm.c      |  3 +++
 3 files changed, 49 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 250ed828c7d3..71ff705e27cb 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -852,6 +852,43 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	return rc;
 }
 
+static int audioreach_gapless_set_media_format(struct q6apm_graph *graph,
+					   struct audioreach_module *module,
+					   struct audioreach_module_config *cfg)
+{
+	struct apm_module_param_data *param_data;
+	struct param_id_gapless_early_eos_delay_t *media_format;
+	int payload_size;
+	struct gpr_pkt *pkt;
+	int rc;
+	void *p;
+
+	payload_size = sizeof(struct param_id_gapless_early_eos_delay_t) +
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
+	param_data->param_id = PARAM_ID_EARLY_EOS_DELAY;
+	param_data->param_size = sizeof(struct param_id_gapless_early_eos_delay_t);
+	p = p + APM_MODULE_PARAM_DATA_SIZE;
+	media_format = p;
+
+	media_format->early_eos_delay_ms = EARLY_EOS_DELAY_MS;
+
+	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
+
 static int  audioreach_set_compr_media_format(struct media_format *media_fmt_hdr,
 					      void *p, struct audioreach_module_config *mcfg)
 {
@@ -1249,6 +1286,9 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 	case MODULE_ID_MFC:
 		rc = audioreach_mfc_set_media_format(graph, module, cfg);
 		break;
+	case MODULE_ID_GAPLESS:
+		rc = audioreach_gapless_set_media_format(graph, module, cfg);
+		break;
 	default:
 		rc = 0;
 	}
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 044994ca4811..a9d4f70ad3e0 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -543,6 +543,8 @@ struct param_id_sal_limiter_enable {
 } __packed;
 
 #define PARAM_ID_MFC_OUTPUT_MEDIA_FORMAT	0x08001024
+#define PARAM_ID_EARLY_EOS_DELAY		0x0800114C
+#define EARLY_EOS_DELAY_MS			150
 
 struct param_id_mfc_media_format {
 	uint32_t sample_rate;
@@ -551,6 +553,10 @@ struct param_id_mfc_media_format {
 	uint16_t channel_mapping[];
 } __packed;
 
+struct param_id_gapless_early_eos_delay_t {
+	uint32_t early_eos_delay_ms;
+} __packed;
+
 struct media_format {
 	uint32_t data_format;
 	uint32_t fmt_id;
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 1a6c7108bae0..37ded6e0f4ea 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -605,6 +605,9 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		}
 		break;
 	case DATA_CMD_WR_SH_MEM_EP_EOS_RENDERED:
+		client_event = APM_CLIENT_EVENT_CMD_EOS_DONE;
+		if (graph->cb)
+			graph->cb(client_event, hdr->token, data->payload, graph->priv);
 		break;
 	case GPR_BASIC_RSP_RESULT:
 		switch (result->opcode) {
-- 
2.25.1

