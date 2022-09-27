Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D25ECB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiI0RkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiI0RjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:39:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027B1E3F58
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:43 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b6so11705643ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9+tXTwnubeAkN3SzieQvhrB6VbDPmkXBs62KmjOv75A=;
        b=CFEunxakkd3tmBC+XsoxcOKyQvxfDlNpQnmi5vkKMgAMsjODZgCL5uceD+g2XqQbjm
         4MealeUeLYI9EHXxbMDPrYH62dTjJzSyoVOndJwJRwkF2Mc2rU7mogr17xEbYfi2ilFb
         GPm00W+Qr2NSn/95FYqengWDjEzv+BiSd7Untp2TzvbHy83ji67xCvuPwONWsWrm1WPh
         kOyUuykmnBotkYU6/XgQIL7h2zof6oxLM7c/t7RAR+/kbygfIJfBakzbTxkmwSrfEKBs
         ljc9iyiht5A9RLaC5+wHhqPu3mkjddLyHeTrFGTS1JGAn8Cyw2AjQgEr4OcS3P5fLQGQ
         wFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9+tXTwnubeAkN3SzieQvhrB6VbDPmkXBs62KmjOv75A=;
        b=EsLfNPOYxp8zlJFD6p6cFLhe7U625iqjbm7OjJWf/pl7Wg8HvqkVxjaRfQcHOENaVc
         sMSSQhqzsD5bUf3VD77a3+GsF+0C521sddxI1IsB3WNwZknMcYdbEM5lYfl6C91h6ym3
         gkKIwsIDiaKwNjfTC2GBz77QNrQ1nU6umyJ6Y0i0I0u6ZL9eZHUERbDR05bfMsh8DF0G
         yJydvVjfxq253zDBYTaBH5en3LzAoE4ziGn+XgGGxo2nvPVjyWM5m+qUeohjBoKOrejJ
         vlobu30OnBL240rJxP4mqUjC0dgYgSom4cOhJ0gL+XYxpBHBiHBZMCCJHEviJiHCpbFf
         wPeQ==
X-Gm-Message-State: ACrzQf26UO+5br+ROpGSLK2bBlz6/tG2fMcxSrtlmunTVl6+68I/evDi
        OHI8Smscxgcj4+fiiOybf31ysA==
X-Google-Smtp-Source: AMsMyM5na8T4oCKS672ibKsOpKYw+CQA3ThZkfAtxzhQv1pRSeFmWJE8RI1z8UMgP160EjCdzCWEmg==
X-Received: by 2002:a05:651c:555:b0:26c:6a30:770 with SMTP id q21-20020a05651c055500b0026c6a300770mr10551692ljp.376.1664300323235;
        Tue, 27 Sep 2022 10:38:43 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:38:41 -0700 (PDT)
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
Subject: [PATCH v3 20/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: fix indentation in example
Date:   Tue, 27 Sep 2022 19:36:48 +0200
Message-Id: <20220927173702.5200-21-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 60 +++++++++----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
index 08e2dd5cbebe..9c647e24fa9a 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
@@ -118,35 +118,35 @@ $defs:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-        pinctrl@1000000 {
-                compatible = "qcom,msm8909-tlmm";
-                reg = <0x1000000 0x300000>;
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 117>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-
-                gpio-wo-subnode-state {
-                        pins = "gpio1";
-                        function = "gpio";
-                };
-
-                uart-w-subnodes-state {
-                        rx-pins {
-                                pins = "gpio4";
-                                function = "blsp_uart1";
-                                bias-pull-up;
-                        };
-
-                        tx-pins {
-                                pins = "gpio5";
-                                function = "blsp_uart1";
-                                bias-disable;
-                        };
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pinctrl@1000000 {
+        compatible = "qcom,msm8909-tlmm";
+        reg = <0x1000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 117>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        gpio-wo-subnode-state {
+            pins = "gpio1";
+            function = "gpio";
         };
+
+        uart-w-subnodes-state {
+            rx-pins {
+                pins = "gpio4";
+                function = "blsp_uart1";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio5";
+                function = "blsp_uart1";
+                bias-disable;
+            };
+        };
+    };
 ...
-- 
2.34.1

