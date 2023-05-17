Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE07F7073C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjEQVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEQVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FC9006
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac735fee70so6100941fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358080; x=1686950080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+mqagyKbbLeYmxfLsA4ErQtn2tgWCu/qclngu8iHe4=;
        b=ve/z3Oz3wYDcUUCrrdAyhzuWlRw6PARpGt+5BepVq9mONktamsPUWOSDyeSbbzOfQy
         k6TI79VrGnZzHmj/wNgs1MREtQ9q9XQlwbFZyEt6bAxlC1R1ZffssbDW3LVlURtiCB/u
         rZWwuVsQyA2mGF8D04RtuHV9uwrMYBKboa497vKQ8h92S4KhwctouiM2Q8Ji1DlgZENx
         g7CFz0ibHy+098KTTn7R2T/XTXzE7rTaJA2ha7QU3zVjuHQ+kcfjMDSThcbJ2qZTKMpP
         BKROIOgDcmcvlJOdrDpts/NSi9APMvdwDPRDtUbQrQqm2wRnZSMx62dVy4akXlDfhwp7
         PjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358080; x=1686950080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+mqagyKbbLeYmxfLsA4ErQtn2tgWCu/qclngu8iHe4=;
        b=Dv2SNZFwZlk0RhiewtsmLIQXlCZvThTzPP/u2FBIfkGcFtVYpmnVOHA+pTj+JJs9mT
         39mPzE3Vfs6GV3xghwAo1VuNmlvszfIsCI4iFjO7CHYuGYmdHpfyI1GDbRvBUqjf0vtz
         GR7twwRAGn8g3FqqozoU/GYr3yUGKto3UzuaERapErtoEmYuBg0/oS9N4llvWlYXVRzf
         qlR9mEm1LSzvHpVEbhboEv0efkvyvz/dR6AAXZoSJowJdVN39XJmXWvFnt/zJdTzJkE8
         OvF3HLHSMLiSkHkJXkKwnh+374jwdOV7uTFdW2KWfiOvaKjz2HfU8ojntIAWrALkGNNm
         qz1A==
X-Gm-Message-State: AC+VfDysZqZBNvjVnA/cnpsR9CpqVfU9Uqc0ceiveM8uAP4LRta1dIRj
        WMnXHxyHKBQQkWUH8VfJVzZkcA==
X-Google-Smtp-Source: ACHHUZ4WdpG34k7NQv5dmiGwwi4kmFQfQcMnvPE1r9yY2KxCl2gD0eQ+hINlRSn6C2kuMk9/dO4ioQ==
X-Received: by 2002:a2e:a496:0:b0:2ac:75fa:eef0 with SMTP id h22-20020a2ea496000000b002ac75faeef0mr1183428lji.7.1684358079864;
        Wed, 17 May 2023 14:14:39 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:22 +0200
Subject: [PATCH v3 09/17] media: venus: hfi_venus: Sanitize venus_isr()
 per-VPU-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-9-6092ae43b58f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=1296;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZwdlwLeKruTsDw0KULMN9qiT9PmoYnKtE1aX18zqNUU=;
 b=gz8BU8HTu41amrQv+L2yV5os7YaEiQCpyuP7RBdxDCTTfQ2GuVF2bR6aNQw+23vlxfRCoR4Dr
 oMuOL/b/PRQD9BdNxYm8HFsTxJt8+sBcv9meiaprvdDt3oGv4nCQzxt
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

Replace the general IS_V6 checks with more specific VPU version checks.

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 9082a2def687..9665fdcfe8b2 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1130,7 +1130,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
 	wrapper_base = hdev->core->wrapper_base;
 
 	status = readl(wrapper_base + WRAPPER_INTR_STATUS);
-	if (IS_V6(core)) {
+	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
 		if (status & WRAPPER_INTR_STATUS_A2H_MASK ||
 		    status & WRAPPER_INTR_STATUS_A2HWD_MASK_V6 ||
 		    status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
@@ -1142,7 +1142,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
 			hdev->irq_status = status;
 	}
 	writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
-	if (!IS_V6(core))
+	if (!(IS_IRIS2(core) || IS_IRIS2_1(core)))
 		writel(status, wrapper_base + WRAPPER_INTR_CLEAR);
 
 	return IRQ_WAKE_THREAD;

-- 
2.40.1

