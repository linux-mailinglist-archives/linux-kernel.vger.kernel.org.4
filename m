Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90A62784A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiKNI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiKNI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:57:14 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4671CB0A;
        Mon, 14 Nov 2022 00:57:11 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 940C010000C;
        Mon, 14 Nov 2022 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BikeLvIio/JhCmemxXGK6Tb6BR276xdjdIvpKahReNo=;
        b=YgayJyWyPZfnFptl1bLMKNITwUQ25vhC/3TGcCwAe0psbOYG5CFVBeATP2+0RMaTRlZKLF
        DO7aYXY1gguBDzioOOMQNXgXubUsLA7GpfehuEvb7jQr9TGbT7QsJuz580UzSpC9cPYygJ
        EJtjZozHNpvGkY/kB77Hk2D4UxZJVnY/0JdJ+EIygIZvzDyoAUrTQvNvps79wHlQ/F432C
        dsG1Q1AegM4+zo4ZS1yZmccdeEyEhuc2DPXjb+GE45D3uaXsyOKWpVp6qewgSXaynEv75d
        n7i7NzrlL/7XQIuk72Gkhs0gZ6P/go8nksf2tzDpTv/BHwgE+jiM5/rq+fKOSw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 3/5] dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
Date:   Mon, 14 Nov 2022 09:56:57 +0100
Message-Id: <20221114085659.847611-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114085659.847611-1-miquel.raynal@bootlin.com>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Add a schema for the NVMEM layout on Kontron's sl28 boards.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../nvmem/layouts/kontron,sl28-vpd.yaml       | 62 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
new file mode 100644
index 000000000000..fef795e79c36
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description:
+  The vital product data (VPD) of the sl28 boards contains a serial
+  number and a base MAC address. The actual MAC addresses for the
+  on-board ethernet devices are derived from this base MAC address by
+  adding an offset.
+
+select: false
+
+properties:
+  compatible:
+    const: kontron,sl28-vpd
+
+  serial-number:
+    type: object
+    description: The board's serial number
+
+  base-mac-address:
+    type: object
+    description:
+      Base MAC address for all on-module network interfaces. The first
+      argument of the phandle will be treated as an offset.
+
+    properties:
+      "#nvmem-cell-cells":
+        const: 1
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+      otp-1 {
+          compatible = "user-otp";
+
+          nvmem-layout {
+              compatible = "kontron,sl28-vpd";
+
+              serial_number: serial-number {
+              };
+
+              base_mac_address: base-mac-address {
+                  #nvmem-cell-cells = <1>;
+              };
+          };
+      };
+
+...
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index ecc7c37cbc1f..f64ea2fa362d 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -17,6 +17,9 @@ description: |
   define and might require dynamic reading of the NVMEM device in order to
   perform their parsing. The nvmem-layout container is here to describe these.
 
+oneOf:
+  - $ref: kontron,sl28-vpd.yaml
+
 properties:
   compatible: true
 
-- 
2.34.1

