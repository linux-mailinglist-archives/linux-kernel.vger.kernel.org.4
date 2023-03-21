Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54556C2CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCUIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCUIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B6460A5;
        Tue, 21 Mar 2023 01:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWnaeK6Uk1KgzDZllbEBkMpP1oMkLkxRSkIfVaI2OaE6X13eV9AwyGSJF+i4yEMp91QCcAfS2vgGRa5JEsyDpl734YNyniuke6oNUHglBT6PBRCYCcZq79iTqbeuKsBzgOO0E4xNESQHTwrAhZk8UyYlcUAeVycp42/CD8H+HjqP6SJL6IjXs5TEEqdXmqQa9ZQKQxOI4btqhOR296eh21684VHzMk1kMKTGIDaUbxs1MEIfT7lC5P8zA9UIlhhuXdK/RzKxSv8vQ8L48QDH7h8IMhQQYqNNaS8lR+ioSRnfG2+owf3BsgcOEvn99tFUEtItQTmcKcQqmUOZ0dF4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51+SX6PXCPRgE0dgckvFecLhC7yvksaMGDKwLdd6Xc8=;
 b=Oz4hsHrQOGdd4nbIvhBb7QxjDgDBW4WIoIrhV8JOMKoM+zmePm7+gA/JWYJzAAQbYLU2Dm3oRnUjISXQH/dElP/mICG5h88uSSTndnZXZhfHsVbRihIb+qU5YKxMxow7AAfdTdpYWXkjowPPqBDXJp3IWjQeYZ+382uA8b1BOncZk+EVwgz1mlqVqOGtFTaXaiun//6q5fJzq8KsxQbmUTa6UL3hr+8RFxpbQa33haFU7RuwrUiKmj6mXqQWCbGBbkhCiLaSJQC8cMS/Y0T8lUEqV+XotQzqIFKvqn3FqjFZ+iLBJEzzdD7WjNghGbatblwaC/d85cJn25lZP4fTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51+SX6PXCPRgE0dgckvFecLhC7yvksaMGDKwLdd6Xc8=;
 b=e0x9kOAI7zX3qaPRmweeCugqTcvw5eUhmD2ITQq+Wf8Ba+KOrZlm0VsuGvyJyFxwBw03MFi0eHHoPUKKOzEsy/f4gSdkkp8YeEkBusMoOcIkEQu62GSew08fDqYCK9xIpyjHXCWIuyrrfZm5Zy5gKjuKLPLAhSnlCNG/rm7cyjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 05/10] arm64: dts: imx8mm: update usb compatible
Date:   Tue, 21 Mar 2023 16:52:08 +0800
Message-Id: <20230321085213.1624216-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b408fe6-634d-4ade-5944-08db29e8ea84
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzgOb37f55CjImHEOmHcaXOKjt3Ty4pFZewJvt2JYSGu1QwIFOVShLO5UNQX2xHg3L14TjCjoabnFRv7qKZoeccopn4di7zZIRVZCdTm4KceEPEG0vOhGdG3sXlRS4UulwSmGMUFAvmRiLhxSSOsJAjf4w2KaMm1r9C/lV1DI+JelGJ8XcFpBsn7pwXeM+NJwbRey2OFLPVxuaRSKkgW4pq5q/rzP1zkVOiUlxEid3REqhuJf/rJwJdBIBOeayQzjapRyL79l+5mm1sI7+/VokOAQ7o7jJffk1aDwkouNcvDbbzfB0OILupZVOAxZNAL3UVdZ5XqUkIvdvcgskR3OY/Pnzhi55cSfbA6cyROgCT71bC32g0R8ZNC7brNxlRPbSzAydwTEoExVy9p4bk94JAa/M3CxITxulNDoTmkmhvdb38Bc6h48ZmZYNZicrAogyTSFuSc4K/0JLxzTT8ZJmiN+V289wC4gXljec/f8qaX4d0J/FD7ZT9ko+ows21DoQQAx5pkWjCgK8WPOv4WvJYk4eU3SooHXTLW+gasCzLKOTT/F5+Fx0f0Hk1GmIMNtuX600ZHqMzLyceLHdzSg01NLUHTQRfH1jPlDkBhaxOEOwNGaJO8sa/A5dsSx1YFDTVJ3JnxGk7IrYme6BFv/twQzeAA4QKFdQUcm4ReB6uYc+YkIMrtGXRrKly0rfROprwWt6xxe3hTfWSbZ/2joRnd0cMHeAqF0jp/yVWuitg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199018)(2616005)(186003)(6666004)(6486002)(6512007)(6506007)(26005)(1076003)(52116002)(38100700002)(316002)(38350700002)(478600001)(2906002)(86362001)(15650500001)(83380400001)(7416002)(4326008)(8936002)(66556008)(5660300002)(41300700001)(8676002)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NvQD/hPXjqUArAMk6oJHu42kd9yofnpNWWgH1WoiotxKOyGNOSde6Drd9oUe?=
 =?us-ascii?Q?hnGhJlZW0Hxzj3gtAhKxTKAsOZKxQUcTOGIEPW6F0bZJ5+KAXuC1J5yvED7L?=
 =?us-ascii?Q?153VduPceJcEpmrs+5OL6PZDNGbwT6Pdf5ZbUOYhApaP4HhL5FDVtT/UCTWH?=
 =?us-ascii?Q?nK23tlqIPzSVRVQZMYOrQS9XYJMeJaVj29cBwS7Sk0gaUatfVZOrLVpD9oH/?=
 =?us-ascii?Q?ynhEsJAsx2DDZ6iYjbzR+yAEIP0xJorLrgf3zBJxTwQwKUjAPsqILSMdl4qJ?=
 =?us-ascii?Q?0IWrYDhYhcZaMdt4nBXYrqQIFvfjqUdWpZ3n8LenyfTcFDHF9c4HSFBbvj69?=
 =?us-ascii?Q?3Q5hYU9LUlavJe67K9WNV4L0Ek/kEYE906Ky8seUue26BlHzHlGIO4TpPd8p?=
 =?us-ascii?Q?JnjKhFuSW3McQFISnuT/Dt+RyZ0lAfP/q5GLQEDRJdU776DQpS4fsiGs4Jh6?=
 =?us-ascii?Q?8zTokI4A3BNbvTW4HKxa8kho/x58VUEgTtK4somtgYwAQ3tuESf6raI8StIo?=
 =?us-ascii?Q?F76O7ZplXJaTG8cg3JV0ruq666WLGse+pfxvjpd0RcuPGXSkjmiXKb1ZOv8O?=
 =?us-ascii?Q?0str98b3K9yt3o9uUlMfVoezfOIj24q6AnDQppFAhhD6BZBniSZbFENZooBF?=
 =?us-ascii?Q?zeliCo+60mCNYm3LmAREMvbbGfYJU9TmYP5OrTbUQVqGPlYgJPa3WygZ/W8M?=
 =?us-ascii?Q?+AozIIaoeP5lLigAuuwnET/htajm37+I/9zsl8+FlddIcEwhHao4D2EoHu3p?=
 =?us-ascii?Q?EfxineDD4canTNdNsyk0FmCYldRFSEs+3CiFk2uC5UZgN3VHKN6Ax6fvtE+d?=
 =?us-ascii?Q?GxbPBzGB4NxKAVA+yoqpym0ov3906iA8C9RbXGDZ71kS3R/yna15KdcbWHmF?=
 =?us-ascii?Q?3ffT3ZCb8h7Ifw24Fx2L5ye+aeCtCB+pia+7hoMvtvHGV/BVFRbHQ+7y/4w8?=
 =?us-ascii?Q?KotFoKQp6P+8vRfrJ3BJYzk12P7+4PI9nLubLTKNJ3da2+YPWGy03B4+ZtlC?=
 =?us-ascii?Q?pyJGTfOzDpEVLzY6BgmJhw9QaG70s5T3xBL/LKJoKiFt1JSm7UaP7VDFgtEh?=
 =?us-ascii?Q?RyjPDbEGApFPHv9tQsS2oNIkeKiFOm/SGcCTS2TTaoQMklBqmq/7ONys/ej/?=
 =?us-ascii?Q?EA5y1wxedeY+fCUhFT3LPk7hei9BQ5v6OjhCWoEFo2T8hgv/NYxxQi8caI/7?=
 =?us-ascii?Q?lr3JX6qPF9YzercQV4DIY3lNWJFtFFzvUu0cgxndpOC6+ejUGQxVzfigq8P+?=
 =?us-ascii?Q?VaWElUNU4DFJFPwDVQZlbXIyfl0g4b15o+W59vs0kxlR4GJghgQT+7nNRXiH?=
 =?us-ascii?Q?9ELZdRnwhrzuWJ/r/4VDw8LHI6WZkVBw4I0EuLbsXYh+xqbRHHaBbCqjwiXP?=
 =?us-ascii?Q?+HoB+3UGS5QRhLvxaqTkXpgUdAYf2F1FdNdb7gwtDDM29xkwkidBMCix4WC2?=
 =?us-ascii?Q?yy7+4+U60LmTdMaoRnPmJitNaeTXYR8thYIOh6YwYJAALV+oSqYcFA87ouQj?=
 =?us-ascii?Q?Bix63SeH4ZvA3SJG4Pg3PtWdmkL9YJY5mU1aeW2cip/2PRi9hg9xHxumqFUn?=
 =?us-ascii?Q?ujQLBnSLQHLqOJg5tVPLskr9kXTibRCjjMlrPbRI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b408fe6-634d-4ade-5944-08db29e8ea84
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:34.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1ObNoEeXzc67WT3SXpOh02Ywzrec97JuPpQQa9wtX104V4kzzIohzoP9qfmYTIfWNdRLwDGb2s28KqcKTsNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index a9552867e547..e311da7e87bd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1198,7 +1198,7 @@ imx8mm_mipi_csi_out: endpoint {
 			};
 
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
@@ -1212,13 +1212,14 @@ usbotg1: usb@32e40000 {
 			};
 
 			usbmisc1: usbmisc@32e40200 {
-				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
 
 			usbotg2: usb@32e50000 {
-				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e50000 0x200>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
@@ -1232,7 +1233,8 @@ usbotg2: usb@32e50000 {
 			};
 
 			usbmisc2: usbmisc@32e50200 {
-				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e50200 0x200>;
 			};
-- 
2.37.1

