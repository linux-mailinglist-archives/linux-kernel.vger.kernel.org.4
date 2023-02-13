Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2BC6953D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjBMWXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjBMWXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:23:13 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B531BAF6;
        Mon, 13 Feb 2023 14:23:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km27YAM6lZ6TH6YK0W9WpNDFD4NKf6ZYOhUjniHa/wkBBaXFyRFgnR1kMHW0ij1XWb4etHea0CLWNTVfOpYfd4y6mbjd+tiZsQtPoXryZDpl+nZ3LQcfquhlMsXfnbEkzV0T+oqVMsxIsPgwPX+0d/i7EBc6gsIeALmApEuVYVVLqL3xLJQ32rkuX9+yDjBp7GMRlsOE+fjk7LLXoepfDfpV4gREBV5leeYzH9uDOzzrf/fkQ+c2XbZo+gdmz3WUkmOivRXQxUqjfZ5W4KiTxNDqvVBSy8lFDuGdSEKfkvM50kRa1cSk1B5AfAwisRFWlWYfTOFl29DZbctvuEJkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LIpkf+6B6pGBG5rA0oJi5017tojUEm4VkOVlQ8XJo0=;
 b=m0S2vcsU+4cfs7+OM9vobUfW0ui5EwdI2gX/MmnEU5mGbJkCpPpt8ei2pscjJs8dpQRCCjyPgR+tqn+JOoSink2Vk+DVZbvYXlnvXN5NZryS9KcUVOdxg3S/lj/VAXPShZRo1lxmIkuUwnm6iI8uCwc8FCmSR98QKsmHGzy3nCZX0xjVXDuHwNnDJFv6sGBNy5rDZIDEa2L0dY1xEjglw1PY7abThzaySaMJEMYpiAF95yIdAu65LbQ6Ap4JY3Fxetp3uxQ8RsFxg+iey5PW44X3Uj8/h2DMnvgeU8DzQyPhjvf1gu8kv2sVy4F5UCuMvhSqgCDcBbP35IZqHMDYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LIpkf+6B6pGBG5rA0oJi5017tojUEm4VkOVlQ8XJo0=;
 b=kG3G6cwBF5ubkjT3xsbST0JPcpX/q4UZU+LqvtPR/+Va+F/4s2F6x6pMnlJUFj7nQeVuFIxHUtLNqIeIpkgeT7zjBswhYQGYI7O24oLiDQKffKCgvluq58khUU7NAaCBqHVeq91HF7BLfVpqp05W+e9+kYEMxXGvNZ0eMv9VnsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 22:22:56 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 22:22:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 2/2] arm64: dts: freescale: imx8qxp-mek: enable cadence usb3
Date:   Mon, 13 Feb 2023 17:22:28 -0500
Message-Id: <20230213222229.686072-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213222229.686072-1-Frank.Li@nxp.com>
References: <20230213222229.686072-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f6bce5-7623-4c0d-b192-08db0e10db3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYfic7h5dLHsc3WtiSLT1z95hv8kFqftlQUAC+J/pBWh2qxPL6zoNH/26ZW8r6YlYfxXc822KZzEDagWhaLVFJf4hOKgR6yvwn7JsNoO7m9RlBDFhfsf3JBxD/eNmx4dT5K7ZUwMsxCmb8D2PblTM1vBMgZKZ87aN/zxpn8rlVItOuGn0jKgBmFlDYAKqDBRDEIlPQNkUHHX/lPD58+ozvi34lHLaxVb24qTvs/mXVgQy6vmTUfgL9uBcta5hFt7TD++VRk7/LC3jkWM8XJieofB8UhiCY0Pi0Te36e6acyzzhZPAj6JtAHE8PGWgX9StJbGq+V/+qK878v9Z0ZsYbC/7WNEaWQ4OnSbfxi4TQe3J1Lc/7QENpXlGHnoRZI5w8sQJdrqkekgAYB611Sq5thqnnIpuEOP3AR1oihLqjVSAGYBPe27FRhzYqmCglS/Vi/MAejyxUWoRLyt4Nyps1EEq+Hw4eb/7GHCez5NphOa6Sv0vhMJMvRnVZq8Gj/2CYnjcWO+89jCNveX8Pacuslf1FGHbGo9vWMp7ogoi7rpxKtYo7VOuLrgAOb069e4fOQWDMYPLQYj/FXO6iM5e/0EIi4UTmQPAgPzbFZ+ZUggDHPlfsf2NoERTduck4yxzXBJ1EdwfGrcAo6v/BVq4Yk2voqGv7n3FUf4AgbrkVCqoTPht3GCfOQ4BBWEwRZw+KUOAlMPmo+uhH0p9CqUJeG/OBEMTjbeDg0GruQ3cZmGzuP3TqM+YXba9ATZQIsoVXDvYlD4uLFCepNbmJMQGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(38100700002)(86362001)(921005)(38350700002)(36756003)(4326008)(66476007)(41300700001)(66556008)(8676002)(110136005)(316002)(66946007)(7416002)(8936002)(2906002)(2616005)(5660300002)(6486002)(478600001)(6506007)(52116002)(186003)(26005)(6666004)(1076003)(6512007)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmFvkLga4936iSFSuF1qJ0WzmPk1JtZJbLpAx7LOAOTSqFFkfGvKS1mBfJEr?=
 =?us-ascii?Q?N+g5EeqyoZfKYmqY251C0HWbpghdiZYmilGcoyGtWaOeOXqofup22NMu6zvp?=
 =?us-ascii?Q?s4vxBjmv1cUmdBrBG2z50rkpbodhtopaVUrX5Znwi42DTzBo2ODshMM3Y446?=
 =?us-ascii?Q?bKaKC5ER7QNZVzTTCuWA/d3mQse3mpvkO2nR++w3IuEDL0rrb/8Z9h4sFdOC?=
 =?us-ascii?Q?7GTC7GF7lXAgZYgW67i2XUW7Ad7O0VPjuBoPuKCvmJWR/0+XfoMzezbXhsrn?=
 =?us-ascii?Q?qLLOn/p2Gks5hHVwL1SsBOMfw/hpAIquoNaMiphTHtaJutjgH4SsvzkQzENi?=
 =?us-ascii?Q?joUrwS/thM1xfTliVDE1y9YW7IXlYCI7HDPb9SJvfVHfwBcTzfppAuiXWbkL?=
 =?us-ascii?Q?NXVPa611OiwqPyeve1QSdM4N4pBXJYoN3EtEz8GNvxA3rRL5A+R3Eeo7fcOt?=
 =?us-ascii?Q?/0JrZy6pisedlGWE6fojqx0/1ytiG0xrMPto3vsF4thv8zysiuLfBIbj0+DM?=
 =?us-ascii?Q?MQ0ItaIKtY8gWgyzMVEK/6As2tjQ9U1+GSOsfrwBlD8IrXZT1Luk088BrEgE?=
 =?us-ascii?Q?dUQlYKw5wrIFX5jhybTGSdHSZxs1GfFlVm6pXeM9Il0Rgfm+X9igsai7KBfa?=
 =?us-ascii?Q?bNykeOIVexUdcG/WrURDPmhTqmgUH/Cuc61EzvfIVT7uefEiaeuBauk/Bgk/?=
 =?us-ascii?Q?3TDQxHaNSzkIwkCNTugCsnKVd57xPIaZjeoULN3HylCFokB11tIbSpTZAAaF?=
 =?us-ascii?Q?L7qWzpsR/ZLE/9jJFz0dh9+GwjeOpRE1+AhFj59MYm6PolkpE3SVXRzeJSoZ?=
 =?us-ascii?Q?eeohHwCytl2OLfKoJOyZ32Qq+6pOR8HTpNSXmD4t1hLrFbuumpZqCA5p6xIZ?=
 =?us-ascii?Q?ttQUoU/TWWGwX8fL9oGyclHbT7RW5ldPfgCnPqcAfZULGPact26hJq6z9aU2?=
 =?us-ascii?Q?sHxjTMCWtewIT2b2eJqSLOxHagUqwY9OeaIMmOnzdirCXyJq044SNj8FiZN5?=
 =?us-ascii?Q?P2fczs0T9JqY0A77NV8Ws4NaSJEDiE5uo68uReuLCQxuMxyYGQo5q0jS/+lD?=
 =?us-ascii?Q?l3l4ej7zojTV3Dw3SV9s4YxRO0RNKrBA9f3KKy/f1KsmEaY23/eAJmvsztYx?=
 =?us-ascii?Q?jLKxOXHHuQuGZr3aS7eDuSK1mQMn30UczI91aBMk8Rb2dI2cuv5x/jElxkny?=
 =?us-ascii?Q?pgi/0Rc8Ud/F9ga1F4y3bl5yjTiKMlY1r0y3Y/3hGhD5JOhj5RoUaLinGqFq?=
 =?us-ascii?Q?sZpBjuFdkcHNJsOeVFCZdMBhQHv6cQCyauZQ3qKbW25VMv7TdeG1VAnn/Dej?=
 =?us-ascii?Q?EVjZFMfeihMiD10vDUJ8DgXGfmKOphuQDDGIrR29V+GklJ7o6DgSt25qzhrQ?=
 =?us-ascii?Q?h2oz0pVXR75v/zX274WxPfsK/mFee3ZbC46oRw1osiTHym5d8BJ0m5Dl64uk?=
 =?us-ascii?Q?gVbsb2Lk36IVny5e9QpDpsONuXcdwVz6yQ3LgaOghrHaUBRHpL7Q69L8gbiw?=
 =?us-ascii?Q?0D7t5rG0oLI7j4Bmlzr/YR+eKd9PnQfUmUNLBSowPqo6sZXDBKReQa6EntCj?=
 =?us-ascii?Q?CFceCyvvBPuxqdnilnpFbS6xi6tQePKHdMn/7k1Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f6bce5-7623-4c0d-b192-08db0e10db3b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 22:22:56.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BbMqqTgjy565lkrTykQ+IgRiap81P6OEpjazv51SxSRHjL1TIS68AU8hHz0NOnVzOs/hepQFKM04GRE3d17Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB3 controller, phy and typec related nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index afa883389456..64f20ff44ba7 100644
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
+		select-gpios = <&lsio_gpio5 9 GPIO_ACTIVE_LOW>;
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
@@ -127,6 +143,44 @@ light-sensor@44 {
 			};
 		};
 	};
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		reg = <0x50>;
+
+		interrupt-parent = <&lsio_gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
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
+						typec_con_ss: endpoint {
+							remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
+
 };
 
 &lpuart0 {
@@ -204,6 +258,27 @@ &usdhc2 {
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
@@ -267,6 +342,18 @@ IMX8QXP_UART0_TX_ADMA_UART0_TX				0x06000020
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

