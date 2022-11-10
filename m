Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1F4623D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiKJIUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiKJITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:19:48 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1482250A;
        Thu, 10 Nov 2022 00:19:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzmJwIfDa27+1xMZFTqpSrGuKvXLE87vCDm7zJQQIQPWg48WH+g8snEQRVc1neUTejlvn/W8VtfmofZx5UQTEbDQ2dJ6KPXUtASZIpzOR+3B3tn57FMMXY/SrLQ6u+Kj2qqsyxg9p3aTWW55uaKC91Xdx+ZgXKOjUuJjKhca3VlnblbACecWweAxLMfIFIEmShnDH4RWOzaW/Hi5hEtEk8Qlt3+jmtLLNX8ABMl45K5rXHBIcIF0Hsx3+0Z4ZLJqNV5eLoNdNZPfn/sDUctCwKRjTJA2apRqvLRjQYoK9P/fmwzQYcrLDyDvLQdU9ND9nL7xTrfk7xHen1EsWGXWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQXL2N906k3sFWdrlevmLB9Q8PfPWCNhkMThpmZaRek=;
 b=YxqvrCTnlhYkY3i2VFkS5gC5JWW1E3eD0zMsWd30YjWKSUXifzibbKOjgUWQgs6gvSLAK7XGZ8OKWMvxX6cFPHxqn9hH42zEgOkdLrPvNbSdYsT12PLiwzELZJyyWztPSle+OUtWI5xCVUA8oPiV+81VNR5vQycSRuUv84GLBGBSQhhvkPT0cvKPYtzpr2Ti9cWrWZ+0mNBaeDcTB54EsLhIKhQGNYzGmc7xirz7JYsQP0wuWnRrtgWDE5xnb7hd/gZ7KHZbZXtv9hOswU/96R2mrB3E1kwR9WAa4zeeIFAOHnZtzYx3txIZTdQswgfDS+aOoOXoJMo57tfm9BuVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQXL2N906k3sFWdrlevmLB9Q8PfPWCNhkMThpmZaRek=;
 b=BEStmd7jGcuBQ0gyZrqYZotvIZuOhd4NoXW/4cNgd9j9NOXf0fAveY0vR1U/7pPpXod+U2lOq0OwRyGA8/wKDl9su70HAZDGP0YeIHxXukkmsmyJ+EyH7XNxPZfL2f5eawRgip3ALf4bVChoZVvUZJnb/42Tn83tWfNSWqgXHz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 08:19:43 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:19:43 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     michael@walle.cc, jingchang.lu@freescale.com,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 5/5] tty: serial: fsl_lpuart: clear LPUART Status Register in lpuart32_shutdown()
Date:   Thu, 10 Nov 2022 16:17:28 +0800
Message-Id: <20221110081728.10172-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110081728.10172-1-sherry.sun@nxp.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1aa27e-ab9e-4fbf-56ce-08dac2f451eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dxaHll0OG0FcEPAj4XUcQHX2Ow3CC8k3kkE1VBQN9owgNljtta7w1bYuIfYROcnTdU5OdJ01o61vsLAdsOM1PuxdMp5RqzIb/7tMBDa7T7U7nsaueQwztmVCWBZeuF6IOj3/S5h5qYtKG9rrCysVKM9s3YJnY77XtFwfwwVctQfV3TvHqqiJJogtsb4y5ElRLDlaRGzQyU0G8HHjup/9Vl9bmeopPenr5yOL6oLbWWp+f1k/cpzFGwtkLWP1DEdjcUQQ0S252CsBxIB/0n00ctuQYmn7mA0ng7RdOq37F0+TJGFlFX0zQSUO9YGf1YDTmSIv98eaXVNxt+ReaHATcK2H1qbtmLIvTXprf8F0lNWvD2qiHgEYYCpZS68+sxxnm79tiYocFTDZ8AXHKUSIdwR3OAe+inYGa3NMH9scxKy21OPJRvuksDZ7ky2yQXXuvenwRl0BTq1Lps9kGTeCDRdTb2ORbt1vCL1DfaNhYxl9lHp+hY1FyFAX+1mbFZ6e1DIE/d3mpyHa+kcmysZgagGhduqigb64/a2Z8NAjaBZH1TYTrckq6fHLXik8ytg6YKh6Jwo0bDJmjNeuRYmAA3JJ9gxVgdxQiaonnohrb24sUI1wbCF8m+JTzPb8kyaNbwGf1iAzj178u7VnHhBNaUveOYM50303VjJDnJkyYrJbsQYWlhtQPTwjnYm3kvrVG18ohEfXtk2uMlSbOYojvSXiLeVkhVTzONw8WQKP7XhwomnDxYXa+yi4J1o8lTIL4xfHF0CLlxi/N+t5E7EUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(66946007)(4326008)(8936002)(66556008)(66476007)(316002)(8676002)(2616005)(86362001)(44832011)(38350700002)(1076003)(38100700002)(5660300002)(6512007)(41300700001)(6666004)(26005)(2906002)(83380400001)(478600001)(6486002)(6506007)(186003)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1g0zNDY6hdxJXBFYIhaDopPkSeN/i4Ch2x2tYstajYw7bLTZmoXQcw6b2Bs+?=
 =?us-ascii?Q?HR+TGpS+DYpwJBVuXNhNljzCzkhFHlUVaHCoBzhaIHqy9taCX6fQhcTYr/NO?=
 =?us-ascii?Q?N+5QM4xjbzsQroPnDlsA1jhzFZypeldIjwekvn05Egyx5f0WgcE47TTMPzwW?=
 =?us-ascii?Q?WZ6GZDQEdVXr5WOk3mJL8bJRmlctaBEjWdMBctg8hwEDbib/bHRmPbxDrYwv?=
 =?us-ascii?Q?1kfRDETrrz1OaFHB+nkzBbtqeVYQ2SQ0yAPZYyodbAV9F0WRJvdfTtBwadtK?=
 =?us-ascii?Q?poV79jIRsFHkYcyrZAAiY4Jr01bUoCkSAYYpYu5rJrxbZy48k4kTGOYTRqRS?=
 =?us-ascii?Q?HKRQEswEECMew/dodC95AxwqAfpetBVCmeKjRvsZ9o6UF21ou7AoIYb93cv9?=
 =?us-ascii?Q?3mE39Kyq9/hasr+L+iyh78aj8BKLOzMJHfynTURwWxro22dKnZ6VVj+swE4Y?=
 =?us-ascii?Q?Aktw74FZqZqoYzHRAY7LX4tmlgT6K+PESli5qEuLnF8dBt1aCtdFRW1jsXrP?=
 =?us-ascii?Q?pGG6Gw+MK+UZJ2QmuFsjgeFA7XYB3TcMIPGCu6VSAQdtnqxfJpLJELQdSXGC?=
 =?us-ascii?Q?iy7SneYBsOE8shWeFpfIm+q8NQ2a2oor3fMB2mpAliTK6eYchR88YTUoV9ht?=
 =?us-ascii?Q?UZx586oLQ+y1wmJVqycIkK7agKcdltHop22SBEmCL2Z6PxYwwpECWmzloh3i?=
 =?us-ascii?Q?eeREz45HGW8fqjMm/x79Rv+U0kk32mWuIi6YflOWEkonTDbVmjR8nI+KnCoU?=
 =?us-ascii?Q?2LFAU0h28jXB0ITPlFBaFGuIyzD9v6CEZ6h4uds8yVUjLxfmD9Scv5rb+Fqb?=
 =?us-ascii?Q?rj9xXrtt8Gnnwz0TqL1BPA7FY8mItC/+xJQgLwBMmmNfidSSnbIcq7tbzv0l?=
 =?us-ascii?Q?B0fvYMd9r0jajuJQnWvzayWStiRynfB+E/aLMIx/QbYwDjRG33cbQzNh/A3O?=
 =?us-ascii?Q?kbpPxSldlN8yW5oDnAAyrBKVizBYuYM9vObHr0zxDRehRSbn8fuuBfM24ED8?=
 =?us-ascii?Q?2amc8Gojv1GnGKGc1GZX5Q0M3RXKhmGFci0vGjuuuhpcixhOZh6XaeNkgfht?=
 =?us-ascii?Q?CbTcoLWfmhG0cfHyeCNpSmG3cxeRE6LDs6q6Y6kinrpWwHNgxhv1bwINlS6B?=
 =?us-ascii?Q?BX3XmzHvN9T9yy3qyqLNu3VOmhtzdlsYvtnCQxIrMiTPjgNDe7qvXW1uOIT2?=
 =?us-ascii?Q?+VTptYNjuY0tDIVFP/tlEM76gOyIdVFIv1MBoqWitTVPUndJe8L/6l9o8CNZ?=
 =?us-ascii?Q?WXnkp/uwqAb0fnTutpcAAM95APjHQjCR4FT/Vtnojm/5Pe5woYyKSwZpuNPv?=
 =?us-ascii?Q?cgpEjSX25EwsiNvzgotF2wpJTrb0FD1zylHcOZcnKtYCuKRpJuphkZeJkGbc?=
 =?us-ascii?Q?zBXSJoSE3/HqnBptGA/8ZdE1Q/aDnn01ZNcCuwX8umoZOdQYlU5QsgIq7lhj?=
 =?us-ascii?Q?fUaG6p/VPWdv4IWTP6btcxByR2wjRuUn3w2QxQpT9J0ialpkecoJvz9sLSxH?=
 =?us-ascii?Q?GnRxR0MBSkDfRU3IWpcJl7pewGfSk3Wx8MZVmN89lODFOk32K0Dd0gQILoXu?=
 =?us-ascii?Q?JM/0jTTpCcUZDZd89SNAqY8XBLvAMY5raMZdCpBl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1aa27e-ab9e-4fbf-56ce-08dac2f451eb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:19:43.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6WS36qGXD4QWjswYPTz3Z3XkJmgIfkITtPxGeYR8a0NwNVGmgOPNPJwgiPeqwaSajZV6wzyWF50JzMIyTTwuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPUART Status Register needs to be cleared when closing the uart
port to get a clean environment when reopening the uart.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Split one patch into four smaller patches to improve the commit
messages and add Fixes tag as suggested by Ilpo.
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c297be11422a..75162c4784dd 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1769,6 +1769,10 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 
+	/* clear statue */
+	temp = lpuart32_read(&sport->port, UARTSTAT);
+	lpuart32_write(&sport->port, temp, UARTSTAT);
+
 	/* disable Rx/Tx DMA */
 	temp = lpuart32_read(port, UARTBAUD);
 	temp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
-- 
2.17.1

