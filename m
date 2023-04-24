Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F046ECA38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjDXKVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjDXKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:21:05 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD140FB;
        Mon, 24 Apr 2023 03:20:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 9D49D5ED71;
        Mon, 24 Apr 2023 12:36:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-pSFkK2Mm;
        Mon, 24 Apr 2023 12:36:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328960;
        bh=qyIgOCdaAxA/ZmT6JZ72pRqNQLXvT4Bjw+nu8ZCSGLk=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=cji00OIAtPjo/9c1sBW5SB3NHMzdCY0u5pc2PqHE5ymJjgPE/p4wxBGzf53/9Del7
         gV/Lc+k5xLLfAw3Q8poSd2dD0YnSdAyKzkfNvwMnwIOkVCdy5TZ5/TP3XzPVc3fZJz
         PcX5efJxRZNg4xE0W2Z5PoH5t483P48nUmmqXHVM=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/43] dt-bindings: input: Add DT bindings ep93xx keypad
Date:   Mon, 24 Apr 2023 15:34:42 +0300
Message-Id: <20230424123522.18302-27-nikita.shubin@maquefel.me>
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
---

Notes:
    Linus Walleij:
    - replaced hex with proper <KEY_UP>, etc

 .../bindings/input/cirrus,ep93xx-keypad.yaml  | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,ep93xx-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/cirrus,ep93xx-keypad.yaml b/Documentation/devicetree/bindings/input/cirrus,ep93xx-keypad.yaml
new file mode 100644
index 000000000000..0310114de22e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cirrus,ep93xx-keypad.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cirrus,ep93xx-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus ep93xx keypad
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+allOf:
+  - $ref: "/schemas/input/matrix-keymap.yaml#"
+
+description: |
+  The KPP is designed to interface with a keypad matrix with 2-point contact
+  or 3-point contact keys. The KPP is designed to simplify the software task
+  of scanning a keypad matrix. The KPP is capable of detecting, debouncing,
+  and decoding one or multiple keys pressed simultaneously on a keypad.
+
+properties:
+  compatible:
+    enum:
+      - cirrus,ep9301-keypad
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
+  clock-names:
+    enum:
+      - ep93xx-keypad
+
+  debounce:
+    description: |
+          Time in microseconds that key must be pressed or
+          released for state change interrupt to trigger.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  prescale:
+    description: row/column counter pre-scaler load value
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clk-rate:
+    description: clock rate setting
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  disable-3-key:
+    type: boolean
+    description:
+      Disable 3 Key reset. Setting this disables the three key reset
+      output to the watchdog reset block.
+
+  diag-mode:
+    type: boolean
+    description:
+      Key scan diagnostic mode. Setting this allows key scanning to be
+      directly controlled through the key register by writes from the
+      ARM Core.
+
+  back-drive:
+    type: boolean
+    description:
+      Key scan back driving enable. Setting this enables the key
+      scanning logic to back drive the row and column pins of the
+      chip high during the first two column counts in the
+      row/column counter.
+
+  test-mode:
+    type: boolean
+    description:
+      Test mode. When this is set, the counter RC_COUNT is advanced
+      by 8 counts when EN is active. The effect is that only column 0
+      is checked in each row. This test mode allows a faster test
+      of the ROW pins.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
+    #include <dt-bindings/input/input.h>
+    keypad@800f0000 {
+        compatible = "cirrus,ep9301-keypad";
+        reg = <0x800f0000 0x0c>;
+        interrupt-parent = <&vic0>;
+        interrupts = <29>;
+        clocks = <&syscon EP93XX_CLK_KEYPAD>;
+        clock-names = "ep93xx-keypad";
+        pinctrl-names = "default";
+        pinctrl-0 = <&keypad_default_pins>;
+        linux,keymap = <KEY_UP>,
+                       <KEY_DOWN>,
+                       <KEY_VOLUMEDOWN>,
+                       <KEY_HOME>,
+                       <KEY_RIGHT>,
+                       <KEY_LEFT>,
+                       <KEY_ENTER>,
+                       <KEY_VOLUMEUP>,
+                       <KEY_F6>,
+                       <KEY_F8>,
+                       <KEY_F9>,
+                       <KEY_F10>,
+                       <KEY_F1>,
+                       <KEY_F2>,
+                       <KEY_F3>,
+                       <KEY_POWER>;
+    };
+
-- 
2.39.2

