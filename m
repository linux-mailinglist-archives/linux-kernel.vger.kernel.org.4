Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D16B7AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCMOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjCMOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:49:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D783864C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so5983682ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678718969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qBG3sjrKTAghBCKa2iFwB3ZxGkMGKgf5ztXirLn58k=;
        b=RoA7lA7BTkLuRBBg+wvZRZ4cTpcwKyLSYz6M+brUeKvgYRJ/JXxhHcV2H+kmWxzu4B
         LdXnxKpRL9JtaXwGOlfFMuTHpgsIei6CzxCDMA17xOSFxXc2vVBmC3YYdx3Mb725Qplv
         VkGWQ6wrPYHuzZ3pfRS00dwF6/4WkUVIyojc9HmqfvSp8N21BSUgvuBT0QG8hV7r4IuK
         0+S6ucW64vuqyMhvRhz330MknVjldF6xEjuYKSLJ3CP4YaCGjHfIZMrwsO33D3jtKPDK
         KQGmU8q7i9kQLmo+qkBkgEmyjXDzTWzJjKnbIvoJF1RR3iVx4l6lYA+0YcAB4dG5DKjT
         RyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qBG3sjrKTAghBCKa2iFwB3ZxGkMGKgf5ztXirLn58k=;
        b=mPolNPzfLxAov0GBuuSeqMXVSCutDf3qIty2pFOPaMlI+N6DeA12jwBDvRy9rF9mxK
         ZlWDXidn45Mt/WqEOsnSpnXK8f4G8vyGx8oneeJJGP3vg3CPPBlqoG799hqpKLQnC83y
         konGpdAkBWNTgiX/a982tp1ui0FA3AVdq+NPot1D3sKyifFQrBABt8kSC9n4f9aucSoY
         aVPlJuVsDbWuNmg7IdcfqoTKhFMv/4FuT9ejKLocUEuc5UPkZAo0cj8o1cFhSZZDmAF5
         cdD14rSUojjAWI8HT/n6mGwZzqpxO3UDxfTBhnFiOZM5F3aOxrbzTNi9ugrn48FrQflP
         0vcA==
X-Gm-Message-State: AO0yUKVe7tqplmHhwlwkgG2rIGim2J5ovdqsmx2vHuf4x8109KpW0X2q
        Z/WFpdOHKiW40mIqAjpjAV4Q0w==
X-Google-Smtp-Source: AK7set9eY4niUGZj5t+Du4Xm+t7YC+ZPtd7BCIDcBMgQ9AM6UbpHCIoDwoMZGddryP6OzWQObagSJA==
X-Received: by 2002:a17:906:4e16:b0:923:4426:5fd6 with SMTP id z22-20020a1709064e1600b0092344265fd6mr6509232eju.37.1678718969280;
        Mon, 13 Mar 2023 07:49:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:69db:4882:d071:27c4])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b0092153c6b549sm3030164ejc.22.2023.03.13.07.49.28
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
Subject: [PATCH v4 04/10] media: dt-bindings: i2c: samsung,s5k6a3: convert to dtschema
Date:   Mon, 13 Mar 2023 15:49:10 +0100
Message-Id: <20230313144916.511884-5-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung S5K6A3(YX) raw image sensor bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

DTS is being fixed here:
https://lore.kernel.org/all/20230211134731.85957-3-krzysztof.kozlowski@linaro.org/

Changes since v2:
1. Add Rb tag.
---
 .../bindings/media/i2c/samsung,s5k6a3.yaml    | 98 +++++++++++++++++++
 .../bindings/media/samsung-s5k6a3.txt         | 33 -------
 2 files changed, 98 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-s5k6a3.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml b/Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml
new file mode 100644
index 000000000000..7e83a94124b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/samsung,s5k6a3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5K6A3(YX) raw image sensor
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  S5K6A3(YX) is a raw image sensor with MIPI CSI-2 and CCP2 image data
+  interfaces and CCI (I2C compatible) control bus.
+
+properties:
+  compatible:
+    const: samsung,s5k6a3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: extclk
+
+  clock-frequency:
+    default: 24000000
+    description: extclk clock frequency
+
+  gpios:
+    maxItems: 1
+    description: GPIO connected to the RESET pin
+
+  afvdd-supply:
+    description: AF (actuator) voltage supply
+
+  svdda-supply:
+    description: Core voltage supply
+
+  svddio-supply:
+    description: I/O voltage supply
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
+  - gpios
+  - afvdd-supply
+  - svdda-supply
+  - svddio-supply
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
+        sensor@10 {
+            compatible = "samsung,s5k6a3";
+            reg = <0x10>;
+            clock-frequency = <24000000>;
+            clocks = <&camera 1>;
+            clock-names = "extclk";
+            gpios = <&gpm1 6 GPIO_ACTIVE_LOW>;
+            afvdd-supply = <&ldo19_reg>;
+            svdda-supply = <&cam_io_reg>;
+            svddio-supply = <&ldo19_reg>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&csis1_ep>;
+                    data-lanes = <1>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/samsung-s5k6a3.txt b/Documentation/devicetree/bindings/media/samsung-s5k6a3.txt
deleted file mode 100644
index cce01e82f3e3..000000000000
--- a/Documentation/devicetree/bindings/media/samsung-s5k6a3.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Samsung S5K6A3(YX) raw image sensor
----------------------------------
-
-S5K6A3(YX) is a raw image sensor with MIPI CSI-2 and CCP2 image data interfaces
-and CCI (I2C compatible) control bus.
-
-Required properties:
-
-- compatible	: "samsung,s5k6a3";
-- reg		: I2C slave address of the sensor;
-- svdda-supply	: core voltage supply;
-- svddio-supply	: I/O voltage supply;
-- afvdd-supply	: AF (actuator) voltage supply;
-- gpios		: specifier of a GPIO connected to the RESET pin;
-- clocks	: should contain list of phandle and clock specifier pairs
-		  according to common clock bindings for the clocks described
-		  in the clock-names property;
-- clock-names	: should contain "extclk" entry for the sensor's EXTCLK clock;
-
-Optional properties:
-
-- clock-frequency : the frequency at which the "extclk" clock should be
-		    configured to operate, in Hz; if this property is not
-		    specified default 24 MHz value will be used.
-
-The common video interfaces bindings (see video-interfaces.txt) should be
-used to specify link to the image data receiver. The S5K6A3(YX) device
-node should contain one 'port' child node with an 'endpoint' subnode.
-
-Following properties are valid for the endpoint node:
-
-- data-lanes : (optional) specifies MIPI CSI-2 data lanes as covered in
-  video-interfaces.txt.  The sensor supports only one data lane.
-- 
2.34.1

