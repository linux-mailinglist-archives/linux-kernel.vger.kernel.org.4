Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCFB71928E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjFAFqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjFAFqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:33 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 22:46:16 PDT
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798B813E;
        Wed, 31 May 2023 22:46:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id BDDD246CCD;
        Thu,  1 Jun 2023 08:46:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-kvQTlySg;
        Thu, 01 Jun 2023 08:46:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598374;
        bh=HA7oFSENkffqTFoqLZaGhaCPiEmPYmrd6eret2C2pWE=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ZoaPv1W1N57wNyCfJtxkTOYMEVVFNMqdDRfLjDwwKPuYIWJPC8HIpGAIyUPKFJkoE
         FLos543TQIlWhM2sNQ2KFg+9Ur6bTdQ/Mioh3VAvW8oC5TgWpuCet1kwEy2Z8ipX12
         1zQ6H1aTMabvZLArYO5UKuiMsRiM5km9Nfa1m/Qw=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 27/43] dt-bindings: input: Add Cirrus EP93xx keypad
Date:   Thu,  1 Jun 2023 08:45:32 +0300
Message-Id: <20230601054549.10843-9-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings for ep93xx SoC keypad.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    - remove almost all but debounce-delay-ms and prescale
    - s/ep9301-keypad/ep9307-keypad/ it's actually only for
      ep9307, ep9312, ep9315
    
    Krzysztof Kozlowski:
    - renamed file
    - changed maintainers
    - dropped quotes
    - dropped clock-names
    - use fallback compatible and list all possible compatibles
    - fix ident

 .../bindings/input/cirrus,ep9307-keypad.yaml  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml b/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
new file mode 100644
index 000000000000..c7eb10a84a6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cirrus,ep9307-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus ep93xx keypad
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+allOf:
+  - $ref: /schemas/input/matrix-keymap.yaml#
+
+description: |
+  The KPP is designed to interface with a keypad matrix with 2-point contact
+  or 3-point contact keys. The KPP is designed to simplify the software task
+  of scanning a keypad matrix. The KPP is capable of detecting, debouncing,
+  and decoding one or multiple keys pressed simultaneously on a keypad.
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9307-keypad
+      - items:
+          - enum:
+              - cirrus,ep9312-keypad
+              - cirrus,ep9315-keypad
+          - const: cirrus,ep9307-keypad
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
+  cirrus,debounce-delay-ms:
+    description: |
+          Time in microseconds that key must be pressed or
+          released for state change interrupt to trigger.
+
+  cirrus,prescale:
+    description: row/column counter pre-scaler load value
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
+    #include <dt-bindings/input/input.h>
+    keypad@800f0000 {
+      compatible = "cirrus,ep9301-keypad";
+      reg = <0x800f0000 0x0c>;
+      interrupt-parent = <&vic0>;
+      interrupts = <29>;
+      clocks = <&syscon EP93XX_CLK_KEYPAD>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&keypad_default_pins>;
+      linux,keymap = <KEY_UP>,
+                     <KEY_DOWN>,
+                     <KEY_VOLUMEDOWN>,
+                     <KEY_HOME>,
+                     <KEY_RIGHT>,
+                     <KEY_LEFT>,
+                     <KEY_ENTER>,
+                     <KEY_VOLUMEUP>,
+                     <KEY_F6>,
+                     <KEY_F8>,
+                     <KEY_F9>,
+                     <KEY_F10>,
+                     <KEY_F1>,
+                     <KEY_F2>,
+                     <KEY_F3>,
+                     <KEY_POWER>;
+    };
-- 
2.37.4

