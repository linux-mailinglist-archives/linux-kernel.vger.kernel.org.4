Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE42E7073CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjEQVPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjEQVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941D65B9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af15b5f726so3202101fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358089; x=1686950089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVbKXR6TkuL6mzIO8jr1tML/Qs51vqKPlZsOURKyzn8=;
        b=HpqHPqBJ3HV308jnTgGEc7EcQAWCm5gziORxglayJncV8PKoYDv9pJ3I6bSeH3EOCY
         O1uw1s0L4brdiDWX2E7Z152oPk2ErzlP4z6LsPUlphpLkOooKrknoFPi1tnbgWfsEjGG
         7sNPPhqoUrjJQK3Fw+WaSvCGfeOuHAMbZ1E1lduIRvw9eDouPgaNceU0Z/sSPb+YAUct
         OPPBKpg391LJVKkMEGa8OslcAowTry6M0pG7ZGdxFDbXNiHhXVpPahdqO/Q3zEK2xlUW
         AoZq3ANC6x/gWmaeMstCnES7boecyBb22yL8O2AwBRRyVk6tGdrjmJ2ttLP+Dxdvd3fN
         mUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358089; x=1686950089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVbKXR6TkuL6mzIO8jr1tML/Qs51vqKPlZsOURKyzn8=;
        b=k36qaI6bwv3geGuIexFh9a8dwQcAI+UkeKWocUfzzzVu8qfjPdkgMjfB2rtQTpKcg/
         BUITXZyCrNnOmVGrfU0ay893VUWPaAhv54AmLzgzyvp94DB2zawPbiGYXiIxYJ4hVAQ5
         Ad/vtsBP6/YxJhZ/nv7sNCCujJaMTMy4y3n1gA523fMyx+WLhG28aVfJYImw3xVH8IDi
         hfYJs38k41sr3gBNDAIz3MRWspJKQUoOU6ecI7Cdw4oiMhqbXmDeXjAEQtA2BOrx9iwr
         eQYjOGKfth68m26qLJ4CzG+wI8W5X7GISA9lRZSFE3FVBUwKNdYbhXVCglNcVUwpAhuf
         kzHw==
X-Gm-Message-State: AC+VfDwfR60ITfl4NN+r0VBpAB2dBH+ekUBe59i3GEd7BMw+RiQJqVRT
        zeuRPYX5B1Nk6NvVkCCWC3rTXw==
X-Google-Smtp-Source: ACHHUZ5exr7VAV5/LK7pMyI2/TNScAr7gJ/VEXcUFywReKvCQ4LT/JUNvghsizJOOdvE9f3NnffyTQ==
X-Received: by 2002:a05:651c:1045:b0:2ac:79df:cb49 with SMTP id x5-20020a05651c104500b002ac79dfcb49mr10244952ljm.27.1684358089008;
        Wed, 17 May 2023 14:14:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:28 +0200
Subject: [PATCH v3 15/17] media: venus: Introduce accessors for remapped
 hfi_buffer_reqs members
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-15-6092ae43b58f@linaro.org>
References: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
In-Reply-To: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=7631;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=iJaK8zSvweyHC0tut2pjuo14EEF7DYLKvV7wmR+GmJM=;
 b=UIZ0DAmfzpJ7C7fnxRlVcfhPlh2XPyp+ADtFqitG5Wo1uh5Iv5QyYS27tTTr12IRpyM13g/WQ
 0QqmxUvW417D9bC7B822Jgcp0Iv6FFD8f/6WAVYeV35G6xcNvuFWtvW
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
 drivers/media/platform/qcom/venus/hfi_helper.h | 61 ++++++++++++++++++++++----
 drivers/media/platform/qcom/venus/hfi_msgs.c   |  2 +-
 drivers/media/platform/qcom/venus/vdec.c       |  8 ++--
 drivers/media/platform/qcom/venus/vdec_ctrls.c |  2 +-
 drivers/media/platform/qcom/venus/venc.c       |  4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c |  2 +-
 7 files changed, 63 insertions(+), 18 deletions(-)

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
index 105792a68060..5ef5a78f64ef 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1168,14 +1168,6 @@ struct hfi_buffer_display_hold_count_actual {
 	u32 hold_count;
 };
 
-/* HFI 4XX reorder the fields, use these macros */
-#define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
-#define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
-#define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
-	((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
-
 struct hfi_buffer_requirements {
 	u32 type;
 	u32 size;
@@ -1187,6 +1179,59 @@ struct hfi_buffer_requirements {
 	u32 alignment;
 };
 
+/* On HFI 4XX, some of the struct members have been swapped. */
+static inline u32 hfi_bufreq_get_hold_count(struct hfi_buffer_requirements *req,
+					    u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return 0;
+
+	return req->hold_count;
+};
+
+static inline u32 hfi_bufreq_get_count_min(struct hfi_buffer_requirements *req,
+					   u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return req->hold_count;
+
+	return req->count_min;
+};
+
+static inline u32 hfi_bufreq_get_count_min_host(struct hfi_buffer_requirements *req,
+						u32 ver)
+{
+	if (ver == HFI_VERSION_4XX)
+		return req->count_min;
+
+	return 0;
+};
+
+static inline void hfi_bufreq_set_hold_count(struct hfi_buffer_requirements *req,
+					     u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
+		return;
+
+	req->hold_count = val;
+};
+
+static inline void hfi_bufreq_set_count_min(struct hfi_buffer_requirements *req,
+					    u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
+		req->hold_count = val;
+
+	req->count_min = val;
+};
+
+static inline void hfi_bufreq_set_count_min_host(struct hfi_buffer_requirements *req,
+						 u32 ver, u32 val)
+{
+	if (ver == HFI_VERSION_4XX)
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
index b880e290a62f..f779ad97f584 100644
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

