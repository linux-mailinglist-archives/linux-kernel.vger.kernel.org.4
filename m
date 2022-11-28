Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA926639F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiK1CIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiK1CIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:08:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122C5FC6;
        Sun, 27 Nov 2022 18:08:06 -0800 (PST)
X-UUID: d6641431d4cf4f8ba3872537d7c01ce2-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x2ZO9T8uDBfvg9Y7/Aj3WgqyBAmho6hFPvG3GNVeqUM=;
        b=APR/Bb2WvRqMpWbMEu36Aflgqv67msoHCjNx/toaDlTt7qi5BOGUEprV94y1iB5xFr22oQOvuvaQfrCqS3Z4gPnIkqeS/yw+w6zD5UnA4icWGnviq9s9grFU7TM5n3oT3W3aWfFM9X/FsDoNmc9vlBuhjkOvlCFRQI3l6bTYWw4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:cf11ef01-7144-4009-899e-684c8ba1a9e3,IP:0,U
        RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:57a0721e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d6641431d4cf4f8ba3872537d7c01ce2-20221128
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 895200316; Mon, 28 Nov 2022 10:08:00 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 10:07:58 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 28 Nov 2022 10:07:57 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
CC:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>
Subject: [PATCH 8/9] dt-bindings: mtd: Split ECC engine with rawnand controller
Date:   Mon, 28 Nov 2022 10:06:12 +0800
Message-ID: <20221128020613.14821-9-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split MediaTek ECC engine with rawnand controller and convert to
YAML schema.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
---
 .../bindings/mtd/mtk,nand-ecc-engine.yaml     |  60 ++++++
 .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
 .../devicetree/bindings/mtd/mtk-nand.yaml     |  92 +++++++++
 3 files changed, 152 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk,nand-ecc-engine.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/mtk,nand-ecc-engine.yaml b/Documentation/devicetree/bindings/mtd/mtk,nand-ecc-engine.yaml
new file mode 100644
index 000000000000..80321157e928
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtk,nand-ecc-engine.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/mtk,nand-ecc-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek(MTK) SoCs NAND ECC engine
+
+maintainers:
+  - Xiangsheng Hou <xiangsheng.hou@mediatek.com>
+
+description: |
+  MTK NAND ECC engine can cowork with MTK raw NAND and SPI NAND controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt2701-ecc
+      - mediatek,mt2712-ecc
+      - mediatek,mt7622-ecc
+
+  reg:
+    items:
+      - description: Base physical address and size of ECC.
+
+  interrupts:
+    items:
+      - description: ECC interrupt
+
+  clocks:
+    minItems: 1
+    items:
+      - description: clock used for the controller
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      bch: ecc@1100e000 {
+          compatible = "mediatek,mt2701-ecc";
+          reg = <0 0x1100e000 0 0x1000>;
+          interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
+          clocks = <&pericfg CLK_PERI_NFI_ECC>;
+      };
+    };
+
diff --git a/Documentation/devicetree/bindings/mtd/mtk-nand.txt b/Documentation/devicetree/bindings/mtd/mtk-nand.txt
deleted file mode 100644
index 4d3ec5e4ff8a..000000000000
--- a/Documentation/devicetree/bindings/mtd/mtk-nand.txt
+++ /dev/null
@@ -1,176 +0,0 @@
-MTK SoCs NAND FLASH controller (NFC) DT binding
-
-This file documents the device tree bindings for MTK SoCs NAND controllers.
-The functional split of the controller requires two drivers to operate:
-the nand controller interface driver and the ECC engine driver.
-
-The hardware description for both devices must be captured as device
-tree nodes.
-
-1) NFC NAND Controller Interface (NFI):
-=======================================
-
-The first part of NFC is NAND Controller Interface (NFI) HW.
-Required NFI properties:
-- compatible:			Should be one of
-				"mediatek,mt2701-nfc",
-				"mediatek,mt2712-nfc",
-				"mediatek,mt7622-nfc".
-- reg:				Base physical address and size of NFI.
-- interrupts:			Interrupts of NFI.
-- clocks:			NFI required clocks.
-- clock-names:			NFI clocks internal name.
-- ecc-engine:			Required ECC Engine node.
-- #address-cells:		NAND chip index, should be 1.
-- #size-cells:			Should be 0.
-
-Example:
-
-	nandc: nfi@1100d000 {
-		compatible = "mediatek,mt2701-nfc";
-		reg = <0 0x1100d000 0 0x1000>;
-		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&pericfg CLK_PERI_NFI>,
-			 <&pericfg CLK_PERI_NFI_PAD>;
-		clock-names = "nfi_clk", "pad_clk";
-		ecc-engine = <&bch>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-        };
-
-Platform related properties, should be set in {platform_name}.dts:
-- children nodes:	NAND chips.
-
-Children nodes properties:
-- reg:			Chip Select Signal, default 0.
-			Set as reg = <0>, <1> when need 2 CS.
-Optional:
-- nand-on-flash-bbt:	Store BBT on NAND Flash.
-- nand-ecc-mode:	the NAND ecc mode (check driver for supported modes)
-- nand-ecc-step-size:	Number of data bytes covered by a single ECC step.
-			valid values:
-			512 and 1024 on mt2701 and mt2712.
-			512 only on mt7622.
-			1024 is recommended for large page NANDs.
-- nand-ecc-strength:	Number of bits to correct per ECC step.
-			The valid values that each controller supports:
-			mt2701: 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28,
-				32, 36, 40, 44, 48, 52, 56, 60.
-			mt2712: 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28,
-				32, 36, 40, 44, 48, 52, 56, 60, 68, 72, 80.
-			mt7622: 4, 6, 8, 10, 12, 14, 16.
-			The strength should be calculated as follows:
-			E = (S - F) * 8 / B
-			S = O / (P / Q)
-				E :	nand-ecc-strength.
-				S :	spare size per sector.
-				F :	FDM size, should be in the range [1,8].
-					It is used to store free oob data.
-				O :	oob size.
-				P :	page size.
-				Q :	nand-ecc-step-size.
-				B :	number of parity bits needed to correct
-					1 bitflip.
-					According to MTK NAND controller design,
-					this number depends on max ecc step size
-					that MTK NAND controller supports.
-					If max ecc step size supported is 1024,
-					then it should be always 14. And if max
-					ecc step size is 512, then it should be
-					always 13.
-			If the result does not match any one of the listed
-			choices above, please select the smaller valid value from
-			the list.
-			(otherwise the driver will do the adjustment at runtime)
-- pinctrl-names:	Default NAND pin GPIO setting name.
-- pinctrl-0:		GPIO setting node.
-
-Example:
-	&pio {
-		nand_pins_default: nanddefault {
-			pins_dat {
-				pinmux = <MT2701_PIN_111_MSDC0_DAT7__FUNC_NLD7>,
-					 <MT2701_PIN_112_MSDC0_DAT6__FUNC_NLD6>,
-					 <MT2701_PIN_114_MSDC0_DAT4__FUNC_NLD4>,
-					 <MT2701_PIN_118_MSDC0_DAT3__FUNC_NLD3>,
-					 <MT2701_PIN_121_MSDC0_DAT0__FUNC_NLD0>,
-					 <MT2701_PIN_120_MSDC0_DAT1__FUNC_NLD1>,
-					 <MT2701_PIN_113_MSDC0_DAT5__FUNC_NLD5>,
-					 <MT2701_PIN_115_MSDC0_RSTB__FUNC_NLD8>,
-					 <MT2701_PIN_119_MSDC0_DAT2__FUNC_NLD2>;
-				input-enable;
-				drive-strength = <MTK_DRIVE_8mA>;
-				bias-pull-up;
-			};
-
-			pins_we {
-				pinmux = <MT2701_PIN_117_MSDC0_CLK__FUNC_NWEB>;
-				drive-strength = <MTK_DRIVE_8mA>;
-				bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-			};
-
-			pins_ale {
-				pinmux = <MT2701_PIN_116_MSDC0_CMD__FUNC_NALE>;
-				drive-strength = <MTK_DRIVE_8mA>;
-				bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-			};
-		};
-	};
-
-	&nandc {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&nand_pins_default>;
-		nand@0 {
-			reg = <0>;
-			nand-on-flash-bbt;
-			nand-ecc-mode = "hw";
-			nand-ecc-strength = <24>;
-			nand-ecc-step-size = <1024>;
-		};
-	};
-
-NAND chip optional subnodes:
-- Partitions, see Documentation/devicetree/bindings/mtd/partition.txt
-
-Example:
-	nand@0 {
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			preloader@0 {
-				label = "pl";
-				read-only;
-				reg = <0x00000000 0x00400000>;
-			};
-			android@00400000 {
-				label = "android";
-				reg = <0x00400000 0x12c00000>;
-			};
-		};
-	};
-
-2) ECC Engine:
-==============
-
-Required BCH properties:
-- compatible:	Should be one of
-		"mediatek,mt2701-ecc",
-		"mediatek,mt2712-ecc",
-		"mediatek,mt7622-ecc".
-- reg:		Base physical address and size of ECC.
-- interrupts:	Interrupts of ECC.
-- clocks:	ECC required clocks.
-- clock-names:	ECC clocks internal name.
-
-Example:
-
-	bch: ecc@1100e000 {
-		compatible = "mediatek,mt2701-ecc";
-		reg = <0 0x1100e000 0 0x1000>;
-		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&pericfg CLK_PERI_NFI_ECC>;
-		clock-names = "nfiecc_clk";
-	};
diff --git a/Documentation/devicetree/bindings/mtd/mtk-nand.yaml b/Documentation/devicetree/bindings/mtd/mtk-nand.yaml
new file mode 100644
index 000000000000..47a1334bcddd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtk-nand.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/mtk-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek(MTK) SoCs raw NAND FLASH controller (NFC) device tree bindings
+
+maintainers:
+  - Xiangsheng Hou <xiangsheng.hou@mediatek.com>
+
+allOf:
+  - $ref: "nand-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt2701-nfc
+      - mediatek,mt2712-nfc
+      - mediatek,mt7622-nfc
+
+  reg:
+    items:
+      - description: Base physical address and size of NFI.
+
+  interrupts:
+    items:
+      - description: NFI interrupt
+
+  clocks:
+    minItems: 2
+    items:
+      - description: clock used for the controller
+      - description: clock used for the pad
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: nfi_clk
+      - const: pad_clk
+
+  nand-ecc-engine:
+    description: Required ECC Engine node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - nand-ecc-engine
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      nandc: nfi@1100d000 {
+        compatible = "mediatek,mt2701-nfc";
+        reg = <0 0x1100d000 0 0x1000>;
+        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&pericfg CLK_PERI_NFI>,
+          <&pericfg CLK_PERI_NFI_PAD>;
+        clock-names = "nfi_clk", "pad_clk";
+        nand-ecc-engine = <&bch>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+      };
+
+      bch: ecc@1100e000 {
+          compatible = "mediatek,mt2701-ecc";
+          reg = <0 0x1100e000 0 0x1000>;
+          interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
+          clocks = <&pericfg CLK_PERI_NFI_ECC>;
+      };
+    };
-- 
2.25.1

