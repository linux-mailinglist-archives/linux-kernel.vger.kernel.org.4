Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57F71924C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjFAFhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjFAFh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:37:26 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA13E4E;
        Wed, 31 May 2023 22:37:01 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id C4C2D60054;
        Thu,  1 Jun 2023 08:36:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OaGNfZvWv8c0-N3OOwoTa;
        Thu, 01 Jun 2023 08:36:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685597819;
        bh=UI5b9rGLSe6LSTTFs3W+D44Mr1cLR1mYJrzowkeGjpc=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Y3Yai3A92De2JQ3w5ZIkXIrF5Lo39zgD6JrHlozv6hMoHfXfBiTsnmb91PBovaLJH
         /q8qz3TgSGbaXvn+3uL7090mOaekERxah3I3mcuLwgNECwtA8TG0JxaYY7MdHbwD6K
         lt2tZso/HueOmSM5ZiM2dV5iYW7BzNjUlk5MGEMk=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/43] dt-bindings: pinctrl: Add Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:33:57 +0300
Message-Id: <20230601053546.9574-7-nikita.shubin@maquefel.me>
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

Add YAML bindings for ep93xx SoC pinctrl.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Notes:
    v0 -> v1:
    
    Krzysztof Kozlowski:
    - removed wildcards
    - use fallback compatible and list all possible compatibles
    - fix ident
    - dropped bindings in title

 .../pinctrl/cirrus,ep9301-pinctrl.yaml        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
new file mode 100644
index 000000000000..ff7b30a11bab
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/cirrus,ep9301-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus ep93xx pins mux controller
+
+maintainers:
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-pinctrl
+      - items:
+          - enum:
+              - cirrus,ep9302-pinctrl
+              - cirrus,ep9307-pinctrl
+              - cirrus,ep9312-pinctrl
+              - cirrus,ep9315-pinctrl
+          - const: cirrus,ep9301-pinctrl
+
+patternProperties:
+  '^pins-':
+    type: object
+    description: pin node
+    $ref: pinmux-node.yaml#
+
+    properties:
+      function:
+        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio ]
+      groups:
+        minItems: 1
+        maxItems: 2
+        items:
+          enum: [ ssp, ac97, i2s_on_ssp, i2s_on_ac97, pwm1, gpio1agrp,
+                  gpio2agrp, gpio3agrp, gpio4agrp, gpio6agrp, gpio7agrp,
+                  rasteronsdram0grp, rasteronsdram3grp, keypadgrp, idegrp]
+
+    required:
+      - function
+      - groups
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@80930000 {
+      compatible = "cirrus,ep9301-syscon",
+                  "syscon", "simple-mfd";
+      reg = <0x80930000 0x1000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      pinctrl {
+        compatible = "cirrus,ep9312-pinctrl", "cirrus,ep9301-pinctrl";
+        spi_default_pins: pins-spi {
+          function = "spi";
+          groups = "ssp";
+        };
+      };
+    };
-- 
2.37.4

