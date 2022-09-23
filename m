Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F005E7536
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiIWHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiIWHwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:52:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C9012B5FC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:52:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t7so19059242wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=5OTJLPTHaCGUvxTLzQpX9KkfWgyXUXuxIB5BfRQ2its=;
        b=x1m7c9FB2/aG357kotIOofarUV5AJycibbv0fUUoWZJeVTfnQH/MIzMT6EXnNi2ctJ
         jUv3wFiTpjQ5VhjFEzPJTDC/FvoEDtjSMiMamcK6YYkyJnW8+EN9atDCEJqROh5/YX/N
         WCLc3fI5mKElNSS/XwD2pYU9mcOZ4e9nU3HLHfOJSoKjfcwpV9e99NRTc8UjNxTZSQ1f
         cnmNn0yPoZ25IW49lgPPjQAkkYbdr7f52IX2BMgXYX2ZS9v312aucw3Kiw4a+uyScsZ9
         otiHlWNHW60WGy+9nCrv8kEQoVpEt+SexqvjZNIJnd6Wj7hZBD2wiIj5Igjd/ebYlC6T
         OhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5OTJLPTHaCGUvxTLzQpX9KkfWgyXUXuxIB5BfRQ2its=;
        b=3/RxLY6Lb0XbQpprLvqlEP9SuimDzY5CxEtbPCnBxMWDZiU5lX/1+BEYetP6JP58R1
         Yc4EHmD9ak3vWGuiOng5eTd1nG5/bM+bSimq2nXsr5hy1RyLCxbFghnkfoFEtMHm9nKL
         33KMwqLWoGuw0VyeSYzxLdzD2cRssHGFUGeSu8ZHTAoA+h4OzcPGXIFkWfwTRHaFPczg
         JPLH382k9ZcN0JdDQ+s9NdoW25qlBSPShmGIJBBH5kvUt373XQ9WAO0n1GNXd+gAu1k8
         IL3AC3qGC9zjCAyvH2iZm+cNFqEGY4YT5KXuhriHs1bYw4/k/WFWG10O+fGDLP6kSjCz
         zMWQ==
X-Gm-Message-State: ACrzQf2OiO/ycdz9J23dEFtwoLy4eftlGK+fiW4Z1MAdvr/fIafy2eCV
        LIWeeQKJTav1IyJtXCKystEVPw==
X-Google-Smtp-Source: AMsMyM5K0BL3MUCQCX1SoMJdGVMS00+U0AY6LIti26t6MQPtQ9C3GKO8ZB2URqjLBBsBFou6vC/jIw==
X-Received: by 2002:a05:6000:80a:b0:229:4632:d1d1 with SMTP id bt10-20020a056000080a00b002294632d1d1mr4510716wrb.73.1663919534600;
        Fri, 23 Sep 2022 00:52:14 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a2f2bb72d5sm2089319wmq.45.2022.09.23.00.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 00:52:14 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3] dt-bindings: virtio: Convert virtio,pci-iommu to DT schema
Date:   Fri, 23 Sep 2022 08:44:38 +0100
Message-Id: <20220923074435.420531-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding that describes the virtio-pci based IOMMU to DT
schema. Change the compatible string to "pci<vendor>,<device>", which is
defined by the PCI Bus Binding, but keep "virtio,pci-iommu" as an option
for backward compatibility.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v3: Renamed file and type to pci-iommu
v2: https://lore.kernel.org/linux-devicetree/20220922161644.372181-1-jean-philippe@linaro.org/
---
 .../devicetree/bindings/virtio/iommu.txt      |  66 ------------
 .../devicetree/bindings/virtio/pci-iommu.yaml | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 Documentation/devicetree/bindings/virtio/pci-iommu.yaml

diff --git a/Documentation/devicetree/bindings/virtio/iommu.txt b/Documentation/devicetree/bindings/virtio/iommu.txt
deleted file mode 100644
index 2407fea0651c..000000000000
--- a/Documentation/devicetree/bindings/virtio/iommu.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-* virtio IOMMU PCI device
-
-When virtio-iommu uses the PCI transport, its programming interface is
-discovered dynamically by the PCI probing infrastructure. However the
-device tree statically describes the relation between IOMMU and DMA
-masters. Therefore, the PCI root complex that hosts the virtio-iommu
-contains a child node representing the IOMMU device explicitly.
-
-Required properties:
-
-- compatible:	Should be "virtio,pci-iommu"
-- reg:		PCI address of the IOMMU. As defined in the PCI Bus
-		Binding reference [1], the reg property is a five-cell
-		address encoded as (phys.hi phys.mid phys.lo size.hi
-		size.lo). phys.hi should contain the device's BDF as
-		0b00000000 bbbbbbbb dddddfff 00000000. The other cells
-		should be zero.
-- #iommu-cells:	Each platform DMA master managed by the IOMMU is assigned
-		an endpoint ID, described by the "iommus" property [2].
-		For virtio-iommu, #iommu-cells must be 1.
-
-Notes:
-
-- DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
-  virtio-iommu node doesn't have an "iommus" property, and is omitted from
-  the iommu-map property of the root complex.
-
-Example:
-
-pcie@10000000 {
-	compatible = "pci-host-ecam-generic";
-	...
-
-	/* The IOMMU programming interface uses slot 00:01.0 */
-	iommu0: iommu@0008 {
-		compatible = "virtio,pci-iommu";
-		reg = <0x00000800 0 0 0 0>;
-		#iommu-cells = <1>;
-	};
-
-	/*
-	 * The IOMMU manages all functions in this PCI domain except
-	 * itself. Omit BDF 00:01.0.
-	 */
-	iommu-map = <0x0 &iommu0 0x0 0x8>
-		    <0x9 &iommu0 0x9 0xfff7>;
-};
-
-pcie@20000000 {
-	compatible = "pci-host-ecam-generic";
-	...
-	/*
-	 * The IOMMU also manages all functions from this domain,
-	 * with endpoint IDs 0x10000 - 0x1ffff
-	 */
-	iommu-map = <0x0 &iommu0 0x10000 0x10000>;
-};
-
-ethernet@fe001000 {
-	...
-	/* The IOMMU manages this platform device with endpoint ID 0x20000 */
-	iommus = <&iommu0 0x20000>;
-};
-
-[1] Documentation/devicetree/bindings/pci/pci.txt
-[2] Documentation/devicetree/bindings/iommu/iommu.txt
diff --git a/Documentation/devicetree/bindings/virtio/pci-iommu.yaml b/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
new file mode 100644
index 000000000000..972a785a42de
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/pci-iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: virtio-iommu device using the virtio-pci transport
+
+maintainers:
+  - Jean-Philippe Brucker <jean-philippe@linaro.org>
+
+description: |
+  When virtio-iommu uses the PCI transport, its programming interface is
+  discovered dynamically by the PCI probing infrastructure. However the
+  device tree statically describes the relation between IOMMU and DMA
+  masters. Therefore, the PCI root complex that hosts the virtio-iommu
+  contains a child node representing the IOMMU device explicitly.
+
+  DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
+  virtio-iommu node doesn't have an "iommus" property, and is omitted from
+  the iommu-map property of the root complex.
+
+properties:
+  # If compatible is present, it should contain the vendor and device ID
+  # according to the PCI Bus Binding specification. Since PCI provides
+  # built-in identification methods, compatible is not actually required.
+  compatible:
+    oneOf:
+      - items:
+          - const: virtio,pci-iommu
+          - const: pci1af4,1057
+      - items:
+          - const: pci1af4,1057
+
+  reg:
+    description: |
+      PCI address of the IOMMU. As defined in the PCI Bus Binding
+      reference, the reg property is a five-cell address encoded as (phys.hi
+      phys.mid phys.lo size.hi size.lo). phys.hi should contain the device's
+      BDF as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be
+      zero. See Documentation/devicetree/bindings/pci/pci.txt
+
+  '#iommu-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@40000000 {
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x0 0x40000000  0x0 0x1000000>;
+            ranges = <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x0f000000>;
+
+            /*
+             * The IOMMU manages all functions in this PCI domain except
+             * itself. Omit BDF 00:01.0.
+             */
+            iommu-map = <0x0 &iommu0 0x0 0x8
+                         0x9 &iommu0 0x9 0xfff7>;
+
+            /* The IOMMU programming interface uses slot 00:01.0 */
+            iommu0: iommu@1,0 {
+                compatible = "pci1af4,1057";
+                reg = <0x800 0 0 0 0>;
+                #iommu-cells = <1>;
+            };
+        };
+
+        pcie@50000000 {
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x0 0x50000000  0x0 0x1000000>;
+            ranges = <0x02000000 0x0 0x51000000  0x0 0x51000000  0x0 0x0f000000>;
+
+            /*
+             * The IOMMU also manages all functions from this domain,
+             * with endpoint IDs 0x10000 - 0x1ffff
+             */
+            iommu-map = <0x0 &iommu0 0x10000 0x10000>;
+        };
+
+        ethernet {
+            /* The IOMMU manages this platform device with endpoint ID 0x20000 */
+            iommus = <&iommu0 0x20000>;
+        };
+    };
+
+...
-- 
2.37.3

