Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372276EC06F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDWOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:39:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA7E6A;
        Sun, 23 Apr 2023 07:39:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f20215fa70so2465025e9.0;
        Sun, 23 Apr 2023 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682260794; x=1684852794;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxascrpnkHsxUo0LirHOTOs03IZF0Zd8/Rtbdyketmg=;
        b=mPuZ9Ir1i7hak/yYSbI/PcvjGSebu/6dMaWjhg55ov7WSNXRhaQw9SdwF5hrpiFfYD
         6Gw7veIFxdQz2CDqrpcSFRoMHHJ/KQ83s+xtiAJqbf7kfPd7CVkvaVTiMn8gpRHeL2sX
         rnVt5BdYYN1q00XBsrppf8tuTqqB2NGePafK9LsC/vumSRZZqUBIYB0zRMj/JWU10+5f
         kreoR565uQzQLI8/L1amA1gJxBE8nC6gyz7Qr1XPJ0NGT2W7NXrAHmrGg6p1m21uEDZv
         T7Yzpp0eIU5ZPwQxN5falUUhIj6zpqQ5BsWeyYQDOkdNhYiS8JIn4o5SD6uXSulofFFO
         uicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682260794; x=1684852794;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxascrpnkHsxUo0LirHOTOs03IZF0Zd8/Rtbdyketmg=;
        b=ZtAnBk17Eu1oW5PN8xgjth78NGoffRVO0MHIvs0NiZ4W59mU/MYcSjwKB32ECJ0c9l
         jwAsnQ/vHRxfrQhpCgftkUmEkArozMvivZn8dyBfs+U3c5gMSbYQfjlgP/4Xe1rZ1EHA
         rtxbgoeeUSML6+F7NWXR7s/lutcePNQO/UK5Q/V3aQZ/xuGDbXlCunYQARtHdpcc4myY
         9HsZXqllCcz+LauDJ4fx91NQuO44VRSImRgsECc9+W82GIh9CWACVJ0liWfHiAXb0o3s
         eFPlBrBUA/T7fwpzhLSZaO8cKEWllOd7Hl1LVJyYNtazCBqnnQfOyAJTXvWtxCoiCJ0v
         eKnQ==
X-Gm-Message-State: AAQBX9fTVIRp7IdGD0kY56Q0LwJoL5iVmLAIoF+QKjGg9NNe2ep4y/VF
        hOavkj0LkuNI+YwtnIZId8A=
X-Google-Smtp-Source: AKy350aPyZPa0CtW4ev4K4hqS4De6YZ1OaWbU9d9U5y6hhqvznG19xTAbpwfSf+xzBGdLdwhFEVBRQ==
X-Received: by 2002:a1c:7201:0:b0:3ee:775:c573 with SMTP id n1-20020a1c7201000000b003ee0775c573mr5550759wmc.20.1682260793646;
        Sun, 23 Apr 2023 07:39:53 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003f195d540d9sm5362328wmo.14.2023.04.23.07.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:39:53 -0700 (PDT)
Date:   Sun, 23 Apr 2023 16:39:51 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH,RESEND] dt-bindings: watchdog: brcm,kona-wdt: convert to YAML
Message-ID: <20230423143951.GA10743@standask-GA-A55M-S2HP>
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

Convert Broadcom Kona family watchdog timer bindings to DT schema.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
RESEND because I originally sent this to the wrong maintainers and
mailing lists by accident. Sorry for the noise.

 .../bindings/watchdog/brcm,kona-wdt.txt       | 15 --------
 .../bindings/watchdog/brcm,kona-wdt.yaml      | 37 +++++++++++++++++++
 2 files changed, 37 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
deleted file mode 100644
index 2b86a00e351d..000000000000
--- a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom Kona Family Watchdog Timer
------------------------------------
-
-This watchdog timer is used in the following Broadcom SoCs:
-  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
-
-Required properties:
-  - compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
-  - reg: memory address & range
-
-Example:
-	watchdog@35002f40 {
-		compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
-		reg = <0x35002f40 0x6c>;
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
new file mode 100644
index 000000000000..5de1b022847b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/brcm,kona-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family watchdog timer
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,bcm11351-wdt
+      - const: brcm,kona-wdt
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@35002f40 {
+        compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
+        reg = <0x35002f40 0x6c>;
+    };
+...
-- 
2.25.1

