Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019B571A272
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjFAPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbjFAPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:20:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86FB197
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:20:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so1499456a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685632849; x=1688224849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyRYXCjCPdA4GAOYKwIB0YmSc3LFJczxSof9rgZKnIg=;
        b=X8lthekv3nQ7reF1HZ6wEh0qLmah+Qclga1WcLOumKmSDURkIJAm20SKaudD39Ocjp
         XdB8Y5U89GSvu48xpGRlVbO3X/YVHO94/Mpp+qhF2m0J+82zr6+D+lndTDhj7G+IuJdL
         JdE3aRMm73MFVbPWAvNZVFkJlnP8gK0oy5dSIOv+j/E3oDjQQuzlHYs5yPKYjFd4O3UX
         tBQ4QsRW/DAreOZcL3reyDnrQiLfwdVt44eDLCC88lXQ6SzRYKHDVvq7kGNhzA11G4sn
         DY+291hkBB7OzxqgMZ3oSv0DhD/GcJ754XUtelHri2j0yoHIxhL3nYtv8UiPmK6oGwBz
         OwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632849; x=1688224849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyRYXCjCPdA4GAOYKwIB0YmSc3LFJczxSof9rgZKnIg=;
        b=gYvIATaPkBWpXZ3b8ylqUk5CwcsNRxHhC/Xcn3pxbNAqNVfvaqygI2wgGFONAG3gjR
         MdlJTTgxg2WY+WvM7PhEevi1iutwHkFKgxvltqI5/MyS19PuoDUehSGEuFGOGD1nttEh
         /Y+VcTmvL/oUD9LDdBFNVW2WHXK468oge2AaUUaW4H388zD4k7fttdXPmVv+wByx1qRQ
         PC1bceXBtVdyh7T2gEBtiIHMNwNQ4BlFoaNwITBAN9TKAdORiKjTxZFhLDonbHCaIARw
         Sl2UOwOgekZhDG54vTuAQqE8SYXwulI/e8R+/9XTGUKEuRrxNfFir58rdcKzxYayjprP
         hgvw==
X-Gm-Message-State: AC+VfDxPs2Ngo71JiflJWdYVhR2ysYy8KVf8sb06w91XZyHMKEHp7yBV
        HA/wvBC98qEaveVqYX59owqxpA==
X-Google-Smtp-Source: ACHHUZ7IHyR7eRjddisgEDgo9r/PHoGBao5VcjWbYXgKak5iwHmVsLhXex0caJGfSLO8ivgBxRVJkg==
X-Received: by 2002:a05:6402:14c3:b0:514:b1d6:d37f with SMTP id f3-20020a05640214c300b00514b1d6d37fmr206155edx.19.1685632849500;
        Thu, 01 Jun 2023 08:20:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402160e00b0051422f31b1bsm7298664edv.63.2023.06.01.08.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:20:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/8] pinctrl: qcom: drop unneeded GPIOLIB dependency
Date:   Thu,  1 Jun 2023 17:20:22 +0200
Message-Id: <20230601152026.1182648-4-krzysztof.kozlowski@linaro.org>
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

PINCTRL_MSM depends on GPIOLIB, thus individual driver entries depending
on the first do not have to depend on the latter.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index b03a62ecdc07..2236bdff7e60 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -121,7 +121,7 @@ config PINCTRL_MSM8960
 
 config PINCTRL_MDM9607
 	tristate "Qualcomm 9607 pin controller driver"
-	depends on GPIOLIB && OF
+	depends on OF
 	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
@@ -271,7 +271,7 @@ config PINCTRL_QCOM_SSBI_PMIC
 
 config PINCTRL_QDU1000
 	tristate "Qualcomm Technologies Inc QDU1000/QRU1000 pin controller driver"
-	depends on GPIOLIB && OF
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -310,7 +310,6 @@ config PINCTRL_SC7280
 
 config PINCTRL_SC7280_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
-	depends on GPIOLIB
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
@@ -380,7 +379,7 @@ config PINCTRL_SDX55
 
 config PINCTRL_SDX65
         tristate "Qualcomm Technologies Inc SDX65 pin controller driver"
-        depends on GPIOLIB && OF
+        depends on OF
         depends on ARM || COMPILE_TEST
         depends on PINCTRL_MSM
         help
@@ -390,7 +389,7 @@ config PINCTRL_SDX65
 
 config PINCTRL_SDX75
         tristate "Qualcomm Technologies Inc SDX75 pin controller driver"
-        depends on GPIOLIB && OF
+        depends on OF
         depends on ARM64 || COMPILE_TEST
         depends on PINCTRL_MSM
         help
@@ -400,7 +399,7 @@ config PINCTRL_SDX75
 
 config PINCTRL_SM6115
 	tristate "Qualcomm Technologies Inc SM6115,SM4250 pin controller driver"
-	depends on GPIOLIB && OF
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -420,7 +419,7 @@ config PINCTRL_SM6125
 
 config PINCTRL_SM6350
 	tristate "Qualcomm Technologies Inc SM6350 pin controller driver"
-	depends on GPIOLIB && OF
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -430,7 +429,7 @@ config PINCTRL_SM6350
 
 config PINCTRL_SM6375
 	tristate "Qualcomm Technologies Inc SM6375 pin controller driver"
-	depends on GPIOLIB && OF
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -470,7 +469,6 @@ config PINCTRL_SM8250
 
 config PINCTRL_SM8250_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
-	depends on GPIOLIB
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
@@ -489,7 +487,7 @@ config PINCTRL_SM8350
 
 config PINCTRL_SM8450
 	tristate "Qualcomm Technologies Inc SM8450 pin controller driver"
-	depends on GPIOLIB && OF
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -499,7 +497,6 @@ config PINCTRL_SM8450
 
 config PINCTRL_SM8450_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
-	depends on GPIOLIB
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
@@ -509,7 +506,6 @@ config PINCTRL_SM8450_LPASS_LPI
 
 config PINCTRL_SC8280XP_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SC8280XP LPASS LPI pin controller driver"
-	depends on GPIOLIB
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
@@ -519,7 +515,6 @@ config PINCTRL_SC8280XP_LPASS_LPI
 
 config PINCTRL_SM8550
 	tristate "Qualcomm Technologies Inc SM8550 pin controller driver"
-	depends on GPIOLIB
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_MSM
 	help
@@ -529,7 +524,6 @@ config PINCTRL_SM8550
 
 config PINCTRL_SM8550_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8550 LPASS LPI pin controller driver"
-	depends on GPIOLIB
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
-- 
2.34.1

