Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7F605831
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJTHQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJTHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:15:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC86157F56;
        Thu, 20 Oct 2022 00:15:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u71so18462204pgd.2;
        Thu, 20 Oct 2022 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJg3vkvL6mAQwIfI1Is4t7HAoGmIXrff5qn+0C2h0VA=;
        b=F3cXE7TKYCnQ4DYQVQ0V/K/TdvmV20wqnacqxzWZgxKePp+eBisnW/DmerLNdp6B0T
         fMfIwGr3wTiSBNQb50oZ42ko4YQrNIbHObY3gqQVhpWrhvdd6snGNewe38R9mj+4ZE1h
         2HHYAmT2bXNKQJ3ASTfEadCah9/jVN3aw8DtxsTGORXRG7fP2pLHApxgbwuzqN+Op9VE
         +jDQQbhIzvcb0iMxUV5/POjCaRwkKrhp0/t3kel9pfE6p66PwwTkQyDOnLWRoGT/Xu0w
         R9TLvOJH3brmuIsmle8/XLmYyGZMluF43irYuKRshiBspsvKln9t9SplVt94xpyqgTud
         Mc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJg3vkvL6mAQwIfI1Is4t7HAoGmIXrff5qn+0C2h0VA=;
        b=5ivlmVdYn5ooDOap17PL4w2yWzvXDWiEcnAGdtgim8rc8QNvp8PVN7d6F0OP5LbmAO
         aQul6vlDknAx4TAQIauh7nPHgwa3Vz/rRS5qwfobwusCM2Gxefxs+Y2ZHKUuBs6prkOX
         YcYItelLOFyFIEzv6tmOiJwQ+p+simzi9TTqHTOzSNGBcjrKAx3d6XJtE7FI4AUXTB6j
         r093kbCkGZ0Uk2rvZiOlCuwKYwSJsvMu0oe4ikyBHlLTqqhY56e/pX4O0cb2jO3nZOsB
         VqCl089p7F85AlDaDpeUt1wE8paPBrb9BwC9FZz7oRGIQIRlE49wrPB4Sp3wwNUcNvza
         QKvg==
X-Gm-Message-State: ACrzQf2SjhyJDOq+tl2X/6E80S4Sou+Zk1ETHMzgIaFe8KKvI9qHjd4V
        yOr/DAjXWHvfQBZnlp6fmJc=
X-Google-Smtp-Source: AMsMyM5ElIpVUnHkz/uiWTk0lecz039cAGsTQCkBc/IuyCFG0wBH3RELVlCJb2MHTjrC5HSptcJzKg==
X-Received: by 2002:a65:6b8e:0:b0:44f:ec0f:f684 with SMTP id d14-20020a656b8e000000b0044fec0ff684mr10248386pgw.25.1666250072043;
        Thu, 20 Oct 2022 00:14:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:a12c:444a:ed28:4831:fc95])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902db0800b0018157b415dbsm12094679plx.63.2022.10.20.00.14.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 00:14:31 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: supply: Add Richtek RT9759 smart cap divider charger
Date:   Thu, 20 Oct 2022 15:14:19 +0800
Message-Id: <1666250061-18686-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666250061-18686-1-git-send-email-u0084500@gmail.com>
References: <1666250061-18686-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add bindings for the Richtek RT9759 smart cap divider charger.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/supply/richtek,rt9759.yaml      | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
new file mode 100644
index 00000000..04fc6b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9759 Smart Cap Divider Charger
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT9759 is a high efficiency and high charge current charger.
+  The efficiency is up to 97.8% when VBAT = 4.2V, IBAT = 2.5A and the maximum
+  charge current is up to 8A. The device integrates smart cap divider topology
+  with dual phase charge pump core. The ADCs provide input and output voltage,
+  current and temperature information to monitor the whole charging process.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9759/DS9759-02.pdf
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt9759
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: Battery current sense resistor mounted.
+    default: 2000
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@66 {
+        compatible = "richtek,rt9759";
+        reg = <0x66>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+        shunt-resistor-micro-ohms = <5000>;
+      };
+    };
-- 
2.7.4

