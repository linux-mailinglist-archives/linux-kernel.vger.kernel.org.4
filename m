Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0736ECA28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjDXKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjDXKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:42 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3AD1FEE;
        Mon, 24 Apr 2023 03:20:41 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 472855ECEC;
        Mon, 24 Apr 2023 12:35:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-2xt778SJ;
        Mon, 24 Apr 2023 12:35:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328954;
        bh=gzZfNhCP4gLQxuxIz1zy8IGUwOFk5Um/gkdDTo4axVY=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=caqZCqDLVch5A8ypmNCfIAMmaENWkpVFbRauIda656kQ6KQThwDcE991Cawuw51ul
         AbXrWBNhpvkR7BsGW5b5ohmYThfKk4TDk4Qf5/3xZSL33tgiLyM+HtmaSe+33VREX1
         /DbEUmHjj35NZzYFsT+cb1Zyn1hbCY231hA3Dpxg=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lukasz Majewski <lukma@denx.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/43] dt-bindings: mtd: add DT bindings for ts7250 nand
Date:   Mon, 24 Apr 2023 15:34:38 +0300
Message-Id: <20230424123522.18302-23-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings for ts7250 NAND.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/mtd/technologic,nand.yaml        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/technologic,nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
new file mode 100644
index 000000000000..3234d93a1c21
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems NAND controller
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+properties:
+  compatible:
+    items:
+      - const: technologic,ts7200-nand
+      - const: gen_nand
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
+    nand-parts@0 {
+      compatible = "technologic,ts7200-nand", "gen_nand";
+      reg = <0x60000000 0x8000000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      partition@0 {
+        label = "TS-BOOTROM";
+        reg = <0x00000000 0x00020000>;
+        read-only;
+      };
+
+      partition@20000 {
+        label = "Linux";
+        reg = <0x00020000 0x07d00000>;
+      };
+
+      partition@7d20000 {
+        label = "RedBoot";
+        reg = <0x07d20000 0x002e0000>;
+        read-only;
+      };
+    };
+
+...
-- 
2.39.2

