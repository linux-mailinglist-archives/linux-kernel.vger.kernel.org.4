Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795B6F4897
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjEBQtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjEBQtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:49:02 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1E3C14;
        Tue,  2 May 2023 09:48:48 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pttBH-0000VJ-06;
        Tue, 02 May 2023 18:48:47 +0200
Date:   Tue, 2 May 2023 17:48:39 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: [PATCH 3/4] dt-bindings: mtd: partitions: add linux,ubi compatible
Message-ID: <faa0ceb4470f7160b05e892932d20b4a540c5955.1683043928.git.daniel@makrotopia.org>
References: <cover.1683043928.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683043928.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for MTD partitions to be attached as UBI devices.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../bindings/mtd/partitions/ubi.yaml          | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
new file mode 100644
index 0000000000000..aa02fbbd50716
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/ubi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unsorted Block Images (UBI)
+
+description: |
+ Unsorted Block Images (UBI) is a volume management system typically
+ used on NAND flash providing bad block management as well as
+ wear-leveling.
+ Any partition containing the compatible "linux,ubi" will be attached
+ as UBI device.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  compatible:
+    const: linux,ubi
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "bootloader";
+            reg = <0x000000 0x100000>;
+            read-only;
+        };
+
+        ubi@100000 {
+            compatible = "linux,ubi";
+            label = "ubi";
+            reg = <0x100000 0x7f00000>;
+        };
+    };
-- 
2.40.1

