Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400F4641C66
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 11:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLDKnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 05:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiLDKnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 05:43:33 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA88E0FE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 02:43:31 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id x6so10361694lji.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 02:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUtAt+SuxLZPa/RB4QNwZAEnF/ypq5aNumvuCyCA9xc=;
        b=b13/F8a+rUqvNZ/XYyBYbeH+jtIJ+hV+icTub0e55c0B1U8hk+1IIlKae3gTssRMZm
         0Vpyp4gKhqCxneqz0Iz9Vjop23XhBF9VKCDhfNeAoMRTgXlzFcAFTrOWmSDaETLAwsDw
         EpjoigAnFinTxpZrrU2YHxR5iA6OrnnkQzqYkVrEmidIy9AASxwyu4ZR9QL8U4x95FfW
         wB6dECAuda6SZgu5CiKnwVJSBmpN+p66EHu0a6Tkx2fNZiugxyyZnQreZRsoT1Mr3eDJ
         dwIUmoROfqCAHTKo8d2oMhuZYD2O9uwQHlF5BGvTdTl5X8OVYaWIAZI8PnI8k9Q2bEyF
         596w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUtAt+SuxLZPa/RB4QNwZAEnF/ypq5aNumvuCyCA9xc=;
        b=BUtjtHIDn4eEVGcXwKfOxiCBAo1ykSKytMUKHxPPnyhefu+OSjIr7ho4fPtAaW/y68
         mP7+xSqRt2oUUfCRmi6su1YbfoFGrwDjKSBhk7/HNFnmhqRnjuzSfkiTXw7eTc4K+Arh
         2fm0UtpBnZt0GaUlaCm1rxrz2mf6Aih7RXbVUXEdgjt7LYklubtX8xRC4qyNRqsLVeSn
         4RgG2jMYU4b4OUGvIjoOEeUJikHGstnTvc/sD9+m9KZnn1TmpOXFUdvFx+01qrVk2Q+7
         7bIwK/giXTwoSf7X95s2q7imv5gZvJ0lVEf3S/kIjq7j5danuk/3S658+zeCtI6dbkbT
         qP7Q==
X-Gm-Message-State: ANoB5pk9GMCR0CiSshQ3v+e3az5maXARmalMVdCAL5jY1PEuoAegnpVd
        HHgupKz+jtbaUskmAx/VvpdY7w==
X-Google-Smtp-Source: AA0mqf5CakR+0IBuMADjv7++aDidoKZ/7nREP95nHQ81sJ0Lmx7kjfFKOT4CS7bPA6s5DVuYJuRRnw==
X-Received: by 2002:a2e:b0fb:0:b0:279:9db3:7e58 with SMTP id h27-20020a2eb0fb000000b002799db37e58mr9729626ljl.341.1670150610240;
        Sun, 04 Dec 2022 02:43:30 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651c118d00b0026c42f67eb8sm893318ljo.7.2022.12.04.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 02:43:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: leds: irled: pwm-ir-tx: convert to DT schema
Date:   Sun,  4 Dec 2022 11:43:22 +0100
Message-Id: <20221204104323.117974-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
References: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
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

Convert the PWM IR LED bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/leds/irled/pwm-ir-tx.txt         | 13 -------
 .../bindings/leds/irled/pwm-ir-tx.yaml        | 34 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 35 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.txt
 create mode 100644 Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml

diff --git a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.txt b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.txt
deleted file mode 100644
index 66e5672c2e3d..000000000000
--- a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Device tree bindings for IR LED connected through pwm pin which is used as
-remote controller transmitter.
-
-Required properties:
-	- compatible: should be "pwm-ir-tx".
-	- pwms : PWM property to point to the PWM device (phandle)/port (id)
-	  and to specify the period time to be used: <&phandle id period_ns>;
-
-Example:
-	irled {
-		compatible = "pwm-ir-tx";
-		pwms = <&pwm0 0 10000000>;
-	};
diff --git a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
new file mode 100644
index 000000000000..f2a6fa140f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/irled/pwm-ir-tx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IR LED connected through PWM pin
+
+maintainers:
+  - Sean Young <sean@mess.org>
+
+description:
+  IR LED connected through PWM pin which is used as remote controller
+  transmitter.
+
+properties:
+  compatible:
+    const: pwm-ir-tx
+
+  pwms:
+    maxItems: 1
+
+required:
+  - compatible
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    irled {
+        compatible = "pwm-ir-tx";
+        pwms = <&pwm0 0 10000000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 25b7fbf09e7b..e3f3c3e53f77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16960,6 +16960,7 @@ PWM IR Transmitter
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
 F:	drivers/media/rc/pwm-ir-tx.c
 
 PWM SUBSYSTEM
-- 
2.34.1

