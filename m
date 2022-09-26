Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED455E9B33
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiIZHtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiIZHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:48:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BAD39103
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so9455164lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vDgJO50k3XmGqltKXWLNMwhH7fSgxWnFKEXL4lxXp+o=;
        b=RTAkI98CFND0ynmiNKmhmKuco8yO84JAAMt9Mzgp+iuk11CGxA4FA+eSXlYmJR1TeV
         pW5fZMJlEl/GBJPygPwkJfp8JfritGltx8cpcKDGKO3nu8zHdAPSi929cUxZU4rgFbtX
         id0C3BLMsoPJdTgNeSN4ScdlWdOwmTKHBJBE4RM+teBy7KVD+7LQ31FoLuipynRm7Bh/
         Jb3kvYAW3Pu7q28Wa32MOWnjabLbpFtv/I+IS77O8mtW9nZJEQOHFocExDe/YS5hV8x5
         SxYVGnwYz5LkUjO+HPxXHkH9qFQIgfUarOQ2xw6h7xCoTn/cklVcGUtx9S4lN+6AW0M/
         rOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vDgJO50k3XmGqltKXWLNMwhH7fSgxWnFKEXL4lxXp+o=;
        b=y6hqLQ0KC3WE6P2tOIzcZHGjOR8s6f+r4ajsfQZZHQhfkZZM4ioZnLs3go94W7qCD0
         GetIz9aEzU+fCm+LCh7zfiZ2PofKv4mnAwl4dXxAs3hE1p/m77TLIz2iavqh6C/Y5bAo
         LOUYTBCQ3AOn9m8ZDrtw/fN6Ra8vYZSbwK6OAjMWUUUSXu2gtPSujsXoVF9ym4buGwMT
         kWtTdFVhfGdkUSU8E/U7W4sl+ULvflHpIbNK7jEy0OGafLltj1TAsimSOyIJ556Q8fwV
         jJrGBX1TBsh1J/buRMxSlITkkuvHfkMK3T7V64e+QB5XA2sDxz/I71tF8reYVglmiE3q
         MNXg==
X-Gm-Message-State: ACrzQf3cY9cN2DOhxAiilT9sZx+idFhJDRhcrOwUFHKtHe4SfrnSwFqj
        /T5PGsXk8sprUU4IyMSFBdUbzg==
X-Google-Smtp-Source: AMsMyM5OuySD/A/fPVqJnE48IEa4ArMlpXX56AIfatdnVRrLn4mON0XcF4dYu+EYk+9MY0WJ6/3O1g==
X-Received: by 2002:a05:6512:13a4:b0:477:a28a:2280 with SMTP id p36-20020a05651213a400b00477a28a2280mr7826318lfa.689.1664178321378;
        Mon, 26 Sep 2022 00:45:21 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:20 -0700 (PDT)
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
Subject: [PATCH v2 29/33] dt-bindings: pinctrl: qcom,sdx55: fix indentation in example
Date:   Mon, 26 Sep 2022 09:44:11 +0200
Message-Id: <20220926074415.53100-30-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings example should be indented with 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index 52b7a557f452..b861feab73dd 100644
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

