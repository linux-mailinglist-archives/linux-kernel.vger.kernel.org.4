Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB162D804
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiKQK3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiKQK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:29:00 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC0356EC1;
        Thu, 17 Nov 2022 02:28:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJRHGxItpI0AI9LcEiDCmO6fP3D7m/hpW6O0NgvAe7hMCTeGfcOgXkvYe9dpC7DXhFIcTZQ3EAZCkvnKaRDkPPwNXQfqIIUyWr9nnvTdlgiNBqc7RbIGFYFPart4YAhd6Nrhk7rFTaZ7pLaW+aRUqDhx6ByuEDl2xQm6uEGyXMqAAOPtJP8pPbEF1vpwGGyhBwA+aMcH79bthZww8s6Zy/tWLRnzT+ED/cP+7t/tU8mkZRvL5iBWrqhA8TWiuDGCd4PE6jGqaX/P9E3yrnspm8mw/65O7QC6+5bQhk/EF/eux4YkOu4yU2qZZ5lMpwlHxz5s6QpQbqIxGAOnvHW16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjwkbFumsygnZAYqlm4Zk2v2jDJPsRiULAQqaQw8sRc=;
 b=YT9+GOOoBrlPDXvGqixma5Yq3fky9nZf5/Bd5S4jEpiqw+t/mRaiyEHEMls2BBVMEycrqHFMFadOXvQGdmiJhh8ElhAFClYLNooWITFwpH7jy5e8LPrwbKCcFzCK4IUZbK7z6dbJw6HbRqAvDQMSz94G17nGXNvQMkevMQ4TRTT7AOWNtC1sG3h+pxgtKnSnuhs0TML/8PX+S/gHNLBBhAsb3C9YxN6D/meTqGCv+5OdqFkf5OsAkGvd6GYGs28K41YGniNd5Cm+6R/ER3QllklTSYRWpcqMZJ0GMMKMc9X3LiV2IgtqDaWSvEc5BHyLQmWVUdrn43prv3pfAowtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjwkbFumsygnZAYqlm4Zk2v2jDJPsRiULAQqaQw8sRc=;
 b=NolTH3Vg22wlB4J+y2fJBDUkzMCj8pdrRWL+xKBDn3GKD+bENnfs1y6Jmg88RFUQ8Fx2iTZgmkesFYGPTPr1MMKGrajv42rCDoVLbgF4If1dpz0NQLs9xFrl989Gsjq9VXuD58IlwYk8It14A42641LQ4lvIFW+nBvd1Azf8Uyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 10:28:56 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 10:28:56 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: switch to new dmaengine_terminate_* API
Date:   Thu, 17 Nov 2022 18:27:05 +0800
Message-Id: <20221117102705.13287-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|VE1PR04MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 288fa92e-404e-4139-6152-08dac88687f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3TFjT/MVo00TjeeEmu2O9MafhDKf9AkFo1A5KfKkRupqgN1FV+w+5n1vq/V0wKLh9D2CWxnChxcog5/YgvebUl4XwP+Jdtyv/tatjENJuAd1cPrUKn/vBXw9N7VTuk2cemrsDfWHXAK3zjvAFPGrCHQaP0kNMA2DxbwmqSsn2/x/Y59W3Og2UEyfOaMn/FCyapiD5gfrwtq2hjgLhwSwBWvH+rKYMLGNRZWgdJbRmZdCc7gIA3f/gnfngRhWI8puvmMvy5JWIisGpkR7RjwRCt+A+VQ8099YfvkAmhSX+/wjt7czUvohJvVVj/priQQKkLUIR91HNqyp7P4keQqWJUYr67AElFc7rZMzhnMLQLFS180HSMYInRI8kRjO/0N68Mo4dQ44f+OKsPpRc3aWT0cGJY3lPJfMiMqHEFOPkM8V7WQWwD7Drpc5Uas1zB+TX/4IpxrzAjPQmQS2qlsuCSLKpmuO9LWpgM/n+2s3ciEe4cawdyPD4N/QySxSB23rn54p+49ZTlC6pII2n1Ak8JQY7Gvh3q18TVorLCU+iRRXmaRQDCCH/Prwm4pK9mXQFGoxHgsKopMXkJ++SlL52nu4UgI10ghE3u68DWvODoujs5ltGomQlbcfQPiBNT3xd5UASDTJvG8WB8nl2g2ml2rBRW4KBDeWHA6LowV6qceamFNTKg7zDPzLtHsUVvDhBE/bCQC736Ad1B7TQdnKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(83380400001)(86362001)(38350700002)(38100700002)(8936002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(44832011)(41300700001)(5660300002)(52116002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYAylNLolkTwod3wSzG/XEjYtygisnoki5mZet/WB+sXlIiqiner1On34dOk?=
 =?us-ascii?Q?nYL1hzICeVDgPgGtaSFUjWXcTraFQ8+Kl+TUAcH4Ia5oA/tR9M88en56zRwr?=
 =?us-ascii?Q?ZBcwkZh+UwnJzekhoVeifW6W6NWdXmnpvkSoym0UQWtzYA5/V/YKrJ4oQnR8?=
 =?us-ascii?Q?UReVZkTyHlPjC66gttx0fNnCBHPzGnxznOZBh14fELpVS5UZ6yuw7bM/i5Ph?=
 =?us-ascii?Q?e3cz3LTEVR07hHidpkTD5g0Uycn4oWikv6KMaDl1F9cp/XFVmZkxDNgsYD0z?=
 =?us-ascii?Q?ZEWh1QJ/azl9bjz4ssk0RH0kzVXPUoCLlIzV3YViQGsp4E7XcPTTR4Wl65BR?=
 =?us-ascii?Q?6fgZhzjUfkUEwZR1Dp/INXOCz5ee6IIwwwS1+1HduBMD8ZdW2sESpNU0/JjR?=
 =?us-ascii?Q?JT3wgojY351XF8+eiQHIFBUQLcOXxUvKLpzZbCjsIfHwQGfsGwEgerh5/g8w?=
 =?us-ascii?Q?aP/uAqAaPg3gNDOsCSo93gu61Tm/e/ereXCdab/iJrrsKkLvZkP6J2QH3jJA?=
 =?us-ascii?Q?llt01MVm9zTL3LPhbMAwa4wJFXw41lnE0rx+Q/ZSSuIRnSbELHATGxrfwVih?=
 =?us-ascii?Q?Hv4vtMLw2SPRe0fgiPDFtaSr1wrSlh9AQ3tT0SDLkmGYiTCYjfZeGIDMbd83?=
 =?us-ascii?Q?SM/ce+1vUEZ9Y2z23rPBLTmhaR9m7AU4HanmajQJusxdyObgrdgvUKhOziga?=
 =?us-ascii?Q?JffiAlnOM5hE5uXn5IgGWtJ6KfZ8aGdUT2h86Di2qJIUq9ZFcicrRgCZGK04?=
 =?us-ascii?Q?q8ZbRTTiDm/DzoLj6qJqg8/1cpsWQkmWBAubF/L7FWw06D0K9wXImM9E0E2o?=
 =?us-ascii?Q?FUXtcWlsWQg0IC9NHd4sCvNOqWXBJRiqPq2D/jDLS+piEw7TRIgYqLwJhfOL?=
 =?us-ascii?Q?6xn3M8LFhAnkXjKyTuLb4Ymeh3e/A9w5IsQ9gO8/bBA0oJfdXeEPyLdn56rN?=
 =?us-ascii?Q?1MwSYG0opTL6h9Cdb31c5Bbz3ixYYWv1dzcE2+68vqObITj0CwxlTjLaf1Ve?=
 =?us-ascii?Q?zOE9HyhYROC1gQ0lOp2VfL5Cbb6Lk5CcRb2O3iNngncUW2IX/zfpBK84FOGf?=
 =?us-ascii?Q?T31IB7K6vB5BDpT3RvgaS1E/5/UVv9z5raBJ2rMeqHyeW/9oUVh6xaA8VF0p?=
 =?us-ascii?Q?l1jh8yeVVt9kBd+pdkhH3uwR0QXLXa64hCinHE1lmdgry5X0kwzZLsQerZBN?=
 =?us-ascii?Q?xxfE5GXUw95w22heI1Wng/tcBHHq+P4mXWwx8Y6C9ZFektbxdhvt8TapAlc4?=
 =?us-ascii?Q?YyDavpDahc7gt+io+fnNWaAE+3UeCVzuDrxbsZjLRhmahCQf5km7yl9tlwyr?=
 =?us-ascii?Q?2rg65gGN3qa+YDTxKICtBzZ2/65aUQqIp7AKrgspxeSvOufwBWPeeXjeQIxS?=
 =?us-ascii?Q?MZBgJTRvjXNZYu5TNSEtpzYqCe2Tcpo+XWWZo4kY3agts/JQyGqpUEtwV3gn?=
 =?us-ascii?Q?pqQDgWi0pqPqkVb9I1rmzlb6mMKdGLef3opFOrY7HWATE26F6iWc0sunbdeI?=
 =?us-ascii?Q?Eg5zNBgibYaIRijtqrzfYGq71a3lvblT2/dc5nEVJbYSHudI+jF2K/Uj5GB9?=
 =?us-ascii?Q?X1OBN6PjjFE6yA1eVzkyOds/+jIisHEUp/KyH3ri?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288fa92e-404e-4139-6152-08dac88687f5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 10:28:56.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQaX41dI5GG4lN/2Azd8W16d5DM/5ZBTWhUst3nDg/XiMlsZxQja/L2JlZ66GlYoNv8wpjECD/38o9sYHGcm1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248
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
 drivers/tty/serial/fsl_lpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bd685491eead..07935b4ad59f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -580,7 +580,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
 				sport->dma_tx_nents, DMA_TO_DEVICE);
 			sport->dma_tx_in_progress = false;
 		}
-		dmaengine_terminate_all(chan);
+		dmaengine_terminate_async(chan);
 	}
 
 	if (lpuart_is_32(sport)) {
@@ -1310,7 +1310,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 					struct lpuart_port, port);
 	struct dma_chan *chan = sport->dma_rx_chan;
 
-	dmaengine_terminate_all(chan);
+	dmaengine_terminate_sync(chan);
 	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 	kfree(sport->rx_ring.buf);
 	sport->rx_ring.tail = 0;
@@ -1729,7 +1729,7 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 		if (wait_event_interruptible_timeout(sport->dma_wait,
 			!sport->dma_tx_in_progress, msecs_to_jiffies(300)) <= 0) {
 			sport->dma_tx_in_progress = false;
-			dmaengine_terminate_all(sport->dma_tx_chan);
+			dmaengine_terminate_sync(sport->dma_tx_chan);
 		}
 		sport->lpuart_dma_tx_use = false;
 	}
@@ -2815,7 +2815,7 @@ static int __maybe_unused lpuart_suspend(struct device *dev)
 
 	if (sport->lpuart_dma_tx_use) {
 		sport->dma_tx_in_progress = false;
-		dmaengine_terminate_all(sport->dma_tx_chan);
+		dmaengine_terminate_sync(sport->dma_tx_chan);
 	}
 
 	if (sport->port.suspended && !irq_wake)
-- 
2.17.1

