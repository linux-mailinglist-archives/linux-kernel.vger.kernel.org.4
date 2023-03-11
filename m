Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF06B586C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCKFLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCKFLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:11:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FBD12B030;
        Fri, 10 Mar 2023 21:11:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762F4604AD;
        Sat, 11 Mar 2023 05:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C58BDC4339B;
        Sat, 11 Mar 2023 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678511472;
        bh=fNduKqqPUYV6F1M5u00Pcrdw5zzaBtWuks1TRf+NJ/0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=MaYyq6u2q4gTzLUWNR3uMcuvUFZiuEYyMbNk3ALY2JtmjHZatv/lDQMKqfj5D/MCp
         gdGEuOoQ9EkbqUVZefKdWoxuqvRBzYNHZJwKTd7hJtEbk7yTBJOkOlw6++I7Fb6Vgr
         YLwEoJ242X49lpSBvkkff25hYtkbpWjXuKaMUh7clsnK800cAfoxWrhxxiqzQi/Kv8
         VXJGbQxip0np7JXmVqdX/9Hh4cSis42yKqar4PbddROlT/7BNsWkybJmLX3DGgvPov
         Oh7zDqXbe85N3EYSXuU86cTz/KLxih2jhDxQDcBlzkS4QHcGit7mF+cDsYMzYezhT8
         ulcbI2p8sSBPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4BC74A44;
        Sat, 11 Mar 2023 05:11:12 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Sat, 11 Mar 2023 06:11:09 +0100
Subject: [PATCH v9 1/5] dt-bindings: pwm: Add Apple PWM controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-fpwm-v9-1-dbe26bccabd6@gmail.com>
References: <20230214-fpwm-v9-0-dbe26bccabd6@gmail.com>
In-Reply-To: <20230214-fpwm-v9-0-dbe26bccabd6@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678511469; l=1759;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=BeW75+AIFJcFrpFjOZabHWBRDLlSvckpqesK7uzTCx4=;
 b=sOhmmuQHIeKoSPIoyCT8Va7evoPNn7FIXJb4GEDaRyfcSgJp265hMnPNXMu6c3bmDL+FpFlc7
 Owlr5oiX8mzBiak04U4IgVOsWtPXuN8eVMwI3xR0JL70x/wvhEUw0B8
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Apple SoCs such as the M1 contain a PWM controller used
among other things to control the keyboard backlight.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
new file mode 100644
index 000000000000..142157bff0cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/apple,s5l-fpwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple FPWM controller
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: PWM controller used for keyboard backlight on ARM Macs
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-fpwm
+          - apple,t6000-fpwm
+          - apple,t8112-fpwm
+      - const: apple,s5l-fpwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@235044000 {
+      compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
+      reg = <0x35044000 0x4000>;
+      power-domains = <&ps_fpwm1>;
+      clocks = <&clkref>;
+      #pwm-cells = <2>;
+    };

-- 
Git-137.1)

