Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A956CA84F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjC0O4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjC0O4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:56:02 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22F46BA;
        Mon, 27 Mar 2023 07:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQBroMEyo6DeErA9xMSv7NUp1ddw/pkk9bY3m67N6MnUo9+YVCbxblTW4XqM5ria3LzEs4xpijpqIZS4yLGdh60f/8GfnnHiZIPfyn4Q03yEYOjTkiTJBOzqlBCyfa8nIVbCP3/my2RB7tZkOLci55W5h/5tpFYiJ7UL8JLkPk6hNYIVZCqBVE2soJut2zL6Td/nIswRqWBCpC5szEZdHOY0rFdt1K8NIvsbjFEjvfLUbS2OBnJdiePM0lmNx0fMF1xF1z+T9OxWTqP+hv9rmRIboftiIzrJOc80wPkyvbuLTwhDvyt8Kjx5ChEeQftCSgyaee1peAVq5hbsOUM32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25b/fOBMFNwZ4c+cmUqlNFV1O5jXs1wsxLl/UzQmoxg=;
 b=ji8nZefxDOxfMmpB64kxWMFZAJQysOdvHqt5Z0SlNTZHzIUOJmtdMnVptwhT8O9lZQ0E1JFur3vQ9a8ZvIWQi/pb3Sp4o1Uyq5zzAkk/3l/OY5lvf9jrNnCvWUI8OAPfk67fTdZbVdhIpL1SZSpwM993uOoSCsdMNL6IbyGJZtM0PfLSvLl+HJEzYvtF0OIcoPl8dNmQHK9CHS409WWCDB4HhMciZEC7GGfsYMpzPWKopdlL/WI7xeN//WnEv3MUMrIIYAOYUkGT8b1pOYX9eJamv4iKlwxsini1mywUBe5/nNnSPfuperoluffmm4IkSvkCxLS3UQRM7ioDv3xv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25b/fOBMFNwZ4c+cmUqlNFV1O5jXs1wsxLl/UzQmoxg=;
 b=ApuiEtOr1pvNf3J39qhH8OAKwmn2fAC/ymNJjblPd3cn3c0UQgv5SAjscYVYw381CjGbTtu9+SqVNG2LVQyuF7bsLVf0sqWTWxDv/IJIlziwrJXIFCkIX4QcBWEJspV6ngTYJl5iunIXAOCSakwPJ8JpJm8W4t7yrpPu4/9LG1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 14:55:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 14:55:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 3/3] arm64: dts: freescale: imx8qxp-mek: enable cadence usb3
Date:   Mon, 27 Mar 2023 10:55:23 -0400
Message-Id: <20230327145523.3121810-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327145523.3121810-1-Frank.Li@nxp.com>
References: <20230327145523.3121810-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 1784b284-db2c-40f8-24f8-08db2ed35c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WcYZf35l+MlDAFx39l6LhO9R5aowgCh621o1DgW9bDz7eM2n3ZQAR7uK4qXX5TWnAlKISg4igo0kkbwWMv/6Y0D/A+1I+SnUpxrTKCTxCrGk1cXWnfuCtp9w4pJmBDh1MzQXPvFjlyNpmdzBzH0F5MXPH+40oi/VTYs00XKX0mBbcUdORt1BbzcRTKqKvjZE7OGS7tvwvFRwGfBaZvN+Xp97dGijINdznlmHYpWZo2G83ItG3gON7rt8mTpNji1gfm8drzOdssSOyjsObh1fM0j4hD2CTXzVDZIIM1Xmy+AOHM41TzYYj2ICXd533FY7wlf6TNI04G1G++xJomMyCbdC0Gjuium6BepXIfHn1hM+gdWeXoovIpzWbQe9AJsWQ6nadfSAgEs1UFbymKnHpINXgt/JprhDsmTlP/TZwGY69k+GX24aCs62W3P5NnkSqwAJmZ1a8O+4i9yK/yTmAAdTxZEbblBEbl5oq6LCMLp26a31tBI67WsU4yW6EfBFgJ2WoCBOKWptIEI895lkgQnF1gdOPbUr7nWmPneHQ9KAAjK95JjxgmwAPfUFmyMikN0VY5ii0vR2EJCxGqMt4U2XJxkqB81kHiohP6IYUu+bajxFZlgG2Z/Ayjvf9eNZYP2gZty99xdIXllSZwl68Og0QXq9umF6vtJwWSYXRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(36756003)(86362001)(6512007)(6506007)(1076003)(26005)(186003)(2616005)(7416002)(8936002)(34206002)(6666004)(5660300002)(41300700001)(6486002)(52116002)(4326008)(38350700002)(2906002)(38100700002)(37006003)(316002)(66556008)(8676002)(66946007)(66476007)(478600001)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/d7BbvqEDhzi5J+kXHYoH4PBw8cZB1Y2hbG8Jhl8A4dGJvAQLBdvUFpvykZH?=
 =?us-ascii?Q?AbRL99BytRuu46aX4KHP2cfbB5Ks32Rlxyqmx8hQSh4UBj0fuIR4XMmkTSJK?=
 =?us-ascii?Q?tHAyr5Kau2qkKD15TCuDGLndaHhvOze/9+te/W5l9u2v0rZIrSwOKWEmfb+V?=
 =?us-ascii?Q?JDlRLSgBI9EGeXlx1Lt8ivKYVP7JP67IbUAXLOQSweFeaad2Dol3GLt6i5EU?=
 =?us-ascii?Q?WHV8iJAsXv0O1nr/3SJDzHOs7tFRoOINGT188IE8KjJkatnjAYZEx3UmqbDw?=
 =?us-ascii?Q?ZAEMpgte/KgpV6mN/VmrPViZtEV2MA1du6RvammW/m8gMzB913VBceGP0uWm?=
 =?us-ascii?Q?vK/n6D24oL/2z0w931yYqx70aBt8Us6O1X6Zw3GDlJAUM5ojzJps7g0OlYR8?=
 =?us-ascii?Q?2EsXOycRY2LWouj0IX9NaK/+wgZ6kxhziGe1BOTNwO/okJMBkd7B2z9X1WSJ?=
 =?us-ascii?Q?LkkwPq4bnJ8jSXuKEaZSwTSs3cq1kuJKSPLnSj+v4aEPLsBzFhKYqNmMMfEO?=
 =?us-ascii?Q?SdzVivGva9a9kpl+iJbnnRkxwrLy3kJFXsp85Cre0b1VdVJ0gFS6eU1Mqo8i?=
 =?us-ascii?Q?hNWKIl1Gndd3KCoZ5+KIQESbhOYPcyrVgBybOJG5bKjdrUKieMJyPueFlb7d?=
 =?us-ascii?Q?FaWilQuL3nyYv+6dgP/E8JaoRCr6sVK/SST3WHVfkiSxdHUQoVDxQPJ6k61s?=
 =?us-ascii?Q?kL08cT+y8BSdjjThwRNPcEuaI9JyxFWBqVxIqS/g3d2t2Y02n9RiFTPKS8AH?=
 =?us-ascii?Q?kDHSsY8Nrk1GslYgHO9NPUdAqEqAXcHrp14QOU1jylSzAoeJN7JQTBn6T2Xp?=
 =?us-ascii?Q?mULBTEg01bWsPxAk4OA80qEAYm41BcYvq8yRlDAkgLd8L7FfhJh7mtzjMqIA?=
 =?us-ascii?Q?0f+hiX0AI2l72LRPNgiMPRcaFo/an6iDNU8snnjdHHY628gzxETtVKPVizRz?=
 =?us-ascii?Q?T4aEPrUYk7kx9AkqeFhbWuE77hFyr730vLMYleqz93gbDHqlZjU8ZmnbCccA?=
 =?us-ascii?Q?HTq4ILgHQJnJMPme00X3LRBgR1TKNJoWHwADd4+w2Y+A7C6CDsdXDNsE59QO?=
 =?us-ascii?Q?xloJnGTMmVM4SbqaoK7l2CfAMRcXmdVVoTPwEe6pgh6vfikszEKg8PLnV/iy?=
 =?us-ascii?Q?eF4urT/if8Zm8WOvy3hVewSvBtyGG2+bngrW/Gu8olTMZcNtKzlgzBgwK7XS?=
 =?us-ascii?Q?lJAQfLUHCCz9ySybvGwQbMkSbEjRHDgs1zSH/A1YYOnL/1jsSoT60Y2QXaRk?=
 =?us-ascii?Q?4eb23y5b/35itBZQP2aOhcdOcB0ajb4lGhQ069uLb8T+fANyqZq1X4jxQo9W?=
 =?us-ascii?Q?yx149mgcZX/BEDtJVJ3EgG94jK6OhqM7sazRoKiXD6CdTfFOzPjtihJFHIay?=
 =?us-ascii?Q?FCzwHVVHbpMoHX3y9OdvM54oOZNfMZ2sjRO1eYCTCv01p+gVCNZE35CEjdVM?=
 =?us-ascii?Q?l2pc3AMGYrmhmVyOi3B6eJJEAJXvIDrrlqLxbtX9loHDySjMpTbgJrZCDW5z?=
 =?us-ascii?Q?HpbgTtDU9c+8etzyIoSm2aQWRJbELUkO1N8HTO4ottVCu6sS1FEux87DnwWX?=
 =?us-ascii?Q?/kyH3USxjJpv0G6mEiLnNa2J5hxEu5naEKI0kMOO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1784b284-db2c-40f8-24f8-08db2ed35c59
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:55:52.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90REwC9on6S21OcM9jcjjoj530zjJmKiDuxU/ninvqckXT+5QnDM2z4r6B57EroU2DNMy9O92ykuIENNlCQ0rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB3 controller, phy and typec related nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v5
-none
Change from v1 to v2
-fix shawn's comments.

 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index afa883389456..9ba4c72f0006 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "imx8qxp.dtsi"
+#include <dt-bindings/usb/pd.h>
 
 / {
 	model = "Freescale i.MX8QXP MEK";
@@ -28,6 +29,21 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	gpio-sbu-mux {
+		compatible = "gpio-sbu-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec_mux>;
+		select-gpios = <&lsio_gpio5 9 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pca9557_a 7 GPIO_ACTIVE_LOW>;
+		orientation-switch;
+
+		port {
+			usb3_data_ss: endpoint {
+				remote-endpoint = <&typec_con_ss>;
+			};
+		};
+	};
 };
 
 &dsp {
@@ -127,6 +143,42 @@ light-sensor@44 {
 			};
 		};
 	};
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		reg = <0x50>;
+		interrupt-parent = <&lsio_gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		port {
+			typec_dr_sw: endpoint {
+				remote-endpoint = <&usb3_drd_sw>;
+			};
+		};
+
+		usb_con1: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "source";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
+
 };
 
 &lpuart0 {
@@ -204,6 +256,27 @@ &usdhc2 {
 	status = "okay";
 };
 
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb3_drd_sw: endpoint {
+			remote-endpoint = <&typec_dr_sw>;
+		};
+	};
+};
+
+
 &vpu {
 	compatible = "nxp,imx8qxp-vpu";
 	status = "okay";
@@ -267,6 +340,18 @@ IMX8QXP_UART0_TX_ADMA_UART0_TX				0x06000020
 		>;
 	};
 
+	pinctrl_typec: typecgrp {
+		fsl,pins = <
+			IMX8QXP_SPI2_SCK_LSIO_GPIO1_IO03                        0x06000021
+		>;
+	};
+
+	pinctrl_typec_mux: typecmuxgrp {
+		fsl,pins = <
+			IMX8QXP_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09           0x60
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
-- 
2.34.1

