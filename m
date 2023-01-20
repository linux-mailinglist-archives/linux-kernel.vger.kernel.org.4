Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199BD675911
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjATPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjATPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:50:27 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06A2729;
        Fri, 20 Jan 2023 07:50:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k18so5674288pll.5;
        Fri, 20 Jan 2023 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ifz3vDvAEZ7BS42gIpHTFMzrz22EW4dCog2+fKqAMLc=;
        b=h5wWDnI4mu+2WaMB0V6kZe+MaCszFySNtwk1wV9PkALf7br2lcsHhs6/izaBZwFkn5
         jRm2JNU9hyZ6skEnL97rpTa2d+49yxfOX5DwNk/t31dYjFVbFtsBumcLWbg+vou9R0eu
         OXwNEvMOjFhBB7BxHdx9o4wfJLhfInYPofZaykiRHXjvQK/UtxoIkG2/ae/eUMZ7whXB
         e6ZP44jhBc8QU7/YcuxUwULgHDzJCIoNOaGcGq3jXqLhyY4zmDr43mfvP3xkwZQ6LF1u
         LUQnbEA3WWlY2WdbHSRD+XXoHSyKwn6aOeIfWRUXUrl64RH9iFX3AVL85i9TeJQzsSEy
         zBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ifz3vDvAEZ7BS42gIpHTFMzrz22EW4dCog2+fKqAMLc=;
        b=xUqzS/K5tdzctt5V8I4XPj0hji2r/COWWh3odg/Y1Viftd3NalrCimesgPdxbmWqcC
         C6oeKC5OEPmn4iEGASkteXDWp8OJuv5b9Nlwsb8WseS6jXz2IHk8gwpvnWTqY5NQ8ITd
         OUh6VoUZM99KTf+UmapRMvdEs4JYsjruZuT5jhaf/z4m9czm3Ucufp/FIdhG6O8O9kK5
         MAzrY1ocO1EaczNV9CPZFmSPQ4MItngTl+lTi4lXPn5pxA5i566k3LWEWeSJoP72fE6F
         RJEc2gpIF9SYYnmIpNFj67hGQsnFNprltHEY7perBpWmYW+uCrvIvWdjGCx/zEgLlz5c
         GyVA==
X-Gm-Message-State: AFqh2krK33dkcCqkGN9KjQcLO7Qpo1Y/Gxfcv3EHo5TvwJSi0vykw/KG
        wy7TBUISKNWc/mWZvH5Zf7z40FrFGqg=
X-Google-Smtp-Source: AMrXdXurnIoilt6fN2sw9uvaZYbWJ6iIHk57f5fmjv34pWqyznNfo6PJJyMgiSTYY9REG2JkqaV4JQ==
X-Received: by 2002:a17:903:449:b0:189:6ab3:9e75 with SMTP id iw9-20020a170903044900b001896ab39e75mr14309167plb.15.1674229825960;
        Fri, 20 Jan 2023 07:50:25 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902780900b00188fc6766d6sm27012824pll.219.2023.01.20.07.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:50:25 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Fri, 20 Jan 2023 23:50:17 +0800
Message-Id: <20230120155018.15376-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kinetic KTZ8866 backlight binding documentation.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
  - Remove "items" between "compatible" and "const: kinetic,ktz8866".
  - Change "additionalProperties" to "unevaluatedProperties".

Changes in v3:
  - Add Krzysztof's R-b.

Changes in v4:
  - Drop Krzysztof's R-b.
  - Add some new properties.

Changes in v5:
  - Add missing enum under property description.
  - Rename uncorrect properties.

Changes in v6:
  - Correct wrong property suffix and description.

Changes in v7:
  - Add vddpos and vddeg supply.
  - Use enable-gpios instead of defining enable pin.

Changes in v8:
  - Rename current ramping time. 
  - Rename led ramping time. 

Changes in v9:
  - Add Krzysztof's R-b.
  - Add missing 1μs to the enum of "kinetic,led-enable-ramp-delay-ms".

 .../leds/backlight/kinetic,ktz8866.yaml       | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..e1191453c2f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTZ8866 backlight
+
+maintainers:
+  - Jianhua Lu <lujianhua000@gmail.com>
+
+description: |
+  The Kinetic Technologies KTZ8866 is a high efficiency 6-channels-current-sinks
+  led backlight with dual lcd bias power.
+  https://www.kinet-ic.com/ktz8866/
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktz8866
+
+  vddpos-supply:
+    description: positive boost supply regulator.
+
+  vddneg-supply:
+    description: negative boost supply regulator.
+
+  enable-gpios:
+    description: GPIO to use to enable/disable the backlight (HWEN pin).
+    maxItems: 1
+
+  current-num-sinks:
+    description: number of the LED current sinks' channels.
+    enum: [1, 2, 3, 4, 5, 6]
+
+  kinetic,current-ramp-delay-ms:
+    description: |
+      LED current ramping delay time in milliseconds, note that the
+      case 1 will be mapped to 1μs.
+    enum: [1, 2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]
+
+  kinetic,led-enable-ramp-delay-ms:
+    description: |
+      LED on/off ramping delay time in milliseconds, note that the case 0 will be
+      mapped to 512μs because ktz8866 can't ramp faster than it.
+    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
+
+  kinetic,enable-lcd-bias:
+    description: Set if we want to output bias power supply for LCD.
+    type: boolean
+
+required:
+  - compatible
+  - vddpos-supply
+  - vddneg-supply
+  - enable-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    backlight {
+        compatible = "kinetic,ktz8866";
+
+        vddpos-supply = <&bl_vddpos_5p5>;
+        vddneg-supply = <&bl_vddneg_5p5>;
+        enable-gpios = <&tlmm 139 GPIO_ACTIVE_HIGH>;
+        current-num-sinks = <5>;
+        kinetic,current-ramp-delay-ms = <128>;
+        kinetic,led-enable-ramp-delay-ms = <1>;
+        kinetic,enable-lcd-bias;
+    };
-- 
2.39.1

