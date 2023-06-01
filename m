Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6003171A26D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjFAPVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjFAPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:21:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B97E61
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:21:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso1531487a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685632869; x=1688224869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8nlnubYNvCAitFaTU3QcGudPdM58mPtxVVVjolot6o=;
        b=ZBlWEL/ihwO0cFS/n2toyk7ftzADUjob1wvn3YHoGaKAAJ09OTOPQNtqpI9c3dMpq6
         jn79y3OCgfqnETxRkcFOQ7opzpV3ygDgg6ZJGEwnfJNfZk/lVV8YEWvpYAcVpjCEJC8b
         J64gQNgmoX/RYlpAMh7xkYxpTRM/xYpbrHQzF0BOdqTYm6xOyQTGears331hMKY1eLWc
         vuUZjuwsZmE9xICsVK4SdtRYdqSHNMqpKzz+Gg2wbLn8JXnLmJ1w4EXXVevZjjp6F7sO
         xjF3htV7Sg0KWqhh8itD70MxaZ4+RBahFoIOwgMhnIhGPkFT0+kUsJCDRCKBdPua8cgk
         cWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632869; x=1688224869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8nlnubYNvCAitFaTU3QcGudPdM58mPtxVVVjolot6o=;
        b=HcpCzFeWiaf2Eq/P4Otxg9rjw2fyGkkSuheIv3tZiZfR2RF6r026fmMTXGH1iHGh/t
         Ts5pI/0mKf6dZ37y3Ibj26/3F6n9kmUghZSPdY7biD+qZmgBn6Z6RPf82WN/4cEtDeF3
         UB9cUes6TLJ+g+0dvonNmFi2loP2VNjOP8MBtVFUpCwgUUWJEOevu7jQV4ZsxKRKQINw
         LtyUGnFA1tdTw5KNtrce8Z7yGAsEo+AGCA5mXVaokUdJHuVeSI5qtpmAs+wA06PxzFzc
         RCBpgf1mzkYnCL+/ktZ/L9xshMemAABIuBPA85zq27X1vh9aTZ36rEmY5WaH2EBzXQIc
         DArg==
X-Gm-Message-State: AC+VfDxxwT/74HCGxPVGWBs+svzZCBQWrLT0//OL3lspiZecULAcP6pJ
        q/p2+fRDALM4DcK5LyECyjG2Rw==
X-Google-Smtp-Source: ACHHUZ7HdSjfTb+UKgw2wxq5n+2gX9erM3Q8mxltpuSD7QNKz0z27jxUUUSTVhhvj/z2bq8NvrAwiA==
X-Received: by 2002:aa7:d389:0:b0:509:f221:cee2 with SMTP id x9-20020aa7d389000000b00509f221cee2mr122915edq.32.1685632869070;
        Thu, 01 Jun 2023 08:21:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402160e00b0051422f31b1bsm7298664edv.63.2023.06.01.08.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:21:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 8/8] pinctrl: qcom: organize audio drivers in menuconfig
Date:   Thu,  1 Jun 2023 17:20:26 +0200
Message-Id: <20230601152026.1182648-8-krzysztof.kozlowski@linaro.org>
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

The audio pin controller drivers depend on PINCTRL_LPASS_LPI, but since
PINCTRL_LPASS_LPI is not the first entry, they are not displayed in
menuconfig as dependent of PINCTRL_LPASS_LPI.  Re-order the entries to
fix this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index f1c23a641fe1..634c75336983 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -47,6 +47,18 @@ config PINCTRL_QCOM_SSBI_PMIC
 	 which are using SSBI for communication with SoC. Example PMIC's
 	 devices are pm8058 and pm8921.
 
+config PINCTRL_LPASS_LPI
+	tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
+	depends on GPIOLIB
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
+	  (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
+
 config PINCTRL_SC7280_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
@@ -93,16 +105,4 @@ config PINCTRL_SM8550_LPASS_LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SM8550
 	  platform.
 
-config PINCTRL_LPASS_LPI
-	tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
-	select PINMUX
-	select PINCONF
-	select GENERIC_PINCONF
-	select GENERIC_PINCTRL_GROUPS
-	depends on GPIOLIB
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
-	  (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
-
 endif
-- 
2.34.1

