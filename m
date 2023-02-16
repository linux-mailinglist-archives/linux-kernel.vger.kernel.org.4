Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035B7699734
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBPOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBPOWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:22:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B655777F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:22:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v11so953003edx.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeMDG43ws8TAI/4WkpIfoMwEEvVNKnkvz75Wq7h1UGI=;
        b=ASbSqJ4gY67dQOzwzJ3iwucWSPH+tuzjqPWjZVrgIVJAssuJRQTBGQsc/JAFrhxW2k
         q4FzMJLK4TaOxmhjHGz2TKQfiaxy1CTLn7neIsBh8bY9ycpty9CM3pNaIfWK9ar9NgAf
         IXyxt0aNOID11/6P/aaT1gtAz0GAXDBpM700aYmU5w6uBYRMNHKuILfkJFpN1LcUM0Lp
         SgzgFLDgAtDbKUCEfpPu1rkjUoTIgOkHC+G79vYj+0I/V/2kli4EYTI7pXpiSD03VbHw
         43s8ETlcX4Y7ia0VwgsD4C3q+xBiu+t+y6s3sftLLWhq2GpW6E75RIf7m5XbPcMvKMpJ
         7Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeMDG43ws8TAI/4WkpIfoMwEEvVNKnkvz75Wq7h1UGI=;
        b=UiDybvgwNZOTfXq3ojInZGnn7g5R+/vVgbhoQDXUcvfQtSXDFtKnEqJUJi6NCT8HnT
         N0bbPVU6xjm2YddPAOdobZRFGcyOBLKyMJO1ltXnIlLIUmXZyhSA5SuE1Je1EIXETCFU
         XeQp2yoiUJDAh8Y1basb9oMrjzPtHoPAvtZLiCa/JewFUpcPg0fQ930Ypm3p9xC6QjiU
         dchkiCXIQNPxQsl9uuR1uZvZMADgJYnbVOeCCeT1NqYAblxWBAs3P5ev/spjqpcMiEKp
         X/GUMLE11mTIoF1B2v9KRhNiLIYEs9N4p+hLsQGuTT/cTRaT+/ljQGdFkxnprB+ekiLd
         x5Mg==
X-Gm-Message-State: AO0yUKUisyIbw5nKYMlYUMPfkXy04wdfpdd/sv3LLWXVrqplTcdhCo9l
        YdLQi5kPs+HZ9P40ESbZQbG/tQ==
X-Google-Smtp-Source: AK7set+aIU1ZTsipwqYwHQfPn5G8amAssWrw4Q1TBUaZp8QcoEtr1EVpefq1ITzydwTF1xYEUkik5g==
X-Received: by 2002:a17:906:4b0d:b0:8aa:11dc:ac6 with SMTP id y13-20020a1709064b0d00b008aa11dc0ac6mr6013726eju.57.1676557332082;
        Thu, 16 Feb 2023 06:22:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ad24-20020a170907259800b0087bdac06a3bsm884757ejc.2.2023.02.16.06.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:22:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/7] media: dt-bindings: i2c: samsung,s5k5baf: convert to dtschema
Date:   Thu, 16 Feb 2023 15:21:59 +0100
Message-Id: <20230216142204.48394-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
References: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung S5K5BAF image sensor bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Add Rb tag.
---
 .../bindings/media/i2c/samsung,s5k5baf.yaml   | 101 ++++++++++++++++++
 .../bindings/media/samsung-s5k5baf.txt        |  58 ----------
 2 files changed, 101 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-s5k5baf.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml b/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
new file mode 100644
index 000000000000..c8f2955e0825
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/samsung,s5k5baf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5K5BAF UXGA 1/5" 2M CMOS Image Sensor with embedded SoC ISP
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+properties:
+  compatible:
+    const: samsung,s5k5baf
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mclk
+
+  clock-frequency:
+    default: 24000000
+    description: mclk clock frequency
+
+  rstn-gpios:
+    maxItems: 1
+    description: RSTN pin
+
+  stbyn-gpios:
+    maxItems: 1
+    description: STDBYN pin
+
+  vdda-supply:
+    description: Analog power supply 2.8V (2.6V to 3.0V)
+
+  vddio-supply:
+    description: I/O power supply 1.8V (1.65V to 1.95V) or 2.8V (2.5V to 3.1V)
+
+  vddreg-supply:
+    description:
+      Regulator input power supply 1.8V (1.7V to 1.9V) or 2.8V (2.6V to 3.0)
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            items:
+              - const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - rstn-gpios
+  - stbyn-gpios
+  - vdda-supply
+  - vddio-supply
+  - vddreg-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor@2d {
+            compatible = "samsung,s5k5baf";
+            reg = <0x2d>;
+            clocks = <&camera 0>;
+            clock-names = "mclk";
+            clock-frequency = <24000000>;
+            rstn-gpios = <&gpl2 1 GPIO_ACTIVE_LOW>;
+            stbyn-gpios = <&gpl2 0 GPIO_ACTIVE_LOW>;
+            vdda-supply = <&cam_io_en_reg>;
+            vddio-supply = <&vtcam_reg>;
+            vddreg-supply = <&vt_core_15v_reg>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&csis1_ep>;
+                    data-lanes = <1>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/samsung-s5k5baf.txt b/Documentation/devicetree/bindings/media/samsung-s5k5baf.txt
deleted file mode 100644
index 1f51e0439c96..000000000000
--- a/Documentation/devicetree/bindings/media/samsung-s5k5baf.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-Samsung S5K5BAF UXGA 1/5" 2M CMOS Image Sensor with embedded SoC ISP
---------------------------------------------------------------------
-
-Required properties:
-
-- compatible	  : "samsung,s5k5baf";
-- reg		  : I2C slave address of the sensor;
-- vdda-supply	  : analog power supply 2.8V (2.6V to 3.0V);
-- vddreg-supply	  : regulator input power supply 1.8V (1.7V to 1.9V)
-		    or 2.8V (2.6V to 3.0);
-- vddio-supply	  : I/O power supply 1.8V (1.65V to 1.95V)
-		    or 2.8V (2.5V to 3.1V);
-- stbyn-gpios	  : GPIO connected to STDBYN pin;
-- rstn-gpios	  : GPIO connected to RSTN pin;
-- clocks	  : list of phandle and clock specifier pairs
-		    according to common clock bindings for the
-		    clocks described in clock-names;
-- clock-names	  : should include "mclk" for the sensor's master clock;
-
-Optional properties:
-
-- clock-frequency : the frequency at which the "mclk" clock should be
-		    configured to operate, in Hz; if this property is not
-		    specified default 24 MHz value will be used.
-
-The device node should contain one 'port' child node with one child 'endpoint'
-node, according to the bindings defined in Documentation/devicetree/bindings/
-media/video-interfaces.txt. The following are properties specific to those
-nodes.
-
-endpoint node
--------------
-
-- data-lanes : (optional) specifies MIPI CSI-2 data lanes as covered in
-	       video-interfaces.txt. If present it should be <1> - the device
-	       supports only one data lane without re-mapping.
-
-Example:
-
-s5k5bafx@2d {
-	compatible = "samsung,s5k5baf";
-	reg = <0x2d>;
-	vdda-supply = <&cam_io_en_reg>;
-	vddreg-supply = <&vt_core_15v_reg>;
-	vddio-supply = <&vtcam_reg>;
-	stbyn-gpios = <&gpl2 0 1>;
-	rstn-gpios = <&gpl2 1 1>;
-	clock-names = "mclk";
-	clocks = <&clock_cam 0>;
-	clock-frequency = <24000000>;
-
-	port {
-		s5k5bafx_ep: endpoint {
-			remote-endpoint = <&csis1_ep>;
-			data-lanes = <1>;
-		};
-	};
-};
-- 
2.34.1

