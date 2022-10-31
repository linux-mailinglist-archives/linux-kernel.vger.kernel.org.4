Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D786141C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJaX15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJaX1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEF913F35;
        Mon, 31 Oct 2022 16:27:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRG9Z058542;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=YityQ/wuUXHsyeqfnkyK8ltNeRnXLIQbQj38R/cl/ME=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=D25L/+AjhDK31CaRRbzeC4KWjnO2HS5MqEnSXbsfw2cL1vh8uuqEWVvMe0e7aA15s
         tq9cN+i8Nmm0nGvuYil+O7UskPKekFubgFUIB4cAiGOWSdeU9brIdMRSdOSQm58cFh
         xOTUyas5KNjuCQgbBlMFKp/wkJnHpU6p4zShL8ng=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRG0D007679
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGe4124787;
        Mon, 31 Oct 2022 18:27:16 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 08/11] arm64: dts: ti: k3-am62-wakeup: add VTM node
Date:   Mon, 31 Oct 2022 18:26:59 -0500
Message-ID: <20221031232702.10339-9-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3321; h=from:subject; bh=/6/erm8uGvFnwvcLO4BZMnh8Xxmwt3ii2KHozEpD0Qs=; b=owNCWmg5MUFZJlNZX+HChwAAav///v75fn33/Leaf1923vff1z26V3+P334t7l47vHfx/m8wARsY IfqT1ADQGgAANBo0A00A0BoDQAANA0GmgNAAGgAPUaA0AGj1PUaPU9PQSHJoAAGhppoAAGgNqNDQB6 RoaGgAB6gNNBoxDQfqT1NNqMgAG1G1GgDQDQ9QeiGRkGgZBo00aDQGhkDCBoDCaAGJhMCNDTAIGhkA DQxMhppiMTQaAAAAgTcJc+Y4HFZMSFjg3bUJfqin4tA7rQrcDIBw0NpY6aAAX5Yt2JntvrpksIBVWS tPvO65pAxBR4K46lj6z6Gd2chd2pHSZVL8Cjkm01UdW5DQXsW62wBQTQG58Y4waj+QDIhW1TFOYEjH zAI5PdWyGNJnwL0zX9j+OhotGgpNEQZeWog2UZlpUVGnXIiOEkJCHgy021etWOXh0NqhFR/qOP42F7 qZw+5XGUvcdPK+KvUuP2QRzzavjnzgo5759SVzEtv81+QnWqg1NcsuWf2Gy1cvjDQN5qouhSO593Ka lUHxAeggpn15KTUJXeugy0KA9YjtesGgTQzE5n8y9glYH3ByTk/ZEA8/Cx4rNkBpYcHi2rsGZOyZBC RmyRdTeB+Eqv5pf5H9SDa6grcqE2OG/NMRFBMQGgMZQs8P7iUy1loNv+LuSKcKEgv8OFDg
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The am62x supports a single Voltage and Thermal Management (VTM) module
located in the wakeup domain with two associated temperature monitors
located in hot spots of the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi | 33 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  |  8 +++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi         |  7 ++++-
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
new file mode 100644
index 0000000000000..1819a6948b19d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	main0_thermal: main0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 0>;
+
+		trips {
+			main0_crit: main0-crit {
+				temperature = <105000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main1_thermal: main1-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 1>;
+
+		trips {
+			main1_crit: main1-crit {
+				temperature = <105000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 4090134676cf6..3954a73a33f35 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -38,4 +38,12 @@ wkup_i2c0: i2c@2b200000 {
 		clocks = <&k3_clks 107 4>;
 		clock-names = "fck";
 	};
+
+	vtm0: temperature-sensor@b00000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0xb00000 0x00 0x400>,
+		      <0x00 0xb01000 0x00 0x400>;
+		power-domains = <&k3_pds 95 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index 37fcbe7a3c336..1795f3ee534e0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -80,6 +80,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
 
 			 /* Wakeup Domain Range */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
 			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
 
@@ -94,10 +95,14 @@ cbass_wakeup: bus@2b000000 {
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
+			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
+				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
 				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
 		};
 	};
+
+	#include "k3-am62-thermal.dtsi"
+
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.38.1

