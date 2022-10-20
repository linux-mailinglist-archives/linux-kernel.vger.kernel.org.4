Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA45F605BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJTJ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJTJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:59:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EB51CFF38;
        Thu, 20 Oct 2022 02:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViOQkT/1mg69fM5aBVcHv2AR4ngd5vd0V81xI9I8YSb74OQyaeEypw8NmTxCBaTvGpc+uZDuEm/o1RVhj5rmj7z4sGfZkIQa93YTQarZ8kShXaRxLPwXMXLofbouaT90htzvmmr1LpX+KQp47ao8USvScjuSeTjlCjzOLe6N7+M9wSelLIzwYBbTpkdD12+SSr5GHDGyX32pfGqKpaQMGt24vt0yzxdTNC81F6p7ikS7kQBlKxjt3WyoBH3gal0d8zjOhIiGySz0vTVmroK152f4txkNJ/tA9lJC6YOpo9mpKoojuCPOOfhsbxQGoEb5eM7D24wVVOYrLVP08bBNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjyyWpjNKMZ8ECRPOYXHOwcwncemsUDhOkkBQGpoU/c=;
 b=WXcwmXIBeIuE6Fujq0tIT6RRXEi/NN8By9YScaa8LiV0ACPXm/LbUUl3KU0FhEOq0QGDjtgKDNBPOyZZsvYW5Xv4NE5cuUlGbT/9q4/JklvuPwFN8EzUEh9Cg7y7zwZxPxcUAlZx+UDF043HDaGZ/i6htKl1SJCeIrIjCIkyoCPDFw3cMkMUnxVPY6BgX9yk38EHF2fV0lfyHoXoy3lunkNqu9smZrHw2Qx1cnvVHZt6jWHU0NxDm8a3dkN8+kNoA3ysc4KCUMTzD7AYXaZccGcFhyeFWrpkNk3ylxwDiPjip6OvYs4XMzRDNKKZavuMr2IRgQm7Lb92JIAmsX5v1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjyyWpjNKMZ8ECRPOYXHOwcwncemsUDhOkkBQGpoU/c=;
 b=mEjipQOIo5SrQ1Cs1Bmmwu5nBQjFWCKhFHfcYeqvwbmKTphr1LeFOy+QyNXNEynTSB7S/EVwvUFW/NbAkt1DjXpkg9CDNONfUUH10XIKHJrxV9KcP4EQjxPXZGlLp/jrKf680vXk3acusiIA3LjLi9GnYqbf0hRMA/cytTnL3P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 07/15] arm64: dts: imx8mp-evk: enable I2C2 node
Date:   Thu, 20 Oct 2022 17:59:26 +0800
Message-Id: <20221020095934.1659449-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: a745d186-fe34-4beb-0737-08dab281aada
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmTertx4RlqzXD4zcxHICdMyLxjG3HLkZs3/43h90pFiLByf23Lc6BDgXZ4nnZZZZjbekU9ZdtCtMTGfMAiqch9XeuikXzI/qOSgLpsinpI7AQfD+GV6qg4OgNYYNkSEU7sUBVfEqaPQ7MOFR7MtSgCs1+K68pW2vn4t8hVUmG8xpZMVVuDNSrMBMUn8sEMA4dMmcuieXxXlZUd7b7v6gwaFRWb1WjFhaYkcf/D/dfzrf1Oc7ynEwqGH5cEEuQYjdAxvH3TV6BeD7tMdTqLn7bpVChrqpOfUN3LbmcsfMQGsXmjn8CymqqbOMdiWW/fNVJm0vfQ89eEl1/BFYjeTqtmOUiYaskTZ6elT1GeSnXca+mN0eSMjOdrgybzGJmclFeQZRansiUgRcM2/79WcIeAADW0RqpfLI8TQh6sMBFogGcDWzlE+m6dr1jiMh4OyUAypQtFXvppp1zeKfkQo6cRYK/fJHzozL0s58HfzOj11OLY54K+ROSwpplYL2DaBNJkDCBb9Ah/6BHRgEejCXcO8oPpRsrEr2wYIobBlNhbvz92jkzyo/ZVAnvtvalXdLLVjB7uoxzePRRtPK/septwNWJI1fytdE9ktkglY2I+Nu6Hjf2c3uRMTARxVTyd8Oa9hu8/OoCaM3N0KylVS7sA/l1grgVQ+wHHBMA9xZEaiblliCOkBexBvS63N3plngkbPy+RFZ1fBR5epMPaiGey5BHk97gSWSr/13a9HA5Cfhbt2wMbTMy49G+85fxNMTuLx2UNE8SUf/QDuW55N8gp13+OTSg+K2aH0gr1bISM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(83380400001)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(4744005)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nfw62cOhxUaPTLRZGlmOYIluVxqTfjBKNtkIk6vW6oE9E/XUJlUPdHMbAQ7r?=
 =?us-ascii?Q?NM7VGH9mF6NEE6dMsF+/Zbr0jadstdc9gRDXKaAeFLNw1QTDro03vt62vh82?=
 =?us-ascii?Q?WCZkBX/pqDt9zMVyC+6AYrRQyCk8OYPwBJTzDEcX//IhoP9sLkXq9TMlZABU?=
 =?us-ascii?Q?zJ9RMSQh5gbKDxIkpKt0A+uwbeDP4u89MYAwoCQjari4bdxyi0kBIqFiXKN8?=
 =?us-ascii?Q?/zoJFfX9BzRPWTJQ9Eh2JXjBFbqUgmRj68BoZFfFl0H6fZOaxeWDQmsCIOy5?=
 =?us-ascii?Q?sqOb9m2KNj6YadPnlLJCe/H6H08yyB3bQt6u/s5zP2YMS7D6B+YxKtL9rxLZ?=
 =?us-ascii?Q?bo92/nmxh7njllK9vj6vcDAfF8nXivTgARMg1jdTFiOT5gu/c6RGQXDl0B3L?=
 =?us-ascii?Q?2+VC06/Yl68jwycJlab6DN4Z8gfBetZOPkGZXtVVtXMTt51DYmB6MUI6GUop?=
 =?us-ascii?Q?Q7cLrHXPjXwxDVszvqmTZs3+/CcpVZOxYexBePigElWI/Mm4HP0uk2JE1G6U?=
 =?us-ascii?Q?sOp9nyCYMSIJ7t5hntVzT9lzr6ErBLHLI2mc4iDCFoL7xPUWu9HrrNw2x08A?=
 =?us-ascii?Q?O1GJ2bUiQd3VwH84cTiPC/Wh0efcCZH8M3qiuVL4jVxXf2ONQXveCj94D/A8?=
 =?us-ascii?Q?l8o3R4er1WW1VtR7ZMG58b5/EMyOKCqdHBOjWutxQWh9k6iGwYkpkSS53pxf?=
 =?us-ascii?Q?FoHzkPbl3b2alljUkk7EUwPLyn+wM9nx5CxQQcGiUX9UY7xpDs7SY/feAX/f?=
 =?us-ascii?Q?qoPos2XE0lFtuACdxe5T+AgdIPk0g9OJeI1A73Er+C0nqm8KiRgvbp3IjywX?=
 =?us-ascii?Q?XSceDkWxB0mK7gb/l/xBWIaKVgrO8IesFVEmzX0E4/oKCOutX4SK7KJcljlT?=
 =?us-ascii?Q?DKTtwz2m85gMBz7lPSLcu2QnqcqtPp8xMyOc1AjuhEQPPW7qwz2kMJk2MzBd?=
 =?us-ascii?Q?dUCohyNLR2QCEm9HbSAGlDSjdrYyEaWCIysXRk4w2G1NjAu3UWMppljBmsaz?=
 =?us-ascii?Q?mHdCdH4MDD3fqsZ0MTxnRk8nJf967bNV4V8RXGlCtupRcK50dOfLgWFLosyn?=
 =?us-ascii?Q?KPFbB5MoVfGSUOiO2LPEZsT+lEunF9K0iI4L/pnyyrzu8NKB3tVnPU682EnO?=
 =?us-ascii?Q?zkLPu2cNL5YXMidIKszfpFCKYJ1O2gq/wlYUJ8jtnuyQefOn/FcjzoevoRvF?=
 =?us-ascii?Q?C1cobfNW+QBmA2Bg7WUn/NYFN4kgn8Ud/1IarJpUEIN6BJhFmbhbQJVFvzRV?=
 =?us-ascii?Q?t/JVlO8VDZi9qTMBOOPnQwapO3sD4W8ESWM19Z1i1ZrN+/aTzhq1Fqvlfjuo?=
 =?us-ascii?Q?PDFe48kkkgtRUibclmSBkei18UifQq8IeUywYp8y1iBSKGG1MPqW7xcRsgLZ?=
 =?us-ascii?Q?dYQKNqn9kXnH+RpeC+gRwFVIqufb7D9iZaNeCU7uqpjqYSf5XfQKZ6945qTL?=
 =?us-ascii?Q?GVjUHDBTDOo1P7AthqC/X4/eQkzub9a7v8Z4EsOOkKi6DwVE1domz0ahRoYT?=
 =?us-ascii?Q?MNrZYzzvxoqaUygy37LTVE/WeL4ZyCHmOsFJId0DbU4LDRJH7wAem8CtIkLF?=
 =?us-ascii?Q?HtIeK1UMkk6SecOY6bXUp1SEBl3csJMRTN2CJG7t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a745d186-fe34-4beb-0737-08dab281aada
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:41.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frBjcwg4mfh6076FEERNgh/O1HzOXIIAm8+IGl5a0xwnu5205s9FJW+LVN5GXlPM1xdqycmDm2fSIdmnK/WwCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable I2C node for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index f36033b9cebb..d4d52ac25d1e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -367,6 +367,13 @@ LDO5 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -625,6 +632,13 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
-- 
2.37.1

