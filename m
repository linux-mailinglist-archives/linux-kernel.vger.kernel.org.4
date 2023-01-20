Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435467517D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjATJro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjATJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:47:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ABFA5D2;
        Fri, 20 Jan 2023 01:47:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z31so446806pfw.4;
        Fri, 20 Jan 2023 01:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPcOeTgKA9sFp6sSVwUMHgyKLqDrFQAyiFwiVpjLuSc=;
        b=V/AmSrPbxbBAdPP/f05pbBgJQSBg36+auPUDMf8w2+eqdExEerGXZ/06QwEOayvHud
         6vBxPxxoEDZg98CjuC0dNk7oM3tF0r+434LHeuGQf84FWmm690TOUVsZCOZ6MAeJV0+3
         qRC6VI5ZVrK4outXs1w3w3D/cGvETGZD22m7gILA9t/X1lvFPaUwJlhaNIRJfSEVuZPB
         R6ccCThYFlhZdSKwwrRaY2X8NUkaqaJmXw1Xes60LQLuda91Sp3A0jMXMWtiDwiPMSuP
         F4hsnlKEqCmcsFvY7TKnDc2ATNY/IaYWefQF8xyp3ZEi7NL9RFLIDO9d15r8aZIG7x/C
         LWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPcOeTgKA9sFp6sSVwUMHgyKLqDrFQAyiFwiVpjLuSc=;
        b=Pcp+sbauUuxwRPtazIjmxa8suiKdl35nWMCO28J7W38QPb6l2NScu5kDNOfYjogn0M
         1rdNmHXfrxCfcJDAi2J2gv4YAckpE095MasMKTb7bwJeiX9oqMe2G7RjNRl/NPw0MwW+
         6j+ztXUjzu1lrsH3H1WPFZIbp4EJZ0JHlbiylrHeJ6uQYTJn62C+4hiQy3XF5putG8mP
         FlsGzblXp53lW92ypuAjbsKwCA7ImZ1ByKQXTaq5/Bnrt7a+U05h51ksdYG22IcWBwE6
         fyUTT086GgAgUeGY3C5z+lLMIzAda55I6M3ROgOkhrJh+IRnSPlyxhW3TGYe55gEMrfL
         g+vg==
X-Gm-Message-State: AFqh2koxD4u395MlnZtQ3JxHkYlVGBYYi5ajfUNUkUtls5pEAkDQggHV
        9pkZGwZ1sAi+UBTmYfJ9yGs=
X-Google-Smtp-Source: AMrXdXvu2Nl2zxBEaAW5n4+lP+XXPnmrE/mONOPpF1bQtyhemIsleknFhv9g6Xd70UYaBXE9V43iQA==
X-Received: by 2002:aa7:850c:0:b0:580:ccae:291c with SMTP id v12-20020aa7850c000000b00580ccae291cmr14963503pfn.24.1674208057319;
        Fri, 20 Jan 2023 01:47:37 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id u5-20020a626005000000b005815017d348sm19308863pfb.179.2023.01.20.01.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 01:47:36 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v7 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Fri, 20 Jan 2023 17:47:27 +0800
Message-Id: <20230120094728.19967-1-lujianhua000@gmail.com>
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

 .../leds/backlight/kinetic,ktz8866.yaml       | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..b1d0ade0dfb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -0,0 +1,74 @@
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
+  current-ramping-time-ms:
+    description: LED current ramping time in milliseconds.
+    enum: [2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]
+
+  led-ramping-time-ms:
+    description: |
+      LED on/off ramping time in milliseconds, note that the case 0 will be mapped
+      to 512μs because ktz8866 can't ramp faster than it.
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
+        current-ramping-time-ms = <128>;
+        led-ramping-time-ms = <1>;
+        kinetic,enable-lcd-bias;
+    };
-- 
2.39.1

