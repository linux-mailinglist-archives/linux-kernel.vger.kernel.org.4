Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9AC634DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiKWCiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiKWCiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:38:20 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E736D97F;
        Tue, 22 Nov 2022 18:38:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+1NBdXUwGKPDP8L4JqazIvtxT8PyUS1YUNkKN/c9nHjgYlVOdpmbDLDTvHNX+eFoqpwS04+QfMMbitX6hQBDz5A+hQ6cNhQ8q1FdqWRL7F5d7E39PSx2sgR05OQKOqNfXLaBJNXAaNubklN5osDmVuB82GzkWPLxos8U/nwiVm5qWHYAid6OAZkZXab2Bbo6CI2lgi54peTCFU0s92fzcK+dJBLmG9d+aYjR6i1V7knJA2iIATJgJv7yGv51GRsWkshcW1NTrFGs7THNO/X1Us7zqgCn2L6tjb/qt+TnErhnHAdZI4YdkfunssaT3/cGrIA8oMmZ97OcExDbXWGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXGQ9oGFquoZqM2Ue6KlBIaCCJtOtVirG387qgfMul4=;
 b=IJvf4+HgEizaWrmQcZCsipfbZE3Avvn/8J96IwMTVN3m1SwovJa0cG3IiUpQqYdT4azYqYVdH73M0TbWH8qRi2ytT2RRQfu+gM3XvxtMj+vJE+0PVKJwN7lzrqcvHxyrhMYtTKuuTOsnk9hah77R74RXQ3Bna/7vOqtCF+aWhGjJO6vxFWzxiI0nw4WvG332fesPIT3s42KH65YxRSKIiwTRTVBKJJ4FnWK1NX5MM7uR+j+VZfVn+mUMRaZgyoxH4cPuFBN5BB6HYNFj6ZF3sk2BzzdiwWAKkCm8p11JmiYsWeRIYcH7gT/fTmwkf+swXAWmjSnVNaeyLEeGkzAVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXGQ9oGFquoZqM2Ue6KlBIaCCJtOtVirG387qgfMul4=;
 b=PnrU3LUz4vy6wtzQvW77oTkMUA0oRzmH2RKvzNl0l3+D6UR5cqPHGp/04s+SuE1i78lt8XZkEOKaWR1kme3N4BfptEzlohFpWO5DaMBI4Y6DQl95KNLu59Wj77sad76Y6smf9ZV4asTYyNjfeeuiUNxlW3eeuff5hUhXsdS82Ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS1PR04MB9286.eurprd04.prod.outlook.com (2603:10a6:20b:4de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 02:38:16 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 02:38:16 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: switch to new dmaengine_terminate_* API
Date:   Wed, 23 Nov 2022 10:36:19 +0800
Message-Id: <20221123023619.30173-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS1PR04MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: b480f04c-07ed-410b-9bb1-08daccfbc589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4zRuCatbwFts7GLcqKAXrP9Qlb/H/khJGYTcxKv7hjZ25uCJLyGKOdS2buEhiGv795zaO89fYIo2cYzCRaig46cdXJmP9mWjYq+F7NIGTjkUex9dWQ+enJ8QWyg6VttM22Ujg167IJ2Pa766+iz2XdoJC18kJTkCNDsVww6UaIgQVKkzS+bl00kKtvH6/CPpUS81l8sE2KvjfyLrGuu5Hra5e2fCMTq/zryHOnl3qRQEyEBGEx5qwVAX9nV87prvaYj49QgE+0ocewGgPYHXnSBtMyL3wm0zOVk9eD2Rf8rRR9t1/2LUBV+e09cbOEJMTKPtkp4ndqE3nHHiAFax7co+IkIdWcc+IZJ1pWpt6STXhO+nGvW3xKFQQNEefGBHA/w37kEVGb7CVG8USSctuaYE/LNWBs2yKlQeASWWDoO4imhPI6IuUdKGfxJFjjLJ3cwMFjh6oMESEJ2gOD6ebsJlCn/XeyfcZbCaoVly8YcAmWy/7htDhu4Df2mAqBhN68MQCnHpxLHzKVv1IeTO4ndKBlKG444GMnW/YezrTz01vx0/SdEFq2ujAuBPzi+W/jvpb54joNL68ze16mxAfFDMyLCvo+Ak5rQL/LsflKpMD6a4jYpBQO9JhH/ukjiDEf533NfOO1XEw4tcWPmJFLTakzl/KSkgwwHjt+DwIbVu3r1AIeWHV9sAERAltrY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(2906002)(1076003)(2616005)(66946007)(41300700001)(36756003)(86362001)(66556008)(6506007)(38100700002)(4326008)(38350700002)(83380400001)(6486002)(8936002)(52116002)(8676002)(5660300002)(66476007)(186003)(6512007)(44832011)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjEZeWmZ6MAgcJifKsjMEctcMH9KuBt+/MQXkJEf882JxuuWRB77cJnYBVgP?=
 =?us-ascii?Q?fZpgYDDsrJlvwA/Wq1AOEZEF7zk/HRc6OdqwJ20GbFEZKerZpv7wm6qIUVR1?=
 =?us-ascii?Q?JFbZPsb4KY1UzrFndm4a2pQjpF20DkmBktVhLHlYRjzdvn3pkJjuQf5EfVbr?=
 =?us-ascii?Q?QEenSCvFC7M1VRzL9VqK4rZAxELHe3xS0hOOZOhtKFd+HV8qOujt3C2w85j1?=
 =?us-ascii?Q?modkphKbzE6cBcuYC19wVFHYXUI9WVmKqhAdl3IWLwY1EkmwBL/FfCLS8D/b?=
 =?us-ascii?Q?hKAwBJQiA5YMNgAaH2UIVEi+WP9GAFlh4mLdWIjNDmPkii9hBcu6oQVDkHi1?=
 =?us-ascii?Q?GoqJvJBHEas484xf4MDkEbgAj4BNrtR3jgYEwQMqWwcS9evPfyvY0VBnV7rR?=
 =?us-ascii?Q?jnt63pgW6nI5TTJuc2JIs28tmUNTEAiTx+0G+4mrTpfYqVqjObTTXSETSzIh?=
 =?us-ascii?Q?SLHf4az9R7hyvJFO9LA8BP1HE7j7OwG6FOM4O2hBJVVdOyJCs6x8GRMb3yzq?=
 =?us-ascii?Q?dGQ1whb6kUfB9trmciOAb2oj8f1Sq+GItL+zGbSS5bru4XmDJFWPebfCZyLA?=
 =?us-ascii?Q?T8saoIk/FcxtZuHfiqcaYoYchSugqpGd5RYhx4VGoTU8wV/1h5Hhvbwlylfl?=
 =?us-ascii?Q?BIcg62YxMPpR4rM75oWzs1tteVK2qaO+ru+q8d5zJHLc7vMZVI8vg5VRfTxM?=
 =?us-ascii?Q?WU0lD+jY7841JU5ysfPcAv3G2o/6L/7/pafFQfxVjOvy4WYsds7p1UHPqoG8?=
 =?us-ascii?Q?d3ElMX1QZszUKVqJBjIwqs+5PeAP4IDQQli9mmkezXgFG/e2p3d+prWcrSnA?=
 =?us-ascii?Q?J5HkQZ5p7ZBi1YppM7C20b9ndLTK2+JlAuWk6SOSsk46MDaP/6C+SxPI9Cbc?=
 =?us-ascii?Q?0HFTGvDiEDwPnLshSfpuO7BGy3obGWqEswLVmaG/nh40R+v2FuujtKksqbZJ?=
 =?us-ascii?Q?dP83ENiYB49sXlg5lA7NMs2VWCqcALyLiXAQ4nVkqyF2atLbBxNd4gJu3s2g?=
 =?us-ascii?Q?13rQjKZt+ZmyfTg2Y7C0O1ULpMQsgvTxx8eTELvdRfR7Y+wLawJXJSy7vuMG?=
 =?us-ascii?Q?Sk/14sUiKkJx3lvLVYWt1RrRpdDO/pgNuo4VIpwRIMS42vTew+pNohdgIDtJ?=
 =?us-ascii?Q?4Lmj207RTqsgNXyxDgn8hD0haxEneMnSu9gOUgyE2vPI/u7Dtx6jAZ9daFi0?=
 =?us-ascii?Q?Y9iOfBxMW42xJapXDM34F3raiZlPbsbL10Hqck96lKHsNEJF0VAd6ECNNLtU?=
 =?us-ascii?Q?yRQESDQetW46Xj2anztYpfP42yfLfHwnG2g31SkcjTfRxl2kllZgX6Sb09um?=
 =?us-ascii?Q?I9ooZYkdJ0csXzwvl/Ah2RdNau+WwXPqdmwG0aXbhgof2UsHc5pGsgQ62v2q?=
 =?us-ascii?Q?r6YSdMFPhoiBGYf4LlHOxpYj0z+t44BSw8ZJ/xjQpw2WspFY+OVvyrGY3RXp?=
 =?us-ascii?Q?EBXNfFB9/LAwWNClAsufDebmFSmiCkKTbq4nrVekJabtXViYBjtWhXfnX91+?=
 =?us-ascii?Q?vJRYuJQ3Se2BSqfBt7DA7XS3ttc66NklNE80zvyQRSNKFq/0Yv+jIzWA1sdm?=
 =?us-ascii?Q?ghpkb/9S+T+YadrHN9yakIIdsqm7h4Mcbzo7bUkR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b480f04c-07ed-410b-9bb1-08daccfbc589
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 02:38:16.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJGsF31yTealg6NnVKixbizZDm7BY9IfSJYHVk1phBrD/qJyLQYqnTTVoU/cBKmc6ShpIw9aHkD2BYj2wOyLsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert dmaengine_terminate_all() calls to synchronous and asynchronous
versions where appropriate.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Fix the rebase fail issue based on the latest tty-testing branch.
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c1c8aa3e0fac..5e69fb73f570 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -583,7 +583,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
 				sport->dma_tx_nents, DMA_TO_DEVICE);
 			sport->dma_tx_in_progress = false;
 		}
-		dmaengine_terminate_all(chan);
+		dmaengine_terminate_async(chan);
 	}
 
 	if (lpuart_is_32(sport)) {
@@ -1327,7 +1327,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 					struct lpuart_port, port);
 	struct dma_chan *chan = sport->dma_rx_chan;
 
-	dmaengine_terminate_all(chan);
+	dmaengine_terminate_sync(chan);
 	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 	kfree(sport->rx_ring.buf);
 	sport->rx_ring.tail = 0;
@@ -1757,7 +1757,7 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 		if (wait_event_interruptible_timeout(sport->dma_wait,
 			!sport->dma_tx_in_progress, msecs_to_jiffies(300)) <= 0) {
 			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
+			dmaengine_terminate_sync(sport->dma_tx_chan);
 		}
 		sport->lpuart_dma_tx_use = false;
 	}
@@ -2968,7 +2968,7 @@ static int lpuart_suspend(struct device *dev)
 			}
 			spin_unlock_irqrestore(&sport->port.lock, flags);
 			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
+			dmaengine_terminate_sync(sport->dma_tx_chan);
 		}
 	} else if (pm_runtime_active(sport->port.dev)) {
 		lpuart_disable_clks(sport);
-- 
2.17.1

