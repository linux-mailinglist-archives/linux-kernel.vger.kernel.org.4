Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600816F66AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjEDIDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjEDIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:02:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3610A4217
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f139de8cefso7575054e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187311; x=1685779311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6QWtJjp2q6c2N1q1GDC5npabf74EYiHpQvEEQaOQAA=;
        b=TSL586EtVmIibnbaXNKWqcoukdk8iBfoZ2PL2zgZt+FYAuWhx7qVRx6wDiFReJufDh
         10JomKzFdoV4BbXaE/jYD1xuLPPx8TuSg4pxFarqFV+yGSiD0fEBj8PMd98pf01E8HMt
         NNaBAV7pYt0imjwR5catlUn6fnPXUi8zhsJpYIEn8YtfcuhMI6R8y3tnIvrsdd8snlpK
         TN+xOH/I0xqw6+iJATFMuVAGBTrGP3drQWTEwgBeYMxARubwdmnnzoQhR8qGVXKmb+1S
         zqcvXi6vRMaNEV9tcep+1wH7kFrFOZ/DTw7l78Gy+Yh60P+d2Evrl1PWz2xsdOAYmE6I
         ArvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187311; x=1685779311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6QWtJjp2q6c2N1q1GDC5npabf74EYiHpQvEEQaOQAA=;
        b=NUxFYSfQ7JGaxOkEaJl2FNeYQya0BXtZmy2cTjguwNNFMB9uk+VL7Amq3E1Bz9CaIK
         Hzb/NrRUwskcush4LLL3saN2B2eRLIa9sVc8hkHpXUxAjRfDDs32LoW8Pt8PAtc7Cie5
         LdB4rTEZPsiD4e8X78QR6AwzxSIq3L8eFa7W3bolNzZ2waErd6eZ3509E4dFnduWbijV
         /g9CdxZMYU+Jt9Ma/AVNiQ6ZbArjAWpGw6n5f2KgcClfkif5Vgjt3/yyUjalkRdCmW1L
         h1gcrkMNLEC076PyrlWw4hKqZllLdV7oXTqxiVoAle4i9hNd/5qZIT/QKLVlE3Xk72Ne
         WOCQ==
X-Gm-Message-State: AC+VfDyDw4a08OpOaK9pbUqTzNEFUy4M+pKQ4uEMm9tQ03cEgqyOYt8s
        h+P6KxkAJeNkov0scbB32coxNg==
X-Google-Smtp-Source: ACHHUZ4r/6NvEVmBchNgDGeeYNpUo3a8919S0BgkOLNingtqsvP6zjDp3OwMNA1fsmMeZwBIxQiP5A==
X-Received: by 2002:a05:6512:31c8:b0:4ec:83fd:1599 with SMTP id j8-20020a05651231c800b004ec83fd1599mr1392472lfe.33.1683187311279;
        Thu, 04 May 2023 01:01:51 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:12 +0200
Subject: [PATCH v2 16/18] media: venus: Introduce accessors for remapped
 hfi_buffer_reqs members
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-16-d95d14949c79@linaro.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
In-Reply-To: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=7882;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JFgOhkeOt67nc44HF+GqE6foLvDaV58jvlZqT/rckfI=;
 b=v8Yq5IZVIa4LQuuTAiStlhuqUHgjSLjAoEfAzxe64ZzOehkZdzRdbRfoBe18cD6IwhO+Lz3BZ
 UeYXne8c4vSCDhDlQBxACqwfEfEdRPCZ0q5wFVKUziocn9ndKFiR5NX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have macros to access these, but they don't provide a
way to override the remapped fields. Replace the macros with actual
get/set pairs to fix that.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c    |  2 +-
 drivers/media/platform/qcom/venus/hfi_helper.h | 64 +++++++++++++++++++++-----
 drivers/media/platform/qcom/venus/hfi_msgs.c   |  2 +-
 drivers/media/platform/qcom/venus/vdec.c       |  8 ++--
 drivers/media/platform/qcom/venus/vdec_ctrls.c |  2 +-
 drivers/media/platform/qcom/venus/venc.c       |  4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c |  2 +-
 7 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index a2ceab7f9ddb..1ce2624abc12 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -189,7 +189,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
-	count = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	count = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	for (i = 0; i < count; i++) {
 		buf = kzalloc(sizeof(*buf), GFP_KERNEL);
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index e0c8f15644df..1e06227ad240 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1168,17 +1168,6 @@ struct hfi_buffer_display_hold_count_actual {
 	u32 hold_count;
 };
 
-/* HFI 4XX reorder the fields, use these macros */
-#define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
-	? 0 : (bufreq)->hold_count)
-#define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
-	? (bufreq)->hold_count : (bufreq)->count_min)
-#define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
-	? (bufreq)->count_min : 0)
-
 struct hfi_buffer_requirements {
 	u32 type;
 	u32 size;
@@ -1190,6 +1179,59 @@ struct hfi_buffer_requirements {
 	u32 alignment;
 };
 
+/* Starting with HFI 4XX, some properties were swapped.. */
+static inline u32 hfi_bufreq_get_hold_count(struct hfi_buffer_requirements *req,
+					    u32 ver)
+{
+	if (ver == HFI_VERSION_4XX || ver == HFI_VERSION_6XX)
+		return 0;
+
+	return req->hold_count;
+};
+
+static inline u32 hfi_bufreq_get_count_min(struct hfi_buffer_requirements *req,
+					   u32 ver)
+{
+	if (ver == HFI_VERSION_4XX || ver == HFI_VERSION_6XX)
+		return req->hold_count;
+
+	return req->count_min;
+};
+
+static inline u32 hfi_bufreq_get_count_min_host(struct hfi_buffer_requirements *req,
+						u32 ver)
+{
+	if (ver == HFI_VERSION_4XX || ver == HFI_VERSION_6XX)
+		return req->count_min;
+
+	return 0;
+};
+
+static inline void hfi_bufreq_set_hold_count(struct hfi_buffer_requirements *req,
+					     u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX || ver == HFI_VERSION_6XX)
+		return;
+
+	req->hold_count = val;
+};
+
+static inline void hfi_bufreq_set_count_min(struct hfi_buffer_requirements *req,
+					    u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX || ver == HFI_VERSION_6XX)
+		req->hold_count = val;
+
+	req->count_min = val;
+};
+
+static inline void hfi_bufreq_set_count_min_host(struct hfi_buffer_requirements *req,
+						 u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX || ver == HFI_VERSION_6XX)
+		req->count_min = val;
+};
+
 struct hfi_data_payload {
 	u32 size;
 	u8 data[1];
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index df96db3761a7..c320ebbdb24e 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -99,7 +99,7 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 		case HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS:
 			data_ptr += sizeof(u32);
 			bufreq = (struct hfi_buffer_requirements *)data_ptr;
-			event.buf_count = HFI_BUFREQ_COUNT_MIN(bufreq, ver);
+			event.buf_count = hfi_bufreq_get_count_min(bufreq, ver);
 			data_ptr += sizeof(*bufreq);
 			break;
 		case HFI_INDEX_EXTRADATA_INPUT_CROP:
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 33e3f7208b1a..2f0a95860c94 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -870,13 +870,13 @@ static int vdec_num_buffers(struct venus_inst *inst, unsigned int *in_num,
 	if (ret)
 		return ret;
 
-	*in_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	*in_num = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
 	if (ret)
 		return ret;
 
-	*out_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+	*out_num = hfi_bufreq_get_count_min(&bufreq, ver);
 
 	return 0;
 }
@@ -990,14 +990,14 @@ static int vdec_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_output_bufs < bufreq.count_actual ||
-	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_output_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
 	if (ret)
 		return ret;
 
-	if (inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	if (inst->num_input_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
index fbe12a608b21..7e0f29bf7fae 100644
--- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
+++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
@@ -79,7 +79,7 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
 		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
 		if (!ret)
-			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+			ctrl->val = hfi_bufreq_get_count_min(&bufreq, ver);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 4666f42feea3..42cbb1619463 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1202,7 +1202,7 @@ static int venc_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_output_bufs < bufreq.count_actual ||
-	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_output_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
@@ -1210,7 +1210,7 @@ static int venc_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_input_bufs < bufreq.count_actual ||
-	    inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
+	    inst->num_input_bufs < hfi_bufreq_get_count_min(&bufreq, ver))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 7468e43800a9..d9d2a293f3ef 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -358,7 +358,7 @@ static int venc_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
 		if (!ret)
-			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+			ctrl->val = hfi_bufreq_get_count_min(&bufreq, ver);
 		break;
 	default:
 		return -EINVAL;

-- 
2.40.1

