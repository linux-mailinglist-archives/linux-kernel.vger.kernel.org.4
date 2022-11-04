Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA80619D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiKDQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKDQin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:38:43 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274A2E68D;
        Fri,  4 Nov 2022 09:38:41 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A56A1C000B;
        Fri,  4 Nov 2022 16:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667579920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtjRswIOq8noqd9T3XKP6UUSDNZ484aVeWXhWlQj5Cs=;
        b=p1J6hSqAhkTv59g/d0BIgGxxVHpofbNs2lVIn2nCagcL/uWYUDqIO0eSmjU912RG2wgJAA
        mVAlBBZu9SlYZw6KbGVC8aMokv9TzDSGGR7SfRBMrQAQ4y16iX9I4wWhhCpwbrp/GVOwBL
        UcMMgMdZzfIKEGdVt4BiwHIPdTBCE8+pt7cv7G0u++8YH0/SCjr9mPUIRKWpZXkni6pcd7
        Md9qw/f8VMxu/xPnFW/wJdHDgSotzeS28T4VwzhlPlTfadEbz2cWEXUggkTKADxegWHNM0
        oyE71p0GFGYtWctGeaV3ynCiEtSFqaU8z2GmMJ1cMby5ZEYnz2HRhfyaxtJxjw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 4/6] dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
Date:   Fri,  4 Nov 2022 17:38:31 +0100
Message-Id: <20221104163833.1289857-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../nvmem/layouts/kontron,sl28-vpd.yaml       | 60 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
new file mode 100644
index 000000000000..44088c8b4153
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
@@ -0,0 +1,60 @@
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

