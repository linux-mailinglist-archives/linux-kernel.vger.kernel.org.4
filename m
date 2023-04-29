Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318496F243C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjD2KqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjD2Kp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:45:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6371FCD;
        Sat, 29 Apr 2023 03:45:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so1179428a12.2;
        Sat, 29 Apr 2023 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682765155; x=1685357155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqgQik20RaJrNL1T+Wan9fC2dfJvhcXkp91dOJuP+tU=;
        b=ff5jeISUOKBWdr65mnm8rSLXdTfGoje2crU/FV35AS0hXK1tnEOiIy2sk0zZE9kuU7
         KOoc61t3VEXaiI8VwHvk/4mhERtXxVrOXgNNfCSzoT9VxFWeSGCqpf0rrMKkt+WsNRMT
         LLHBxRHPczDtZqvVsP42/RY+dNSMDNY2kiU6wBxeEyrDBy7+aHxEzK1T7Zqwl3ASa1sk
         t1G0oHANQt2Q/qaxAURMz32lytoIsvi6evHsGQtz1vXjYKczmgyfkKfl9SGV8G+cuDhz
         jpDbmXoFIDGQ2x8wzHsjtLs5gIh6eAEt7zZz8HWF1/cugDS/ZPbocMiGjj2Ptj2Vge4W
         dsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682765155; x=1685357155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqgQik20RaJrNL1T+Wan9fC2dfJvhcXkp91dOJuP+tU=;
        b=FDlAN5iRLTx1b7YIBrFs9rGZBpPc/tRzePgWpatSujGjy7y08NgKq7rsVVCwu/rSCk
         8WsZk8eLRvsaQsgSwuYvz6lDsOWmQ9RhzQfaAtwrfPbLk8stl3IfFNTwnGOK9ZLv5/EK
         eqWiUm6p9ssYLjkkgeVBE30c7O1CJWRwmccljeSjp0BLqNFmnohUaaQ5JT41tMJnvevW
         dKNI+S/uVe9spqNjxZcbP5A3KNMj7bTQPAeyieOhfTGh39IXhgQXUhbSzRjPBN8zzE80
         3+eOLI3SwrSa5Tk9fYwgWHyKOzz9K5d3tPR3E15gbTz2EwvRgbZ/MxgfhSbR5zEkAYzR
         qaSQ==
X-Gm-Message-State: AC+VfDyZCeT2uvewcmub7ehMY4dvoDDSYU8TkHYzJ/hBvQBEanMOwWrA
        +aS4Q7YopWoLGRG8IjI2QvU=
X-Google-Smtp-Source: ACHHUZ5IX7xd8VAKHJ8OC13ltLaInMOVU/XbGBnAThSTe8i0B/XBGS7hyaGf2AaaeTCqRO2qTgWDrQ==
X-Received: by 2002:a05:6402:1219:b0:506:7d65:c1fb with SMTP id c25-20020a056402121900b005067d65c1fbmr960029edw.30.1682765155315;
        Sat, 29 Apr 2023 03:45:55 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id b11-20020a056402138b00b004bd6e3ed196sm9952522edv.86.2023.04.29.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 03:45:55 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 1/4] dt-bindings: backlight: lp855x: convert to YAML and modernize
Date:   Sat, 29 Apr 2023 12:45:31 +0200
Message-Id: <20230429104534.28943-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230429104534.28943-1-aweber.kernel@gmail.com>
References: <20230429104534.28943-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notable changes:
- ROM child nodes use dashes instead of underscores; the driver
  reads all child nodes regardless of their names, so this doesn't
  break ABI.
- pwm-period argument is deprecated, as it effectively duplicates
  the period value provided in pwms. The driver continues to accept
  the property, so this should not break ABI.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../leds/backlight/lp855x-backlight.yaml      | 148 ++++++++++++++++++
 .../bindings/leds/backlight/lp855x.txt        |  72 ---------
 2 files changed, 148 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
new file mode 100644
index 000000000000..dfe8131d2a32
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/lp855x-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments LP855X backlight controllers
+
+maintainers:
+  - Artur Weber <aweber.kernel@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,lp8550
+      - ti,lp8551
+      - ti,lp8552
+      - ti,lp8553
+      - ti,lp8555
+      - ti,lp8556
+      - ti,lp8557
+
+  reg:
+    maxItems: 1
+
+  dev-ctrl:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value of device control register. This is a device-specific value.
+
+  bl-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Backlight device name.
+
+  init-brt:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: Initial value of backlight brightness.
+
+  power-supply:
+    description: Regulator which controls the 3V rail.
+
+  enable-supply:
+    description: Regulator which controls the EN/VDDIO input.
+
+  pwms:
+    maxItems: 1
+    description: |
+      PWM channel to use for controlling the backlight; setting this
+      enables the PWM-based backlight control mode.
+
+  pwm-names: true
+
+  pwm-period:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      PWM period value. Deprecated; set the period value in the pwms
+      property instead.
+    deprecated: true
+
+patternProperties:
+  "^rom-[0-9a-f]{2}h$":
+    type: object
+    description: Nodes containing the values of configuration registers.
+    properties:
+      rom-addr:
+        $ref: /schemas/types.yaml#/definitions/uint8
+        description: Register address of ROM area to be updated.
+
+      rom-val:
+        $ref: /schemas/types.yaml#/definitions/uint8
+        description: Value to write to the ROM register.
+
+required:
+  - compatible
+  - reg
+  - dev-ctrl
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@2c {
+            compatible = "ti,lp8555";
+            reg = <0x2c>;
+
+            dev-ctrl = /bits/ 8 <0x00>;
+
+            pwms = <&pwm 0 10000>;
+            pwm-names = "lp8555";
+
+            /* 4V OV, 4 output LED0 string enabled */
+            rom-14h {
+              rom-addr = /bits/ 8 <0x14>;
+              rom-val = /bits/ 8 <0xcf>;
+            };
+
+            /* Heavy smoothing, 24ms ramp time step */
+            rom-15h {
+              rom-addr = /bits/ 8 <0x15>;
+              rom-val = /bits/ 8 <0xc7>;
+            };
+
+            /* 4 output LED1 string enabled */
+            rom-19h {
+              rom-addr = /bits/ 8 <0x19>;
+              rom-val = /bits/ 8 <0x0f>;
+            };
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@2c {
+            compatible = "ti,lp8556";
+            reg = <0x2c>;
+
+            bl-name = "lcd-bl";
+            dev-ctrl = /bits/ 8 <0x85>;
+            init-brt = /bits/ 8 <0x10>;
+        };
+      };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@2c {
+            compatible = "ti,lp8557";
+            reg = <0x2c>;
+            enable-supply = <&backlight_vddio>;
+            power-supply = <&backlight_vdd>;
+
+            dev-ctrl = /bits/ 8 <0x41>;
+            init-brt = /bits/ 8 <0x0a>;
+
+            /* 4V OV, 4 output LED string enabled */
+            rom-14h {
+              rom-addr = /bits/ 8 <0x14>;
+              rom-val = /bits/ 8 <0xcf>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/leds/backlight/lp855x.txt b/Documentation/devicetree/bindings/leds/backlight/lp855x.txt
deleted file mode 100644
index 88f56641fc28..000000000000
--- a/Documentation/devicetree/bindings/leds/backlight/lp855x.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-lp855x bindings
-
-Required properties:
-  - compatible: "ti,lp8550", "ti,lp8551", "ti,lp8552", "ti,lp8553",
-                "ti,lp8555", "ti,lp8556", "ti,lp8557"
-  - reg: I2C slave address (u8)
-  - dev-ctrl: Value of DEVICE CONTROL register (u8). It depends on the device.
-
-Optional properties:
-  - bl-name: Backlight device name (string)
-  - init-brt: Initial value of backlight brightness (u8)
-  - pwm-period: PWM period value. Set only PWM input mode used (u32)
-  - rom-addr: Register address of ROM area to be updated (u8)
-  - rom-val: Register value to be updated (u8)
-  - power-supply: Regulator which controls the 3V rail
-  - enable-supply: Regulator which controls the EN/VDDIO input
-
-Example:
-
-	/* LP8555 */
-	backlight@2c {
-		compatible = "ti,lp8555";
-		reg = <0x2c>;
-
-		dev-ctrl = /bits/ 8 <0x00>;
-		pwm-period = <10000>;
-
-		/* 4V OV, 4 output LED0 string enabled */
-		rom_14h {
-			rom-addr = /bits/ 8 <0x14>;
-			rom-val = /bits/ 8 <0xcf>;
-		};
-
-		/* Heavy smoothing, 24ms ramp time step */
-		rom_15h {
-			rom-addr = /bits/ 8 <0x15>;
-			rom-val = /bits/ 8 <0xc7>;
-		};
-
-		/* 4 output LED1 string enabled */
-		rom_19h {
-			rom-addr = /bits/ 8 <0x19>;
-			rom-val = /bits/ 8 <0x0f>;
-		};
-	};
-
-	/* LP8556 */
-	backlight@2c {
-		compatible = "ti,lp8556";
-		reg = <0x2c>;
-
-		bl-name = "lcd-bl";
-		dev-ctrl = /bits/ 8 <0x85>;
-		init-brt = /bits/ 8 <0x10>;
-	};
-
-	/* LP8557 */
-	backlight@2c {
-		compatible = "ti,lp8557";
-		reg = <0x2c>;
-		enable-supply = <&backlight_vddio>;
-		power-supply = <&backlight_vdd>;
-
-		dev-ctrl = /bits/ 8 <0x41>;
-		init-brt = /bits/ 8 <0x0a>;
-
-		/* 4V OV, 4 output LED string enabled */
-		rom_14h {
-			rom-addr = /bits/ 8 <0x14>;
-			rom-val = /bits/ 8 <0xcf>;
-		};
-	};
-- 
2.40.1

