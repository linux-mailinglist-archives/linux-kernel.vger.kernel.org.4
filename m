Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6143701D23
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjENLrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjENLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:47:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF78171E
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 04:47:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso20557736a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684064834; x=1686656834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTu+ijL7vIw00kidH/JRNGgwxxOVvJQCG2CPdE8Obr4=;
        b=w2hJ/CXQ3rtYZlZM5CWisRH2aHdMBF0bobRU7BCwnYRGoc+a3Ot+JuCspJ7APBvlTY
         1dVhmYQv90KF+yOZSnLNXvxD21szk/Q6A4M9uKaayDLCllsgegwSNEeopVh99VJZ8A4I
         PEL0Pm0q51O4GMGtaxkHXADfuaULumRoi3URxyY0X+65cfSXpkxfga2r5khvaN/x7zd1
         SDejhpgbPMq9wT+BlaEaFdppVJMpZNrlKR223+LK4uJJ4PT7d21M0LG+I2QbOgsqtUwF
         dsfv8ZE/QQTfizshoWFYhscu72IKMe60I9c9cTIuu7LGaQ2jMToBJ8IgOY93G6X/JanP
         qrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684064834; x=1686656834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTu+ijL7vIw00kidH/JRNGgwxxOVvJQCG2CPdE8Obr4=;
        b=evd/N9yvWnBgURvqrrzJRwLtENNlR4w2bZ0NyMYGAT87oFbHXITRYwQW5FMCLU9yUR
         6pRSPa+4TWBCrsDbGk62A1H7lhIzOBBhnO5Ny39TAFnslQAWlFuWY5TcbYZMSxbKvMnP
         m6ah+reXo3f2ABNehYazm7p61yOo6vRRY06jgLKLFynypfr0dMhYvJHIVlGjXdGkoDpq
         3C5VzrLQV0q25fwo565T5JbYNfIAHjDotTLtBoY3T1DFV2vdBdlLluxr7AWb8oBnoEbY
         uD4hPxvYw7lB/QImjNrLxQZzmKUA5DynTJ4fpVwQ6agkBb+W0OuPCoWEXj6a2RPDs+DW
         0LPg==
X-Gm-Message-State: AC+VfDzm7DLqNBdhDGvOfaJnYYiv+f1XE2MiaC5XJfranrl/U2lAOyF8
        zCWDHP7BZNi6mazr8VWpvPkN7Wl1NnL+togjWQSdIA==
X-Google-Smtp-Source: ACHHUZ60mOBJTUfgTXnQO8+cMz6T9yj2FB3Ac2l2Pkq/+vAk5fcqxpLQIz3I2b+j/JW3Y/WpJxq9cQ==
X-Received: by 2002:a50:ed99:0:b0:50b:d5cd:612e with SMTP id h25-20020a50ed99000000b0050bd5cd612emr22576455edr.3.1684064833809;
        Sun, 14 May 2023 04:47:13 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:715f:ddce:f2ba:123b])
        by smtp.gmail.com with ESMTPSA id d14-20020a50fb0e000000b0050bc6d0e880sm5648574edq.61.2023.05.14.04.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 04:47:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] clk: qcom: restrict drivers per ARM/ARM64
Date:   Sun, 14 May 2023 13:47:11 +0200
Message-Id: <20230514114711.18258-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to allow selecting clock controller drivers for
Qualcomm ARMv7 SoCs when building ARM64 kernel, and vice versa.  This
makes kernel configuration more difficult as many do not remember the
Qualcomm SoCs model names/numbers.  No features should be lost because:
1. There won't be a single image for ARMv7 and ARMv8/9 SoCs.
2. Newer ARMv8/9 SoCs won't be running in arm32 emulation mode.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct pinctrl->clock in commit msg,
2. Do not restrict several drivers for older ARM64 SoCs to ARM64 only,
   following the discussion.  Argumentation from Stephen was that some
   ARM64 SoCs could be used in arm32 emulation mode.  This is heavily
   unlikely for newer SoCs.
---
 drivers/clk/qcom/Kconfig | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 12be3e2371b3..17a7c91d855c 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -57,6 +57,7 @@ config QCOM_CLK_APCC_MSM8996
 config QCOM_CLK_APCS_SDX55
 	tristate "SDX55 and SDX65 APCS Clock Controller"
 	depends on QCOM_APCS_IPC || COMPILE_TEST
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the APCS Clock Controller on SDX55, SDX65 platforms. The
 	  APCS is managing the mux and divider which feeds the CPUs.
@@ -100,6 +101,7 @@ config QCOM_CLK_RPMH
 
 config APQ_GCC_8084
 	tristate "APQ8084 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on apq8084 devices.
@@ -108,6 +110,7 @@ config APQ_GCC_8084
 
 config APQ_MMCC_8084
 	tristate "APQ8084 Multimedia Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select APQ_GCC_8084
 	select QCOM_GDSC
 	help
@@ -159,6 +162,7 @@ config IPQ_GCC_6018
 
 config IPQ_GCC_806X
 	tristate "IPQ806x Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on ipq806x devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -166,6 +170,7 @@ config IPQ_GCC_806X
 
 config IPQ_LCC_806X
 	tristate "IPQ806x LPASS Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select IPQ_GCC_806X
 	help
 	  Support for the LPASS clock controller on ipq806x devices.
@@ -191,6 +196,7 @@ config IPQ_GCC_9574
 
 config MSM_GCC_8660
 	tristate "MSM8660 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on msm8660 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -198,6 +204,7 @@ config MSM_GCC_8660
 
 config MSM_GCC_8909
 	tristate "MSM8909 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on msm8909 devices.
@@ -232,6 +239,7 @@ config MSM_GCC_8939
 
 config MSM_GCC_8960
 	tristate "APQ8064/MSM8960 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on apq8064/msm8960 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -239,6 +247,7 @@ config MSM_GCC_8960
 
 config MSM_LCC_8960
 	tristate "APQ8064/MSM8960 LPASS Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select MSM_GCC_8960
 	help
 	  Support for the LPASS clock controller on apq8064/msm8960 devices.
@@ -247,6 +256,7 @@ config MSM_LCC_8960
 
 config MDM_GCC_9607
 	tristate "MDM9607 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on mdm9607 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -254,6 +264,7 @@ config MDM_GCC_9607
 
 config MDM_GCC_9615
 	tristate "MDM9615 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on mdm9615 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -261,6 +272,7 @@ config MDM_GCC_9615
 
 config MDM_LCC_9615
 	tristate "MDM9615 LPASS Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select MDM_GCC_9615
 	help
 	  Support for the LPASS clock controller on mdm9615 devices.
@@ -269,6 +281,7 @@ config MDM_LCC_9615
 
 config MSM_MMCC_8960
 	tristate "MSM8960 Multimedia Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select MSM_GCC_8960
 	help
 	  Support for the multimedia clock controller on msm8960 devices.
@@ -285,6 +298,7 @@ config MSM_GCC_8953
 
 config MSM_GCC_8974
 	tristate "MSM8974 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on msm8974 devices.
@@ -293,6 +307,7 @@ config MSM_GCC_8974
 
 config MSM_MMCC_8974
 	tristate "MSM8974 Multimedia Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select MSM_GCC_8974
 	select QCOM_GDSC
 	help
@@ -393,6 +408,7 @@ config QCS_GCC_404
 
 config SC_CAMCC_7180
 	tristate "SC7180 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the camera clock controller on Qualcomm Technologies, Inc
@@ -402,6 +418,7 @@ config SC_CAMCC_7180
 
 config SC_CAMCC_7280
 	tristate "SC7280 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the camera clock controller on Qualcomm Technologies, Inc
@@ -411,6 +428,7 @@ config SC_CAMCC_7280
 
 config SC_DISPCC_7180
 	tristate "SC7180 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -420,6 +438,7 @@ config SC_DISPCC_7180
 
 config SC_DISPCC_7280
 	tristate "SC7280 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc.
@@ -429,6 +448,7 @@ config SC_DISPCC_7280
 
 config SC_DISPCC_8280XP
 	tristate "SC8280XP Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_8280XP
 	help
 	  Support for the two display clock controllers on Qualcomm
@@ -458,6 +478,7 @@ config SC_GCC_7180
 	tristate "SC7180 Global Clock Controller"
 	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SC7180 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -467,6 +488,7 @@ config SC_GCC_7280
 	tristate "SC7280 Global Clock Controller"
 	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SC7280 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -476,6 +498,7 @@ config SC_GCC_8180X
 	tristate "SC8180X Global Clock Controller"
 	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SC8180X devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -485,6 +508,7 @@ config SC_GCC_8280XP
 	tristate "SC8280XP Global Clock Controller"
 	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SC8280XP devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -492,6 +516,7 @@ config SC_GCC_8280XP
 
 config SC_GPUCC_7180
 	tristate "SC7180 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the graphics clock controller on SC7180 devices.
@@ -500,6 +525,7 @@ config SC_GPUCC_7180
 
 config SC_GPUCC_7280
 	tristate "SC7280 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the graphics clock controller on SC7280 devices.
@@ -508,6 +534,7 @@ config SC_GPUCC_7280
 
 config SC_GPUCC_8280XP
 	tristate "SC8280XP Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_8280XP
 	help
 	  Support for the graphics clock controller on SC8280XP devices.
@@ -516,6 +543,7 @@ config SC_GPUCC_8280XP
 
 config SC_LPASSCC_7280
 	tristate "SC7280 Low Power Audio Subsystem (LPASS) Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the LPASS clock controller on SC7280 devices.
@@ -524,6 +552,7 @@ config SC_LPASSCC_7280
 
 config SC_LPASS_CORECC_7180
 	tristate "SC7180 LPASS Core Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the LPASS(Low Power Audio Subsystem) core clock controller
@@ -533,6 +562,7 @@ config SC_LPASS_CORECC_7180
 
 config SC_LPASS_CORECC_7280
 	tristate "SC7280 LPASS Core & Audio Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	select QCOM_GDSC
 	help
@@ -543,6 +573,7 @@ config SC_LPASS_CORECC_7280
 
 config SC_MSS_7180
 	tristate "SC7180 Modem Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the Modem Subsystem clock controller on Qualcomm
@@ -552,6 +583,7 @@ config SC_MSS_7180
 
 config SC_VIDEOCC_7180
 	tristate "SC7180 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the video clock controller on SC7180 devices.
@@ -560,6 +592,7 @@ config SC_VIDEOCC_7180
 
 config SC_VIDEOCC_7280
 	tristate "SC7280 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the video clock controller on SC7280 devices.
@@ -568,6 +601,7 @@ config SC_VIDEOCC_7280
 
 config SDM_CAMCC_845
 	tristate "SDM845 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	help
 	  Support for the camera clock controller on SDM845 devices.
@@ -575,6 +609,7 @@ config SDM_CAMCC_845
 
 config SDM_GCC_660
 	tristate "SDM660 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDM660 devices.
@@ -583,6 +618,7 @@ config SDM_GCC_660
 
 config SDM_MMCC_660
 	tristate "SDM660 Multimedia Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_660
 	select QCOM_GDSC
 	help
@@ -592,6 +628,7 @@ config SDM_MMCC_660
 
 config SDM_GPUCC_660
 	tristate "SDM660 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_660
 	select QCOM_GDSC
 	help
@@ -623,6 +660,7 @@ config QDU_GCC_1000
 
 config SDM_GCC_845
 	tristate "SDM845/SDM670 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDM845 and SDM670 devices.
@@ -631,6 +669,7 @@ config SDM_GCC_845
 
 config SDM_GPUCC_845
 	tristate "SDM845 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	help
 	  Support for the graphics clock controller on SDM845 devices.
@@ -639,6 +678,7 @@ config SDM_GPUCC_845
 
 config SDM_VIDEOCC_845
 	tristate "SDM845 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	select QCOM_GDSC
 	help
@@ -648,6 +688,7 @@ config SDM_VIDEOCC_845
 
 config SDM_DISPCC_845
 	tristate "SDM845 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -657,6 +698,7 @@ config SDM_DISPCC_845
 
 config SDM_LPASSCC_845
 	tristate "SDM845 Low Power Audio Subsystem (LPAAS) Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	help
 	  Support for the LPASS clock controller on SDM845 devices.
@@ -665,6 +707,7 @@ config SDM_LPASSCC_845
 
 config SDX_GCC_55
 	tristate "SDX55 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDX55 devices.
@@ -673,6 +716,7 @@ config SDX_GCC_55
 
 config SDX_GCC_65
 	tristate "SDX65 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDX65 devices.
@@ -681,6 +725,7 @@ config SDX_GCC_65
 
 config SM_CAMCC_6350
 	tristate "SM6350 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_6350
 	help
 	  Support for the camera clock controller on SM6350 devices.
@@ -688,6 +733,7 @@ config SM_CAMCC_6350
 
 config SM_CAMCC_8250
 	tristate "SM8250 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8250
 	help
 	  Support for the camera clock controller on SM8250 devices.
@@ -695,6 +741,7 @@ config SM_CAMCC_8250
 
 config SM_CAMCC_8450
 	tristate "SM8450 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8450
 	help
 	  Support for the camera clock controller on SM8450 devices.
@@ -702,6 +749,7 @@ config SM_CAMCC_8450
 
 config SM_DISPCC_6115
 	tristate "SM6115 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_6115
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -711,6 +759,7 @@ config SM_DISPCC_6115
 
 config SM_DISPCC_6125
 	tristate "SM6125 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_6125
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -720,6 +769,7 @@ config SM_DISPCC_6125
 
 config SM_DISPCC_8250
 	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_8150 || SM_GCC_8250 || SM_GCC_8350
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -729,6 +779,7 @@ config SM_DISPCC_8250
 
 config SM_DISPCC_6350
 	tristate "SM6350 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_6350
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -738,6 +789,7 @@ config SM_DISPCC_6350
 
 config SM_DISPCC_6375
 	tristate "SM6375 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_6375
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -747,6 +799,7 @@ config SM_DISPCC_6375
 
 config SM_DISPCC_8450
 	tristate "SM8450 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_8450
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -756,6 +809,7 @@ config SM_DISPCC_8450
 
 config SM_DISPCC_8550
 	tristate "SM8550 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_8550
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -765,6 +819,7 @@ config SM_DISPCC_8550
 
 config SM_GCC_6115
 	tristate "SM6115 and SM4250 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM6115 and SM4250 devices.
@@ -773,6 +828,7 @@ config SM_GCC_6115
 
 config SM_GCC_6125
 	tristate "SM6125 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SM6125 devices.
 	  Say Y if you want to use peripheral devices such as UART,
@@ -780,6 +836,7 @@ config SM_GCC_6125
 
 config SM_GCC_6350
 	tristate "SM6350 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM6350 devices.
@@ -788,6 +845,7 @@ config SM_GCC_6350
 
 config SM_GCC_6375
 	tristate "SM6375 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM6375 devices.
@@ -804,6 +862,7 @@ config SM_GCC_7150
 
 config SM_GCC_8150
 	tristate "SM8150 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SM8150 devices.
 	  Say Y if you want to use peripheral devices such as UART,
@@ -811,6 +870,7 @@ config SM_GCC_8150
 
 config SM_GCC_8250
 	tristate "SM8250 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM8250 devices.
@@ -819,6 +879,7 @@ config SM_GCC_8250
 
 config SM_GCC_8350
 	tristate "SM8350 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM8350 devices.
@@ -827,6 +888,7 @@ config SM_GCC_8350
 
 config SM_GCC_8450
 	tristate "SM8450 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM8450 devices.
@@ -835,6 +897,7 @@ config SM_GCC_8450
 
 config SM_GCC_8550
 	tristate "SM8550 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM8550 devices.
@@ -870,6 +933,7 @@ config SM_GPUCC_6375
 
 config SM_GPUCC_6350
 	tristate "SM6350 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_6350
 	help
 	  Support for the graphics clock controller on SM6350 devices.
@@ -878,6 +942,7 @@ config SM_GPUCC_6350
 
 config SM_GPUCC_8150
 	tristate "SM8150 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8150
 	help
 	  Support for the graphics clock controller on SM8150 devices.
@@ -886,6 +951,7 @@ config SM_GPUCC_8150
 
 config SM_GPUCC_8250
 	tristate "SM8250 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8250
 	help
 	  Support for the graphics clock controller on SM8250 devices.
@@ -894,6 +960,7 @@ config SM_GPUCC_8250
 
 config SM_GPUCC_8350
 	tristate "SM8350 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8350
 	help
 	  Support for the graphics clock controller on SM8350 devices.
@@ -902,6 +969,7 @@ config SM_GPUCC_8350
 
 config SM_TCSRCC_8550
 	tristate "SM8550 TCSR Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the TCSR clock controller on SM8550 devices.
@@ -909,6 +977,7 @@ config SM_TCSRCC_8550
 
 config SM_VIDEOCC_8150
 	tristate "SM8150 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8150
 	select QCOM_GDSC
 	help
@@ -918,6 +987,7 @@ config SM_VIDEOCC_8150
 
 config SM_VIDEOCC_8250
 	tristate "SM8250 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8250
 	select QCOM_GDSC
 	help
@@ -958,6 +1028,7 @@ config KRAITCC
 
 config CLK_GFM_LPASS_SM8250
 	tristate "SM8250 GFM LPASS Clocks"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the Glitch Free Mux (GFM) Low power audio
           subsystem (LPASS) clocks found on SM8250 SoCs.
-- 
2.34.1

