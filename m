Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306D06F0C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbjD0THl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244658AbjD0THi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:07:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A24488;
        Thu, 27 Apr 2023 12:07:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f315735514so35380385e9.1;
        Thu, 27 Apr 2023 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682622447; x=1685214447;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DD/i3pbFgHoXQYJbjBQbgWQpfiH0mY/V+lPtAi5i5E=;
        b=KYfywVJpr98BpGpUIMqxiOWLoVzT8wTs6KkJbyntKqr1amFwN4b1tANgZotb31/3Tr
         dV1pjRe8tKdaAl6HOWDQ3K+bZo7pMh76x84iLn4BaG7KwdzQFAfOMomj7I0V9G3gA76H
         8CJYQjapq5+VBAmdu916oOuPUT91BUQAlsLKLVaJnt/vPlm62OaJ+3v/MxmMh07DDnml
         3SIAiVH5I1m5oYEc8JJMxPZjtE2jLpHMZi1Px2lgsUXW+iv2G7F4qytfXTfdJTXSgEYa
         YilTrc3ZX4Hv+mzrIdJduqriNZDI2f554NjTYB5tqQNCSXrpx2+uM23KE0KSAt/CEW8L
         qyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682622447; x=1685214447;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DD/i3pbFgHoXQYJbjBQbgWQpfiH0mY/V+lPtAi5i5E=;
        b=QBHh4DNnA6XrfTEupOLlMwuaFTOYHPIATyJj/zOtO0g0W7PyVybZt7KOAsuUxB60Hz
         yfu8ULNIUAp9Ulyn/icQE5GSa9JsCQL0QILoUG8UgnINr+G5pDl/fqTZZAQJbsfIOfJ1
         G9Dq/8TiMz7+fnT+8BoauLZyoDVxBu+1+M6S2RNZU5Wc/bY3zv82mPARMnzn1EvkQAkM
         q3BDEipdVkIBCBASVQcn88dC+eP0QBeACYds/oSPwvi2vw89kY6swt6rxAHaeqQgmkWw
         F+9zX+HgyuTDFK+tmDRxEjBRv1+v7rExxflVM1oM0zvTiO3+a6DE0i1erVohsMYVVAlp
         zVCA==
X-Gm-Message-State: AC+VfDxxm84rhVIBGcV7VzLR0UoALL97AfU2sNGcXpE+yf9mrffr8uuC
        gdWreM4BMK1s8jEPMxrnxMzcdDQn0TqCUg==
X-Google-Smtp-Source: ACHHUZ6YOdz4pEj5ILXL0eZIKrBh1KFvZPGv9RzTwKeNdO3k5tHQ12aCAisCbRh5jM2+tRbYYlKFlw==
X-Received: by 2002:adf:f5c1:0:b0:2f5:dad1:41a4 with SMTP id k1-20020adff5c1000000b002f5dad141a4mr2302395wrp.6.1682622447461;
        Thu, 27 Apr 2023 12:07:27 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d538e000000b002efac42ff35sm19217573wrv.37.2023.04.27.12.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:07:27 -0700 (PDT)
Date:   Thu, 27 Apr 2023 21:07:25 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: brcm,kona-usb2-phy: convert to YAML
Message-ID: <20230427190725.GA7730@standask-GA-A55M-S2HP>
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

Convert Broadcom Kona family USB 2.0 PHY bindings to DT schema.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/phy/brcm,kona-usb2-phy.txt       | 15 --------
 .../bindings/phy/brcm,kona-usb2-phy.yaml      | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.txt b/Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.txt
deleted file mode 100644
index 3dc8b3d2ffbb..000000000000
--- a/Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-BROADCOM KONA USB2 PHY
-
-Required properties:
- - compatible: brcm,kona-usb2-phy
- - reg: offset and length of the PHY registers
- - #phy-cells: must be 0
-Refer to phy/phy-bindings.txt for the generic PHY binding properties
-
-Example:
-
-	usbphy: usb-phy@3f130000 {
-		compatible = "brcm,kona-usb2-phy";
-		reg = <0x3f130000 0x28>;
-		#phy-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.yaml
new file mode 100644
index 000000000000..d7faeb81f7a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,kona-usb2-phy.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/brcm,kona-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family USB 2.0 PHY
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,kona-usb2-phy
+
+  reg:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-phy@3f130000 {
+        compatible = "brcm,kona-usb2-phy";
+        reg = <0x3f130000 0x28>;
+        #phy-cells = <0>;
+    };
+...
-- 
2.25.1

