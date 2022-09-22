Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15BF5E684A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiIVQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiIVQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:20:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339BE119A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:20:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id iv17so2508344wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ikNsXWXU/bxgoF8rWbJPE8/lOHvhyE2xcZVDiYsxD3w=;
        b=cNg49/8wtVekJsFl/kyO40gP2uw4vSef6Y0zG3Oe9TLF0SeeND6DMWYKBqheFIIPt2
         /Uj/C5wsiZGk3tKdaXdaDehm+eMHU+tT6/Ud0khG95GkYriQRGO96QEyNHge+IjZCSeS
         tLAPENCUrQvu5gDAb4U032KfrXGGcSgKrXnfx/2tSp9+vjPPJjDAmHAfUjsfFhXIPrg0
         IvR/N2wp4ABC+CdcTB4Cqkwmq2+QdcCSnRqctDtTO2bBBt9KpN2dJ3epQQbuxWuzAUn7
         TfJeT+Lq4UqhJXw0w8iei16hXkF5vPPRVgPTrylK2g4ZomZh06zUJAZekbxaIHpB/RFb
         5Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ikNsXWXU/bxgoF8rWbJPE8/lOHvhyE2xcZVDiYsxD3w=;
        b=gn7xBxjiRchLo3wy/H7eaNdXjdsVUaplYTIrmSEX9YIlbQSNb+36CrlsV9d7G8Dh56
         tMbRT+xUaxTZIeWtaUKmAt4moFdxAYKv/OHSxnPtCCSAyM2kX8lnpZkJQUQRm9u6j8zK
         nwzkdSoXHMoC1UBZEonuD6uqLJ5RojtlBSXlXBBC29hZCNS+H/DpGh7MHsG9FvHAX+C0
         Bmh0yHQQmTNcwR1cHAofv0ODga11Uq23fyQ4tnmDHwoQcFkVVRCvDc7CXp/bh6b8dyU9
         qj7K6oIjep8cxgcJoYT7EVBOmn/ad2CVpSVWSpMDfSxrLxUBBArfC5lLqk1uUaPuTZYh
         KTJg==
X-Gm-Message-State: ACrzQf3aJNm93IUMbHPHrxwQduwTLICqlc2SxC27Iz/VfyA5WCG88QEa
        OsmnCf1wp1EIHTESCrCUPRMcxQ==
X-Google-Smtp-Source: AMsMyM63wvCdfBqy1LUih00pnG9zl0EzimES3cDlucoVL4oQ4Muo7KEqFG5WkCVhvhJWODL4RQkeAg==
X-Received: by 2002:a05:600c:a185:b0:3b4:ff33:9fc4 with SMTP id id5-20020a05600ca18500b003b4ff339fc4mr3841469wmb.2.1663863643268;
        Thu, 22 Sep 2022 09:20:43 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d6d0a000000b0022aeba020casm6600328wrq.83.2022.09.22.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:20:42 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2] dt-bindings: virtio: Convert virtio,pci-iommu to DT schema
Date:   Thu, 22 Sep 2022 17:16:45 +0100
Message-Id: <20220922161644.372181-1-jean-philippe@linaro.org>
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

Convert the binding that describes virtio-pci base IOMMU to DT schema.
Change the compatible string to "pci<vendor>,<device>" which is defined
by the PCI Bus Binding

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2: Fix example, make compatible a required property
v1: https://lore.kernel.org/all/20220916132229.1908841-1-jean-philippe@linaro.org/
---
 .../devicetree/bindings/virtio/iommu.txt      |  66 ------------
 .../devicetree/bindings/virtio/iommu.yaml     | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.yaml

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
diff --git a/Documentation/devicetree/bindings/virtio/iommu.yaml b/Documentation/devicetree/bindings/virtio/iommu.yaml
new file mode 100644
index 000000000000..ae8b670928d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/iommu.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/iommu.yaml#
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

