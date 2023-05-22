Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888A470B36A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEVCzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVCzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:55:52 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7B7C1;
        Sun, 21 May 2023 19:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTPrn2LBgA6YlU8azukXpFaG0VVGmBmnjGmZWP3BPKq9gJogsZU4zeuYOpyqF2i4tSFA6aXkIeRQ5tCaUvzH/CYyVNRhW5vxleg72ghbL8hb1rK82ECxCM6ctkF+HYKfo0iw5IakQcJ+7o7AT8ySTettJNtc1EOMUhJ+eFWQUqbTXaa9/mPE3NnYm44pP/ZQ/kgAcW9pnGbLmWAUoIPJxKidpJMnZli7TzCJLYUtRsRon3kFBco7qqJarRBLQrJFUsHR6CMntaqF3tZu4GgdnPocQCc/eOioZ8NpadXkTGR7QlvAwiJYC0uvFuB2WjVPQeN+DNhfgxuDeAB3l3FiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WynSM98sTJHnCUJAcU8pwa/Da7DgeJQNdTMfOjd/eVc=;
 b=HyhCxBgWiivLSZw9FXidcCLIxMNRR8lDaIkZ/HSs6WhXHymF94VPocUJZUICpJ1AA0EXal6MRId5GLhuGvO2O9VM81quWZUsjC0BvAKN2oL3WhwtVnG+KwDDQPdA1sQ2RNitf9YWQV4mC3y4Le+FLyncg6tmznIRjOQ1IhhgTbCNd8FUVdGxnvYN4ZNuC57eur9t5FZAk+ctoK+akZV33+S3+RxKv0KMi4qFrc7COnGS63r9wMpVQc1CHwwwnl8bWoVGLP7Y8iVVJxQIDTnzTNV6ru1ZZjJtrCSZzbJhgPjqUFeHtwf7iSM405Yy0PNunSnj2+VJRPtUuwRADs5yWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WynSM98sTJHnCUJAcU8pwa/Da7DgeJQNdTMfOjd/eVc=;
 b=Ns1V1+8dIcPaHhxF0E9EALKqyVjSfLQYAOE4obQiaTfIUIe4yHw0XF3WSApxtBL1akcUVqKorp2RZ1jTHsTRsDE5wBvjP83By3m8PWwVkRA8ynF9uXJYgYMf3TTTVVQQAlH4wNyfjg/K6/sDJtSG5ZrJgyolUV6BA7sxe3iFFfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 02:55:47 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:55:47 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shenwei.wang@nxp.com, ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: Check the return value of dmaengine_tx_status
Date:   Mon, 22 May 2023 10:51:11 +0800
Message-Id: <20230522025111.3747-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 2634d9c7-a7c1-4742-e535-08db5a700b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAaoM9q0Or8QXQSKwBCz7+UPfT3USBiV+LmoBjleu6IqLiRtae/UssL3aN0k44ftcZlP9LSBP+vGbHeqY1xIwtKvzBZM1cLS89lbCm9g9sqQAGjOto3b/elSYvCkjRnRy8lpaL07Es8ZVXi7zgXAYCaZPlJ7mEyO31RMmdBy192x4aTZGXFf2HX9JqIBRrQ3gr9NjGaWF+/hTn11QoDXzVxtlXbE4S3RwZHfJRBbUFMnBqX+Fli+TX1n9ALjHk1/9dC0ys6VlZqJVSCUyBFwciI5/RVZA9QTrFPxR2t6F6G1cMxqqK+q5+u3e85r5l2tEcw9bhH+soBDOcSZc3iM+63sI33wXRLqM9YoENG5cpWN963U2EuVzNR00VHAu5Aq81rRu61XArqh4RFKYuiuIbCBoY6Kzf4qWATsVY6XzFLqIdnvEY81LK787hLI8Q5nZPDHuIRFoOQMpKEpUkZTaaZrflso9QyTg8cy1P0jxtV+lebQpMkParJiIxCp7G6hF4OSy7U8aTYU1+GBMtXS77O5rfUJAu2q1kq9wVS3IgwU9WOiic6N8ITRclw9ItRlb9C+sxdoQoAt4hq2zN4TdTEOPThZ420UyQ4y3D82r+zUoa3b3aGIzifFYmUK0H16
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(8936002)(8676002)(5660300002)(44832011)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(86362001)(38100700002)(38350700002)(41300700001)(6666004)(6486002)(52116002)(478600001)(66476007)(66946007)(66556008)(4326008)(316002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQ2tN6MhOqvcode1R/Zn1Xp+08Qc0SWJAo/nsTS5FFOZPYzJOSynamM3G0dj?=
 =?us-ascii?Q?z0Utg+AOZO9YKqBtd8NdnyywyDEyQOqKLO9VBeLZlYPq7N1hOXjvAoVetAwz?=
 =?us-ascii?Q?ycawU9PlCase5yA/x53i1pO926oEV/Tl31zKLWVkAqZOxTphwVOH5uQQi83z?=
 =?us-ascii?Q?SCPDCS+E6fAJslC46TKcy32A+9zcQ43qVx/Wj9CsLeUEHopmyiuWU7IPi75v?=
 =?us-ascii?Q?VHMPOXljDJFUVVNXn3zauc4pJ7CEpTgbgGRgNd1mHncuuWyWz6uQQqBl0sx8?=
 =?us-ascii?Q?jv2WS5d/ADTyelb+0cWpNW5bc9NBBXrjUXldGanPPNChabSy4o6QGqZSNqM+?=
 =?us-ascii?Q?wB1NcCns9cvPiDBKI13sJestRmIEQmV5Yrq55ftpwD4hMFESgNBuP4ntwX4h?=
 =?us-ascii?Q?RTHP5+R6rT7KsLm8QwmcDzKv6EIZaT+L7adUh1McVaPc62ZIvPONtRzuBmyD?=
 =?us-ascii?Q?yHtcos9J4u7c2DEganHOQkTYEBrxr3Me93JaPe+Th7SFeDU4GBdUOQ6s+5K5?=
 =?us-ascii?Q?ZpE5kxmvgJTZpxgeoUx6ukNAJbPAOUeJ9Pv/sDrw59KYaQ79rHpIXwUUzOTb?=
 =?us-ascii?Q?vGaec/DVX346MidJcnNL1r/fvCuxcsqWq7YVLWdNL1tAoYBvFHEOBb1EK7V5?=
 =?us-ascii?Q?EvYUlUESm0awstZ+bW2tZRBxM0AnJ3Z/4e6mi9NEfQLbIVQCRQqSL643Ixpl?=
 =?us-ascii?Q?s299M8IeyvlneqPyD+VYqmwCV3gR+okRFDXZuD8p7xAsJRI70zKBLOtSCin6?=
 =?us-ascii?Q?radZH8Dg3BcyiMazwgAJHysn74Kt5pXGQR19EGbKFgKSQqPf/KKas3pBd/QT?=
 =?us-ascii?Q?IMbCVBjKLXBU4rq5g2RE6lvWSAAGFCxdcpQE0fmwvac9NHYKaPxHKwd9TnBA?=
 =?us-ascii?Q?BAVTkCnQjjAOvuF4MQdyEy7yuR6Otui3N+tMRXxyUewWi4ySGf2tMO/7PBI6?=
 =?us-ascii?Q?MXOER/plgrWLK3vd2R3ZaTfckhxX/DlDrsQejVdQPDV1rWof8YcwXeLgzzZF?=
 =?us-ascii?Q?Y1SfxZqRifyF7T0c/hBLb1WF/JiUFBvJlescgsyAS9mW3XEIuVa5F5X5GokA?=
 =?us-ascii?Q?IlLUsbCFuWEOlflSqfu+nrLDDyoOfOg0kBkydhQPtaLzxw/jhfJyLc+9Eqk3?=
 =?us-ascii?Q?MzEO+kgPYn0wIz0GQzAJ93xN2ePCCj3cxnVnZWVTSOES4Y+rmoncTuzOh6pc?=
 =?us-ascii?Q?onimpIfBi3RqYm5UXvtiu+NW59gdRWaIfVdbJPLpy8Ui3qQhnZqRjN6U7kee?=
 =?us-ascii?Q?jVTICaKdKfXyyOEC47DbePK+Iz4pFvSiZgoTa1fAnkGiDqla4zwDeuAVMHji?=
 =?us-ascii?Q?Jd4R0vfOYgIjaUIV5owJw8KrOmhswEjOEB4/fSNfEM7SDW0zWb1g6hfjwItN?=
 =?us-ascii?Q?57eaE/0RgD0pbGqhVHXVJrmZpkpJQGk0zEWjcZ8tZlCpY+8C+aTrsprZirl3?=
 =?us-ascii?Q?0kv3Yxxn+d6fxPEbRq5usS2vDrXkNmrWbd9ocp0xbiVSuED/8JcYAd4qBpgQ?=
 =?us-ascii?Q?qO6qmMnLT6sLE5kkLYDuPl2qvMpLb3oYdEQDKv3GPlD2VrY062RXRXUnWqdu?=
 =?us-ascii?Q?dTqb0gIBL6e2L7BLA0ccpd1abmCc6Bu7r2vEXulk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2634d9c7-a7c1-4742-e535-08db5a700b07
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 02:55:47.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZUDF44cPUZZUeCFzu7CaZFsJlPLA1C4sWUYVB3m12EadLquL8IqzYalfU1r32xb9846p5aPmSclP6R7E7afzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity reports the Unchecked return value (CHECKED_RETURN) warning:
Calling dmaengine_tx_status without checking return value.

So here add the return value check for dmaengine_tx_status() function to
make coverity happy.

Fixes: cf9aa72d2f91 ("tty: serial: fsl_lpuart: optimize the timer based EOP logic")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 92a3bd0f4158..f2a47a8c5b85 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1286,13 +1286,19 @@ static void lpuart_dma_rx_complete(void *arg)
 static void lpuart_timer_func(struct timer_list *t)
 {
 	struct lpuart_port *sport = from_timer(sport, t, lpuart_timer);
+	enum dma_status dmastat;
 	struct dma_chan *chan = sport->dma_rx_chan;
 	struct circ_buf *ring = &sport->rx_ring;
 	struct dma_tx_state state;
 	unsigned long flags;
 	int count;
 
-	dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
+	dmastat = dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
+	if (dmastat == DMA_ERROR) {
+		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
+		return;
+	}
+
 	ring->head = sport->rx_sgl.length - state.residue;
 	count = CIRC_CNT(ring->head, ring->tail, sport->rx_sgl.length);
 
-- 
2.17.1

