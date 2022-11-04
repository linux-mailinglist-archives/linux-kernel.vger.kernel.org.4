Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB89619D77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKDQis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiKDQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:38:40 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810E82EF5E;
        Fri,  4 Nov 2022 09:38:39 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 389D9C000D;
        Fri,  4 Nov 2022 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667579918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4AM4lnV2gTii8655Tt65FHVrgfOcRYc0nYRGkNgVIU=;
        b=DqU/oCr8N0GTdjVft/L1DgvUTSld6b0y64b8fQwnjGFy4ty36q1VizpqfgH8oBFVCM9NwR
        GsrZSdlkvQ2faePej+qjegC+om6gU7PLqW1G6A5KTvMJ0d+/07IopJ7Z1Mh0tPJ89vVGMA
        Wbi28EL8rEVDAZslj4WTUlWB/DlN16zZmJXKmVJuMOe/avytQvVXqZceK/Z2YzRv9ptz6x
        7Jc0YNHtAVbRYKpH1QRJKTYi3tA1EArKHtGFuub6K1I3Rz8eqI6mh7ywdPsT4ztzvlLX9D
        WnIVmCSbS+wRa1B5gQnPnz1uuMKDcSfjokG7XP8B155cS1WVbZewbkEiB3vKJw==
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
Subject: [PATCH v3 2/6] dt-bindings: nvmem: Introduce the nvmem-layout container
Date:   Fri,  4 Nov 2022 17:38:29 +0100
Message-Id: <20221104163833.1289857-3-miquel.raynal@bootlin.com>
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

The nvmem devices description works like this:

* Most cases (EEPROM & co):

eeprom@x {
	 compatible = "<eeprom-compatible>";
	 ...
};

* MTD case:

flash@y {
	compatible = "<flash-compatible>";
	...
	otp {
		compatible = "user-otp"; /* or "factory-otp" */
		...
	};
};

In the former case, the nvmem device is "eeprom@x", while in the latter
case the nvmem device is "otp".

Nvmem devices can produce nvmem cells. The current way to describe nvmem
cells is to locate them by providing their static byte and bit offset
and length. These information are stored in subnodes of the nvmem
device.

It is now a fact that such description does not fit more advanced use
cases where the location or the size of the cells may vary. There are
currently three known situations which require being described
differently: Kontron's SL28 VPD, ONIE's TLV table and U-Boot's
environment variables.

Hence, we need a way to describe the parsers that must be used in order
to make the dynamic discovery of the nvmem cells. This new description
must fit both use cases (the generic situation and the MTD case).

Let's create in both cases a container node named nvmem-layout whose
content will depend on the parser. Right now nvmem-layout.yaml is
"empty", but references to additional layout parser bindings will be
inserted in the near future. The final goal being something that looks
like:

* Most cases (EEPROM & co):

eeprom@x {
	compatible = "<eeprom-compatible>";
	...
	nvmem-layout {
		compatible = "<parser-compatible>";
		...
	};
};

* MTD case:

flash@y {
	compatible = "<flash-compatible>";
	...
	otp {
		compatible = "user-otp"; /* or "factory-otp" */
		...
		nvmem-layout {
			compatible = "<parser-compatible>";
			...
		};
	};
};

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/nvmem/layouts/nvmem-layout.yaml  | 30 +++++++++++++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  7 +++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
new file mode 100644
index 000000000000..ecc7c37cbc1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/nvmem-layout.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM (Non Volatile Memory) layouts
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+  - Michael Walle <michael@walle.cc>
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+description: |
+  Most NVMEM layouts are static and thus do not require additional description
+  besides the bytes/bits offset and length. Other layouts can be less statically
+  define and might require dynamic reading of the NVMEM device in order to
+  perform their parsing. The nvmem-layout container is here to describe these.
+
+properties:
+  compatible: true
+
+  '#address-cells': false
+
+  '#size-cells': false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 0455506fc30f..75bb93dda9df 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -39,6 +39,13 @@ properties:
       when it's driven low (logical '0') to allow writing.
     maxItems: 1
 
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+    description:
+      Alternative to the statically defined nvmem cells, this
+      container may reference more advanced (dynamic) layout
+      parsers.
+
 patternProperties:
   "@[0-9a-f]+(,[0-7])?$":
     type: object
-- 
2.34.1

