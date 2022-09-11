Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979D5B4E22
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiIKLPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiIKLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:14:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853BF3D59A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bt10so10405950lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=691KvJvip9wejzXr7qpWGsmceASveD6n9KP/WuDonD8=;
        b=aLxzrcdLFl7uHztPJyUgymD5UhbCoTd0RuTnr82HkYmtqvQC6quDqk7QuKKlfCvpE2
         ZWt5m1TnHf869tugxUfGIeJ3AZikUniA4tBcEcf3gHjVrGqvDUyDkzfcquv8sgn2Pw2u
         ioUOqm62ozdo5LkDtD5Kn6C4LPyQh0oOyrJ89x5YHwaYHnoqqL51RK3tTpIBS4S9Ra4b
         QkP6BXmSXUVaVagMf+PDk5T+rrAkpV6302BOcpNewVZAZ2Ce0LaBjE9ekkDTQk9BL7y7
         MFUIF1u062dVDxX3xPxebENZn3Xwj8FLvkmiSPWIjJxRf61MDlBpxkxdj9Lf/iLLuO/w
         4krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=691KvJvip9wejzXr7qpWGsmceASveD6n9KP/WuDonD8=;
        b=yXEhdkHZuuBcO3M0uy14gstwTuSYjIzY6PIDuVoGEWcZMDRXcyNwCvHsX4gMvQXSwP
         TPG27SP/0nJubv3D3h34KEJG2zzvr6eGTyzxqg0d76GbS8xGHpQi8z1eNnNQyKW70GL8
         MHziulz0V2HOcpwEH3O5tlVfU4n1A1spox8avqCtqkIxxFiVHeBcivKYtXIUoTWd/tef
         IgG57VLeIht3i+9MQzXj19NdBJ7xQAK7VnVBt3KnkWTXL78vhCQ4U+uqeP3BD9gfpzZU
         1k+LP3I46iVvmFHEdAZy4Va2yLSNGK8aORI3dtjylMuCXf9VLt9/pbgcoxXbWoMq+Nzx
         M+EA==
X-Gm-Message-State: ACgBeo0C2zN7tpXcka7eQD9f+xlelwVCM+R5zccXnIyEgSYD9HxZcRd1
        TlZf4l9NwOlHgBGHVWZy1l2a6w==
X-Google-Smtp-Source: AA6agR6qAHPE5W4Bko0Tyb5fzR49diqQfAoaniDLvQD3dg29AqngAImjgUcacpSEDX2hqyFe4h2u5w==
X-Received: by 2002:a05:6512:1188:b0:499:6fbf:d751 with SMTP id g8-20020a056512118800b004996fbfd751mr2716870lfr.51.1662894766675;
        Sun, 11 Sep 2022 04:12:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:46 -0700 (PDT)
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
Subject: [PATCH 33/40] dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: fix indentation in example
Date:   Sun, 11 Sep 2022 13:11:53 +0200
Message-Id: <20220911111200.199182-34-krzysztof.kozlowski@linaro.org>
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
 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
index 8610f2701388..b9ab130cd558 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
@@ -127,34 +127,34 @@ patternProperties:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        pinctrl@f100000 {
-                compatible = "qcom,sc8280xp-tlmm";
-                reg = <0x0f100000 0x300000>;
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 230>;
-
-                gpio-wo-subnode-state {
-                        pins = "gpio1";
-                        function = "gpio";
-                };
-
-                uart-w-subnodes-state {
-                        rx-pins {
-                                pins = "gpio4";
-                                function = "qup14";
-                                bias-pull-up;
-                        };
-
-                        tx-pins {
-                                pins = "gpio5";
-                                function = "qup14";
-                                bias-disable;
-                        };
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pinctrl@f100000 {
+        compatible = "qcom,sc8280xp-tlmm";
+        reg = <0x0f100000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 230>;
+
+        gpio-wo-subnode-state {
+                pins = "gpio1";
+                function = "gpio";
         };
+
+        uart-w-subnodes-state {
+            rx-pins {
+                pins = "gpio4";
+                function = "qup14";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio5";
+                function = "qup14";
+                bias-disable;
+            };
+        };
+    };
 ...
-- 
2.34.1

