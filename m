Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F636F66B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjEDIDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEDIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:02:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842F1421B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so2015361fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187313; x=1685779313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/ezoAVw2YsuX0T7djrVDfZq5CgG+6MzZDD2YwmF/kg=;
        b=kLenHnDCd0uBsKrSo1WGh78cZTh9Ra3zVmHLL4gndv8ZleajftHuLyHS3D5fezkMOr
         WSMdKVvRSRukQniAoZj5cvlK1hmjJmwXsyAqZpccM38y9Ko8BEvOW/5buqQ0oAQ2LjxM
         SnsjZW9r66m51bB0WBrMDS2jDAmUc0kCgZF4WSA9G68QKVr/3bj9j1TK8g4/U2G6G/qZ
         EZPlPR56wdKsTspC1CaGZ9SZlpWCJcBahFv+edw1hr8IBmgpjEWOLEUr5b0l/G5Hh0O4
         CC5DRGXbfNjfJwRkSiT+ShE2u1LxiLSzx0EpkQVupLKMXBXc6yleYaq5TvdSC6cSRvhc
         Xckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187313; x=1685779313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/ezoAVw2YsuX0T7djrVDfZq5CgG+6MzZDD2YwmF/kg=;
        b=kY+ME3ZkaKGN6ORq6S4Fq3yZqSBtfocJw3gryNQPdQ19pj3e2lE+zWYXXK1cmhjnQ2
         ic8Z/w1c1fd9CZOtIBHC49ddEVcDxSCtNKVB4gep8X4sPA2wSahqp7MLCyR4OLWb8F6J
         nWMNH/+Tt3gyOwszNxNwJ7dOR6Wh6HgsrX4Sl09KXa+wi4+z0tynOhkYAOiO0cDnrL7N
         b5ZBDYHbywdRl2HIRjABjruzAn4rlWATC2/m0HB9RCqIN7p/lk4hlfDT6plMicVc14x4
         g5BcvTmMrkpUtNJEPPlYOlTzFNldtFLRbtB9RJuvR9rQizrrFo3ssYNLHuN+iiBWIT9i
         smaQ==
X-Gm-Message-State: AC+VfDwTj4XsZbt2Cdm3Gc5EqCK2suuJTPPRIu8kCLD5tFrT94pdbnAY
        1vdjOuYLxA4ruYXQqHUi5/XDZA==
X-Google-Smtp-Source: ACHHUZ7SjeFgvK6nG6qtBdpqsELpBYDXq4bDezFMSZJUZ+zWtJyorg/du54Mm4TQBT6B+si38l3WTA==
X-Received: by 2002:ac2:5976:0:b0:4d8:6540:a731 with SMTP id h22-20020ac25976000000b004d86540a731mr1454565lfp.47.1683187312943;
        Thu, 04 May 2023 01:01:52 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:13 +0200
Subject: [PATCH v2 17/18] media: venus: Use newly-introduced
 hfi_buffer_requirements accessors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-17-d95d14949c79@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=4434;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3DU/aHZTwApMpAzleBOxmDEmeu3wMrZY4AjWxSwH9y0=;
 b=9IA8yX1+nsMn6XchQoCxp1wd6G+ibq7ZxKdRzqfGpLjOauwbHOGMVdZCFeUChEHEN7xfLqT+s
 fwK2smrptb9BbTMppDZxwJGyF5mMRqzK8YhnFfv9x2mzqZuijYKnGRg
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

Now that we have a way which is independent of the HFI version to set
the correct fields in hfi_buffer_requirements, use it!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c        |  5 +++--
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 22 +++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 1ce2624abc12..0268129ab9ac 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -667,6 +667,7 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 			    struct hfi_buffer_requirements *req)
 {
 	u32 ptype = HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS;
+	enum hfi_version ver = inst->core->res->hfi_version;
 	union hfi_get_property hprop;
 	unsigned int i;
 	int ret;
@@ -674,12 +675,12 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 	memset(req, 0, sizeof(*req));
 
 	if (type == HFI_BUFFER_OUTPUT || type == HFI_BUFFER_OUTPUT2)
-		req->count_min = inst->fw_min_cnt;
+		hfi_bufreq_set_count_min(req, ver, inst->fw_min_cnt);
 
 	ret = platform_get_bufreq(inst, type, req);
 	if (!ret) {
 		if (type == HFI_BUFFER_OUTPUT || type == HFI_BUFFER_OUTPUT2)
-			inst->fw_min_cnt = req->count_min;
+			inst->fw_min_cnt = hfi_bufreq_get_count_min(req, ver);
 		return 0;
 	}
 
diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
index a9be31ec6927..5eb4032bc551 100644
--- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
+++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
@@ -1214,25 +1214,25 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
 
 	out_min_count = output_buffer_count(VIDC_SESSION_TYPE_DEC, codec);
 	/* Max of driver and FW count */
-	out_min_count = max(out_min_count, bufreq->count_min);
+	out_min_count = max(out_min_count, hfi_bufreq_get_count_min(bufreq, version));
 
 	bufreq->type = buftype;
 	bufreq->region_size = 0;
-	bufreq->count_min = 1;
 	bufreq->count_actual = 1;
-	bufreq->hold_count = 1;
+	hfi_bufreq_set_count_min(bufreq, version, 1);
+	hfi_bufreq_set_count_min_host(bufreq, version, 1);
 	bufreq->contiguous = 1;
 	bufreq->alignment = 256;
 
 	if (buftype == HFI_BUFFER_INPUT) {
-		bufreq->count_min = MIN_INPUT_BUFFERS;
+		hfi_bufreq_set_count_min(bufreq, version, MIN_INPUT_BUFFERS);
 		bufreq->size =
 			calculate_dec_input_frame_size(width, height, codec,
 						       max_mbs_per_frame,
 						       buffer_size_limit);
 	} else if (buftype == HFI_BUFFER_OUTPUT ||
 		   buftype == HFI_BUFFER_OUTPUT2) {
-		bufreq->count_min = out_min_count;
+		hfi_bufreq_set_count_min(bufreq, version, out_min_count);
 		bufreq->size =
 			venus_helper_get_framesz_raw(params->hfi_color_fmt,
 						     width, height);
@@ -1264,7 +1264,7 @@ static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
 	u32 work_mode = params->enc.work_mode;
 	u32 rc_type = params->enc.rc_type;
 	u32 num_vpp_pipes = params->num_vpp_pipes;
-	u32 num_ref;
+	u32 num_ref, count_min;
 
 	switch (codec) {
 	case V4L2_PIX_FMT_H264:
@@ -1284,21 +1284,21 @@ static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
 
 	bufreq->type = buftype;
 	bufreq->region_size = 0;
-	bufreq->count_min = 1;
 	bufreq->count_actual = 1;
-	bufreq->hold_count = 1;
+	hfi_bufreq_set_count_min(bufreq, version, 1);
+	hfi_bufreq_set_count_min_host(bufreq, version, 1);
 	bufreq->contiguous = 1;
 	bufreq->alignment = 256;
 
 	if (buftype == HFI_BUFFER_INPUT) {
-		bufreq->count_min = MIN_INPUT_BUFFERS;
+		hfi_bufreq_set_count_min(bufreq, version, MIN_INPUT_BUFFERS);
 		bufreq->size =
 			venus_helper_get_framesz_raw(params->hfi_color_fmt,
 						     width, height);
 	} else if (buftype == HFI_BUFFER_OUTPUT ||
 		   buftype == HFI_BUFFER_OUTPUT2) {
-		bufreq->count_min =
-			output_buffer_count(VIDC_SESSION_TYPE_ENC, codec);
+		count_min = output_buffer_count(VIDC_SESSION_TYPE_ENC, codec);
+		hfi_bufreq_set_count_min(bufreq, version, count_min);
 		bufreq->size = calculate_enc_output_frame_size(width, height,
 							       rc_type);
 	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {

-- 
2.40.1

