Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B56A5BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjB1P0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjB1PZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:25:40 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB8D311FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:25:04 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f18so13729207lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eihSZiwgZ6E2xYB6tBxQwPxo/1weB3lZJYhUgr716R0=;
        b=iZne8soTXQSAFkA31CLy56qpAcfb3w8dOqu2GvAqQAOoh2F6nv0pUllNXziBTLDKgg
         TMJWrdGit7aMLmqSlNn1Clkm6H8z3LOnf6JLIqEAT6LSypohzhubatiC+vmydQhKVlOa
         M7Bk+eeLR/vV7u5DBjF4LtjLIcYgSN/59BFYNFkKWNcHVWfwYU6jLXCC5ABp2qoMgOpH
         obtcCBJiMFm+P9/FPkcr5leTZeCaw0RlKochX25oyqVv+jv0ORRulsgbPJxSJr3mmtF4
         Fd/ZqqrSPfO+o1CiFIt54K3IE9DYZTlzTpws3QqdDjpTEJjL7s5Z8V3vQuX/XVfwDt6s
         FspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eihSZiwgZ6E2xYB6tBxQwPxo/1weB3lZJYhUgr716R0=;
        b=qUCZYgbh1rv6X5DP7EhgNfyAATKfUzzgBDvLwN6hobZ2W4hx2MuE5lZSvBtcZ9WjgN
         df97Z5NQ1ItkP9/pLJ922qSSzymYgfAcyUE2pYoWvhxOe5BN2mxCM/vm6g8vVa47PiW1
         8u1hO0w/HF8z0TB2MvA00jm93ofONLU9T0iqupMkXJRIBR6JNiFFTE8OqciAuJZG4aJH
         aO6HzmI9jGSFCDNWAVE1BCBDuhexHyiOVtzxbIrfAxfCKvBn04fPdgTJzlwSNJa45uI0
         h1YGs1VCNrQ6V/lPcO97ZVyDtAS0ktt6n6A8XKH120rTZxXYoXAxR7lWNEGQdv0UwM/1
         asMQ==
X-Gm-Message-State: AO0yUKXmjKCCui/Fmg+O1zDfKbsxO70SVF4V8MXvrklW0qGqGmKKFxiB
        susWeEaHpQEDdBWBsbkoBKeSmg==
X-Google-Smtp-Source: AK7set8AAkv5WYBlc9LciR0jKllGR7cHtpOxJpq2SPV9qTKjK9shySAtaU5Gw41Fhy7qmuUcPRW0Ww==
X-Received: by 2002:a19:7404:0:b0:4dd:a02c:5817 with SMTP id v4-20020a197404000000b004dda02c5817mr822266lfe.22.1677597901101;
        Tue, 28 Feb 2023 07:25:01 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:25:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:41 +0100
Subject: [PATCH 17/18] media: venus: Use newly-introduced
 hfi_buffer_requirements accessors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-17-58c2c88384e9@linaro.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=4416;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wZmtHBSeLXcghfRfyraSJEKtKF8I/yxpGdSokA4JG+Y=;
 b=a2zLs3lnOrnkrQugMN+EC1ojEqX1ZH7Pl0s5cY1pmw4Cby63ZtuKxki1I6AsfowIQTxKJWXL2J8D
 b58Dao15DaG8aVoP9qyrtm2vogQoDn2FcMSQB3HXe162Z202dWIM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a way to HFI-ver-independently set the correct
fields in hfi_buffer_requirements, use it!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c        |  5 +++--
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 22 +++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 502f45da84fb..aa7a2059bec1 100644
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
index ea25c451222b..d3466b46c868 100644
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
2.39.2

