Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC76A6B80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCALNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCALNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:13:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C51EBCE;
        Wed,  1 Mar 2023 03:13:36 -0800 (PST)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8578166020E6;
        Wed,  1 Mar 2023 11:13:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677669214;
        bh=WCfgAcB4UaEzGmvvwq/jOJivTdFWK6XfOflmE7TETnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQQnw7rhJjaDoDAbYV4Rk43bpWt07AKX73vFrJjeKnhBOWkZYFKttit1SrxRBEM76
         KwqzRhD6khHanvUJpaWryt7ue0hCTQw3TjXW7eO47ts/h9EeB+xzfAKq0ONZPQ8xf2
         lBwp2DezA+PtKhKQ8RWwTUjJmhmP6mT99fLFin57rqplCf0ggFeOC7QBVL0xuGR7TH
         mNN+LlwlFopN7LBmmHM2TFgMdj5JpWd5KLlXgB4FiFYvN3fTKX8rmbqcPBoCraFAqJ
         HrPSb1AAYgDa8Sv66w9kW6NHuna9PPMCx9k9wz7b7xx/DGABCEy5KLZcXrzzY8GQdl
         3tCA3Xh6P9UIA==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: remoteproc: k3-m4f: Add bindings for K3 AM64x SoCs
Date:   Wed,  1 Mar 2023 11:13:21 +0000
Message-Id: <20230301111323.1532479-2-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301111323.1532479-1-martyn.welch@collabora.com>
References: <20230301111323.1532479-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Nagalla <hnagalla@ti.com>

K3 AM64x SoC has a Cortex M4F subsystem in the MCU volatge domain.
The remote processor's life cycle management and IPC mechanisms are
similar across the R5F and M4F cores from remote processor driver
point of view. However, there are subtle differences in image loading
and starting the M4F subsystems.

The YAML binding document provides the various node properties to be
configured by the consumers of the M4F subsystem.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
[Martyn Welch: Amended as per review comments and to pass DT tests]
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes since v1:
 - Spelling corrections
 - Corrected to pass DT checks

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
new file mode 100644
index 000000000000..1b38df0be2e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI K3 M4F processor subsystems
+
+maintainers:
+  - Hari Nagalla <hnagalla@ti.com>
+
+description: |
+  Some K3 family SoCs have Arm Cortex M4F cores. AM64x is a SoC in K3
+  family with a M4F core. Typically safety oriented applications may use
+  the M4F core in isolation without an IPC. Where as some industrial and
+  home automation applications, may use the M4F core as a remote processor
+  with IPC communications.
+
+$ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+
+properties:
+  $nodename:
+    pattern: "^m4fss(@.*)?"
+
+  compatible:
+    enum:
+      - ti,am64-m4fss
+
+  power-domains:
+    description: |
+      Should contain a phandle to a PM domain provider node and an args
+      specifier containing the M4FSS device id value.
+    maxItems: 1
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  reg:
+    items:
+      - description: Address and Size of the IRAM internal memory region
+      - description: Address and Size of the DRAM internal memory region
+
+  reg-names:
+    items:
+      - const: iram
+      - const: dram
+
+  resets:
+    description: |
+      Should contain the phandle to the reset controller node managing the
+      local resets for this device, and a reset specifier.
+    maxItems: 1
+
+  firmware-name:
+    description: |
+      Should contain the name of the default firmware image
+      file located on the firmware search path
+
+  mboxes:
+    description: |
+      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
+      communication with the remote processor. This property should match
+      with the sub-mailbox node used in the firmware image.
+    maxItems: 1
+
+  memory-region:
+    description: |
+      phandle to the reserved memory nodes to be associated with the
+      remoteproc device. There should be at least two reserved memory nodes
+      defined. The reserved memory nodes should be carveout nodes, and
+      should be defined with a "no-map" property as per the bindings in
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+    minItems: 2
+    maxItems: 8
+    items:
+      - description: region used for dynamic DMA allocations like vrings and
+                     vring buffers
+      - description: region reserved for firmware image sections
+    additionalItems: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,sci-proc-ids
+  - resets
+  - firmware-name
+  - mboxes
+  - memory-region
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0x9cb00000 0x00 0x100000>;
+            no-map;
+        };
+
+        mcu_m4fss_memory_region: m4f-memory@9cc00000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0x9cc00000 0x00 0xe00000>;
+            no-map;
+        };
+    };
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mailbox0_cluster0: mailbox-0 {
+            #mbox-cells = <1>;
+
+            mbox_m4_0: mbox-m4-0 {
+                ti,mbox-rx = <0 0 0>;
+                ti,mbox-tx = <1 0 0>;
+            };
+        };
+
+        bus@f0000 {
+            compatible = "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;
+
+            bus@4000000 {
+                compatible = "simple-bus";
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;
+
+                mcu_m4fss: m4fss@5000000 {
+                    compatible = "ti,am64-m4fss";
+                    reg = <0x00 0x5000000 0x00 0x30000>,
+                          <0x00 0x5040000 0x00 0x10000>;
+                    reg-names = "iram", "dram";
+                    ti,sci = <&dmsc>;
+                    ti,sci-dev-id = <9>;
+                    ti,sci-proc-ids = <0x18 0xff>;
+                    resets = <&k3_reset 9 1>;
+                    firmware-name = "am62-mcu-m4f0_0-fw";
+                    mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
+                    memory-region = <&mcu_m4fss_dma_memory_region>,
+                                    <&mcu_m4fss_memory_region>;
+                };
+            };
+        };
+    };
-- 
2.39.1

