Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9273A671E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjARNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjARNkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:40:18 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6091BF8BE;
        Wed, 18 Jan 2023 05:10:14 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s3so23598321pfd.12;
        Wed, 18 Jan 2023 05:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5iDPqq2wL1x5UVYS+LC8NuxcAKp2OxFDi96DZphNLQ=;
        b=bL0JpCqTuGGGtqXInCGKfaFZvmIgRwEvI7ZIhN5WHvTzz7QAufN9+18EFo1BE6d22z
         Ayk4ytDiShS5yJEUDkgXcBbPvWrej1L01bX2ZuQjtFEgdwT/PvFzOJ81f36VXGYURKDQ
         droDZSV6kpJF15ux9kOn/2uoM5Zen/ViU5/ezUDbwlx1wtTjxpT5G2KKv7qXkLCVz1C9
         96xtyIw5gtBwRnR+f4bFSefhFvsS9zdU/L9P2ZwlFoOUVTT43R4yG34iHYjdPvVvMXDg
         0FKMGD3xzTOfWJKXn0C+Z0+aq8HzZsp4xZAROLMtnf5Qfps6EZXpJASdbruCJmoc9yyM
         KA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5iDPqq2wL1x5UVYS+LC8NuxcAKp2OxFDi96DZphNLQ=;
        b=BdyBKW0cC2aEVxdcPc6YmVmasGBDtFaSJwMW717QP/7pM6n5ngwjXA12968bHpoi70
         rl0sDWjk0u6AcdQma2Y2UulITMXswYX0nYFvev0JyCxpTDxkmWAPuUAo683MC/yX3Uvf
         vpAKNHvzYaR9ZNBN17U+PxeRFNh0pBpwNBv0R9LQC8Rd2yl4xCfy1Z5EfDZjrfh/U+fJ
         oCiE24T35hHtrnm4INb29lpCoV5cw9lu8V6nBKcIhmWM+eNTVnhq2JQ031tDixsK+m+5
         H8bZJ1WYIgEtSmnbvAc5urF3bHRG3sgUMfgeKTa1Umt9F0/865nudyChep3LQlpYSAAV
         hT7g==
X-Gm-Message-State: AFqh2kp+mIrUH7872JwIv/dhS923qqToB34ZIZTmpU7RY8P8i9HXpysO
        T8x2uxasz7Qot8KMLUWhwPM=
X-Google-Smtp-Source: AMrXdXu2yetaER0yc+qp8u9oWZL1aexMnTGa1KY3Tz1NL4YMJ3U5n7bI06w6myjw3yUh/5WCpowP2g==
X-Received: by 2002:aa7:9182:0:b0:58d:987b:2e9 with SMTP id x2-20020aa79182000000b0058d987b02e9mr6643081pfa.24.1674047414000;
        Wed, 18 Jan 2023 05:10:14 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id l123-20020a622581000000b005818d429d98sm21959880pfl.136.2023.01.18.05.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:10:13 -0800 (PST)
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
Subject: [PATCH v6 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Wed, 18 Jan 2023 21:10:01 +0800
Message-Id: <20230118131002.15453-1-lujianhua000@gmail.com>
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
  - Remove "items" between "compatible" and "const: kinetic,ktz8866"
  - Change "additionalProperties" to "unevaluatedProperties"

Changes in v3:
  - Add Krzysztof's R-b

Changes in v4:
  - Drop Krzysztof's R-b
  - Add some new properties

Changes in v5:
  - Add missing enum under property description.
  - Rename uncorrect properties.

Changes in v6:
  - Correct wrong property suffix and description.

 .../leds/backlight/kinetic,ktz8866.yaml       | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..ca0deba14523
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -0,0 +1,59 @@
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
+  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
+  with dual lcd bias power.
+  https://www.kinet-ic.com/ktz8866/
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktz8866
+
+  current-num-sinks:
+    description: Number of LED current sinks.
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
+  enable-lcd-bias:
+    description: Set if we want to output bias power supply for LCD.
+    type: boolean
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    backlight {
+        compatible = "kinetic,ktz8866";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bl_en_default>;
+
+        current-num-sinks = <5>;
+        current-ramping-time-ms = <128>;
+        led-ramping-time-ms = <1>;
+        enable-lcd-bias;
+    };
-- 
2.39.1

