Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF716ECA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjDXKUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjDXKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:40 -0400
X-Greylist: delayed 2706 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 03:20:38 PDT
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224719B3;
        Mon, 24 Apr 2023 03:20:38 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 7117B5E6FB;
        Mon, 24 Apr 2023 12:35:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-hYJwwRUe;
        Mon, 24 Apr 2023 12:35:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328937;
        bh=LuvwFxFGRS5iNfT4J+WUehyL2rZj86DmXsjlr5Rkiuo=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=odwNcFIKvpgD7Mxs61sPi/mM0t5sONtn8X+zNZFoC++6LweyKj1K0ogUCqcp7G4DB
         MzgAu4cBnHr7FWS8qEq4FTsMtOG9R9JjeljUMwPy2cX/EV6XVN2P/40L1sViD/JHuX
         +8Ap7ni0mGO63qd1SeqIylq2dbUz3UlKA/vu1nIw=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/43] dt-bindings: pinctrl: Add DT bindings ep93xx pinctrl
Date:   Mon, 24 Apr 2023 15:34:19 +0300
Message-Id: <20230424123522.18302-4-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings ep93xx SoC.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Notes:
    rfc->v0:
    - dropped separate bindings description, left only one with all groups,
      functions and etc...
    - added Alexander Sverdlin to maintainers
    - added Linus Reviwed-by tags, through i shoudn't =) too many changes
    - fixed warning and added seq_file header

 .../pinctrl/cirrus,ep93xx-pinctrl.yaml        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml
new file mode 100644
index 000000000000..cba4be7c5994
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/cirrus,ep93xx-pinctrl.yaml#
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
+    enum:
+      - cirrus,ep9301-pinctrl
+      - cirrus,ep9307-pinctrl
+      - cirrus,ep9312-pinctrl
+  regmap:
+    description: phandle to syscon
+
+patternProperties:
+  '^pinctrl-':
+    type: object
+    description: pin node
+    $ref: pinmux-node.yaml#
+
+    properties:
+      function:
+        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio1, gpio2, gpio3,
+                gpio4, gpio6, gpio7 ]
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
+  - regmap
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon: syscon@80930000 {
+        compatible = "cirrus,ep9301-syscon",
+                     "syscon", "simple-mfd";
+        reg = <0x80930000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        pinctrl: pinctrl {
+                compatible = "cirrus,ep9312-pinctrl";
+                regmap = <&syscon>;
+                spi_default_pins: pinctrl-spi {
+                        function = "spi";
+                        groups = "ssp";
+                };
+        };
+    };
-- 
2.39.2

