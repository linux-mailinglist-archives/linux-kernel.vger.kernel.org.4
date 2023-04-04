Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986276D56AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjDDCVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDDCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:21:52 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE29A1BEC;
        Mon,  3 Apr 2023 19:21:48 -0700 (PDT)
Date:   Tue, 04 Apr 2023 02:21:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1680574906; x=1680834106;
        bh=Qz/nY1nVK+mYxZEsq/SpNw5eBg+A/ANSmY1kTqZoS4M=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ta+OCzSmaZVOhWvRpFwYnfh/qF1s5peeue0eCyOb8ZS/Vt1c5mWag1LUb8k/0FlCi
         v/l2BvzCuNMOyQ9wFBq8d2x2szSxCaHY5HlnCIS+VPpnEN+8X29k5slz4x8fDMqaKB
         4y/hZ/0ku4b9v2rG5sTRT0XP7b1yFUgUOR34t8yqeoh+dj2NbtGEw3RILMstrhq/bR
         SWzHyIylRC/X2ESCKDoiaUQe0/K7RRBCU0y04hgiiyQLe382Ww1xyRtx2kr1pUDJhh
         tSaptBKcucNkn5T54VujgcifvhF984Vp9RvEHZWzX7G2vtkTYi8aBSwZ0jQpSxEJ8g
         knEMFfzPX4Y0A==
To:     Om Parikh <hack3r-0m@proton.me>
From:   Om Parikh <hack3r-0m@proton.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: alphascale-asm9260: convert to DT schema
Message-ID: <20230404022015.754177-1-hack3r-0m@proton.me>
In-Reply-To: <20230403004138.326482-1-hack3r-0m@proton.me>
References: <20230403004138.326482-1-hack3r-0m@proton.me>
Feedback-ID: 58440162:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TO_EQ_FM_DIRECT_MX
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
 .../watchdog/alphascale,asm9260-wdt.yaml      | 73 +++++++++++++++++++
 .../bindings/watchdog/alphascale-asm9260.txt  | 35 ---------
 2 files changed, 73 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,a=
sm9260-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-a=
sm9260.txt

diff --git a/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-=
wdt.yaml b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wd=
t.yaml
new file mode 100644
index 000000000000..ceee5f086e4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yam=
l
@@ -0,0 +1,73 @@
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
+  - Olof Johansson <olof@lixom.net>
+
+properties:
+  compatible:
+    enum:
+      - alphascale,asm9260-wdt
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
+    items:
+      - description: phandle pointing to the system reset controller with =
line
+                     index for the watchdog.
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


