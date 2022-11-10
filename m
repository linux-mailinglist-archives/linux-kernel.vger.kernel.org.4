Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B80623D47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiKJITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiKJITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:19:40 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20067.outbound.protection.outlook.com [40.107.2.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8E2250A;
        Thu, 10 Nov 2022 00:19:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGb5zzfb54gQDTXVDRWZktmk1YnJvJ5SSFI2dTEJ20e8DP9NiaUm9ophCNl+x8tDlEEOr3oLQ98n7KerYJaegHgPJncn56Javf8eDD9Ybv4DzR9t+4NdrbHb6BayphOLwzuo+cC/GSIZFFC76Hy/rbrqzmMxJyiZ9UlgstTkESd3J9Hs9uY0rLqnzXzbvgIHpWAU9ESrXORFNMTITR6ZLqPATUdIi7VSIq3bFfvQxQ/Z7VRVI2arPFQI6bIU9JfeSQeSlaxWIXS7RZFJFui9kIeGvdLFy31712omwnmu+rBbA2ARVwlKqKvgbCDdlXUxmqlKnAnEOyXi42KZr5hPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTC+t8kYf0GC0OzkqBvmE0A8XCc6Lso/PN9oSUIcjho=;
 b=mo5ErY5Aa19YxuvNWlb/+42VNgEIMm51KMgZSyeBsY4SR4IVEffmTwgibkVfYyzJiV8z2wV6bBZ+IttV+YXzQ6aX9KNNRea1eygdgURoqS+7vKnVK++8cNSiy446cZAhN/u6kzMWS+VgWu7z/Qt0RjTij02g1HXz9KlM+c0YO+KHalxkCI7pGdhKrDcPgQpicAr+p33/Qa1xemceJRmEL1bjesM+J3OAAL3dioPtfHG2SQbslWa3GvEIqMogF0XlKkcvOzFEW3aXtC1y2ys3piNMKtrgaY1Y830WwNc+duamqhVVeEm/kqvbnUzPEmnHf1CvGvS+0GRdHJeSa/R3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTC+t8kYf0GC0OzkqBvmE0A8XCc6Lso/PN9oSUIcjho=;
 b=H0pSQmtbASDTA7yDGA+A9owUyPsCXkRs8ELtsqdrKH31k7eqYEmtsMbQcq+z1KM33q23GAQYiquMeqyksjajnErVBlfIAX9Cw59NTEyZCF5R9tiOLREpgnre2ZSHWZwIJVgAlOsBO5MtIpPPPpmoh2QYZgiZm/kTv1hxQEOLp9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Thu, 10 Nov
 2022 08:19:30 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:19:30 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     michael@walle.cc, jingchang.lu@freescale.com,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 2/5] tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in lpuart32_shutdown()
Date:   Thu, 10 Nov 2022 16:17:25 +0800
Message-Id: <20221110081728.10172-3-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e38b3dd6-c20d-4ebe-90db-08dac2f44a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUVAAbfLKDws/ncQMLRNe6gEGy9HQqhhYczVqWcmlN3O4MQPCykhmA89RTys2rWdqOd6Ar4Ef2/pm1hDU3IhWaIaNVPfvXTqYEt0f0mhaMZ9W5M+Wlu3QPJCrcXikfBiJWedry7lV+iEh56vUtk+Mv6biat+/MA0+mdTWCZYswfRxlQsNtUZNjBjQHlcRRNpyrfngP7a7uvjr1vmRPq35z90JqZ7FslZAyt0OvGUTdzXPysm+TmvBlggWNhfLcMrXJEJlKgj2zYoqsE9iVWuJ6Gqsy701yOxdB4UUVta9qX7aM7SEFKSXx9MTXEyaMyKEvxs6PflyGhtIrkSBFyH8xNfd38GNS7j4rv9iYE9eWzWZkcW2gMPOQ0rHQRxs0jnrnupR0aI9HjSCZR/Ha2T+gZnEmGSu3Q0LdB8AwYqW+DDGgHY+RE9sfwTiXhKI30/uI64v4GELogXiIMbUZiuLF9Qw5PlgX7q1LJpfoJjEyxZE6R95OPWLU0R02yOiDmpj3usNxlB9teEWkHqQ/wcvZb0Zun7XpWEM424S/gcFt88o0JYUfeiWgRQy/P+X+sIWvXV6LfqB4f3MzHTUqPDdQZ22IIXtvnc4S7Bo0UbiPgJVVtKlVPlBwhbxDYScsKCUhdNmNOvVpL/tDNaxeiGQUv4DOCH4QeVdPjpbzvdqE2Jv6NcnTvZb6Sm/rXHSwzMJ/Fsv7NeZ+OQ+qTHEoUzNdOCeV2xB0RTs5mkPmIL1N0A10xJkWSqoA8Z/D+BpY/j9Cwz4WLJ9PQctoVQlBMSag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(6506007)(38100700002)(38350700002)(36756003)(86362001)(26005)(2906002)(478600001)(6666004)(186003)(41300700001)(6512007)(316002)(66476007)(6486002)(44832011)(66556008)(83380400001)(66946007)(8936002)(2616005)(1076003)(52116002)(8676002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8yDWxF3W0+DoATY3hGoMWcyGloDd/28xfuho8AOT1btLeZtKz+9OxlFEfNj?=
 =?us-ascii?Q?a5+mPrDp1Pg31+M8AfXCkkypCOtXnm+oK57DuDNtr5J1fIfA9fh3xoRuPZfY?=
 =?us-ascii?Q?7WsXb/hVWEg69rUCl47/iC7m7B6Mbvb4ABeKgZbOU2bOP/gyNkBFk+5dCaFg?=
 =?us-ascii?Q?E0G7T6s49E47xhPnRZZMO/lyUnMwsRIPLU0VmJLHuL/TwrX2quF24/OWS6Od?=
 =?us-ascii?Q?PQ6TrsPUMaVpKCT2D/vtt0PFXvQvSnSrlJomFhUWD3zT5FCTzRYxfhTwD87C?=
 =?us-ascii?Q?bVCn3zdwbWccQR1lFrGp9JinRmvffecYz57SR7BfDJweFukvg3VtCQ1nJDk7?=
 =?us-ascii?Q?VY90Y4PekSYDj/Kvk6x2L8DoVTIGs+YvRwqH7oTVAuRaUCzLTORToYAxUV4c?=
 =?us-ascii?Q?t6dZHgM73+E6fRGY4u2mt5NmCmYsnWV4F8JU8/mL7dyw9APlxvS//85M00wV?=
 =?us-ascii?Q?+LCaikwhDapmrn8TJ7uu+Ax9jW6KF+NkUqrbzEpey5ybtkpvXxc4Hx+/vOs3?=
 =?us-ascii?Q?ltjyfSAMYZK9myKJnZleB+pxRWXLMSgTlj1i/q05pZzAWs8ril51knwnb2nK?=
 =?us-ascii?Q?ryN1ccEbka9YtlzhPCYlTKfTEW3DsgQ25IYyJQKIFVja/gdRJ8xflpk2kmkj?=
 =?us-ascii?Q?DUuB1ayHyrRMMPO+PinJ+j2ZP7qzHKj08S7SW8HraWjJq5sjHjCjfGPBtGwx?=
 =?us-ascii?Q?8edYlu1p5kdYatqtdHMtFAkJt8tZYhrJWG/BgVlJLuuE4fvul3Ibn2Ftb+zu?=
 =?us-ascii?Q?m2DoiApb3oNEAycV2yUccMU1MZHBeTBO1C5XK4HdcxU5lOQJYE7ndc1jSae6?=
 =?us-ascii?Q?dhiiuVu9yYEj2LXc3+SOtbOd/QM6J8V3tXoynjCrALFddttqbG41SkV8J5Fz?=
 =?us-ascii?Q?lDpAY+v2AYoxA6QY5fqAmQcwU69Jvi3lM2xg/dhwzIXMnAPFmAj8tYGCwrQQ?=
 =?us-ascii?Q?4tZySmIwZIxaN3j4b2klD/ZGTUMLRgTtG87l4Mm9s2yO8GSfObYZKY97Gwst?=
 =?us-ascii?Q?+Wlj6BLYvBi3zdDmr/SWSciRiHzKuPPYCf83eSj3Voio5Vn98gY0J6vPgTPu?=
 =?us-ascii?Q?xDPItmFZQ1X1IhxNqJ07jAx2eB5CwT1dPFLu8VLHgHu68qGP324ShBDXTIyU?=
 =?us-ascii?Q?93VhaKkmrGmkn+wbHMiOFf+V1rCjRYxX9uOlb4Yink3ICQx0sivixEjaYRbU?=
 =?us-ascii?Q?nMge9X/rbbLjSo2TXdG5mzYYKyM8+u6S1XLdWP9ojqtDscDFFyjy55fOvawk?=
 =?us-ascii?Q?68fYHS6xM9coPl2ojvFgIoeHdwJTZU3OCGnI+PW/T/3StaDCz6meGjdt7cW6?=
 =?us-ascii?Q?F/7hTpWnRd5J/FxDDtHfLQeBGjTKS8BHO1RTUvoRckEPDo4HZYNozZ/NVg3M?=
 =?us-ascii?Q?N3xVQVTWdOmVJINRrcwlIHKzjDoogHGnY7ihHtQuPyjZ1VDcDXebNU4ZxWg1?=
 =?us-ascii?Q?lV8mp/j91UQcC7To+IeJpRzuGvIe4c1r1yue3nbQz+Mc+T/NB7JnMsqhqdDl?=
 =?us-ascii?Q?QQL/IgQpwKlW8bOCWTsb6joM1cAF3xDfpJXXXXQxY468Lof6b6WZiqE9ERZW?=
 =?us-ascii?Q?lR/tsfEe9PaIF9xLSSX9rcl/P0no079Y4XlePlvt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38b3dd6-c20d-4ebe-90db-08dac2f44a26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:19:30.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGL3OvEMcd+JPbAoGrgagw4Oil6yG/2+ATLXznxrD5me06rjk6FnhQWS62yHq8WVtd8Ni30Huo71ODqihi72jA==
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

UARTCTRL_LOOPS bit is set in lpuart32_set_mctrl() for loopback mode, but
nowhere clear this bit, it should be cleared when closing the uart port
to avoid the loopback mode been enabled by default when reopening the
uart.

Fixes: 8a0c810d94f0 ("serial: fsl_lpuart: add loopback support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Split one patch into four smaller patches to improve the commit
messages and add Fixes tag as suggested by Ilpo.
---
 drivers/tty/serial/fsl_lpuart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a8f8e535077a..dbf8cccea105 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1772,7 +1772,8 @@ static void lpuart32_shutdown(struct uart_port *port)
 	/* disable Rx/Tx and interrupts */
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
-			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
+			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE |
+			UARTCTRL_LOOPS);
 	lpuart32_write(port, temp, UARTCTRL);
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
2.17.1

