Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50A69315A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 14:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBKNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 08:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBKNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 08:47:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552C28237
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:47:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j23so7893996wra.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RtrS8mLtl7ssVBCGB2QEC8eHd7/s0+c6vonCW3UXCY=;
        b=lNTCUPyKJh67Sp45u9X7lDBFO3QWb+wjDKRFL7yoUvliYg1+MpNteOmztjMJEsLapN
         pWbJOY/aTu4zPeshTOyW7aq7/tnvh0jGpf61UAY3QP74rLCtfgrksK+Ne5hbns+/StKM
         d+0cn05eTZ+ZQbIcSALV1jA+xV+53Qyd+XOgcujfong1TPfu0O+dd/kjLScuhWEXb2xD
         Citjpu+mMvYBcqxJybPP332tnWwqturUht8l60XnXgdV6cbTw39QRzDYo3s3H6pEsKdW
         YbvCnLT1gv2fvmHAhd5I2rDYuiBTR+S4J8rKBs2Q4OKchyk1HRyW7PT5wF9uh9RsuMlr
         uaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RtrS8mLtl7ssVBCGB2QEC8eHd7/s0+c6vonCW3UXCY=;
        b=HoeaKIJc2QPnAtz53e/ztGdHQJcu0W6y0sG59fVPkrSRO95EjetCzmaszgPZeVIhvx
         0dxj7nyP/ZOK8daAIyQ151nBzYTuEscklwabF5cUcMPQbO01p/9SINcxeIrUTxcRD4i6
         sqIzm5ZBpnodrak/EEhHPldE5knYHZOz4coMhr6XgP7Vwnk9IahhEtOYwYOnSBNUEgno
         NE0LwJjPy2Qcp7RD9/ElmuhJK+xEso0qIbnM+PObqHJ+O14uVF74B8qZ3ylPpc6lL8Kb
         3vgGq16CGk3WmUFwOb3djOw6WTTF6dlytNuer7sZ9K8lRHErPJ4g4rK9nKZo2NkPTNiU
         1Iog==
X-Gm-Message-State: AO0yUKV0ErAMafRjMsiPNonMRrV1sCzuTsz7kPFWpSbc4q49W4BOnwYD
        z/KaORSotjGWyhFXq54RnbefpA==
X-Google-Smtp-Source: AK7set8uab1hRAPzEt+iup9dx4I6F+c3TfUmqNTMUc36rapfNi9/19ZWTFvQcsWtzjhVHWijRHusIw==
X-Received: by 2002:a5d:5389:0:b0:2c3:f808:2d97 with SMTP id d9-20020a5d5389000000b002c3f8082d97mr15682310wrv.43.1676123257958;
        Sat, 11 Feb 2023 05:47:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y9-20020adfee09000000b002c550eb062fsm1118055wrn.14.2023.02.11.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 05:47:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] media: dt-bindings: i2c: samsung,s5k5baf: convert to dtschema
Date:   Sat, 11 Feb 2023 14:47:30 +0100
Message-Id: <20230211134731.85957-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230211134731.85957-1-krzysztof.kozlowski@linaro.org>
References: <20230211134731.85957-1-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung S5K5BAF image sensor bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

