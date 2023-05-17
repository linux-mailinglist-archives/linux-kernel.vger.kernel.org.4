Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119017073D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjEQVPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjEQVPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:15:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE183FE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so13075681fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358092; x=1686950092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7g4tYUCSnADCqdupnI6ZWhiqSVw5byFBn9Ee75pCtk=;
        b=E70vNCXLDgz8mutLEzPTMRQPL9zsJYV2fbpYj2M9dCTgYwOFO86MzzSOaBIs8f//uR
         Wl6Sddh65UrrQ9bi1I3USM79J3FwISK2S2d/rwj2SJ86QzCkYLlyEcxYXRZsB8nZYDz2
         I5OIZ8RcLE/oMqurn9GkHpDfyNda6FmpN7L8Z+zrXCmOt3V0oHkYCiAlSs+mcRgRANdR
         gTSwLnqvvhfWbVmsmqr4wwn3rDF1H2Q0WD4/fFS4upF4wyKqUJjkGyX+ysINOeTpbldT
         ZE1jrzRzhxDzTn+sdZQcnv38T6bUGICzLOMgqkvNBKqP5cAfXqihCj+UaJGbO6KNIRKu
         H+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358092; x=1686950092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7g4tYUCSnADCqdupnI6ZWhiqSVw5byFBn9Ee75pCtk=;
        b=FQ64NaA/kP5f6ZOMV2PMsXcQypkiH0+V0tci9/4XFqkvWuZNoCDWZ2mrmOR8nDde8m
         FkwPboqIXX1t8khZRtO5yW80j+uyf7ntFKItgh/n5BKqjRrfm4gMcEE8/UyJtRtREHt5
         uBXzgurkqplYyO/VP6n/zqyBYkKWxaMzBw7IRbk3DMK9B+w/2jCuy7CAnuj2QZl7rc46
         x+ZcqFdMXOVjFJXovhLfBRoEAe2wCLPsHzLuVqGMl6saeA0thTSk+0rKTzFfOQoHL7S0
         wDv24DkJ1/xEEKb6YQNErZUPugEqOGcd2wwbd+Mrqjh5Z2NsC72y/kZFkurJtMLcoU4y
         djoQ==
X-Gm-Message-State: AC+VfDzrTHhgrw4Tkkew9XIqk+Ehtwdf3TBQjsWVQINwgMOVyEzu6xkw
        4QQM75n+JYwwdUzCgLWQ2/bAbg==
X-Google-Smtp-Source: ACHHUZ4JykT444pZCOuyCI+MvVKcjXoebBsi9OFSJTqQZdNYJXrAjL8SsQhQYwuadF7y0/w3lznuTQ==
X-Received: by 2002:a2e:8782:0:b0:2a8:adf6:b0e2 with SMTP id n2-20020a2e8782000000b002a8adf6b0e2mr10150800lji.13.1684358091922;
        Wed, 17 May 2023 14:14:51 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:30 +0200
Subject: [PATCH v3 17/17] media: venus: hfi_venus: Restrict writing
 SCIACMDARG3 to Venus V1/V2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-17-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=1033;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=aCglDZnAfwj5KEsWFEt+s9yuCbYnCkOVxbgN1N7xiwc=;
 b=9kC+UvZMPpwn1xet5596Txb/EcLZKO4oPkdMyS+SXZGJBhMVAfM3Zmy8uJu5Y1I6f9uZO5/I8
 L4T/MfdnDifDjMHFSXqopWzGLq2PZe2OeV03NsW6iq+zTN9g7bl70Mp
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

This write was last present on msm-3.10, which means before HFI3XX
platforms were introduced. Guard it with an appropriate if condition.

Does not seem to have any adverse effects on at least SM8250.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 105d49fb72be..9a8aa3d8e0f3 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -462,7 +462,8 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	}
 
 	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
-	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
+	if (IS_V1(hdev->core))
+		writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
 
 	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	while (!ctrl_status && count < max_tries) {

-- 
2.40.1

