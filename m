Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1D6001C1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJPRDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJPRCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:23 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C5C40BE3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:07 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m6so5436176qkm.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEQGlHOaZDI2yxxfcVBN3AKF8pfUjgYleiCijPBhYQI=;
        b=cVhiuQyQy6HOCLl4n2ipIE8Sb9uH746moTj7IeL31d1LPP7a/cV2k5Wa3sp5FjqtCi
         kwV0iQjsYzttgJ3cmKcz2t0p0xOdUHm3T7o5iAuzdMVwv8Ux1YnXHzVCpJi1I7nWzoSk
         fDKvftiL2kNmFggkpGg4yHBE06eL1MFD+gCu2vLnUJUsBr6T0QH0NuTjflABujf3YNhI
         LYaKe0j8KtJYdyjLCgydlbXk9AmIGKrrU+dcWvgcQpjR3Kwvt0OgKeAnTMhggG5mMtIb
         sFmQAm/vTBRyMl1XnVc44jmdwC+fgx9n6ULAaMS+A+SKARphf62ENDxD2EiwJfUl8GI6
         50gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEQGlHOaZDI2yxxfcVBN3AKF8pfUjgYleiCijPBhYQI=;
        b=B1ok4gT2wQQPF3HP3xj//y+3yLsNWLCq5tRPOlpYHu9D9Ap1BU1guKE2Zs6m94uUUc
         SeSHC/ZWqAfF4xoZ+50xseO4W5mcT2TwIY3EdoZEmyxRC2Zdg5jbf66ymiaArq2Q+zVZ
         7CwMHrdLtSxLH1h1EVxuDh9KDC8H5Ha3Zhi6WcYZLowz0icGPYpvFwU3O6N77Mif6opD
         vVUC5y13xFvIKbh1I7i5FL52t4RAFBo5+aWDCnjIJmmH/RVrbHk3vmL7vK/ekpHbbR5Y
         sDWks1ehUYfkMW3VCWD8fA/q4fAqStIs0I7FzlmP2PQ5nokp2IzoEWONaQT3JUVzuXoh
         RQWQ==
X-Gm-Message-State: ACrzQf0QeyYza3jUXaGqAumHGKyvXfEcUVn77ovWBlpHWj5spFB82AFN
        x5jD3QxBsRBPPgji/8NTzxCJVg==
X-Google-Smtp-Source: AMsMyM4uFTaRFTIR0b/lAz7sGxvxpaslxxi5Zlg8h8ODiEl/e/5bP4VaF0L9W0JTuMgIO6aBIMhP2w==
X-Received: by 2002:a05:620a:c4f:b0:6cf:33cd:2bc9 with SMTP id u15-20020a05620a0c4f00b006cf33cd2bc9mr5169161qki.99.1665939726878;
        Sun, 16 Oct 2022 10:02:06 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:05 -0700 (PDT)
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
Subject: [PATCH v5 17/34] dt-bindings: pinctrl: qcom,msm8226: fix indentation in example
Date:   Sun, 16 Oct 2022 13:00:18 -0400
Message-Id: <20221016170035.35014-18-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/qcom,msm8226-pinctrl.yaml         | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index 1d89bc85c3d9..6d56d2ef1242 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -94,22 +94,22 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        msmgpio: pinctrl@fd510000 {
-                compatible = "qcom,msm8226-pinctrl";
-                reg = <0xfd510000 0x4000>;
-
-                gpio-controller;
-                #gpio-cells = <2>;
-                gpio-ranges = <&msmgpio 0 0 117>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-
-                serial-state {
-                        pins = "gpio8", "gpio9";
-                        function = "blsp_uart3";
-                        drive-strength = <8>;
-                        bias-disable;
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    msmgpio: pinctrl@fd510000 {
+        compatible = "qcom,msm8226-pinctrl";
+        reg = <0xfd510000 0x4000>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&msmgpio 0 0 117>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        serial-state {
+            pins = "gpio8", "gpio9";
+            function = "blsp_uart3";
+            drive-strength = <8>;
+            bias-disable;
         };
+    };
-- 
2.34.1

