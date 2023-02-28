Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB83C6A5BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjB1PZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjB1PYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:24:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DEE241C5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g17so13712182lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaGduNCU1ULlQ2WtlYAAuJDe5x2zJJiEdNeq0M5C+Gk=;
        b=Fa/Hki05PBoukLOCE5VDxKeIcqwy+HqoIfP3kRLrzJCnjjZCsz0bgxY2M9/qoOJ4HZ
         u39h6etpitITUN7Jy8VhyJZue+YXfLhJ55iKdUy9aPEYuqrNfR6FDTNjV42MZ0M0ZK+Y
         AvNiNGMYd4YzRr6PLB/qNZKU0cIPXlcSQWRsE+kwej9AR8GCGx9A7TDZxzpJGTCYS0Qr
         cyAtH/1ejx3VmNwh89hvZNyfFSb5Sz/p/4+ZoqUEbvpv7KqVhEAly4e+wf6Hg7EUbgSR
         dLD5FxVfXGj7CnfiEl7M6mypRwFk+rDF7KxB/1Rrh88AGBLb1RHiL1vDDaEBe1dTS7RZ
         6+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaGduNCU1ULlQ2WtlYAAuJDe5x2zJJiEdNeq0M5C+Gk=;
        b=n44w8Qqx4Vkn5UDduVqtmKzQWnyyD4XVVluhXpK9+Oys6SwjirDVJu87wM1e2BKHZD
         KZFwg/U8QdmTw9W/S1RvG5YoYz1bN+HUVY4MB0XkM2c4EP8v3fVB3lFApkq/6PzxONfv
         4ClQp3OE2/8te6S1OI+1fLPcpKqfmr+afU4MkoReTWsLxFeqRMqC3DWF9TG6dyz7gSjx
         ZSiMTcII4TD1YEC4qFmKTm6Hryg3+/neW4wMjeqEBJkG7JiDh00B9u1uo0AMWxA6AcNh
         oI+03mXdxOk4fTVpYHTYH9wdmC5XMIJdpUkcTXnbH6yLTSsgjZd5Op5J5Pr9c8eCxFvM
         kXSA==
X-Gm-Message-State: AO0yUKXWYGZjuUX+4OJH80mpmSSIMoglfir0kjJ6yXtQl22OSoemTqm5
        h0lN8eJJmPIbb6zUPKNVA6qJGw==
X-Google-Smtp-Source: AK7set/+0/f3JmH9P6brEOJU0OMj4vy9VZG90QBqe7KsHWNIoXK3Ag2pk2j78rRHq8/ukF9DBMfqww==
X-Received: by 2002:ac2:54b8:0:b0:4dc:537c:9229 with SMTP id w24-20020ac254b8000000b004dc537c9229mr981894lfk.30.1677597878555;
        Tue, 28 Feb 2023 07:24:38 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:38 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:27 +0100
Subject: [PATCH 03/18] media: venus: Add vpu_version to most SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-3-58c2c88384e9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=1939;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=35x7tSloOwjwMyZxSi42rizc5msFf8OvUc6xn5LhOF8=;
 b=1YtZEMsw3wAb0TnoxRkEQKQh9U09FypcPXueNkxnks0ZMptpyQAYsGhUDWuyHVRi9uIjKKxK9Pkh
 5TPNzwzYCkcb5TvZgTSMLDHeIzTChoiKoQsMUM7F0Vkkq2uyMLEm
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

Add vpu_version where I was able to retrieve the information to
allow for more precise hardware-specific code path matching.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 990a1519f968..c13436d58ed3 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -686,6 +686,7 @@ static const struct venus_resources sdm845_res = {
 	.vcodec_clks_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
+	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,
 	.vmem_addr = 0,
@@ -711,6 +712,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
+	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,
 	.vmem_addr = 0,
@@ -758,6 +760,7 @@ static const struct venus_resources sc7180_res = {
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
+	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,
 	.vmem_addr = 0,
@@ -811,6 +814,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
+	.vpu_version = VPU_VERSION_IRIS2,
 	.num_vpp_pipes = 4,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,
@@ -868,6 +872,7 @@ static const struct venus_resources sc7280_res = {
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
+	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,

-- 
2.39.2

