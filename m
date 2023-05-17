Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411317073B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjEQVOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEQVOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D507C83F2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac7c59665bso13373721fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358072; x=1686950072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umRAJMqKc5zF6FOAntGSMEcHnMlgnfWakGEzWkoJKuw=;
        b=xCQfwTscEvtS2rrOux3FRlqc0g861cQHp8W+wx4MmACk6AbBbjvABF7ylMkB1utg2w
         iepKJ3Xe9+zKqFIvFu7T4N4ZOxfQZtFAJZHN2AAseg3aVfwMb56JDEz4f5oPCSZcU7yc
         mfAQmN3xhtCVo+1x/UKM/UJxXIxdcqzyKI12LH7OmLTecgSbPFbwJZQ5PamRAqhzz9Ua
         WARLlGezEb9UlUS15/atY9lZ10pDG4k06zgo6t8LQjIzcHPgpUjTYfk8El1vJcKGyVMO
         /XVh9H07d9UzUJ8hUHPxnK40T2DeFmGcleRB1g57ia59asuZVf47cROmRJzVBXGM9LrJ
         2raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358072; x=1686950072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umRAJMqKc5zF6FOAntGSMEcHnMlgnfWakGEzWkoJKuw=;
        b=c5dIYwf1fkSSE108361bmGcs3jk9X3BK+i5EnmhhzbuAJj3qAAItQFqxWE6AwCrPEo
         1oIGYBVhmQeSQyYUIJmBJ3Ek+HUGUmJKOgsFRcyOaTFUG5Uv3cyvhCFNdMNPe6byzEib
         xIW2McA5ULF3fkGtaJQYRUcCOVLfjABQ63/au1VdOOkTANsy2ibVzBuncQF5mwY7iM0T
         HaRuSotSPvT1jcm8RXj7aUiz0mg++oen5rGXP0QWB0W/Si00nJ4C2fCQv0jrh+xUg7XI
         RWX3B45S9+uK4h7vf4dkfZfPE3ig+Z7MFq5RXmlwgZkHySZagAtUVE1gVnfU0zo2PTnR
         0Q6Q==
X-Gm-Message-State: AC+VfDwi7jB8nLPYSa4Ea3h8zg5ftRYyesfBRitujflLWjr8pWDuSn1N
        WbGZ0qsv23UOTHV31yEL1v4azw==
X-Google-Smtp-Source: ACHHUZ6bRdZiWx4+kMVTtpzPkUtuso8ZdtBEASLvPQSebYOcaJbFL78oPbNh4Blk6kyNIKYSua7MvA==
X-Received: by 2002:a2e:3201:0:b0:2ad:8f4a:1e52 with SMTP id y1-20020a2e3201000000b002ad8f4a1e52mr9502642ljy.30.1684358072091;
        Wed, 17 May 2023 14:14:32 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:17 +0200
Subject: [PATCH v3 04/17] media: venus: Add vpu_version to most SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-4-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=2055;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nc30HaKHpy9R0tdyW3Z01908RNfbGE4dIZSAtIHTLSQ=;
 b=YXKIWgtmy6cmCJsJJvLU4SOyJogiI+vvX3h3IUV8wCW9zGscSByxBEcJEZbzB8DDLQbVhwW+j
 xKexNN9dYTyBNpkvH74EMqflr76LpD6nvs/cJ+BMjqxephMCpvg/TqE
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

