Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A871A273
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjFAPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjFAPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:20:59 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A907513D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:20:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af177f12a5so12886581fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685632854; x=1688224854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiZfuwCIaluJhaqBfTqJS8IZU85Nh8CZF7iTfaB6qqg=;
        b=NvuVCCUBDf4xH0V+thYIgFbjLldRHMmcWu+GrkFDBJW204di9nljizesO9z/ihSPAw
         Ici2JittR31Ey/1Yala2InSSdUu18famTsPY59+cq653mLqCdJyHFi3NKO6PXY26mHxu
         aqiykdHLRjLkGn7hMJLgQ/HUwodze468bOfwzghcE1YgVn7eNV7jp1wUlJy2qX2vyAoV
         wL1p8dEQ5porA/GTgN1g+8DvNsHB5Q1Qj95JlxChnBewFmEIN+U1G897Mml7OaX0XXPY
         AOysIQiqQV8sK1iYgY3rUB+xsYX72J4NSg1Kwrwije6K/diXgPRbX/b3ylofDiD1xXM+
         JpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632854; x=1688224854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiZfuwCIaluJhaqBfTqJS8IZU85Nh8CZF7iTfaB6qqg=;
        b=Eb1plos9ZFg2S1aN4Jc4qyVreKk8N69tPjGk6Lx7UkQOiDDh0lr0XoNOr8B1OmjeCA
         OsxBTiJ4wLtm72mlZloRD43toPm7b95QET8KtDFM0BYut57eebvc3348nCRdlW2pSEF8
         MfSdC05KhqaCzeGebQILql831GlSL49LWgiyel6FLYC+MGi9FgqEMkKRJXDOaMqIrIj2
         3dPQf4j2lTOS1avNqzJW9QZmsO5nZZrvxiWlVXxOYfgl9rVQfDFDYt9VCJOrQwnwr5fe
         JgngQmcVuI3bdBzUH/R7bHl+2McvI5eo6Ijp3ImT0fcHmRuogLc7s5cldNtLTa2rKC0E
         7OCw==
X-Gm-Message-State: AC+VfDxkVjShyAI3eQQemPMcc17B/3YfdO/i7Zi0t+mYj+4ME3je9QYS
        eJMGkjlpzupNGIm++RUuWv19kQ==
X-Google-Smtp-Source: ACHHUZ5BS4Za2fFCUyTmj4MAg6RniESnZxxHLDGuUA2Eq+eKJv6eRHUGJJpE2tbC+07lskOc42j3YA==
X-Received: by 2002:a2e:8402:0:b0:2b0:360f:5752 with SMTP id z2-20020a2e8402000000b002b0360f5752mr5198821ljg.2.1685632853584;
        Thu, 01 Jun 2023 08:20:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402160e00b0051422f31b1bsm7298664edv.63.2023.06.01.08.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:20:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/8] pinctrl: qcom: mark true OF dependency - common MSM pinctrl code
Date:   Thu,  1 Jun 2023 17:20:23 +0200
Message-Id: <20230601152026.1182648-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
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

The common MSM pinctrl driver code (PINCTRL_MSM) uses
pinconf_generic_dt_node_to_map_group() from GENERIC_PINCONF, which is
not available for compile testing for !OF cases.  Drivers actually do
not depend on OF.  Move the OF dependency to the entry actually
depending on it and drop any "|| COMPILE_TEST", because OF is required
also for compile testing (lack of OF was never visible in compile
testing because none of the drivers could be compile tested due to
Makefile).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 43 ++----------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2236bdff7e60..18ac19f41873 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -4,6 +4,8 @@ if (ARCH_QCOM || COMPILE_TEST)
 config PINCTRL_MSM
 	tristate "Qualcomm core pin controller driver"
 	depends on GPIOLIB
+	# OF for pinconf_generic_dt_node_to_map_group() from GENERIC_PINCONF
+	depends on OF
 	select QCOM_SCM
 	select PINMUX
 	select PINCONF
@@ -14,7 +16,6 @@ config PINCTRL_MSM
 
 config PINCTRL_APQ8064
 	tristate "Qualcomm APQ8064 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -23,7 +24,6 @@ config PINCTRL_APQ8064
 
 config PINCTRL_APQ8084
 	tristate "Qualcomm APQ8084 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -32,7 +32,6 @@ config PINCTRL_APQ8084
 
 config PINCTRL_IPQ4019
 	tristate "Qualcomm IPQ4019 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -41,7 +40,6 @@ config PINCTRL_IPQ4019
 
 config PINCTRL_IPQ8064
 	tristate "Qualcomm IPQ8064 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -50,7 +48,6 @@ config PINCTRL_IPQ8064
 
 config PINCTRL_IPQ5332
 	tristate "Qualcomm Technologies Inc IPQ5332 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -60,7 +57,6 @@ config PINCTRL_IPQ5332
 
 config PINCTRL_IPQ8074
 	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -71,7 +67,6 @@ config PINCTRL_IPQ8074
 
 config PINCTRL_IPQ6018
 	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -82,7 +77,6 @@ config PINCTRL_IPQ6018
 
 config PINCTRL_IPQ9574
 	tristate "Qualcomm Technologies, Inc. IPQ9574 pin controller driver"
-	depends on OF || COMPILE_TEST
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -93,7 +87,6 @@ config PINCTRL_IPQ9574
 
 config PINCTRL_MSM8226
 	tristate "Qualcomm 8226 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -103,7 +96,6 @@ config PINCTRL_MSM8226
 
 config PINCTRL_MSM8660
 	tristate "Qualcomm 8660 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -112,7 +104,6 @@ config PINCTRL_MSM8660
 
 config PINCTRL_MSM8960
 	tristate "Qualcomm 8960 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -121,7 +112,6 @@ config PINCTRL_MSM8960
 
 config PINCTRL_MDM9607
 	tristate "Qualcomm 9607 pin controller driver"
-	depends on OF
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -129,7 +119,6 @@ config PINCTRL_MDM9607
 
 config PINCTRL_MDM9615
 	tristate "Qualcomm 9615 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -138,7 +127,6 @@ config PINCTRL_MDM9615
 
 config PINCTRL_MSM8X74
 	tristate "Qualcomm 8x74 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -147,7 +135,6 @@ config PINCTRL_MSM8X74
 
 config PINCTRL_MSM8909
 	tristate "Qualcomm 8909 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -156,7 +143,6 @@ config PINCTRL_MSM8909
 
 config PINCTRL_MSM8916
 	tristate "Qualcomm 8916 pin controller driver"
-	depends on OF
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -164,7 +150,6 @@ config PINCTRL_MSM8916
 
 config PINCTRL_MSM8953
 	tristate "Qualcomm 8953 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -175,7 +160,6 @@ config PINCTRL_MSM8953
 
 config PINCTRL_MSM8976
 	tristate "Qualcomm 8976 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -186,7 +170,6 @@ config PINCTRL_MSM8976
 
 config PINCTRL_MSM8994
 	tristate "Qualcomm 8994 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -196,7 +179,6 @@ config PINCTRL_MSM8994
 
 config PINCTRL_MSM8996
 	tristate "Qualcomm MSM8996 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -205,7 +187,6 @@ config PINCTRL_MSM8996
 
 config PINCTRL_MSM8998
 	tristate "Qualcomm MSM8998 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -214,7 +195,6 @@ config PINCTRL_MSM8998
 
 config PINCTRL_QCM2290
 	tristate "Qualcomm QCM2290 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -223,7 +203,6 @@ config PINCTRL_QCM2290
 
 config PINCTRL_QCS404
 	tristate "Qualcomm QCS404 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -271,7 +250,6 @@ config PINCTRL_QCOM_SSBI_PMIC
 
 config PINCTRL_QDU1000
 	tristate "Qualcomm Technologies Inc QDU1000/QRU1000 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -281,7 +259,6 @@ config PINCTRL_QDU1000
 
 config PINCTRL_SA8775P
 	tristate "Qualcomm Technologies Inc SA8775P pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -290,7 +267,6 @@ config PINCTRL_SA8775P
 
 config PINCTRL_SC7180
 	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -300,7 +276,6 @@ config PINCTRL_SC7180
 
 config PINCTRL_SC7280
 	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -329,7 +304,6 @@ config PINCTRL_SC8180X
 
 config PINCTRL_SC8280XP
 	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -339,7 +313,6 @@ config PINCTRL_SC8280XP
 
 config PINCTRL_SDM660
 	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -349,7 +322,6 @@ config PINCTRL_SDM660
 
 config PINCTRL_SDM670
 	tristate "Qualcomm Technologies Inc SDM670 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -369,7 +341,6 @@ config PINCTRL_SDM845
 
 config PINCTRL_SDX55
 	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -379,7 +350,6 @@ config PINCTRL_SDX55
 
 config PINCTRL_SDX65
         tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
-        depends on OF
         depends on ARM || COMPILE_TEST
         depends on PINCTRL_MSM
         help
@@ -389,7 +359,6 @@ config PINCTRL_SDX65
 
 config PINCTRL_SDX75
         tristate "Qualcomm Technologies Inc SDX75 pin controller driver"
-        depends on OF
         depends on ARM64 || COMPILE_TEST
         depends on PINCTRL_MSM
         help
@@ -399,7 +368,6 @@ config PINCTRL_SDX75
 
 config PINCTRL_SM6115
 	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -409,7 +377,6 @@ config PINCTRL_SM6115
 
 config PINCTRL_SM6125
 	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -419,7 +386,6 @@ config PINCTRL_SM6125
 
 config PINCTRL_SM6350
 	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -429,7 +395,6 @@ config PINCTRL_SM6350
 
 config PINCTRL_SM6375
 	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -439,7 +404,6 @@ config PINCTRL_SM6375
 
 config PINCTRL_SM7150
 	tristate "Qualcomm Technologies Inc SM7150 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -449,7 +413,6 @@ config PINCTRL_SM7150
 
 config PINCTRL_SM8150
 	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -459,7 +422,6 @@ config PINCTRL_SM8150
 
 config PINCTRL_SM8250
 	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -487,7 +449,6 @@ config PINCTRL_SM8350
 
 config PINCTRL_SM8450
 	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
-- 
2.34.1

