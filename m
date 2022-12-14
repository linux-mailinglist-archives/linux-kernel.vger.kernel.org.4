Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5589464D24A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLNWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLNWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:20:30 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E2545EDA;
        Wed, 14 Dec 2022 14:20:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bx10so1340802wrb.0;
        Wed, 14 Dec 2022 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f08SdDPxY3s7apm0pW8UKA50CDY6FJL0VeamqVNi2UA=;
        b=Yjc45udOXyFthyeieoMF0iG5GxAXVAOAm3WA9qfLuCaeCLmKptSOjG58ePgvuGXpi9
         DWoQX4TPN2WILUT4d2fTwYi1ed4dWBz9Ime0tX4MGrTOhrIvaNDwfZH0zreHeBohxqsA
         aELRE8ls53U/xplxi7975YKZmQEsTykJopLLo2rjTBulTcqufV8dfOXu34eRKyqLH+bO
         yJKCWjl07uU+W9J/t0h9yH1bvUEkEfkwMdbOpTdtnH8pDbgfjPEftMq1F+65w0+/xmxF
         93NV2qY1VGm5VwirQ0F6VCYhFUFp5Zr5gAbiZ4TsyjFcHlvO2l8AgdOM9Fv53RBal+61
         aVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f08SdDPxY3s7apm0pW8UKA50CDY6FJL0VeamqVNi2UA=;
        b=lMKSd0J8kEtdsaFDGG5b9mZmJ8QUrwszllqN5R6iAjw0xtxSXqovoHsL+VgC5parV4
         aNOgIaYv35kmVYM03eXVkMfRjbA+a8yU+g3vVIjMO7OOF6YiDqDEsz6N8lqSawc4m8rC
         nKXPuE1+noO73mCa9KjdRm4avvgVw41uzAEaUIsAAk9RjFAcWpJYj6sJZJA3+uywueJo
         Pbw4cEucnvLb8Suv7/58XykretQ8TknfLy4rW9YEUZZnUCc8lrkvtFxiJXyRl9ootUeZ
         wb4zUCSHXAk3KgJhvLJB1r3VbEXVluiPjSA++tIBCJoYjaA18LWGlEQHJNnFvD2lavQd
         TryQ==
X-Gm-Message-State: ANoB5pnSvV6D7iKX+oLOd67ac2ctNckBFdIgb1fZr8x4v8LqLIOk0QlK
        1ITA1flVlTu15gdfiBZf3ZkAL4XNdwFOrA==
X-Google-Smtp-Source: AA0mqf7HYjkDNlcQozVgR36OzLerd5FB4x0I+KKgj+etRfLwfqEbTkYMiL6WxHZlYFmXFQhdZ2aIZQ==
X-Received: by 2002:adf:a45b:0:b0:242:64fd:3e05 with SMTP id e27-20020adfa45b000000b0024264fd3e05mr15823475wra.53.1671056427012;
        Wed, 14 Dec 2022 14:20:27 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id k17-20020adfb351000000b002423edd7e50sm4208950wrd.32.2022.12.14.14.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 14:20:26 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc description
Date:   Wed, 14 Dec 2022 23:20:23 +0100
Message-Id: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' ADC
block.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 .../bindings/iio/adc/cirrus,ep9301-adc.yaml   | 58 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
new file mode 100644
index 000000000000..d0fd24d1be04
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/cirrus,ep9301-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP930x internal ADC
+
+description: |
+  Cirrus Logic EP9301/EP9302 SoCs' internal ADC block.
+
+  User's manual:
+  https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    const: cirrus,ep9301-adc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ep93xx-adc
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        adc: adc@80900000 {
+            compatible = "cirrus,ep9301-adc";
+            reg = <0x80900000 0x28>;
+            clocks = <&syscon EP93XX_CLK_ADC>;
+            clock-names = "ep93xx-adc";
+            interrupt-parent = <&vic1>;
+            interrupts = <30>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 69565ac0c224..4a914d5bc2e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2027,8 +2027,10 @@ M:	Hartley Sweeten <hsweeten@visionengravers.com>
 M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
 F:	arch/arm/mach-ep93xx/
 F:	arch/arm/mach-ep93xx/include/mach/
+F:	drivers/iio/adc/ep93xx_adc.c
 
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
-- 
2.37.3

