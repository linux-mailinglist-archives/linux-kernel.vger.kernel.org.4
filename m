Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECB76251B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiKKD3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiKKD2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:14 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6D654F1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfSPh1B7dN7puAVZdRyuj//CzyUzMWFiq0M9ex3INPD2obdcV6Aran3zPX6geroyBzg20XJXbzA4CSnqlEiJmZdFNdW3uOwrjJhOe6+rBmJwEgBqRWXx8VlwEpnug3/3LI3EHZ6U2hVwTsBJ+05TogQ6ET1xWHlSbuSIyVoRKk3NA54kKkOIbmQiGD7cOOB7z7ypgH1Cko9f43VPcuzAq1jP7a6k52EeTrCCrEeSqf8yXemDKD6IbISW3sJzP2192QNAP6e00R/YiX2H8P4RT6dZnhRwr4IlZRMLWN92JELyvAhdJKAQ++CYBllwcK0Y4vCAtBJrz1c2MjsmhEeJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvUAb3mcK96FP9e73bKTht9uQvkXPfy6sAzCX5waNMc=;
 b=ODjtstH0/wBssq3beuLbyj8BqTvYDyiIQoN6BnrlaXr5qQMuZQqEF/BLrXQo5p4qPp4MNdhtmXW7PMFusNbqPjtnRtkEUqrPm0wS8aVxd6Dlw148qP/CZsetInIPhU5IIFPnFfz6rX7SYzTzXID2kJz2J5Zmx0iOZb8iIPMQ6wgV30RdYTGI0BcIEdiVlb4xhIPi1h2JhYaePJWXf6X/+iBBAbT200Cs9nhMOaap4l5jjxpsnZADjj6ep49cKYfv4RFUL/umrY1GROyDkpZ/xr7Qv3uPuGUbFQ3y+nbVRci75hgzoWhRfIIhArZM0cpQ5S3X9VdiLLwej0QlWj1uJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvUAb3mcK96FP9e73bKTht9uQvkXPfy6sAzCX5waNMc=;
 b=O0OnJMgHTJM7vegWjq3qS2czP/BntuB3nVdvGRBPtxFrsbX7ZR4XGy4E3pzy4sFpm6/9OCJutKNVDzdTkONByzIWvvcJvnUVlSL/evExVW2KXQKcCr/d5NeSEejQsVXjK8tttagHi54PMu7ZtiIL2OBMw9gfk0DdFOvag5tfsmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 08/14] arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
Date:   Fri, 11 Nov 2022 11:28:05 +0800
Message-Id: <20221111032811.2456916-9-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: db68fd70-f9ea-4a95-6f27-08dac3949e60
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnI+A9Bhk90DsEEfMOW1Tu+GWAtA5pWIMUjGTFWjwcrtvy5BM2uySnz5f4SyEWlV//1MgPhhzJUeXZUb9t85/baNZE4eIBM2YO+yqpnGlOrAa9iO46OHn43dU4b0vmWVpKikgZoyOOp7fXQonU6tRwIttNFpXQzSLN/kLxay7O5eU/8c7l2qewp4Hnf8FOXxsCdmLW9VpflmLCoetfKTQwrZQlr6xDn1Kr8KYXYPWIvWGxf1mhCdnnTc00liJxOfH7qIXEsq73Xv0dxwk0RtCgLGtigTNR7/HWJkGQsdBVOX2Edr4K0QLehjz9xTXKn91CvEuITPR4vn0WNRqirydHMcemwJiTclaDSb1edbp8eA01nkMunbGmTm2FT0x29fm41snxb27USoUAKoyiqbj8iuZOwHpll9p7PIMBBWBoj3gO+Wx7N3g/NapapWUT7cRNFFd+ZGILgPt+xYvgjesJm+DX02s0KgRRptf3+EBBGnk59MhCVQQv4ZwXLIc24Ed4kMQiLR4vlorgMoHf2inPtGQorguky1g+rEJxpCIlVCg/3rSGORR/otlVD2fNpMYGma02QaUoUOFt2nhs45MUfnAYCBwzBz6xhqdK8YxjkknuShTVvPSEjR4eLQiflAZITD6pqKLvb7wdy7Su0rdoY1jav5r3yWV34xk8Iwu8JVFuQLLLTivQo7d01gXzNHv4qdcJzfudsYRLbKYDdi6rzOr0OA3fuI2mTfQsqpc4wBYmQ3bOYvi/duDKdpKm94NCMX4nJLSsEHIdWo4v2fe7ZJxRbM1iKKMwMLTg4kzU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OOpgPsKuEpLdM6S+rHh4L2s6kFKZIGiiRF+9RAHEN55QATSfQwdWzUnYDxZk?=
 =?us-ascii?Q?dUOT3rnQ7y+zHX7FQnWC7uEUg4/OhhqB4MizZi+qZ8XnoR7k4LYZRmZ1HlyT?=
 =?us-ascii?Q?S/4lBHoZT0YJcCcct6BaVPHrolak7UN3FBvKpRB2/A4DttuTY5rJZhgN+QPv?=
 =?us-ascii?Q?9n9FbSxC6Qk4qdPkp7j5stXhwTreBiR2w0D8UB94zRFujMuRMM6R50sUwvk3?=
 =?us-ascii?Q?p1G4OPnP7aF/xKSFRsRRbhhChh/zKuVkhaRA5/deXUVLNsAibcLYRYRd214F?=
 =?us-ascii?Q?UGIpLdT9adBwUasVcwuzGACjDz8dbFE+DL27+Ew5HkkgYhI0LxqnZ2YlcofH?=
 =?us-ascii?Q?4wRcfWB4zMH5CArK5yvS7tlkYiUA9iagk9mZpa4JWI8v2vWUNJiaQ2IMjMwW?=
 =?us-ascii?Q?rRNnftY9mV9lXYKfn4oYrSVbvqO1CRsQ8hTfmOLNMAVOsx439KZ0BNA6eP4U?=
 =?us-ascii?Q?fW/jryDRHMQhPAPROBP4VUB2OxgTAlw0kLuMpFrWtwyuF/ZVuFsPxrQRqbEb?=
 =?us-ascii?Q?YXr3hFqJMrwmQTaCH+P8Fz1P0bsIuTT9IbPiIUmTHDixTNIcbqsDUz/ZZCRy?=
 =?us-ascii?Q?JqcMErQf6GAgxSU4swo5ikhWt6tzyjlFi2PIN1yl3bBGR/UetyE4XCkrilmc?=
 =?us-ascii?Q?iqJeT3p0NcFX9TYneozWXld80sqf2qIdXhh4+sCcpX/VtwmEuPYxl+TDiun2?=
 =?us-ascii?Q?h4yqc9aJuBFaeUM1u42jhqejU4YKoc1yIfLKqBrZcBaVSNu5bqUr2+aWoCPB?=
 =?us-ascii?Q?8vU324DW3jR6O/8NWO+aEl2SH9kPr1sPGj/2jW0hVBOJgDg5gSOosCiosg0J?=
 =?us-ascii?Q?F2sJ9+I75kBG13kESodk9sv24YZC72CewtoIpG8pX6UZ2pTBp1cgEPxvNMkj?=
 =?us-ascii?Q?EFwF+s0q/7BdPQLsBlz1l5k9a/oFTbPeSd1IrpRTTV67DBirsBlZ6LC/zlQm?=
 =?us-ascii?Q?hQioycC1TLZaqijVCyMazCp9h7fw9GH/QMbVH58K57DLqypgKUHrRoNyY83l?=
 =?us-ascii?Q?Zg81hdd3Tm9dRP93IHyUHnhHenE4yLz3hd4CrY9NKw7lbAphwVQb5Trb3GcQ?=
 =?us-ascii?Q?u9Ixxez2IlicDakMn69x5WHqlwg85S0/ZuN3T9TDQMySpqiQhyXqHw0+JmqO?=
 =?us-ascii?Q?zaCAbP/o8p9LlJaA2Pj27lv5Zo5vNMhSjzqsxMLqxC88mDn2n2wK4qJapS8f?=
 =?us-ascii?Q?bPmdAB5uwvHqgkoKda6/6hO/COIXOudIsafBd0jkQPbb9FGAKdE25doEN/jC?=
 =?us-ascii?Q?4WSaQhtog4GzC0/TLMqPmNHO+8/yu2LcFlTSdqMDd217PcyBiWTIua91f6Cy?=
 =?us-ascii?Q?0bvzYIp3bboB/MsQcV0hsEsjszCAQ/WoDrjZP8s8q3jhBP/Cq67gWTi4xaUo?=
 =?us-ascii?Q?f6moyyKPGTVkUWWPAn8Elo0C11Ydx/tLFfvRuxy3okDTyeTegzMR/BkVDVxg?=
 =?us-ascii?Q?yc+kjVqAEc/FCesAChzdQ0yrMGq3Q939NgFnvKQG6s8y2XTR88foIOFLz02C?=
 =?us-ascii?Q?9hFEoRHX8iJb5CsXUkqbvvF5WwxJKLHb+hhqpMLcHK/V+poMrKA9yee1l/ut?=
 =?us-ascii?Q?OYn7z3aVj016m6Yt1UDxyIRUT7RAtvqNHN2KYESa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db68fd70-f9ea-4a95-6f27-08dac3949e60
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:10.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2H9ZjTXjZVcBFTh20uXdrnzc0YFlGJJEwNXaaoOytBOLpvrCtGyj8gRsct/Ie1bw8gYb+V5zl42kd83gPg0Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 261c36540079..2b4395854283 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -36,6 +36,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
 		enable-active-high;
 	};
 
-- 
2.37.1

