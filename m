Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B86734692
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjFROXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 10:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjFROXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 10:23:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E488EE72;
        Sun, 18 Jun 2023 07:23:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-311275efaf8so1307107f8f.3;
        Sun, 18 Jun 2023 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687098210; x=1689690210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJYV4u/kyWnHPf15N2q+dF+MPxP3v/xQ6on86+LClyU=;
        b=qAUD+bj7MVLiR5sgtqerqMei0aUrWvRNb5gR3JbevNXKTFzqNY4PGLD4ua6tQ/ssND
         P8DX7Od582jfr4hzChfEiDVvgY7xOxf/BD9xwTcBQRBf06eV0wZ3YU5qn2xifaa2Aci3
         nTsdBlHlmRtD0AG7IbHFlq20BcZzoZw9uqL+VBQ9VbMdeqAHTGGAGKR7G8xuPWVNpWpy
         8bwKKIhezCSyyXdeJuyrxTJWyKSRWQfa0NuqshPkmOrgcOMf7cgXau2fuoo9IgQRzA0q
         MSzIedG4+AZYoGaQKWP6yBw3IOHt9e3LhX2eAbD6/fp3cdH6YvpqX6wijF3YoFKiQcm6
         y9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687098210; x=1689690210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJYV4u/kyWnHPf15N2q+dF+MPxP3v/xQ6on86+LClyU=;
        b=XFi+byzyr0BNHYFTEAs/bHmfybYc5sABMMPCP3+mQRWR323P9nvt3oPZV2Gb5FgjbR
         Dikb9DGB3T5pHmCq9RLg9rJj+ZnUhvSB+WON7ji5LVwCAYC0gx80A0lVM4wmR8C/wZFU
         ExjNOCpJg9NJSyvewHmL350E+NPe5yv20Liiyuv+dy/xwlaXRlVynun5EVuhBLQJoB/z
         VAul5csW4XxoNY/eqwmV/nSmEiUAUCzqSRLfWQFnKYIzzS9RWckZpUFfBnljdpN1W1q/
         S/MsQbRHiaszvK4b72wrGspZSgV8rPfPpNEaHFJSg7w44qFwby98T7gnDmGZJqMlBQxC
         2KRw==
X-Gm-Message-State: AC+VfDzfUJi90bAtZmHxgXPpQdWUItBamktVt/8uRYWz28hBC1KnTK9H
        VrL4f8P2vzZ/VCpJWQnCEpE=
X-Google-Smtp-Source: ACHHUZ63HNWBd6P41y4hmjtF2ILMWQA3HUEu3zuPO9LibLofcFKyGWY7zsR98/6S51B7AOuxj5Y2pA==
X-Received: by 2002:adf:f952:0:b0:30f:ca58:a00d with SMTP id q18-20020adff952000000b0030fca58a00dmr3822114wrr.45.1687098210150;
        Sun, 18 Jun 2023 07:23:30 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id t11-20020adfdc0b000000b0030ae3a6be5bsm28960710wri.78.2023.06.18.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 07:23:29 -0700 (PDT)
Date:   Sun, 18 Jun 2023 16:23:27 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Message-ID: <20230618142327.GA20367@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family PWM controller bindings to DT schema.

Change during conversion:
  - add used, but previously undocumented brcm,bcm11351-pwm compatible

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V3:
  - change "" include in example to <>
  - rebase on next-20230616
  - collect Krzysztof's R-b

Changes in V2:
  - mention the new compatible in the commit message (Krzysztof)

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt | 21 --------
 .../bindings/pwm/brcm,kona-pwm.yaml           | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
deleted file mode 100644
index c42eecfc81ed..000000000000
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Broadcom Kona PWM controller device tree bindings
-
-This controller has 6 channels.
-
-Required Properties :
-- compatible: should contain "brcm,kona-pwm"
-- reg: physical base address and length of the controller's registers
-- clocks: phandle + clock specifier pair for the external clock
-- #pwm-cells: Should be 3. See pwm.yaml in this directory for a
-  description of the cells format.
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-
-pwm: pwm@3e01a000 {
-	compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
-	reg = <0x3e01a000 0xc4>;
-	clocks = <&pwm_clk>;
-	#pwm-cells = <3>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
new file mode 100644
index 000000000000..e86c8053b366
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/brcm,kona-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family PWM controller
+
+description:
+  This controller has 6 channels.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,bcm11351-pwm
+      - const: brcm,kona-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm281xx.h>
+
+    pwm@3e01a000 {
+       compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+       reg = <0x3e01a000 0xcc>;
+       clocks = <&slave_ccu BCM281XX_SLAVE_CCU_PWM>;
+       #pwm-cells = <3>;
+    };
+...
-- 
2.25.1

