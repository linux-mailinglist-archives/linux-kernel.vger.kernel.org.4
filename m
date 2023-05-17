Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4F77073AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEQVOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjEQVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99866E91
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ad89c7a84fso13440481fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358069; x=1686950069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cmL4u+Slx7l2A0wEzo/2w7BTBeWrOV7Pv60ybojUJA=;
        b=ER9r6Br4mcYlDn9S+VCz1x5xjWCFtW3c+PQBQAsY4cIrB4K2FuU+obzKEKleoP6sfa
         58m6n1C5IQg3svsG7p5CIM16Jt+CY8LFUv4GuKygxQCfEP0aWaW/g7rK67a4z3EtaFU2
         N+3e61wLZSqq3NB96zrurirR9zjFoyttsryDBirZAiNiUpE2FLct/NRiDkomGJCBiPRp
         974iJWrFULvjb6DV9jIgT2nvXkdqHQeAYPiHsn5V95rnMfxAih/ueCjfIdaCNnf0C6+D
         vGusEM5ZhRJG+x3AYWeZbxzWhjmgeHsubm287QeJDWt+Q5qAmVFxOv9prKuMVdrhSYoE
         f3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358069; x=1686950069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cmL4u+Slx7l2A0wEzo/2w7BTBeWrOV7Pv60ybojUJA=;
        b=JmXTUBYJ05ZXNAsreYR/JcKLSFpOUp21X0HU8SOhKI72WPQLNwjc6cQ7zIoYxngxHC
         JU1+CFzssZIfLQoUFEaIs3yd1jfrQwFH5uAS6Q9Zun+9LNKAIVziFzjwX74Q+2BBGO+4
         GLo01gowBgZIzKLcujiHbj38KL7gYWFsScwlDf8xo1guHy+DPlSBIJ2iNjTK+oiyi62q
         eJwSILRCF66JWSSxhbLf5qA37Nt76vvZzP6oXizQoxb4wxQzcnQXlhyg6XBaV9yc5oR3
         c6P5s4gz/kP5l2TN9Aayie72UW26KVds6at1TqcqIPKpsQha4sJi8jXtT+GL1m5nWU3m
         mkqw==
X-Gm-Message-State: AC+VfDx56pZ/pAebjV5B9L7oqF9Oy1bJemgDuTINXRuLTWLug3Wlqu2t
        FcZgxXlJ++xI/r7UxEqySMfnzw==
X-Google-Smtp-Source: ACHHUZ40rSRd0kTcTtQFpmLfCfr2FarYLUQG4NFHRCdETeTyeuiqFxeeW7g+LCyD9Rd67VHir2d+cQ==
X-Received: by 2002:a2e:9e0f:0:b0:2ac:7889:3aa3 with SMTP id e15-20020a2e9e0f000000b002ac78893aa3mr9695712ljk.18.1684358068921;
        Wed, 17 May 2023 14:14:28 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:15 +0200
Subject: [PATCH v3 02/17] media: venus: hfi_venus: Write to VIDC_CTRL_INIT
 after unmasking interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-2-6092ae43b58f@linaro.org>
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
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=1518;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OBi3iN9xHm3GkjRVCscvcLpgwCmitvtLl8nO9ocX5Gw=;
 b=WsAuikeiUnp5EwlibVmUd2TDnT+hUdw/xJt1naAfDqykGAHiU3/qguA/UbO9iwLOPLS69a5Wf
 SpDduUtnPfYBsfaZbC+DCtIC48GX8tjNbe9ZT5P8/fyQv/HOzpyMM79
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

The startup procedure shouldn't be started with interrupts masked, as that
may entail silent failures.

Kick off initialization only after the interrupts are unmasked.

Cc: stable@vger.kernel.org # v4.12+
Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index bff435abd59b..8fc8f46dc390 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -453,7 +453,6 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	void __iomem *wrapper_base = hdev->core->wrapper_base;
 	int ret = 0;
 
-	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	if (IS_V6(hdev->core)) {
 		mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
 		mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
@@ -464,6 +463,7 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
 	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
 
+	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 		if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {

-- 
2.40.1

