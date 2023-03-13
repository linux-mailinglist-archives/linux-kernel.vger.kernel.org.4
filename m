Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA896B7AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCMOuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjCMOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:49:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F485FE80
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k10so49642137edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678718970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeMDG43ws8TAI/4WkpIfoMwEEvVNKnkvz75Wq7h1UGI=;
        b=Kelx3Ag+nnhqLWm1/D6+i/jVKrO79Eis5KrTSe0UISTNFIUR8c78rsXpjC/xjiTjl8
         FPFDzPnSJw/aTv4a440QoR0AKzP1WreQ2penpa98uwuAWKhj0y6LUIC0eJO9HpTwwiQO
         MewwJVdhVBB/Quq+IXTvaHmKXdkcbJo6lETWHwM0njupf0Ig/K9k10Mf1hj4jpWZfhoS
         DMsn1vFbW1ZirNN8B30NA68CnyCzzZD+RWtZXk51gjxpq3YDapbA0QcL4pAqPYLloniR
         ZDr5Ka5hqtgvjOa2YOgp6BWo/domJikWj8M0+d7D3K+kVVrBziW7CNpA7TraNzGlly0A
         vGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeMDG43ws8TAI/4WkpIfoMwEEvVNKnkvz75Wq7h1UGI=;
        b=5hF/Qmzo6CFdKOPdR61MilSlrNldpySEYjw4DAFHN2copEDnqKD/YSnZfUXHoDxAN8
         vfLYSHtRe5O+JYyicl8ZF83rnIM42wTzMGTPiwUqkcaDnc1ZS/ULj8XWIepbOlV1jDTn
         Aibq913nZi/xeAW1P9a+qpXxZ5uoBSfu0tfi/fXVOcgAETwm59yqwte2K5Ci4D7XPCJ8
         KhM+YD4AWDwl1lVgFWmwfnmOTm4GIE9rMQ9cgGzYerELomekf8ggyU2o5lRxaNG6oujS
         L0KembSpzkW2ZyME4lgoSlBCkiNSf9RCCJd/QSeHwZRXGUNHr8/M94ZE1qYOTBExDJEI
         +vwg==
X-Gm-Message-State: AO0yUKX18L+QqpxREnyJR3aV7MFhZWzFiEWahStFJAbXbQlpinaf9XVc
        vbdNYmrQ/EsPV6RCvR9QG+CMZA==
X-Google-Smtp-Source: AK7set/Cp+ne5n1/Bl2462/v3udYEfF5novO3vr6S52khX2yowN2yM9nATtqpGZaE87nVziDIUsaCw==
X-Received: by 2002:a17:907:31ca:b0:88d:f759:15b0 with SMTP id xf10-20020a17090731ca00b0088df75915b0mr41661962ejb.45.1678718970246;
        Mon, 13 Mar 2023 07:49:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:69db:4882:d071:27c4])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b0092153c6b549sm3030164ejc.22.2023.03.13.07.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:49:29 -0700 (PDT)
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
Subject: [PATCH v4 05/10] media: dt-bindings: i2c: samsung,s5k5baf: convert to dtschema
Date:   Mon, 13 Mar 2023 15:49:11 +0100
Message-Id: <20230313144916.511884-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313144916.511884-1-krzysztof.kozlowski@linaro.org>
References: <20230313144916.511884-1-krzysztof.kozlowski@linaro.org>
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

