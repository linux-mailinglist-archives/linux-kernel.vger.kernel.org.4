Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF16623D45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiKJITb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiKJIT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:19:29 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20049.outbound.protection.outlook.com [40.107.2.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD7184;
        Thu, 10 Nov 2022 00:19:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNQYQCuQ/DIcpmibweJfnvsuGtudUsUEA5RN5sd3vPSYeeiGMhqaUEAVHDkbmZCtkbwv3fZCJXOpk0xArlRmLb3meDnD2lBL+fVvhqHOkqDvmdPf1adxHWar3SabEINx6hpJ3wLAErYdFhaYQX9X8sGlEhpN8aNucsFaZ01HvtIl6/j+pDnG6J4VkB2oDNi2ou+uCF8RzCQFqpzTB0rl4eta5smx1C/LsRvwV/Ww5mpze2EL/7X04Xyn9vH0HQE+MDp9e7tIsC6GuQCalxdEiSjMfGtPLzAfTRuOU0m9W7n7mqEoHLZoir5TkXF48FLNoiJfKvaDk5NVnQVZovexNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4FQxESk5pKaJX5lvN/J1P5Y3Ce1qRahLhmanTMKkcc=;
 b=drnM7GQlbYQcJPlJT8pL31E1eu28+BzRK1EYfsY53X4zd9bgZDWp/TupvsrQIsTvATW061MaxP6zdZAQL6wBO0C6SsU5amcgKmSJACdqkdmGicyfJgzbn6QImBzWUDz6oJKSIqZkFpZg+jHEy6h468LizJc2+/naCJaC7S6lUu+z3DIjfyznfFRXCn/7SFaMUpsf6z0vRlvpeS+mCqlifqKqxVDCSt3T50IT2WKJuAFzh6dXPXyU/K5hHLG/RTRoxMMr8/H/iExh7PG2HFWYTzSrBpcumdvYuwlqEe+ZfNSTw5Z+Imyni78iTM1JOPwHV0934etE4hFrvpCWaov8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4FQxESk5pKaJX5lvN/J1P5Y3Ce1qRahLhmanTMKkcc=;
 b=iVtolKHtSdOvpE2XTdAg4nAJzQmIYLwTgMg7iUhLgFts2ARr592DrmIE4UVgkYfsYK90ZeAPxGsqEhKEeoWivgyhbTe7XfP/tWDIIJnmUVxMvm5VgLnQh4DWN1DsQ4O10JwtYNn3ATevm2jUCHdrmMdJ9XJy2LdAoq+KghAN3A8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Thu, 10 Nov
 2022 08:19:26 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:19:26 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     michael@walle.cc, jingchang.lu@freescale.com,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 1/5] tty: serial: fsl_lpuart: only enable Idle Line Interrupt for non-dma case
Date:   Thu, 10 Nov 2022 16:17:24 +0800
Message-Id: <20221110081728.10172-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110081728.10172-1-sherry.sun@nxp.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ea8836-57b0-4aa9-b7b6-08dac2f4478a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weO/wPziSfOtd0Km01oxbtNtR3sgWfCGceoHpW/JSFLULi2txgzjfMnnILsE9jZQn/T3BwQgjPonU7D1heN3+6NZwm1OxfYTXZ5oTBr1WMEmqqZUF7OQUixLok23+tqKZkO/rprU2GBFXbUlmlZ/tOtzhyoT4+9nYNTifp00G5dC10GU9WbMrojH6JjJExAJRh9UexWDbYV3YBzLSvqlSKiph1jYulWIDtQWGLWwZuXHyQtGQbzquP2TqxXHoHtSSQdYH+MybCZhNAVP7VWxQh2V3UPrh0aY17Gt6ZNvdubWWp+q2kC8faUkuM/WnQVk/cUkvA74MKbi2qprbsKVjI9/QLFK+784r2rjal39NnfpfNiYYj3K+Z2ph2VAUkEngx7slSvUgkMrc+Fn+Ke+BNLU9Itv/6lB9g1pCezP3jOLAE6qDYoGeer16cQ063ITb+Ol0ZOmscqORECyUXO1RieDh0lJpdC4N8rx0Rf2AgKbV60stniyKVIHnOakxVrzrEwhJm10By3Gl3ga7fB3vpU26Az/SHCuYPO2qhBmPsiBpBvTmQALVBH6R0v4P1Ls6FUhHI0rmI5onyeNZsP08HwTEsekIEcqsN+dNdh+0NnwwSONkqlSLhZDiwVmAHxAnVY02N0pnfqK10AoITHakdcmkSKhQCEQe7w474Zd8A0231Doq4rGq9WbzUwQIs9jXslkUuTPZcqmSiZMu40vAt1Iu+jJ7oxgpX6W/9vHq8RBZaUWTEeRAfZEvTYplwJk7B7tPfrQ3ByY8lrg9AyppA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(6506007)(38100700002)(38350700002)(36756003)(86362001)(26005)(2906002)(478600001)(186003)(41300700001)(6512007)(316002)(66476007)(6486002)(44832011)(66556008)(83380400001)(66946007)(8936002)(2616005)(1076003)(52116002)(8676002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZUQY/HrqE549TQ3wgXR6NEKNQwbBvoPqHS6EUExfFQmJC77vCZt46XZoEY10?=
 =?us-ascii?Q?4+3IT2ib2i3akZEhD8+QUI35/beJgUFO1oqGSF9yFLVAC7ld3IDkMjFvQj0O?=
 =?us-ascii?Q?EKJPANJLxshxx4dEthii5m4uXJKzQN0t8jO0YI35+ofTabXDhMB8w9xoCOWr?=
 =?us-ascii?Q?QaPiP0wbctk0mTBOtGzN6NArzubWs6jsLGr4mJOISecLCuKw/nS1lIYQrl/D?=
 =?us-ascii?Q?JWEehV9FTv6ArrFLO5BtnjBmjGozt376nWx/aB19d+/6pSVqiNpWPoOKJfBa?=
 =?us-ascii?Q?OzFbPLx6/3GWAAc/wwPqg2bgP24dHaSAZbR5Kyriu+zUONQGudA0OIghu34s?=
 =?us-ascii?Q?jEmZOFCEMtfWxKiKmEA1XFc5u3Ll5lCMFWTWPLRxVCHkg3GMN+VFhZs3YKBM?=
 =?us-ascii?Q?tqHtHShpqGNTM2fKcsfVW5qsJCBt1Gg7yxfioegl1nevurSX3IgvvHnB1iSo?=
 =?us-ascii?Q?RDgUrk0PbyiDv4AvJSXUYW/viOPBKSo6tu9ysy3YmXRIB1PYTRFSA+DiI4QP?=
 =?us-ascii?Q?Kn7KygoyYcoSaf5d7T7Ktz5gik2ZT7AyRyl5T3V1OVnnSa40WY5wdAPZJMqA?=
 =?us-ascii?Q?cJATB/vih9OKMAM76RLAW2FMjds+vdVyLfuKBU238Yfe3FQB8tHwpmi4kmhF?=
 =?us-ascii?Q?d8/AnMGga68MMsnhSIJcbSkagrIjjNzt5IF7YCvPo9Du1R79NxXq7mSCFCi/?=
 =?us-ascii?Q?9n4PSKjYQeQfNmU1kDKkh6smWXV88EhS6Rsc+8rszR43Ht3oA7f5BKqO2cdW?=
 =?us-ascii?Q?uj9rGSKQMzBVKbIQDLaTPVJbtyO3AHfxKJgLTunGqpxqjZjiGs7sZXkUiLT8?=
 =?us-ascii?Q?ueYnE+3/1jn5xHe/zi1TtEzdDxFJKPCprHAMOhS+LyWCMZCL36aJpmsqVYki?=
 =?us-ascii?Q?IoRhuyvBif5zPksDKagKiVimtuyDwS02bk0hL+fE5XseWJ2yVaoMpO9Vyuva?=
 =?us-ascii?Q?zjdp8jjXxVzbTwsObgaHiBm6X41qYhRoXwclnJrjbiD5vrslgdXa3qQk4VgG?=
 =?us-ascii?Q?WF2HkRm8sm33GxS75nRf7Jj2N/Xb0hI0MxGVeas1L+h8SNiDpPVCJqgSq/bh?=
 =?us-ascii?Q?QzZWIKZhCxI+vM4+1B5WGVTYPK1y4NTcThRpcch6N8rimtUCMzDRKSX59FuO?=
 =?us-ascii?Q?lydKmgk67ZWlkxvkmycxUBkBsO0nztt8kjBOlvp2/CIelKb927YlcstWvlRT?=
 =?us-ascii?Q?g2d1RXl4fSf/tgMTxZ1w/QJlLDo+7KZrae8CCR8sL4+2XdXFDpXwzkaDjEiM?=
 =?us-ascii?Q?vEt4VQzrBroVHUO+rm6n2mxemQDmToaJmnp7Xh8G3vxKhUtInVcrWuAbAB47?=
 =?us-ascii?Q?TMbiJvQN6jE+UUyvcpyXlmo5eiEvmNV6kAuT2/KahrqyUZD8yVDIUU92hiUA?=
 =?us-ascii?Q?mhSaXjRj9aaklCrsB/5IcsOjNKOYXzxzE7z6dB3ZcnGB6E44OQy8Wj4dvR8W?=
 =?us-ascii?Q?KERJQu2atah2eMuX8CGfHKeuUrX5B/gBcjuGCuYVjALeIvuy2yZQYvzISIuv?=
 =?us-ascii?Q?VWwgkh7cwvwtaV8TCLAoFR3yhRveq1WDj6aFGAPxQIbnjoW+MTz+RlavuUZY?=
 =?us-ascii?Q?tKIaKGvLW0IKSyX/g6ULwBW0oh2W0LeAIhGBHnXA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ea8836-57b0-4aa9-b7b6-08dac2f4478a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:19:25.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmUIDmVCSy6QvaT0qMbDf+/5dEFEo9ZsdEYXB7syAHj06bKZjbj3a0g9oHz+Q3hgyUHYecuuZVoEp1FPvZSA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the lpuart driver, the Idle Line Interrupt Enable now is only needed
for the CPU mode, so enable the UARTCTRL_ILIE at the correct place, and
clear it when shutdown.

Also need to configure the suitable UARTCTRL_IDLECFG, now the value is
0x7, represent 128 idle characters will trigger the Idle Line Interrupt.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Use FIELD_PREP() and GENMASK() for easy access to UARTCTRL_IDLECFG
fields as suggested by Ilpo.
---
 drivers/tty/serial/fsl_lpuart.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bd685491eead..a8f8e535077a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -179,7 +179,7 @@
 #define UARTCTRL_SBK		0x00010000
 #define UARTCTRL_MA1IE		0x00008000
 #define UARTCTRL_MA2IE		0x00004000
-#define UARTCTRL_IDLECFG	0x00000100
+#define UARTCTRL_IDLECFG	GENMASK(10, 8)
 #define UARTCTRL_LOOPS		0x00000080
 #define UARTCTRL_DOZEEN		0x00000040
 #define UARTCTRL_RSRC		0x00000020
@@ -1506,7 +1506,7 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	ctrl_saved = ctrl;
 	ctrl &= ~(UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_TE |
-			UARTCTRL_RIE | UARTCTRL_RE);
+			UARTCTRL_RIE | UARTCTRL_RE | UARTCTRL_ILIE);
 	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 
 	/* enable FIFO mode */
@@ -1530,7 +1530,8 @@ static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
 	lpuart32_setup_watermark(sport);
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE | UARTCTRL_ILIE;
+	temp |= UARTCTRL_RE | UARTCTRL_TE;
+	temp |= FIELD_PREP(UARTCTRL_IDLECFG, 0x7);
 	lpuart32_write(&sport->port, temp, UARTCTRL);
 }
 
@@ -1669,7 +1670,7 @@ static void lpuart32_configure(struct lpuart_port *sport)
 	}
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE;
+		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
 	if (!sport->lpuart_dma_tx_use)
 		temp |= UARTCTRL_TIE;
 	lpuart32_write(&sport->port, temp, UARTCTRL);
@@ -1770,7 +1771,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	/* disable Rx/Tx and interrupts */
 	temp = lpuart32_read(port, UARTCTRL);
-	temp &= ~(UARTCTRL_TE | UARTCTRL_RE |
+	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
 			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
 	lpuart32_write(port, temp, UARTCTRL);
 
-- 
2.17.1

