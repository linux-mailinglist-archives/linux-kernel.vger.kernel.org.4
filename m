Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F6A71A26A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjFAPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjFAPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:21:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61149197
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:21:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so1469397a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685632864; x=1688224864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCj4ihjZhuT0JIZclPDZ/If45D3eel9gFOei53u/gGY=;
        b=ZYX7e3EjiXDchsH+FPqWqFFj4cjZv/WtpGZjf79HVbJiGrB22tjDpvnqcMPQVUPl6D
         gEsxWDa30QfdhLvAzY3kn06WKNp+JAS2nAGFinLsfm/WkjrrenxYZ0SK56hzARksvtGi
         HXFlQLjVrG2Hx68weJ/WRhNGGr72qQBiiFHtDzIJS5T0l7O5tpN4FwbFMUaIFEA8t1/3
         oSfdaknKS1VoIr8N3xUOZNRUieahiHc+R7mErADn5D9+5avVc7PaLnjd2MtV1gBrLoBg
         KdF127CaaILxo6Wkb3Y178nciRPJrA1/96iPbaZCFKjgaHwbaOfGYzG7eOZMcaRJW5k3
         XzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632864; x=1688224864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCj4ihjZhuT0JIZclPDZ/If45D3eel9gFOei53u/gGY=;
        b=WxRZn4VES377Gu131pbnmD4Om6hpE1Vy1dSDyr1RZTQRbZakkCvqk2f3Yw9R2Qx2XR
         1XW3L1Z2n0F1bcTbqOCyQ0yl2h7ggrnBAXolE3NspsFRpDtgV7+NXiCE5PgDCaz0tTfW
         LFRTWFWKuOiEfArWAMKScYUlxAQcGHxv8ojRXHumWIFNYrPUVc+k87NuQ5whH+U7kjuY
         UAslxXdxoyUhOWOb0i2ccJsHXTVyqFXs5yPjzPEe187MbS7lAk/dVZ2lcBJjezN/2Ci3
         8HlOT5B7P8VV8SRQJVs9h2RKAe2C6x5yo4aCle1l1chZElhTRp9WYnv0JPyVXmuDx5gZ
         n6Bg==
X-Gm-Message-State: AC+VfDyN6C5PIfs1GNTGId+W/jkkxHUqXoSDfdIOBZvqcKhglqnN4fX6
        yJF+NWWQuyeq0Dwdvbj0LR3NMQ==
X-Google-Smtp-Source: ACHHUZ4G6Z5o3J5u4XmqukIuWHoQEAYgIT6Ms4k2uF66Vrmpa+yyU80VLvs9g7o5rO1Fi/CYf7kQMQ==
X-Received: by 2002:aa7:c2d9:0:b0:514:9c7c:8a37 with SMTP id m25-20020aa7c2d9000000b005149c7c8a37mr152418edp.28.1685632863653;
        Thu, 01 Jun 2023 08:21:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402160e00b0051422f31b1bsm7298664edv.63.2023.06.01.08.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:21:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/8] pinctrl: qcom: organize main SoC drivers in new Kconfig.msm
Date:   Thu,  1 Jun 2023 17:20:25 +0200
Message-Id: <20230601152026.1182648-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In menuconfig, some entries depending on PINCTRL_MSM are indented and
expressed as dependening but some not, because of other Kconfig entries
in between,

Move all main Qualcomm SoC pin controller driver entries into new
Kconfig.msm file so they will be nicely ordered in Kconfig file (by
CONFIG_ name) and properly indented as PINCTRL_MSM dependency in
menuconfig.

Functionally this is the same, but since entire file is guarded with "if
PINCTRL_MSM" drop this dependency from individual entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig     | 402 +------------------------------
 drivers/pinctrl/qcom/Kconfig.msm | 360 +++++++++++++++++++++++++++
 2 files changed, 361 insertions(+), 401 deletions(-)
 create mode 100644 drivers/pinctrl/qcom/Kconfig.msm

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 18ac19f41873..f1c23a641fe1 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -14,208 +14,7 @@ config PINCTRL_MSM
 	select IRQ_DOMAIN_HIERARCHY
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 
-config PINCTRL_APQ8064
-	tristate "Qualcomm APQ8064 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm APQ8064 platform.
-
-config PINCTRL_APQ8084
-	tristate "Qualcomm APQ8084 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm APQ8084 platform.
-
-config PINCTRL_IPQ4019
-	tristate "Qualcomm IPQ4019 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm IPQ4019 platform.
-
-config PINCTRL_IPQ8064
-	tristate "Qualcomm IPQ8064 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm IPQ8064 platform.
-
-config PINCTRL_IPQ5332
-	tristate "Qualcomm Technologies Inc IPQ5332 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc IPQ5332 platform.
-
-config PINCTRL_IPQ8074
-	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
-	  the Qualcomm Technologies Inc. TLMM block found on the
-	  Qualcomm Technologies Inc. IPQ8074 platform. Select this for
-	  IPQ8074.
-
-config PINCTRL_IPQ6018
-	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
-	  the Qualcomm Technologies Inc. TLMM block found on the
-	  Qualcomm Technologies Inc. IPQ6018 platform. Select this for
-	  IPQ6018.
-
-config PINCTRL_IPQ9574
-	tristate "Qualcomm Technologies, Inc. IPQ9574 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
-          the Qualcomm Technologies Inc. TLMM block found on the
-          Qualcomm Technologies Inc. IPQ9574 platform. Select this for
-          IPQ9574.
-
-config PINCTRL_MSM8226
-	tristate "Qualcomm 8226 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc MSM8226 platform.
-
-config PINCTRL_MSM8660
-	tristate "Qualcomm 8660 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm 8660 platform.
-
-config PINCTRL_MSM8960
-	tristate "Qualcomm 8960 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm 8960 platform.
-
-config PINCTRL_MDM9607
-	tristate "Qualcomm 9607 pin controller driver"
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm 9607 platform.
-
-config PINCTRL_MDM9615
-	tristate "Qualcomm 9615 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm 9615 platform.
-
-config PINCTRL_MSM8X74
-	tristate "Qualcomm 8x74 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm 8974 platform.
-
-config PINCTRL_MSM8909
-	tristate "Qualcomm 8909 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found on the Qualcomm MSM8909 platform.
-
-config PINCTRL_MSM8916
-	tristate "Qualcomm 8916 pin controller driver"
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found on the Qualcomm 8916 platform.
-
-config PINCTRL_MSM8953
-	tristate "Qualcomm 8953 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found on the Qualcomm MSM8953 platform.
-	  The Qualcomm APQ8053, SDM450, SDM632 platforms are also
-	  supported by this driver.
-
-config PINCTRL_MSM8976
-	tristate "Qualcomm 8976 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found on the Qualcomm MSM8976 platform.
-	  The Qualcomm MSM8956, APQ8056, APQ8076 platforms are also
-	  supported by this driver.
-
-config PINCTRL_MSM8994
-	tristate "Qualcomm 8994 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm 8994 platform. The
-	  Qualcomm 8992 platform is also supported by this driver.
-
-config PINCTRL_MSM8996
-	tristate "Qualcomm MSM8996 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm MSM8996 platform.
-
-config PINCTRL_MSM8998
-	tristate "Qualcomm MSM8998 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm TLMM block found in the Qualcomm MSM8998 platform.
-
-config PINCTRL_QCM2290
-	tristate "Qualcomm QCM2290 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  TLMM block found in the Qualcomm QCM2290 platform.
-
-config PINCTRL_QCS404
-	tristate "Qualcomm QCS404 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  TLMM block found in the Qualcomm QCS404 platform.
-
-config PINCTRL_QDF2XXX
-	tristate "Qualcomm Technologies QDF2xxx pin controller driver"
-	depends on ACPI
-	depends on PINCTRL_MSM
-	help
-	  This is the GPIO driver for the TLMM block found on the
-	  Qualcomm Technologies QDF2xxx SOCs.
+source "drivers/pinctrl/qcom/Kconfig.msm"
 
 config PINCTRL_QCOM_SPMI_PMIC
 	tristate "Qualcomm SPMI PMIC pin controller driver"
@@ -248,41 +47,6 @@ config PINCTRL_QCOM_SSBI_PMIC
 	 which are using SSBI for communication with SoC. Example PMIC's
 	 devices are pm8058 and pm8921.
 
-config PINCTRL_QDU1000
-	tristate "Qualcomm Technologies Inc QDU1000/QRU1000 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc QDU1000 and QRU1000 platforms.
-
-config PINCTRL_SA8775P
-	tristate "Qualcomm Technologies Inc SA8775P pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux and pinconf driver for the Qualcomm
-	  TLMM block found on the Qualcomm SA8775P platforms.
-
-config PINCTRL_SC7180
-	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc SC7180 platform.
-
-config PINCTRL_SC7280
-	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc SC7280 platform.
-
 config PINCTRL_SC7280_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
@@ -292,143 +56,6 @@ config PINCTRL_SC7280_LPASS_LPI
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
 
-config PINCTRL_SC8180X
-	tristate "Qualcomm Technologies Inc SC8180x pin controller driver"
-	depends on (OF || ACPI)
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc SC8180x platform.
-
-config PINCTRL_SC8280XP
-	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc SC8280xp platform.
-
-config PINCTRL_SDM660
-	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SDM660 platform.
-
-config PINCTRL_SDM670
-	tristate "Qualcomm Technologies Inc SDM670 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SDM670 platform.
-
-config PINCTRL_SDM845
-	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
-	depends on (OF || ACPI)
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SDM845 platform.
-
-config PINCTRL_SDX55
-	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
-	depends on ARM || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SDX55 platform.
-
-config PINCTRL_SDX65
-        tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
-        depends on ARM || COMPILE_TEST
-        depends on PINCTRL_MSM
-        help
-         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-         Qualcomm Technologies Inc TLMM block found on the Qualcomm
-         Technologies Inc SDX65 platform.
-
-config PINCTRL_SDX75
-        tristate "Qualcomm Technologies Inc SDX75 pin controller driver"
-        depends on ARM64 || COMPILE_TEST
-        depends on PINCTRL_MSM
-        help
-         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-         Qualcomm Technologies Inc TLMM block found on the Qualcomm
-         Technologies Inc SDX75 platform.
-
-config PINCTRL_SM6115
-	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SM6115 and SM4250 platforms.
-
-config PINCTRL_SM6125
-	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SM6125 platform.
-
-config PINCTRL_SM6350
-	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SM6350 platform.
-
-config PINCTRL_SM6375
-	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SM6375 platform.
-
-config PINCTRL_SM7150
-	tristate "Qualcomm Technologies Inc SM7150 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SM7150 platform.
-
-config PINCTRL_SM8150
-	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	 Technologies Inc SM8150 platform.
-
-config PINCTRL_SM8250
-	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc SM8250 platform.
-
 config PINCTRL_SM8250_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
@@ -438,24 +65,6 @@ config PINCTRL_SM8250_LPASS_LPI
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
 
-config PINCTRL_SM8350
-	tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc SM8350 platform.
-
-config PINCTRL_SM8450
-	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc SM8450 platform.
-
 config PINCTRL_SM8450_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
@@ -474,15 +83,6 @@ config PINCTRL_SC8280XP_LPASS_LPI
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SC8280XP platform.
 
-config PINCTRL_SM8550
-	tristate "Qualcomm Technologies Inc SM8550 pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MSM
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
-	  Technologies Inc SM8550 platform.
-
 config PINCTRL_SM8550_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8550 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pinctrl/qcom/Kconfig.msm b/drivers/pinctrl/qcom/Kconfig.msm
new file mode 100644
index 000000000000..e03042e80a0d
--- /dev/null
+++ b/drivers/pinctrl/qcom/Kconfig.msm
@@ -0,0 +1,360 @@
+# SPDX-License-Identifier: GPL-2.0-only
+if PINCTRL_MSM
+
+config PINCTRL_APQ8064
+	tristate "Qualcomm APQ8064 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm APQ8064 platform.
+
+config PINCTRL_APQ8084
+	tristate "Qualcomm APQ8084 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm APQ8084 platform.
+
+config PINCTRL_IPQ4019
+	tristate "Qualcomm IPQ4019 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm IPQ4019 platform.
+
+config PINCTRL_IPQ8064
+	tristate "Qualcomm IPQ8064 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm IPQ8064 platform.
+
+config PINCTRL_IPQ5332
+	tristate "Qualcomm Technologies Inc IPQ5332 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc IPQ5332 platform.
+
+config PINCTRL_IPQ8074
+	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
+	  the Qualcomm Technologies Inc. TLMM block found on the
+	  Qualcomm Technologies Inc. IPQ8074 platform. Select this for
+	  IPQ8074.
+
+config PINCTRL_IPQ6018
+	tristate "Qualcomm Technologies, Inc. IPQ6018 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
+	  the Qualcomm Technologies Inc. TLMM block found on the
+	  Qualcomm Technologies Inc. IPQ6018 platform. Select this for
+	  IPQ6018.
+
+config PINCTRL_IPQ9574
+	tristate "Qualcomm Technologies, Inc. IPQ9574 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
+          the Qualcomm Technologies Inc. TLMM block found on the
+          Qualcomm Technologies Inc. IPQ9574 platform. Select this for
+          IPQ9574.
+
+config PINCTRL_MSM8226
+	tristate "Qualcomm 8226 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc MSM8226 platform.
+
+config PINCTRL_MSM8660
+	tristate "Qualcomm 8660 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm 8660 platform.
+
+config PINCTRL_MSM8960
+	tristate "Qualcomm 8960 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm 8960 platform.
+
+config PINCTRL_MDM9607
+	tristate "Qualcomm 9607 pin controller driver"
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm 9607 platform.
+
+config PINCTRL_MDM9615
+	tristate "Qualcomm 9615 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm 9615 platform.
+
+config PINCTRL_MSM8X74
+	tristate "Qualcomm 8x74 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm 8974 platform.
+
+config PINCTRL_MSM8909
+	tristate "Qualcomm 8909 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found on the Qualcomm MSM8909 platform.
+
+config PINCTRL_MSM8916
+	tristate "Qualcomm 8916 pin controller driver"
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found on the Qualcomm 8916 platform.
+
+config PINCTRL_MSM8953
+	tristate "Qualcomm 8953 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found on the Qualcomm MSM8953 platform.
+	  The Qualcomm APQ8053, SDM450, SDM632 platforms are also
+	  supported by this driver.
+
+config PINCTRL_MSM8976
+	tristate "Qualcomm 8976 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found on the Qualcomm MSM8976 platform.
+	  The Qualcomm MSM8956, APQ8056, APQ8076 platforms are also
+	  supported by this driver.
+
+config PINCTRL_MSM8994
+	tristate "Qualcomm 8994 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm 8994 platform. The
+	  Qualcomm 8992 platform is also supported by this driver.
+
+config PINCTRL_MSM8996
+	tristate "Qualcomm MSM8996 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm MSM8996 platform.
+
+config PINCTRL_MSM8998
+	tristate "Qualcomm MSM8998 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm TLMM block found in the Qualcomm MSM8998 platform.
+
+config PINCTRL_QCM2290
+	tristate "Qualcomm QCM2290 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  TLMM block found in the Qualcomm QCM2290 platform.
+
+config PINCTRL_QCS404
+	tristate "Qualcomm QCS404 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  TLMM block found in the Qualcomm QCS404 platform.
+
+config PINCTRL_QDF2XXX
+	tristate "Qualcomm Technologies QDF2xxx pin controller driver"
+	depends on ACPI
+	help
+	  This is the GPIO driver for the TLMM block found on the
+	  Qualcomm Technologies QDF2xxx SOCs.
+
+config PINCTRL_QDU1000
+	tristate "Qualcomm Technologies Inc QDU1000/QRU1000 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc QDU1000 and QRU1000 platforms.
+
+config PINCTRL_SA8775P
+	tristate "Qualcomm Technologies Inc SA8775P pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux and pinconf driver for the Qualcomm
+	  TLMM block found on the Qualcomm SA8775P platforms.
+
+config PINCTRL_SC7180
+	tristate "Qualcomm Technologies Inc SC7180 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SC7180 platform.
+
+config PINCTRL_SC7280
+	tristate "Qualcomm Technologies Inc SC7280 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SC7280 platform.
+
+config PINCTRL_SC8180X
+	tristate "Qualcomm Technologies Inc SC8180x pin controller driver"
+	depends on (OF || ACPI)
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SC8180x platform.
+
+config PINCTRL_SC8280XP
+	tristate "Qualcomm Technologies Inc SC8280xp pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SC8280xp platform.
+
+config PINCTRL_SDM660
+	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SDM660 platform.
+
+config PINCTRL_SDM670
+	tristate "Qualcomm Technologies Inc SDM670 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SDM670 platform.
+
+config PINCTRL_SDM845
+	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
+	depends on (OF || ACPI)
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SDM845 platform.
+
+config PINCTRL_SDX55
+	tristate "Qualcomm Technologies Inc SDX55 pin controller driver"
+	depends on ARM || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SDX55 platform.
+
+config PINCTRL_SDX65
+        tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
+        depends on ARM || COMPILE_TEST
+        help
+         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+         Qualcomm Technologies Inc TLMM block found on the Qualcomm
+         Technologies Inc SDX65 platform.
+
+config PINCTRL_SDX75
+        tristate "Qualcomm Technologies Inc SDX75 pin controller driver"
+        depends on ARM64 || COMPILE_TEST
+        help
+         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+         Qualcomm Technologies Inc TLMM block found on the Qualcomm
+         Technologies Inc SDX75 platform.
+
+config PINCTRL_SM6115
+	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SM6115 and SM4250 platforms.
+
+config PINCTRL_SM6125
+	tristate "Qualcomm Technologies Inc SM6125 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SM6125 platform.
+
+config PINCTRL_SM6350
+	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SM6350 platform.
+
+config PINCTRL_SM6375
+	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SM6375 platform.
+
+config PINCTRL_SM7150
+	tristate "Qualcomm Technologies Inc SM7150 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SM7150 platform.
+
+config PINCTRL_SM8150
+	tristate "Qualcomm Technologies Inc SM8150 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	 Technologies Inc SM8150 platform.
+
+config PINCTRL_SM8250
+	tristate "Qualcomm Technologies Inc SM8250 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SM8250 platform.
+
+config PINCTRL_SM8350
+	tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SM8350 platform.
+
+config PINCTRL_SM8450
+	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SM8450 platform.
+
+config PINCTRL_SM8550
+	tristate "Qualcomm Technologies Inc SM8550 pin controller driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SM8550 platform.
+
+endif
-- 
2.34.1

