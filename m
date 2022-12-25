Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCF0655D1F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiLYMBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiLYMAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 07:00:41 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A16B646C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y25so12871283lfa.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJm2wioESvThzzMOuzKJ3QtCPr7g0JfFvuAg6gEUcPI=;
        b=LiRgMi1qkQ2+Ds7g9/JAYO4WUSM4FJmGIlvOD7cjtAb5RdlPgbnz502iHgVI+Q093a
         lyGWP0Jss+EmDo1QcTzafJXnnlJaoGsD/5kQ+wfELfx7hs+kixmS6ANmTMVqNSCzDAJ1
         u6MlwmI8y4H2UD3/FOBS5gxJ92miBatL/e2PkVVyjUlHt8JivFAx/55o9rBhNCrrRL4W
         2AQo+nlvvnNBfmESBQRfL6czWQ8lfe2GOqW5jTMTj7HO5T4puwssyH8HriVa0+An3g2Q
         uMC2ma/b4clP8Y0jOmLqWP7oXEuY28OgzvQvO44KifylJdOIua2nUutHqDQiMNhgBdJX
         fxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJm2wioESvThzzMOuzKJ3QtCPr7g0JfFvuAg6gEUcPI=;
        b=0CyYFis5li0UCBsPaUbhVdelz5Pu8aBoFotOSbAPejruIqSlUbwfu8t7qlsrwtfnCL
         wMNDcCmnDu0ksvAsISdQebgKyTNr+qFYsfxfYp21mYsVoR/zEwk1eJBHtixnEV6ZweS+
         iTHBM3CADBKwDH8Rymbrm0vysCZk83+cik2oiAC7ffyPtgL/ZdxKQQGYSEY8nspdBlNx
         uoBgIgN3DY0FNJLjgavnNPX41uIJXvR4xAvcmgwVq66/3J4mv6iGGPiLuh3jNnvIB1vJ
         JljjJbkmb57ZVe2vrpxgwA9YMqkE+J+kR98M+XOPZ1rFOEIN7el+mtxwgrTbeujUB1u/
         IJHQ==
X-Gm-Message-State: AFqh2kp1mwyoLD44J657N9ADCVW9xaLX3SwSpYjjw/0QZd8QemLM30hQ
        Zy6lRBltf8qlBhkKX4MgQt+Y0g==
X-Google-Smtp-Source: AMrXdXtZbcr1lewm33QSNJ02le4poAH1iJiWRMNcmbXeb/Tk88AaBN5cBHC8rGSoz6Usb0/FzIq/tA==
X-Received: by 2002:a05:6512:32cc:b0:4ca:d81c:f172 with SMTP id f12-20020a05651232cc00b004cad81cf172mr4589490lfg.43.1671969587983;
        Sun, 25 Dec 2022 03:59:47 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v10-20020ac258ea000000b004b501497b6fsm1338615lfo.148.2022.12.25.03.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:59:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: phy: qcom,sc7180-qmp-usb3-dp-phy: correct clocks per variants
Date:   Sun, 25 Dec 2022 12:59:44 +0100
Message-Id: <20221225115944.55425-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225115944.55425-1-krzysztof.kozlowski@linaro.org>
References: <20221225115944.55425-1-krzysztof.kozlowski@linaro.org>
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

Different variants of Qualcomm USB3 DP PHY take different clocks
(according to upstream DTS and Linux driver):

  sc7280-herobrine-crd.dtb: phy-wrapper@88e9000: clocks: [[43, 151], [39, 0], [43, 153]] is too short
  sc7280-herobrine-crd.dtb: phy-wrapper@88e9000: clock-names:1: 'cfg_ahb' was expected
  ...
  sm8250-hdk.dtb: phy@88e9000: clocks: [[46, 185], [44, 0], [46, 187]] is too short
  sm8250-hdk.dtb: phy@88e9000: clock-names:1: 'cfg_ahb' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml      | 72 ++++++++++++++++---
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
index 97d94c685d7b..2e19a434c669 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
@@ -51,18 +51,12 @@ properties:
   ranges: true
 
   clocks:
-    items:
-      - description: Phy aux clock.
-      - description: Phy config clock.
-      - description: 19.2 MHz ref clk.
-      - description: Phy common block aux clock.
+    minItems: 3
+    maxItems: 4
 
   clock-names:
-    items:
-      - const: aux
-      - const: cfg_ahb
-      - const: ref
-      - const: com_aux
+    minItems: 3
+    maxItems: 4
 
   power-domains:
     maxItems: 1
@@ -171,6 +165,64 @@ required:
   - vdda-phy-supply
   - vdda-pll-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7180-qmp-usb3-dp-phy
+            - qcom,sdm845-qmp-usb3-dp-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Phy aux clock
+            - description: Phy config clock
+            - description: 19.2 MHz ref clk
+            - description: Phy common block aux clock
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: ref
+            - const: com_aux
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc8180x-qmp-usb3-dp-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Phy aux clock
+            - description: 19.2 MHz ref clk
+            - description: Phy common block aux clock
+        clock-names:
+          items:
+            - const: aux
+            - const: ref
+            - const: com_aux
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8250-qmp-usb3-dp-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Phy aux clock
+            - description: Board XO source
+            - description: Phy common block aux clock
+        clock-names:
+          items:
+            - const: aux
+            - const: ref_clk_src
+            - const: com_aux
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

