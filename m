Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333A5E89C1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiIXIH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiIXIGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:06:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FB12579B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w8so3474947lft.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Q5dFwhz+edvWchiYpL/Tsu1LCXZgF2hAyN0xPGws2rk=;
        b=lYgFmekYB50Zn9KViRzYwJLlONX1+wIkUsdAol4JZiqkW4I2z5K3wGdRIlUk9qVhTC
         +/QDcSMeJ2u/OKYJJB38B0oTINgdPfxcuehvkFTUbNZZLymkpUmunj/aCXRdhhWiRp0r
         09aIcNlzhf2eGhG3fDpm1/PaWk86HNsMxC/AZ7efT7moyaqtx0XR+rPYC/C+DDOB6XxG
         YQws/LLT4qt5y3tI9fOvhto3hJ6IPlZELPIbTyNwe16Bd21nRD5wa1ESa1f8xQGrKT/G
         ATBE63uIFkGwf1aABDv0t3HdUzCspCt6U/sY+WU9+feaOXkbGzezSN2zXQBD26pCZyDu
         ECug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q5dFwhz+edvWchiYpL/Tsu1LCXZgF2hAyN0xPGws2rk=;
        b=mbERzKqLFyxfJsK4wlkTJnqU98TmjTYUG2C1pYkckLYkgd0vyxmUGvFxp0yFmE1g+S
         Ma+7y6eOklBfc8T0VyYLsdbc/csluuEwi15vpbkfTaupZTN/L51lYNJN2IbzIpoetfrb
         o9rXdyxfAN/FAK7k7v2h6WFH7VnasqhJIRJS/3oIcRtXxa7s1CLjVoI/+Vvg+5mI+zT3
         IUSyiAmbBHxogyWxWOT5p4Tv5XCRe1koXE6C5Ae3c2lNHkchw6UsZstraIpjeNo98KK2
         ipAaiPoe9Dj1GhSfoQ/lSsIWOPNOVLkhiGgljqykAC5ER4ZDVyCQR5uzPiJmZZb6EJL9
         csaw==
X-Gm-Message-State: ACrzQf0nULWKgDDZK6xgf/aSio/NDBotaVh6geEfOW+tTovyuvc1Ah2t
        WuFswNeCz83NX2cA8gDovnp5Fg==
X-Google-Smtp-Source: AMsMyM7KegMaIGZG+TBkBpyFQfR7Jmx/BeTgWcRH+6qR0xtKP8Ugwl4qEwkOnbGI13LW+Q15ZG7KcA==
X-Received: by 2002:ac2:5097:0:b0:498:f5b9:7a6f with SMTP id f23-20020ac25097000000b00498f5b97a6fmr4786708lfm.640.1664006737771;
        Sat, 24 Sep 2022 01:05:37 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 23/32] dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
Date:   Sat, 24 Sep 2022 10:04:50 +0200
Message-Id: <20220924080459.13084-24-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
index ef22090fd6d6..3757d6841085 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
@@ -129,14 +129,14 @@ patternProperties:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        tlmm: pinctrl@1000000 {
-          compatible = "qcom,mdm9607-tlmm";
-          reg = <0x01000000 0x300000>;
-          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-          gpio-controller;
-          gpio-ranges = <&msmgpio 0 0 80>;
-          #gpio-cells = <2>;
-          interrupt-controller;
-          #interrupt-cells = <2>;
-        };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,mdm9607-tlmm";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&msmgpio 0 0 80>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
-- 
2.34.1

