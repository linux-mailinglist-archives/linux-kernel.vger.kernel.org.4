Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A587B674805
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjATAbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjATAbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:31:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44519A297F;
        Thu, 19 Jan 2023 16:31:19 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30K0V3gi069161;
        Thu, 19 Jan 2023 18:31:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674174663;
        bh=EhVmb2u2O6mw4AA79EZXTNGXm1WaiokelpyqCkP0Q/0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aWI3/TNQSu4yIupAYDNjuz7ZbMCs5nxOhQnBmkE8YjH3p32sEWTjIAyw2HFmasNtV
         ++RFm8+EmN6ykp7BitdA9oNjgvmcBxiHwnIvH+nx6hLj6kQorh1VSh/r6ZtZ6HNZIa
         0lMtaZU4raEZlQvWfr9snhu1HcqqzwtN3WL8lFLw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30K0V3F4079150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 18:31:03 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 18:31:02 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 18:31:02 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30K0V2El120141;
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
Subject: [PATCH v2 4/6] arm64: dts: ti: k3-j721s2-mcu-wakeup: add VTM node
Date:   Thu, 19 Jan 2023 18:30:49 -0600
Message-ID: <20230120003051.9100-5-bb@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120003051.9100-1-bb@ti.com>
References: <20230120003051.9100-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4456; i=bb@ti.com; h=from:subject; bh=bi4FblxH6lsHOjpjZdiQo9patDWW3roBBQlfzTClUAM=; b=owNCWmg5MUFZJlNZut8WrgAAZH///rd9Ti/7+MzeXu//+t9b37s7+j//v/fr97/4039R516wARsb Q71RoGgDQAaAGhoaGmgGgGgGIGjQGIDRkAAAD1NAAD1AMgDRpkaaGGm1RADQBhABoaAD1NAAGgNAeo 9TIDQNDID1AGg2oaaaHqaaeUaaDQD1B6QNAGmQGQyjTaRtTJpoBo0AaAZMTQyGgNAZAGgYgNA0Bpoy DQGQDQGQDQNMgaNPU0aNNMgSJ3OAKpFX1N0Ajkr4PKlIkVnz4QXJADgETEAQCISo4YjnWtezdoOTK1 i7NBVlwJh6CHbjJaAsSiYkjSQbjK4Ys1VnRJhSnhwbwHeEfFh1oIpJhJoAu598B0cIdxXdyKoIwcMj UIHXo+UNouictKwWcSRayDLIqwPPTsZ48JHBBnrVKjA+IFUJFqalgVEXq06sbAaF+ybqhlKgwshnnk 2MhB467/tHCvHVqDLOkviX7b9BuGjZFBX3yq8K3VE7QQRXiO9+vE7eVSQnQrBfPsYaTPIVWdKTV+A6 UIGnfMfFZpuumcKQvMyrvFFZF5LU7nMXEO49tINW3k1D55p6Z2jTWtgA+2npQA1zkbolzk9HxQrIp8 sAffACuhdGaSui8UhrjdYNCOZwCZtYuLnmbgww3uEemockq0jwuQPqfLqd2guxw3zh/i7kinChIXW+ LVw=
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

The j721s2 supports a single Voltage and Thermal Management (VTM) device
located in the wakeup domain with seven associated temperature monitors
located in various hot spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   8 ++
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi | 103 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |   2 +
 3 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 0af242aa98162..b31a0a812f83f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -306,4 +306,12 @@ cpts@3d000 {
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x0 0x42040000 0x0 0x350>,
+		      <0x0 0x42050000 0x0 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi
new file mode 100644
index 0000000000000..945f3fa44aefa
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	wkup0_thermal: wkup0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 0>;
+
+		trips {
+			wkup0_crit: wkup0-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	wkup1_thermal: wkup1-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 1>;
+
+		trips {
+			wkup1_crit: wkup1-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main0_thermal: main0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 2>;
+
+		trips {
+			main0_crit: main0-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main1_thermal: main1-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 3>;
+
+		trips {
+			main1_crit: main1-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main2_thermal: main2-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 4>;
+
+		trips {
+			main2_crit: main2-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main3_thermal: main3-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 5>;
+
+		trips {
+			main3_crit: main3-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main4_thermal: main4-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 6>;
+
+		trips {
+			main4_crit: main4-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
index 7b930a85a29d6..0c8234a4d7978 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -161,6 +161,8 @@ cbass_mcu_wakeup: bus@28380000 {
 		};
 
 	};
+
+	#include "k3-j721s2-thermal.dtsi"
 };
 
 /* Now include peripherals from each bus segment */
-- 
2.39.0

