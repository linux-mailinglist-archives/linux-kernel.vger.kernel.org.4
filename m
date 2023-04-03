Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76C66D3B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 02:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjDCAnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 20:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDCAnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 20:43:04 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02335BBB;
        Sun,  2 Apr 2023 17:43:01 -0700 (PDT)
Date:   Mon, 03 Apr 2023 00:42:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1680482576; x=1680741776;
        bh=GrH4LNncTeaHJC9oMAUJWv4wtKVY6Ir+P33KCx8nHxo=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=eGOi9cvjkJlbWuY7XyTzX+u/CatWgG+3NuxKGBy2Ko2+Mz/O0sPl/gg3mn2wF5t4V
         xt1+s/+in+vsyxyCSiUp8ot8eu5EU+QXZI+1y+jqvkPlg9Q3nNpZU8AbHbKKRfKhWs
         d76Tc/xcBL0l5OsYG0l/mf/6Z+/e3JSgBoByxrW/rqee3BAMI0uCmk6RLTN3e8Sf54
         LiTMaYnQUtVzkE9Z8izqEuLTyuizTNECUoYZqMTlxvKDgR+GAB1pJeiHRsgTGWYN2v
         1cU2g6WGUJ1d1I024EwUmt+BO+CAkwZ82JKY7stPA4+rpebgCbAWKjX5G5HKULsTMR
         Nvnd3OWBIcwBQ==
To:     daniel.baluta@nxp.com
From:   Om Parikh <hack3r-0m@proton.me>
Cc:     hack3r-0m@proton.me, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: alphascale-asm9260: convert to DT schema
Message-ID: <20230403004138.326482-1-hack3r-0m@proton.me>
Feedback-ID: 58440162:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch replaces the txt file and adds YAML bindings file
adhering to the json-schema for alphascale-asm9260. It is a
demo patch for potential further contributions to the GSOC
project.

(see: https://wiki.linuxfoundation.org/gsoc/2023-gsoc-device-tree-bindings)

Signed-off-by: Om Parikh <hack3r-0m@proton.me>
---
 .../watchdog/alphascale,asm9260-wdt.yaml      | 76 +++++++++++++++++++
 .../bindings/watchdog/alphascale-asm9260.txt  | 35 ---------
 2 files changed, 76 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,a=
sm9260-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-a=
sm9260.txt

diff --git a/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-=
wdt.yaml b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wd=
t.yaml
new file mode 100644
index 000000000000..1f7baaf6b0f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yam=
l
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/alphascale,asm9260-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Alphascale asm9260 Watchdog timer
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Oleksij Rempel <linux@rempel-privat.de>
+  - Olof Johansson <olof@lixom.net>
+
+properties:
+  compatible:
+    enum:
+      - alphascale,asm9260
+      - alphascale,asm9260devkit
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
+  - resets
+  - reset-names
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


