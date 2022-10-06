Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3545C5F66BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiJFMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiJFMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:48:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE537A4848
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:43 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id t16so2112264ljh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1KqImZmGxWpbG6r7f++yaRkl8o1vQR5tbeGhirJSHY0=;
        b=A+y96/rNfR7Q8UORkLvNDxiZhyaIR5KCXbbtAKFZebu8urFwpHFewSCdXTmUE7IVpG
         kjUxlYmzEn2aJXIwbqUirrUCZd6bLGdQvvfhFrJVRPfyBHeWPwMu1wpPd1DPDcdg8PZf
         iDNUe7U4hnLGpNJg5gABvGPnY4oSvgiFb0Lq0swzcNh+b199TsHbez/d/fNAuy0BhBsy
         Jxo4c7tquHWCHjNwiXMsReK9K1Salcy+tE6PfLPbHmWMl42V+LtMK8/a1Gd+Aya1Smb0
         YJy8ZV0dgBt3DQCPb6eCURylCiEK5Tb7Y5vxhL9PNLzO36R19eNAJEApSe+Pa03e4kyj
         dViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1KqImZmGxWpbG6r7f++yaRkl8o1vQR5tbeGhirJSHY0=;
        b=n9514uUxgQHl9RYKV07ZnHdf170u/SE9Qtu2yV6nGrI4sq2cL6TdSGM7zs9tvUHk4k
         AItmA7HZonQw8ZVuaLRF+oy2gVkrQjuDZWNg0rNf4h2zFYq5cczrcdkHqFXR9otRFRl1
         XETztsFri970eIxjWR3aP75tB6yMxAlIMUtDkaBIzxuJdmVT3/cTtAzmMD81nmmg+9xv
         qVWlgUMVJjVH4wmGVcV6rVK2tLEFN3t+G+/og7AuSIKhJ5rOt0uQdFa2UNA+JCegWszE
         7nZVlQ/bAG564G1nyiiyQuPfmxbNhwdpK72ME2Rgk6z7pgVCld/J5tYzfuMLtKVcLrsj
         tx2Q==
X-Gm-Message-State: ACrzQf0EsxHjvkyaO1xnYjHBOdK89yLt+tBJxUK8XRR/qFGtVJglqAKD
        yxNvxw8uxsiJZalfa94by46iDQ==
X-Google-Smtp-Source: AMsMyM4LP2ChmWlfvVKeVtuExPTDn5JRLywEwlhciR0bPCuVXbGZgVMY4WngNqmM5smRLSZyt4kAjg==
X-Received: by 2002:a2e:8049:0:b0:26d:cd1d:1640 with SMTP id p9-20020a2e8049000000b0026dcd1d1640mr1744096ljg.279.1665060444724;
        Thu, 06 Oct 2022 05:47:24 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:24 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 20/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: fix indentation in example
Date:   Thu,  6 Oct 2022 14:46:45 +0200
Message-Id: <20221006124659.217540-21-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Rob Herring <robh@kernel.org>
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

