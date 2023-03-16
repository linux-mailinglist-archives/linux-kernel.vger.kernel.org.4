Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A258A6BDAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCPV1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCPV1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:27:44 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6407DE5021;
        Thu, 16 Mar 2023 14:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb2xKWGbn9Ue+apgVPFnd76epBAB55jptkTPHBFMqqsUfYdGj+90VREHHN2YCSQVlQCwY34bj6FDoF3Ixjrm2zr2dLuJauCSTE/R/jJsCAZd6yBAhkb9XxJwhq7XIcQeQ6yqd6pihFevpRLk+uocmNA+3pu+61A351QY64TIyGdj8aHSa5zBDsIJyBxv/u8BhMc0wVsehZjr0h04MgiswWWBHly3zTsFQeg91goHbf7M8xLAS0Hg/6D1Wc5XF6aq4VRJP93/htOxwZ2q2SE1/aa9UCvgZBkmjnR+XNH90cmlXhnMi7sv+1KWs822L1BZFDbEsNL6HQtJNDc8D+pAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvltPXxTRCqhvhFjIEZB69YWYh9va5BCNL/F/VDqEUM=;
 b=PzpMVKMGzazDVPp9MNiWRo8RijqV/njOSOPu0Z8/0MZz/ne9weTzCwAGiMkcKi6EQXCWLFNQal4/J0CfaMCUq0a/efSMNnFdeIkRaPHLXujvIgSE6y3zz85opOvTEWW7y6Z//u20jtdA9cqfWa2XkRA6tYPM/08JkFAufFUhbOHLKbaZjsSFN9xOf/TtXHnII4Og8KNsRk24smGpxZBfZZavaCTJshO2g7qDNCbPXxiODvpDnejtyi4vLeDT8jB1Iu0IlAj8h8LL0AC0fkDmOkAVXFdsbF1ZQOu7CsFVDTJjeoC4glgr84a6ssZsTGmdAtT2JEg7m8Xzr8qMq/yx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvltPXxTRCqhvhFjIEZB69YWYh9va5BCNL/F/VDqEUM=;
 b=OKTwfhuip4jGH5S8iOHnnO+sOEQE0tjgs5M7ytEnzxecG6CYMPiDuXjdMbZn6QS1bIHiglAfx8z6dk4g017nyjDImwdvescjEH8m9MbzLwuBReg7sTIjT6I0mM1W+Lng3RnKwG62gNl2iD2Bo9vGN4IA7t8E7/y9+ysUWVtYMd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7332.eurprd04.prod.outlook.com (2603:10a6:20b:1db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Thu, 16 Mar
 2023 21:27:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 21:27:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Subject: [PATCH v2 2/3] arm64: dts: imx8qxp: add cadence usb3 support
Date:   Thu, 16 Mar 2023 17:27:10 -0400
Message-Id: <20230316212712.2426542-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2a283db7-6b10-4199-da1d-08db26654340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJasiMl3edH91PJE3x7yzY0G9Asy+u6yoO6yaIFyUNrDPVUctZgVwQNWYg8ELWCh/NaJyQRzBcai9L4Ks616EUTRKesyFc6VGK1UzLcfL7yLuhPzkWf+fcsrFt/VwkbUFJ0PtVc1WhXlF09gS4dJLGtEVLxcmZ+7WgDrAfmjKNQiTOdvakqdqP9iksBvnrQrn4YmkGsiwptyHSb8tk9qxQoAQqiaNHMGGA5zS39P8vYsPyiT4nhzJp1GM8XKIb1nZrjiymK/eQV2wu+OuEiHZFt6regRthEIz+LE6PBDd43ye48PNX+FU2SyTT39ReHg8a0DMi8jhV8DgmD/BAxCTKCJLZSBNqBCepxx0HAMTcxUQsjTXx+Ic8umx4Npnv8aokj3qkpO66wOKDzPhiMBZQylwoAcc/AJGzoUoJgdtQpuSrB1WLPC9u82mubKOidPsSlJHNs5kLqzRXZdVd6YJlE7oXkFCK+ZVTnWT/Ge26rwI/36bk0poqhjdxlA3XtaOwmIJ4wOMHTLlw7Px/l+NKNAXwvorVzwAUyosguQtmEBdf2x5dwAtuelSx67F23M0fqG14flzVWCIrU7d2J5vfrsZr7bzFGfHboYkk8PuIyuy1/xWMRGilH6Ux4WxwJvvQqamqWfWNlrTDyv1d3S/jxSkT8Yuza5WEVL50YQzODreS+vmeQMxnNZGuDIHSfdyKjOk+0OUZiopWl48RF8zYfh5E0ZyjNgQSgV7Cg6iZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(38100700002)(38350700002)(86362001)(36756003)(2906002)(41300700001)(7416002)(8936002)(5660300002)(4326008)(6506007)(6512007)(1076003)(26005)(186003)(2616005)(83380400001)(316002)(8676002)(6916009)(66476007)(66556008)(66946007)(6486002)(6666004)(478600001)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v4kX3oBiahiDYe+IQM0P+i51xlOdxa91Ylv+8CxAxclAf2mt/qb5Tgyi8x9W?=
 =?us-ascii?Q?OTNPJjBxOURDD2XmGQldJ7o7IkkmJfHBwKhwRCAtGVTh7QggRxs8up9RsC4X?=
 =?us-ascii?Q?7xeMPicY6wKi7AbLLUweta8+MQ2f8Cjyeq+tvDXAZm1OgRx1SWVQkX54oCbn?=
 =?us-ascii?Q?9+1sbDIK//ZoXVN91n7drtDZwlmoTPJmvb3HRjuwOATRzcOHK02urnkRqvkM?=
 =?us-ascii?Q?r2HhRwA3Q9exnWFjozZ+8j/XvoS1fGbldHqUioYtkfz0AhMek/IkrPv2sc6f?=
 =?us-ascii?Q?bDPiLYeQZU8TdVQ/4PO1fsCedMJUmD9XfDyyifog8xETY/eD7hxIHmWOVqip?=
 =?us-ascii?Q?A6u1L4yyBuyr9nH/RVprRENcSDe4ffUvHqwZ/huCZo/kjGhMt3VfDdh8aAzj?=
 =?us-ascii?Q?ulDvk+zBnAtlmwobe8/UrDlm8D+KoNdyvHufazy17xB9TVmThmVTeXYs0ax4?=
 =?us-ascii?Q?nDR+jqZbvZ2etoRlorJDX/asY8ZyawJYORyeL5dRcI4uHurzQ3xsmoe3F+US?=
 =?us-ascii?Q?dvljIAIfn9ax8j2bwbmYrnc8LUg1+YWDpaOzbHWvETD7jazfb6JPO2GR4t7q?=
 =?us-ascii?Q?p+MfKRgi8OHLgRw/jiwyt0+719vf3ZI7IT0Ipy2pasLzAKRHApkC/CDXdAVC?=
 =?us-ascii?Q?OJ+0lNltnOBEFFfvyK69M7hXayrPgG13w9zrhsdmTGIMnxWylLMpBNU2q+6D?=
 =?us-ascii?Q?dCMl4rWuOFjw++1YM9IzszWeShlOB6LdqmIjRgAlOM8s1ySuWTDO0jnAjgJv?=
 =?us-ascii?Q?wq6iwkP8jMnaI2ZS8qCECdfx12/KQk0/Wkzwb5ILA6YatuqlRNNH8N1R5/ZX?=
 =?us-ascii?Q?tawsPPPfGvgi24iHXbtwq16I8UNzfPROx6zpsmdbN+Jft+3tohAhyi8aKxq0?=
 =?us-ascii?Q?f8zk9E8NdtZDmUGb7QRda48F54MggvnhkZDhHbTRGKtwHiIL8bl/oRHhpsI7?=
 =?us-ascii?Q?D0EubhJnYZCC7E2Bks2D1vqiAotvvqhq9W3k3WNRWzGLLZcV/6RST4Cw1yZk?=
 =?us-ascii?Q?1LNtJwyX7Fa1kXTufOlEJrz1bHDlK+ZILzWdN7hmywpjiaPw2LLxxm+C/jCu?=
 =?us-ascii?Q?SDjERT1eVta6317v7NMdZahI0fuYbQeoKu1pgAOaYYjuVTTG+Za+hcHkhUCv?=
 =?us-ascii?Q?0zGlkAclWYcYZ/sW+JB0wPphjDXbrqukz0WJUQ2MH+qswWYRrrlH5EC6jSZq?=
 =?us-ascii?Q?3vUov3R7UX08TFmMlPjfLd64j5aJgIECKSQ9N2bpz8BG1Fj6NSFg1Wp7+eEn?=
 =?us-ascii?Q?GAiXQOzVDBx+so2/IzqsnuhVi9OVG4TLndct3qXiRAA7irkDfRH1lNeeE1Os?=
 =?us-ascii?Q?xsH3hPpLVG96Bgj47BBCkthWLI/8qZCX8LC6xIAxw2SdihTebN1ni7rKAk/M?=
 =?us-ascii?Q?bP6RWKreQ0IEkdXEy1OZKKtxjBKMhAu/soZMJheorsZ+3TKHqv5cLknP+Msc?=
 =?us-ascii?Q?bDFjwvQkWbYFIkrxQ4rl58zD/Hjrj8KZG9WsJl4/ugjBGANghVlHR3UasjSM?=
 =?us-ascii?Q?SpcW6eUYaxllMB7JgkmTQUCTDXFVLzzW0+B8lhatjyLn+UMdi3p1/VXJ/GdN?=
 =?us-ascii?Q?044X1wKYEHKO1H0/ECmLkr7GpZIcBN/TeD01S6dZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a283db7-6b10-4199-da1d-08db26654340
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:27:36.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3p3lFkyvuCtcYjifa6AQH3v85wTKeePqAo6TuFLmh+aOrIfvgRHzcvUClDg6KqQyg+skduxiIKCp06TOcb2fIQ==
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

There are cadence usb3.0 controller in 8qxp and 8qm.
Add usb3 node at common connect subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4852760adeee..389f52f16a5c 100644
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
+			      "usb3_ipg_clk", "usb3_core_pclk";
+		assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
+				  <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
+				  <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
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

