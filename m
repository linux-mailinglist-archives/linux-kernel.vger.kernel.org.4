Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B0267C63A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjAZIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjAZIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:52:04 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180F42DFB;
        Thu, 26 Jan 2023 00:51:59 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id F3E154002B;
        Thu, 26 Jan 2023 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674723117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwaqQPmDrUKIdm5l0Y0T3RW2RQ9pM+xGeQ1lgAnxQdA=;
        b=jxLMyMusKlBXvqCmu9XxAxS948BQ9GUDnzY1A7HSXSYLqUI1hkQgY3aitj5VbYNejxadg9
        tIlwR6KBprkHi0HhtChoX2d6xy+ASxakMvdgEN4F5512YT3nBVsSuV0qBul6h2ZpcYfI8b
        go5y1nZit9aGlkgW6t60ivNYqSyvmnWcytvBKbalfQRL/z6cIaYBumX58iV2YY6mjas2nb
        yxPsCg83ehXlyu+oMjm9gxYulh1WLHL8m2ihoHeuHDDwXgJnreS2xolxJhkbfs7CVJJZq2
        n55Tcv4kTau7gAIuuF2hf6T20nj1fYbkmUqDpWJZVYBIS9TEJwtV27amKPcQaQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: sound: Add Renesas IDT821034 codec
Date:   Thu, 26 Jan 2023 09:51:35 +0100
Message-Id: <20230126085137.375814-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126085137.375814-1-herve.codina@bootlin.com>
References: <20230126085137.375814-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas IDT821034 codec is a quad PCM codec with programmable
gain.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/renesas,idt821034.yaml     | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,idt821034.yaml

diff --git a/Documentation/devicetree/bindings/sound/renesas,idt821034.yaml b/Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
new file mode 100644
index 000000000000..a2b92dba5529
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/renesas,idt821034.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas IDT821034 codec device
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The IDT821034 codec is a four channel PCM codec with onchip filters and
+  programmable gain setting.
+
+  The time-slots used by the codec must be set and so, the properties
+  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
+  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node for
+  sub-nodes that involve the codec. The codec uses one 8bit time-slot per
+  channel.
+  'dai-tdm-tdm-slot-with' must be set to 8.
+
+  The IDT821034 codec also supports 5 gpios (SLIC signals) per channel.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: renesas,idt821034
+
+  reg:
+    description:
+      SPI device address.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 8192000
+
+  spi-cpha: true
+
+  '#sound-dai-cells':
+    const: 0
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - '#sound-dai-cells'
+  - gpio-controller
+  - '#gpio-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@0 {
+            compatible = "renesas,idt821034";
+            reg = <0>;
+            spi-max-frequency = <8192000>;
+            spi-cpha;
+            #sound-dai-cells = <0>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.39.0

