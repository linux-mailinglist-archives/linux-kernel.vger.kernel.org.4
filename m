Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6289A5ECB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiI0Rl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiI0RkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:40:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AE91D980A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z25so16822393lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jxM1ze0TJoMq0tnGJSQJuEhnSrZAlWLgaVv7dZzzKys=;
        b=aN3hTO9Euh7t/ZKm9hwN+KEzSzrY+9EuyxsGym/WuYHDQ1HzmXm6/CFoykzbPgE7h/
         Y8OEIaZAcgrihIP6pWh5kymH5zmEbTHFTn0uPAcFXbHW52AJBIu6HAQWlJtMdroD65tS
         FueAtml01BoN9eagIppg3YWnaoc/si7lGkYT5NpjaV1tnt+z8dRsHmo3w2D6LLrXFl2F
         QRgQ+U2P4HB3PCb4kqwXlDR6/GJthlWpFqoWHWX/km53G9VUNEzFaODYBtgQDxsrVuf/
         C3v6x9DgXRBl/7fnGbvcm0yzbMxaRkXe1ywH1IYRf5qmpMXpIefy0RpH7tyDUMIenOy5
         Aiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jxM1ze0TJoMq0tnGJSQJuEhnSrZAlWLgaVv7dZzzKys=;
        b=DNtwvf92VouqBgoM6xJ9a3JlX0XGvXw5FVuX3tmntgdEyC9g98Kkiv8CwaMIWwGjcq
         KCzEva6h9z1YLIHTreqdI03Sw1h7nzNP51XNzNYqR9paUR/qVbDrGWBaQOZb48Sgl/t9
         DvdnvHqF8zmrsMgmTV9A8ssAQDyhJZouH1G4sP7XzK06G8jFtvgW5UxF/4wLPZ1uvH7w
         uSq1aAuIPkhuDg3aVczgAyBbEQEUPaGwnkXvmcNUcpG0dhLGZdqFnXmr+DR7wFc4KT8S
         /Zk8DIbTl3oezJnX440XL7ZH8PPqir/DyHjJ9rkHC+MLsGagena9Fhkmm/k0IxP2TqiX
         hxeA==
X-Gm-Message-State: ACrzQf0jFbIBhy6IJQXJ1Ot94MMrp1dXxZ0eux4vgYEpldvv8QhKh9tT
        /h+jHjZCo008extpcrnDwl25gg==
X-Google-Smtp-Source: AMsMyM4eSnuI2btkGhg4appx7DxwhP3qta0FPzJ6CvmgDuzgKGyRRwZYVtetegfOvXUE9c9yBXmPNQ==
X-Received: by 2002:a05:6512:3f8c:b0:4a1:8d5:d75b with SMTP id x12-20020a0565123f8c00b004a108d5d75bmr8018061lfa.670.1664300352996;
        Tue, 27 Sep 2022 10:39:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:39:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 30/34] dt-bindings: pinctrl: qcom,sdx55: fix indentation in example
Date:   Tue, 27 Sep 2022 19:36:58 +0200
Message-Id: <20220927173702.5200-31-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index 498f2f87217f..afe60b1c6d89 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -142,23 +142,23 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        tlmm: pinctrl@1f00000 {
-                compatible = "qcom,sdx55-pinctrl";
-                reg = <0x0f100000 0x300000>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 108>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
-
-                serial-state {
-                        pins = "gpio8", "gpio9";
-                        function = "blsp_uart3";
-                        drive-strength = <8>;
-                        bias-disable;
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@1f00000 {
+        compatible = "qcom,sdx55-pinctrl";
+        reg = <0x0f100000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 108>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+
+        serial-state {
+            pins = "gpio8", "gpio9";
+            function = "blsp_uart3";
+            drive-strength = <8>;
+            bias-disable;
         };
+    };
 
 ...
-- 
2.34.1

