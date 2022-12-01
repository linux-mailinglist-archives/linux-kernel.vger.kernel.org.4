Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDB63F158
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiLANPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLANPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:15:13 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A059E475
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:15:10 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so2454126lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=397kbqZIvcY9WZM25zkLtCOQdvj4LqgI2IGa6Y1sONU=;
        b=NSfaThwXrrMYeqtiOqi8Ur7yJYrt4b6KqyJq0ynfyC1A4Xsj1AptXn96VSW/U7560E
         w9qEMf8yOKrJkM4DhRIkaTskBZuzNjnifn/BAiFXutvD6v33GABfAXM4LjjeR0++GlpW
         IvxSTHoS/XtBB0MJh53dYgGmNfWDRxqZOhVKTZ8/yutCVGr1+e6JJaFrzKgQGJPp24ci
         vwBPALQhWAXc4ENqmP5g/Aw7QK0TK2x/IsEwFNNTwzd4Gk7TTqdd/zQ33Jzfcuy82cCP
         AfmFZUpBJyGAtAN7m9gO2qvJqI+GjGHu4eZiEMjarerlrSpDynIcNBAeeZH+3EBGR38q
         SecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=397kbqZIvcY9WZM25zkLtCOQdvj4LqgI2IGa6Y1sONU=;
        b=I0sFqB1rpPijs2eURG/nVshdR/dtPC3K++tOGe/Jb2mDoUBLe+6gt0re+3mE+KPjUW
         Xplcw9za8cmhHgcWRiEKTQ9fOpLEIQ3Y7Ars2ujg75iRh+d2CXoC1abxM45ouIVCu8Vg
         0xCNZTi1Ou0Y3gjl17jAgIv3yEebQ6/7l5OLbMojg3uUfq7dFk3p2XQtdiDjtZ3WmoOV
         Mi/YTC0QNsb7YSx2bN2XMUKYTcKbnyhBdnagK2pC55P4vJP1N7LtVPBFCMohACe7a5WY
         wFLaKjFAzhwztZLHgHQpvOfWgPSP3/CKl9h7JBBJ/zWMWOPPom6XY5ikR+mNOV40YJZ0
         fHaw==
X-Gm-Message-State: ANoB5pm1CoeTHP+LgK9y80xPg7caVPg8VdjFzmb+r7n8M9Bd1kaAP8kM
        rv5DS7Kp6uASwRO4EO6Xrj1laA==
X-Google-Smtp-Source: AA0mqf4vJdo/O26H3KI5RceWwW2GVcGsw7XVgSKr19Bu1LaGEOKlszIGgfHyL6G5vQQN7cbLYpUwyg==
X-Received: by 2002:ac2:5931:0:b0:4ae:ba01:1f48 with SMTP id v17-20020ac25931000000b004aeba011f48mr16942988lfi.373.1669900508597;
        Thu, 01 Dec 2022 05:15:08 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u11-20020a2e9b0b000000b0027712379ec8sm382252lji.28.2022.12.01.05.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:15:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Date:   Thu,  1 Dec 2022 14:15:05 +0100
Message-Id: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
 .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
 3 files changed, 61 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.txt
 create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pm8058.txt b/Documentation/devicetree/bindings/leds/leds-pm8058.txt
deleted file mode 100644
index 89584c49aab2..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-pm8058.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-Qualcomm PM8058 LED driver
-
-The Qualcomm PM8058 is a multi-functional device which contains
-an LED driver block for up to six LEDs: three normal LEDs, two
-"flash" LEDs and one "keypad backlight" LED. The names are
-quoted because sometimes these LED drivers are used for wildly
-different things than flash or keypad backlight: their names
-are more of a suggestion than a hard-wired usecase.
-
-Hardware-wise the different LEDs support slightly different
-output currents. The "flash" LEDs do not need to charge nor
-do they support external triggers. They are just powerful LED
-drivers.
-
-The LEDs appear as children to the PM8058 device, with the
-proper compatible string. For the PM8058 bindings see:
-mfd/qcom-pm8xxx.txt.
-
-Each LED is represented as a sub-node of the syscon device. Each
-node's name represents the name of the corresponding LED.
-
-LED sub-node properties:
-
-Required properties:
-- compatible: one of
-  "qcom,pm8058-led" (for the normal LEDs at 0x131, 0x132 and 0x133)
-  "qcom,pm8058-keypad-led" (for the "keypad" LED at 0x48)
-  "qcom,pm8058-flash-led" (for the "flash" LEDs at 0x49 and 0xFB)
-
-Optional properties:
-- label: see Documentation/devicetree/bindings/leds/common.txt
-- default-state: see Documentation/devicetree/bindings/leds/common.txt
-- linux,default-trigger: see Documentation/devicetree/bindings/leds/common.txt
-
-Example:
-
-qcom,ssbi@500000 {
-	pmicintc: pmic@0 {
-		compatible = "qcom,pm8058";
-		led@48 {
-			compatible = "qcom,pm8058-keypad-led";
-			reg = <0x48>;
-			label = "pm8050:white:keypad";
-			default-state = "off";
-		};
-		led@131 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x131>;
-			label = "pm8058:red";
-			default-state = "off";
-		};
-		led@132 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x132>;
-			label = "pm8058:yellow";
-			default-state = "off";
-			linux,default-trigger = "mmc0";
-		};
-		led@133 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x133>;
-			label = "pm8058:green";
-			default-state = "on";
-			linux,default-trigger = "heartbeat";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml b/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
new file mode 100644
index 000000000000..fa03e73622d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/qcom,pm8058-led.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM8058 PMIC LED
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description: |
+  The Qualcomm PM8058 contains an LED block for up to six LEDs:: three normal
+  LEDs, two "flash" LEDs and one "keypad backlight" LED. The names are quoted
+  because sometimes these LED drivers are used for wildly different things than
+  flash or keypad backlight:: their names are more of a suggestion than a
+  hard-wired usecase.
+
+  Hardware-wise the different LEDs support slightly different output currents.
+  The "flash" LEDs do not need to charge nor do they support external triggers.
+  They are just powerful LED drivers.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8058-led
+      - qcom,pm8058-keypad-led
+      - qcom,pm8058-flash-led
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led@131 {
+            compatible = "qcom,pm8058-led";
+            reg = <0x131>;
+            label = "pm8058:red";
+            color = <LED_COLOR_ID_RED>;
+            default-state = "off";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 84b87f01e029..9acad9d326eb 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
@@ -43,6 +43,10 @@ properties:
   interrupt-controller: true
 
 patternProperties:
+  "led@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/leds/qcom,pm8058-led.yaml#
+
   "rtc@[0-9a-f]+$":
     type: object
     $ref: "../rtc/qcom-pm8xxx-rtc.yaml"
-- 
2.34.1

