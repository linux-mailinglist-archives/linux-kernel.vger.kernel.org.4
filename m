Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFC96BDAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCPV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCPV14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:27:56 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B4E5024;
        Thu, 16 Mar 2023 14:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2rIxPHFEMzHYRVmaSRhmmTGGQqtp9D84ypeAVA07HGJIK6iG8eogaNTN5igICRmlWnZPu3T3bg5YoRRMqf0UqbqD/OFDi/1uYeYdN5AMRXZ6CkvAj/yb/cIeHn82XCKmxmUVgWG2BqrDcnd6C2tehEzRIE5QRlZBreLwoH8esWKbIYDudwK95zsACu1cwo13KETVHyVUxcZIA3DyAbMJjDDt6gNdEBmMCeGupRff/yS1grXJlF5d3uQVNV37KKW8TJpr9dbclg2KszwlG44lEOxp/CGjMCVFiboCfZOlDLfWobf502bFL2BCRkO0ZQI7Tlq9tGroHaAEw4c7kUO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7o9y1Z5tDig9CwgQlfGYEvKmYlwQtYljplWQC01wCU=;
 b=CtmuUFC1N/5qo7+M9LxEUgnOeC3Sm4Ph3g7b5c70aY0oDj9ntZPtLmPxCozfVv659TkHl7n/z7pjUTZL5optpuAoZ+x8+83bSQ0/VDWwUtsRTkMHZF8bK1+VW7Kj/bk+gpKLx5d4jba2zoBm1X9et+HvlQOQnxPXH42DU5yiHzEsBpkTNzPWrMFe/ou0PkQ54wBaH5j4TOYO3KHjpwv6hywkT0FT/yUdJfyVD5VzWhafQE3zyOqgSFCJ2qQK+TYiVURlFmFYsLrgHxFKYshNECHqDp4mV8a4vUM7lIIxb94X50cGkMCltk7ZZdd3uMsWlbh9pLrU0VchwXQ5r3dakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7o9y1Z5tDig9CwgQlfGYEvKmYlwQtYljplWQC01wCU=;
 b=fiTsEHgP3lVf5nu/eJZQFgGzcaHSaxJCe3SyyYykHseR2gd5oY4W6ViYQTZkGgH+KbYBTILcymsTdbxyw7q9Do/S6OnQDmFtyMj3D4xeZBQDu3ata1bzyIYO9NKvIaFFVVUQews1euq9JW+F6s9mL8tKRECpi737oXg2bPuIb58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7332.eurprd04.prod.outlook.com (2603:10a6:20b:1db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Thu, 16 Mar
 2023 21:27:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 21:27:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Subject: [PATCH v2 3/3] arm64: dts: freescale: imx8qxp-mek: enable cadence usb3
Date:   Thu, 16 Mar 2023 17:27:11 -0400
Message-Id: <20230316212712.2426542-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316212712.2426542-1-Frank.Li@nxp.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2ea676-ebae-48d2-a77c-08db2665451d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTeXzOBFeyAC0EzEsG6HqC0zIE0JwcGYUMd86EAp7/QNtUcB2eZW8tUXcU9f54B5WbduPZauoS2/H3cbhapEIrDrdC4ht5wnqt30utS5NQgJ9+uMo+vxqNHiQBTedTjppyfa0V91ZLMGkFJ0KEpxvuJ5K88YVPSzU8CAXKt1s7/AU1mqTugXkVgSp/EaLBfST3SP2u+iKndnjhappyZSd/ZEADB4wtdxDhJwVUUnudofpASDQvTRGQ1fLi8DhJ1BuCtjGhHLo4wEW0JGO1XsNp0SzDfg7zQiFsWP+68Glmjh35L3qPucHx0Dii7tJHJwEouGwvR7OvUN7DbFQXbtQPxNlgbrgmdVdEWxmXioBM4oYkjlMcg9PXSrVe+0N0KpXD4+ikCgINPIN2qXB/YPphRGuTWM2RK5Kk9aawTMbq7mA5vqTQoDvbQ2xcaaZxPUhqLAyXNgIgYpG/NhnRGeZzdLwWnHsMRJjJJ7guTKNdPsZYFnB8gXlsiYYkAQI2OgH6JsMt/ReLzOGtJ189E7hCbw8egQZmfZvCEL3lD6dWj1cRZFdRjLNwwNplH9X6qxHX5XWHWZv7SkhaIXTgr2dY7pYF+/SqKLjGq4ajRtBprUcTnX3drOJiz9zlTLMJHVq9/AHdkwZ04VhHyBlZOxKwBTe0ferfKR97TVQYDALtI26rvA2/YGFwHitLodqccrcMSbnh0b+mA3nrzaxPzBsXEZIZqP3+nVBPreDYMnRnSPlkgFia9xnQnWR6wQdcqj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(38100700002)(38350700002)(86362001)(36756003)(2906002)(41300700001)(7416002)(8936002)(5660300002)(4326008)(6506007)(6512007)(1076003)(26005)(186003)(2616005)(316002)(8676002)(6916009)(66476007)(66556008)(66946007)(6486002)(6666004)(478600001)(52116002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0W0xtir7ijH4v9ocahKs7ZOKMVhRHxLm4z7VNWlfKXp3Ke/5zCNhKuE1Ueuv?=
 =?us-ascii?Q?A0e4fsVqbWM6zoiEEp0TPF/ARwBLT9AuPfbPQMR2fMplqXrHXe5lRL9z5fuo?=
 =?us-ascii?Q?xpceTJOVxRBWN3PR9cpvq/O+77eoPj80tzUSBxB3+IE3WPH0qniKMUyhbUIa?=
 =?us-ascii?Q?NYYLhCNYBWHbvfoCoEa30zjboO76nwi2xMPNg7/hIQdN/wPI3gUGU2IegzBG?=
 =?us-ascii?Q?+a4Rj9eoseMxNF1meizyuxL0UNBx6tN5RLA4NEFRFQxPQLizsIRnlxYk6hZI?=
 =?us-ascii?Q?vs++f295rqhguIWclJDo55nNZBhMzAGpDTeXzOuXmwDTKzRvqNuEnhMUdN9e?=
 =?us-ascii?Q?M6af+HrPX0VjrpwqKHgSdQOg1Fc3p5RP9DktzP+ooM4vA1bft9XKYeVDEYEh?=
 =?us-ascii?Q?hwiRmv29wjbgOxvz3jCXW4+oh97ejQqjpZAIOX1vyAbq9zFNB1jwo0Q3pKws?=
 =?us-ascii?Q?D9cwZbHGyo5xj3ebGyE5SZiUF00GothfIVzKdM22l0oDOUgaQ0YYR79WI0MJ?=
 =?us-ascii?Q?2X5Wp0pFBd/3kp5tFKlPgz338KMVX+aROw6kZPn4QxxtrkEvUnyUB4XudPPv?=
 =?us-ascii?Q?odAZzW+lG2Y1GZfad0KO2V/rC5CJZIFwtDO6jMU1qMrX34Cl5n96Z5uM5fGC?=
 =?us-ascii?Q?e6X0jxFsuApmCK5eVUsYXVCLZtuiNj7ETnJAvPMpzFKxz3Cep7BUzdULqiI7?=
 =?us-ascii?Q?/vLscIZUvAX5h0BQxl1iRDnk6NCzUlK0Xl42EobKJOP3AOub0t+3EJbv4xZm?=
 =?us-ascii?Q?ZrbyegRnP8EEW6ZFB/I9RGAa0mpIDi9jV803Jjbl785CRp90Mquaa2IxW6qt?=
 =?us-ascii?Q?lf0Gxb7sVCDO5ePD28RTpQRz8gy33beAmUhGMh2F4MZe8NG/Q+ua7//TypTB?=
 =?us-ascii?Q?zRDkUCh1uTFhShl+sG6cQuTGkHgW6porvF8hQ6t+s8V6OB8gEw9hfs75Qxnk?=
 =?us-ascii?Q?+1A+F1RMEdX1rjuT/KD87IBWCGbB7Sor8mE6sEkoB6bdaIxApyuy9fUYY3Tp?=
 =?us-ascii?Q?bqXtu8BwWNFvG2FGiFWYzlFYiamkfRQtkY1J1NrC7RKpvQpCi2eGRw5iB0KO?=
 =?us-ascii?Q?BQXtuf+i1yl+OA7to/jYmzmSib4oPPcbqJVsHCY7XGqmlRaqlvXhtVqZJAsd?=
 =?us-ascii?Q?CqdRjSHtILS64Q8d9eRb6Alht5VcJ1WTt+5Yv+pTRg64MRS9K3FCeaO6NTG1?=
 =?us-ascii?Q?YwPKSb/WBERMWZiqQUNLg6S4xgtp/7lz49e6xxAl0mCXmU/Tf2x8/zb0d13Z?=
 =?us-ascii?Q?jms2lG9d6x7BlOrp2WCWIBb2zAsdjn1cN79/Zzxl/jzp7zC5zj93ghAALoDf?=
 =?us-ascii?Q?7Y09GsQmNLALaPHxU/zPgA4KsFDPZmLcR3e1oJ/iVClrAyJGsyy5NXixm0Uy?=
 =?us-ascii?Q?Ew+nUFTk0km0htr0eN0qbR36/HVuR0eT8X1+JGXFc2qKaN2n+SI6p7uP3kGw?=
 =?us-ascii?Q?ZAF/CPx1qg8gCnBVTqCL8o6GnbpGmkQQxTA7BiOnTuQxY24jWXN/+3e+6X0L?=
 =?us-ascii?Q?+TaV4LAHofx/dBJhjd5zzRs2ixZahw3lXZ8ZrK7wSbZjNmNZEA4pdqwB0+z6?=
 =?us-ascii?Q?xqQOg0vRtt4BCF4MBoQJExi0pBtSoHPi+8qLD3ow?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2ea676-ebae-48d2-a77c-08db2665451d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:27:39.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLxwHQsf1EUA2F5Oy1xiTyMjq9crnpXfKcEN1esMQ7W42qdongY1lIrs1kANEJsG0ixWpKOIsyzmJMtN2VFVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7332
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

