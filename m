Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B0B6D177E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCaGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:34:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE751CB80;
        Thu, 30 Mar 2023 23:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDRgD2Ed3tq6pC0XXk2aNNQt34EnVsIom+UieSSBL0PdhoJe/ZcSIG+fVXUckUkWhzSUtW5DNxsFAdo5Yp7IXxXkLtaXgH0owm370lH2/fe6ihaUs2gBXiRg2eOJY9+ze6cABvGZ2XSTYIB66qsQmZd02SLjJuxCBJJBY77YcMHrN83Jo3L1ZxYWHYHSt+e/9tlplWFMwD6vu4AmvlIHq7sPeNt/0Rvya7a35xIaCacwwuRqBtxup4qlBQe4oZt4WPL2oly6yyYuJByU25QXSJQAATUYjLyoIV7ESYZdbv0ZxVEMWTiJHemd7WlQUpdScsJS3Uw3u8BzkN6AUc5WWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY5uwQC9+WsuyirzBJZcLQntfeLaO9VQUhQhxE+Kbf8=;
 b=HPm7i7F/a0B6E3QKn7BOa0SaU9nUqlz9zI5uL8BZjPmYFcAwGrNmekli54rT1oqrYJJ7jNrcIB61oxzhGEaJUCMRqFtctqKPTFjyHptupxOoW//WJbvfsHSSwDE0lEGcAueqSzMIA5IxqECHDJ1iN/Gn7r65zCbBODfTvHGQ7WkHzffv1bdusegyEUQD2gM9jfqQf1XmiSBAwC6nPlN1RwjotVoDnP8e2wlaewXkUK6s3cQgucXb6ZYFRA2yXcRnsxRC8q2zkmXF+hwJyXnv0PKO30Mevi0n++AAUVT0Qe2srDhrhFQL02pShunCTmo+X68217FSzrWVhLQEoad4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY5uwQC9+WsuyirzBJZcLQntfeLaO9VQUhQhxE+Kbf8=;
 b=le691XHMZIl7Du+cmC/Tb9GhxzY2nQPWiubztAbmFQBX2lXralPeGR+EqQwC33z4jDY+0klT2lnBmZxr4+3KSPi9VX+XnbVrTczOfZqV6hzx9wjZ72SEeFrNPsUVw9HeEDMyQSon5I5HprRCC/K0MqhFM3riVJS1JZA2WTqv9BM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7356.eurprd04.prod.outlook.com (2603:10a6:102:8d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 06:33:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:33:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/5] clk: imx: imx8ulp: keep MU0_B clock enabled always
Date:   Fri, 31 Mar 2023 14:38:12 +0800
Message-Id: <20230331063814.2462059-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a83280-091c-429c-4861-08db31b1de81
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTs4s61CJJRXse5zk5XYxVcC3jIqrL4GooI1qqMyMOOSRJQWyX3iQpiLHPJFqqPNbM2z0ePTTY/XFZfZqflyrOt7iorDq9v7rdWbbMLRgLIZCO1MQhtLAqo9ahgJqvjQJLpEqdoOHGEJK6yeNEoRVI1/gFl3O533t9YFbvzoU3SyTM14uMb5atmcToi5iYUrSSztR3YsxuXQjS7n5FDxB5FbStioIq/GwYetQb87JaiA4Y6CDIndL97Vh33iHX/IiekXWTYCDq3KW6m79p9mf+c2feDOXoKUy4AOe0JbFKA3TH4WkSQmKmioSZNJKOhb2B2Prvx3BFYE3Zjwa1TaTYtNPw2+0rwj/hEDg0oYBqeLpTpv6DV9JOoMuAxb9UmEjIx3cjhlMowDzAL62x8de0jKxiTX6s3cOKibg7V4hOZo6ho8RNi+oiWzslB6Lv35VbTZNGic93hYY6qcuMSidrTwYpvgr7l6tHxhseot92Ou69kj7HR+letwWE2H/C18TXj9B+Nv/m1dVIlqvhAYJgnk9qkQtC9+3Xzy2r8UVnnkHqfCNWDoyTLSn4ZfSQ1gaBfGrHySQqmS2PVTKtC/oSAi/GLTEjPXeBkpTmPqY4upvZNP5BuygBMKxMKn1J6xZRUiyctnRiB+zsAHBWcQfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(38100700002)(5660300002)(8936002)(7416002)(66946007)(41300700001)(38350700002)(4326008)(8676002)(66476007)(66556008)(6486002)(83380400001)(2616005)(54906003)(6512007)(26005)(1076003)(186003)(6666004)(86362001)(6506007)(2906002)(52116002)(478600001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kfmnYCY+Xn+T4IulkjhyiYZzpWAuSV384MHmA+w5HN26EyiY4VcN+CH8/m9?=
 =?us-ascii?Q?mwyqhcIs+ta0jWhIr9P3ixBqbkRPCMBfE2k7p+12dmRCDKEegU0Ddx1H5cr6?=
 =?us-ascii?Q?lmkqAM+GKDdImg/AT/7WMngVmIfo69RVCHdgAaHCt46f7aSHOk1oOnKuc5tz?=
 =?us-ascii?Q?+OjfUvZWkelI1iEhy/0feOFNWtgIkLQJ8u+FEttNhLwwUmWAVHvJi7F9c6dw?=
 =?us-ascii?Q?mF+xqIaguz50O10GKYmBjU0WsWeE1ml7XZQyp72/s4VnRInomxNv59OfW7DH?=
 =?us-ascii?Q?MOSkDCd2v3CpeUOs86Fg1Qz8nR/tqtnjts4v30+bLBm8Q4fDpe5FS7mk5Mqn?=
 =?us-ascii?Q?vyHVgNBd+H90XWG2yfo1OxrrgXWaXjJlpC/5pvvhHGLAh99gZfJBvMDdEDgI?=
 =?us-ascii?Q?3+3u0NERmtb/8Ay+0Qxsd6lZOXd7RXOXD9Bi7sae7FRPaSqVUAeVmuZlmrE3?=
 =?us-ascii?Q?BXfYyjUC2LIXo+07dYncdk47cu7FecVhx0hO8L061/3wua8xQmBEMN771td/?=
 =?us-ascii?Q?TpPI4VdN+U5Fur9AFbzG590+hXoyKVgvzPQBFgsS7EZ9vnm9ePp3c1QO5wD5?=
 =?us-ascii?Q?zictHaKouvSIQUGFb5EIIxWM+eKv+lwGwGyfOuXJr/VhFOwTKoHr8N5ZGuRu?=
 =?us-ascii?Q?L9wWQNBh37eHldx9QFdiKxJhHcBSt89WFZlPqw4RA7RcbCEGOqPasP++gCxR?=
 =?us-ascii?Q?8fkywuMjudzFAowWIGqZ3QUDCYqaNaaB2kQx6n5OPQKqih4wZNdiBaEBXZrL?=
 =?us-ascii?Q?yjlUlDt4fWdwJV26KPeE9A6lLaaL20kpKmaQz9ZKZZuppTRMIEoYtk+9e7y+?=
 =?us-ascii?Q?HHhqzs/U2TFd6fHBVC2ur/AlbOKm4hjk1z7gIo0vRyGDBo2h4QjMjfQ8HbY0?=
 =?us-ascii?Q?EWoyYXG0G7o9Ue4wxplHPUn2cFuvpcURX7QUqdXArZcds74PSvaEtgiQQFjq?=
 =?us-ascii?Q?AZWwc9p/5mnuQdKp+MeO9fVu329RqoSPKEUHmv9jvUrecZ0JTC4e9Byt+Zrf?=
 =?us-ascii?Q?HMumv20NdOaVei8SsferCiJwubEzHVW/fsvTVSN7PAsqyYsH+IYkYhWaDwqu?=
 =?us-ascii?Q?C4RKUEzs3MUnoKCGyDsz7W5F70hCduXNx075Wu4tTWU6AEyg1ybXykDDyEd/?=
 =?us-ascii?Q?oCukwLU5nBnP/7pKO6CNkDQAs4+x2oRh7FAwjXCCwNS1sPI0Apov6du3RvmN?=
 =?us-ascii?Q?kCKwv5QuHf3V2xdC8BUG+9E7q1Fcc+h2p9oPsBvEQr+uarEqt/aIa0UCq2Qu?=
 =?us-ascii?Q?8dWJ/Cw1wC5rf30/Yl8zTjjITjC6FQ/E3Hk5rnLMQd1lnkklqDknm/D9XkkI?=
 =?us-ascii?Q?Ng3OcKNaWHA76aqQU3c9StREKVqsQmoYSFJvdcyPB89ZzjClCdpf3WVXIJ+G?=
 =?us-ascii?Q?yWRee4Le5bPkvSKjNwdqxN+k16EwHKpXsGe4E8xYyzhjPA5A/0+SALqYOu9w?=
 =?us-ascii?Q?X6mMDCPt5enyLUpXK6GDYU1fEufMzKSRV1vsIa4zwwRN7vQMVYv8XUGV3gze?=
 =?us-ascii?Q?NM0+VGIVrHBdfFwo1zxrEnOI+OBSYKQQ6oIEEBKj1tF/HTOUF7lsgt7SrmGC?=
 =?us-ascii?Q?fONKVBLhQM+9LQ8PAmzHArFKkPvKKMlQ4PG0yVS0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a83280-091c-429c-4861-08db31b1de81
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:33:41.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya82YARoqyKN4HFEGYFHKNVTDxuud3II3PlSo6stcwR/K2AnE2BCvd5IhWtQdYa2ULjmaV6e45HMsQFNMw/9uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7356
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Keep the A35<->M33 MU0_B clock enabled always for low power
communication.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8ulp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index 3cf4b094dfff..0dd48e8159ee 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -376,7 +376,7 @@ static int imx8ulp_clk_pcc3_init(struct platform_device *pdev)
 	clks[IMX8ULP_CLK_DMA1_CH29] = imx_clk_hw_gate("pcc_dma1_ch29", "xbar_ad_divplat", base + 0x7c, 30);
 	clks[IMX8ULP_CLK_DMA1_CH30] = imx_clk_hw_gate("pcc_dma1_ch30", "xbar_ad_divplat", base + 0x80, 30);
 	clks[IMX8ULP_CLK_DMA1_CH31] = imx_clk_hw_gate("pcc_dma1_ch31", "xbar_ad_divplat", base + 0x84, 30);
-	clks[IMX8ULP_CLK_MU0_B] = imx_clk_hw_gate("mu0_b", "xbar_ad_divplat", base + 0x88, 30);
+	clks[IMX8ULP_CLK_MU0_B] = imx_clk_hw_gate_flags("mu0_b", "xbar_ad_divplat", base + 0x88, 30, CLK_IS_CRITICAL);
 	clks[IMX8ULP_CLK_MU3_A] = imx_clk_hw_gate("mu3_a", "xbar_ad_divplat", base + 0x8c, 30);
 
 	imx_check_clk_hws(clks, clk_data->num);
-- 
2.37.1

