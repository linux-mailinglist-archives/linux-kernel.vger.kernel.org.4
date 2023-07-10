Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF7A74C9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGJBkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGJBkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:40:21 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68C185;
        Sun,  9 Jul 2023 18:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiE2LBcQbAWkeizQ4qT7wEoCmT9hzZLG0vREVWKmHR2N0Y/rFVFwqQkuaGhhaCYvA1ctqAZspAmyq9KUv/gfOn5usYNV03wTJeXDialDxpdUjM4KM1LQztRQ10C9Z2IGH+gqSlWaYSc2HOxtfYT8nofi7+ghMi6URiNMBJ0BxxVktoafzAPeJQgyNnGh+OS/E4xT7SrTOvDsCRYqU5IagxpvivEy10+Ns3r6pOPu6raLoaUB0cc3sZWGilRgW6Ycs7/O+CyaarRA0UXO81CBNv1Yv+XP/DxF/a0N7hmdr2+UY6Wyy11+mdBzKDvkk1SyhAozS4VTmx/FPXcMh4cvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qtVdq462+DW7zoeYYTpfwUwlGrEzSaHf9fJowXWRko=;
 b=RqF5LiB8ZzX+2kGzBelsdveHiM4HvbDUDdpUCmKSi0IYCj+LL2A00UxvYEkJ1hd52l6pZ1Qp3JW2WjMUsjc4mIOIHZT60UwI7UdwwffTp/ryzwnFtlEtnFtHdQ1BMBr1YhclAwyNWpo6AeG4HYUtrm7fzGpZFAFJBRziYIdBEOhrpRpaD9yVPLgL3w7Zyg0JTI2vreC622WudAJmpzwuXA0u/F+4zwtAj+rhSA2vAc+1NJYte6WIDjcSqcTEeonPdUBtk79axXOdz69akdoHo0pk5mj6aIx8NA/QfjE5ITGs0eVKKFTf5IUv1IWC3m6q2UOxjvSe/tU8EEyrFb/gFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qtVdq462+DW7zoeYYTpfwUwlGrEzSaHf9fJowXWRko=;
 b=W8u/qdyWbpkLSlbgL9FWcOtUa6A0aeItZg9VgkfibZWBoFxRRNQ5RzUQp7NA5sJx7+Td42lsd/hYnoX3uqTYseBdKzEuRks8gFFYdcFhfBsVLTqQKqeP1sKFMw2N/iSO2t9mjpvo8ZcIPGyEG+dELNS8l9GM+hOASqoCl82XztU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8117.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 01:40:11 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1e0a:1ed2:2e4c:6b6b]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1e0a:1ed2:2e4c:6b6b%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 01:40:11 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: add IDLE interrupt support for rx_dma on imx7ulp/imx8ulp/imx8qxp
Date:   Mon, 10 Jul 2023 09:38:57 +0800
Message-Id: <20230710013857.7396-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230710013857.7396-1-sherry.sun@nxp.com>
References: <20230710013857.7396-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0cfab2-6d7e-46f3-8bd0-08db80e699e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xl+nYG4frOtY8lMZuRJSsXgEwF/+3TmDODrxVyJ7peVNdAEkKEI0dfv6ULPr9loDqQwqTTaqhywEmpJ69QEgfomLu9mOg5eKuxaHPlvcNvApoWPSkOivsj8iKFtBHU1wi+D7t22cfy5CFslMYerrZaMyxKkWmQaQdHobpj893hHMf3jB007y8MRgsXoKqtDatOfLwv50j7DsKh3+EEXbSf8R7b7ymtqdcquzyDPTaA+0a8/bTq+LzCM0A3A2jQzmo+le7y/fz9v5N5Fd5CuijaGqFkYoXcg9zMFOgxGKMNMoeayfyMpEjoQr988WTCMzJbHjW5NqJj9nA+M/ZTot08a/IXObuH/iIsVODt8KVlJS2K4V98E18JHp/WUyCucRzNAt9UdknNlSjF0bGScvgrayhOFHrnsz1lEsiCV3dWis5lMd7sG3vQu39Rqm7DvEHmqZq7F60F4/rSDd84yQzOXiYvCf+cdeQngEYcoZHP9BiB0N1/eKYbVF2NEf9Xdlah4H1TYCS4FEIIMfV/d3qo4ZecrNFWfVHL1y/KSot/gCa1vs0+FJOTZWmTid19RnAOaP1rVDtvGAtfQCc4Wzo822L/vPC7N9kzNqkz+K1G9+uVNio3vOByxVybImjRlH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(52116002)(6486002)(478600001)(6666004)(2616005)(83380400001)(36756003)(86362001)(2906002)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(38350700002)(38100700002)(66556008)(66476007)(4326008)(41300700001)(316002)(8676002)(8936002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmP545nnoSAUwmVUh3E7t6SmWnvCZeUSYj7Kd616xBRNA1Cj51o5lDfyvRub?=
 =?us-ascii?Q?Peku5i985UOzkqIC3yM8zTH1IO63VE2HH83gmer1HfDGCRwrbK4cUjPI3yxf?=
 =?us-ascii?Q?dfPgn81MDhubqxQ0fNu2+M+YuE7XCwi/ek2ICqzW5eF8cOWXInNLNBQz/UJ2?=
 =?us-ascii?Q?AYhZD1BP19b56cAFJZQbsqTTl3NpNPZqcjFaH9FUy32EjsgFza9ThybEQuAc?=
 =?us-ascii?Q?rE8XPh19oA6geJkXXqyVso6ORi+quqc6Nxw5xY1uWuPCkO/68GBLTgRNEZ2K?=
 =?us-ascii?Q?SyNxhLAA5W27DPfhe5/tijvPGGKk4pWHxMMR18RVa+Gs1C6GH7ZGHUzaCHJA?=
 =?us-ascii?Q?AfPdmA78ji/JtaRlgixCiRkVy5N1zURoCQk+jC3QCmtYaLSqCV4BMGnidf2X?=
 =?us-ascii?Q?SyM2xecwGcIEtuI+GCwQvMsCCxRW/EAfkYpGXTmz3JeaigPyULqHnZlTh75f?=
 =?us-ascii?Q?1LPeSo2GMNW6hSzAinlD8viAWLlzKm12ldbDoSltSSxi6+N5bI6SuVIkeEtO?=
 =?us-ascii?Q?d0ELloWVJUJcniXfU3xEpQRZQE82hV8iHeKZFJWg/sicUAdtj8zvxIv+ROHp?=
 =?us-ascii?Q?eyM83OubXJR6wdUSnVRiR/JeBHn0S8bqoitl0PII6r6ZtoF+pOf+ypDX6+Qm?=
 =?us-ascii?Q?Fo6WgWPQFHq5yfUpnu0sHZ9DiYe09NJuOeUyVJB/itwdFYsoCiCg56OsTvzV?=
 =?us-ascii?Q?CqqZSUDfd8ZruXi4RzRxbcFHdQ6ijUxXTt9+dp341rCSRtx4naqygXSuSYgE?=
 =?us-ascii?Q?CM9zhOs4whLABvMBRs7TyXJQYj+xmEiqE7nVaPChkUOOYrOvrkbylCoXo+S9?=
 =?us-ascii?Q?5j6V35CxAkfOOOdKKvwImaOyWX/gY/sOMHj9mkYrwPwyNfZQJnFJaa4ogoPX?=
 =?us-ascii?Q?HfeU3aogBr2phzGXjhttA11Ah7pfKDmuSf3tjsBZ/+uu50lj4gN22hi9Zonn?=
 =?us-ascii?Q?aeF5tpTha7e0EqR/Pe/yvWi49dX1N0BcNmzY6VnjlOH/mSTGiYdx0ME++BLW?=
 =?us-ascii?Q?aMA0lDrnDtEeEHNN2yx4U8+W7Ge5X0do+KmFJCylGrHCl8SXO7WAOU1sYrQp?=
 =?us-ascii?Q?xrRLXJHYO4/ZdrBRDQ2t2FEZLQB7+gsn4X/la1rWd79WxUcM5aH0Czryz7fM?=
 =?us-ascii?Q?CV+Qnpeg63rJHyZm2nvivb31ni7AJk25zotoCKdUUqZXbDrdVW+3fGVf6p6x?=
 =?us-ascii?Q?fXrRwbtINYWkgj0jULuBbsdX7VkeQoFayW8kOBfGASmmJqbj3p4HPOcE3Gmx?=
 =?us-ascii?Q?WqhJLjIPJYums7rp3iffR0JacpNCL0yBNuCNGvR6W2EB9Ibj47Ffi3y17SpT?=
 =?us-ascii?Q?9Z3CH2f9OE+n8JkqLZLPHjQ2H6+Tf71ThyfFIOj27ende/skVxrFAbhSH+X6?=
 =?us-ascii?Q?jfz40FLHXwAy0Elaz8mRt1HKn4d/Pq+O4GiDizaEB2jOvsA3Z7h+jkGN+Nf1?=
 =?us-ascii?Q?bi7PGoSow/Nyp+knVpLPSJ8IcwQ1cmkS2C1EpzQu5PPYqxcqon6bDtEKrIte?=
 =?us-ascii?Q?xQzsBGAmeUvwAEs5Y9It2KRKW30qn7jBQ0T15XpvP0dhGDr/zvvGvl3SXBIy?=
 =?us-ascii?Q?ZL5hmJFpP3rvlHjytXacrQHXu0n4mKdAywfezN2b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0cfab2-6d7e-46f3-8bd0-08db80e699e1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 01:40:11.8048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4d8LoVGWJn1saPWeiDcTihhSN18YjQGLH8q2KiyY0M9RGRyIJvP776F0fEJ3dqKkxCFaFthRi3mwemEyfmmv9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IDLE interrupt support for receive dma on imx7ulp/imx8ulp/imx8qxp
platforms to replace the receive dma timer function, because the receive
dma timer has bigger latency than idle interrupt triggering, which may
cause the Bluetooth Firmware download timeout on Android platform(it
has a limited FW download time window).

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 44 +++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 653cf8eb5a72..c1980ea52666 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -290,6 +290,7 @@ struct lpuart_port {
 	wait_queue_head_t	dma_wait;
 	bool			is_cs7; /* Set to true when character size is 7 */
 					/* and the parity is enabled		*/
+	bool			dma_idle_int;
 };
 
 struct lpuart_soc_data {
@@ -1248,7 +1249,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	tty_flip_buffer_push(port);
-	mod_timer(&sport->lpuart_timer, jiffies + sport->dma_rx_timeout);
+	if (!sport->dma_idle_int)
+		mod_timer(&sport->lpuart_timer, jiffies + sport->dma_rx_timeout);
 }
 
 static void lpuart_dma_rx_complete(void *arg)
@@ -1258,6 +1260,28 @@ static void lpuart_dma_rx_complete(void *arg)
 	lpuart_copy_rx_to_tty(sport);
 }
 
+static void lpuart32_dma_idleint(struct lpuart_port *sport)
+{
+	enum dma_status dmastat;
+	struct dma_chan *chan = sport->dma_rx_chan;
+	struct circ_buf *ring = &sport->rx_ring;
+	struct dma_tx_state state;
+	int count = 0;
+
+	dmastat = dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
+	if (dmastat == DMA_ERROR) {
+		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
+		return;
+	}
+
+	ring->head = sport->rx_sgl.length - state.residue;
+	count = CIRC_CNT(ring->head, ring->tail, sport->rx_sgl.length);
+
+	/* Check if new data received before copying */
+	if (count)
+		lpuart_copy_rx_to_tty(sport);
+}
+
 static irqreturn_t lpuart32_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
@@ -1273,6 +1297,9 @@ static irqreturn_t lpuart32_int(int irq, void *dev_id)
 	if ((sts & UARTSTAT_TDRE) && !sport->lpuart_dma_tx_use)
 		lpuart32_txint(sport);
 
+	if ((sts & UARTSTAT_IDLE) && sport->lpuart_dma_rx_use && sport->dma_idle_int)
+		lpuart32_dma_idleint(sport);
+
 	lpuart32_write(&sport->port, sts, UARTSTAT);
 	return IRQ_HANDLED;
 }
@@ -1394,6 +1421,12 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 		unsigned long temp = lpuart32_read(&sport->port, UARTBAUD);
 
 		lpuart32_write(&sport->port, temp | UARTBAUD_RDMAE, UARTBAUD);
+
+		if (sport->dma_idle_int) {
+			unsigned long ctrl = lpuart32_read(&sport->port, UARTCTRL);
+
+			lpuart32_write(&sport->port, ctrl | UARTCTRL_ILIE, UARTCTRL);
+		}
 	} else {
 		writeb(readb(sport->port.membase + UARTCR5) | UARTCR5_RDMAS,
 		       sport->port.membase + UARTCR5);
@@ -1409,7 +1442,9 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 	struct dma_chan *chan = sport->dma_rx_chan;
 
 	dmaengine_terminate_sync(chan);
-	del_timer_sync(&sport->lpuart_timer);
+	if (!sport->dma_idle_int)
+		del_timer_sync(&sport->lpuart_timer);
+
 	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 	kfree(sport->rx_ring.buf);
 	sport->rx_ring.tail = 0;
@@ -1671,6 +1706,9 @@ static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
 
 static void rx_dma_timer_init(struct lpuart_port *sport)
 {
+	if (sport->dma_idle_int)
+		return;
+
 	timer_setup(&sport->lpuart_timer, lpuart_timer_func, 0);
 	sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
 	add_timer(&sport->lpuart_timer);
@@ -2833,6 +2871,8 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
 	sport->rx_watermark = sdata->rx_watermark;
+	sport->dma_idle_int = is_imx7ulp_lpuart(sport) || is_imx8ulp_lpuart(sport) ||
+			      is_imx8qxp_lpuart(sport);
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		return ret;
-- 
2.17.1

