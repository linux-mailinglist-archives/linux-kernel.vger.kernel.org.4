Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFE8620682
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiKHCRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiKHCRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:10 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544027FC5;
        Mon,  7 Nov 2022 18:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJdLLdWgqbuYZGT9HjPjv2dsiVwaZpOzyT1KaJ+YZXwwB8e5fTGVHmOW1PJ2fkLJRdQzfrQQQGz0AbCSPdxDdEO29qtahchggDFB1u0pFVZatXmuYqze4btAwqJpFE7mHcatAuFF6aqA+igzxZcHjwp3t8TRR53jWssSTmmUmG+rVMFRF162CIGQAJZlLaYu3F5Ue6uF42oNBGkDAX7SJVdD6YnTIEKpCdTk5utaB2mg8Pi2YdnoYByVJfTrXfV75RIA2uZ+nq9KKjq/01S8KiBUNqHQmm3hMA0LW34bcAlRqL0kP+Tj8RjSwRvhig7+hliALi3kMiPsUjYv/hTlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQby33EV02onxRlFM7akkEkA0XvFpAwKcx9wYCEmXOc=;
 b=mkxngH1gbqeziEkmVj1sd5iJ8VKDUjxiGJXVOkqx4X9nG/bjouwlK6kOIkfFuwU8rsziXRRUhBZ9Z2+OtJ4+UknRzqcteUb57plRlpP+u9uE3yvLGm5kIGmngpHhHoD+pMl6h2KxM2HNCg1sDL1OYKEH5v3/gET9RxqSlsAYPhp9LUR5je+9aLrgUBglz7xkbPGqayA7/gvfWJ4Xieo+dh4+Pev8843D6VH3dF9uG/vD4+X0P5QgVf2/RF77AC0UTu8t92nJG3SsKrfP0y/q679xnSi442n3gwWPpQAr2caPBMLuQPHjd3DYBGdn2vpKhUEFC9/KUInxUSmOfEODOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQby33EV02onxRlFM7akkEkA0XvFpAwKcx9wYCEmXOc=;
 b=ar/xVr28vnOIuH7SXR5RNMtR+EUpjx7M3+4KWnL1/9yrtwM7HiR+mkI2QtbB/IuBoCdBZHNM4r2XipuSc9XCB87h5LmB+eADzs33COkl4rAKvShEFWpFGonHlB/+m4CSEBsku3wbii1xlIC6F/xlsozO9fhvr83Mb19eKlRW3/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V3 01/14] arm64: dts: imx8mp: add mlmix power domain
Date:   Tue,  8 Nov 2022 10:18:07 +0800
Message-Id: <20221108021820.1854971-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 673127b1-e95f-4ab7-c980-08dac12f532d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Db0wARPG5uuZOKZ0Cz62k94lArVCw9is+zkqUsOMqSDURgshAupv8CesJc57OXe5krTpK7raXmiiDE3ukf2N7LahCi6juw5lLiIT7j3rxkl1/yRzyT2VNB+aMzAqeL3GF2k4I4X0FNzDawefkJIUXXY1zVUPlux9Ougzfz0TF+ev82kQqxgIgyNgAhmV9vBpHnRw3btH33oSgYzerUquzYTcRKPjEGIW4EqFrIORZTZw5C8tWidnZIXsKAlxU1/VtnMDkJIQRrpq4kdkdICThCp6yllqcSQJa9AW1iJz7KUkIl9aUJykhyVXLuYKguHK6tldVWqZ9SFo9dS8uV06GEJKwpychJm8kez/Nnc+ZEl6SxZc5fmS1Cuqae8PQZYZWQlJTD4AiCVrIv0vkqmhCufKmQ19BAq3uU69/fh3+fWMm5UqFlUPNt2RYUN1TccdtyovxHo8AGg8GwSPz7GgZKPOwlC/Nqb4cuErOOsijUQPUSAn4aq8BbUusLEKrykLcMByRoasw3Xow4+s6hegPJBsZ+yEiIUshFHN7vZ3JXmzx7c4TbtQNXmGcjh4naIImQe4kaE6vjoemqmTYCSxySCx3/b1q//gBxogfhCrGWfXJ6D3usUDhrME976tM/QTk4rIjcN9ikM6RTy6S9ZJ027S4PS32LHiq/E9nLwv++sEVvxMrBAFVEUN9BPKdW81s8xVoSC3tC32yEp8AnVAPIMPH3icO8sTuo48zfGpWkQavB87NHIibbgEqu/XrIlDVlRvwtIkagl8Getc4/zw/83enOvHc6b29cqSaj+2n4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(1076003)(5660300002)(8936002)(7416002)(54906003)(41300700001)(6486002)(2906002)(4744005)(86362001)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(26005)(186003)(83380400001)(52116002)(2616005)(6512007)(38350700002)(66476007)(38100700002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dMSmBCu6vkrhiOfEXEmBT5P988ojgNL7lUWhrtZ9SbGPhKX/dlPxwW1OT4Ct?=
 =?us-ascii?Q?Bv+yBegBcqtkuNZFbVR9LqZVJuewhzlfSfKTw7EncuYm/BzrP+xNLgErgFAV?=
 =?us-ascii?Q?Nu1OZsgg554cR61uPJa7nlLO9xQrx/va8uQeYQXrX7bjs7dVwgX6JwRmzliO?=
 =?us-ascii?Q?dpbH+tpIPXWMrUyHI6TgMcrMeneUJWzeVE1+TKLOnQMGeE+qczdWA6flv2Me?=
 =?us-ascii?Q?YIyYDwjEIFwfaOGmJw9cEfvIBLjckiA/W6vQ1AJrjoWrv+MVUGRmRECatp4m?=
 =?us-ascii?Q?9+bV5RO8z32FDRUHnDLQvGjsIqkjxdMt9jqwcpdlzh1zQu2TTUaMLMpOvodu?=
 =?us-ascii?Q?P3nMyI4QG2vrib1xNUssxmNcXILdzFrCPe+V3JYW9wM6oJMXECWvjHi+X8YM?=
 =?us-ascii?Q?uca/HsUDipA4Of4KuC8OmX18vOEZEW9ciqc3UA7IHMZfbSKlQ4Cg+/ZW6rXi?=
 =?us-ascii?Q?GMtU8KxSIYd+m5J7P9TwcHf7zKdHOfvGdoKeEMt1kphcn1hfLLaHpRuZqB5W?=
 =?us-ascii?Q?FES172h06thT6GRfXu+bua2F0izxej5kmvDOejOGHfYs89J7Vb3vCQaCQkOD?=
 =?us-ascii?Q?o3rbX125E+o6FEWYLyQ56CjIiRBxUCqdA2mj1p21UESqUlE8icWSEEKuw/w0?=
 =?us-ascii?Q?/E/Fl2Lf5JkE9Lp8pedD4PlMuiFAOVj7A6qA4ux7Y3TL6LkuM4fg8Ad0wfzC?=
 =?us-ascii?Q?dobWWrwt93vZO55SB0xUlQg64N+deTK3ocrywX12VAuduv3sLaghKHNFuXQ5?=
 =?us-ascii?Q?3MTkHogAjpU1ohfXSffZVeto+iDvfJ1nc1Pja1CFFGg/6CbhEyPRpP4WATSs?=
 =?us-ascii?Q?mzfS6I8WJcQG0RZhNK4LFH3P7EhiLhlep5/6l513uSuhgrgM4a7SvPLpbraP?=
 =?us-ascii?Q?Ai+jXyr5Nwz647T6Pt3/4aQj0zTr5Sfbn0ytF5s7+E41G80ElPthgEdMRGNP?=
 =?us-ascii?Q?zYWfdwDfnNkA07it2l+EnlBd41DlBz4HMNl/WlQXURnwm44GVzyGCA+H/thp?=
 =?us-ascii?Q?y+XnLSaV8Vt33vBj42lOeVMUknSrHZvop+IJ/eNJE+1qhcvO8Sf8gWSb0lJV?=
 =?us-ascii?Q?Fha65CqqcZ5+lveJ3/HFKBJD4W1LUPttd6KSj7NBgqbwUjjgyCdPYGiHCSM1?=
 =?us-ascii?Q?sBaDGInnAiMvR4Ogp/b+akallT/0yBXlI3tAvzLfCtQD7j0kY8qKv3fKDDu8?=
 =?us-ascii?Q?DSGD/7gZwDDunRA0h5aSadCdbWZRI2GmcaSYZ078TqwUG5MEwr3H9RNz3H7M?=
 =?us-ascii?Q?SfDzYMM+hPv4aKikeHtvqUWF8qFusNSP0wGWqYsmqt+gvvuQUdJTGcpPQKuA?=
 =?us-ascii?Q?O478hnUvo4Fg0RuynP/7VzhcuKJ874WcWEerdrWbRvnGpowHfodz0xANMgd0?=
 =?us-ascii?Q?P/9mLuAAiQRtTDEqK/JMOksW+MrhsJejJqqAi+pqSRn0/y3DrRe5F6ew9mjN?=
 =?us-ascii?Q?jFPx4z9zh/gNTrE7Fry/fmDZT2cEEFhq7xf3jGq1BznKLrnonvlF3g8iRY3q?=
 =?us-ascii?Q?qnnTTIm9pspfqfzMzLQTJ8cbBH5XjiKOTFBdKL4Z8catLryHEGE+4ISSsoMC?=
 =?us-ascii?Q?RACfwvbvmbr4R+6jZblPfyfveFbkl6XtIOTEofsQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673127b1-e95f-4ab7-c980-08dac12f532d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:03.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGgrgs5QRMbesUiEcnu35AAhcIn20Tvl2Z6qXgtbQsgFdmub3Fum3Dz0L8zG65vM4BxVl1hwc2kPaZ0/ujVD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mlmix power domain

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 7be02cd100cf..08704d2d9fdf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -631,6 +631,14 @@ pgc_vpu_vc8000e: power-domain@22 {
 						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
 						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
 					};
+
+					pgc_mlmix: power-domain@24 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
+						clocks = <&clk IMX8MP_CLK_ML_AXI>,
+							 <&clk IMX8MP_CLK_ML_AHB>,
+							 <&clk IMX8MP_CLK_NPU_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.37.1

