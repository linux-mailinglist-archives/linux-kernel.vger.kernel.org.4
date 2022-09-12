Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BCB5B5413
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiILGTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiILGS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:18:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068782A947
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so13182557lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZQ3YhRzsCIvzwIGS4j9FwdZrsy4eOBBU0P2zsVYlRwE=;
        b=YFavRgvL8Jvgg5KSU7zov2VEdf7/zxH1U32/swYPYp5f2qVJbinY5B6l54ABAseTH3
         1Fjg9xNatNquSqn5PMqNzm9jp5Qj2LA5RsQuDb9Y10qcTLHaSQJBvXuVrUV8qeDit1AC
         WBsBwTWptg5bhihq+/lF6h7AYnRRqctNJmof7jLiIMkGbpI21HBCRM6uathMx9S9Qz9/
         bgOJ5mNE7KOkBXEyv4jHTodPdYY9tZBZqhxNLlA8kogprxZ0ISEIgzHvu/kgaw5OP5Yq
         K0BS/X/+yHI+dntmO2WvxDLI3XbYyyDDzu0zTAssVURmNjKweg6HpDE8GDIitcM8chKo
         UXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZQ3YhRzsCIvzwIGS4j9FwdZrsy4eOBBU0P2zsVYlRwE=;
        b=IJb43CXKBaJe8SukSQVeiX2WipgnuGwR1bz0gFW2ynFCBPSUXkE+MzhJ+/wcoXrJ0I
         3DDdAR090Aq9qQ0bp2q8uBJMX1BBM5+DTG8d3kCGo8PFVNpfvxgWwwccNljrT7BuElF5
         iVpB7BN024P0kr7hn+TguyHrkdrUsThLPyGVhWQu7+6tmekT+l8dgVaPYfr1zuE7hPBR
         1YBa4VzYDzjP7F6wfckPEj0u/YMm0mtWaf7PHe3wadHdsFs6nQmkg6k8AlYqlfJcloPj
         iDYa7tkKnpJD86SUPBDYEnQrvAGw6x1sW88RwEimQIVuWxvy8h5F13Lg8iVgFpjATyA7
         SgTw==
X-Gm-Message-State: ACgBeo0DNL+z/MKgWCVp+BcUVK1NxMwiAEuSXCm0UoJp/9v8XNLy+Nhe
        KdSxDJbLTD29cWBOM5Ee4NnAew==
X-Google-Smtp-Source: AA6agR7kBHj+9dOwtJjEUEh1uLmt4hg7BQQArafWb63SmcnqlHqYdmLuiBg9Z7u/AqTNVBUt0yMFuA==
X-Received: by 2002:ac2:4bc1:0:b0:48b:2ab9:8745 with SMTP id o1-20020ac24bc1000000b0048b2ab98745mr8996563lfq.75.1662963495403;
        Sun, 11 Sep 2022 23:18:15 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:15 -0700 (PDT)
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
Subject: [PATCH v2 17/40] dt-bindings: pinctrl: qcom,sm8350-pinctrl: fix indentation in example
Date:   Mon, 12 Sep 2022 08:17:23 +0200
Message-Id: <20220912061746.6311-18-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
index 211cca11f94f..f3106d25adcf 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
@@ -114,34 +114,34 @@ $defs:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        pinctrl@f100000 {
-                compatible = "qcom,sm8350-tlmm";
-                reg = <0x0f100000 0x300000>;
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 203>;
-
-                gpio-wo-subnode-state {
-                        pins = "gpio1";
-                        function = "gpio";
-                };
-
-                uart-w-subnodes-state {
-                        rx-pins {
-                                pins = "gpio18";
-                                function = "qup3";
-                                bias-pull-up;
-                        };
-
-                        tx-pins {
-                                pins = "gpio19";
-                                function = "qup3";
-                                bias-disable;
-                        };
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pinctrl@f100000 {
+        compatible = "qcom,sm8350-tlmm";
+        reg = <0x0f100000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 203>;
+
+        gpio-wo-subnode-state {
+            pins = "gpio1";
+            function = "gpio";
         };
+
+        uart-w-subnodes-state {
+            rx-pins {
+                pins = "gpio18";
+                function = "qup3";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio19";
+                function = "qup3";
+                bias-disable;
+            };
+        };
+    };
 ...
-- 
2.34.1

