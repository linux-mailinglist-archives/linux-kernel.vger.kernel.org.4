Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6CA6FEFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbjEKK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbjEKK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:26:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87810C0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:26:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso12739058a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683800763; x=1686392763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ah9vrmwXkmgBXYxu0weg0/evB6b5zH+I5OTrqcCotE4=;
        b=rXxX/EZCr13k7OrOt467ssxzf2X9J/TlPGkcCk2Lmi0YzVGXnItA9qzHiPDqRgxckk
         E1BYRXPqAWPpFm1HwrGrxurvp+kh0C6JZW4HX2sq+x2TdsC6CFqxz69Cy8TSci0pCaQ3
         A5/R4DglPc6NLnrLlYl47Xk2akLwGXB1UXYCzUmewAicNFBn5vYjkIZlt1pJ+C8q98xc
         Mv19Of4l4dBD4jrMFTWIJF1CrnVFCU5xZ8zKHvMbhr0Yckl0LgofYNw+Qvq2jVC3luJf
         mdPRcUIHRV8zegspfQF8GwAhWcuX1eJFobzfVazRVG8GzRQsxLaRgjVTcbPEaEYQBczC
         sllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683800763; x=1686392763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ah9vrmwXkmgBXYxu0weg0/evB6b5zH+I5OTrqcCotE4=;
        b=DBTfqD2pwDn252KYHFyn+G2vW2r9dDWon5FxVrugRtBIIzgfo4RRrUXZqxn1FV4tBr
         w04cQHoxI4QOPpYf/JDeAZ1SGmzkMO+f92+Uz9SG+X8y6wHJvkhWdSC8GTC0F8+NpI/B
         ZKE2blCID90D2bkF+l3606apdewGXo7A2NzNZYGsjeHFYLBHDhxTBk65KxAwTJtip3Ui
         +HNE0wfVpyblyJUYeW7rV8qnNfAYTa+bYMqBEaDt3xM9zLIsFbKeKYuMPwQ3xRWLp6ci
         Cyxv9UXDulPN39VdgfZTNfwLzTZ6mu8EYAdGY4K8O5amhDXwR9gjxTGBFvsIDPJ/vWaf
         KB6g==
X-Gm-Message-State: AC+VfDwKZFu6HrOvCChVqBsFNj2OueoqJW/psgVfTngcWn9s+57/lXON
        LYt3T38Ga2Qu+mn8WoHupJtfJQ==
X-Google-Smtp-Source: ACHHUZ6v0q0rkYOVzfy1x5Zv7HMvJ0TR86ZQeUQKPw/eThfnEv2XBPqTzZdzQPuVsKkt4nRhZYtWTA==
X-Received: by 2002:a05:6402:1056:b0:506:86aa:78ed with SMTP id e22-20020a056402105600b0050686aa78edmr17255596edu.20.1683800762902;
        Thu, 11 May 2023 03:26:02 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:41e7:1b68:d38e:1348])
        by smtp.gmail.com with ESMTPSA id d5-20020a50fe85000000b004fbf6b35a56sm2894642edt.76.2023.05.11.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:26:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH] dt-bindings: input: cypress,cyapa: convert to dtschema
Date:   Thu, 11 May 2023 12:25:59 +0200
Message-Id: <20230511102559.175088-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert the Cypress All Points Addressable (APA) I2C Touchpad / Trackpad
bindings to DT schema.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/input/cypress,cyapa.txt          | 42 ----------------
 .../bindings/input/cypress,cyapa.yaml         | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.yaml

diff --git a/Documentation/devicetree/bindings/input/cypress,cyapa.txt b/Documentation/devicetree/bindings/input/cypress,cyapa.txt
deleted file mode 100644
index d3db65916a36..000000000000
--- a/Documentation/devicetree/bindings/input/cypress,cyapa.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Cypress I2C Touchpad
-
-Required properties:
-- compatible: must be "cypress,cyapa".
-- reg: I2C address of the chip.
-- interrupts: interrupt to which the chip is connected (see interrupt
-	binding[0]).
-
-Optional properties:
-- wakeup-source: touchpad can be used as a wakeup source.
-- pinctrl-names: should be "default" (see pinctrl binding [1]).
-- pinctrl-0: a phandle pointing to the pin settings for the device (see
-	pinctrl binding [1]).
-- vcc-supply: a phandle for the regulator supplying 3.3V power.
-
-[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-[1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-Example:
-	&i2c0 {
-		/* ... */
-
-		/* Cypress Gen3 touchpad */
-		touchpad@67 {
-			compatible = "cypress,cyapa";
-			reg = <0x67>;
-			interrupt-parent = <&gpio>;
-			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
-			wakeup-source;
-		};
-
-		/* Cypress Gen5 and later touchpad */
-		touchpad@24 {
-			compatible = "cypress,cyapa";
-			reg = <0x24>;
-			interrupt-parent = <&gpio>;
-			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
-			wakeup-source;
-		};
-
-		/* ... */
-	};
diff --git a/Documentation/devicetree/bindings/input/cypress,cyapa.yaml b/Documentation/devicetree/bindings/input/cypress,cyapa.yaml
new file mode 100644
index 000000000000..29515151abe9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cypress,cyapa.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cypress,cyapa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cypress All Points Addressable (APA) I2C Touchpad / Trackpad
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+properties:
+  compatible:
+    const: cypress,cyapa
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source: true
+
+  vcc-supply:
+    description: 3.3V power
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        trackpad@67 {
+            reg = <0x67>;
+            compatible = "cypress,cyapa";
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpx1>;
+            wakeup-source;
+        };
+    };
-- 
2.34.1

