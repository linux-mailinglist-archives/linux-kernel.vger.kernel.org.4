Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33585B545F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiILGVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiILGUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:20:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB12BB17
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k10so13154855lfm.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GuYszGqRUvgj4iSIWHANYUWvhVnhTB9OnVeXvHTw1Z8=;
        b=WokROcTL8/yBzzsDBvVCTM0Y0+RbY9AuLJwSynt63bAxNV6SvoUh+UOejSoGS4XaUr
         UqtkazUKgIxgiJ1hLKzRxGAxRSA3XzX5F3OxOxquL7l0FtLl04n11EZ+X0/oNrh0oVf5
         6znwMuihyE5TPIwsRYxILuJ2QRGEGajIlIosD/D40qYx1u8/zt2foQoai3cqtOmDRqgy
         k2ftL43JBKwem6UQW/ZbjR6VHX6rmVRUQq/zu1P/hHxIjwVlEW8sPzRBTw6/mjhpClua
         IfIa19CMGcTnyWZOpl9zf8UA+dWcitf4EMah9tO6Vmkn/dvNMlgAk+7qMKsjo8IycgH9
         3MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GuYszGqRUvgj4iSIWHANYUWvhVnhTB9OnVeXvHTw1Z8=;
        b=QyJYsmmLZUeIxG4ad5PL+1MShZ42YxYeGVVS/uickEsM6sFmKwPSsccFfjtbdKPNWg
         NOIZzU8mKyqxyXz2pJsGLx33J3XxFWn1mFR3tQK9acl7k6H+qegWSzHAK/rchtFrJsFH
         f+Z5YCy4Y2zK8Msxn5rinblQOJBzxwBWoCYZiQq02oNflllKEF5EaFsHpuRfxJwfQ41T
         SBbS+RFCTK9z8ydAzfegyejVQVrR4aYXgIV8+RbXyTjS3G+ZuGhyuvE5Y/ioof1FhhXG
         Xasn4k2qBuNdRjRUDVZtqc9X40ggXM6pxlS6B5CAJnn2FjznZS7Ze6Botz6V/jIAhgiV
         /WUQ==
X-Gm-Message-State: ACgBeo0LjP3hzSV6OyVMWW7KNa0KhAMUrsiHt42JJei0/XQ66NgCma7t
        ZyVuoZqBaGBl4z5qqo88l484Rw==
X-Google-Smtp-Source: AA6agR5oJOWbVa1PdbQ1XCZJ3VJHS6tgg1+MBOSg3drRcILNTZFp/4A7Ah3vRwovv77AcFd92qjd9w==
X-Received: by 2002:a05:6512:3407:b0:49a:4862:965b with SMTP id i7-20020a056512340700b0049a4862965bmr1895628lfr.576.1662963510939;
        Sun, 11 Sep 2022 23:18:30 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:30 -0700 (PDT)
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
Subject: [PATCH v2 27/40] dt-bindings: pinctrl: qcom,sc7280-pinctrl: fix indentation in example
Date:   Mon, 12 Sep 2022 08:17:33 +0200
Message-Id: <20220912061746.6311-28-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 2ad79029d9b0..ad3496784678 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -150,22 +150,22 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        tlmm: pinctrl@f000000 {
-                compatible = "qcom,sc7280-pinctrl";
-                reg = <0xf000000 0x1000000>;
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 175>;
-                wakeup-parent = <&pdc>;
-
-                qup_uart5_default: qup-uart5-pins {
-                        pins = "gpio46", "gpio47";
-                        function = "qup13";
-                        drive-strength = <2>;
-                        bias-disable;
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@f000000 {
+        compatible = "qcom,sc7280-pinctrl";
+        reg = <0xf000000 0x1000000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 175>;
+        wakeup-parent = <&pdc>;
+
+        qup_uart5_default: qup-uart5-pins {
+            pins = "gpio46", "gpio47";
+            function = "qup13";
+            drive-strength = <2>;
+            bias-disable;
         };
+    };
-- 
2.34.1

