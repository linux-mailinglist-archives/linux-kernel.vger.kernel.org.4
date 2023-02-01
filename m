Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE3686A62
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjBAPbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjBAPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:30:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812F728FB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:30:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg26so7119757wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTCQQQp9TwvWEkEmZNUkDX50epuJR3X4sS8N8mIieaw=;
        b=Bm9NAsiCudfLJ/6CdP0tFaQmonDdijhbPyzibAfaAl3T2d7Jj7zQsIvx5ltcJ6EjIk
         Hdvsh+Qk5cNfF6WunqZz8nPyref6ljGUtZVyMVU0Tuy7GENKb15sNTpo3FZ9sQAEFlpm
         yYE1nLJaC19+tt0VxYJ0ZTYZCJxvaRClJKhtRpDctXeqL7G+dsMh2hQ6lKrgrTGDZ4Ed
         zJwWdP/7nUcoXLpcLS3ymjm1ABHAa/1InBBdOTAnNXWripHLPzrCQejx4Pto5oqbKAn0
         yEa2utax+zyHlvo47cSXD3X2VPgHiPljSTuVDDYFIpxTY62NGpAbuACyb++ZEZYkszd/
         HbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTCQQQp9TwvWEkEmZNUkDX50epuJR3X4sS8N8mIieaw=;
        b=iEcc+dfYSXaQOGY3fLH7EHuUoujgTCmRFwU1EgPJNRwISC+Xd/0PmzndSsoTT1Jv2f
         6CFLtCtWrt4gDjW/PQDUI+XFaR65p1x1YlUS2aHPK+d7miLwWiyXJkGcgFXSWGxAyApH
         +qNeNbouleXLTWtL5ESImVYGa9SDvugeplVmHC78KooLNsMuptf+ZcHW/qacqCDbHb2E
         m6gnhokyX+FP2uda4YMwjKTsMasUcWya8fZoBgiZ7udLNPZA/BAxfaPV1weC9xWjO650
         YVpaH0LmppXxVVYpj4TIiR9xkOdMv+gUMvH6VmVElZ5twyj0U4MRre0cR0BpXCGtBl4b
         9cnw==
X-Gm-Message-State: AO0yUKVREQGmn3GgY5FcT7i7nYGrD3/ng1z08w98KBrMFwMm0x/+IljB
        j/GWEXqXc8FnryjXYSifbasSiQ==
X-Google-Smtp-Source: AK7set8dXAZkzmcB4bGaw0aGWlqD6c7f1rHrnFCUIrJR0h4d7ovQJB0AekylezAJcM6W1ItfhI7b0w==
X-Received: by 2002:a1c:4b15:0:b0:3dd:1b6f:4f30 with SMTP id y21-20020a1c4b15000000b003dd1b6f4f30mr2778255wma.3.1675265444964;
        Wed, 01 Feb 2023 07:30:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c544b000000b003dc4fd6e624sm2168032wmi.19.2023.02.01.07.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:30:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/7] dt-bindings: pinctrl: qcom: correct gpio-ranges in examples
Date:   Wed,  1 Feb 2023 16:30:19 +0100
Message-Id: <20230201153019.269718-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
References: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
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

Correct the number of GPIOs in gpio-ranges to match reality.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml         | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml        | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml  | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml        | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
index f33792a1af6c..77a5aaefddbe 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
@@ -138,7 +138,7 @@ examples:
         #gpio-cells = <2>;
         interrupt-controller;
         #interrupt-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 120>;
+        gpio-ranges = <&tlmm 0 0 119>;
         wakeup-parent = <&pdc>;
 
         dp_hot_plug_det: dp-hot-plug-det-state {
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
index 97b27d6835e9..854bbb5b6f5d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
@@ -128,7 +128,7 @@ examples:
         #gpio-cells = <2>;
         interrupt-controller;
         #interrupt-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 230>;
+        gpio-ranges = <&tlmm 0 0 228>;
 
         gpio-wo-subnode-state {
             pins = "gpio1";
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
index f586b3aa138e..03c7b5c97599 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
@@ -119,7 +119,7 @@ examples:
         #gpio-cells = <2>;
         interrupt-controller;
         #interrupt-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 151>;
+        gpio-ranges = <&tlmm 0 0 150>;
 
         qup-i2c9-state {
             pins = "gpio6", "gpio7";
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
index 23d7c030fec0..a08e4557d8b7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
@@ -134,7 +134,7 @@ examples:
         #gpio-cells = <2>;
         interrupt-controller;
         #interrupt-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 151>;
+        gpio-ranges = <&tlmm 0 0 150>;
         wakeup-parent = <&pdc_intc>;
 
         ap-suspend-l-hog {
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
index 89c5562583d1..96375f58fa22 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
@@ -140,7 +140,7 @@ examples:
         reg = <0x03000000 0xdc2000>;
         gpio-controller;
         #gpio-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 109>;
+        gpio-ranges = <&tlmm 0 0 108>;
         interrupt-controller;
         #interrupt-cells = <2>;
         interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
index 29325483cd2b..d35db4f4581b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
@@ -121,7 +121,7 @@ examples:
         #gpio-cells = <2>;
         interrupt-controller;
         #interrupt-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 114>;
+        gpio-ranges = <&tlmm 0 0 113>;
 
         sdc2_on_state: sdc2-on-state {
             clk-pins {
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
index c9bc4893e8e8..83848950cc3b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
@@ -125,7 +125,7 @@ examples:
         reg-names = "west", "south", "east";
         interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
         gpio-controller;
-        gpio-ranges = <&tlmm 0 0 134>;
+        gpio-ranges = <&tlmm 0 0 133>;
         #gpio-cells = <2>;
         interrupt-controller;
         #interrupt-cells = <2>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
index d95935fcc8b5..3fe1f1668fbc 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
@@ -142,7 +142,7 @@ examples:
         #gpio-cells = <2>;
         interrupt-controller;
         #interrupt-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 157>;
+        gpio-ranges = <&tlmm 0 0 156>;
 
         gpio-wo-subnode-state {
             pins = "gpio1";
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
index 4376a9bd4d70..4c9ad9079e69 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
@@ -136,7 +136,7 @@ examples:
               <0x03d00000 0x300000>;
         reg-names = "west", "east", "north", "south";
         interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-        gpio-ranges = <&tlmm 0 0 176>;
+        gpio-ranges = <&tlmm 0 0 175>;
         gpio-controller;
         #gpio-cells = <2>;
         interrupt-controller;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
index 56c8046f1be0..c4cec40cbb92 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
@@ -124,7 +124,7 @@ examples:
         reg = <0x0f100000 0x300000>;
         gpio-controller;
         #gpio-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 211>;
+        gpio-ranges = <&tlmm 0 0 210>;
         interrupt-controller;
         #interrupt-cells = <2>;
         interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
index a457425ba112..6ecc1ad6ccd4 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
@@ -136,7 +136,7 @@ examples:
         reg = <0x0f100000 0x300000>;
         gpio-controller;
         #gpio-cells = <2>;
-        gpio-ranges = <&tlmm 0 0 211>;
+        gpio-ranges = <&tlmm 0 0 210>;
         interrupt-controller;
         #interrupt-cells = <2>;
         interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

