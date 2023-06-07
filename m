Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BABC725B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbjFGKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbjFGKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:18:48 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA81BE6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:18:42 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-172-149.tukw.qwest.net [174.21.172.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 13008CFC;
        Wed,  7 Jun 2023 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1686133121;
        bh=Wi0tNbMeMIxnA5OELgarZDXHHas4dR4zF0TSjLM+/t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQcFsAPOgEw0D/5m+IYx2uAnFOA9vOUQM/J1vHoGB4QVEnJYUF48kp4gy0+RJMu7J
         W1JjgcqeawV/YqmKHrhx11mLag50cCb0hm5y8P353DlvYBJ1xSzGhi85q81xqW+HVt
         N2bs5WjhQ741nN++oU2HPzEtzhY2mfE1xPlf/h5c=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH 1/2] dt-bindings: hwmon: Add Nuvoton NCT7362Y binding
Date:   Wed,  7 Jun 2023 03:18:29 -0700
Message-ID: <20230607101827.8544-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607101827.8544-4-zev@bewilderbeest.net>
References: <20230607101827.8544-4-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding describes the NCT7362Y, a 16-channel fan/GPIO controller.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../bindings/hwmon/nuvoton,nct7362.yaml       | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml
new file mode 100644
index 000000000000..630dcce7a14c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7362.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT7362Y fan controller
+
+maintainers:
+  - Zev Weiss <zev@bewilderbeest.net>
+
+description: |
+  The Nuvoton NCT7362Y is an I2C fan controller with 16 pins that can
+  be independently configured for PWM, fan tach, or GPIO
+  functionality.  Each pin's functionality is represented by a child
+  node.
+
+  The datasheet is not publicly available but can be requested from
+  Nuvoton via their web site.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7362
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 16
+
+patternProperties:
+  "^tach@([1-8]|1[0-7])$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+        description: The pin number.
+
+      nuvoton,pulses-per-revolution:
+        description: |
+          The number of tach pulses per revolution of the fan.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 1
+        default: 2
+
+    required:
+      - reg
+
+  "^pwm@([1-8]|1[0-7])$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+        description: The pin number.
+    required:
+      - reg
+
+  "^gpio@([1-8]|1[0-7])$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+        description: The pin number.
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      fanctl@22 {
+        compatible = "nuvoton,nct7362";
+        gpio-controller;
+        #gpio-cells = <2>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x22>;
+        gpio-line-names = "", "", "", "", "", "", "", "",
+          "", "", "", "", "", "", "led1", "led2";
+
+        tach@1 {
+          reg = <1>;
+        };
+        tach@2 {
+          reg = <2>;
+          nuvoton,pulses-per-revolution = <1>;
+        };
+        pwm@10 {
+          reg = <10>;
+        };
+        pwm@11 {
+          reg = <11>;
+        };
+        gpio@16 {
+          reg = <16>;
+        };
+        gpio@17 {
+          reg = <17>;
+        };
+      };
+    };
-- 
2.40.0.5.gf6e3b97ba6d2.dirty

