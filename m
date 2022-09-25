Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145BE5E92AB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiIYLVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIYLVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:21:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0212B612
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:21:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so6783618lfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=af+0mbAc84TKD9G91K14NRxllLn8dGl9/l+WvPVW08E=;
        b=neG8PpqdKNEitYdNozE9shvYxqRKQB8x0gnjkJauNt2KdUI4KoWxmfUeMjz5BtdBgq
         DY0g7NCIhQELPZUrShbVDUidl1/VeGt1V9D1chP9Z89cYJhWj8PQ2htS3jAGwcNOLq44
         vNIp3S38WmNM5bI65vXMLPPRXl7SbRNuoFJbayZkLc5P44E4qfeIQVS1TciZ8j+C/fRI
         WqTjA7kt+dw3X1Oo6QKADHW9j03C8veq9YQgEjodkP+s0PURoSWthVIaWq8Z97IM2ZDA
         YjtdDbwzTm0qhJWZCGzLWMOLpCd+vsnt6JGxqXLlcTLIbD3xhxfmw0epqiy+6/zReZB9
         qfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=af+0mbAc84TKD9G91K14NRxllLn8dGl9/l+WvPVW08E=;
        b=Wdx7IWkVpor+/+tngnQpx+yz8THy1RGMkcCTdhZjnKg2dAaD0HZ8mWodyZ7kcd3VP9
         V7hqhRboBDg5y0Fh68N5uY/ISKTvcsAG80o36iktVU3XT3RT4xGZO1O8d7/c8JHRiW+z
         pGVNmLv5D1t1kaPQGP0ThjvAtNgWbatD0JsxM99GjGvRDovDErMRHRj3XBGAFdKXBFZS
         bEuyGPEUH5VcIwGDECvDDLzK943v2WKAb5+64sv4L1u6tqsXD9nBvF1HU+YO6lcvjkfb
         437d6p1CRbKsFkoivu66Ufj8I10JLMGWt2qNoB0nI1Hix0iPGqzmxp0oKSCFvaUeI9TV
         iyWw==
X-Gm-Message-State: ACrzQf0oCDL1LtV9NhVhnI32RIepsG32uYBYpZz6D5uJ8NMn4TW4/dFn
        I0nAmMJ9/JWmX9l3OvzhkMVXOQ==
X-Google-Smtp-Source: AMsMyM6+TIXLkQ79F3NwofJPcda/6NukOh01wvPGH0RvFHLUjQ333nwgw7icjEOYoo2mPVTYYuSCAQ==
X-Received: by 2002:a05:6512:39cb:b0:49a:d1e1:16df with SMTP id k11-20020a05651239cb00b0049ad1e116dfmr6884172lfu.438.1664104865971;
        Sun, 25 Sep 2022 04:21:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v21-20020a05651203b500b00497ac6b2b15sm2176243lfp.157.2022.09.25.04.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 04:21:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] pinctrl: qcom: restrict drivers per ARM/ARM64
Date:   Sun, 25 Sep 2022 13:21:03 +0200
Message-Id: <20220925112103.148836-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

There is no point to allow selecting pin-controller drivers for Qualcomm
ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
kernel configuration more difficult as many do not remember the Qualcomm
SoCs.  There won't be a single image for ARMv7 and ARMv8/9 SoCs, so no
features/options are lost.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Restrict MSM8976 to ARM64.
---
 drivers/pinctrl/qcom/Kconfig | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2961b5eb8e10..9dc2d803a586 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -15,6 +15,7 @@ config PINCTRL_MSM
 config PINCTRL_APQ8064
 	tristate "Qualcomm APQ8064 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -23,6 +24,7 @@ config PINCTRL_APQ8064
 config PINCTRL_APQ8084
 	tristate "Qualcomm APQ8084 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -31,6 +33,7 @@ config PINCTRL_APQ8084
 config PINCTRL_IPQ4019
 	tristate "Qualcomm IPQ4019 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -39,6 +42,7 @@ config PINCTRL_IPQ4019
 config PINCTRL_IPQ8064
 	tristate "Qualcomm IPQ8064 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -47,6 +51,7 @@ config PINCTRL_IPQ8064
 config PINCTRL_IPQ8074
 	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
@@ -57,6 +62,7 @@ config PINCTRL_IPQ8074
 config PINCTRL_IPQ6018
 	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
@@ -67,6 +73,7 @@ config PINCTRL_IPQ6018
 config PINCTRL_MSM8226
 	tristate "Qualcomm 8226 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -76,6 +83,7 @@ config PINCTRL_MSM8226
 config PINCTRL_MSM8660
 	tristate "Qualcomm 8660 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -84,6 +92,7 @@ config PINCTRL_MSM8660
 config PINCTRL_MSM8960
 	tristate "Qualcomm 8960 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -100,6 +109,7 @@ config PINCTRL_MDM9607
 config PINCTRL_MDM9615
 	tristate "Qualcomm 9615 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -108,6 +118,7 @@ config PINCTRL_MDM9615
 config PINCTRL_MSM8X74
 	tristate "Qualcomm 8x74 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -116,6 +127,7 @@ config PINCTRL_MSM8X74
 config PINCTRL_MSM8909
 	tristate "Qualcomm 8909 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -132,6 +144,7 @@ config PINCTRL_MSM8916
 config PINCTRL_MSM8953
 	tristate "Qualcomm 8953 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -142,6 +155,7 @@ config PINCTRL_MSM8953
 config PINCTRL_MSM8976
 	tristate "Qualcomm 8976 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -152,6 +166,7 @@ config PINCTRL_MSM8976
 config PINCTRL_MSM8994
 	tristate "Qualcomm 8994 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -161,6 +176,7 @@ config PINCTRL_MSM8994
 config PINCTRL_MSM8996
 	tristate "Qualcomm MSM8996 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -169,6 +185,7 @@ config PINCTRL_MSM8996
 config PINCTRL_MSM8998
 	tristate "Qualcomm MSM8998 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -177,6 +194,7 @@ config PINCTRL_MSM8998
 config PINCTRL_QCM2290
 	tristate "Qualcomm QCM2290 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -185,6 +203,7 @@ config PINCTRL_QCM2290
 config PINCTRL_QCS404
 	tristate "Qualcomm QCS404 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -232,6 +251,7 @@ config PINCTRL_QCOM_SSBI_PMIC
 config PINCTRL_SC7180
 	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -241,6 +261,7 @@ config PINCTRL_SC7180
 config PINCTRL_SC7280
 	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -250,6 +271,7 @@ config PINCTRL_SC7280
 config PINCTRL_SC7280_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
 	depends on GPIOLIB
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -259,6 +281,7 @@ config PINCTRL_SC7280_LPASS_LPI
 config PINCTRL_SC8180X
 	tristate "Qualcomm Technologies Inc SC8180x pin controller driver"
 	depends on (OF || ACPI)
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -268,6 +291,7 @@ config PINCTRL_SC8180X
 config PINCTRL_SC8280XP
 	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -277,6 +301,7 @@ config PINCTRL_SC8280XP
 config PINCTRL_SDM660
 	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -286,6 +311,7 @@ config PINCTRL_SDM660
 config PINCTRL_SDM845
 	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
 	depends on (OF || ACPI)
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -295,6 +321,7 @@ config PINCTRL_SDM845
 config PINCTRL_SDX55
 	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
 	depends on OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -304,6 +331,7 @@ config PINCTRL_SDX55
 config PINCTRL_SM6115
 	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
 	depends on GPIOLIB && OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -313,6 +341,7 @@ config PINCTRL_SM6115
 config PINCTRL_SM6125
 	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -322,6 +351,7 @@ config PINCTRL_SM6125
 config PINCTRL_SM6350
 	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
 	depends on GPIOLIB && OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -331,6 +361,7 @@ config PINCTRL_SM6350
 config PINCTRL_SM6375
 	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
 	depends on GPIOLIB && OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -340,6 +371,7 @@ config PINCTRL_SM6375
 config PINCTRL_SDX65
 	tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
 	depends on GPIOLIB && OF
+	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -349,6 +381,7 @@ config PINCTRL_SDX65
 config PINCTRL_SM8150
 	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -358,6 +391,7 @@ config PINCTRL_SM8150
 config PINCTRL_SM8250
 	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -367,6 +401,7 @@ config PINCTRL_SM8250
 config PINCTRL_SM8250_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
 	depends on GPIOLIB
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -375,6 +410,7 @@ config PINCTRL_SM8250_LPASS_LPI
 
 config PINCTRL_SM8350
 	tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -384,6 +420,7 @@ config PINCTRL_SM8350
 config PINCTRL_SM8450
 	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
 	depends on GPIOLIB && OF
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -393,6 +430,7 @@ config PINCTRL_SM8450
 config PINCTRL_SM8450_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
 	depends on GPIOLIB
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -402,6 +440,7 @@ config PINCTRL_SM8450_LPASS_LPI
 config PINCTRL_SC8280XP_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SC8280XP LPASS LPI pin controller driver"
 	depends on GPIOLIB
+	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-- 
2.34.1

