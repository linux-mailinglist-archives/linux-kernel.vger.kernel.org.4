Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0818A6777C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjAWJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjAWJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:49:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173701631A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:49:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d2so10185702wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7XNhfezFNCGQXPoGQj2pwQnaEfYn+WK3J4yM3sd3+M=;
        b=cSXxoPQYYGXrokhYwJhcZL/vie8yFcpRu+fvYJbNvnTEv374vBp7BsibPm6YxlgVGN
         wMItfoWIXo9y4xYUPFUIQ9R5xyGh79onOxmd7Mp74UQrUz1zoMGBTl/M0T6zDDc/bCJK
         qqGOQrveX0dEhdoDlEguuq+qJ1hoSYzGaj3bnZAzZa9+45EhoMYkN7kD04i5XukROyLG
         E7UaLZL218jp7UtrhBZDzQw6TM1tMDcPXMn8MxVP54cKdnt9HSzJuGJ8M2ydy/zeIqLf
         f8rkk8Qp2RAfZDer3100YCsw4tTNoUdAnUsCA/QQ7JNBkJiFekvXcp+WO61bGnZ52JWd
         OR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7XNhfezFNCGQXPoGQj2pwQnaEfYn+WK3J4yM3sd3+M=;
        b=u4AR3yVGJx4VtcgCtFkq4Pn/7Oww20cOkun1aoZVUeym3MajXRMOL19zrCYQCtHQl8
         YMsI2zSj2AkdMfDDaxefshH1NXvPmGW8WZiwwOrRB8uoDaykJ4Jai0v4/ovxbSnYYGOz
         YPRvDiKe2d73R51lvGdDYFRFfYjb7tK0OKiohpoK0AmmpHGgp+umNA6NNeWm+nMqUuSj
         JNC8Gq9rYFKFy73ptoMR2mzLoij+NZa6KZIkcHHVZGdH0YpSfRUs4T7V/qPRaMb3JnSq
         Wzbp2+wSNNQpLp+MJjXgJjEJ6qq5ckChEoWeZeWdfZ8UAexY6m1ZYdtvGLHBmLohHHki
         HOyQ==
X-Gm-Message-State: AFqh2kp7RMLjuwMvX93PD409U4VT+m00FIpvE1Yj5od82L5BaI78CjEK
        mVhl40Ts4zZvH92ulM7NriqYwQ==
X-Google-Smtp-Source: AMrXdXs3vovGS0vIVMoOD8nLn2T0D9KPSRBzzDlx1npIrc8o9r76G1eOOWPdV481iGJzwgV4cHBTKw==
X-Received: by 2002:a05:6000:1f84:b0:2be:5370:4f2a with SMTP id bw4-20020a0560001f8400b002be53704f2amr14411295wrb.22.1674467384469;
        Mon, 23 Jan 2023 01:49:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm23976864wrr.20.2023.01.23.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 01:49:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] clk: qcom: restrict drivers per ARM/ARM64
Date:   Mon, 23 Jan 2023 10:49:25 +0100
Message-Id: <20230123094925.54824-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123094925.54824-1-krzysztof.kozlowski@linaro.org>
References: <20230123094925.54824-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to allow selecting pin-controller drivers for Qualcomm
ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
kernel configuration more difficult as many do not remember the Qualcomm
SoCs model names/numbers.  There won't be a single image for ARMv7 and
ARMv8/9 SoCs, so no features/options are lost.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/Kconfig | 88 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1c360eed72d7..3112ca762f4d 100644
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
@@ -116,6 +119,7 @@ config APQ_MMCC_8084
 	  graphics, video encode/decode, camera, etc.
 
 config IPQ_APSS_PLL
+	depends on ARM64 || COMPILE_TEST
 	tristate "IPQ APSS PLL"
 	help
 	  Support for APSS PLL on ipq devices. The APSS PLL is the main
@@ -127,6 +131,7 @@ config IPQ_APSS_6018
 	tristate "IPQ APSS Clock Controller"
 	select IPQ_APSS_PLL
 	depends on QCOM_APCS_IPC || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for APSS clock controller on IPQ platforms. The
 	  APSS clock controller manages the Mux and enable block that feeds the
@@ -143,6 +148,7 @@ config IPQ_GCC_4019
 
 config IPQ_GCC_6018
 	tristate "IPQ6018 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for global clock controller on ipq6018 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -151,6 +157,7 @@ config IPQ_GCC_6018
 
 config IPQ_GCC_806X
 	tristate "IPQ806x Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on ipq806x devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -158,6 +165,7 @@ config IPQ_GCC_806X
 
 config IPQ_LCC_806X
 	tristate "IPQ806x LPASS Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select IPQ_GCC_806X
 	help
 	  Support for the LPASS clock controller on ipq806x devices.
@@ -166,6 +174,7 @@ config IPQ_LCC_806X
 
 config IPQ_GCC_8074
 	tristate "IPQ8074 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for global clock controller on ipq8074 devices.
@@ -175,6 +184,7 @@ config IPQ_GCC_8074
 
 config MSM_GCC_8660
 	tristate "MSM8660 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on msm8660 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -182,6 +192,7 @@ config MSM_GCC_8660
 
 config MSM_GCC_8909
 	tristate "MSM8909 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on msm8909 devices.
@@ -206,6 +217,7 @@ config MSM_GCC_8939
 
 config MSM_GCC_8960
 	tristate "APQ8064/MSM8960 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on apq8064/msm8960 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -213,6 +225,7 @@ config MSM_GCC_8960
 
 config MSM_LCC_8960
 	tristate "APQ8064/MSM8960 LPASS Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select MSM_GCC_8960
 	help
 	  Support for the LPASS clock controller on apq8064/msm8960 devices.
@@ -221,6 +234,7 @@ config MSM_LCC_8960
 
 config MDM_GCC_9607
 	tristate "MDM9607 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on mdm9607 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -228,6 +242,7 @@ config MDM_GCC_9607
 
 config MDM_GCC_9615
 	tristate "MDM9615 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	help
 	  Support for the global clock controller on mdm9615 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -235,6 +250,7 @@ config MDM_GCC_9615
 
 config MDM_LCC_9615
 	tristate "MDM9615 LPASS Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select MDM_GCC_9615
 	help
 	  Support for the LPASS clock controller on mdm9615 devices.
@@ -243,6 +259,7 @@ config MDM_LCC_9615
 
 config MSM_MMCC_8960
 	tristate "MSM8960 Multimedia Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select MSM_GCC_8960
 	help
 	  Support for the multimedia clock controller on msm8960 devices.
@@ -251,6 +268,7 @@ config MSM_MMCC_8960
 
 config MSM_GCC_8953
 	tristate "MSM8953 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on msm8953 devices.
@@ -259,6 +277,7 @@ config MSM_GCC_8953
 
 config MSM_GCC_8974
 	tristate "MSM8974 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on msm8974 devices.
@@ -267,6 +286,7 @@ config MSM_GCC_8974
 
 config MSM_MMCC_8974
 	tristate "MSM8974 Multimedia Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select MSM_GCC_8974
 	select QCOM_GDSC
 	help
@@ -276,6 +296,7 @@ config MSM_MMCC_8974
 
 config MSM_GCC_8976
 	tristate "MSM8956/76 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on msm8956/76 devices.
@@ -284,6 +305,7 @@ config MSM_GCC_8976
 
 config MSM_MMCC_8994
 	tristate "MSM8994 Multimedia Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select MSM_GCC_8994
 	select QCOM_GDSC
 	help
@@ -293,6 +315,7 @@ config MSM_MMCC_8994
 
 config MSM_GCC_8994
 	tristate "MSM8994 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on msm8994 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -300,6 +323,7 @@ config MSM_GCC_8994
 
 config MSM_GCC_8996
 	tristate "MSM8996 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on msm8996 devices.
@@ -308,6 +332,7 @@ config MSM_GCC_8996
 
 config MSM_MMCC_8996
 	tristate "MSM8996 Multimedia Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select MSM_GCC_8996
 	select QCOM_GDSC
 	help
@@ -317,6 +342,7 @@ config MSM_MMCC_8996
 
 config MSM_GCC_8998
 	tristate "MSM8998 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on msm8998 devices.
@@ -325,6 +351,7 @@ config MSM_GCC_8998
 
 config MSM_GPUCC_8998
 	tristate "MSM8998 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select MSM_GCC_8998
 	select QCOM_GDSC
 	help
@@ -334,6 +361,7 @@ config MSM_GPUCC_8998
 
 config MSM_MMCC_8998
 	tristate "MSM8998 Multimedia Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select MSM_GCC_8998
 	select QCOM_GDSC
 	help
@@ -351,6 +379,7 @@ config QCM_GCC_2290
 
 config QCM_DISPCC_2290
 	tristate "QCM2290 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCM_GCC_2290
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -360,6 +389,7 @@ config QCM_DISPCC_2290
 
 config QCS_GCC_404
 	tristate "QCS404 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on QCS404 devices.
 	  Say Y if you want to use multimedia devices or peripheral
@@ -367,6 +397,7 @@ config QCS_GCC_404
 
 config SC_CAMCC_7180
 	tristate "SC7180 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the camera clock controller on Qualcomm Technologies, Inc
@@ -376,6 +407,7 @@ config SC_CAMCC_7180
 
 config SC_CAMCC_7280
 	tristate "SC7280 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the camera clock controller on Qualcomm Technologies, Inc
@@ -385,6 +417,7 @@ config SC_CAMCC_7280
 
 config SC_DISPCC_7180
 	tristate "SC7180 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -394,6 +427,7 @@ config SC_DISPCC_7180
 
 config SC_DISPCC_7280
 	tristate "SC7280 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc.
@@ -403,6 +437,7 @@ config SC_DISPCC_7280
 
 config SC_DISPCC_8280XP
 	tristate "SC8280XP Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_8280XP
 	help
 	  Support for the two display clock controllers on Qualcomm
@@ -414,6 +449,7 @@ config SC_GCC_7180
 	tristate "SC7180 Global Clock Controller"
 	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SC7180 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -423,6 +459,7 @@ config SC_GCC_7280
 	tristate "SC7280 Global Clock Controller"
 	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SC7280 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -432,6 +469,7 @@ config SC_GCC_8180X
 	tristate "SC8180X Global Clock Controller"
 	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SC8180X devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -441,6 +479,7 @@ config SC_GCC_8280XP
 	tristate "SC8280XP Global Clock Controller"
 	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SC8280XP devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
@@ -448,6 +487,7 @@ config SC_GCC_8280XP
 
 config SC_GPUCC_7180
 	tristate "SC7180 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the graphics clock controller on SC7180 devices.
@@ -456,6 +496,7 @@ config SC_GPUCC_7180
 
 config SC_GPUCC_7280
 	tristate "SC7280 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the graphics clock controller on SC7280 devices.
@@ -464,6 +505,7 @@ config SC_GPUCC_7280
 
 config SC_GPUCC_8280XP
 	tristate "SC8280XP Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_8280XP
 	help
 	  Support for the graphics clock controller on SC8280XP devices.
@@ -472,6 +514,7 @@ config SC_GPUCC_8280XP
 
 config SC_LPASSCC_7280
 	tristate "SC7280 Low Power Audio Subsystem (LPASS) Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the LPASS clock controller on SC7280 devices.
@@ -480,6 +523,7 @@ config SC_LPASSCC_7280
 
 config SC_LPASS_CORECC_7180
 	tristate "SC7180 LPASS Core Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the LPASS(Low Power Audio Subsystem) core clock controller
@@ -489,6 +533,7 @@ config SC_LPASS_CORECC_7180
 
 config SC_LPASS_CORECC_7280
 	tristate "SC7280 LPASS Core & Audio Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	select QCOM_GDSC
 	help
@@ -499,6 +544,7 @@ config SC_LPASS_CORECC_7280
 
 config SC_MSS_7180
 	tristate "SC7180 Modem Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the Modem Subsystem clock controller on Qualcomm
@@ -508,6 +554,7 @@ config SC_MSS_7180
 
 config SC_VIDEOCC_7180
 	tristate "SC7180 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7180
 	help
 	  Support for the video clock controller on SC7180 devices.
@@ -516,6 +563,7 @@ config SC_VIDEOCC_7180
 
 config SC_VIDEOCC_7280
 	tristate "SC7280 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SC_GCC_7280
 	help
 	  Support for the video clock controller on SC7280 devices.
@@ -524,6 +572,7 @@ config SC_VIDEOCC_7280
 
 config SDM_CAMCC_845
 	tristate "SDM845 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	help
 	  Support for the camera clock controller on SDM845 devices.
@@ -531,6 +580,7 @@ config SDM_CAMCC_845
 
 config SDM_GCC_660
 	tristate "SDM660 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDM660 devices.
@@ -539,6 +589,7 @@ config SDM_GCC_660
 
 config SDM_MMCC_660
 	tristate "SDM660 Multimedia Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_660
 	select QCOM_GDSC
 	help
@@ -548,6 +599,7 @@ config SDM_MMCC_660
 
 config SDM_GPUCC_660
 	tristate "SDM660 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_660
 	select QCOM_GDSC
 	help
@@ -557,12 +609,14 @@ config SDM_GPUCC_660
 
 config QCS_TURING_404
 	tristate "QCS404 Turing Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the Turing Clock Controller on QCS404, provides clocks
 	  and resets for the Turing subsystem.
 
 config QCS_Q6SSTOP_404
 	tristate "QCS404 Q6SSTOP Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCS_GCC_404
 	help
 	  Support for the Q6SSTOP clock controller on QCS404 devices.
@@ -571,6 +625,7 @@ config QCS_Q6SSTOP_404
 
 config SDM_GCC_845
 	tristate "SDM845/SDM670 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDM845 and SDM670 devices.
@@ -579,6 +634,7 @@ config SDM_GCC_845
 
 config SDM_GPUCC_845
 	tristate "SDM845 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	help
 	  Support for the graphics clock controller on SDM845 devices.
@@ -587,6 +643,7 @@ config SDM_GPUCC_845
 
 config SDM_VIDEOCC_845
 	tristate "SDM845 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	select QCOM_GDSC
 	help
@@ -596,6 +653,7 @@ config SDM_VIDEOCC_845
 
 config SDM_DISPCC_845
 	tristate "SDM845 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -605,6 +663,7 @@ config SDM_DISPCC_845
 
 config SDM_LPASSCC_845
 	tristate "SDM845 Low Power Audio Subsystem (LPAAS) Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SDM_GCC_845
 	help
 	  Support for the LPASS clock controller on SDM845 devices.
@@ -613,6 +672,7 @@ config SDM_LPASSCC_845
 
 config SDX_GCC_55
 	tristate "SDX55 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDX55 devices.
@@ -621,6 +681,7 @@ config SDX_GCC_55
 
 config SDX_GCC_65
 	tristate "SDX65 Global Clock Controller"
+	depends on ARM || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDX65 devices.
@@ -629,6 +690,7 @@ config SDX_GCC_65
 
 config SM_CAMCC_6350
 	tristate "SM6350 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_6350
 	help
 	  Support for the camera clock controller on SM6350 devices.
@@ -636,6 +698,7 @@ config SM_CAMCC_6350
 
 config SM_CAMCC_8250
 	tristate "SM8250 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8250
 	help
 	  Support for the camera clock controller on SM8250 devices.
@@ -643,6 +706,7 @@ config SM_CAMCC_8250
 
 config SM_CAMCC_8450
 	tristate "SM8450 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8450
 	help
 	  Support for the camera clock controller on SM8450 devices.
@@ -650,6 +714,7 @@ config SM_CAMCC_8450
 
 config SM_DISPCC_6115
 	tristate "SM6115 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_6115
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -659,6 +724,7 @@ config SM_DISPCC_6115
 
 config SM_DISPCC_6125
 	tristate "SM6125 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_6125
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -668,6 +734,7 @@ config SM_DISPCC_6125
 
 config SM_DISPCC_8250
 	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_8150 || SM_GCC_8250 || SM_GCC_8350
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -677,6 +744,7 @@ config SM_DISPCC_8250
 
 config SM_DISPCC_6350
 	tristate "SM6350 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_6350
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -686,6 +754,7 @@ config SM_DISPCC_6350
 
 config SM_DISPCC_6375
 	tristate "SM6375 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_6375
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -695,6 +764,7 @@ config SM_DISPCC_6375
 
 config SM_DISPCC_8450
 	tristate "SM8450 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_8450
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -704,6 +774,7 @@ config SM_DISPCC_8450
 
 config SM_DISPCC_8550
 	tristate "SM8550 Display Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on SM_GCC_8550
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
@@ -713,6 +784,7 @@ config SM_DISPCC_8550
 
 config SM_GCC_6115
 	tristate "SM6115 and SM4250 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM6115 and SM4250 devices.
@@ -721,6 +793,7 @@ config SM_GCC_6115
 
 config SM_GCC_6125
 	tristate "SM6125 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SM6125 devices.
 	  Say Y if you want to use peripheral devices such as UART,
@@ -728,6 +801,7 @@ config SM_GCC_6125
 
 config SM_GCC_6350
 	tristate "SM6350 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM6350 devices.
@@ -736,6 +810,7 @@ config SM_GCC_6350
 
 config SM_GCC_6375
 	tristate "SM6375 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM6375 devices.
@@ -744,6 +819,7 @@ config SM_GCC_6375
 
 config SM_GCC_8150
 	tristate "SM8150 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the global clock controller on SM8150 devices.
 	  Say Y if you want to use peripheral devices such as UART,
@@ -751,6 +827,7 @@ config SM_GCC_8150
 
 config SM_GCC_8250
 	tristate "SM8250 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM8250 devices.
@@ -759,6 +836,7 @@ config SM_GCC_8250
 
 config SM_GCC_8350
 	tristate "SM8350 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM8350 devices.
@@ -767,6 +845,7 @@ config SM_GCC_8350
 
 config SM_GCC_8450
 	tristate "SM8450 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM8450 devices.
@@ -775,6 +854,7 @@ config SM_GCC_8450
 
 config SM_GCC_8550
 	tristate "SM8550 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM8550 devices.
@@ -783,6 +863,7 @@ config SM_GCC_8550
 
 config SM_GPUCC_6350
 	tristate "SM6350 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_6350
 	help
 	  Support for the graphics clock controller on SM6350 devices.
@@ -791,6 +872,7 @@ config SM_GPUCC_6350
 
 config SM_GPUCC_8150
 	tristate "SM8150 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8150
 	help
 	  Support for the graphics clock controller on SM8150 devices.
@@ -799,6 +881,7 @@ config SM_GPUCC_8150
 
 config SM_GPUCC_8250
 	tristate "SM8250 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8250
 	help
 	  Support for the graphics clock controller on SM8250 devices.
@@ -807,6 +890,7 @@ config SM_GPUCC_8250
 
 config SM_GPUCC_8350
 	tristate "SM8350 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8350
 	help
 	  Support for the graphics clock controller on SM8350 devices.
@@ -815,6 +899,7 @@ config SM_GPUCC_8350
 
 config SM_TCSRCC_8550
 	tristate "SM8550 TCSR Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the TCSR clock controller on SM8550 devices.
@@ -822,6 +907,7 @@ config SM_TCSRCC_8550
 
 config SM_VIDEOCC_8150
 	tristate "SM8150 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8150
 	select QCOM_GDSC
 	help
@@ -831,6 +917,7 @@ config SM_VIDEOCC_8150
 
 config SM_VIDEOCC_8250
 	tristate "SM8250 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8250
 	select QCOM_GDSC
 	help
@@ -871,6 +958,7 @@ config KRAITCC
 
 config CLK_GFM_LPASS_SM8250
 	tristate "SM8250 GFM LPASS Clocks"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Support for the Glitch Free Mux (GFM) Low power audio
           subsystem (LPASS) clocks found on SM8250 SoCs.
-- 
2.34.1

