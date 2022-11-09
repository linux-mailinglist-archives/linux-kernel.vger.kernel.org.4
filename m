Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2629622964
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKIK7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKIK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:59:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449ED12D37;
        Wed,  9 Nov 2022 02:59:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCmky8UzJn9nj3lhbYD0NvYnnsFDWa9XZGpjlyWiRKsZ17pmVHDhG9oqAvHoVS+97feFBYuB/cpeMgJTnlg59YZ9Ttcrg5YA074qfLO/JvRP6PIhoOX1wruf8sKNZv5DEZeepa4Sbv2hIn7r/nwilgSlSoeJwetSEnEBpkFznZxOkDZ4V62bJl2lyIFh7h5j4Nf+tFmgAJ7UZWBHw2tdfksvK3bOVqVOiRkQYY783/XYFK2aCoN0cgUWlGIV6pIFXIZPW+oFaafsnI+LhnNE6aCPI3V3ZVa62UyfOULUeH0bYtfqcVkPSG1jfracjUBKLt57s9hQm2AwBuFRt9XYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMDSGotcBQeBHU2yu2fCDuA0Bk0Jtueq0UwuGm4UttU=;
 b=dtdQGsePuOygPdU6lnfV0ePfuOTa7QRLqISOauVw2SnVUB+4cFqlCDFNY7hfcENUwoD+ZHhsUUdzHnto4fNTaR9HE6AN6W640WP2ZWel00xrKPumtApOPh99cxb5RtPE3JETLy0VnGARhi6oRBoQHuIH4k9oqramaB4yVOzpli5rovI9y5FKL0XwkuyowxsBUEV52h198h7ezP+3C/vkibzymMWq/4AbErrYXxMoqEpSXS189OVz3TrpwevuwcPnYnNmSAT5T0Z+o8j05rwFWb1LRoBvg6HPWrW7ACZOFOEm1zviiDTaa+/Zwq1hhOqxmlZC9T3RkaXfzrf1jZGIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMDSGotcBQeBHU2yu2fCDuA0Bk0Jtueq0UwuGm4UttU=;
 b=BFvhwvB2+IdBXAfVqUpbwJIg+N151MODawJahe7XvkxC5XYwI/Uodj7QOX8YU5gRS2gh7D4iZxIFopo4Dt7GNEw3SbBC1a2q55srOYk12Psj2MkCiULrhXyVRRxh+RiOsVhAFPvexSakpDOn7ijAcZfZzQDM5BoaTLxkbU90QsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8515.eurprd04.prod.outlook.com (2603:10a6:20b:342::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 9 Nov
 2022 10:59:04 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 10:59:04 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/2] tty: serial: fsl_lpuart: enable wakeup source for lpuart
Date:   Wed,  9 Nov 2022 18:56:58 +0800
Message-Id: <20221109105659.17381-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109105659.17381-1-sherry.sun@nxp.com>
References: <20221109105659.17381-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf27b2f-7ecb-4107-3129-08dac2416a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvH4PpsP2O9mI+mV0mLRcKwrTSaXyz7Btd7VOPNUV5P4sXhl1Vh3Jv8Orp2T9QHI1evfRtND3doBiSJimfvxzWZsa8T+TzPYzIYNrDqjcPE2+ISeyTXmRclesgBwOtb3HBTzHxajoARC0TwGed0ZsUbTlZMW2hzCurNIq7xBqqK1m83Pa9Ec7KprL4jURnKsxIn8bObRVLqCMdLsCB4PnYWy4blu1dNQCM9Gwjzoic51TEZmnQYiTr9p33v424vLnMAmDLquEDqAbCaSHdKng8ik3WnG45O66NPAYzI6ZoN0QLC4AvfMWqGv/wH99Fmsi0fg4wQ2Wri6xPjdiRVMqBNqw2YTdqQfTNZy5LtVnVtC1pLAIXDImdxotJ3bWDR5jpIJ/j27sGDj64jyAXjzkzlGYoUEgAntsg7TMu65teQI8Lttjfop0yxZIgeFrRaqB0HMiblJUBwog45kfcc5t9SX1BYQCT4HfPLirV7dom7uA++V4tsdK0zm+cXJhzjUGvhU/4hIi/dzMPSWI1GuV9i9sR7cgMZlilKj9zSGJILiyAeLhCSe/iiBdRvwG7Q9fiRtyg71Xt29bsNIKTgEjXFgvvsVvVYGLBLrYr8EGf0onJXCvgVSWqGGO5AnkERDV/OuiDor0iraWqS2qi0+l5FrSAVS27kXWpRfcFwSgEqc4FfO/c2gtFTjbXVwz/Ap/ubxfIkOXfX4girgtvlktaHerwG8RTng0Z0HXQ9Lzw+oGJBIHmLXBMlNBJgZhy/wdDDWFmG2VEGNdTntP2ONTEKMLEH5XLf71WN6EXIFoOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(36756003)(86362001)(44832011)(5660300002)(52116002)(2906002)(30864003)(26005)(6512007)(83380400001)(38350700002)(38100700002)(1076003)(2616005)(6506007)(186003)(66946007)(66556008)(66476007)(316002)(478600001)(41300700001)(4326008)(8936002)(6666004)(6486002)(8676002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yr+ILnSX+Jp/6QZnZn7MO4SKSI03h7FME6KSGZ8OdMe9UlKRdSU4lHpjAfrY?=
 =?us-ascii?Q?jl5dRbuoIQIl8Lw42yJos7tWMfGVTeXEWjmVhaS5rKmods6c1B5hxdLlYlUK?=
 =?us-ascii?Q?LOkD6D4vv2pf7nokh9l/otFgLAO5TpGKiPCQqMZwT1ZTtFFpV5n2nOnWaqe4?=
 =?us-ascii?Q?3Ye1FKOaG5QhJzzQieDN2+gaU7Air1FtpBUFMkvU86P1Xc9w+edicg23SZhL?=
 =?us-ascii?Q?bn4grQ+mAkyi3imGjiJyid0AbrdQtLtI/3tSXiJFu2cAA1G5RpyDKdqn7U5h?=
 =?us-ascii?Q?qteOxsiYAHaLqDb5f1zHsJemDRJXII/x5gLfHtHjb5T97l7//c2x8y+erzGZ?=
 =?us-ascii?Q?itN+9bgYiZdK/yBOs1JPN90vgzTTVZvDLUn3sbug887AYuw8gV2HtRc29wU7?=
 =?us-ascii?Q?1xcKJmsTImX4U4SQWGAguHj9GBV6iG61fSFo/Upwj4QjlTgXTqQ36zoBGS8J?=
 =?us-ascii?Q?lArSJAiUo5kH18aSNsU+eOLqU79on5HBecepfJX6fqyQnlMvKL/eJJ2ervXE?=
 =?us-ascii?Q?RmK7J2ReH8ZbXA9sItBuOyQ08q5Cx2ZMOMTLDcKjcUvINAG8lNtemdy+cuX1?=
 =?us-ascii?Q?Tu1NCmKX8C5imkQWOSSXOmV5KGadlst71BuSyoOKuHswzRO8X6qCHSyYJG/K?=
 =?us-ascii?Q?9YuFxZBm9SBw0cmp8oAKyy/MXsppKyR5nHcdUB3Ow/9u4/ZxmolQPg7d4t/g?=
 =?us-ascii?Q?/FWSFq0Tjk0VcEpNnA5t6JjzRC0H4VdIt6GnAXsFNV7aQ0RkGx4RjkpJr4jJ?=
 =?us-ascii?Q?PhGByNbVLi6vqS5cg7tj5VFuuVo1zjcgcXKQ4NqSNu4YRv0/Wsw9ZJSINg4g?=
 =?us-ascii?Q?1iMaYlPB+wvBJref/k6HT2kIY6++T0+X1C2FJ1ESltYJTb4Mg3EzZIxHAvdf?=
 =?us-ascii?Q?5XkA8EwPmi+2ZoX5Qv6LapzRAmk5018+EQbmKw1dAXj8ef9At0gn+AkWugrp?=
 =?us-ascii?Q?NwWX2p1vjUnfv9O2PyodObHKMRb10XQ0SVex5CxL2Wfy9lUQvsC9hzqzfCY9?=
 =?us-ascii?Q?2war8ULfQQ/2k7W1PXYiB5Og9EE/83r2xO86IAbHobgFG9S2BRJy/du30lFO?=
 =?us-ascii?Q?uff/oz4d4frzjuKf5vfJooHA9mEkr9hPBgoup5E1hCe0dOiTlwAndI8StQaN?=
 =?us-ascii?Q?6npBBtzLK/ZKRUdIhX7daie1K3Py7oDZclFXzLqz+nrZ8MIpmcqlmULUuj1D?=
 =?us-ascii?Q?dBNWLcqOQvGsKyWf3hcSWo+c6NidywZt6OLAcO5JmTkxhWexzusJzHHJZCBJ?=
 =?us-ascii?Q?cT9/0F1yEXjzs+XoEQwS/2ICJh8T/0SVmrozAs75pXYEM/ICdl+Io4la7A6U?=
 =?us-ascii?Q?nbp2W94tyCn6czH5LA9SNRx7LdFJFhDBO+MPft0BVRXiZBw7n6kvbP2h6L14?=
 =?us-ascii?Q?mXp4aH1IyKqcPAESjhk8F/Jf0qo1xuG6bX7Itml1U+3RM1cYE0X/qFvl8wEB?=
 =?us-ascii?Q?1a9zOxTepqZnO1xjBPFcYMRAlJgvfJNo7o/O4Fzdv9iFd28k+AzWpw71Aifc?=
 =?us-ascii?Q?P0KprUqJqVTIioCddZLphOgwZtO4YWZTYb0yiMiuqcn51k8JRT9nbrKa8D4O?=
 =?us-ascii?Q?++4pIIEbm0YIj/8nV4wCYKkjmkDuOd/ub3kQSxcg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf27b2f-7ecb-4107-3129-08dac2416a98
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:59:04.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXKMvIsOA94WqnrEZvAPj7MoCNpEPmaFDHonfAF/0LV2b4CnmIKuc6JMgQs9bk2Jx3FHxBkZSFnUABHBH2mr7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPUART supports both synchronous wakeup and asynchronous wakeup(wakeup
the system when the UART clocks are shut-off), the synchronous wakeup is
configured by UARTCTRL_RIE interrupt, and the asynchronous wakeup is
configured by UARTBAUD_RXEDGIE interrupt.

Add lpuart_uport_is_active() to determine if the uart port needs to get
into the suspend states, also add lpuart_suspend_noirq() and
lpuart_resume_noirq() to enable and disable the wakeup irq bits if the
uart port needs to be set as wakeup source.

When use lpuart with DMA mode, it still needs to switch to the cpu mode
in .suspend() that enable cpu interrupts RIE and RXEDGIE as wakeup
source, after system resume back, needs to setup DMA again, .resume()
will share the HW setup code with .startup(), so abstract the same code
to the api like lpuart32_hw_setup().

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 281 +++++++++++++++++++++++---------
 1 file changed, 200 insertions(+), 81 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 43d9d6a6e94a..474943cb06b2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
@@ -1630,10 +1631,23 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 	sport->lpuart_dma_rx_use = false;
 }
 
+static void lpuart_hw_setup(struct lpuart_port *sport)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	lpuart_setup_watermark_enable(sport);
+
+	lpuart_rx_dma_startup(sport);
+	lpuart_tx_dma_startup(sport);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long flags;
 	unsigned char temp;
 
 	/* determine FIFO size and enable FIFO mode */
@@ -1647,15 +1661,7 @@ static int lpuart_startup(struct uart_port *port)
 					    UARTPFIFO_FIFOSIZE_MASK);
 
 	lpuart_request_dma(sport);
-
-	spin_lock_irqsave(&sport->port.lock, flags);
-
-	lpuart_setup_watermark_enable(sport);
-
-	lpuart_rx_dma_startup(sport);
-	lpuart_tx_dma_startup(sport);
-
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	lpuart_hw_setup(sport);
 
 	return 0;
 }
@@ -1678,10 +1684,25 @@ static void lpuart32_configure(struct lpuart_port *sport)
 	lpuart32_write(&sport->port, temp, UARTCTRL);
 }
 
+static void lpuart32_hw_setup(struct lpuart_port *sport)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	lpuart32_setup_watermark_enable(sport);
+
+	lpuart_rx_dma_startup(sport);
+	lpuart_tx_dma_startup(sport);
+
+	lpuart32_configure(sport);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long flags;
 	unsigned long temp;
 
 	/* determine FIFO size */
@@ -1706,17 +1727,8 @@ static int lpuart32_startup(struct uart_port *port)
 	}
 
 	lpuart_request_dma(sport);
+	lpuart32_hw_setup(sport);
 
-	spin_lock_irqsave(&sport->port.lock, flags);
-
-	lpuart32_setup_watermark_enable(sport);
-
-	lpuart_rx_dma_startup(sport);
-	lpuart_tx_dma_startup(sport);
-
-	lpuart32_configure(sport);
-
-	spin_unlock_irqrestore(&sport->port.lock, flags);
 	return 0;
 }
 
@@ -2780,97 +2792,204 @@ static int lpuart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused lpuart_suspend(struct device *dev)
+static void serial_lpuart_enable_wakeup(struct lpuart_port *sport, bool on)
 {
-	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned long temp;
-	bool irq_wake;
+	unsigned int val, baud;
 
 	if (lpuart_is_32(sport)) {
-		/* disable Rx/Tx and interrupts */
-		temp = lpuart32_read(&sport->port, UARTCTRL);
-		temp &= ~(UARTCTRL_TE | UARTCTRL_TIE | UARTCTRL_TCIE);
-		lpuart32_write(&sport->port, temp, UARTCTRL);
+		val = lpuart32_read(&sport->port, UARTCTRL);
+		baud = lpuart32_read(&sport->port, UARTBAUD);
+		if (on) {
+			/* set rx_watermark to 0 in wakeup source mode */
+			lpuart32_write(&sport->port, 0, UARTWATER);
+			val |= UARTCTRL_RIE;
+			/* clear RXEDGIF flag before enable RXEDGIE interrupt */
+			lpuart32_write(&sport->port, UARTSTAT_RXEDGIF, UARTSTAT);
+			baud |= UARTBAUD_RXEDGIE;
+		} else {
+			val &= ~UARTCTRL_RIE;
+			baud &= ~UARTBAUD_RXEDGIE;
+		}
+		lpuart32_write(&sport->port, val, UARTCTRL);
+		lpuart32_write(&sport->port, baud, UARTBAUD);
 	} else {
-		/* disable Rx/Tx and interrupts */
-		temp = readb(sport->port.membase + UARTCR2);
-		temp &= ~(UARTCR2_TE | UARTCR2_TIE | UARTCR2_TCIE);
-		writeb(temp, sport->port.membase + UARTCR2);
+		val = readb(sport->port.membase + UARTCR2);
+		if (on)
+			val |= UARTCR2_RIE;
+		else
+			val &= ~UARTCR2_RIE;
+		writeb(val, sport->port.membase + UARTCR2);
 	}
+}
 
-	uart_suspend_port(&lpuart_reg, &sport->port);
+static bool lpuart_uport_is_active(struct lpuart_port *sport)
+{
+	struct tty_port *port = &sport->port.state->port;
+	struct tty_struct *tty;
+	struct device *tty_dev;
+	int may_wake = 0;
 
-	/* uart_suspend_port() might set wakeup flag */
-	irq_wake = irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq));
+	tty = tty_port_tty_get(port);
+	if (tty) {
+		tty_dev = tty->dev;
+		may_wake = device_may_wakeup(tty_dev);
+		tty_kref_put(tty);
+	}
 
-	if (sport->lpuart_dma_rx_use) {
-		/*
-		 * EDMA driver during suspend will forcefully release any
-		 * non-idle DMA channels. If port wakeup is enabled or if port
-		 * is console port or 'no_console_suspend' is set the Rx DMA
-		 * cannot resume as expected, hence gracefully release the
-		 * Rx DMA path before suspend and start Rx DMA path on resume.
-		 */
-		if (irq_wake) {
-			del_timer_sync(&sport->lpuart_timer);
-			lpuart_dma_rx_free(&sport->port);
-		}
+	if ((tty_port_initialized(port) && may_wake) ||
+	    (!console_suspend_enabled && uart_console(&sport->port)))
+		return true;
+
+	return false;
+}
+
+static int lpuart_suspend_noirq(struct device *dev)
+{
+	struct lpuart_port *sport = dev_get_drvdata(dev);
+	bool irq_wake = irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq));
+
+	if (lpuart_uport_is_active(sport))
+		serial_lpuart_enable_wakeup(sport, !!irq_wake);
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int lpuart_resume_noirq(struct device *dev)
+{
+	struct lpuart_port *sport = dev_get_drvdata(dev);
+	unsigned int val;
+
+	pinctrl_pm_select_default_state(dev);
+
+	if (lpuart_uport_is_active(sport)) {
+		serial_lpuart_enable_wakeup(sport, false);
 
-		/* Disable Rx DMA to use UART port as wakeup source */
+		/* clear the wakeup flags */
 		if (lpuart_is_32(sport)) {
-			temp = lpuart32_read(&sport->port, UARTBAUD);
-			lpuart32_write(&sport->port, temp & ~UARTBAUD_RDMAE,
-				       UARTBAUD);
-		} else {
-			writeb(readb(sport->port.membase + UARTCR5) &
-			       ~UARTCR5_RDMAS, sport->port.membase + UARTCR5);
+			val = lpuart32_read(&sport->port, UARTSTAT);
+			lpuart32_write(&sport->port, val, UARTSTAT);
 		}
 	}
 
-	if (sport->lpuart_dma_tx_use) {
-		sport->dma_tx_in_progress = false;
-		dmaengine_terminate_all(sport->dma_tx_chan);
-	}
-
-	if (sport->port.suspended && !irq_wake)
-		lpuart_disable_clks(sport);
-
 	return 0;
 }
 
-static int __maybe_unused lpuart_resume(struct device *dev)
+static int __maybe_unused lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	bool irq_wake = irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq));
+	unsigned long temp, flags;
 
-	if (sport->port.suspended && !irq_wake)
-		lpuart_enable_clks(sport);
+	uart_suspend_port(&lpuart_reg, &sport->port);
 
-	if (lpuart_is_32(sport))
-		lpuart32_setup_watermark_enable(sport);
-	else
-		lpuart_setup_watermark_enable(sport);
+	if (lpuart_uport_is_active(sport)) {
+		spin_lock_irqsave(&sport->port.lock, flags);
+		if (lpuart_is_32(sport)) {
+			/* disable Rx/Tx and interrupts */
+			temp = lpuart32_read(&sport->port, UARTCTRL);
+			temp &= ~(UARTCTRL_TE | UARTCTRL_TIE | UARTCTRL_TCIE);
+			lpuart32_write(&sport->port, temp, UARTCTRL);
+		} else {
+			/* disable Rx/Tx and interrupts */
+			temp = readb(sport->port.membase + UARTCR2);
+			temp &= ~(UARTCR2_TE | UARTCR2_TIE | UARTCR2_TCIE);
+			writeb(temp, sport->port.membase + UARTCR2);
+		}
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	if (sport->lpuart_dma_rx_use) {
-		if (irq_wake) {
-			if (!lpuart_start_rx_dma(sport))
-				rx_dma_timer_init(sport);
-			else
-				sport->lpuart_dma_rx_use = false;
+		if (sport->lpuart_dma_rx_use) {
+			/*
+			 * EDMA driver during suspend will forcefully release any
+			 * non-idle DMA channels. If port wakeup is enabled or if port
+			 * is console port or 'no_console_suspend' is set the Rx DMA
+			 * cannot resume as expected, hence gracefully release the
+			 * Rx DMA path before suspend and start Rx DMA path on resume.
+			 */
+			del_timer_sync(&sport->lpuart_timer);
+			lpuart_dma_rx_free(&sport->port);
+
+			/* Disable Rx DMA to use UART port as wakeup source */
+			spin_lock_irqsave(&sport->port.lock, flags);
+			if (lpuart_is_32(sport)) {
+				temp = lpuart32_read(&sport->port, UARTBAUD);
+				lpuart32_write(&sport->port, temp & ~UARTBAUD_RDMAE,
+					       UARTBAUD);
+			} else {
+				writeb(readb(sport->port.membase + UARTCR5) &
+				       ~UARTCR5_RDMAS, sport->port.membase + UARTCR5);
+			}
+			spin_unlock_irqrestore(&sport->port.lock, flags);
+		}
+
+		if (sport->lpuart_dma_tx_use) {
+			spin_lock_irqsave(&sport->port.lock, flags);
+			if (lpuart_is_32(sport)) {
+				temp = lpuart32_read(&sport->port, UARTBAUD);
+				temp &= ~UARTBAUD_TDMAE;
+				lpuart32_write(&sport->port, temp, UARTBAUD);
+			} else {
+				temp = readb(sport->port.membase + UARTCR5);
+				temp &= ~UARTCR5_TDMAS;
+				writeb(temp, sport->port.membase + UARTCR5);
+			}
+			spin_unlock_irqrestore(&sport->port.lock, flags);
+			sport->dma_tx_in_progress = false;
+			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
 	}
 
-	lpuart_tx_dma_startup(sport);
+	return 0;
+}
 
-	if (lpuart_is_32(sport))
-		lpuart32_configure(sport);
+static void lpuart_console_fixup(struct lpuart_port *sport)
+{
+	struct tty_port *port = &sport->port.state->port;
+	struct uart_port *uport = &sport->port;
+	struct ktermios termios;
+
+	/* i.MX7ULP enter VLLS mode that lpuart module power off and registers
+	 * all lost no matter the port is wakeup source.
+	 * For console port, console baud rate setting lost and print messy
+	 * log when enable the console port as wakeup source. To avoid the
+	 * issue happen, user should not enable uart port as wakeup source
+	 * in VLLS mode, or restore console setting here.
+	 */
+	if (is_imx7ulp_lpuart(sport) && lpuart_uport_is_active(sport) &&
+	    console_suspend_enabled && uart_console(&sport->port)) {
+
+		mutex_lock(&port->mutex);
+		memset(&termios, 0, sizeof(struct ktermios));
+		termios.c_cflag = uport->cons->cflag;
+		if (port->tty && termios.c_cflag == 0)
+			termios = port->tty->termios;
+		uport->ops->set_termios(uport, &termios, NULL);
+		mutex_unlock(&port->mutex);
+	}
+}
+
+static int __maybe_unused lpuart_resume(struct device *dev)
+{
+	struct lpuart_port *sport = dev_get_drvdata(dev);
+
+	if (lpuart_uport_is_active(sport)) {
+		if (lpuart_is_32(sport))
+			lpuart32_hw_setup(sport);
+		else
+			lpuart_hw_setup(sport);
+	}
 
+	lpuart_console_fixup(sport);
 	uart_resume_port(&lpuart_reg, &sport->port);
 
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(lpuart_pm_ops, lpuart_suspend, lpuart_resume);
+static const struct dev_pm_ops lpuart_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(lpuart_suspend_noirq,
+				      lpuart_resume_noirq)
+	SET_SYSTEM_SLEEP_PM_OPS(lpuart_suspend, lpuart_resume)
+};
 
 static struct platform_driver lpuart_driver = {
 	.probe		= lpuart_probe,
-- 
2.17.1

