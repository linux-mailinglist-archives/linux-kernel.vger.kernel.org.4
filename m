Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95832696157
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjBNKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjBNKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:47:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D125E2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:46:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso5841428wmo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wXN5oUCLnm2C93hf9UxnZeLddJ4OBVmPryKWY/Xmfg=;
        b=luUXS7knWdNopdDFhg3n0+WWGzOBKLpah9hErnaoGsRXIQae47hwFSjPGJPRTjLPIG
         Bc3M9Uizl2qZ6pgXTnAlOEyMHpQ/vxyMHobcZjhukYpDFzvU9WT+P75DjJKfCtrUlwzE
         gJAmQtpag/K6Uqr46fgpms4w8NJKtDRRntUtO0mi+GBhrCxKfLTXpQJlJFF21RG4PY+B
         Kf9QbRi4mluicb7OF2uYHd680WYdZ9LLI7NqOTIn77FSQ9+1Awl+Xg/A46z9sEGrbVQZ
         LN5r0WAQly2DM0MzI51btKtJvnYtMI09CPiY6++ONCcz+NoqNVl9SuKWPwvdoWh+lYlb
         wrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wXN5oUCLnm2C93hf9UxnZeLddJ4OBVmPryKWY/Xmfg=;
        b=aOcoL3neXBfxLYIVYGMhhCoXrctLyZhZBs0Zai3yAO4EmDdXJWrG8ew0QqHXk7ArmH
         DzTajGpFBZFwUKXo9hpgz/vzFjvn1ffPULBRZqCu10l8O1IvBt+nzIe7ZBrStWy+fJw5
         ETczvECP4UKvwd+bbop1c1FaZySKsfSsHdVEI/DPCcPsnHLr+cU4bMhOOt9kQfRqNwxA
         yYWYDkowKfhof9Hb8GxFrEY3UrkPlMAZO3rfyaffSAE1delI+/w8iVIuy32yPhqnSiwX
         EJTAsFgitgt4IvEptyHAXrXkNadNr5jVkpHhQ9i566C7ZhIs/5fmI623loMEjSOM84+a
         PFnQ==
X-Gm-Message-State: AO0yUKWIZZz4h/fV28VplLnJoF2nEs6ojTotHu+zxUuUOTC52TLpfUQn
        0Xgtb2LwHn9j31e5ovWB6S9VZw==
X-Google-Smtp-Source: AK7set9M3e1JfW+D5xPWc3HV6lekr1TOTKgaEb+yWLDRl8lkFgdKQPV8sghYSleDsOw/ONnovsrGpw==
X-Received: by 2002:a05:600c:3d8c:b0:3da:f670:a199 with SMTP id bi12-20020a05600c3d8c00b003daf670a199mr1652853wmb.36.1676371612245;
        Tue, 14 Feb 2023 02:46:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b003e1f319b87bsm2623719wmq.24.2023.02.14.02.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:46:51 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/7] media: dt-bindings: i2c: samsung,s5k6a3: convert to dtschema
Date:   Tue, 14 Feb 2023 11:45:02 +0100
Message-Id: <20230214104508.51955-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
References: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
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

---

DTS is being fixed here:
https://lore.kernel.org/all/20230211134731.85957-3-krzysztof.kozlowski@linaro.org/
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

