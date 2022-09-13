Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF295B6E26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiIMNPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiIMNPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:15:14 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEC611469;
        Tue, 13 Sep 2022 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uc1IOQDrZ0YYwOtAcPT9458o1AqjznLKeKIiCpywtbk=; b=J3ZzVJnrQbC8Dt8sBguNHYT6IT
        Mgta9m9pqmKDupG2WCzRP/3r567ARQTLt4wm7XTTvrQdVa0JIujExY7pTY1lyDPf//6ySocq6K+M+
        TsEYhEsfwPka/GMuexMW6UU9/9fIvEXsXaTmZg9TFEfXRJ5426mjwIr3iN6n1BQfUqkppNvEJwwiL
        7oPGE8h1RJGpkjvLrc58zhpbaHh8rYyXDT4P1TUEZDbPSKVekoDWn1OBC3gMnHbLAXLyjez8UgbbS
        vpUh5yZjMO83iXPA67nfqkYUeYOoiH+BauIp+OP78sUbirlYyZJ3NbIjPQg8n8Rq4CFGxY+FAgKkO
        ALfMM7ng==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1oY5kh-00EVnM-Do; Tue, 13 Sep 2022 16:14:59 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] dt-bindings: Add bindings for Tegra234 NVDEC
Date:   Tue, 13 Sep 2022 16:14:41 +0300
Message-Id: <20220913131447.2877280-4-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220913131447.2877280-1-cyndis@kapsi.fi>
References: <20220913131447.2877280-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Update NVDEC bindings for Tegra234. This new engine version only has
two memory clients, but now requires three clocks, and as a bigger
change the engine loads firmware from a secure carveout configured by
the bootloader.

For the latter, we need to add a phandle to the memory controller
to query the location of this carveout, and several other properties
containing offsets into the firmware inside the carveout. These
properties are intended to be populated through a device tree overlay
configured at flashing time, so that the values correspond to the
flashed NVDEC firmware.

As the binding was getting large with many conditional properties,
also split the Tegra234 version out into a separate file.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
- Split out into separate file to avoid complexity with
  conditionals etc.
---
 .../gpu/host1x/nvidia,tegra234-nvdec.yaml     | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml

diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
new file mode 100644
index 000000000000..eab0475ca983
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra234-nvdec.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Device tree binding for NVIDIA Tegra234 NVDEC
+
+description: |
+  NVDEC is the hardware video decoder present on NVIDIA Tegra210
+  and newer chips. It is located on the Host1x bus and typically
+  programmed through Host1x channels.
+
+maintainers:
+  - Thierry Reding <treding@gmail.com>
+  - Mikko Perttunen <mperttunen@nvidia.com>
+
+properties:
+  $nodename:
+    pattern: "^nvdec@[0-9a-f]*$"
+
+  compatible:
+    enum:
+      - nvidia,tegra234-nvdec
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: nvdec
+      - const: fuse
+      - const: tsec_pka
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: nvdec
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+  interconnects:
+    items:
+      - description: DMA read memory client
+      - description: DMA write memory client
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  nvidia,memory-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the memory controller for determining carveout information.
+
+  nvidia,bl-manifest-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to bootloader manifest from beginning of firmware. Typically set as
+      part of a device tree overlay corresponding to flashed firmware.
+
+  nvidia,bl-code-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to bootloader code section from beginning of firmware. Typically set as
+      part of a device tree overlay corresponding to flashed firmware.
+
+  nvidia,bl-data-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to bootloader data section from beginning of firmware. Typically set as
+      part of a device tree overlay corresponding to flashed firmware.
+
+  nvidia,os-manifest-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to operating system manifest from beginning of firmware. Typically set as
+      part of a device tree overlay corresponding to flashed firmware.
+
+  nvidia,os-code-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to operating system code section from beginning of firmware. Typically set as
+      part of a device tree overlay corresponding to flashed firmware.
+
+  nvidia,os-data-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to operating system data section from beginning of firmware. Typically set as
+      part of a device tree overlay corresponding to flashed firmware.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - nvidia,memory-controller
+  - nvidia,bl-manifest-offset
+  - nvidia,bl-code-offset
+  - nvidia,bl-data-offset
+  - nvidia,os-manifest-offset
+  - nvidia,os-code-offset
+  - nvidia,os-data-offset
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra234-clock.h>
+    #include <dt-bindings/memory/tegra234-mc.h>
+    #include <dt-bindings/power/tegra234-powergate.h>
+    #include <dt-bindings/reset/tegra234-reset.h>
+
+    nvdec@15480000 {
+            compatible = "nvidia,tegra234-nvdec";
+            reg = <0x15480000 0x00040000>;
+            clocks = <&bpmp TEGRA234_CLK_NVDEC>,
+                     <&bpmp TEGRA234_CLK_FUSE>,
+                     <&bpmp TEGRA234_CLK_TSEC_PKA>;
+            clock-names = "nvdec", "fuse", "tsec_pka";
+            resets = <&bpmp TEGRA234_RESET_NVDEC>;
+            reset-names = "nvdec";
+            power-domains = <&bpmp TEGRA234_POWER_DOMAIN_NVDEC>;
+            interconnects = <&mc TEGRA234_MEMORY_CLIENT_NVDECSRD &emc>,
+                            <&mc TEGRA234_MEMORY_CLIENT_NVDECSWR &emc>;
+            interconnect-names = "dma-mem", "write";
+            iommus = <&smmu_niso1 TEGRA234_SID_NVDEC>;
+            dma-coherent;
+
+            nvidia,memory-controller = <&mc>;
+
+            /* Placeholder values, to be replaced with values from overlay */
+            nvidia,bl-manifest-offset = <0>;
+            nvidia,bl-data-offset = <0>;
+            nvidia,bl-code-offset = <0>;
+            nvidia,os-manifest-offset = <0>;
+            nvidia,os-data-offset = <0>;
+            nvidia,os-code-offset = <0>;
+    };
-- 
2.37.0

