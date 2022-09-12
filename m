Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A805B5448
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiILGUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiILGTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:19:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE482AE18
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:35 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l12so9328298ljg.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jLZlsEJ5VG4J2SIrJhH+JChzqh+Qp8BnGJ+3NtUQBWY=;
        b=iy+1E6NNM2NV6qejn/O7aNh2X6cahhiySX7JGDDPWM8fi7pbSxNy1Vy/08sMI9/SwD
         /Pg38MrUhxzzTL3YQFuIdnpJViM2Wb88kJaZAkfCk4rNCn6WsVjsWyMBjCXVNgYPrjhn
         +vglAER66aopmjjkNzalteCtuSiCC6nHQ8U5f5Zy7O8eVuZfTUuxeg0jkDPFWRP8BCXl
         +um5K7Ih0ATyvtrZQTK+fs+Ch18yyL4y0L5HNzCCBvZZm2KeKu13/czNFegoZpZcEYcr
         wNApHRGtZ4m58YV8YUplpkyh+xf5AIsYWtGaUUWoc6arPYnog5qGi5AuHJLveLSWK+lP
         GaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jLZlsEJ5VG4J2SIrJhH+JChzqh+Qp8BnGJ+3NtUQBWY=;
        b=TbnxrpTowZ9yhdNZk+cYygTi1xMuNe2bWntKSdFY+SjSXYf/XdAa+n2Qa5fFArhCLK
         QUii8A7zXBmLis4RfmXidasodDppx+mpZkfXngNf8qaa172q6uCrUcOGBesa3AhIIIwN
         bo2zjxL8CvHEY6oBiCIP4789ggZSdHemqsxdrlX3aDQ33zPrqzFmQpiyZo4A5SnEZsoi
         9qJEJeG8yd9bVO97JpYVb2/X1F98ooug/ipu/7jfE8T5Pc0yYB7rvi7WijupA+bggZDl
         x1icmrhhVc9CxiFxmJ5xc2wE1ZzHVLRerkfQjEXsBYfeMnebf5jrRD4ZwHhkWD/5igjz
         u2Wg==
X-Gm-Message-State: ACgBeo1CCQZ2IHJTZnIRXlffDSBm4Sh43F3grPs/d1s96E8r9Y+l6/7y
        Uv4aGV0KbYfc932QlKQnCbYZuA==
X-Google-Smtp-Source: AA6agR6SCFQ8A3mDkdUAbA6vJv5w7JkeX3CkwNy4Ko3l8MlMVLJ2U4z8kPRzN1YdMQHNTkqVbseQxQ==
X-Received: by 2002:a2e:9b0e:0:b0:26b:e2dc:c0e4 with SMTP id u14-20020a2e9b0e000000b0026be2dcc0e4mr4610047lji.459.1662963499851;
        Sun, 11 Sep 2022 23:18:19 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 20/40] dt-bindings: pinctrl: qcom,sm8450-pinctrl: fix indentation in example
Date:   Mon, 12 Sep 2022 08:17:26 +0200
Message-Id: <20220912061746.6311-21-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
index d1d1c1455b3c..87347e9c5f1c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
@@ -111,34 +111,34 @@ $defs:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        pinctrl@f100000 {
-                compatible = "qcom,sm8450-tlmm";
-                reg = <0x0f100000 0x300000>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 211>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-
-                gpio-wo-subnode-state {
-                        pins = "gpio1";
-                        function = "gpio";
-                };
-
-                uart-w-subnodes-state {
-                    rx-pins {
-                            pins = "gpio26";
-                            function = "qup7";
-                            bias-pull-up;
-                    };
-
-                    tx-pins {
-                            pins = "gpio27";
-                            function = "qup7";
-                            bias-disable;
-                    };
-               };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pinctrl@f100000 {
+        compatible = "qcom,sm8450-tlmm";
+        reg = <0x0f100000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 211>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        gpio-wo-state {
+            pins = "gpio1";
+            function = "gpio";
         };
+
+        uart-w-state {
+            rx-pins {
+                pins = "gpio26";
+                function = "qup7";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio27";
+                function = "qup7";
+                bias-disable;
+            };
+        };
+    };
 ...
-- 
2.34.1

