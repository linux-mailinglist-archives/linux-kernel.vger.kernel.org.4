Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E796FAA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjEHLD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjEHLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:03:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EAB2E831;
        Mon,  8 May 2023 04:02:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f19ab994ccso44054195e9.2;
        Mon, 08 May 2023 04:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683543754; x=1686135754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3IcJNxOJ2et8h61nJbPiOjLbQlc9C+Ke7Inm0DeTLs=;
        b=JXK+B13Nx8jWObwa56nX9ZAdz4PRaDb1+Oa9Yr0kGYpYfUz3tCrJmuV5cn9QjD/vQ0
         0+w1MXP6dJtw9YNA1R3F8+q1T9o+YnLR6J8yyQCNAgOaGscvuqn3V3OXnp7LvFvB5JkY
         NTJzlxIgxnxKWF0hoy5lrTbXeIoK26JZ9Oi0Vc7n3tJgX+qaBn9nxhppTDcAdxQgJz+d
         EgKv0cYvEyp6D+8Sj/pyQdgqG6jC3TwEnn62TUkun9AXbNHBWHKeoBetcIXKGdx6SNbg
         MnchwgHrS6DzYCPsVjV0oLCHVJ7vvmlNNBZ0EnQQJB1EHOvDHIY2SuXSFz+eyGe9ireX
         qs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683543754; x=1686135754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3IcJNxOJ2et8h61nJbPiOjLbQlc9C+Ke7Inm0DeTLs=;
        b=k4jfL7Yws7k0y1Zo3zblwBOVJz6jn3bt/TAVvbaOWKJGHPmJfSrgFAR3fmDSbI2rAW
         pUOOEK+f/csjUhUgSlzb6oCnTms518BWmjC+u0m8WgfHhBhEJw0Z1QZcx1+MmbhBSSsu
         +8XebN6ZXHlniZAWipvZw7T5EQTTuAc381SAMXCcl3fqjxcWQMABcrc01Gj/aj+GMcBQ
         TqxF7eNaX+iOxgyXIIMef5hMkEPRg3zyDAPYufd66lg86KpqX18AngXMHSB4QoAbHqoB
         k26xNqaMjYjDqgNB6YydOkVKGaevHgRcR6b9Kt5mUJoVZqVtlsxvl85D/NHJrBowfFlv
         4tSQ==
X-Gm-Message-State: AC+VfDzltHKfNWgEE2wP4Nzq/r9ek0GKbiU5FGUjwzrKL1PMG5yv64/X
        gK+nEQsa/Avw+VcDRdf06oE=
X-Google-Smtp-Source: ACHHUZ40JcHgb1pxEW8IAXrZ58TAREMaBogbyLSdwmFa2D7xupidNLMVM5RXHBAr54rIEd+pVzpYPg==
X-Received: by 2002:a05:600c:2283:b0:3f4:2254:bd86 with SMTP id 3-20020a05600c228300b003f42254bd86mr3251242wmf.8.1683543753891;
        Mon, 08 May 2023 04:02:33 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a9-20020adfe5c9000000b0030632110586sm11245095wrn.3.2023.05.08.04.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:02:33 -0700 (PDT)
Date:   Mon, 8 May 2023 13:02:31 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Message-ID: <20230508110231.GA19395@standask-GA-A55M-S2HP>
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

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
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
index 000000000000..d1a58d130708
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
+    #include "dt-bindings/clock/bcm281xx.h"
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

