Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64C6745FF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjASWan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjASW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:29:34 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B68C3815;
        Thu, 19 Jan 2023 14:13:41 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDV5I103038;
        Thu, 19 Jan 2023 16:13:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674166411;
        bh=31mTZJYBIgY75wlnyijVEc4W9dSBKWa72a/x4eFE+oY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a1FNJNqLTdtWspAQO95nR1sDR9WqDMG+EeQmsv3WMqio2EwBp98HXsKcV5PBSvmXv
         qYNpzGII5uzmN3oPbMJ5GPX2xp8wyApDRZdTNfS9twcxVQt4qzuDMIG0U/2ymM/XTh
         SgtvMqNFO/zcdwCiZh63/11sR8jdcUGSN/29HDQo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30JMDVQF012466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 16:13:31 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 16:13:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 16:13:30 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDUJ1002659;
        Thu, 19 Jan 2023 16:13:30 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 5/6] arm64: dts: ti: k3-j7200-mcu-wakeup: add VTM node
Date:   Thu, 19 Jan 2023 16:13:21 -0600
Message-ID: <20230119221322.12563-6-bb@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119221322.12563-1-bb@ti.com>
References: <20230119221322.12563-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=bb@ti.com; h=from:subject; bh=fnGHhI0x+GuDg9xHZ1j87gRgvMs54/9Tc3Q9qTchzRQ=; b=owNCWmg5MUFZJlNZOS/nAwAAYn/////7/vn6fL2+LOP/3fLv6SH210zT6t+tb7/88/14+m0wARmY HamgDQGmgNGj1ADQAAHpNANBo0BoAA0GgANANAGgZAeoaHlGgZoZTzShxDTQZMQNDEaZADQYQZGQGQ Gg0AYTTRiYRkNlA0aDQ0aaNDI0NDIaGRoaNCGh6g0aGjTQaaGTIaBkwgGQYmmmg9TQGTRhGmBAYgyA YRo0ZBkMgADQNMRoAAmk8T7KAyoVQDIiHQcSWIRyu7nlR+rDTgeK3V831BLVw+0OG/cI+IgFf3HoE8 cMvBqncG35ZgVS5wBfebdKt8hfgi2xKWd2wnyc+roj79ww50VIuL2b3rPCD9aA84YhoeLW2kqsPJkG wArm/ReCdcMFBNDInjWlbSXGPZFIdiSXEbWN7EmAnnGoGFp/OsCL3Nt3bwPfBhE5rUgWSv+eoYP14H FJwM/QFIOK1dAicb2fFTuv3QyS1Uvji5w+8chKAZhS0J5S2UIRNVApSGBJYsU3MYxlgHaHVnnb4vr4 9HZnjy5TM8yAPPj/xzZXCQiOrb4RHsnvcFz6mz2i1BEvAccj/OBgYuFGatbsMZpTOkOxKC+mQS2dZk /pDT0TB4ahCEq0l4u7vpyFhaKZWlpm5KsowtGkGN0zsMY4BYwIICsFYb/i7kinChIHJfzgYA==
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

