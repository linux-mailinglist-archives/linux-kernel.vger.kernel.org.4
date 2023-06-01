Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA89F719289
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjFAFqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFAFqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:10 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C200139;
        Wed, 31 May 2023 22:46:03 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 1C91A46CE9;
        Thu,  1 Jun 2023 08:46:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-VwQCQDbN;
        Thu, 01 Jun 2023 08:46:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598361;
        bh=GdyoiL3hVIM28KbzlgDxlhFIddktjtk7MSpa7eYVBM0=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=iuhtd5NKMWFW2QpY6pNwwZ8wYZgt30gFFJRuQ8WGcppZFyvFJx02OyjiWUpJtE5cY
         uaU5P/lyrYML/xNoIDWqUT6c3XwUiEYR3sUuF3BsppgBDmb/up3vrWXsRt+c3hwfcM
         xn8NLtFoIUslKlZmt7+uNon0zcczu0rW3MyECWnU=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 23/43] dt-bindings: mtd: Add ts7250 nand-controller
Date:   Thu,  1 Jun 2023 08:45:28 +0300
Message-Id: <20230601054549.10843-5-nikita.shubin@maquefel.me>
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

Add YAML bindings for ts7250 NAND Controller.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    make it a nand contoller

 .../bindings/mtd/technologic,nand.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/technologic,nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
new file mode 100644
index 000000000000..26d1d9c3331d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems NAND controller
+
+maintainers:
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: nand-controller.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - const: technologic,ts7200-nand
+      - items:
+          - enum:
+              - technologic,ts7300-nand
+              - technologic,ts7260-nand
+              - technologic,ts7250-nand
+          - const: technologic,ts7200-nand
+
+  reg:
+    maxItems: 1
+
+  '#address-cells': true
+  '#size-cells': true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: true
+
+examples:
+  - |
+    nand-controller@60000000 {
+      compatible = "technologic,ts7200-nand";
+      reg = <0x60000000 0x8000000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+
+...
-- 
2.37.4

