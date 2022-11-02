Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9FA616185
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKBLN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKBLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:07 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2058.outbound.protection.outlook.com [40.107.103.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34899264B9;
        Wed,  2 Nov 2022 04:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7OvAGvev4Zcp+t6YM/o0ulhdt3KRa/zw82H7PLME61lW9JaxoRZ15oImwqh+V5e+f5cMHte1GNtPo2q1f6QtZwe20GLJQg+jkJqfSrIXGW9MWfEXI5eMYpc9y89xmYJJfnbvdnBS4oB3kkU8v/3S9xrSd7tdw+Iz7YerkPtjks9Aosn/FjusCR3/A1S+8JKI5QrLTJCRoEotbmNbwlWA1TXFaBKFrstHwuuDCH5kPTCtgn0pMtVBpg46WYMFwB2egXecoHB2Zl4IcmwtdREOyUoISmRZ4eVK+7ux1YvRPY6D6WZP45C7tuswjh15CXdr03HqxIrcX5w8SKkO8tftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g20/glyF2cIT93nJCt+AZ9kShNCO7A3mMK6IIH0uDDI=;
 b=DumjhNtAGEOhfGo2M27THhIvK+epsEMcCH14QG6Qyd5h7vQo8C/Is8M2UZcznCSWlltahNeDs0CuXk2g3p9QGAC1t6yDeKg+yq85xUkN45JVF9xJ5bevZ0kHESjaeL+w6CGtFNQKiYoVxk3bv9axumitSMfCvbOKzv5eAz1+/xCGqMAZesF2nFLI2mbYdz6DM6/UJJI1ODg26hMHftGibY/6NvT78bxL8e49VuVcgjbuoK0toYo1s+QeqryST9MBYIETQz1AAJh8lRA6ySCK/CGiPjKepv3aG6GkK7g/dvDYF9hG5f1fczNSuZ/1Yim23pHfhbU5ejBwPRU3gzcKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g20/glyF2cIT93nJCt+AZ9kShNCO7A3mMK6IIH0uDDI=;
 b=EMHqy/SRnUGOksKsmm9N0Gwk3UB+VLKd7qspsuLhT2L4cD7u4Sc2Yq0bj7E+oFNSmnYcscqArRbmEtx3e05Uj80YJyYt1wZwSiovkoP7Lc1xVToIloCCCEn1Na0tHWr++pjDMhjDGj38N4cBb+nn0Gg+rhWu2ASB3h1scyNDqqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Wed, 2 Nov
 2022 11:12:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 11:12:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
Date:   Wed,  2 Nov 2022 19:14:10 +0800
Message-Id: <20221102111410.38737-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 113f12b5-0bde-427a-9d89-08dabcc328ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cR4V9e0Pc4ikKLXAljxFVI0T5wysbCi0Jw5zDWKNooLmyFiY4MUDj6to40eQhIjfip/esnjoIuoTvlQs17A6rA8YmLly8Rvk/oWFhfNhCCglhggUextHE25tqdr/AHnUU2izt8LyIwFBRfJItDi7X9KJ0l02RNn6Ccp6Onz1JPR8URLOG0DII5hNI3LGjtpd4XXJblh0XkxO5JPvZUaSSB8tA9D7nKKwtJ+ZxREXPzgk/J+2l70t0kajUmtMm+R6/sc8dTN0sFay7gAWT7FqMxTScrkwuf/h/46zqO6PJMx9blHq824dLVLk7VNCJyzCIm2JNlHS7B1gUGcNMMCucwqpzM0LxCTFJokVsOZ85sC/NxJHOJNUDUDo6qF2X9/ln8vDzPr3Fznx70JfVNCV6bQcNn4R1CaHT18WWyxfMus7+Q1cEEHYzqkfF7d1jk1MxhCrg/WWBue7GbI0pz3J/XsPII2K+RfB8Tz7d+Jfh//XIfHlkAivlgq2Mli4jCNxRF/y3YbqrgkGSnjTPeXeWk95Y7s/CUlig93dcg3fbwOzoiarnOwAs7dIBK/OvZIrhc0Uwaa/FxXmVwQ8pgZ14rz6H1V26ry53qf00gTyU8D+CNFPO02ibqb9Io3UeG3xl2BSdzv6KECt30rH34FN/ytBv6je1ulGDQvdkpF1rslp89MY4YnvjIneyx2NeHM8u6Ir7ONwMmnYUUYN1Dgfc56NGBHjApAlLbAI3JTU6WSLHWl8Ioivvq1eBwW0kcS3HFcIrbuzZjQ+r38r42IVnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(41300700001)(4744005)(6486002)(4326008)(478600001)(2906002)(316002)(66476007)(8676002)(66556008)(38100700002)(8936002)(5660300002)(6666004)(66946007)(26005)(2616005)(86362001)(1076003)(186003)(52116002)(6506007)(83380400001)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hOw0Sk6jpMYj3MsLBld+ctGkh0jRbb1PYiEG5M2elI92gbjwqtiaf4zNe9YO?=
 =?us-ascii?Q?y2KiClASZJHeo2mSMN7ZYAflfOTrAo5HWGZ75UiZen1beEukvASeeFuQIR63?=
 =?us-ascii?Q?zB0sxy0fcbgOYH1aFdYCfyhP69nrcVE4W7mZBURylaUiC1dLDTEp62WSKbsa?=
 =?us-ascii?Q?9B5m0mtH1Hz8E64WB+DjkNMaVh04oSkPHRgTy+9mIRvYe/njIACSwu5MpWA6?=
 =?us-ascii?Q?TwhFnWL8IpcIPTwrrPuCmf6+k6GKgGwyyjYACthxHCyzix9Szbtj6qIe0nfO?=
 =?us-ascii?Q?7oDPVqOgkF9nQ3vlk999XOSfW42glFy9HfeDy1S1a6cBqBBqn6WWpqV1D/G7?=
 =?us-ascii?Q?cSCJnjDEJ1sdShJBPuoArXR43HtWTKFkc9h30XdhK1LL4l4AwhZZz8UGqx7M?=
 =?us-ascii?Q?Q4ryYuGddYuaa8uA8qXWSuIYu8yLEq2rWziN2elbTn+hTUIxAE0v71B6Pt7+?=
 =?us-ascii?Q?CKLckXnUsbrjDTlB+BdQ0zGN3Ch/avqXLd6NyjLLfKeF/U80Yfkmtnxxyvb9?=
 =?us-ascii?Q?4NHYiirA7dYjvF0YMq8O6a6Cc4qIQbthMYzX5xYijn8Gnc4DfGFOuvrHQgZH?=
 =?us-ascii?Q?ZTRamu7Sih+oZc4LKalTeS7Ltfh6J/8CwUJLLSCeeM7cz864R1Zr72oTWQN9?=
 =?us-ascii?Q?+r8QugtviDAZBxf5tY2MTIFCp0M5p9Rpz/U9ae26/1L9j/fwJpcWiBsOfjF2?=
 =?us-ascii?Q?yxT9bup60IBX4iV/VWamv/QTXYGERHh5mwIM6o1MWXdzwYftSAtkWioQAd82?=
 =?us-ascii?Q?GXdCFnYBlTfgia7gaxxrAYyglgZBZEXhpDeyI4nds8xZQyshK3oyDU3T0A6w?=
 =?us-ascii?Q?a1UXKJy9vHl5fK+Gkz/I7EFu5OuO7IbJ7gGYYA/yHUQIpXJlr3igGe+YrESb?=
 =?us-ascii?Q?rSJXv10dodP3pGaJWk0h7PXoonuulrMoGzwEihruoUQ5Utf3S9/zTWAcfMTs?=
 =?us-ascii?Q?q8bYvHIxMZnmFWAXhDvIZs9+/hpB4lsp03opk7DsjJdfeKe5nj0R0E/zRIp3?=
 =?us-ascii?Q?O6rS+EBSc1DKJbmK/1mW194hl9/jztO7tqNR0qkX0ZMq0mWNlfFKotr+24DU?=
 =?us-ascii?Q?VNa0Gymv9NLcLOX2yvypndT74FU5Wt1UQzKQ+Of76zHlbKfGdTvR/7fBd7/W?=
 =?us-ascii?Q?OKki7L1q39o9zl3S3CB/ivC8sQYpkhuKDX0hPKrRghrQfM4i2CAQ5KoJZ5dW?=
 =?us-ascii?Q?zT1E2zFSbGI4piwNut4kkw5ozYCnVoBfFxRI2O1SeEe0tesArKRGs6gyZAgf?=
 =?us-ascii?Q?+ztorosLgQiFyXf1sSlKk3KUBsxar5CqLNfrVQAddV10y841P2pJTbSQC1iD?=
 =?us-ascii?Q?D7egAOFqoDpO6w3LRGQWXnweDEI5U3H6E+aDDS6NlthW+TWN+9ZxvqXxpZlw?=
 =?us-ascii?Q?vpeqPjAwFnpJRkDgJUkN6Fu+rcf4liaZDQNTxq1i7sxrJQgf4GeRMcoh8B1J?=
 =?us-ascii?Q?EOq070gVQQnctVIIyRzRfNU0sK7hcbHyD0KCXAIZbx/gmTMENExZCrr5o/il?=
 =?us-ascii?Q?e/bBU5XQjYf19Kmcp/A4KOjRp9sNFAK+rnvvcfCIjMdNPE7eTmdzLNpRMuwu?=
 =?us-ascii?Q?B273pM/YMrNx+vO5euldNwZlz9vfuQAIRsO790xp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113f12b5-0bde-427a-9d89-08dabcc328ad
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 11:12:41.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcC9aNcCiLDcvf4aBY7CEADyaWS706a1TLwztziafFRJBofDs/yguHOiFWio71EbC4hCh0jqSF4mQNlJ+0xWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to updated reference mannual, the M33 DRAM view of
0x[C,D]0000000 maps to A55 0xC0000000, so correct it.

Fixes: 9222fabf0e39 ("remoteproc: imx_rproc: Support i.MX93")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 2c471e46f4ca..9fc978e0393c 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -134,8 +134,8 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
 	{ 0x80000000, 0x80000000, 0x10000000, 0 },
 	{ 0x90000000, 0x80000000, 0x10000000, 0 },
 
-	{ 0xC0000000, 0xa0000000, 0x10000000, 0 },
-	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
+	{ 0xC0000000, 0xC0000000, 0x10000000, 0 },
+	{ 0xD0000000, 0xC0000000, 0x10000000, 0 },
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
-- 
2.37.1

