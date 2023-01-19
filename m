Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0864B674607
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjASWbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjASW3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:29:38 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7CC3824;
        Thu, 19 Jan 2023 14:13:44 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDURQ110978;
        Thu, 19 Jan 2023 16:13:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674166410;
        bh=ZSPCoPFBIjAT2TdS7esgXeJaXnUbGDBq0LvDJbjFWbI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hhskcdreWIFqxRA5mnQgm9i4Rr3NwzcWoZVdPy297X1oY9tFMiUcICTOqRhBVFG+m
         Cr6OM+8oG4uZgo+p54H+TYXY7Z7QGBwK0wmL8yJTJQnyAh7+KgLjj9jwuGUMKjmy7r
         dwx/ZSZwVvFKLDfk4rut1+akB2yUmLeHDMG8pvvw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30JMDUGt014175
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 16:13:30 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 16:13:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 16:13:30 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDUoh046554;
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
Subject: [PATCH 1/6] arm64: dts: ti: k3-am64-main: add VTM node
Date:   Thu, 19 Jan 2023 16:13:17 -0600
Message-ID: <20230119221322.12563-2-bb@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119221322.12563-1-bb@ti.com>
References: <20230119221322.12563-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3221; i=bb@ti.com; h=from:subject; bh=WRpTenZnFqswM19fCea5NPnWy2bZgS4CBrjRh4INKEg=; b=owNCWmg5MUFZJlNZUoGuxAAAan///v5fw3vqXtvnXP3fff2339V/8X9v7/Nz+2u9+7Prkd+wARmw HagGmmgNGmhoDQAGgAABoANNGgADEDTTRoaANANA000DRoyephNNNMRiHtTUQNGQwgaMAgA0ZAwAgA aGgANNAGjIwBAwgANNDTEBoxNAGgGQA0HQaYQZqNNAGhoNNqAAZDEaMQGI0yAGEA00BtEBkBoPQQAZ GjQaNDQAABIm4fSlQiKjLul1xhAfB8nUvCmQL0Mo/RX9iDw4kiISdlvldAiueVru2lSve7eOCzST+S bIYLLhU0MQ9ThgNk6cJgN2aQyhoLeBcEwekk6vyKBvLJ14OwxAjVSkxU/JjF5MZ/+nhNfzX+cKZ7au gy9o9kVswxacAqlyjb9Krc/AudzIrpYooi9sMS8GpSdOe6OmcUu1sv9UdbtjklhwYp8oo2Jcml+gxB J0Yifsrbca/bAJoTW3/gisTICBKHRrFdrQmZYiBDXsaZcwD7gM6oNInUYiBFxHI83fCqy6P3gj6pUK FEJF7VUdBcFc5gpFWumr7GCk+hOuP5quaIdSzgRllUcplbFNBtjCj5Mc6jHrIa+TZkQKBH2xj8YhKB AHDqVnvNzk0yAFeNmov2XQNwzQpYF2PENljw3SCT8JoD25AK3QoopKi/xdyRThQkFKBrsQ
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

The am64x supports a single VTM module which is located in the main
domain with two associated temperature monitors located at different hot
spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi    |  8 +++++
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi | 33 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi         |  3 ++
 3 files changed, 44 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5e8036f32d79d..dc8c1c6021630 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1392,4 +1392,12 @@ elm0: ecc@25010000 {
 		clock-names = "fck";
 		status = "disabled";
 	};
+
+	main_vtm0: temperature-sensor@b00000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0xb00000 0x00 0x400>,
+		      <0x00 0xb01000 0x00 0x400>;
+		power-domains = <&k3_pds 95 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
new file mode 100644
index 0000000000000..036db56ba7977
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	main0_thermal: main0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&main_vtm0 0>;
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
+		thermal-sensors = <&main_vtm0 1>;
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
diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index c858725133af4..3ac0545cbfe6f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -69,6 +69,7 @@ cbass_main: bus@f4000 {
 			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIE_CORE */
@@ -105,6 +106,8 @@ cbass_mcu: bus@4000000 {
 			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral window */
 		};
 	};
+
+	#include "k3-am64-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.39.0

