Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B575B4E10
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiIKLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiIKLN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:13:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D6E3CBDA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z20so7409070ljq.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nXdmZRWySMH2y4BHslWMyDvfmlDcWpCDzcQgKmezSiA=;
        b=UlAZv0nKRhX0fZ+HjxVuvwBdtMlpVeVd2Yi/2YXQvSZsjL0fTglhvwEeKCmDs1I0Fd
         91bvvkZcyAnrEyTlUF9qT4WdyFP+uuIPiZa+xh8YuzoBfU+ZTSWH97ZwmP4ORq/dSB8x
         Gl90lDAZXu92HgwgaROu/29xE70zaxvUDL6ooCPb9EL+m+xZ5hxuZDAktxEI0XoHiUCT
         JBo0TJE718Y5oZlXEP4RykdUoy6W/XFNxGlsR6R8ZsB/yzmPV81EmytddUar1Q4u3zjx
         NOnt1dGvqjLTQ1eRwSxhnZJkmRqJ4WyqvSmeNYIonsGypHPElXvNV57u1PT13f7Tx/O0
         YAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nXdmZRWySMH2y4BHslWMyDvfmlDcWpCDzcQgKmezSiA=;
        b=FckZJBGzDgpTIJqMtQFYFuSf0VYmPse11LH49/UpdIkUhgKWsJtlhQbexxvJ3Ijk3i
         a77Zi1WHnaYuaygmaQ1fXR2vTGoKrh6UfGTZ5arRcUjPOPL92wUbQ67uPJKJXGZI9Loc
         Qg4ubtbkQf5GhDIZW8onPFWonQOzbX/uLXzyDmDRsJLUfBnSwrGwB5OWzC5c2z5SgXNI
         9n34gsYv59OhZmIg3kqdc2b39GAYxF94QFdZ0fvcHYZGAWpZh4RaaysuI/3NKrY+Ct2l
         Yczg7z1Kngz1hGUBj2DeiJ5fjpGj7LgPLzrSmKkzvwnpMLR4V+I3mnlxSPJ3lMPcjjb3
         HXaQ==
X-Gm-Message-State: ACgBeo2uFwnQr8z1+lVqhadfDby3kagWBZppqqA7sormpqQilu8za9KP
        Klb141uY0GMrhWRoDrTmfWaYvw==
X-Google-Smtp-Source: AA6agR5I/tGMgMOjbRLS0g2D7/H7nug+yH6MMWQA8TT4KGFTnqcJFWtdQduFm8lM0QIvCSSDsAXAdw==
X-Received: by 2002:a2e:bc11:0:b0:26c:565:12f6 with SMTP id b17-20020a2ebc11000000b0026c056512f6mr300214ljf.91.1662894763042;
        Sun, 11 Sep 2022 04:12:43 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 30/40] dt-bindings: pinctrl: qcom,sc8180x-pinctrl: fix indentation in example
Date:   Sun, 11 Sep 2022 13:11:50 +0200
Message-Id: <20220911111200.199182-31-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
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
 .../pinctrl/qcom,sc8180x-pinctrl.yaml         | 64 +++++++++----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
index 4afe20bac87c..b98eeba2c530 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
@@ -126,37 +126,37 @@ patternProperties:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        pinctrl@3100000 {
-                compatible = "qcom,sc8180x-tlmm";
-                reg = <0x03100000 0x300000>,
-                      <0x03500000 0x700000>,
-                      <0x03d00000 0x300000>;
-                reg-names = "west", "east", "south";
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 190>;
-
-                gpio-wo-subnode-state {
-                        pins = "gpio1";
-                        function = "gpio";
-                };
-
-                uart-w-subnodes-state {
-                        rx-pins {
-                                pins = "gpio4";
-                                function = "qup6";
-                                bias-pull-up;
-                        };
-
-                        tx-pins {
-                                pins = "gpio5";
-                                function = "qup6";
-                                bias-disable;
-                        };
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pinctrl@3100000 {
+        compatible = "qcom,sc8180x-tlmm";
+        reg = <0x03100000 0x300000>,
+              <0x03500000 0x700000>,
+              <0x03d00000 0x300000>;
+        reg-names = "west", "east", "south";
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 190>;
+
+        gpio-wo-subnode-state {
+            pins = "gpio1";
+            function = "gpio";
         };
+
+        uart-w-subnodes-state {
+            rx-pins {
+                pins = "gpio4";
+                function = "qup6";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio5";
+                function = "qup6";
+                bias-disable;
+            };
+        };
+    };
 ...
-- 
2.34.1

