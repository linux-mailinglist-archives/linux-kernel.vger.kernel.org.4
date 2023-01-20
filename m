Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB36754C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjATMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjATMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:40:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D9BD14C;
        Fri, 20 Jan 2023 04:39:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so4751740pjb.4;
        Fri, 20 Jan 2023 04:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwPb45S4zck4WbXwQFmAg4Xm6xKrl+WSTMeV0mCeNHE=;
        b=RxsRwu6VwViLl0V73U0fHLgIp3yEFGAVMnnTPe/cqQ4kOTRAgbZivTpCQ75V6IjU85
         L2y8uymJOmAiBUWpSy1gyrevBHjegZpZP7cYNnWQJ7Dapik5untY8wPtOHes4EH79JUd
         o7hpVU/aJUS9qu0kuYostfxenVOHn+bIVpHsVVjhqlfHcf799MEJa5RXNP/fQEc1Shsa
         LAKBZexvU/uhODmepBOqNEkEbox4UkflDQIN4eJyenO7r7fTJ99mxg3uABPp6bJMJhGN
         AuyFZGSfjAwg0yHO/CKf6cNIOYX/BxFF2V1kHn4hjG7GK2H0LUqKk20meh9kGem9xJ05
         Bwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwPb45S4zck4WbXwQFmAg4Xm6xKrl+WSTMeV0mCeNHE=;
        b=7VuV39w1VsNAxdptWTl9XH5P+a7KBAzYM6kLjUmjbQ9sqh/yxV4RwVGzn2Bvbnu5xQ
         taB2Cy/tzbTsb2xoL6DRwaBDh7D5f4k83heWChkQf9T03ngPKhgr4MfL0TtkVa4S55rh
         X9ll3GVDPdPfAQ20TS2l0DSHg8k+/eTOxNN0sZMVxsIL3Nnm+C/2KBNGHKUDVkqlpOuu
         xWRKKn0aVBwdindBs2tetTeqfpk7gzAvnwnTzZGynngotJgCoARMvBlV7LxNf232/Z9O
         V1v+Y92CeS/ByhrCZ23Dm/DvNzXFXvlQx4u0x/mQOMWx1vgwMpKNMKRo6lVCD0MNo6A0
         4lDg==
X-Gm-Message-State: AFqh2ko/+fc1qzHv3luy21p6QEyF6h4aOMo2obmNAQItjrMe4fn97FKJ
        Fi+5Q8PmpzvGIFbwBWs76v4=
X-Google-Smtp-Source: AMrXdXu6pObqvl76QfZIflRoyTvuicFFnNoT0voDnB1PyYO8xPA+yC10yQ/nR2VUT7qpp3NkPdMWzg==
X-Received: by 2002:a17:90b:4a0c:b0:22a:3c8:9d1 with SMTP id kk12-20020a17090b4a0c00b0022a03c809d1mr2832809pjb.32.1674218346867;
        Fri, 20 Jan 2023 04:39:06 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090a0e5700b002271b43e528sm1131044pja.33.2023.01.20.04.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:39:06 -0800 (PST)
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
Subject: [PATCH v8 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Fri, 20 Jan 2023 20:38:56 +0800
Message-Id: <20230120123857.16124-1-lujianhua000@gmail.com>
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

Changes in v8:
  - Rename current ramping time. 
  - Rename led ramping time. 

 .../leds/backlight/kinetic,ktz8866.yaml       | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..950d5d819b4d
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
+  kinetic,current-ramp-delay-ms:
+    description: LED current ramping delay time in milliseconds.
+    enum: [2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]
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

