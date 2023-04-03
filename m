Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017EC6D4119
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjDCJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjDCJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:48:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AD33A9B;
        Mon,  3 Apr 2023 02:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAZ38zf1Zj+XOkgBGbqZ7bgY71H+ZZLP8UDLR7JZ9M/jrbj8B+gqtGHXpJbI5HbPZYRwwaxleXEMmsb8dbT0aSPFkdiAp3mh8yRH7DxsEqDezjMgcUe6sA7lJIcTp9Nf8qzvOm5oEqnEEMOI+UqagclmG+zD6dQV63+efNP3eadtHY/jUlbnqOBZstPnxjYD6RBTyr2uM2CZg2CTo9j16IK958Hww1f1Y1EBLUw+XRKqK+O/HSABfisCkfmrMplTee3WI5benw6F35FWThTnHDbtonLPN36FkJ3xkx5GTcC5jpR8t0OdxI7/DVe3b7OqypDQ09HOsbcpPda2U2d/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzruYS+R6AvPKjpuvCaOqvFBbZIy/MVXfW9MaFKqoNk=;
 b=ApRxD2xM7+5VNZQFxYREi8tsWJDDjoTuTkCk7ukbdpz2e6Yu4m8VCQ5Ux7tw62o44j+fLmz7PaqfTctMWgo//DggaItI2jjC7q/fbBtv6dy/FhJTec5szAeo3JCGQMuyN//pPYnAiUFgCO9qxzy1sqhvmQMuTQ7h4j3nPqv3MTR3dWH35CxjZODzYlBOhcd37xyGLBmVbO9JccAQAs6/v8ti0ePocK/ycpLXoNhiRDeVvUBABiNy1ZFyJOO6G4s99z3J0CMpiJeQa49kYtN2SpoDAhAgJuDEqn7gAeN1FTpebY6LYlZsb7lyt3001wffE/5PtuveR4wPpqXoCaZb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzruYS+R6AvPKjpuvCaOqvFBbZIy/MVXfW9MaFKqoNk=;
 b=FG0XC9lAGJF8pv5NCeLSi2pmtakPtGD9LgNIZXAdeKO6IeXUqpefvxCoyqWfvNuQeIKfwqAdr4fu5lqZsJE1DoZLdlQUoeJK2Twrx7CayPrPZsKajM6X+pdp/4R7lpsrEXti6/+Zxn1nRO+1QktiL48CGJht6aFJ+XSmoPvj+Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:47:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:47:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/7] clk: imx: imx93: fix and update
Date:   Mon,  3 Apr 2023 17:52:53 +0800
Message-Id: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab40714-3425-4da7-95ea-08db34287fc6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7atJQz+izDCEddJG3rhhPGsHHIBoRADCRoGJwSu8fS1wK4ZDNXDq6rwbBgBoI4ZOAoU/RYR5lExng3PRnXbqV+h3CDKFTlzuRDYSlzy5rnC/jr+CKkN1bosauCTQvYCS9RdT0i1+c1r8HNzsyxOvQIdrCm15sdMPEk9KcsQWzRek4wprMnkYMsTbe30uN82lYi46Rx3yPpBmLmgv17N0eaqVG3XzWC66IGbjtpkwWkyydFVysM5rCfmtTpFVvNX3p1lPeWlhArhlhgHIOfY4/Op4J+iyaVlhgOQ+JI2OlFiZZcJdbZJ41BcUlz7/38afSmUYE5qKJiIX+lCzqALkEwOM2wZV4H19q+8Jh0SrN9skof9jLd2nrBnW5VBmod1j7By2RXRhZQax0SPLT7nWBoV7v+O4vYRkeL/9wKhguCM/FFZ5ohR/bX3OO/BHWnOrNGUPAv1PW3HTjCAFE7DjYzawfilEG1xeyUqEqbrTeCn+8GMzclBpK/6iqM0WcCf2Cb8Qphvqc/KduFbgVq8CRZdoL3IJsSDQCNqUyud2LLCOuBn7SriNLNZVDMQ8S+4iXSnr+UjdzeBuS5pjgwk3EgxLGBQ5s/mUfn/yCKb5qBBm5GcEMmwrFL7ul8fIhUgR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(4744005)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6512007)(6506007)(1076003)(26005)(86362001)(2906002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P2VQss51t5OmkkTU5+CVJGHHe5ocY8kkFs+szS3eS7IB+qpyT/czaKviUVF7?=
 =?us-ascii?Q?Febu5qGJ6EaYdNB1pM4n0vFbWlDJJlKU0H+NNQfLQpG1UjXEi6M+PT9WtAdA?=
 =?us-ascii?Q?CReVmWkh4mNMhSXQ+M3r4VW+Sf73mK21McVYjREdenDF2bPmYvV5xSEgbQuZ?=
 =?us-ascii?Q?qgXihqKbz9/NWTOxlMiMJIoBD5GV/tmgPuOdLjbq076tOsBDoZCE5H3ve883?=
 =?us-ascii?Q?qrDSYTQBztaLE1G08h/40W4cdSP3fn5ObUuSwQqphD1+p3VKeHewya/kXcYo?=
 =?us-ascii?Q?s1ARj7hw0ZJbCQNfGguJa1R+YO+IThWkoqZJ7QhqR49QvhtE/97uxixDqx6g?=
 =?us-ascii?Q?9wHUBDB0ETc0Qxfp9vKMXR9EZjEomEoSaH70ysulVnRAvgfQ2Hhfex+nUQMI?=
 =?us-ascii?Q?2uQ9ey8J8qBK8Ngmhck5WgS0RfxmTnBNs+SVtqOkvcji/BtSAjHpVs3SEPOe?=
 =?us-ascii?Q?k+lAFmHwevQpNPgLZ0K+WX5l9o0pyJKkgYWU7f0kNEuvIShms2zy+sZOFARR?=
 =?us-ascii?Q?/vFflMkJsP4tyaPIZA8yuVRTdPjHZaSivYFFK7CX7KsBpNXt1nFTniSfOTnQ?=
 =?us-ascii?Q?z1qai9nqV9vcgmb2YO+Ds98BK0J/3cdoeDDu9N5UY+CE4ck5i9V66CrkVeVb?=
 =?us-ascii?Q?PbLX8bi5SjJ5DqsmBPV9MyQ6jvUr0jJyommwpEoq/yrCUAMJEQhylpQb2948?=
 =?us-ascii?Q?W6IWNdzv4YhTV2faNzRuh2XsSGN7vq+Hrs/+hAQfcZ4cxeu4sH+AqXL+3IqP?=
 =?us-ascii?Q?x+kLZ/m1WXBRTnSvB2vUfG8OJRSqOkJ48bQevDw7bktwhvwnv1sd05EtzDfA?=
 =?us-ascii?Q?jIgu0tQMpy1VPLx/1Ks7FGN1QsgicCOp/dKe8b7xuo48NCaiELTOnKqqxx22?=
 =?us-ascii?Q?bTedyRIGLG3TFFmPJp+XaVZkvBKNapUFY4JxdxBG2UDLBlF8YbiW4QoduUzl?=
 =?us-ascii?Q?1ef7ZbuRAzvfk91bDxG7JuxkHp3pzw3f3CmVmbxn0FJUyG7b7L+tfOQhBAme?=
 =?us-ascii?Q?BWPCyaZZoe8nf3vcNtjKQN/EjRei+d/VAo/En8ICkLzZw49LcZnq7Gj7M3fg?=
 =?us-ascii?Q?GrVjD4L/orJ8yRPHqyDNG9nt6w4Ljbmqe0Zdp/CQ80uB/HkZwhgBSaiodeQS?=
 =?us-ascii?Q?VkX5WaA3/tUPMHz3V7YX8ikK4o0Jzj41gNu7H7VyQbmtQ2j5QX7NJLVDev76?=
 =?us-ascii?Q?BaOfnW4M3+bUjmulHBZBEGo1nbZsY3XQKxdCPHv7axqyj5dA+nQIRPqvz9Bi?=
 =?us-ascii?Q?VIfB5RrIfntWdgXPJUT25AvblJZm8GZ8e2hOL8jnGkEkBl0Q9/BXEpnwb0nB?=
 =?us-ascii?Q?0SkcrPNKO9dWO4VyIm0FZ3SEuZdqT9jTNN+FbwczCK6iPLO/DNAkH0PFg41F?=
 =?us-ascii?Q?GtNB5UKDEJXweo+XOegDf6LxMq+BjziK4dDCNchviL9dM3QYLaCMGTQRiwAM?=
 =?us-ascii?Q?5j9OxyfPVL4ZFnBNKHI+52M/PTCwX9rFPaLk2g64seSl9+/AlEzwHJ3Phhlw?=
 =?us-ascii?Q?XFjC3fUzweeF/2zZI+RhWDkXS/ieZgoje4Cub0zch8amNFjjTysDxHqpIte3?=
 =?us-ascii?Q?iZmLnDtsThBkMfZlBFIHEGhf9w9ZA6zCbsMeVS0O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab40714-3425-4da7-95ea-08db34287fc6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:47:55.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR39AgBQ3m09JrbxMvpLoojrejz7uxEI9rjPbzRJZbYpsbhxUUpJqPQnXyYAeSfJQ4v1wTcOKwcS8cXE+LQSKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Update dt-bindings patch subject to match subsystem

V2:
 Separate the dt-binding clock header into patch 6
 Address kernel test robot build warning in patch 3
 Order the patches

V1:
Patch 1,2 is fix the freq table and set rate flow
Patch 3,4,5 is to support integer, A55 clk, mcore_booted parameter


Jacky Bai (1):
  clk: imx: fracn-gppll: Add 300MHz freq support for imx9

Peng Fan (6):
  clk: imx: fracn-gppll: fix the rate table
  clk: imx: fracn-gppll: disable hardware select control
  clk: imx: fracn-gppll: support integer pll
  clk: imx: imx93: add mcore_booted module paratemter
  dt-bindings: clock: imx93: add NIC, A55 and ARM PLL CLK
  clk: imx: imx93: Add nic and A55 clk

 drivers/clk/imx/clk-composite-93.c      |  8 ++-
 drivers/clk/imx/clk-fracn-gppll.c       | 91 +++++++++++++++++++++----
 drivers/clk/imx/clk-imx93.c             | 19 +++++-
 drivers/clk/imx/clk.h                   |  7 ++
 include/dt-bindings/clock/imx93-clock.h |  6 +-
 5 files changed, 113 insertions(+), 18 deletions(-)

-- 
2.37.1

