Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74A267480C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjATAbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATAbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:31:19 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD226A25BD;
        Thu, 19 Jan 2023 16:31:17 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30K0V3W4069165;
        Thu, 19 Jan 2023 18:31:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674174663;
        bh=31mTZJYBIgY75wlnyijVEc4W9dSBKWa72a/x4eFE+oY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oUNiJGEWQP/Y1PjZ8r0+uGEuKWwng6SPGEogr2XFrH20YaM0mlL6vP0bIeWwsjxyy
         gKhfOFfpYNn7mDAMAMZSYX1hgG7Xw90iIZqBoNiOZJylY/JzpgZ7bBBRGbNASvmnSS
         yhk1iqq5XclcW29K/77Z08exqxdKtcf5UFntyDZA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30K0V31B079155
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 18:31:03 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 18:31:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 18:31:02 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30K0V2vb016882;
        Thu, 19 Jan 2023 18:31:02 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 5/6] arm64: dts: ti: k3-j7200-mcu-wakeup: add VTM node
Date:   Thu, 19 Jan 2023 18:30:50 -0600
Message-ID: <20230120003051.9100-6-bb@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120003051.9100-1-bb@ti.com>
References: <20230120003051.9100-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=bb@ti.com; h=from:subject; bh=fnGHhI0x+GuDg9xHZ1j87gRgvMs54/9Tc3Q9qTchzRQ=; b=owNCWmg5MUFZJlNZs90XbgAAa3///7Z5v/e3//P+bX1fv/vzuf/naMYXnHs/bf2v/N95i0+wARtZ RD1ADQA00AGgDQ00AA0AGgHqAAxDQ2oABoHqAGgAAAeoeoaaGh6J+pPZUQaGgYgDBMhkAaMmTEyMIN NAA0GCaNGINAMRhMQDQNMIDCZA0AaAaAMmp5T0jRoMgNNAaB5R6TQNqNBoAA00AaaDIAAAaDQAyGQA aDQAaaDIHpNPUDD2DCeoXF8RHEFzLyD/G0B4YQ+OnYqnUqmfzYHaBXgo8xLDIR1bMsguymFOSwdRAs Ny+NWaReT01cLOpqt9fZNvYrcCUcHrsLlPT0rm64fw5LYl1e1gbgRH1CraF7ZGtVeVzJRjy8K+0pP9 aSTPPDCwSNNhkmkON1dLdlyiitkkFrpj8feEEBYpEz9tnf5n1d6LcyTqAmXCTsHCnh78V62vg/htvD NlvOLl20qQsCR08baFpyJQ8d1JuYgbhSs7DZVVlpAQVHqmmI+H9A6F2bj8l0i8rn/ttN7o2KVER1iG KKjKtMKi24W6RDqxjILHedmtYuOT8oYsls5ZzBMBvpBPvs8ifUA4I3ffwn4aNWxbl1zyZaNDmP3R+O 7D6UKQmhZMwbyAY1hV6yR2QCEBCsDUKOC2PjZGUlsQMRzRwhRUAsT/F3JFOFCQs90Xbg==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The j7200 supports a single Voltage and Thermal Management (VTM) device
located in the wakeup domain with three associated temperature monitors
located in various hot spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  8 ++++
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  | 47 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  2 +
 3 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index fe669deba4896..1eb16542bf9f1 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -399,4 +399,12 @@ rng: rng@40910000 {
 			status = "disabled"; /* Used by OP-TEE */
 		};
 	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		      <0x00 0x42050000 0x00 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
new file mode 100644
index 0000000000000..c271cbb72db68
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	mcu_thermal: mcu-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 0>;
+
+		trips {
+			wkup_crit: wkup-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	mpu_thermal: mpu-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 1>;
+
+		trips {
+			mpu_crit: mpu-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main_thermal: main-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 2>;
+
+		trips {
+			c7x_crit: c7x-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index b6da0454cc5bd..2abc872ecec08 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -168,6 +168,8 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3 */
 		};
 	};
+
+	#include "k3-j7200-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.39.0

