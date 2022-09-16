Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E665BAE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIPN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiIPNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:25:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83827ABF00
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:25:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so5358237wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KAhx2geP3Y9yF06rJ0c/NiVsJMPP2YuQ7uxVtCGSGkk=;
        b=JJFSshL4zSleIf5ZPzka8f3p13jYW9DJ5IH+L0Uy++TuG8ROBNVZOd7YUlbQmdMCTU
         cf+i0xXkHF2kAUlze9tzxbN8VBC4oXqvzzYrM8S9wfKEZq7Xzlkh6mo9YyOVZISYU9jm
         g2OqmvApsDEAkdz6FufP0Ce67jtB0cEKx86i2osg6aEONY06Lwz4rp/BOAnRN9rocEAq
         MKBsvJwkHIEHLt9QQwbDkyJCdIPL0NvqrMf8XSeBkL5MP53DejZQIzEqqX7Wo5Bm+sLt
         ViQRrS9Y6nnzTUjUJhkNUs26ZrEnLlV3xfI5GMV9o06fSL8UnLqao6i6lG9lOsVVHeih
         biTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KAhx2geP3Y9yF06rJ0c/NiVsJMPP2YuQ7uxVtCGSGkk=;
        b=X/XAFyVEquwgtBL8JaJOPbpu9xWvbryS7TiTAwrE8P+M0Uwkbm21RDUly3+YWXspU+
         FB4C5dCcvmOkB+gOEayKEnW/p6gNBhLCTUKeJbrMl7APzsnnyN1aJtLFB58CJ8fzps7J
         Xy7r7V5k9nF/navk2msLcoTD73J7TOptbcrgFPlPIGnOlCMsl18I7NN8lum1hkT0boQe
         Ljdvu5K5TpFNJAFpzlOOlI+n/aoN0H7y099YjFEmrjneKCOSQlngdv3O8N+tmJgjt6HB
         dTdgrxuFv000H2KbVCFORZyMZ4buKT0FThUpwyeVdYbOCjaL6cG0O8gUQsVkyQVFKGh+
         UBXA==
X-Gm-Message-State: ACgBeo0rNW92Yj7vjmLNc4Xj48ZKK6STMDVegISzw9AuPVhnr3Ds8wFP
        fuWuZOTMt9fPyNFgG/Xj5j18Xg==
X-Google-Smtp-Source: AA6agR7jr63V9Sesi0cmYIfkozQRB0y4Lf7+tqw6QTVo8kUP/7lcOGvCMsNy1AzysMLxGxCa3K+J7Q==
X-Received: by 2002:a05:600c:4fce:b0:3b4:935f:b952 with SMTP id o14-20020a05600c4fce00b003b4935fb952mr10267270wmq.197.1663334754022;
        Fri, 16 Sep 2022 06:25:54 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id v12-20020adfe28c000000b00223b8168b15sm5122475wri.66.2022.09.16.06.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:25:53 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] dt-bindings: virtio: Convert virtio,pci-iommu to DT schema
Date:   Fri, 16 Sep 2022 14:22:31 +0100
Message-Id: <20220916132229.1908841-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/virtio/iommu.txt      | 66 --------------
 .../devicetree/bindings/virtio/iommu.yaml     | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 66 deletions(-)
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
index 000000000000..d5bbb8ab9603
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/iommu.yaml
@@ -0,0 +1,86 @@
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
+  - reg
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie0 {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        /*
+         * The IOMMU manages all functions in this PCI domain except
+         * itself. Omit BDF 00:01.0.
+         */
+        iommu-map = <0x0 &iommu0 0x0 0x8
+                     0x9 &iommu0 0x9 0xfff7>;
+
+        /* The IOMMU programming interface uses slot 00:01.0 */
+        iommu0: iommu@1,0 {
+            compatible = "pci1af4,1057";
+            reg = <0x800 0 0 0 0>;
+            #iommu-cells = <1>;
+        };
+    };
+
+    pcie1 {
+        /*
+         * The IOMMU also manages all functions from this domain,
+         * with endpoint IDs 0x10000 - 0x1ffff
+         */
+        iommu-map = <0x0 &iommu0 0x10000 0x10000>;
+    };
+
+    ethernet {
+        /* The IOMMU manages this platform device with endpoint ID 0x20000 */
+        iommus = <&iommu0 0x20000>;
+    };
+
+...
-- 
2.37.3

