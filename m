Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17317073B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjEQVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEQVOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7058869A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac8ee9cf7aso13434441fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358075; x=1686950075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SMIxbzQsbA3j3Sn/cFi6oIH9U6UOcuGopU1jwYoxzI=;
        b=ENZ141snmw41TacxRPtH82IJeitzBbxUTAe2ew4flCFkoHjNyObBMHingajjyBeIkC
         rm2gIHCIpKWJwYdss5Fclm9rzqfdqsUMGZz5cyMZjgGz5mSSYhhdAtifYM8yn0r4qTy2
         cKV8eiSqjqIRX2n26e0LSQGsPkbyVznqiSjHWm0zozqvD+2iBmb3pSsD3mWN1JOCA6GW
         VjP76btQMEFgm4dH8A6OmEITY16Z3c2AEm0T5U7TXF3ob1SA677eA+g70Ah33jOL3Y/4
         Jhmvr6x686628QKBAIB5ogyP61oh+tiX4bChuNzlMX15U11tY2NWC6VSMeSpNwNRfQUI
         a6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358075; x=1686950075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SMIxbzQsbA3j3Sn/cFi6oIH9U6UOcuGopU1jwYoxzI=;
        b=NFrleXR56HGVrFhI8rtTNd9biOOtv2k+Gencl6Zb7tLShAYZwdt6CKrOqfb2DMjbdt
         tIi41/9F/iaUeKNOUOj7939KjmPcLE9CAt4sI1xcwomqsDPj9EnV6ULYkL1BbwqXPBwv
         OuYhU2/EGMQHywX5iW64dwkIiyAGIU8prHOilUqkhXQpnnH5MWWC+LCZrP/CUyEnbZK8
         G2MDmGcxE8s7YIhPpsZizciL/64qupUSKXO3H2nu1pZgpprUAPyN/5E3pLSPOXgB88D5
         FvpHgqQ13YVxcIvQKtjEGzVFvjVMJqkD890l81Yo5TO3G/QTFLgDFIDvwuZPVFooXZi7
         nlqQ==
X-Gm-Message-State: AC+VfDwnflKDyDC/HR80lo7ulSJu99TWcNwALixwcaQbfs6jUG+WfkH2
        Y3a8aoup/fL6Z/Nky+Hfdwfvqw==
X-Google-Smtp-Source: ACHHUZ7a4dFPFuSQ31F2rsmq/ckQkqlVG1wnkVuLSWa9zbc+zlig3Duk/oPDsoC5kQjcj4SQDpUG9g==
X-Received: by 2002:a2e:910f:0:b0:2ad:9139:c871 with SMTP id m15-20020a2e910f000000b002ad9139c871mr10062316ljg.19.1684358075353;
        Wed, 17 May 2023 14:14:35 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:19 +0200
Subject: [PATCH v3 06/17] media: venus: hfi_venus: Sanitize
 venus_boot_core() per-VPU-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-6-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=1788;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=R/8X6NFLn14XxMVcEJ6kABO5lC3geO3MpBjA7WOBG7c=;
 b=hShc6PwEdR8dj70dMIWq8olCXlH/tw/vxVtWQbs/94pYFCPJAGVgfuKYA5jN6hzFHDj1f6GFL
 Kw9hTFCgUCWCr5D9gX2iYQ6Vr5TYoFbshK8FoSL9qpYWm3IdJCAFlnI
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

The current assumption of IS_V6 is overgeneralized. Adjust the logic
to take the VPU hardware version into account.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 8fc8f46dc390..5af24e98caf0 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -447,19 +447,20 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
 	static const unsigned int max_tries = 100;
-	u32 ctrl_status = 0, mask_val;
+	u32 ctrl_status = 0, mask_val = 0;
 	unsigned int count = 0;
 	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	void __iomem *wrapper_base = hdev->core->wrapper_base;
 	int ret = 0;
 
-	if (IS_V6(hdev->core)) {
+	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
 		mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
 		mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
 			      WRAPPER_INTR_MASK_A2HCPU_MASK);
 	} else {
 		mask_val = WRAPPER_INTR_MASK_A2HVCODEC_MASK;
 	}
+
 	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
 	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
 
@@ -479,10 +480,11 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	if (count >= max_tries)
 		ret = -ETIMEDOUT;
 
-	if (IS_V6(hdev->core)) {
+	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		writel(0x1, cpu_cs_base + CPU_CS_H2XSOFTINTEN_V6);
+
+	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		writel(0x0, cpu_cs_base + CPU_CS_X2RPMH_V6);
-	}
 
 	return ret;
 }

-- 
2.40.1

