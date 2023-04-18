Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5D6E586D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDRFQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDRFQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:16:30 -0400
X-Greylist: delayed 86323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 22:16:27 PDT
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26340E5;
        Mon, 17 Apr 2023 22:16:27 -0700 (PDT)
Date:   Tue, 18 Apr 2023 05:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1681794985; x=1682054185;
        bh=+w7z3alPLwzNkvvn0KLBZKtp9RjVXYgSCWgZ1BS3+8I=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Khq572Bk4K5UafoQEWcO8lCaHSfx0kzISL94FuV8E0Aei94bwWqFWAuLvy4mvQFwz
         rfFYyeSiQy6rjFWByzMUk9bL9hjxM49uoQn3g2AqXDUf3wl0aCum9obVSijzsKT6b6
         WhtlyERSHCW6H8AlVpOoFacuOMasSLQ1sSPyL8K7hnyAPBGz0Ro2nVpZeIGZ4TXRoX
         48bhZDm0hTqb16D8egF2SgLjdNOE8dWV1j93TDYTY6MkpszP0kHOJO+iMeEBFu26yv
         uVx48JVYooaRSxzVEOePMYJonc96BjkzkCsr0JL7ZxVrLbgPJjvB9tlYkB+OyvLNri
         9X+umVSiOelAA==
To:     hack3r-0m@proton.me
From:   Om Parikh <hack3r-0m@proton.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: watchdog: alphascale-asm9260: convert to DT schema
Message-ID: <20230418051446.24288-1-hack3r-0m@proton.me>
Feedback-ID: 58440162:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes alphascale-asm9260 dt bindings adhere to the dt json-schema
by replacing txt file with yaml file.

Signed-off-by: Om Parikh <hack3r-0m@proton.me>
---
 v1 -> v2:
  - drop quotes in "$ref" value
  - update compatible string from board name to node name
  - drop "Olof Johansson" from maintainers
  - update "compatible" property from enum to const
  - drop generic reset description

 v2 -> v3:
  - drop timeout-sec property
  - update description for mode property
  - set default as "hw" for mode enum

 .../watchdog/alphascale,asm9260-wdt.yaml      | 70 +++++++++++++++++++
 .../bindings/watchdog/alphascale-asm9260.txt  | 35 ----------
 2 files changed, 70 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,a=
sm9260-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-a=
sm9260.txt

diff --git a/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-=
wdt.yaml b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wd=
t.yaml
new file mode 100644
index 000000000000..fea84f5b7e6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yam=
l
@@ -0,0 +1,70 @@
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
+  alphascale,mode:
+    description: |
+      Specifies the reset mode of operation. If set to sw, then reset is h=
andled
+      via interrupt request, if set to debug, then it does nothing and log=
s.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [hw, sw, debug]
+    default: hw
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
--
2.40.0


