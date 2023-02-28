Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2042D6A5BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjB1PZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjB1PZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:25:22 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8F2B29E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s20so13653990lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZkaCJiZZhP7M4QpTnBKecqE3oGLYQNzII/qpkWF2DU=;
        b=pSUhAczdlcMpDN3XecezofrJ6Vn6cJgvRcxuLYVuzXR12HPdwJN2GFJlUze0lceQyG
         7iV8TTth2D/JCmiICmPMWcTT1Weo9ZEqy3VuKpIqEMm+JM0lBaYsdLMHSprI3JJWb8Rj
         XF7Za336KhapXU7OE4KFKsGg9T6tw4dNmE3tfYE9QwqCYHatNb/4r1A/Il51TVRa5nYy
         8OVVUIz/x7N2RhJf2mrCGI6xHaoUOycHECV1U6xVYrx9qLQVazwn5VXIJ41dWK3gXXYZ
         Q+lPuwU3S34HUCn8DRwDjQrhv4EJ9CWEVepvP7m5wvXOHfE0R2jmkEUE0OVEdR1VbiFn
         yLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZkaCJiZZhP7M4QpTnBKecqE3oGLYQNzII/qpkWF2DU=;
        b=Q0uMLPWDr7RBr1IpnoEJHR6/AW76Ug44DVfttv93Wu2D+P3G4fFmIuXkPLPjH27Z3I
         2d3rg+QYH9//P0M5RmkPJSJYV0vobiNxzX7JOUD/f7lZ2lIWwKArN1TgOPvyae8uG3pc
         6T4Tj8TXAmwlKoBvX1rIpy++WXj0ne2oJZB3dMclY7xHayvluNW2ui4RkbayHzRXp3hC
         ovSVmaJp7SCqIcdjr9HKDtV2ubuk3QcRNJN62YVzwEn/o8ePe1Om9UCQgPIKn1y54lEh
         r8xyJGiupIXluGZhkXBMTv4/R6IF9qS+64yGPR6eG2rke6ho1Ue/zDgSgBoVzO35I1fZ
         gdLQ==
X-Gm-Message-State: AO0yUKU6HTzsFappu0dUCzjq+MUkZN97pvjGJlWOn2kyWMO0oiUltl7d
        SWRIG7kVsHMM0C1WxC94L7etugamXeuwrLPE
X-Google-Smtp-Source: AK7set8GxrfZrFbu2G+dj6kvtuj6U3ZATUJ5KdP+qZVThilMOPaW6ic4cY5gVLbnoD/47yYhmWxbHw==
X-Received: by 2002:a05:6512:230d:b0:4bc:af5:b8d9 with SMTP id o13-20020a056512230d00b004bc0af5b8d9mr1095288lfu.6.1677597893419;
        Tue, 28 Feb 2023 07:24:53 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:53 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:36 +0100
Subject: [PATCH 12/18] media: venus: firmware: Correct IS_V6() checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-12-58c2c88384e9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=2314;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DnkwDzLQUiE5JvVncPl6/mqiwBIKHuhJRybXTxaOOyI=;
 b=+DebxnCvGPvYpYTlwV3brQl9RuhOYNr/o9edS5Tl0a0hYrTjoEBsDmNO5WO5R71OLSEZ/aEJ0kiS
 WkAtvxPAAKN49hkxSDw6S9PAY61oHFHaPtflX/6OHteLI87vNv29
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

Most of these checks should have checked for TZ presence (or well,
absence), as we shouldn't really be doing things that the black box
does for us on non-CrOS platforms.

The IS_V6() check in venus_shutdown_no_tz() should have checked
whether the core version is IRIS2_1 (so, SC7280). Fix that.

Fixes: afeae6ef0780 ("media: venus: firmware: enable no tz fw loading for sc7280")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 1bb6406af564..10d3805dc2cb 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -29,7 +29,12 @@ static void venus_reset_cpu(struct venus_core *core)
 	u32 fw_size = core->fw.mapped_mem_size;
 	void __iomem *wrapper_base;
 
-	if (IS_V6(core))
+	/*
+	 * This may sound counter-intuitive, but when there's no TZ, we gotta
+	 * do things that it would otherwise do for us, such as initializing
+	 * the hardware at a very basic level.
+	 * */
+	if (!core->use_tz)
 		wrapper_base = core->wrapper_tz_base;
 	else
 		wrapper_base = core->wrapper_base;
@@ -41,7 +46,7 @@ static void venus_reset_cpu(struct venus_core *core)
 	writel(0, wrapper_base + WRAPPER_NONPIX_START_ADDR);
 	writel(0, wrapper_base + WRAPPER_NONPIX_END_ADDR);
 
-	if (IS_V6(core)) {
+	if (!core->use_tz) {
 		/* Bring XTSS out of reset */
 		writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
 	} else {
@@ -67,7 +72,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	if (resume) {
 		venus_reset_cpu(core);
 	} else {
-		if (IS_V6(core))
+		if (!core->use_tz)
 			writel(WRAPPER_XTSS_SW_RESET_BIT,
 			       core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		else
@@ -179,7 +184,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 	void __iomem *wrapper_base = core->wrapper_base;
 	void __iomem *wrapper_tz_base = core->wrapper_tz_base;
 
-	if (IS_V6(core)) {
+	if (IS_IRIS2_1(core)) {
 		/* Assert the reset to XTSS */
 		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		reg |= WRAPPER_XTSS_SW_RESET_BIT;

-- 
2.39.2

