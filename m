Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22B3715FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjE3Mbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE3Mb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:31:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA1E19D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af30d10d8fso45109011fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449844; x=1688041844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umRAJMqKc5zF6FOAntGSMEcHnMlgnfWakGEzWkoJKuw=;
        b=jnsR9g/cD1+a55KbA0DPQEh1v8dBMUVwa/pGnmLJ+EVsv+7FrPJBwGBzq1awiJBwV4
         5506xFpPIY5ajiUdPzQl+0g4iUuqY/im9vQ8uqpTGe17pRNVeP5rmg18J98QvNACxbs7
         C27pNj3OghpqkdAoSBYLbylG/VO2qVD1EO2MH4RRlB2cuhU6Qbpt45+VkfJAul4wR2ar
         gT7I6v4GbsTEY0HQBvl8IerIJ6/Ccw8He7THDGAgTjH5KrsoI04ux/TeQ1UWkrBcO/bX
         Xaw3qxmXZ6fcCRbbVx3U8LYB9iUabRIHuipMCx7eQS+s1ZGctoT6p9MZwWtSwbelnpJA
         /P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449844; x=1688041844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umRAJMqKc5zF6FOAntGSMEcHnMlgnfWakGEzWkoJKuw=;
        b=WapNsN+ARgoToh/4+MmgQxfeikuRAM82Xn4JKpxEcbYWYftIgqHWnr53ViDsvFWhGV
         FmOs/V7HiLFtxCCYpV3Hd0WU6eAmEjy+OX5VOKAxJrEq0h3U2lFvWwrRxh9gyY81txk5
         WDsDF4Y/DHDTVHgb9IK8Y9mfAwaxfCrZ9KaSxahwu6FsgiurxmUfVT9+ePCaR0/W8xSH
         vOV0DUFDl1N2nS9qYGVtTgYS/NjR1LAbTnoH/JVWXbsN+/HXoIUTh/2qo+LfPwZ/P1wB
         DkqMHCoRKn4PyySrK22RpT/zwJWgTRvjeWfG+cS9soibuPLcxDj38w+qPkBUqZfY6o8P
         dBcQ==
X-Gm-Message-State: AC+VfDxacOW4pIBIXctl10e0q52dZ0Gvm+sRktCjkhSXJqBqtSGvppds
        G2SrCNFwukpih/0/y1cG/+faog==
X-Google-Smtp-Source: ACHHUZ6/nBGT6VORi7yfg6oIBBu1olPvsuDxuH+z4vUTD91hksgdUQcZ4INGN63Dh75knKZ/1EJarA==
X-Received: by 2002:a2e:b349:0:b0:2ad:dab5:fe8e with SMTP id q9-20020a2eb349000000b002addab5fe8emr696053lja.47.1685449844609;
        Tue, 30 May 2023 05:30:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:38 +0200
Subject: [PATCH v4 04/17] media: venus: Add vpu_version to most SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-4-feebb2f6e9b8@linaro.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
In-Reply-To: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=2055;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nc30HaKHpy9R0tdyW3Z01908RNfbGE4dIZSAtIHTLSQ=;
 b=FARdtRF1h/o8OTBryIzEh0kRUC7FIYB57opTKh9EHQjhSK1TwYa+NH420fna6UIVIQm8bPO2F
 hFfOaXBuRe1CHneEMbIbbAIPfWlInwcEMeQCizXxlpl4NMRJEgpiNmb
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vpu_version where I was able to retrieve the information to
allow for more precise hardware-specific code path matching.

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 2ae867cb4c48..01671dd23888 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -684,6 +684,7 @@ static const struct venus_resources sdm845_res = {
 	.vcodec_clks_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
+	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,
 	.vmem_addr = 0,
@@ -709,6 +710,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
+	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,
 	.vmem_addr = 0,
@@ -756,6 +758,7 @@ static const struct venus_resources sc7180_res = {
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
+	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,
 	.vmem_addr = 0,
@@ -809,6 +812,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
+	.vpu_version = VPU_VERSION_IRIS2,
 	.num_vpp_pipes = 4,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,
@@ -866,6 +870,7 @@ static const struct venus_resources sc7280_res = {
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
+	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
 	.vmem_id = VIDC_RESOURCE_NONE,
 	.vmem_size = 0,

-- 
2.40.1

