Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415F6709ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjESSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjESSJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:09:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C537E13D;
        Fri, 19 May 2023 11:09:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso6215488a12.2;
        Fri, 19 May 2023 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684519762; x=1687111762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa4GrAhOE8Ip1cfBaEizrnK5it7+wALvb2m6cKMWkr8=;
        b=PjsDBdWqzXzuWYohuR4TtfYGn0lvJdCvz56mbJsAebNLvs9Y7yEXnEvei99fYs7x1T
         C8zGFiYkQZ/yPfM3KIuIht5qLZX+Em9AShhJHA72aLShq60p2bzW6Ogrj7P0z0U2GdRj
         +PK4Q3QNCK26u614Jop1jnPDfarQub8anU4jrtG8wMCBUMr3rIqjJbHLyc6qdTg0Gmnr
         J/ciu1SrMAqgWFo8M9zLmrdf4Zv+mMGp1jx31AdNHlFXKQ+USET3IcVorJegcFkz7Gsw
         50pCq1zuIsbGXm/RM35wt2nd0qFq+npqyZqaBISZVn1xNUshEiCo1SBZuupu3cN5GRev
         C/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684519762; x=1687111762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa4GrAhOE8Ip1cfBaEizrnK5it7+wALvb2m6cKMWkr8=;
        b=ZEpDisgmps9QIPxADkBvuRAEV155n5n8foByIEK3FekZyVT5NeygmZyUiWkSeul4rD
         J2Y4ewY8wwmaRFyUqret5F0Gj9qp85UX09K6i0JYDSDeTo1hStGrA98GKBl5xp56kxL2
         decZYAH1Eu8phzf8JVsuWOvnfHvTaB0VPT+Ednxp6/qOIWQNJ//pGKNQk7SDzudOpAOK
         oLRN48SIH4L6ldAI1AcuTab+m7vZZmuQwT4+OVqBYwFLFdBZ9Hr339ahZ+jLxKC1Ns+B
         sggmDPbXLlbUIAvkOPygovagPnWBzgwdVUBmIoIl0Mj1KysE2E94TX+pq9MVXt21tzgK
         Ec/g==
X-Gm-Message-State: AC+VfDytXxh+3dWp8syaLv6uHGbl5mULhnYXGosu91gQNWGO8gB3bWnk
        +EMugaK8B4SDK8+Fj4lAYvM=
X-Google-Smtp-Source: ACHHUZ6u2a9Lr9cYq4NaOedPUdAUAaoP0VKuR6scPJCvErQGvWxvv92EU6jX2N5Mfo22SCLxomNc0A==
X-Received: by 2002:a05:6402:2cb:b0:50d:fcfb:861b with SMTP id b11-20020a05640202cb00b0050dfcfb861bmr2712993edx.0.1684519761880;
        Fri, 19 May 2023 11:09:21 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7c85a000000b0050690bc07a3sm19824edt.18.2023.05.19.11.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 11:09:21 -0700 (PDT)
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
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: backlight: lp855x: convert to YAML and modernize
Date:   Fri, 19 May 2023 20:07:25 +0200
Message-Id: <20230519180728.2281-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519180728.2281-1-aweber.kernel@gmail.com>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changed in v2:
 - Added additionalProperties to ROM patternProperties
---
 .../leds/backlight/lp855x-backlight.yaml      | 149 ++++++++++++++++++
 .../bindings/leds/backlight/lp855x.txt        |  72 ---------
 2 files changed, 149 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
new file mode 100644
index 000000000000..9416e1bfab92
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
@@ -0,0 +1,149 @@
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
+    additionalProperties: false
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

