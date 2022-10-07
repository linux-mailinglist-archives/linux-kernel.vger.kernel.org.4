Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BEF5F7408
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJGFzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJGFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:55:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2804CA26;
        Thu,  6 Oct 2022 22:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsSEypmpGwKIHy2rf7XP6ZCstm3f+9xanLsYnsAncymh8k7VhQnCjFzQD7Udm3bwhzWxiqiYPNvJLiiTuoHPkSSLOvDxG/DqcWYTvdmFk26Wo7Cy+hDAxtYSIo15CKAp2eI+TxapDMSl9WyXNX6mEarb3U2m1iLqOTvaEmxVpUuyWvxxj3Lx3F/CXfNILyqAPIh1ASYZUflmUrA9QA/liL8NO0OdWJ2taaUF/TZahVzY4ZxlshLZfO5qWL3cveLj91IeciSwjLnmBOMLeuC0O56GQEU9opmJrIvQBbvTZb5FXPHLA8QjZeLS1gGXOdKZT3SoCehxQn6S+aXx8bYv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQMz1hVZMicFHw73g1vElVHjNCasi0lD2dYdaynVkNQ=;
 b=jdBg6lrYSmZXdhyhVIs8/1SmUIK3XIGlJ7st0ug90+I+ZH2Zl9DYfHJjHkeX1JqgLL2CHldscpg/vkdd/B+DBQ3PGevFGKnxeyYcmLzL53nzmiV7V0o482SR88lfPKw7HDDo7JnbjMPjHP//NmNsTXn+Atb4jabYJhX7hJvRSQAQwUp80sftsoqavfsfndhlOhLjyzmdpBhdjiuyzQljQhornouTd0hE4kgPAk1aJjxKY7ljsrQZGri2Ie2Yx4d1vVRCUD3teqE1hryurRJB0vnn0XBU9BjFzkaJf39OgdPIc/M6oz3rWIdNvDoqc7HVxIWUxByLTuvpVQ0XzSfCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=linaro.or smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQMz1hVZMicFHw73g1vElVHjNCasi0lD2dYdaynVkNQ=;
 b=qT3F6p/wtC1uSnE0Jf4bXuMOIKUPejRtv208mxaiGBBXlTbXcgGBwGPJWRp8JEeZHpYCfTeWQLgaZ1CVpTkAwDsiywgrg7bLeO/TtuBPmnq2nVvu7OUllVlI0N9/2c9TiRiJXnGfeLJ3S11eZ4n6Z8fHRFmbCSZS9bEUHstPlW3dyNoupLbwdWaDR217MjJ0Nnc9UAT2KBL1Tjbp4EJKxeObA4IDW2mxShPzG71YjH9ig3j72VKEq+/FCW4MnZphhlI2dj529/htQWZRuf1asS6/wKjD5jTkS0iPv0jkL9eeOUEciLTBrtTQcDApMpAZorqkOsCFMl8nN73mxDMGIg==
Received: from SG2PR02CA0078.apcprd02.prod.outlook.com (2603:1096:4:90::18) by
 SEYPR04MB5883.apcprd04.prod.outlook.com (2603:1096:101:6a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.31; Fri, 7 Oct 2022 05:55:11 +0000
Received: from SG2APC01FT0047.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:90:cafe::8e) by SG2PR02CA0078.outlook.office365.com
 (2603:1096:4:90::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34 via Frontend
 Transport; Fri, 7 Oct 2022 05:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2APC01FT0047.mail.protection.outlook.com (10.13.36.133) with Microsoft SMTP
 Server id 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 05:55:09
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
To:     krzysztof.kozlowski@linaro.or
Cc:     patrick@stwcx.xyz, garnermic@fb.com,
        Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        Bonnie Lo <Bonnie_Lo@Wiwynn.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v3] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Date:   Fri,  7 Oct 2022 13:53:39 +0800
Message-Id: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0047:EE_|SEYPR04MB5883:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e60bed13-96f7-4800-eda1-08daa8287eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNScBUSzpwrgOVDPViezKxyAtKhFG0wU6f8H+8RREC0TNL3npsrGrnDOCn8B5mChkCImGMqKQ5gC6IsKRgecVHOHArsT8l5aSirV4iBeMavLX/e/nr7gIo+lVChOsYaNZBo5bn0FQce8ApKINFkkNpHm//60ceHPXBopb2XZjlT3sTAFsTCrRo9o1vVROXsJxlv1FO27xZG9TGC/HSQrK7K7kIj2k7ZspwKlQRIRISZ9WM+sB7Fqn8Ox+oWbKBJpFa4zWIbcXJK3SEKQ+CU26TY9/qSNEnjFSokYPb1lheLMSSzRFhYpa7JyOD3zhwMdZlkreNi31Yq7wWjzBCA8ggrZ3I4EEa/iztOHtaw4TLIlm/fgs7sWomEzgCM5o4xaGMN38JpEZcsX5UHCUDpfNpdiy4VUu/JrbvXdct1t/ZkmQsFHZaLuUbmvEOYj7HcS1UM+9yj8E3Gwe5rko7rE07DOWZDkDMhhTWx5Mn7bJ4CSWcxKxCyYUKucGBRFsCsfEs4OugBcGYA5QKt4TQKbR4xFodIp9tEngxOtN6oLbuSCH2xT0aIH9ZIcm0Tt3DtpvAF7uS0m02qa/9za38Fv+HMxz/zTEof7yD8TYVS28I6oE31ARj9oXLxbueE2ZuMUO/njdRFCfEF5TuZBLB770vi/B7GMIWE+7KFeJ5PhEduf6SGbkOH0y3e93nUIUADTWpVDxgmqJ6SKhFSAUGO6Hv2X7ardm8ESw57esw4LrBYAx4iaYPSyPTvKSBfY82Fw
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(136003)(346002)(396003)(39860400002)(376002)(47680400002)(451199015)(46966006)(36840700001)(6486002)(81166007)(82740400003)(6506007)(1076003)(26005)(36860700001)(2616005)(336012)(47076005)(478600001)(6666004)(956004)(356005)(186003)(36736006)(6916009)(36906005)(316002)(54906003)(6512007)(7416002)(8936002)(41300700001)(86362001)(70206006)(5660300002)(70586007)(2906002)(8676002)(36756003)(4326008)(82310400005)(40480700001)(9316004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 05:55:09.7829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e60bed13-96f7-4800-eda1-08daa8287eea
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0047.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry related to
greatlakes specific devices connected to BMC SoC.

---
--- v3 - Add documentation of board compatible (bindings)
---    - Add board compatible
---    - Remove the bootargs
---    - Revise the DTS node name
---
--- v2 - Add binding document
---
--- v1 - Initial draft
---

Signed-off-by: Bonnie Lo <Bonnie_Lo@Wiwynn.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-greatlakes.dts    | 241 ++++++++++++++++++
 2 files changed, 242 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..d9f417f2d7df 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1586,6 +1586,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-elbert.dtb \
 	aspeed-bmc-facebook-fuji.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
+	aspeed-bmc-facebook-greatlakes.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
new file mode 100644
index 000000000000..8c05bd56ce1e
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
@@ -0,0 +1,241 @@
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
+	model = "Facebook Greatlakes BMC";
+	compatible = "facebook,greatlakes-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+				<&adc1 0>, <&adc1 2>, <&adc1 3>, <&adc1 4>,
+				<&adc1 5>, <&adc1 6>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	no-hw-checksum;
+	use-ncsi;
+	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc2";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	multi-master;
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	multi-master;
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	multi-master;
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	multi-master;
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+	temperature-sensor@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+	// NIC EEPROM
+	eeprom@50 {
+		compatible = "st,24c32";
+		reg = <0x50>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+	multi-master;
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+	eeprom@54 {
+		compatible = "atmel,24c128";
+		reg = <0x54>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	temperature-sensor@4f {
+		compatible = "lm75";
+		reg = <0x4f>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&adc0 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+			&pinctrl_adc2_default &pinctrl_adc3_default
+			&pinctrl_adc4_default &pinctrl_adc5_default
+			&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc10_default
+			&pinctrl_adc11_default &pinctrl_adc12_default
+			&pinctrl_adc13_default &pinctrl_adc14_default>;
+};
+
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
+};
-- 
2.25.1

