Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120ED6C357D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjCUPUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCUPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:20:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0A20568;
        Tue, 21 Mar 2023 08:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyA3Zeo66fE0mryCIaqcywQ6EfPZ3y1/d71NQzsr+l3MyEk9I4V1bTdpkHoi2NVmhOVV+xf+VBebcqXXWBWu0oZEacPUIdqbn1qRGPR0tbTwBfU1BAu/fnlr9rkOZWQar7TXYlTEgPq/KjcJ8iBOzzXS//3ljhUUBmiuwU8vlVaQKJfvTU3NS7QoVWsD3hzj7aSNBTPVkeMPBIfoY1sc/j7z+eDckL9frmoPe0ep8y0qX7JNFRCSFzEgv5n/3FbLn+UwW3XWrvD/Qo4acHYb/fbEjGEeXNwIkSW9kOmMkF6nY/kXUgP6M7N9pUSc13LisG9tYdaXWHMaJswfX5Wg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oakmsn7afFQSFgu29gGjtwXJ2Cj7MtzJmQ0aSH9s+vI=;
 b=P8hmZ667stR6TcWk3421Ci+D0Ye3X2TbGq5uUNWXe9BDvcdfSWbboDLtib0Ga9hSiAcs2u1oIsLQfVxN7iS4KVwtomC7/GFzANgvqjKkP1/lLGXRDAWD4LFsukKAjJUZ9CSiR80DToS0+mmXXzwCTv1Nrjg2N7inGIGvW0VvVfhl2c6UPv9h1c4cnI00KjNF/RrQ5eGnK3tHLMPEgvfy3RYL0/DFHdzb6E4IdikqlLihr1zR+7/KxWIMaaItrmIuOWBJZi/MEnAMTRsB2MdYVp0n0gLqRirEL2pFK0BP5HOqii4D+styLEX0fJTO/rYPV8hqxQGdnehL3wTk0XaBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oakmsn7afFQSFgu29gGjtwXJ2Cj7MtzJmQ0aSH9s+vI=;
 b=Oe13dh0exBSTkPc0dLkoPLyMML1IkjrAbZ56GfwOSMuqYRe2H1jecCTyX23QMYA/LXpo+55b3LrKvHoT8no2KHEyfmaKbX1ET8ZHMLj1kyaaPiHGwxUth9Hwp4MY+Z+xRdgcp4pM5Bzsa6OGLzWfMJ7XIBPe/+g19BHz93VcQT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8819.eurprd04.prod.outlook.com (2603:10a6:20b:42e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:20:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:20:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v3 2/3] arm64: dts: imx8qxp: add cadence usb3 support
Date:   Tue, 21 Mar 2023 11:19:50 -0400
Message-Id: <20230321151951.2784286-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321151951.2784286-1-Frank.Li@nxp.com>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d95bc91-4e9d-4dad-6ebf-08db2a1fc69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vz2SLGs4s+FXOUMXUUv2erFO0gD+GoycNIUppcS5tFom3ASshGsDYVsOGChXLGv3OWFWuZwUBsLBRx0r4gPb4ciua0Bfl3wH6J89GgeOx/GmvB8E6CjUkP8sWq9ObmqIapquce5hIEtgbcgNqF37aIY3SrhFfDgw4sOC2rNO2TpaunHL+85wv468quCYndue8ettoiz9hA6vXNVFtV6E6Klpze2DBCCRdhhCPNz6Z6CAXrf86CEfVhcjkkATzpURcjJ9MNgG5fkyw0DIYiAbHFe1VYQ0PfNWTxN5EwKu/TewkBgW66iS9HIGuWp8Jl1UtMDyD8KsGgvH3u6G78jFR54q2Gq2hOyH9zVzc994tXUOU17hTIZN/trVgGfOhcC3b/5Rmtf8L3nynjHUHd+LeMLZy6H4+Tf2cV7wcG7OVmMc59Jxc53QCKE0onrEN05nh4rYnd00G1XYl8DEW6q5lUKSnXMkvEh0NnZ6B11h1ZMNcVZDfg+jjL6zrwY01yI/SiCtFm+O8MRdO44NaLR7s0E7gfhjEEM+4SE4dsXynxrSleY1BAoa6OSd7j7APJQO0R/MBtvwqaWHS3S4V4mQ4lJsnCWNBQS/0P9gmv9WMjQ2yh4pRkwD9Rn26w40vuHgjYHbfxEEvXDmAuswbVZHaEU36IpzeykyLLr1UMeb1xpZY2lT6H9Bw6vWCCL58RmEItnFhgi24IQuq0XYGutC3zblBl0xF/mVuzygTEKgVF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(8936002)(41300700001)(5660300002)(7416002)(4326008)(86362001)(36756003)(38100700002)(2906002)(38350700002)(6916009)(6486002)(83380400001)(478600001)(52116002)(6506007)(2616005)(6666004)(186003)(26005)(1076003)(316002)(8676002)(6512007)(66556008)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FsgKFOjNyeqf9QOP6R9AiVw9y+vhxwGAfeTPoG/gYL1+Lzy10SgzTyDa9fFg?=
 =?us-ascii?Q?YfFidUKnvYvWEbQ/HLwE2i990vHTPbb9oWHmcvgXRT480/kK/vSZ4IlfwFqu?=
 =?us-ascii?Q?S7nkNQ4Q+VZUWDIjAz1e4JMzxGsbqDug+1IZWloWKPqT+pjW/ZZl8IbQRDME?=
 =?us-ascii?Q?pnGLUlhK2/wjXuXditOb0ezntbaSTZisnVBstWn5Ytet65cCuxCnuVxrJEz5?=
 =?us-ascii?Q?Ym5W1rbBF11DgDCzm2eQE6G8/FKtZMfeGtRZ13+ZkQ2uY8lgw9UiA73omDN3?=
 =?us-ascii?Q?GW7R0ITGXIB5mGR1EMxqOolMIiaqpGOaEndnRS0q3X9m0S2hg5XNZwdgpckY?=
 =?us-ascii?Q?hOY81xTGfvv1UAi6erVz0E3RhfzUn3BB+SppNUXHJQ6iPWIqWJnOhLVOBpS4?=
 =?us-ascii?Q?Nqz/rzZ/apky3A0sXkwsH+VIrB+6b8dsKcLhlpIkfUFh4ezThB4wBD/WR9CL?=
 =?us-ascii?Q?j7VPN7LTan/M8pEIbbvn7JVxuM4EW+lG1BUf+XQcz+ALcw7G6mgGoX0yfBN5?=
 =?us-ascii?Q?Y8xdO1dDjbqLJPqctpJvOSCzwCoUiI9on7byCyVgc7WGQGBPWf8cioa499m/?=
 =?us-ascii?Q?nuhWzPoPh6G6yat2ZxOIrT7eyzLZnx6NYPmPSuID+FygTuTYVK4cs1THgc84?=
 =?us-ascii?Q?CwJdrumsnegjU4xBLU7aRi/Oc0xH33ViYVWkdpP/CGuwurqnYd7Xh95JpW+u?=
 =?us-ascii?Q?j8k+hAHrz9ygiLswT2cokoZiQDE5f2Ap9CYheg3o0Hk8zK8cKpj832d2VfDY?=
 =?us-ascii?Q?gbOiDTN5XKQScQ2dNXXqV8lEeWBrovf8oZtp1pxtq8NxNQOZ6xx5eMen/luI?=
 =?us-ascii?Q?sau1MeFnV3q4ofqX/TnMIYZGR0yWDYgF2HYvn6PXyagXyZrQz8JxMZbnY11l?=
 =?us-ascii?Q?H2XmnoTcpJCZIrMn6hcdWNm8Dr/e2n89krgZcAkmlrQTdz5GrlUIwyE0xWWa?=
 =?us-ascii?Q?ZPcgrKE35v4WRC5Q9YHCAlTS8kad6vo/3Xdn0L7SVWCDb1+xnfviF0aSXqXI?=
 =?us-ascii?Q?d5h+iCq9p3VBs9kocq3ZbykT0K50fP4Z9m9cQUOnUB6xFSSksO+kxV3BxMmw?=
 =?us-ascii?Q?Ldshw2jew5HoBdQ7s1wtsBx502Baa+k7rN2szGsV8rwlpPddkwNBtRWrCzDM?=
 =?us-ascii?Q?ySlNXP6F8RV/pkJFJnXPe2waYZxbgZDgAbv8AmJOEPaKLqHlJPh4i85mJvRn?=
 =?us-ascii?Q?bGMDsOWDfdHbmfNun38IcOIZgb5Ld6UZEl4CJQiZmBYcJ+SiKLV0TNbVMXFP?=
 =?us-ascii?Q?STEmimNu4ufKgFfYstoY2SYdL8xCbpb14qPD3So7YmTQZHTdcYexR3Z2iv0r?=
 =?us-ascii?Q?a15gHBV+mTlSG2EPVj71KXohfP0BisN68B6118SkhxG8BYsCI9MvpZjuUxNZ?=
 =?us-ascii?Q?UeD8Ap9I9jtpkwm0IOASxI/uEmQl4iG8YNaJTphDcimuWzGzOghe2gIF2m/f?=
 =?us-ascii?Q?kebBtW9cQ0UCRWW5u0OztTopZTDR2x/l+LilL7b6wtp8cXJbfgX9mYy9+9qy?=
 =?us-ascii?Q?5qhGwYBkRjzyx9gWtHtIaMpnfVYWsj4dcwfXyf/i+Vl4q8Z3TdxPATIpfcrn?=
 =?us-ascii?Q?C/Iwq31htpndhIKM3AyrdgJ00WdKL6R8s+6NGi/G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d95bc91-4e9d-4dad-6ebf-08db2a1fc69b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:20:16.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUnXbK9S+AU2GrmCf0WRoyiKCoYUPyq9+gaULJwkJyGqxYWqhUOhJh9wmnkOaKKfcVlMOTRaGh1jM73qjEHsnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
Change from v2 to v3:
- Drop fixed frequency clock. See binding doc patch.
- move req as second property
Change from v1 to v2
- fix shawn's comments

 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4852760adeee..a08608312f16 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -138,6 +138,54 @@ fec2: ethernet@5b050000 {
 		status = "disabled";
 	};
 
+	usbotg3: usb@5b110000 {
+		compatible = "fsl,imx8qm-usb3";
+		reg = <0x5b110000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
+			 <&usb3_lpcg IMX_LPCG_CLK_0>,
+			 <&usb3_lpcg IMX_LPCG_CLK_7>,
+			 <&usb3_lpcg IMX_LPCG_CLK_4>,
+			 <&usb3_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
+			      "usb3_ipg_clk", "usb3_core_pclk";
+		assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+		assigned-clock-rates = <250000000>;
+		power-domains = <&pd IMX_SC_R_USB_2>;
+		status = "disabled";
+
+		usbotg3_cdns3: usb@5b120000 {
+			compatible = "cdns,usb3";
+			reg = <0x5b130000 0x10000>,     /* memory area for HOST registers */
+			      <0x5b140000 0x10000>,   /* memory area for DEVICE registers */
+			      <0x5b120000 0x10000>;   /* memory area for OTG/DRD registers */
+			reg-names = "xhci", "dev", "otg";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host", "peripheral", "otg", "wakeup";
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
@@ -234,4 +282,26 @@ usb2_lpcg: clock-controller@5b270000 {
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

