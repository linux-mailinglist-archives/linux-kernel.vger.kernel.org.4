Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010455FFFB3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJPNwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPNwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:52:17 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130044.outbound.protection.outlook.com [40.107.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701EC34985;
        Sun, 16 Oct 2022 06:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MStsA8qBPaZmw4UZ1Q7LlHinl/TQd7d6PRGl0uLzgNMjV9KacqKS2PymOwVMzXakRwNsgc1KhAYA5vql6FrOajGUk3L4MEy7on4BhFodinJJRd6AfhzOt6a+It5ZkvZfu1udg1ONM1LOAHLAmL1WuFYNITSu8FcobV4lB1gxSX8KeeGf43XUSdGe9Qh3LQV7zMwnxWini/Z5a3/1zEdL9PbW/13W+kbJ6LUbsZjGjT4PVeLohg7BA/i590Tklo1zWIKNprmAbokuaaq60I9dgtsGduVbY1+4pe3L1dO/X4eSENm3NNWGLQ4Dk2msiesVa2u2bwFJwnFpGqy6WlYVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dDCDn2uhf8VX5gl/G265a7U8zGhv62uupqW5+zCYqw=;
 b=IW8+v9tPxqY7vMQ42uIjxeeGv4LtgoSlHeG2j+xxmejJQ+CQ5MIeH164c2cXoJR+5PGy8oc6NDAWshQlHUXGcKHt5xrxbcGVlmaaC7NP371DJbAec/BEJZr3PZJ35U60kuBKOyLX/WSBSf9uLBxsJBPGYHrqNGUUs6CD6sRJNmJtMU3j+wg5U0KDCqcyRSvgWfvmqZmAsZ2JDTKZQfNqXTz7QACWfGregOjVTLKIq/qmz+V5nG0ciSuLgD2hsz/HcpeCN98lYpDih80Wfc39HkRGF9nz6c+v8KiSSTDIKkfhdsoRODAW+51gX4BsVGePQml3RlZIUq66w1EoBdAKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dDCDn2uhf8VX5gl/G265a7U8zGhv62uupqW5+zCYqw=;
 b=ZDk8WdhQWIvv+qYMxzq4jx0DRJNee8bPcKO2EyiHMnulWlmgDCi/6kIIWMPD9Rp/gComUkI3imGa0LbZQq1ad0Mv5MJBpqwG+qJ42RmoUMydIoVuvsfF5XngwoLGXULEX3q24IuZ7/E+nzEmcPLNMDrNSgle3q+6R9u7xffWvGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AS8PR04MB8149.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Sun, 16 Oct
 2022 13:52:12 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::a1ae:2f3c:6a54:fb24]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::a1ae:2f3c:6a54:fb24%4]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 13:52:12 +0000
From:   Mirela Rabulea <mirela.rabulea@oss.nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        dan.carpenter@oracle.com, ming.qian@nxp.com
Cc:     linux-media@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com
Subject: [PATCH] media: imx-jpeg: Fix Coverity issue in probe
Date:   Sun, 16 Oct 2022 16:52:00 +0300
Message-Id: <20221016135200.3406628-1-mirela.rabulea@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:208:14::17) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|AS8PR04MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 8202f536-b9ff-4cab-7fa5-08daaf7da03c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sos8eGzWfnkqYDaOBHN4mRTbSnK3tI9Vtu69QZtndrpbr6UiVFDu2WB6PWL79RtHslAPGT8vcX0oArB/iiOPVWmQDOFz/1oIbFiyRlvieCfYXVVsx3FpeH++oSOlXs7z4fP87LxuG5hBbGrQQOEt+UqdHyZxiQMiFqatQoBoWhGF2bLe/8GLXby3s5OBvs+PEFmDL0Fot8Coju5g5Xv2xT8tt0yEwMcv4zZG9WfOx8wJTiMQi4lIjPDQBF3CEmrNDBfFhFEh4yzSoqN3ZUMcDfkmMjTavTlz9m4SYIv2zW+fz6IWfoLwn6iyIrODKW+k0025V2z84yCLuWfAaMhJ6WBmcgqgk1vO3RR7q3C/juIsPjYznDJZifg8sSJCQfF3Ug/rHXDrVozZQSlwnObvR94/22dFVf/QADrKZDJZjRf8km831GyeSaFdXwCJrfeEusHc/qkxlSjZEucS8pFVBqlhFHmvkYUxvT4SP34Z7dBiyOY4K1e44kGHbeeyDmM30qBZAFjN/s9ur2c4PjHh8ncE1V6U0nTOFT4EteQgemrQthr6iJLjV1/yw9S5Bq0e01Otj3YOZ5kk5gYGTBK0fJSz/YKiW2N1eLsxm8+v1LW+CNNUkEB5i4wZLwM5gQdbFneBQK6h+nqsBh7vvez+Ad3iqCJsNfD2Pc+99XUzbhlIqCAimM+E6VregKRhyKZTVsupYvqYvKqwTl6mnYLE2GmB/h42dzhNN1I3lqkBCa+4T1VU2trzFDvlQ8n1SYC3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(6512007)(26005)(2616005)(52116002)(6506007)(6666004)(186003)(1076003)(316002)(66476007)(66946007)(66556008)(478600001)(6486002)(2906002)(8676002)(86362001)(38350700002)(38100700002)(41300700001)(4744005)(5660300002)(8936002)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YRwAlaBY74CjHvNfCVCCUEwgesHIuH+5ggBNIrJnNY3Fw9iX3j0O010djtqI?=
 =?us-ascii?Q?pqmPpkcTfn+yFn6x1L3FqV/MO5mwH8P5gqyxPYP0JJr3PbVuV6r6Jp/s071F?=
 =?us-ascii?Q?7JwALhYfuDIYmIj6NscAxSfzt3KkX7y6MMhC61TwOkzjLnvLAR1sRY+1T3BY?=
 =?us-ascii?Q?kFpyHFMHaqHKU9DcEly7RPLj0DD338jnsngEyCSYnn2+n/BfSkrUgVXTPbvG?=
 =?us-ascii?Q?LCuLDKo7KY5JJsqdWcTyTYcA5nYWy/j+e48kjBRR/hj7Cpe3kdccLS48hTob?=
 =?us-ascii?Q?dEvA00yDlFeTjOnZ8tPx3AC0cazR0XFoDMbGB2CXq/ysiH9vaZdDu9Z/gonG?=
 =?us-ascii?Q?F8zgLCmQ+itq1ZvREk1S7nWxjRSYqP8umzQPOs52BwTO9cmXNgoOkw7XkPV5?=
 =?us-ascii?Q?lB+/ZDUIvauatTf9ZprvZ1BRpmO46iY0IjlYWTAC9HSIZg05lCpfPnTzh7lY?=
 =?us-ascii?Q?NDyP/tL0EwDeqvf2xbB5TpRrYleYAEJ+zEyEiUjDQGN/GF/BBT7unAuNp+zS?=
 =?us-ascii?Q?kwyo00Z+7DwU6Hv3kGjf5Aqvr7unrAOOOd4nliU/qmvgEsJqeOQb909zprpv?=
 =?us-ascii?Q?LCUVrY0VZcbbujrL3xxBfBxizzGCm9WD9kIVxracjCRwHmFk3u3tZRxxcKLc?=
 =?us-ascii?Q?kF/nFzRmfVcYF4WcLNbhrthjJkfQ0asFoeEU+zfDQ9BaC5wCMIqhzlGfl1Tp?=
 =?us-ascii?Q?ged6YifRvXdCK4J0EnqxjEIWBqDakKlwSPqYwKAqwbxz22+LakSryhmExWiu?=
 =?us-ascii?Q?3cVpE+UOnNu70s71T0bpOK8FZCWzmtre0xQ1thllFpimqeEkTOdsAc13sQpF?=
 =?us-ascii?Q?H4Tid1jOki4GPdeydth+VfmzpJIWyTQEiQjJqMXc6DdqR8tAKCEALOUwJBd8?=
 =?us-ascii?Q?/7tdaoND4iURk57GkLb7kFs2W62nhrrZgoR7n2AS2KLgOXEt3LqBZdA7mt22?=
 =?us-ascii?Q?qtvt4rktz4SVULmNYrv91aDRwEg/8iXBTPFBjn/KbbE9xTl7gWBeYQVL6t/6?=
 =?us-ascii?Q?JYPxYCLNjUNf9tMksP9qz2vEM1R7nX9sALdZTd+JMmzLG+O8ik9FDsNihQ/a?=
 =?us-ascii?Q?/w9Z989MnikAnQQNPFRkhIeeEwW1rz+s7OICH+1CQhInZiUZi1ZMdRj7zn1P?=
 =?us-ascii?Q?L4UMiyfFYGtH13mxBNeNFwLjwOEs1p84C0ry/RYFa+FoIkMw45qc85EDPAkD?=
 =?us-ascii?Q?VlUR3HJKXKUS29TGh14Oky0v51N7LebhXWkn5/+VCTb+yg912JZe0/Qd7DF1?=
 =?us-ascii?Q?nqT5Kwnhsf8qFz5L9n3ytn6K0lPgw6esQ1LalezQcCDjep8+KtldkvVHjEMr?=
 =?us-ascii?Q?Vool4OV84t1L0yiAX6xg5uGWJgkq3WP1niGeFRTN8gLmGi+nJmXGnZXTb12n?=
 =?us-ascii?Q?q+BNMXY6dhDxIGwX9dtVesjsDahlxsx9XDSgnuRKtrL0NytNxn5+gMIP5Azq?=
 =?us-ascii?Q?s8kVp10nd5coY9LE3XlY/hWTzydi4j7R5kds1ut4BrOB02f0Wm2KzsN62RJW?=
 =?us-ascii?Q?rKQffIWaOOmiRsRro/AvF0kJxXDpmwojmJ6Pk2GNRTALZcPvC/rrueGdQfJ/?=
 =?us-ascii?Q?Nfvmr/XurcwtmVgLpFwti3Ft3ljZ6yrU5klBXfOzFZ4Vmo9tycFslCbFM+4c?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8202f536-b9ff-4cab-7fa5-08daaf7da03c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 13:52:12.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eZ9lgUukL/NHWQ4OcXrTZJ94qercNgP3jsuXMBOePivNDMzAkbKM9/nftcL4htSdas1flQpaPHDpiFWjnaNew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8149
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Possible dereference null return after of_match_node,
so check for NULL of_id.

Signed-off-by: Mirela Rabulea <mirela.rabulea@oss.nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 51a503f0a47b..9d0a361a94cb 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2432,6 +2432,8 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	unsigned int slot;
 
 	of_id = of_match_node(mxc_jpeg_match, dev->of_node);
+	if (!of_id)
+		return -ENODEV;
 	mode = *(const int *)of_id->data;
 
 	jpeg = devm_kzalloc(dev, sizeof(struct mxc_jpeg_dev), GFP_KERNEL);
-- 
2.25.1

