Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998FC638771
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKYKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiKYKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:23:48 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8BE41982;
        Fri, 25 Nov 2022 02:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLUIrryh/E3lGsOmYgR9enOA183AMAtny/jx8FXFQtCBcb+MliQy6m260NYMp8Haq7+OfyBN6LP3/uT3ttNYwVxCdUKoFQSEQ11wykMvI6bK9GuzPVukF7U6fUSS1W4LvdJdlvb/YEdGzQ45dk0+1igbNby69o2t1blcM09If190FMPGmj07eEbExx8Ysul8SYi6w5SoO+hSBhGhTQZsvJAuFkfIEEQRL6sBuJa1jdTgVsAM/eSBaLuA6cfklfxrzCAHINuHN3irHIFJGMOPfaj6juwhsrORsUm+e0EC+q3thIlVTWhiNvzIVMtNh14qw6XpKIUmGrYikuXejYPnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1Z+0ngsC/7Zrmljcq4ywyrRLs4vLXgSr7rQWkCM84g=;
 b=kuRAB6csPzYAqqkxAd8RJG3nAnXFfj82edYi5Oau7fuSdNmJGziwHcK0VpuNsp2bCuc8s3JdPt3La4P1pF8qQJw/dXE9BBo+TEi4V3dy1gXKePuWL+XdxjmkPJ1fMfFF0/m6KMSmf1Px8gQ+ZEPkDt+C1EDwwgfJBY2KOBC49n2g4Q3P0pvPouRGkJUAzqYTacjZhmQj75Z/vMerk1I5LxkxoVWbqv96lfVtyg9bbXd3n+D2/L2H/qW14oQ+JZiRh2u285nsfRBBgH6Fze/sWf6Ma5QpobdHlQvi9JvZ7/wNJol+HTiycZSeXYcVnVTlg49g5q9UMlMmOJsRJefzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1Z+0ngsC/7Zrmljcq4ywyrRLs4vLXgSr7rQWkCM84g=;
 b=UCzFCZ0KEJw1F1NxFZ3nVMAPgX80GVzlYA78CbdlKeFlzdnY1mDkg22UHwLJDrKoxTwxSMq36UguoPPQhFmOPQpy9rhyo1bDDP7+t3Qy8Ht0LTJSzJpVOtY+wEuI5aHLlkjdBHgNUoLM/Pb+SPCbQdZIPf4pukxAXBhlGNNy1EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 10:23:42 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 10:23:36 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, atsushi.nemoto@sord.co.jp,
        tomonori.sakita@sord.co.jp
Subject: [PATCH V3 0/3] fsl_lpuart: improve Idle Line Interrupt and registers handle in .shutdown()
Date:   Fri, 25 Nov 2022 18:19:50 +0800
Message-Id: <20221125101953.18753-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: accf68ea-4de6-4c90-d510-08dacecf1bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/anBq0aFNmd2TzcmovFbhB3nsOnLTQcyfMHnEZMaHt7tCooJsZohi+ne1iNyZ0+enaTdjZZ51nzCC4lotNoERNcea8t43ATpnGpCfQ+lJ3xWOp6G/jBjFvE+nCFUplyVCKTMQu9UhcxNBvQCL+6V+wlsrSd+4YauOzRU5PxG5eTtqFCjYhxXHaHo+xHWMi0C1J85KbK9RFe9vW0eSl9DSSHHXeeNiiaAiKTmjPA46Q9VYxiPm0tBJ/x6c/Xl89MowhY7Vg31W3J/D9tdYB9j1QxaFeI32FbfBZNv56dQVnb269RkbP3tn71qRHDiLsGX3LD7JOGHR12jhTBP08iJFcv0cOi0FN5pnKXoRVzGvRpXDjVq8/rzRvBLceviXTf9nMR3fAkvgIt//JRQTw7ar+/BfKAPVWLYGoGV59qlyMlq+KbSEuM4zuwICkZXxoHg/r2a73rbq4v5iEd5zH+XutV1mfDmwbW+nJmp9bya+SOX9TecyItHocVA9LZMAOHgJvEmByHrID3qjdMTyFfysxsVfGUGusibFI4xbGPnNqFZeAe5vyqHPCr24NMjWrD/eOTl+GUzu4c7LCIucXxNq8fI6CjoLCjK264TP1JjPwKsBpjstTIr7MpdfAI3TD4Zer306JKZlH9oGZBavFTj9UsWrR0rrF/jsTxMoul5HWG60Wb+S3DhvB60Eh1hGNk/zT09movkohadAHflxgupxIJdNM542Ax8fFXiYPXAOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(6666004)(66556008)(36756003)(6506007)(316002)(52116002)(6512007)(66946007)(66476007)(26005)(83380400001)(2906002)(38100700002)(38350700002)(4326008)(186003)(86362001)(41300700001)(1076003)(8676002)(44832011)(2616005)(8936002)(5660300002)(6486002)(4744005)(478600001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4dcBBO8HJeziGSBsStZamUUmqvZRG8Z0yLG2E3avZP2toD7zuUE0h9ho+wp?=
 =?us-ascii?Q?j8lc/MSoMHAmtRUsroVyExjx8Ex562TLwEIG7dTvoMi94CW+TdfB+BDjLv6x?=
 =?us-ascii?Q?kWuxSgUhu8JkI/ipW4M2htU29uwzN4k9hyOo9f4v8Ut4ZqnU+pFHOBzmTYlG?=
 =?us-ascii?Q?r9wLusZoLf6qhwy4xbP+DNG1WfHtVo/ioY+1uJRHPBzlZViOAdLA2oRIe+GW?=
 =?us-ascii?Q?Bg3ByDM7azVzFT0wsvcXZNvD/y7mGM2dightvIpPU0+tn8BnfQTVI7Bg+Qwc?=
 =?us-ascii?Q?Rshi0SAk75JzcHQi+w3GSfZZUm3PDnI2SqDzSS2gqk4xWtB3Svd58GhXtX32?=
 =?us-ascii?Q?ltlk+nxQxdR7JFq1WSk7OOuKokP7bzNbWmvGMNK1u+dlaeVkDlj7nIHo4dpo?=
 =?us-ascii?Q?ntFMVOB1r8FlktQRgrlCDJOdv3ej5anRd3Pwxp2qoh0FxLhK2sr7PBSf/NcR?=
 =?us-ascii?Q?NbiXT3OWtXwhtg3G/iuLjpguf8CLlBm3buUMgWOT/vBAy74J0BacC2f/6xCH?=
 =?us-ascii?Q?hbRuCh2axGmxUGICdlzADwKz1PWAOpIHi3jxkNdIC3z1bHHOwcCeNbbjlaLf?=
 =?us-ascii?Q?OnhnoZJcIoKXCgJalxsqcUpokMrf6wsZ7DGPTzjQ9ckmq1SFc9uNaF13SxTF?=
 =?us-ascii?Q?Xd4ik1PxbRFRqF68Iq5+GE6KweZmsLtv4N+j4T4AcxS4fvI49MYtCFMsyUsa?=
 =?us-ascii?Q?NQrdt72S9bg0553RRVwme0PzDjXbjZ2YBLiD+80jWONrq9Kmd7Q3sFVqPZt7?=
 =?us-ascii?Q?O9diHlv9runFQUNRBV/h3uKOVN/u7PFn1k7qxHBLqLHeYhq2PD+0nKkEOvkm?=
 =?us-ascii?Q?EYL/w5lRu4MUaoZyWBxOenQsZkYizxRbvm2RXwpBLmMbgD/7Pe1VYVxKxsDi?=
 =?us-ascii?Q?9t18+cFkLc5Qp1jDYi0mdOzckoczj1xtxs2TYkd3XGzpc1P86IoCzPR8ELLN?=
 =?us-ascii?Q?aIG1oSqGq5Cq2LgfbzQh+de73WyjevWFJOCS5nLX0Vb/JFwRI/kukkMDFeCn?=
 =?us-ascii?Q?VwYA1RfbfV8KlFQe/jGjwWCj06UVEoFZpe3CfkkTWH/TmjP0mCZR4Ym3gBS9?=
 =?us-ascii?Q?E2pWwdjTPFHIwamTNlVrB9Q7sPwgIhRVLYuqutinUTqhHWayadY/wv2vF6hF?=
 =?us-ascii?Q?vbxIad723JgclUe2gQ8zvR69Tm0vy1CkhpB4YS9cwEo0KZSMvB6z54dNg5bU?=
 =?us-ascii?Q?G3rCBGIHAvf5XnA0uyGNq3c69IFtuOmEK4PNbYZNMDFZHh+lZSeUk1HSbyN7?=
 =?us-ascii?Q?3UYVUetUKApWZ/d8/GjR1QOoaKDaLWkk/OnBoN7gjB0a9EI0Gy3Wt3ZHGb4m?=
 =?us-ascii?Q?m9bBrv+UtNZAm6iRYjUS0sAjImQURhjgfQAN6XVU+kqn4vjI62UfmMiczHHQ?=
 =?us-ascii?Q?2jyRC1IC8ftatUgIrFipMb56zek5ZXErIeJ6S3ERh2kyJt99/za0SsRYqdVY?=
 =?us-ascii?Q?PGWo2xp7OEExBc8tOL/pxdWhOmXxNwagIYBf5AgEWsb+cnT2gsFPmWal9rrJ?=
 =?us-ascii?Q?n0c1anFmOXJ29ncReZ1V6XUUkebVnodR0VPmxyoJln3yOpFzD532aMaaAPnv?=
 =?us-ascii?Q?rGAryhI/r6ilwHQpHII8+E2H4/zkA/at3bEclhQ1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accf68ea-4de6-4c90-d510-08dacecf1bef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 10:23:36.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sElemt6O4OW+mYKRo90WQjwQjS6YEsauShSQrpiEMqQSPU2MvBD6vSPCQ3Ue1rl8AOzeNeZKRYLPyfSwohCrHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
Changes in V3:
1. Add the corresponding head files for GENMASK and FIELD_PREP to
avoid build break.
2. Remove the patch 2 and patch 3 in the original patch set, as the
loopback and RTS/CTS flags may not need to be cleared in .shutdown().
---

The patchset improve the Idle Line Interrupt for lpuart driver, also handle
the registers correctly for lpuart32 when closing the uart port.

Patches have been tested on imx8ulp-evk platform.

Sherry Sun (3):
  tty: serial: fsl_lpuart: only enable Idle Line Interrupt for non-dma
    case
  tty: serial: fsl_lpuart: disable Rx/Tx DMA in lpuart32_shutdown()
  tty: serial: fsl_lpuart: clear LPUART Status Register in
    lpuart32_shutdown()

 drivers/tty/serial/fsl_lpuart.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.17.1

