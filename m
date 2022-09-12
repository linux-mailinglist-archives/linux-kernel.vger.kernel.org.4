Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4235B542D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiILGUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiILGTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:19:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB129811
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f11so13137467lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qxAFFeV9Jghea1krVGY5BQK+UR1GkKeREC8WB6H5B2c=;
        b=gTdROqGrrSl+2/wJzwvxlczeW+rqBSo9O5tBZh5AMCfufYpHRu1eptMa2gvOexkH8G
         HUqG4NBpOoNAEYe+GXhJp035hZEjfPiFHZBKJlHDvqoAuxTtk5M+4K1JUUtQjoGlmaTb
         VHUfRvTnlzyw/n+Mmev6p/pPh0VGS5XDn9xDY1nDzk0gRpZebTGG9Q1Fpm3Z/cbsXNZV
         YQ8GEMs+OE5ccWatvCHnJefz6e06Gia1ZHzhzQQUsJtVsgF0aKjPKRpoxhnRlZU3bho9
         V8hvIHpY1Bi8MItUeuzWhbfFdd5R6LFF4C5fX0Nb0ytbWreOhkrnovbBchnwFGwkhGUF
         QWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qxAFFeV9Jghea1krVGY5BQK+UR1GkKeREC8WB6H5B2c=;
        b=wNlVxzLQSanV8vPrqkBv6Hz/V3TM1nGYID4F79Aav7P+1jje1S5AihcX2Qll10GQFc
         H8lN7ovvdc2H+k9HWKwuoSuO8qZtAkcFWX0cFjTtpuI1uV98UnlXAttOzb1bSCR1ZmFk
         xhzUKmrRoMzgeGbvlcYRJLFyP3S/v5X5/ZVbpcPdsR2iomGqFeii4ZmwmxXP8q1pXDyT
         WrLNWCBoWed//07LzpvTYTsDIFbeafkwmTlnBjtHprHVyYhqDoaQIRVH3WUTALgc8PzP
         fIz/TSgsf4w3s8cRybcfdrRFxLml4bfy3R7/jpuQidX4+eR6Ki+h4PRUbQHhkFTN1g3o
         n9nw==
X-Gm-Message-State: ACgBeo3BHajoxcLghorFi3EhKK+udyCD4sq7zzNbnbHItwL/2VPuXBg1
        DHKqFVeGnw8SnjYDkkZK+pl4vA==
X-Google-Smtp-Source: AA6agR4yo2Oq6q/w+fQcJQJ371CJ+xnE/8UWXETJpk5WRuihsK1HiT2e9lawhz8pPDGJ/Xi8mdW6LA==
X-Received: by 2002:a05:6512:6cc:b0:48d:acaa:8a66 with SMTP id u12-20020a05651206cc00b0048dacaa8a66mr9041345lff.272.1662963492830;
        Sun, 11 Sep 2022 23:18:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:12 -0700 (PDT)
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
Subject: [PATCH v2 15/40] dt-bindings: pinctrl: qcom,sm8250-pinctrl: fix indentation in example
Date:   Mon, 12 Sep 2022 08:17:21 +0200
Message-Id: <20220912061746.6311-16-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index bccc83f22aae..c44d02d28bc9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -141,18 +141,18 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        pinctrl@1f00000 {
-                compatible = "qcom,sm8250-pinctrl";
-                reg = <0x0f100000 0x300000>,
-                      <0x0f500000 0x300000>,
-                      <0x0f900000 0x300000>;
-                reg-names = "west", "south", "north";
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 180>;
-                wakeup-parent = <&pdc>;
-        };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pinctrl@1f00000 {
+            compatible = "qcom,sm8250-pinctrl";
+            reg = <0x0f100000 0x300000>,
+                  <0x0f500000 0x300000>,
+                  <0x0f900000 0x300000>;
+            reg-names = "west", "south", "north";
+            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            gpio-ranges = <&tlmm 0 0 180>;
+            wakeup-parent = <&pdc>;
+    };
-- 
2.34.1

