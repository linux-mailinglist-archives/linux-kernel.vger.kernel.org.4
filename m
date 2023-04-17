Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036B86E3ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDQFRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDQFRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:17:48 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3095A173B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 22:17:46 -0700 (PDT)
Date:   Mon, 17 Apr 2023 05:17:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=v4v5elwsenamxmvcu2ko4nipba.protonmail; t=1681708661; x=1681967861;
        bh=eyEEFuJ6J03iyuYUhTw6txWj7lanqGKlF05HL7VvWs4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=aJcnCwLaG0gx0uqeNj4g36x5lutATDQ8idrUUvqscCox/mo1P6LUPMIQEX/owSZzP
         Dw0j9wYpjWBPoQ6D7JiC9xH6GxkggNFn6YzGcidf7L+T4cA4MxuW5AZMY7k11DRp6K
         niHq/QQay5ZagajFEpHbLJd7kn79Zy8JOrnsSJuw5TQS7X1JzZiXOR9ovwM4ualQ4t
         uPehRD8CnhG6kowxeNEMAqO/FQ3LVWhBjmz/rMcg7JhQX8L4I2p1j46VyNItjJapTj
         aX0CE7gv1sD+kP8PAUTKajUvzcaeUbk+raXWlgdK2jkjqHZCaNbwrhSRyH/XjT4Bmn
         cRM8PicrHn4Qw==
To:     hack3r-0m@proton.me
From:   Om Parikh <hack3r-0m@proton.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: watchdog: alphascale-asm9260: convert to DT schema
Message-ID: <20230417051641.3832314-1-hack3r-0m@proton.me>
Feedback-ID: 58440162:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes alphascale-asm9260 dt bindings adhere to the dt json-schema
by replacing txt file with yaml file.

CHANGELOG from v1:
- drop quotes in "$ref" value
- update compatible string from board name to node name
- drop "Olof Johansson" from maintainers
- update "compatible" property from enum to const
- drop generic reset description

Signed-off-by: Om Parikh <hack3r-0m@proton.me>
---
 .../watchdog/alphascale,asm9260-wdt.yaml      | 69 +++++++++++++++++++
 .../bindings/watchdog/alphascale-asm9260.txt  | 35 ----------
 2 files changed, 69 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,a=
sm9260-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-a=
sm9260.txt

diff --git a/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-=
wdt.yaml b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wd=
t.yaml
new file mode 100644
index 000000000000..aefcb0cf3e3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yam=
l
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/alphascale,asm9260-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Alphascale asm9260 Watchdog timer
+
+allOf:
+  - $ref: watchdog.yaml#
+
+maintainers:
+  - Oleksij Rempel <linux@rempel-privat.de>
+
+properties:
+  compatible:
+    const: alphascale,asm9260-wdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: source clock, used for tick counter
+      - description: ahb gate
+
+  clock-names:
+    items:
+      - const: mod
+      - const: ahb
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: wdt_rst
+
+  timeout-sec: true
+
+  alphascale,mode:
+    description: to specify the reset mode of operation
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [hw, sw, debug]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/alphascale,asm9260.h>
+    watchdog0: watchdog@80048000 {
+      compatible =3D "alphascale,asm9260-wdt";
+      reg =3D <0x80048000 0x10>;
+      clocks =3D <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
+      clock-names =3D "mod", "ahb";
+      interrupts =3D <55>;
+      timeout-sec =3D <30>;
+      alphascale,mode =3D "hw";
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.=
txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
deleted file mode 100644
index 75b265a04047..000000000000
--- a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Alphascale asm9260 Watchdog timer
-
-Required properties:
-
-- compatible : should be "alphascale,asm9260-wdt".
-- reg : Specifies base physical address and size of the registers.
-- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
-- clock-names : should be set to
-=09"mod" - source for tick counter.
-=09"ahb" - ahb gate.
-- resets : phandle pointing to the system reset controller with
-=09line index for the watchdog.
-- reset-names : should be set to "wdt_rst".
-
-Optional properties:
-- timeout-sec : shall contain the default watchdog timeout in seconds,
-=09if unset, the default timeout is 30 seconds.
-- alphascale,mode : three modes are supported
-=09"hw" - hw reset (default).
-=09"sw" - sw reset.
-=09"debug" - no action is taken.
-
-Example:
-
-watchdog0: watchdog@80048000 {
-=09compatible =3D "alphascale,asm9260-wdt";
-=09reg =3D <0x80048000 0x10>;
-=09clocks =3D <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
-=09clock-names =3D "mod", "ahb";
-=09interrupts =3D <55>;
-=09resets =3D <&rst WDT_RESET>;
-=09reset-names =3D "wdt_rst";
-=09timeout-sec =3D <30>;
-=09alphascale,mode =3D "hw";
-};
--=20
2.40.0


