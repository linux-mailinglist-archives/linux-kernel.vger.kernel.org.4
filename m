Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19D273F113
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjF0C7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjF0C7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:59:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C20F1BD2;
        Mon, 26 Jun 2023 19:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhjlWlmQ8155r0eV7k9viuLfBQhzZHzuNU8MeFlyEijoYgPWH1b7IJrYWO7POvHr5RxRsXt8B3cpVcNQ+c42sbCK9BYGOEiWqkqDUrMPp0W+fp/xYtM6hPGlehmzOFbReX4WQoIXnZRa7z6diq2H+x0ZOb/wBlxnpGB/lQQtNpdYg1SrUHLkVasRqQIeU2uiNq+eStYz9q0NIsyUtnwQUp9R5K3PdOCWzEALbR5kliVNjSgk2tIcdhs8rooxSs3bmlZvEU/EsmEGd0hZdxmb8HhMsLCjta3bd+dHqLBLWyefx5zw5kQy+9zrj0UUEU3W00I3fa6O+sk29GZp4CQmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+2oIdvGmV+wFU/Ddd/UarSTFl2JuYWhYJwY8klgrXk=;
 b=DGKYXEnGAII96xM0p6Qte7dYAnJojx9eWydAkE06mEIR0mTBqYOq5FsZZVpqjm2HNsxXsDO7ospwnaeTvKrJGNFy1Knt65gQkh0f8JuDT0J0yctfoXUHTNKxbNtR6MtmKocE/hsQaa9MSS46eCxHnaq6kpBhloexJGqwVO5aaHzegXF1GzLYKp0MmZQ007KHpsswArGyIMDT9ve/3oCBzEmLSqMkrkxnay0f3YW1elvmCu/Y8OyX19jeO61kM2jPSVLRZuXe03pwpM61ibn/fTmNhvNKxqPnKSZGmNimonY2RAQQ/Me5RJ7OStM6Jj8aWIVOoI2P4erbPuYJTWOMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+2oIdvGmV+wFU/Ddd/UarSTFl2JuYWhYJwY8klgrXk=;
 b=WmShx5IhsvF0BISuaRzYqaPprnARtdvT9ja/8JTW39ZxySAnxq/Hf0UbtXJGMh8fqpSEk0+GeIZCWqN2a9E6XT3f11sg3qRT0YZYUoAOYBZBQSgGtM5AKYc43XY/qdavBC+tqfsjdVjk9V1zr0+EZ7zw6umlQkIjByNvzRyvWxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 02:59:10 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 02:59:09 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V3 2/3] arm64: dts: imx93: add "fsl,imx8ulp-lpuart" compatible for imx93
Date:   Tue, 27 Jun 2023 10:53:31 +0800
Message-Id: <20230627025332.11133-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230627025332.11133-1-sherry.sun@nxp.com>
References: <20230627025332.11133-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 62327154-c3d9-4a37-822b-08db76ba7a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nhmj1sK6dT+xiuJDmcolIsxk5QTLtbbwn28iq5FxbBqVVnADvyRpWRIJ5nFV+q+prRlOC46jQbTKKEbdAH+2xAVRGYfJopn4Y7EQXoqNRYNusqQ7RUrYdUUqtJburVCNa71/dEZFK7T6DCcCybDoushzlYmYXlli1YXdhbaMo+IvRCeHAIk5JK8SJSlMpihMXjUoX79BKkPkmj5C8Q3TsiobMlv/HS4GxvGh5OZkoAzLa1x5VPcY8XoQSbPCsyH3XrBDbO0a48/838qMCQU1k97S5Ctm7vDN3yIbfrOek8figDqrC0tjKSVA+L+GWKnyHYj/7PeK8upxRkS/fEddcR8ODfFfrnUD4Vq+JtWjz7iwksLnQgGbvEWLAeTgtHvebLociT+adnP1Gwef65i79+iiFoN6z7Lv8I/QpFEIccRDBrbYq/lGISUvXrx483uBP79J+vi25L9dK7p+IbJWkjMHqNLWYO9lMaBxZ/QXxFfELZx8x9OW83fppFmWBNFttoxIhvylf6KU/NjiFQFaacDl/3L4R9y2hfAKFWWB0JL9kByCQGOG/96trqgiDykmanv8kvL1OwCRmkc7LfpMKMFNXY2zA0PSrDCN5CRgoXGzd0tJ9IYcc6XvrxfhzEuZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(316002)(66556008)(66946007)(66476007)(478600001)(4326008)(36756003)(8936002)(8676002)(5660300002)(7416002)(44832011)(1076003)(86362001)(41300700001)(6486002)(2906002)(52116002)(26005)(186003)(6506007)(6512007)(38100700002)(83380400001)(38350700002)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MxPOOP8+vOPjAau4I5bMSSKoW/cJKJ+HFXgHsXbDTzyKaxKe9nqTu8BQ2S4C?=
 =?us-ascii?Q?+IoF+ghVxyMXGuoh4yZuD9Y4gF9B22ogV8kUqeau68XxXQdO3YePYrFQkgJo?=
 =?us-ascii?Q?MY3B8VxQijmOcmt20rsuc07FF2c0dEo0NSkeJqiEso2RFAnS7voT/WQO1X0t?=
 =?us-ascii?Q?CTmt3lnAxHxMMioyIRw0YbPVrtZPhJUZ+86LskLoIUvuJBYTWbYqZOwKBego?=
 =?us-ascii?Q?P2jc70a7IInSO5uFo4/RNV2wEDqyLGONs1C8xgOxf2coK9sPto1kUUEl0PYk?=
 =?us-ascii?Q?YJ7H+dHmYA8JZFNb/TToZNh8LzHwEu6MiuORHWZo+jGoBf02leDfU0ha/1Du?=
 =?us-ascii?Q?MJyrcGzXEJ19NLzQc7SlgPOnT/15TNuP2vqnQjRDyElC90lKpYwaUzJ/KtwV?=
 =?us-ascii?Q?HxXPYTHl8etGbT++/ytPyMYWXsZ3ZwIwbjKagrRwN/VjM8uqhf/OEJEEC3yT?=
 =?us-ascii?Q?aIATAqVDzc9Onb2mV5hWfL8+v78rqb4RCJA4hXYK4HdEEmiR5iVE/qszx86c?=
 =?us-ascii?Q?RqxK7DZSgCVYQp4PHC3+7J0tnc076dmzHQ1iElYI1QK3plMHBRcTBAOOL+im?=
 =?us-ascii?Q?8Z7TZNZ9xV0BJNYAjJRysz8o8luJQP1zwPQCEPGOdiMRTCJ4DinextH8pt25?=
 =?us-ascii?Q?naVPDrf6yd5ZWtirkH+kUu0jej8ihHPQSvVwD/JkoZBYaj9Prgla1KE8OsZF?=
 =?us-ascii?Q?Wcv33USu2EF85zkS0l1oEW05XLG0ZOMPEfTa4P2TRc4EnrIwB3ZJ0P2IvNv9?=
 =?us-ascii?Q?GKHDknbhmdg68QBfik8ZRzZrGroqXfh8VZPDzA0Dh8VZKx4NGZq9i/GfEuZH?=
 =?us-ascii?Q?u93/xY8n0MdNUkRevq9UOlw7BzTgWO1disbnFdxsm8gPHqPVeU6hVg2VHLBm?=
 =?us-ascii?Q?u7ZjLEcU8Fa+mXSmk7rA7waxUgCAebTZxVsJGzfLz/0a5Iy5UVMRdcCE753b?=
 =?us-ascii?Q?J3wk+P1r1PxtPW+lS+5+PEHeP+lBik/Lph8W0thYarSbA4e5jxlgByXUGcvQ?=
 =?us-ascii?Q?+1SSYmujc77HWuiuI/f7MZ2xbgEsOqbE/RswNe6nAR8DnLB0E4oBS4X9bvoU?=
 =?us-ascii?Q?ipagIfKE0Ow6Ay1jCuhjDZ2ViW3NNkMDBsDmrWeNW1HqwJQwkvPaIh5DktCh?=
 =?us-ascii?Q?zcxguN8q4dg08L+LPYuLg5rlFtIczpAefGkLjfhVCuOiVucIfVgJkU3zudlC?=
 =?us-ascii?Q?gTBDxI8dKWnVkWXMgqIpF9AkhMv0ojLSLBRMzsRgiJhcPNwAWFXsYZA14z8m?=
 =?us-ascii?Q?2FWlXZ1sdlVFAaoIgt8gaTzhkIE3vj7SuFPb7LdCqk9MMdLlZa2UFlwLVlNp?=
 =?us-ascii?Q?Bq+LAprTrFbUpHL1+LDVtZUZiJu3aJSsEKrhcwz8+hvQSTRyTTy+wZALDMFi?=
 =?us-ascii?Q?/ReXd1DRHpye6WOEfZU3D3A/bT8dzUZt/F0K1XzeKcKz9xCpg0OH7RkNSFhH?=
 =?us-ascii?Q?mO7Cg6SReTyVrwToKmZzW6nfaAVz0t2bf2qfLVgQH+eJq0Y6Igciu/3EZPKj?=
 =?us-ascii?Q?AOjXBT0VxOCEfWEHfNRFIserNoS8Kf3sMhHP/c1SksVDn8Ix/71WYnJyyqkY?=
 =?us-ascii?Q?S45pUSIYlmpinxE5OGUvsJKtrdLk/Dqb+CNobf59?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62327154-c3d9-4a37-822b-08db76ba7a91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:59:09.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCGoU0y36bwev3z4Ep8TmOq/YkptVANZHwfM5MzZ2PwFTKjLQztP2f8sXajDNKCu8P5W3I7sYkdGWkahexbHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX93 and i.MX8ULP lpuart add some new featurs based on i.MX7ULP, for
example, i.MX93 and i.MX8ULP can support EOP(end-of-packet) function
while i.MX7ULP doesn't support, so add "fsl,imx8ulp-lpuart" compatible
string for i.MX93 to support those new features.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8643612ace8c..16da5ef578c5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -252,7 +252,7 @@
 			};
 
 			lpuart1: serial@44380000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x44380000 0x1000>;
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
@@ -261,7 +261,7 @@
 			};
 
 			lpuart2: serial@44390000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x44390000 0x1000>;
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
@@ -486,7 +486,7 @@
 			};
 
 			lpuart3: serial@42570000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42570000 0x1000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
@@ -495,7 +495,7 @@
 			};
 
 			lpuart4: serial@42580000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42580000 0x1000>;
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
@@ -504,7 +504,7 @@
 			};
 
 			lpuart5: serial@42590000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42590000 0x1000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
@@ -513,7 +513,7 @@
 			};
 
 			lpuart6: serial@425a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x425a0000 0x1000>;
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
@@ -551,7 +551,7 @@
 			};
 
 			lpuart7: serial@42690000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42690000 0x1000>;
 				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
@@ -560,7 +560,7 @@
 			};
 
 			lpuart8: serial@426a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x426a0000 0x1000>;
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
-- 
2.17.1

