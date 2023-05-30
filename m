Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF005715FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjE3MdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjE3Mcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:32:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028A10E7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:32:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af2c7f2883so45882031fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449864; x=1688041864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=473x+lqpzUfA2jtVVPxgqLYhChW/9qnAzMi0phiVfDU=;
        b=SbDg3Cb800/J9YKHr/9xr/So94j1gdK2pCQq2DpZwtW0XYNJzdyj3g+EeFYCuKOswg
         V5g0jjllzu2HJqYY0SRrnpBMVkKsess1Ix85hkjezHpB4EXgk5CuWhzYuDk5A9ovS+HQ
         INCMunxkw/qkfq3euvf7XnrI3JgXorAG6UYdxl0p3pPqYl+io5+JoB24t0JJLX0W6wou
         AEFX7VHeDctfIiLhMkzRYEmR4KlD9p4TAYpz8fKAQyiY6OvGqbNOS8djWboPNLJaukdA
         mj1DcJVsvifEBc2p7JppBBDnL+xWOXUgmd9wqs1TwzdG+xo8+2IGcQzS+Hrckkmzl5t+
         XWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449864; x=1688041864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=473x+lqpzUfA2jtVVPxgqLYhChW/9qnAzMi0phiVfDU=;
        b=ZjqG9VpXkXW7wan5xTnTD4OutddxJQ6i58boimH5zh3L3wd8FUi+vx1Hq814VYdwZS
         DKhMsCmL+iCvqPzL627/D9y8e7BWjFAIWec6dunNxB19LvZN+edaSabgvGY/5gif4s4z
         0XSUU3mt+OkadEbGvaqKShK71u/eaHLujIIteclW7Wwpwj0WXeeKdYYRsTfo1NRZcqYk
         zavhiYujBxAPX7JELfY4hEkDY53GbepDL5z+w0SQMmxBUBMksKQ5cUJZENFkTbz4n0jh
         W+F5HTdB4ibLuLhe0kzRXHF8lhKy2+WUS4SJRfoM1N5vfs/1q2SOr5j1CODTU61rrFnW
         RIQQ==
X-Gm-Message-State: AC+VfDyZM+HpC5BeeXq0D2iQzWFPWmoJgMqZF7VzDFnIS1/A63yw75nM
        jCDjXd+k4NKdZadoYfYgwGweBA==
X-Google-Smtp-Source: ACHHUZ7/QXbo3yHpNDSE14vxr/l3CfeUgwZfQCqZydr5pHp063/LWEiSvqmesyK56npYxU0ALEC2dw==
X-Received: by 2002:a2e:93d5:0:b0:2ac:5905:eff9 with SMTP id p21-20020a2e93d5000000b002ac5905eff9mr690143ljh.6.1685449863993;
        Tue, 30 May 2023 05:31:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:31:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:51 +0200
Subject: [PATCH v4 17/17] media: venus: hfi_venus: Restrict writing
 SCIACMDARG3 to Venus V1/V2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-17-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=1033;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=oNIm1Wj0FhsO3S/n6eYL1/VajszUoAmbnQl8ZF5tL0I=;
 b=EE9MNWA8F4kINCga1/UXPCIhBDawDBerb3GjKdXmHwemGRPPenW+uzKGjJDlutvnjbhxRuBrL
 n2qOIG5TDzJBQ2xwNRHxcaDBE2ggs1hhafCeMzDCs4pTESJoU7Dx3gQ
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

This write was last present on msm-3.10, which means before HFI3XX
platforms were introduced. Guard it with an appropriate if condition.

Does not seem to have any adverse effects on at least SM8250.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 82854553f99e..19fc6575a489 100644
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

