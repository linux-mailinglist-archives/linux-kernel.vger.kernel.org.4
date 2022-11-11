Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C488E6251B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKKD3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiKKD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:15 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6085E9C8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anPHs2D2pYl4E+F8oZQ+Q6SSCqDJP5+bu1RfcFBBkIIzR/G6Qd+fxtAdJp0zOB4fsmnrENAuS1FyMF7F/gEQrUraDj9WKzzScXd6P5SKMl9IGnYZQ69LQuuwMms+zeYrSqtttAeRVrNwqoYSxRP/eUSjwvJmgWFeQmZRMmoNBw6DePyCxIjJRsdjQYiozv7LrGQCEKQA4NOlf1KVKml8ElHA8088AGPiQ1x/Cx6GN+aVFLX3hDYRj0NledW/2KR73VCPUGgjX9A4XCxIpTyDbOC6Gopk7aoNPmc5UUUluys6/IJDBv38Nf0NPhxmFV3Ne2RSgpyuXVPsUWXlRgELTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz3zK8DP17lcFGmZHLPXTi1DTD0usmKlYijve+Fp8dI=;
 b=oGhpEcphR5vgUu6gJJ2CGtJW3LJwDrmVKmEA1rSjGGoBFNIewq5hk1tz4zods6tT7W096d8A8aWC15f45BHjHf5Mo4TdZRSIH+m/EDuILdtALgR+6zXOlzX1hlYG7MqfIVQbioEXsQkz/z1Ol1lKEQyaRRDz+P0gNmc49EIkiCz4A+AgqZGdk+Yo6GKbl4jS/GpZdNdRVi+ahNNHjuAgayBZr/F8FVfPL9cuAb/mddse/BpSzQ0yYFzjdw0xGm0/xrZ0cwa5nL19Cf8GqwU2k1DI7LoexAJn33LmQLpO+qVGltM/+j47euEM13A6e1hsBgSJaGBS7f6wEO9ljJEsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz3zK8DP17lcFGmZHLPXTi1DTD0usmKlYijve+Fp8dI=;
 b=CJVbg9/AKOgoiVdEyVcZZUNhRqzsm7+4fiWnWiqyRCS61OSTLIJckvQjVJ4JsX9jGfdzQAz9URZLfjXZoFr+tJF4k0eJ34PmZ3XVuJfR9S4WpZXJEqrONP1EJYCd3okW6lELOaWqs0p3Xx/+RJ8PhiAWPdx04fuEgnpyQUDXPwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 13/14] arm64: dts: imx8m[m,q]-evk: change to use off-on-delay-us in regulator
Date:   Fri, 11 Nov 2022 11:28:10 +0800
Message-Id: <20221111032811.2456916-14-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c0a808-63f3-4f00-77f5-08dac394a74a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQdDVEIh4QK4kWkxgWjW5SKUMjpDWn3AsfMQh1Jm/LZrq5Wyp8aTPZT/aRk1IYhhgYxN0eDCmsOTHfmbVLrRJzj4QEygl+/Ahqsjg6wDB+/znwDWY8f3s2GEkdmyPTWtmb8iu26kSGHA0wIy0wUTerOMYtTtcVL8DAWd6tYkla8PKOMySfhpwuREoK5DtPFeDIrrBOiArmS4v6bd2lDY/afAjRaKLoRWWJPf0qiWHrKqNTLULL0knwDB3XxMVVquMA4R/9P8ifJKIhTaSwH5qDJgsof9Qh/+hOCMluapilfdB0Jco1P+WWEm6W/HZM+ZcfSiB+ekkTEtWCRTOh1/3hlouR2QoHYqrEzr7d70Q471Uk/PspZVoX+MO01T77o1FxnWUjTzcKdp/nbnIMwnco3Kr+IhEszcvS5krHD2yH+R7H75PY7ORIYr7DEFPs2AxNef0PXAWNFtLgpZQpG1YCFvVULsdVtScTsUyQx+hABMnvo3TLKa7+gd/GyGG3zZvGrcZLVOEdSv/GG7zedwOr3/pVC1OmQRB+IrWIE2EYp/9zJ1cfXgXFBbzzApM16+SvtYFYgZmELujGOQstzhG0KY/5t590W/C97+u0p9+RJigueNqXRQed1sI2od6PsP6REMu+LZk/UTDsQlV6IOQMWH0hOqiFsYLKTGl+XijQTUGXbZJbcTcdke5+lFvL2z618/nO7gs8aUPek+ygkaOlOGbk3bNJUVAJHjmQhUnTp6rlw/6C22cRomRW3/PPn/Mb0pk5z8fz85alpSHWim9VYpLbmWREDHazKlg+4MWmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlqSEVtvw2/YMHfkfRfDcTzJ9nVRmWp3lErEjC+V8BFV1DxaioXuRVBAIQQ/?=
 =?us-ascii?Q?sdniTqzNRYrXUmdRYGdyrGsZNDdF8ZAOTgqfMMHG+PSzrXv5jFNeJuqEezbZ?=
 =?us-ascii?Q?TIhI0xAjMW098DjkTyms74i/9Qg/TtY0QGNAFVL4oXreJ7EKpROH9itEQDmx?=
 =?us-ascii?Q?YJQgRvyV/Qa49KZbtModYIyfEEmp2VKu3MWm8SWzvdNmCfDJATm3aVH3Jqwn?=
 =?us-ascii?Q?MXPIUdVvtj7eHtAesxr4edRwFe6uOSiUsBnNkSWHKnwopLjLJXM/ctkdfKVI?=
 =?us-ascii?Q?r/JO5wiNvr5J1/10YoN29mnJdLnP/0tJwEuMEMWk4+SBge6jlNHv5gpf2bzq?=
 =?us-ascii?Q?DtrPxxXwp6X5XC3uly2byXX7HgqC4IbdqUcQP4sGyeHwZqExa2Pypzvcm3Ss?=
 =?us-ascii?Q?rcwUgJFwWN2nwTRZNSNQdVdoR2b91ViyTlN0qNRKV7+5G5sd3sXICqdC7SPa?=
 =?us-ascii?Q?gkXBltpmGdb31SBSyBcmHCRDO8Z17zxyLPIrPOTdPjVZiLxEbzt9IBYUIjjv?=
 =?us-ascii?Q?q7e2NyconLMqgOGA6XWJTGaoMG73wQEHNZniUiUgiEphUyNgWbDgd/FfVb7Y?=
 =?us-ascii?Q?i2Vobtky51vOMt4bujxzPm0Rajx3d0P1+jLL5dgIBLRw7Y3r5WJD2zmZtpOs?=
 =?us-ascii?Q?anLR6HDdDihAcwZT2EdeWZTWKqiOjvJ5BXZRoOPHDxRldu+YArNDFqrAphqG?=
 =?us-ascii?Q?QlwDzZZhTe0wzjWhskTIx1kt4p15GTyPetTUbFzyYKohp5kBZWRdRV8R1/U7?=
 =?us-ascii?Q?UsKtIeuWVmC2+x08TNNjZOr+L9NjGyeTEau+5d+21mtM7RY1DxexJLQYvkKL?=
 =?us-ascii?Q?G0VoWpZ5PsK3foWWY25WEyzgL8UHXP0/0QSsyxcMJaktV+QDM5JnDFO3wY52?=
 =?us-ascii?Q?TEiDhzG8LCB0roI4e5CoPlw2Vd+YIvLSx/f8sp42PtskJezYx0g0dqCy0bTi?=
 =?us-ascii?Q?2olItDruJveGfYLEaceMdPD1Ji6pqvngIB+aWVgSwJVD1tGMobMoE5oMXTpQ?=
 =?us-ascii?Q?od0YS3IQtCR38yRj7XA8Tb+kAepRrCipueUn2d8CU98F/9+15RSOe0nbTypb?=
 =?us-ascii?Q?vUjcoGG9psvNvnNGH7Jm6zXuVnWyLa8NBPQLrpnvGKZGRiFyaWkbpALiOOur?=
 =?us-ascii?Q?tgpBGXBYuo/xv3YOkQJ3KxxQgUCBAx2df8Trwofpl/uWlR0JZqx/C9dhCI6v?=
 =?us-ascii?Q?rJsD3DQVKjaO8ZP8kV2wu3nnthFq/Cl1+aM1P8Zp+79aLm9A9zStpvOCs4dm?=
 =?us-ascii?Q?qxTHST3Txn/GtmFuw6uExwghZQPceWK4GmH631DJt7CPpPYlKI+Ohqh3a7pI?=
 =?us-ascii?Q?2YTjS0NIGqfCO0T4Yffw7g9BWKt0THFr5uomNlupBEmrEXSbWRt03MjAJF8O?=
 =?us-ascii?Q?4hQjNsRW/L+90dZzIOGh0aa7UBHxMVXSVr4G09wLVzPjo4gyDG2KoiDiQNJv?=
 =?us-ascii?Q?XTDsO3KTNZhWwwD/EqWppMcLnjnfjnQv8kbb2SKiQhhzMRygHCd1E0au9dWK?=
 =?us-ascii?Q?calyFIpPCxSK2RZiwJMQY5KI5k/pTP7c0ZhIgM+Xi4v1qJsFDvpLM0de3pXi?=
 =?us-ascii?Q?Yzhsa9ocvaalwzRkq9GkPYXfDORs4rYNGHj/u1Xi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c0a808-63f3-4f00-77f5-08dac394a74a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:25.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvFhDU1vbKKAqE+voK1y6Fk1a2poEHRHG4NII2iOGx757DiiIUd403n+YAAMi3y3z50b2G6VAsu+nyyjawFS/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Some SD Card controller and power circuitry has increased capacitance,
so the usual toggling of regulator to power the card off and on
is insufficient.

According to SD spec, for sd card power reset operation, the sd card
supply voltage needs to be lower than 0.5v and keep over 1ms, otherwise,
next time power back the sd card supply voltage to 3.3v, sd card can't
support SD3.0 mode again.

This patch add the off-on-delay-us, make sure the sd power reset behavior
is align with the specification. Without this patch, when do quick system
suspend/resume test, some sd card can't work at SD3.0 mode after system
resume back.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index ce450965e837..fdbcd2483efc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -56,6 +56,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 82387b9cb800..07d9fb2aacf8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -46,6 +46,7 @@ reg_usdhc2_vmmc: regulator-vsd-3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 
-- 
2.37.1

