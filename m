Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606AE6F66A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjEDIC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjEDIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D574204
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f1394cb0d1so175190e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187302; x=1685779302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPLFybUnSCLJz0oCMRR9jsL5keYJ4n9HhX1ELcMGsYM=;
        b=Rm6vE69ZkFmGqXM10Qu7Ec++Ds4AHAx4PppyIKKpic8AdFYrX368gLcW9X1gubcFvB
         IFxP9d5hM/UCRNYFS4TgtMLgzYXfm4QANLnwhgpeLqJzVoAJFyuitM37B8p/i9i7mKrX
         Ik+Qnm8Lnqecmdtr9wNViTilkVjwDekSBIvhBRtum7hQLSgbWpkBD+Obnsuf6ZMHY6UY
         pRz1uR8UtpIlGYpYrVTJ9GfGLtPD+LWMdq4U6xMW+MuI9eULIVKExe90DmRe4oiNXoi0
         B08Zhv2yOUe9hhjlZ0cCj7mUt+KF1z+VREumVuiDz3ptdbsnddlpyk4JiHbpkqoBUBR6
         RZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187302; x=1685779302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPLFybUnSCLJz0oCMRR9jsL5keYJ4n9HhX1ELcMGsYM=;
        b=iemWIgfjUfaNizG6jaiQVGEN3ROCwzHetnT6xqM+fgccaeQ6NQKpBfieSIcykO+AGu
         YrMSVcjaWRckou36CXOVXCctL06uUbBG9PCrXGj7BGHG9I0XsnjqR8N5pvahKRmV4tkR
         IPCBTVZSKGKMMdCBdRyo6Y/FPm4ftyV/7w9vMUIVhTfu3zfWSgDmLq+zvPTQz/tgc/aw
         0naKJY9S13h7wR0tFkZcOXUUim6OnII0BbswqvMkZl8ma1SwtYrbZYbO4JyuBGKg4kYC
         /IYXps3dfH+CS5jDsR1jKHRjarlWu6wuOB8ancfqVqe4oXgbrfu9AQVhFR/FPIMXb4Hd
         1cXQ==
X-Gm-Message-State: AC+VfDyACAqYY7gQLMyeYzGKK7ewPxn17Z/AFwIGan81/uof1kcqajJJ
        iZad8cmPOrN7UR+l15H/U8diGA==
X-Google-Smtp-Source: ACHHUZ4QIj9WDDN9cnR7O3jT4v+wOw0gXEM13W3Etrtc70lp0Wm/Pt2n1R4YQ8SQxwcuJibxBk+2ug==
X-Received: by 2002:ac2:5921:0:b0:4e8:c81b:1a11 with SMTP id v1-20020ac25921000000b004e8c81b1a11mr1655084lfi.49.1683187302126;
        Thu, 04 May 2023 01:01:42 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:06 +0200
Subject: [PATCH v2 10/18] media: venus: hfi_venus: Fix version checks in
 venus_isr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-10-d95d14949c79@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1475;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ibQkhpaLOkmp/Wq5qNMd5hbG2R/lmbg93apEMw7+R/s=;
 b=jehrky/1ouQ53cSiRDAu4XyUT8R4vJlTkCW4cUtU5rc8nk3rsH37v8m5njowOHaF1lBOpjZfi
 bXJ7lPH/JDiB3MdQrsQkyVwlfBSY0E2l/3cpXWZ7nrPrmDhI7A6Dq1E
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

IS_V6 was used there IS_IRIS2(_1) should have been and the !IS_V6
condition was only correct by luck and for now. Replace them both
with VPU version checks.

Fixes: 24fcc0522d87 ("media: venus: hfi: Add 6xx interrupt support")
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index ca56b1a8eb71..6d5906fab800 100644
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
+	if (!(IS_AR50_LITE(core) || IS_IRIS2(core) || IS_IRIS2_1(core)))
 		writel(status, wrapper_base + WRAPPER_INTR_CLEAR);
 
 	return IRQ_WAKE_THREAD;

-- 
2.40.1

