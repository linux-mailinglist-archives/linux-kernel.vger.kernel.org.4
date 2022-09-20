Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39C5BDA27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiITCbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiITCbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:31:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17674054F;
        Mon, 19 Sep 2022 19:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fricHUsSA55wNRy0MpMuri18qmXxblTGmCvRNg2LISsdSBGcaJrIkbZf4grnK2zW2Seemvtar92qsHBc75yVezf0nJzRuj3QC8r1nOhefTnxuJbZk5OHNj0SWRUXXkTQQiJogj5JIK8SRK97hbhywbFzr5Gxt3s2TweP+NsbKq3xdPU1w+dlDGuXUDlaaoz0qgIRLByRinKq3A1bLnuYZT2XRTJXrODEUc76B5/aNXE3zIJVnvydg5LWIgHBYLDnzwQ2rEQDr31RGLRNjhFjBR+/mYIHUt5GIJmJq8cLat9kqt9+KgvQt4ybvEdnqA4E4Av+druHLbsK4rKgwCXQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fBZdvIA1nXn8ptN+cnpZ6MWm86B9cQv66bPJf9CiXo=;
 b=HMeQatg/pYcJbPqyAmjlou4ibunH/J2zDFNDKrAy33XCd6/CgHuWjn4/rvqcQoDpLHYCvkQPVT/NR0reTE7thpBSDOtt4D77kOZbLdlJ3vPFX/dRsamLDUBiNeigVn+fvjgj0+9imKFFldhi4NnAVBjKi0J1qR1cRTQhqzLWkHr6Mn7CwuzNY1hEJIBF4bC9hU77+myK/+4vp2TsPpruynvDj8EE3SZslsJMFibumYaY79qWwMEzEPCmsBnfWmodTpifotM7SNPTTdLMU3iZsiEyQMOKJoSnsjaNZGqgZb+8dADE8jcw/daZ2UUY3tN/dS3DKt+EnekVAdm9i+fHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=linaro.org smtp.mailfrom=wiwynn.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fBZdvIA1nXn8ptN+cnpZ6MWm86B9cQv66bPJf9CiXo=;
 b=L/2wrPI2xoB5JNR/6RLr2SUkhKvCTNrrF1w92I9HGHft4YW9+6cYCO209tllGfm+U7UVa/OSlPlVcdkr0CbNbcFMpLhaUfe1FFgvsMTsHGkf6tuGqZJjOciwiSOyo63HxTrWuqbarAwC6AQHvsFLiMIjEa/7lRqGwRYQgf5tgN3moKtNPOykGsPOy/tx7xJFINkSboL8PDfK8timCTzkqcM/ZXSyH2diCdsJdbf+C/j+DscxYaAweivyKLoMI2Xl2cJUOG5qddgw+Qz+HLBszzEvW8x60FaZxuUnULdA8eEjjeU3/i8bcs0kzrfA2/q3BauYjm28BB13fsk639/uQQ==
Received: from PS1PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::30) by PSAPR04MB4373.apcprd04.prod.outlook.com
 (2603:1096:301:34::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Tue, 20 Sep
 2022 02:30:58 +0000
Received: from PSAAPC01FT061.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:75:cafe::9) by PS1PR01CA0018.outlook.office365.com
 (2603:1096:300:75::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 02:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 PSAAPC01FT061.mail.protection.outlook.com (10.13.38.140) with Microsoft SMTP
 Server id 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 02:30:56
 +0000
From:   Bonnie Lo <Bonnie_Lo@Wiwynn.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     patrick@stwcx.xyz, garnermic@fb.com, Delphine_Chiu@Wiwynn.com,
        Bonnie Lo <Bonnie_Lo@wiwynn.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH] ARM: dts: aspeed: greatlakes: Add Facebook greatlakes (AST2600) BMC
Date:   Tue, 20 Sep 2022 10:30:34 +0800
Message-Id: <20220920023042.19244-1-Bonnie_Lo@Wiwynn.com>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT061:EE_|PSAPR04MB4373:EE_
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 28188756-d697-419e-bda4-08da9ab026be
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWjeQHocWboMEItBacwYcR5RWtojqAbs938v9wnNzBJ1LG37SS3WFXj6aJxXEOh+yHsNVbojv22IiMOAkweBCocCB72RlZ9ATmUNq5mf1xrHtpbEFLtqDfVlne8AQ6wJ3sKMLG9Cy8sIkvnnev/x765MBSz6wQzCVjm4q4TrhikNoPakUGWToC3PtLaYGTO7FDH4512tnAT8HJ0F+FsrbVEzoj0nJJk23xz/efI35p/UNIAbvgxDyZyOITG/Coz9MaCxphSaUCRfJafnoeER7ETRWIYR69s0UhaZfWvhKr1T5QM+O2FeqM1xdSBX4mOAYPPQW0Cfi5Hi3++VIElZl0gaD1rDN8znezK2G8ew8AWOKngZwAIYGY/lazxUrc82t1JasZuhdF1aIcxioKRofEqs9cOC80JQSKd16GafrVRsl/MRuJHzSDB/m8D/eSJwxw3p640jWIAJ8rbGDhpmWbpAJL8XEwx7WEzZ1td7XB8Zo0uFo3coBwmGDn38W3Ux6YNLmlH6WtFIv1KySucT1158ccsq6+zM78dmggrDP6qSsC0SYH/WwFtaJ1Bu0xiBIMYEi7y4FMKm+E0y6aj7Bu9hCOVLRurXz+x/2ld3eQRDbf6l7/P+EHyzHU6SXta07fP6B9pg3JNP+QuXN+7VwKCIkVd1WpvB13vVoHhLkEYP5SHCORNxkCqX77wdRwOCLuoHBqWSc4mDjN8hYVLtC43cz7sjydzV0UGXb84KGZNPNRelyQd1YSdgEaQSwMn9
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(346002)(396003)(376002)(136003)(39850400004)(47680400002)(451199015)(36840700001)(46966006)(82310400005)(40480700001)(36756003)(9316004)(2906002)(36736006)(36906005)(316002)(36860700001)(47076005)(8676002)(82740400003)(4326008)(7416002)(5660300002)(70206006)(70586007)(6916009)(8936002)(86362001)(54906003)(336012)(1076003)(186003)(478600001)(956004)(2616005)(356005)(81166007)(6512007)(26005)(6666004)(83380400001)(41300700001)(6506007)(6486002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 02:30:56.9584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28188756-d697-419e-bda4-08da9ab026be
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT061.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4373
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bonnie Lo <Bonnie_Lo@wiwynn.com>

Add linux device tree entry related to
greatlakes specific devices connected to BMC SoC.

Signed-off-by: Bonnie Lo <Bonnie_Lo@wiwynn.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-greatlakes.dts    | 247 ++++++++++++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..d9f417f2d7df 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1586,6 +1586,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
        aspeed-bmc-facebook-elbert.dtb \
        aspeed-bmc-facebook-fuji.dtb \
        aspeed-bmc-facebook-galaxy100.dtb \
+       aspeed-bmc-facebook-greatlakes.dtb \
        aspeed-bmc-facebook-minipack.dtb \
        aspeed-bmc-facebook-tiogapass.dtb \
        aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/ar=
m/boot/dts/aspeed-bmc-facebook-greatlakes.dts
new file mode 100644
index 000000000000..c368eb33efeb
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+       model =3D "Facebook Greatlakes BMC";
+       compatible =3D "facebook,greatlakes-bmc", "aspeed,ast2600";
+
+       aliases {
+               serial4 =3D &uart5;
+       };
+
+       chosen {
+               bootargs =3D "console=3DttyS4,57600n8";
+       };
+
+       memory@80000000 {
+               device_type =3D "memory";
+               reg =3D <0x80000000 0x80000000>;
+       };
+
+       iio-hwmon {
+               compatible =3D "iio-hwmon";
+               io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+                               <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+                               <&adc1 0>, <&adc1 2>, <&adc1 3>, <&adc1 4>,
+                               <&adc1 5>, <&adc1 6>;
+       };
+};
+
+&uart1 {
+       status =3D "okay";
+};
+
+&uart2 {
+       status =3D "okay";
+};
+
+&uart3 {
+       status =3D "okay";
+};
+
+&uart4 {
+       status =3D "okay";
+};
+
+&uart5 {
+       status =3D "okay";
+};
+
+&wdt1 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_wdtrst1_default>;
+       aspeed,reset-type =3D "soc";
+       aspeed,external-signal;
+       aspeed,ext-push-pull;
+       aspeed,ext-active-high;
+       aspeed,ext-pulse-duration =3D <256>;
+};
+
+&mac3 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_rmii4_default>;
+       no-hw-checksum;
+       use-ncsi;
+       mlx,multi-host;
+       ncsi-ctrl,start-redo-probe;
+       ncsi-ctrl,no-channel-monitor;
+       ncsi-package =3D <1>;
+       ncsi-channel =3D <1>;
+       ncsi-rexmit =3D <1>;
+       ncsi-timeout =3D <2>;
+};
+
+&rtc {
+       status =3D "okay";
+};
+
+&fmc {
+       status =3D "okay";
+       flash@0 {
+               status =3D "okay";
+               m25p,fast-read;
+               label =3D "bmc";
+               spi-rx-bus-width =3D <4>;
+               spi-max-frequency =3D <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+       };
+       flash@1 {
+               status =3D "okay";
+               m25p,fast-read;
+               label =3D "bmc2";
+               spi-rx-bus-width =3D <4>;
+               spi-max-frequency =3D <50000000>;
+       };
+};
+
+&i2c0 {
+       status =3D "okay";
+       multi-master;
+       ipmb0@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c1 {
+       status =3D "okay";
+       multi-master;
+       ipmb1@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c2 {
+       status =3D "okay";
+       multi-master;
+       ipmb2@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c3 {
+       status =3D "okay";
+       multi-master;
+       ipmb3@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c4 {
+       status =3D "okay";
+};
+
+&i2c5 {
+       status =3D "okay";
+};
+
+&i2c6 {
+       status =3D "okay";
+};
+
+&i2c7 {
+       status =3D "okay";
+};
+
+&i2c8 {
+       status =3D "okay";
+       temperature-sensor@1f {
+               compatible =3D "ti,tmp421";
+               reg =3D <0x1f>;
+       };
+       // NIC EEPROM
+       eeprom@50 {
+               compatible =3D "st,24c32";
+               reg =3D <0x50>;
+       };
+};
+
+&i2c9 {
+       status =3D "okay";
+       multi-master;
+       ipmb9@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c10 {
+       status =3D "okay";
+};
+
+&i2c11 {
+       status =3D "okay";
+       eeprom@51 {
+               compatible =3D "atmel,24c128";
+               reg =3D <0x51>;
+       };
+       eeprom@54 {
+               compatible =3D "atmel,24c128";
+               reg =3D <0x54>;
+       };
+};
+
+&i2c12 {
+       status =3D "okay";
+       temperature-sensor@4f {
+               compatible =3D "lm75";
+               reg =3D <0x4f>;
+       };
+};
+
+&i2c13 {
+       status =3D "okay";
+};
+
+&adc0 {
+       ref_voltage =3D <2500>;
+       status =3D "okay";
+       pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
+                       &pinctrl_adc2_default &pinctrl_adc3_default
+                       &pinctrl_adc4_default &pinctrl_adc5_default
+                       &pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+       ref_voltage =3D <2500>;
+       status =3D "okay";
+       pinctrl-0 =3D <&pinctrl_adc8_default &pinctrl_adc10_default
+                       &pinctrl_adc11_default &pinctrl_adc12_default
+                       &pinctrl_adc13_default &pinctrl_adc14_default>;
+};
+
+
+&ehci0 {
+       status =3D "okay";
+};
+
+&ehci1 {
+       status =3D "okay";
+};
+
+&uhci {
+       status =3D "okay";
+};
+
+&gpio0 {
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
+};
+
+
--
2.17.1

WIWYNN PROPRIETARY
This email (and any attachments) contains proprietary or confidential infor=
mation and is for the sole use of its intended recipient. Any unauthorized =
review, use, copying or distribution of this email or the content of this e=
mail is strictly prohibited. If you are not the intended recipient, please =
notify the sender and delete this email immediately.
