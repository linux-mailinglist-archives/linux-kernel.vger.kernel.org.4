Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011E86EFA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjDZS3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDZS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:28:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D8132;
        Wed, 26 Apr 2023 11:28:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so47708835e9.3;
        Wed, 26 Apr 2023 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682533737; x=1685125737;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyzX5FFZMMCDfRy8AcL0TL3fxW2nxpzs6bzkB27YBtw=;
        b=edKi3SAC9R7jXENJBEwCvadKFYC6oOmLfId6cd7JSHVFMP/+yDgq0S/ja1R6YIp7xL
         iwdfr5vo0jtDEETxW2/r5ric8hPwG2mtON+sAkzTJ78R2zDp0NLC1dMkWts2sbPG1hAB
         JPtUB0fL8nUFzSyfqiIe4L2HgaTCa1GJmcVwsNtzoy8sjZXpcAHQr9Mynuka+EU6xxtW
         VP3GSLEd4TXM7Dab/1KXF+fJuAAaASYoKfB9pJ8ehjshzewScZOqIx5caCQb0cmm8QM2
         VofCzQkg9FHZRv4x6RsJDk/X3QsV9plUym2ua//NEdwBVrzveXJ8Qbs+uaDoT0XvV0AX
         O4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533737; x=1685125737;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyzX5FFZMMCDfRy8AcL0TL3fxW2nxpzs6bzkB27YBtw=;
        b=C0Fk4QvdT6c1YQLF0IDmZkKltXVd7mCUfTlrvZa75gEZMecydvx20oa9n8Z+CUc2Gh
         qxVuH4wIyzDXFbGXcfkOvSLyfS64td5juU6LeM0xWJjfH07ez8zbtP1Y6O7RJnv9220w
         APs1GROcSshrv2H1J9SA2yEwzKM9Hm+3VtcuM0g85MuwqTYfd8SyDD1seeCxMvqrQXXz
         mxT66vx3qQ/avGKtYjZLT0fGzGbz8tvoFyM0gTZHEeq+B6XcS26ucMM8CObRH/+b7OUC
         mL1aOpw3x8lYChN+SXze3X+74jb2h+x8TMMTcNSO69Vm+DyVOYeU8czIL38Ot1rd7L2T
         ASxA==
X-Gm-Message-State: AAQBX9c4DEAmTBtGHjQdFapELn3KGebQ/M9MDUIakc+QH0B2S1/0+yit
        Sj0HcIV3rfqgRvy5z32Z6Ks=
X-Google-Smtp-Source: AKy350bHFpkpJXfv6QjNFAs7WuhoZ0x7eY9eYf4I4jNeuDUgS/VTrc4bRDLnAESyAqwCVnUi6ZkxJQ==
X-Received: by 2002:a5d:5960:0:b0:2f9:9f6f:e4d with SMTP id e32-20020a5d5960000000b002f99f6f0e4dmr13373236wri.39.1682533736685;
        Wed, 26 Apr 2023 11:28:56 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c21c800b003f2390bdd0csm10173427wmj.32.2023.04.26.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:28:56 -0700 (PDT)
Date:   Wed, 26 Apr 2023 20:28:54 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: brcm,kona-timer: convert to YAML
Message-ID: <20230426182854.GA9571@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family timer bindings to DT schema.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/timer/brcm,kona-timer.txt        | 25 ---------
 .../bindings/timer/brcm,kona-timer.yaml       | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt b/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
deleted file mode 100644
index 39adf54b4388..000000000000
--- a/Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Broadcom Kona Family timer
------------------------------------------------------
-This timer is used in the following Broadcom SoCs:
- BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
-
-Required properties:
-- compatible : "brcm,kona-timer"
-- DEPRECATED: compatible : "bcm,kona-timer"
-- reg : Register range for the timer
-- interrupts : interrupt for the timer
-- clocks: phandle + clock specifier pair of the external clock
-- clock-frequency: frequency that the clock operates
-
-Only one of clocks or clock-frequency should be specified.
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-	timer@35006000 {
-		compatible = "brcm,kona-timer";
-		reg = <0x35006000 0x1000>;
-		interrupts = <0x0 7 0x4>;
-		clocks = <&hub_timer_clk>;
-	};
-
diff --git a/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml b/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
new file mode 100644
index 000000000000..579a8e190c10
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/brcm,kona-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family timer
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: brcm,kona-timer
+      - const: bcm,kona-timer
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency: true
+
+oneOf:
+  - required:
+      - clocks
+  - required:
+      - clock-frequency
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include "dt-bindings/clock/bcm281xx.h"
+
+    timer@35006000 {
+        compatible = "brcm,kona-timer";
+        reg = <0x35006000 0x1000>;
+        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&aon_ccu BCM281XX_AON_CCU_HUB_TIMER>;
+    };
+...
-- 
2.25.1

