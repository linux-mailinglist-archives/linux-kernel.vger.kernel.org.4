Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58111719249
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjFAFhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjFAFhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:37:17 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284561BE;
        Wed, 31 May 2023 22:36:58 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id CA60F600FB;
        Thu,  1 Jun 2023 08:36:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OaGNfZvWv8c0-ljXORRHt;
        Thu, 01 Jun 2023 08:36:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685597815;
        bh=zIJEhcZ91Oaqa6Xmm24KHPdM/EoDuW4yx6hKsFtUgXw=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=idlakvnNspTx/hhaf1scWcevr+yryNuzxvfQEdwBri6tBVlLw8q+i9LEJ1rFbfXvP
         VWI3pcacmkyMJkSqi/yJkfrLllDi5wFiXPRLIMULIdz65wwmZs9VcAPSI4UFrQwtci
         G1/yTh1J1qbmJd19/0fmpteYQn9kNbb3rkCQXuq8=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/43] dt-bindings: clock: Add Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:33:55 +0300
Message-Id: <20230601053546.9574-5-nikita.shubin@maquefel.me>
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

This adds device tree bindings for the Cirrus Logic EP93xx
clock block used in these SoCs.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    - it's now a clock controller

 .../bindings/clock/cirrus,ep9301.yaml         | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml

diff --git a/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml b/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml
new file mode 100644
index 000000000000..4f9e0d483698
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/cirrus,ep9301.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic ep93xx SoC's clock controller
+
+maintainers:
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+description: |
+  Cirrus Logic EP93XX SoC clocks driver bindings. The clock
+  controller node must be defined as a child node of the ep93xx
+  system controller node.
+
+  See also:
+  - dt-bindings/clock/cirrus,ep93xx-clock.h
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-clk
+      - items:
+          - enum:
+              - cirrus,ep9302-clk
+              - cirrus,ep9307-clk
+              - cirrus,ep9312-clk
+              - cirrus,ep9315-clk
+          - const: cirrus,ep9301-clk
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    description: List of clock specifiers which are external input
+      clocks to the given clock controller.
+    items:
+      - description: reference clock
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    clocks {
+      xtali: oscillator {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <14745600>;
+      };
+    };
+
+    clock-controller {
+      #clock-cells = <1>;
+      compatible = "cirrus,ep9301-clk";
+      clocks = <&xtali>;
+    };
+...
-- 
2.37.4

