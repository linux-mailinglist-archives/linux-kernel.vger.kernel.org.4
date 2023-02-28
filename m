Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E96A5BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjB1PZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjB1PYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:24:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9426B30E8A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id n2so13656592lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zJn479IcitDv9y2x8/xGaUK4fklDoWt49Sew7oDQTk=;
        b=awJOG1x6vvDifU8IO+8pYduD09ixIs0ijf8kY0Lj9ZERnN0/d33XytUi3bfHwIAspP
         Zh1CexMr4O4vkLNRNuR7mtmxaFX1oNSdPuD/IZqLRY6LEXlMDL+U8BXO3xjXRGh8kZXP
         g/Fer7Y9BHi44jt04itYxiZcScRxOOtIqpUZhb204GwEm1MPU+rcXJ+oZBe7cUzRFrUX
         5Nn+rNCUDMJFA2or8YIgp2Hetzz2aQLO8pMjEwavCMOtBVXhaB/Fr5x8hyzz/TsezJcz
         2mdXUHy651+YdHU2l+1WLhxmA/JsODoR8m4t5KxASNTwedjcYQ/mZiUzJMmYPkTbNqTd
         jvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zJn479IcitDv9y2x8/xGaUK4fklDoWt49Sew7oDQTk=;
        b=3dF3Pc3LJihyZboRi+kojoQfdXwNpuicKtt4sZ3Q1QjLiOvACTk8+x/uCGV9h7BPAM
         aVbe8AFuk7aXlJpNUcW1g84tJtNSGsnyZ62RYTvbfvjKdzx0iBW35pEmsuL9CicaF1GP
         bRUE/2VXmaWkUlB7JkI1xQ2K9Cf4Aj9VwcWafaLSP4GOuDk4dL9rnybMj4ggEwcBIWHp
         qURCRcJ0t/n/rx3ZSd1+coU8JDhOLrVm7AWDJnHtxk69bWGBPze1YwP/qh6TTiFU3/Ob
         5+La4rKo1kjcnV6zWf5i00Lz+vBWlDOCLzYjJbmiu7Vd60nO9zwBDhDOwaTMAFICT6sR
         3hvA==
X-Gm-Message-State: AO0yUKVDFx6q1BXKJQ6GJ9psnJbmdz+V6QMduSND11RQx2RuhXXah1sW
        hRzeWIIGnQgZKf+yev5qLHjoIg==
X-Google-Smtp-Source: AK7set+LuimS/qwgMAM/OiVqoaphc/qdq8Zno+c6ljdc1DPhe5d0rox1juH27r8CC5IvDEYLWrkEig==
X-Received: by 2002:ac2:4159:0:b0:4dd:9f73:f3f7 with SMTP id c25-20020ac24159000000b004dd9f73f3f7mr770788lfi.64.1677597888954;
        Tue, 28 Feb 2023 07:24:48 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:48 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:33 +0100
Subject: [PATCH 09/18] media: venus: hfi_venus: Fix version checks in
 venus_isr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-9-58c2c88384e9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=1416;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0FyKqrw1Z2G70EdUUzUQkOOkBEgG1egwrSn1MIrNYrM=;
 b=UN8UtyczdV8UrzDPjLnovtj6Qv0MdUw/ClSqkBV90i2Hmtes5INpWmt+IHINqWRSxMRs3JHoxcLB
 d6Scg9q6BSWRjG5AEzM1IciXaVnlrNv2b+Jp+ZGk0ypDxaxpUEdo
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

IS_V6 was used there IS_IRIS2(_1) should have been and the !IS_V6
condition was only correct by luck and for now. Replace them both
with VPU version checks.

Fixes: 24fcc0522d87 ("media: venus: hfi: Add 6xx interrupt support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 0d137e070407..ecfbac36de20 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1136,7 +1136,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
 	wrapper_base = hdev->core->wrapper_base;
 
 	status = readl(wrapper_base + WRAPPER_INTR_STATUS);
-	if (IS_V6(core)) {
+	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
 		if (status & WRAPPER_INTR_STATUS_A2H_MASK ||
 		    status & WRAPPER_INTR_STATUS_A2HWD_MASK_V6 ||
 		    status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
@@ -1148,7 +1148,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
 			hdev->irq_status = status;
 	}
 	writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
-	if (!IS_V6(core))
+	if (!(IS_AR50_LITE(core) || IS_IRIS2(core) || IS_IRIS2_1(core)))
 		writel(status, wrapper_base + WRAPPER_INTR_CLEAR);
 
 	return IRQ_WAKE_THREAD;

-- 
2.39.2

