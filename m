Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677EB62BC58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiKPLqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiKPLpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:45:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DFF5AF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:30:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so2663663wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qxHyJFGHhLk0RSYc9bAx1DwP95osQN3qHY27P7is5w=;
        b=oXzbOeUJBhkDcNQNA+LhGQ1ejuw2y8CDvdSn4hdT6xOBu5ml37hUeNo5dhXoNEKXnx
         v3drru72QOYiwlCDwdZsiMVEH0kkIhKoXQOCztFdFqTEm5yOU3519rWbuw2bMype3EOU
         FSvkP60h0IAJgQQTP4Kk+tMm1iwZHIoSGr11285KT9FYqPunL+jBnly0If7dP5fhyVYz
         ihG01bfR+ja3QsLVdnShTflno3TxXfWjomIPG5nwQejLrsGmdDyMN95CmOCAS4uldAUu
         oG6PSfrtl7s0PdVQJ9227dwxTFgkWhPEUYSEBPPrRnbCIfwK0USXke0Jc3LyCbit0Des
         Cclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qxHyJFGHhLk0RSYc9bAx1DwP95osQN3qHY27P7is5w=;
        b=Pya8Pio9QXn2JtrFAHsebC9NPfuKN9EluNagONINtOSldlGUjstiFcnt3NYrSZIQVB
         E8eTv40bo9C9Pu9A0t5ajkXyQ4h7p0sN7Xa6kj84UVyfOWcK8s5qmVh/5Zif3cDu0ord
         xjN5oVp43Kk7wYwyj1ax2Q10xT7wfvwr9lurveFRe338dm2W2SSWLYGikrV8Xolqm8q/
         oPODbJcSpKis6A+DwIhVVb/JZMVhPZBAhN2WgKgq8I+HmWAtTVE/mdm442VFRinkgNDo
         yFvvkf2xv/Q8+KHGYK1DwvJJFXmwwjyjZkb3kVRcJTclprd51OkABESzBH2+ESocgb4i
         NaFA==
X-Gm-Message-State: ANoB5pnEyQgKkj657HSgvoO0CZSBdUY3QBIxufrzRpEs3zondQR8w/0P
        JAmHPoizn/gCQgIrKSSU8auixg==
X-Google-Smtp-Source: AA0mqf53s6hdtUjVxn0hzNTqWjfDRkrSsNRMEisRxC+l7E6DfsJo4bGF9C+kFq2+PPTdKR7YqSXd9Q==
X-Received: by 2002:a7b:cbc3:0:b0:3cf:a83d:28d1 with SMTP id n3-20020a7bcbc3000000b003cfa83d28d1mr1883235wmi.57.1668598225101;
        Wed, 16 Nov 2022 03:30:25 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003b3307fb98fsm1929489wms.24.2022.11.16.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:30:24 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/3] soc: qcom: llcc: Add configuration data for SM8550
Date:   Wed, 16 Nov 2022 13:30:05 +0200
Message-Id: <20221116113005.2653284-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116113005.2653284-1-abel.vesa@linaro.org>
References: <20221116113005.2653284-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC configuration data for SM8550 SoC.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c       | 41 ++++++++++++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h | 12 +++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 6bb88816958e..23ce2f78c4ed 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -318,6 +318,38 @@ static const struct llcc_slice_config sm8450_data[] =  {
 	{LLCC_AENPU,     8, 2048, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0 },
 };
 
+static const struct llcc_slice_config sm8550_data[] =  {
+	{LLCC_CPUSS,     1, 5120, 1, 0, 0xFFFFFF, 0x0,   0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_VIDSC0,    2,  512, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_AUDIO,     6, 1024, 1, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_MDMHPGRW, 25, 1024, 4, 0, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_MODHW,    26, 1024, 1, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CMPT,     10, 4096, 1, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_GPUHTW,   11,  512, 1, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_GPU,       9, 3096, 1, 0, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_MMUHWT,   18,  768, 1, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_DISP,     16, 6144, 1, 1, 0xFFFFFF, 0x0,   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_MDMPNG,   27, 1024, 0, 1, 0xF00000, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_AUDHW,    22, 1024, 1, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CVP,       8,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_MODPE,    29,   64, 1, 1, 0xF00000, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, },
+	{LLCC_WRCACHE,  31,  512, 1, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CAMEXP0,   4,  256, 4, 1,      0xF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CPUHWT,    5,  512, 1, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CAMEXP1,   7, 3200, 3, 1, 0xFFFFF0, 0x0,   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CMPTHCP,  17,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_LCPDARE,  30,  128, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, },
+	{LLCC_AENPU,     3, 3072, 1, 1, 0xFE01FF, 0x0,   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_ISLAND1,  12, 1792, 7, 1,   0xFE00, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_ISLAND4,  15,  256, 7, 1,  0x10000, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CAMEXP2,  19, 3200, 3, 1, 0xFFFFF0, 0x0,   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CAMEXP3,  20, 3200, 2, 1, 0xFFFFF0, 0x0,   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_CAMEXP4,  21, 3200, 2, 1, 0xFFFFF0, 0x0,   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_DISP_WB,  23, 1024, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_DISP_1,   24, 6144, 1, 1, 0xFFFFFF, 0x0,   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+	{LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
+};
+
 static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
 	.trp_ecc_error_status0 = 0x20344,
 	.trp_ecc_error_status1 = 0x20348,
@@ -464,6 +496,14 @@ static const struct qcom_llcc_config sm8450_cfg = {
 	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
 };
 
+static const struct qcom_llcc_config sm8550_cfg = {
+	.sct_data       = sm8550_data,
+	.size           = ARRAY_SIZE(sm8550_data),
+	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v2_1_reg_offset,
+	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+};
+
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
 
 /**
@@ -986,6 +1026,7 @@ static const struct of_device_id qcom_llcc_of_match[] = {
 	{ .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfg },
 	{ .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfg },
 	{ .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfg },
+	{ .compatible = "qcom,sm8550-llcc", .data = &sm8550_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_llcc_of_match);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index bc2fb8343a94..ad1fd718169d 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -42,7 +42,19 @@
 #define LLCC_CPUHWT      36
 #define LLCC_MDMCLAD2    37
 #define LLCC_CAMEXP1     38
+#define LLCC_CMPTHCP     39
+#define LLCC_LCPDARE     40
 #define LLCC_AENPU       45
+#define LLCC_ISLAND1     46
+#define LLCC_ISLAND2     47
+#define LLCC_ISLAND3     48
+#define LLCC_ISLAND4     49
+#define LLCC_CAMEXP2	 50
+#define LLCC_CAMEXP3	 51
+#define LLCC_CAMEXP4	 52
+#define LLCC_DISP_WB	 53
+#define LLCC_DISP_1	 54
+#define LLCC_VIDVSP	 64
 
 /**
  * struct llcc_slice_desc - Cache slice descriptor
-- 
2.34.1

