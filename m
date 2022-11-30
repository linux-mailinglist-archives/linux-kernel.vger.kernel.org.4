Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117C63E1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiK3UNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiK3UNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:13:07 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C88E583;
        Wed, 30 Nov 2022 12:10:58 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUH37Dm028849;
        Wed, 30 Nov 2022 20:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=ll031SR+kAaxL16fqeXW3X9vRYzryfygRDNccWalYBg=;
 b=bPAJnUPDq7TVJottCDTfKTPRFdMrPqKK6t+U/rL1V3J1hYD6zuMgciHmEltJ8ySfheCx
 LUCkKpIidK/RvUOMmkpPaqES2V5SsM9qorMglb+lvUCtYI98VC+bEH9HL5TLCrRFDnfM
 CD5E9qZz9stQ2RDNRM1dnnVzB9Q4bgjKsufQ+iQAkONv6ZqAvH1e2uo/e4Ya880ROkHa
 OhAyDiITF63oSEumKLmh11+IMlKeUHodPwOfODYeq8+S1OM5vW5UK22NedUW5KnF1KTf
 xHGWzu4klkFL4Nrq4KFfHoUcoRwjvsAeUV1ZsAMd7PGAEk5jh1vjywACzUV4cggFpNCX 4A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m693gjt95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:10:20 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 38C492FCF3;
        Wed, 30 Nov 2022 20:10:19 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A5BBF805CDF;
        Wed, 30 Nov 2022 20:10:18 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/6] ARM: dts: add GXP Support for fans and SPI
Date:   Wed, 30 Nov 2022 14:08:44 -0600
Message-Id: <20221130200846.4226-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221130200846.4226-1-nick.hawkins@hpe.com>
References: <20221130200846.4226-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: IVPac_UJqHX8ZmSVqicH8_PsWAU5xDpR
X-Proofpoint-ORIG-GUID: IVPac_UJqHX8ZmSVqicH8_PsWAU5xDpR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=898
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Reorganize the base address of AHB to accommodate the SPI and fan driver
register requirements. Add the hpe,gxp-spifi and hpe,gxp-fan-ctrl
compatibles. Add comments to make the register range more clear.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts | 58 +++++++++++++++++++++
 arch/arm/boot/dts/hpe-gxp.dtsi           | 64 +++++++++++++++++-------
 2 files changed, 103 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
index 3a7382ce40ef..d49dcef95c5c 100644
--- a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
+++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
@@ -24,3 +24,61 @@
 		reg = <0x40000000 0x20000000>;
 	};
 };
+
+&spifi {
+	status = "okay";
+	flash@0 {
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			u-boot@0 {
+				label = "u-boot";
+				reg = <0x0 0x60000>;
+			};
+
+			u-boot-env@60000 {
+				label = "u-boot-env";
+				reg = <0x60000 0x20000>;
+			};
+
+			kernel@80000 {
+				label = "kernel";
+				reg = <0x80000 0x4c0000>;
+			};
+
+			rofs@540000 {
+				label = "rofs";
+				reg = <0x540000 0x1740000>;
+			};
+
+			rwfs@1c80000 {
+				label = "rwfs";
+				reg = <0x1c80000 0x250000>;
+			};
+
+			section@1ed0000{
+				label = "section";
+				reg = <0x1ed0000 0x130000>;
+			};
+		};
+	};
+	flash@1 {
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			host-prime@0 {
+				label = "host-prime";
+				reg = <0x0 0x02000000>;
+			};
+
+			host-second@2000000 {
+				label = "host-second";
+				reg = <0x02000000 0x02000000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
index cf735b3c4f35..b73b22a93716 100644
--- a/arch/arm/boot/dts/hpe-gxp.dtsi
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree file for HPE GXP
+ * Device Tree for HPE
  */
 
 /dts-v1/;
@@ -52,76 +52,102 @@
 			cache-level = <2>;
 		};
 
-		ahb@c0000000 {
+		ahb@80000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0xc0000000 0x30000000>;
+			ranges = <0x0 0x80000000 0xf000000>, /* 0x80000000 - 0x8f000000 */
+				 <0x40000000 0xc0000000 0x7fffffff>; /* 0xc0000000 - 0xffffffff */
 			dma-ranges;
 
-			vic0: interrupt-controller@eff0000 {
+			spifi: spi@40000200 { /* 0xc0000200 */
+				compatible = "hpe,gxp-spifi";
+				reg = <0x40000200 0x80>, <0x4000c000 0x100>, <0x78000000 0x7ff0000>;
+				interrupts = <20>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				flash@0 {
+					reg = <0>;
+					compatible = "jedec,spi-nor";
+				};
+
+				flash@1 {
+					reg = <1>;
+					compatible = "jedec,spi-nor";
+				};
+			};
+
+			vic0: interrupt-controller@4eff0000 { /* 0xceff0000 */
 				compatible = "arm,pl192-vic";
-				reg = <0xeff0000 0x1000>;
+				reg = <0x4eff0000 0x1000>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
 
-			vic1: interrupt-controller@80f00000 {
+			vic1: interrupt-controller@f00000 { /* 0x80f00000 */
 				compatible = "arm,pl192-vic";
-				reg = <0x80f00000 0x1000>;
+				reg = <0xf00000 0x1000>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
 
-			uarta: serial@e0 {
+			uarta: serial@400000e0 { /* 0xc00000e0 */
 				compatible = "ns16550a";
-				reg = <0xe0 0x8>;
+				reg = <0x400000e0 0x8>;
 				interrupts = <17>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			uartb: serial@e8 {
+			uartb: serial@400000e8 { /* 0xc00000e8 */
 				compatible = "ns16550a";
-				reg = <0xe8 0x8>;
+				reg = <0x400000e8 0x8>;
 				interrupts = <18>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			uartc: serial@f0 {
+			uartc: serial@400000f0 { /* 0xc00000f0 */
 				compatible = "ns16550a";
-				reg = <0xf0 0x8>;
+				reg = <0x400000f0 0x8>;
 				interrupts = <19>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			usb0: usb@efe0000 {
+			usb0: usb@4efe0000 { /* 0xcefe0000 */
 				compatible = "hpe,gxp-ehci", "generic-ehci";
-				reg = <0xefe0000 0x100>;
+				reg = <0x4efe0000 0x100>;
 				interrupts = <7>;
 				interrupt-parent = <&vic0>;
 			};
 
-			st: timer@80 {
+			st: timer@40000080 { /* 0xc0000080 */
 				compatible = "hpe,gxp-timer";
-				reg = <0x80 0x16>;
+				reg = <0x40000080 0x16>;
 				interrupts = <0>;
 				interrupt-parent = <&vic0>;
 				clocks = <&iopclk>;
 				clock-names = "iop";
 			};
 
-			usb1: usb@efe0100 {
+			usb1: usb@4efe0100 { /* 0xcefe0100 */
 				compatible = "hpe,gxp-ohci", "generic-ohci";
-				reg = <0xefe0100 0x110>;
+				reg = <0x4efe0100 0x110>;
 				interrupts = <6>;
 				interrupt-parent = <&vic0>;
 			};
+
+			fan-controller@40000c10 { /* 0xc0000c10 */
+				compatible = "hpe,gxp-fan-ctrl";
+				reg = <0x40000c10 0x8>, <0x51000027 0x06>, <0x200070 0x04>;
+				reg-names = "base", "pl", "fn2";
+			};
 		};
 	};
 };
-- 
2.17.1

