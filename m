Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4257D6C6DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjCWQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjCWQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:32:24 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD692B603;
        Thu, 23 Mar 2023 09:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cW/5egRgE4QC8UdR3Rah8IZp9/UKA3NU6Uyr8tFIWVe7W368O92Js3pRCtBRrt0bfVHApXU/I21LQ39BjtggOIypVqfyoaRlx6/7cTkfAEWBD3LfMcj1pLMA3F88bhNALZaGwszNsrIHrX3Nqa0Pcp7a8PmdIw25fs/b6xQuecL/rgS4mfK5hm84fONAccoWCw6rxF0++R0ySVRQ7Ae9AYBfQxz32fBxdoAR5TuOg1ZsnT6He5Zi1l33a312L6nTCWRMef2OARLkM/DZ15iQ59LMn0L/1//H2i7/RZtYSSQ2TYUHwsUWLcLXA2L3IvbsYM5uWYZt10dRVTIcUn/p0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoMAOmU2j3LLP2H5izMGIhag5FFWAY8BXna6p9F61tc=;
 b=jNGxoTkm2V9OMOPYdppihy0Voh7I7BGQQu9oRcvM87oSeGk0+4+pcj/+MG6Iww2EkFWu6W1VF736rLZ6qzf2jjn9apzbgjtXCsZTc86TnUSjkl1XbnSkVucTOTOj9yb2X0B4vYPEeklnoteqpexZF2hHsa1OKDJ1/D3+H3Q+bM8UJ5XArcemQqikVIH9DWjRk2jg+7tZS2umFXS6l45Dwo7kMklHOFLt6F4uqTYHx7s/RuKKvtPcO7v7qOrFp2F57rmpekymmuY/BHEaKmcpdJo7iVUn+OvrzEczlAWSkndL0d9Lu2tI51UFuXRtv0Iprorx/ATw7vpEgIhh++7P5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoMAOmU2j3LLP2H5izMGIhag5FFWAY8BXna6p9F61tc=;
 b=oh76WeccTjTVwD8aFDDn9bPaZO9iokVHGbQJfy3QwbP1iZocgYKy1CEMM4BQl/cp3T00xR7lcyl4COen1bjQyqAIYxPc70gpYz2dICzJv/JdLkmNH0dm0E1MaMlMM5fEiUOZUPOZQXTjODlfkXST9em8867kkfmftAWSd3aJfx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 16:31:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 16:31:43 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 2/3] arm64: dts: imx8qxp: add cadence usb3 support
Date:   Thu, 23 Mar 2023 12:31:15 -0400
Message-Id: <20230323163116.2921999-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323163116.2921999-1-Frank.Li@nxp.com>
References: <20230323163116.2921999-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d766b9-bb22-4fcd-deaa-08db2bbc165f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4Bm8LhF++X6LWx9NkdTm64ryWXUsGrTIrmCQDgj/HDYbjsXYV1jBwKn+9D7miYql2HSDpQEoy9XV80EUXtpefKuq1CFAuspndDLVbVlc2X2Cw1h8VCdIGO1a278xcMRASGK2fEpaIDsGakhhX8oBw7jMLkBZFQ1WkupPCxun13HTCW8zayHdcGLBxVo7vBCYpvtKfl2m6izHld4R5LcDEPVNr8BnQLoY+uzVgNd6r9j0MTo4/hNi7S8rrrOQCdbvg6pATph/PGKDlEM9OL2Fd0may+xLNNF/IXA1y5TOCMSVRGaFLxmGuPgIzrjg/lMtoLY16BVHbD9Ok+DZEhnmBizwaDpkHzuIPZfH0gFE1Eo3HVgk2P5kncwm+CXHOnUfwmzdBMpLUoGbnOKI+Ufo2FgD0J6HO/fO6w1yhAw4hY9YJt1yqJgr8GzV0LgnJta2koOATJtbcU3IpxEEdtYuLOv2FooqSQmpnYrfOeEm/cUGPUYmut/oPzY32hwHd99fgk9U8Z8fCOpp9PWnoD5vJFdt8SUgvexTWVB8jlyuUPVXObbu3Od/dfnhh/Iv2N4ZaRqjaROfaVlCjJnBglsLw4sr/gYJZGYbunWodhahTuPkPXIDo+ohoXu7WL60i+F8Accl4HHi4o0TRm0GNFfRfgpqywpHSzJRseUidyPN+ZHEUams7luBoEME96Fat2+aAVGmhlGk+FtjnmAAktcFponohGtG0Bs9pVdxAX8B6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(38350700002)(8936002)(34206002)(66946007)(66476007)(66556008)(41300700001)(4326008)(86362001)(8676002)(36756003)(38100700002)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(186003)(6666004)(52116002)(316002)(478600001)(6486002)(37006003)(2906002)(5660300002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+LUpvfwzRe86TJphoXNtZd/LmY0OJLdxtsxsdnew21juJYbfCIm4oT6Qr8K0?=
 =?us-ascii?Q?CyNTB+yP0h1t00BGEIGYNcuf0caWINxdgYuIelZ7FmoGdWWOZKLADBoVSGfG?=
 =?us-ascii?Q?tTDm7hZvCQ3MkZHxUUkB+1i+otGcO0J+yXwPifSc4v+NhpEnBQ/ExcUSIF3A?=
 =?us-ascii?Q?p1yq/rSsZ4StiLQNdM8p+K3ZkLaHn6tJ0VKzZM52bMiVrnb8YJBm+IAUCQWT?=
 =?us-ascii?Q?pv+shQtjU3n0v8K78LrbUz7y8R8Z1GkyDdw4LBgMBJojgUh+k36O5ypawEV6?=
 =?us-ascii?Q?8pBD8L3PUdxSo5/CfSM0Fst5Ua/3gVb84v/BtlQAOcZdUGIWf2Oj5Fyz8MX3?=
 =?us-ascii?Q?X6cdBGZzBC3sqC4QtYR0nFy93fJc71bLtEN3W/VV1J5kTBx73+j6cY55Xd4v?=
 =?us-ascii?Q?Dbp4cOABAAkmg91ZHIxHuYklGekbQxw2qtOupCZrlEnrxFTXo6hcKgdKbtcg?=
 =?us-ascii?Q?WHLMSd7ucIaMh4VFz9jZqbqsoZlJpACSE8gcw//pphgBM7NuCpgFiLsx7TQh?=
 =?us-ascii?Q?Qcux8GXlUpc7NgcJtWXTT1PurQGRGYqkGV0YyHZ67QuYB2pGLiIrwc7wI0yR?=
 =?us-ascii?Q?snit/hp0sFwGWm+YLd2QVTu8u8T7w1Sj1sOYhWOqZMC+7yzD4wGgEwFALwr6?=
 =?us-ascii?Q?5ntN4Nh0uokesqtTX3oMNx3432NDk2+OV293IZYcC48AUh9OjvttoHFWiORh?=
 =?us-ascii?Q?oPGTCATQGe2fSTFPW7A7NXt6mULnpVfOBE0glVpgKGsUfD8mRs6XjSEfLa9y?=
 =?us-ascii?Q?5961T4Y8i1+Y1neah0VhsjTJuUdR1rH2d2MAo8ldS8FT++TLZVx/NDWDfJ2N?=
 =?us-ascii?Q?HNTRq8/4IrYEv7RzMjYROmqBChFPoLss8Xh8rZzjq34DMsU7fvtTyRYp76eI?=
 =?us-ascii?Q?l8MHJ2SQsKHqS9SQ/cvF1K9hTUBTkMAJuBNFsivpbLKrlfTb2AsxL4pXkvDp?=
 =?us-ascii?Q?bdhwDGOeJrvzYs7mmLkN9LN68VQ08OHzwuXsXocDGf0qDuOv39zMQJiebs+6?=
 =?us-ascii?Q?SBrjVGFDqoHcpW4+QFopf8uM4nodAhPbZ0Nql8IVcpBQ2rXLJDXt+Wd5z6Ku?=
 =?us-ascii?Q?1t1p2GnxoYLD3bBav2+p26JBGAMaZuHYz5zPV+8or7348M1sOnLUwgohCF1V?=
 =?us-ascii?Q?IRZXKYD9JZSsGlgE+1IiTVsClzgs7LR65u4+nOwvWR5zV5C8710gLYQkadJg?=
 =?us-ascii?Q?TNyTSxg84eBQ3e56ZCRRQWTcVnj74G3KAlG8V4nVthcxO/4Kq9ZJWluAEld/?=
 =?us-ascii?Q?V1BpTMmwpZ1xKFCBjouzGBQUvXzQS5hnknyeojeA+pRt2dVC5rVuKf4eAg3Y?=
 =?us-ascii?Q?veWEw2V0d6YuEG4bxM2i1ZVXRREpMvix/foJcJ6jntbsWPT2Ka5jYhkoVdt/?=
 =?us-ascii?Q?IldNl0ack9dxYAL8DHeD3a+UYmncsmozsR8jkqo3+UXAeMjVIdEqkZazQsdR?=
 =?us-ascii?Q?KY/GOyi8yVn0Hk4oQ6VoQkhGSP4khwhCLpsTHEMyXaQ03qWy321Pun4c2AS9?=
 =?us-ascii?Q?Jz6ubyIxTIgfFfKeIlsJfHNJX5htdRebqfMGGdIGhYEZQx7sm9ge+RoILD3i?=
 =?us-ascii?Q?J6Ye8PIL6Y0D5QMJ7Gr8UyEWEdvfkC6SCi7I/pOw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d766b9-bb22-4fcd-deaa-08db2bbc165f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:31:43.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uArWyBF6F1f/N8g8hb8/j+Enhni9mHUuFyJIa6bpNXDoA0UIBPoE4LqevQphR1TigbF6gnL8sSjzfwkMiA4GvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cadence usb3.0 controller in 8qxp and 8qm.
Add usb3 node at common connect subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
 - none
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

