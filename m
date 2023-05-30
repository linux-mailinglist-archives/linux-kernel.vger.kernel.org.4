Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F4715FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjE3McL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjE3Mbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:31:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661CE4E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af2e908163so47238781fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449852; x=1688041852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHPVGbjJBA0Db5NX5/99pqJA6zhMyUu0sO+jgoxH74w=;
        b=TfJC3WPbzJ918/gievnznE/ZwcFlBinuavTQ4Po9BfAFOFkKLC6BMvsSMn2bgGAf4F
         ylbrPfgLRETekQXK3xs5uodxliYY50p5WViq/IErrz2My0QjIfqx2ujNBDWJ3t+waCWs
         siDh6kOP+1rgfM78KlGJ8yYUHKFaJD1hv5zuNPP30mJGW1gaTMw7UQW68g+E3NeydrYI
         oBzfAgxjTTudADMPd49sewz211f0wgdqLFZ+XFILN7x+gSRANDeAGft5AKprRqdh/NBb
         MhhMs8tIQ6PJ2VwWfqkO+cvYFvlsoyysuL6Mxkvn8vl81GoLn/xLheK+4D36WG7SX+Zg
         GxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449852; x=1688041852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHPVGbjJBA0Db5NX5/99pqJA6zhMyUu0sO+jgoxH74w=;
        b=Xmd3ICdBkUrykoKAOqMIojM3Aw8+5Dfqn7hxeFqmybUjbZ7vLyOG7O0HcYIG6haEh0
         AJ8DIJTD6QT2r9ZZLwX+Shc+E24e552sF696V4rJpmmfEd8dfcoXxEg4CdWgJfhISFhH
         SQBFelcGkiicj9H3U2qcyIMGcnRhdQgqMpOX41t/u6/cE47LOyk257Wry2OzeGKp2RKJ
         LvNWD6OGY5m69WzAuPR5yZnIO/xfwyod3rEjFd7wlH3asieS2XDDm4CVPB0C9xgL5BHh
         TtEP45Z7l94+tRF0tOgMwy7xSqW4lNP5B7/OUSDRBaJ7ugFreDMpr8UWmQmRFU+vlL4T
         vwfQ==
X-Gm-Message-State: AC+VfDzxISYG8YTkw7a36DleS2RyuJGyrTJ9cOIBKD+J/l32IQxwfhWT
        /d8DMX4uYPXOmR09qQlIYu6NeA==
X-Google-Smtp-Source: ACHHUZ7pYkqFll2vdHt0IWGzDg39n9bH07VlDBfSMSaNf8DRKQ7SWKFzD/dODWeEx+ArtrAaKHNn6Q==
X-Received: by 2002:a2e:a212:0:b0:2ad:bb53:8b9a with SMTP id h18-20020a2ea212000000b002adbb538b9amr772535ljm.20.1685449851577;
        Tue, 30 May 2023 05:30:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:43 +0200
Subject: [PATCH v4 09/17] media: venus: hfi_venus: Sanitize venus_isr()
 per-VPU-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-9-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=1296;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=F378bEBVQejn0ekkF/wJCvXE1cklNHMQZFzTNKZSqSE=;
 b=6cCLhcsld50rl+TGqoJgykbJLGOa1JqrHParUU3GM6CVGBKnKZF2l4Ix69R/uXef9M+pWNqdG
 lqI0ZcNJQVoAEA0S4rrrPx/3kk9oYpevUwfT+md++1QrzwrA/dVIYAv
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

Replace the general IS_V6 checks with more specific VPU version checks.

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 60252d05781e..5e4b97b0a4ae 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1109,7 +1109,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
 	wrapper_base = hdev->core->wrapper_base;
 
 	status = readl(wrapper_base + WRAPPER_INTR_STATUS);
-	if (IS_V6(core)) {
+	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
 		if (status & WRAPPER_INTR_STATUS_A2H_MASK ||
 		    status & WRAPPER_INTR_STATUS_A2HWD_MASK_V6 ||
 		    status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
@@ -1121,7 +1121,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
 			hdev->irq_status = status;
 	}
 	writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
-	if (!IS_V6(core))
+	if (!(IS_IRIS2(core) || IS_IRIS2_1(core)))
 		writel(status, wrapper_base + WRAPPER_INTR_CLEAR);
 
 	return IRQ_WAKE_THREAD;

-- 
2.40.1

