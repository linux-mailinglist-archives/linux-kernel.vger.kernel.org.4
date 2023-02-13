Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C16953D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBMWXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBMWXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:23:09 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B084EEC46;
        Mon, 13 Feb 2023 14:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLEv8spsmEW93KfY/BVd7UyhV7GNS20+1xX2ATj+vYZL92ZUZXup0dMyaPtw7Ihrl4AkQmKYI2bOGY97wblVyaU70KgZCuXd2Wu0aPvtZfhzX8ICt3bn1DxsOW+bEiGL8fsEDQOrHnShi3yQ3C/aocLLf0LibFhgjfBQeUWm/CebWsBGBHtUSLiioYPWXNTLP9ku6S4Umf8FM3P12MoFympogwo1qYCcy4RBeM9b5wDtJ7bL0SWk0C4vZhtRZYWC9s8WzHPGzwYHWG2lypBZ+4IYjI5ucuunbS58dh4noD25oJjyGpY8+nmj7JBJkEpuj6JWwphMd39n66kcdy2mtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U+byJApSlMPRL17wKlqp0R9J9bkddcFeEKZ1Fs+9+0=;
 b=Pj6KZZB/UvINrssiAckkJHyBCMyazGAmH8MrPe7ONpnDFAraLqp8xLyPh+D8DUwxYw2xc3tJEmj01ZOvOLLHXK/PwH6Jkb9JzM9bejs13ZG+ZDgX+ie5gxxmZ/aCChwZcsnS3D61OBH2MXFG2WoZZPiy06kRuNpz2DNvQi2A8l371Mr6BH8Nk6NiSAsHfFsdcDKefiU7XX9zpgpLusTbiH1FJg7qjYlBbxR7oOvb1J37kkD7TN4Nn87jgko4NEaeb4c5fPZn3c+9ukiUGOxdGlAqLlF5TNJ6nRQRPTdQ/r2gV0tf/6IDQgionEqN4T3c3jNoHfzPjmmPPR+U6Mkb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U+byJApSlMPRL17wKlqp0R9J9bkddcFeEKZ1Fs+9+0=;
 b=NkVdEIZlTG3t+p01o2yaliMDVh6rtN1trfp3wUPm28i7gvvdyrv5+NsSso5iBl2QtsR5MKfxTXJG1+x0fqjBsYG5CYtRlqxgTrTmU520sd6/zzVuspnge8iwqYkJSasHAoxlJMzZt2gvAc9hEM9gFs1wAlnQ7Ine+oWiezGCNW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 22:22:53 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 22:22:53 +0000
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
Subject: [PATCH 1/2] arm64: dts: imx8qxp: add cadence usb3 support
Date:   Mon, 13 Feb 2023 17:22:27 -0500
Message-Id: <20230213222229.686072-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cc2fdb-2c4f-44d5-f546-08db0e10d8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //31MCLyhpPflAVPvD/QOnWKrOgE9GeqeRQUoN66gzsB0vyhpVkUJW7PvDr5PqWh3w9cxSiazLxkeppy3AVfWS/eFakHRiZchCtoMb01303kb2JDM/26aswTBU8JFdvl2B1C5g1fTGzA4h0sr0UDMbThDH96l6+sgkQ14vCdPBReooETEtGS/sJvd9izbRpJRPxfIw9gaKkrJwfcwCKe/va/69OsORfBhEMUe/0gTjjkt06zMo5vJAiQ6A8aO9o2t/sHNvqxoCPMQtxqu0F/lVj6vRm0ZKhQUJBAkhx9IrMekMDhqB1OlULFRS9Q85tRxnZsUrYw46hApUJUG6ikE2YIsea9O7XzRvRzVyBpDa75hJuB2rIRfrjDkl/XFgYDVvpsh0dY43DYUdzfHn9ezRVMBrNhFm7NHRSXalfvkUkc0AvVr2fsxc0LkvFl6SrvVTVg6emLlJkBd8vv1IgGTdKyF7/j1P2LMbOJhfBUlT4ovwYc1CDUWQoe88Fa0Ey08gm/vGn04Ec5EA7eW+RI0DWeYtibieJp9W9TM9+ircFbq2rg/ML6prY6mSNcm3px+/ca80HKs2aRjWZzldbK3m3OHcCMHV88VlEXjmKUtrjA8dMzn+MApq/fMOiWgFpGZ2ChQdVOHmMvvDmBS82ApCVSsCRN+81bTQ58pj8rtMcIKGX5IELYxojQg9Dn+f0zHL3vyKgywd7WCCuS4jRy0FDQTXGW7+GuvUMLLGbAUFq06Uc6XRUiyOTM9bGxRnnS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(38100700002)(86362001)(921005)(38350700002)(36756003)(4326008)(66476007)(41300700001)(66556008)(8676002)(110136005)(316002)(66946007)(7416002)(8936002)(2906002)(2616005)(5660300002)(83380400001)(6486002)(478600001)(6506007)(52116002)(186003)(26005)(6666004)(1076003)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gz2/OAmIGrFfOtpSgu20QDBoBa56rDGqOb1FURS/sEhyTAa3YH0LJDbvswdU?=
 =?us-ascii?Q?7Mc1TYifGO07VadpuQSl48i31X2Tx59v/MDw1cwdINqYXQhZ9Yj9I2QuBZ38?=
 =?us-ascii?Q?TVrWp5fZ09rOVODP/Pev5S60rMCFtO1zl0DJBBqYGeo+Zqs65/PwjzgEWpNP?=
 =?us-ascii?Q?qLdPl3M1iXtnoITq2cT68LJHsy3tRy56NqX2xNCZy8Sp9EJU+To+14X7TmxI?=
 =?us-ascii?Q?sWk10ljoCECd2bAxlgNHQf+Odsdfv2SrBSxmBXOHp9cki8g9K8OSfZ/EmN+3?=
 =?us-ascii?Q?/9gZ62FsbIYLQmbXv7o7FnrSCq2vY2gw/pSlfuCrNEIBenbyUUaPWLqhCiZL?=
 =?us-ascii?Q?D8Y6P935AaXjrjI4JWMr+qWDGlWXMBEfiZoJL8dNvGeZ1bUyIMjqCaquZjUb?=
 =?us-ascii?Q?SLkTVjAOlmCSbzerjGkxfODKCua586s1ogXiFLn3bcc7fG6gdZki+ykC065F?=
 =?us-ascii?Q?10gQeYppRcmgZcxWV5hUyuOPWtldn1pa+cIecMcBMglE0Irg5lUzXSgW2gu1?=
 =?us-ascii?Q?MxUbdkF/3SZy4/1irQgsgZpr75l5BOzembSXvAUgI0nliRdRijBEdd/Mxm8N?=
 =?us-ascii?Q?wWRCTi+b5KV4bMKxYqsLaDuKspjsJd+IYRxxvEqFOmJPQmJrPZC0NNbDol87?=
 =?us-ascii?Q?sCjF9oVGhb+axehyhCKtIjYm3L3xFPZb8tjN92HXGOtadPYo1ZiszCvQ6y6g?=
 =?us-ascii?Q?IqqApbuo3nHNHxeK0yxWar9EX1ffferyyxgivzlEX7BUJRrXkaG1/FZ5bVqN?=
 =?us-ascii?Q?emHAH6KmXBs6XfIbLF5hYgDbvS4Y+q7kqGabCW3XkpU18wFfR7ZHjIxAnU96?=
 =?us-ascii?Q?LUiQQ4yDevnwE3BNtE6O2E9od8DHV9TUdkIbDJ2QRxuTRVcoV7aKlddXZfk9?=
 =?us-ascii?Q?GQ+ceA3KGGegGSvDpR9g4Pv4P6O1AjXGGZLA1OAED+hjAVOCk7JPe+06jvZ0?=
 =?us-ascii?Q?yPiGHXwuCsw3YtL00T0X++DBGRLlpikq2wkQetpDExWA/it74wVstUxXljQ5?=
 =?us-ascii?Q?brAFPZHXiayaOGI09eHrnmyQC02obyD7l9Sh/Iu6psnww48BZORq0hGR7D95?=
 =?us-ascii?Q?gzQ5GuBA/vw7D/Zcp9UUQ6fC5CykQXGpjb9zwpozxFt9K1u+szQ8cRYocsis?=
 =?us-ascii?Q?WzyI0G2JbHXSyBzxwzn7+VnHKBWETXM7+hJw/LNXLutVW/1xex/mQ5qLWiH7?=
 =?us-ascii?Q?Hnc7mvtCnuJR1tTU8Lbbg8WoIYwbvrn8WF0Yv1JesnXIzhhLzs5AjCKBvS6p?=
 =?us-ascii?Q?Rqk6Dgwzoln+UvJO56XXnJEXN2+xMByotdOgR8suoSMT8BHV1T8sRp+OGqM1?=
 =?us-ascii?Q?Yy8TL9ylNBLBQFBaSLlJ5UdW9mKgT5nloW9BW+BpToPiZr/f6Bq+GxV/CszY?=
 =?us-ascii?Q?oqZ2lSjOM711yQr1J9dWFefITytb3Hwv0bIZOSKr4akU2W1cxdDRpg/YOAt7?=
 =?us-ascii?Q?rRPHe+804+TBPk1uX7+qrx2FOm4jQ/LebMilO75Lx9/EaQFsYBFzn3G1V2H3?=
 =?us-ascii?Q?tpa0tdBQfT+LRE1TXC6UpyR8iqzX2QCiD/3D8cIX4vrHT62gR1vQCF6bWoKV?=
 =?us-ascii?Q?tHzzSmlfdK69dtgOkfxp543qQ4Gl2Qm7fjec7mgR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cc2fdb-2c4f-44d5-f546-08db0e10d8b7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 22:22:52.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7Dk/rs1Be/Ip3ksmc26VGKjEdKdC+coC9XkXRMVcfpY4FynJ7LQQMh4x3L7kBieYKhB1TmYsXosP93anXZHNw==
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

There are cadence usb3.0 controller in 8qxp and 8qm.
Add usb3 node at common connect subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4852760adeee..94692cee25a0 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -138,6 +138,56 @@ fec2: ethernet@5b050000 {
 		status = "disabled";
 	};
 
+	usbotg3: usb@5b110000 {
+		compatible = "fsl,imx8qm-usb3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		reg = <0x5b110000 0x10000>;
+		clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
+			 <&usb3_lpcg IMX_LPCG_CLK_0>,
+			 <&usb3_lpcg IMX_LPCG_CLK_7>,
+			 <&usb3_lpcg IMX_LPCG_CLK_4>,
+			 <&usb3_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
+			"usb3_ipg_clk", "usb3_core_pclk";
+		assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
+			<&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
+			<&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+		assigned-clock-rates = <125000000>, <12000000>, <250000000>;
+		power-domains = <&pd IMX_SC_R_USB_2>;
+		status = "disabled";
+
+		usbotg3_cdns3: usb@5b120000 {
+			compatible = "cdns,usb3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host", "peripheral", "otg", "wakeup";
+			reg = <0x5b130000 0x10000>,     /* memory area for HOST registers */
+			      <0x5b140000 0x10000>,   /* memory area for DEVICE registers */
+			      <0x5b120000 0x10000>;   /* memory area for OTG/DRD registers */
+			reg-names = "xhci", "dev", "otg";
+			phys = <&usb3_phy>;
+			phy-names = "cdns3,usb3-phy";
+			status = "disabled";
+		};
+	};
+
+	usb3_phy: usb-phy@5b160000 {
+		compatible = "nxp,salvo-phy";
+		reg = <0x5b160000 0x40000>;
+		clocks = <&usb3_lpcg IMX_LPCG_CLK_6>;
+		clock-names = "salvo_phy_clk";
+		power-domains = <&pd IMX_SC_R_USB_2_PHY>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
 	/* LPCG clocks */
 	sdhc0_lpcg: clock-controller@5b200000 {
 		compatible = "fsl,imx8qxp-lpcg";
@@ -234,4 +284,26 @@ usb2_lpcg: clock-controller@5b270000 {
 		clock-output-names = "usboh3_ahb_clk", "usboh3_phy_ipg_clk";
 		power-domains = <&pd IMX_SC_R_USB_0_PHY>;
 	};
+
+	usb3_lpcg: clock-controller@5b280000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b280000 0x10000>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
+				<IMX_LPCG_CLK_6>, <IMX_LPCG_CLK_7>;
+		clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
+			 <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
+			 <&conn_ipg_clk>,
+			 <&conn_ipg_clk>,
+			 <&conn_ipg_clk>,
+			 <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+		clock-output-names = "usb3_app_clk",
+				     "usb3_lpm_clk",
+				     "usb3_ipg_clk",
+				     "usb3_core_pclk",
+				     "usb3_phy_clk",
+				     "usb3_aclk";
+		power-domains = <&pd IMX_SC_R_USB_2_PHY>;
+	};
 };
-- 
2.34.1

