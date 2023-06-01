Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907EE71926B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjFAFjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjFAFj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:39:26 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D71717;
        Wed, 31 May 2023 22:38:36 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 86BCF6003B;
        Thu,  1 Jun 2023 08:37:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OaGNfZvWv8c0-HGdKrmol;
        Thu, 01 Jun 2023 08:37:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685597837;
        bh=MVrfFhDDrzP+QZ7AKJkzp8cNrCZ+hvwz6QWWmxQNar0=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=DJFo/I2fNChDDfRzST21CjxcKfb4LS5XQ1cSS5uw6T32cKkAvmFsPl2ixOz8y5qvu
         /FAKYFKIbPTarwSqkk9Jy6PD219xLzGgNeS3iRCwRPOYbdv2FgnAOEiT9/iDRtSdR2
         xQuZBBxsv6TpYBuH5lXtRWtaWrXSDJsWq0Ayep4E=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 17/43] dt-bindings: spi: Add Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:34:08 +0300
Message-Id: <20230601053546.9574-18-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings for ep93xx SoC SPI.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    Krzysztof Kozlowski:
    - replaced maintainers
    - removed wildcards
    - use fallback compatible and list all possible compatibles
    - drop quotes in ref
    - dropped "clock-names"
    - dropped label
    - fix ident

 .../devicetree/bindings/spi/spi-ep9301.yaml   | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-ep9301.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-ep9301.yaml b/Documentation/devicetree/bindings/spi/spi-ep9301.yaml
new file mode 100644
index 000000000000..c363b25a3074
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-ep9301.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-ep9301.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EP93xx SoC SPI controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-spi
+      - items:
+          - enum:
+              - cirrus,ep9302-spi
+              - cirrus,ep9307-spi
+              - cirrus,ep9312-spi
+              - cirrus,ep9315-spi
+          - const: cirrus,ep9301-spi
+
+  reg:
+    items:
+      - description: SPI registers region
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI Controller reference clock source
+
+  cs-gpios: true
+
+  cirrus,ep9301-use-dma:
+    description: Flag indicating that the SPI should use dma
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
+    spi@808a0000 {
+      compatible = "cirrus,ep9301-spi";
+      reg = <0x808a0000 0x18>;
+      interrupt-parent = <&vic1>;
+      interrupts = <21>;
+      clocks = <&syscon EP93XX_CLK_SPI>;
+      cs-gpios = <&gpio5 2 0>;
+      cirrus,ep9301-use-dma;
+    };
+
+...
-- 
2.37.4

