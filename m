Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7C6F669B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEDICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEDIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A4240D9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f1394cb0d1so175008e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187297; x=1685779297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaAO6KbucUD7sHLqAUICCg61yVdFTkFkYPZOacYDIUA=;
        b=YWeqp4eIilP1QTmr9LlCR+XFh3h3RwZBNg5GrOa6+n2wSitL7fNb6un47ABP5pOMNP
         l9bc4Z0eg4If7ffQ5viyJTDrmfU7j/SwxH9hCwRZMJdjZZnqGRoHZKEkI4Tj4pziN3AU
         CWl4mQJUHJxDUqT9plBZ5V5NFMrSlo5vTq/0Z8R2EnqtO3lBGk/atYmsAT8mzn9rpwOR
         z75CgJlCX0pql/9uw4X5BxWgptsA3axkYUCtHO9yZDFXJhgbqA00OyntjWrBcP7wKxuH
         QM13MJy8Er0UV4o0IbFy4Sw3A8yK0kJwBo00tH1eNEfAqzG1j6+8WkI6MQXvN8/6cTbM
         kkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187297; x=1685779297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaAO6KbucUD7sHLqAUICCg61yVdFTkFkYPZOacYDIUA=;
        b=i58F0Iz3eu6I5xNqBdR46t/HMugyg4co/4qQHH6tU4zN+wT0vu+0QNWSNLYRkkzzvP
         VyGepy7NIznlVldepFwmZP23Jm1ppbyY8+fvgYPCs+YeePaYJvnyX9VmW1G+lRoiCosP
         Tos/cuKFs39fKThzRDp2QbbrelIP/BSSw1cs1JiqZmZ02hHLtD2//K3rqm07hbw2PTvx
         FfH0Roy88Ap7ptjLqh+XBC7GzET0f73EJJ3v/ZBnE1bCpfQm1mcjkOXZpbEOfozYZEAp
         Uw+YLQHyfwstP1XAyrPXbZgYMhYJOW2bPLN89jK0cq8Z9KhUHH6gEs0pya2ujAR3UhQT
         B7Ig==
X-Gm-Message-State: AC+VfDzL1/V2PHt8M/FVoahE0WLHO2lYy1UWKK/9WI0/aD3rx2o4wtc2
        c0Z9tc9nTGQwi19AKIDXHtMo+g==
X-Google-Smtp-Source: ACHHUZ69PmJuZEEsn/7Rao4cWdVRqYPLQ+gr+DPp0icoV/BNUsb++4UpSyuhJyrWdiN6ylRL46IW5A==
X-Received: by 2002:ac2:5551:0:b0:4ec:85f6:5bf4 with SMTP id l17-20020ac25551000000b004ec85f65bf4mr1560630lfk.67.1683187297204;
        Thu, 04 May 2023 01:01:37 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:03 +0200
Subject: [PATCH v2 07/18] media: venus: hfi_venus: Sanitize
 venus_boot_core() per-VPU-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-7-d95d14949c79@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1840;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jgU7eoLOdocZ2/cCE0wfh1hS/YMFv/9bQw2DJ7khniY=;
 b=rkj9z6gxfeKGh/ipIT6gpC8Zndl9khftLdh9zsxLYTn3gIX2EfNqR3vjS9w7D4yFoUzHe/ewq
 vWfYg/7gh4uB37EtSzzr325y6WxIgn4XLTvdbNyRTrgJ/txsIqG8841
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

The current assumption of IS_V6 is overgeneralized. Adjust the logic
to take the VPU hardware version into account.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 8fc8f46dc390..9b840440a115 100644
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
+	if (IS_IRIS1(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
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
+	if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		writel(0x1, cpu_cs_base + CPU_CS_H2XSOFTINTEN_V6);
+
+	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		writel(0x0, cpu_cs_base + CPU_CS_X2RPMH_V6);
-	}
 
 	return ret;
 }

-- 
2.40.1

