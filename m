Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74E66241FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiKJMKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKJMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:09:54 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F105F57;
        Thu, 10 Nov 2022 04:09:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0G75KE3ecpyYCfxvxeMa93D9criOC4I0EUbyuyeXPMb6lZw7D5L/pVgzRxDYsOR9oBR1kHJGWfEcqlBkRQC2xuE/OYPuhJLENam+i2OVfK32r1W2AQwjPiQ6TmphcvLSjeDo1S/7KPANHM4GVF5RCP23RTqqwCFToGqJY427tgfGb0nBAyXthj+TQy2EnM7vBMju1a4dA9P+bKJhU0eH/S5Icg29asC16/GqOLracrwWhVHagK2wv4LuYId+mM0+rme1SXSYYNcbMujnEHFNiWrHNxSiZyGdp4er02UdPRPGrTiJAs/PUJPQxsYDuiQuKW0bgsaJ3qXlDEXlf3IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIpt47kPPYoxgkCj5/ylsWolAtZd0zZBIjJDtcvg/x8=;
 b=aq9fPXpxjrOr9fnsm7Lauwg3J2mX4zii18BMhmNwUuvcH6nRkP7ycytmHcQgWiEDGILmz5DZFA1b8dTKBqHsJJTi375dn75zi5TXYkcFIzBmDB64HPb2KEytcn6V51rzzog2bzB3caFCpTo7oy++8nGCx2+xNPpWOcDg30kL3BLHXjw/v8mBrl//Wg3+39UxhwDeFxYcoS/HeBkk9v8W1yE1wBmDlkIXE8o6ypJhx5XVFMfhEq5AcSCLNTlz7WNSunSVnpW9a43UV/u0bIAjvTP57RwoxPBywlZvpK81yVXq2/av8WTm/MLPvniNpuO+xO3cvHBcB7Ox2JXwHni0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIpt47kPPYoxgkCj5/ylsWolAtZd0zZBIjJDtcvg/x8=;
 b=NDBHTvY053D26bQ3P3yCnQrA/FAqfu7T5+cBUEwTk54w+uE/sutkOP+uwYWI8pijAPZVnkbJiMHYNCDUYXs62KZS92nke8P/9Hatvu8JJeGP7EvdyA7Xei4ondFWzQiM8ba+cmy0Y2YQBFUIY+2dYTiJiX1LbhkUad4qsCRkSMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 12:09:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 12:09:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 1/3] tty: serial: fsl_lpuart: enable wakeup source for lpuart
Date:   Thu, 10 Nov 2022 19:38:57 +0800
Message-Id: <20221110113859.8485-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110113859.8485-1-sherry.sun@nxp.com>
References: <20221110113859.8485-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc4ec52-c21b-4d89-e556-08dac314773a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkM5/eceH4un1BOQAV12da/kOwodPJsUUuUxhfcY5sy04ydF+9osa6ORSbB2nawdabIjCBfOv/hjbtcD6MVfW8yJ/00mpGnikuxCvWxdusM6TqMveTSF5b6JvP8MxD+e6JmqadgueLcFlDIeb0WeROgW5mpmRRu1JQrugT5PFcwAi2VNLrDb/9VoJoCn2MAtqsDjhEaVBAZvjilAIAXRoMwtq8lJ42DembttyHch2G/vSnqeula1tcLG9+YwJxHwk0AUT/JEqD4UlPvcRxnyXgh/+0EDqItf9Ma2brxeKqhZjRcpHalhOW2D6O2yn7mMaiF45EUCr5LfaGmNtAwPiYiUpNUTROk2fxeXfkorPjKIi6TfT3lcZ4CDKKbHOJA1bMQIVt5kHiQV+dwO3iBY9EHeC4AeY5/FuaEdMA/t+eRVkvw0PAshoDbyNa1Gv2YzGCNebzvCRQmugvxMxX3ep4GV+6VlwpWeF2dwj1cMJSxYXaSyWLVlVUImQx9FlwrjPeCdYhMHyYIQtki9kkjxeVRRTJHWtk2MjDEYSeITM+hodpwXRWXQY6L9bbtSLwHePRxZ3vrYjGzH9suJubIOigRVVRdBmK8D+yXQvKxNa3V5t+FX4HFMqlkQ26BxvFddT/B0z4fElJW0BjgCIwqBggSzMwqdBkvO5CeTyHI6UsF5spv/Zl2XCsi+X+pxDrVknxe/NnpqIrYuZh7U+eE7QUJHpZvXuB/bjNDRx0jY0YNW2KS6+cosn7UfqaEMnVSd82+zUyaNMk3tTXUvEfk6y4aZJhHO5/1GO1truI+3ABc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(38100700002)(38350700002)(6486002)(478600001)(6666004)(8936002)(2616005)(316002)(52116002)(6506007)(66476007)(6512007)(41300700001)(66556008)(66946007)(86362001)(36756003)(26005)(30864003)(83380400001)(44832011)(8676002)(4326008)(186003)(1076003)(2906002)(5660300002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6R/kCmzjMbIvkm+z/D4vUfJfa/Wzogr44U+gxmqK2i4DrSQ+ALgdhThI44D?=
 =?us-ascii?Q?p6t+ZtRE7xQZXib4FW746jmORwqT94/IaDrdiiPIFi53LW3Yp8gtO0v5tKij?=
 =?us-ascii?Q?ygRHtuqAOGRILdCpH0Ev5txZfittFQzEAv+1yo86fzChzOJ7/CjpJg6LNbRj?=
 =?us-ascii?Q?j1JMwkp4CL1JTIyUveev0oAZ+slA847ndCK9DeuzjjdjomJBX+dZE2vAFlPs?=
 =?us-ascii?Q?LtEKeGzBwYFhvenVg79+RwmOLoyAXWakly0/pv+8RoXyGXinW0sujU2QuEHL?=
 =?us-ascii?Q?Di0r7oLJ8rMed+rsNc28iJ+6u7prHSVAKkULIZddvUorkkvgFFpZeREC673Q?=
 =?us-ascii?Q?FrFq29H7VxcgmbYyAdNWKT30ALdw+5CvoG9P83Ou0sSId3M92omqmh+JaUi1?=
 =?us-ascii?Q?R9MjUP1esi0Eto4ORWhjKf760DeBC3aXUIYtPnJnch0F6MiFag5bfV3a5RBp?=
 =?us-ascii?Q?oyYL8gNHyhgPywWmb6WOJI7QuejhbYT1vUCdYpBnq+vdWYKcvapnI49cMgHg?=
 =?us-ascii?Q?3NC9Gj+kEKzhQxFTlYO1i8850CFzpoHAmfMfbvrDaIJTaXIR9xpZ1P3aegcA?=
 =?us-ascii?Q?VfHVZENBHwcJEbrt7uxru/6uRf1hdo+aeegCI/SkTnLbc1XlYAGWPCseuNN1?=
 =?us-ascii?Q?/QPYq8yOA6zB0UUSaDpuhaqqf188aPIWRQYhzDkgnXO/22nXglgG6iRZAyW2?=
 =?us-ascii?Q?FVx+I3uKzDZBDVX/CyAPP5CKElEnyQln39GVG84N8rk/6ZBZTh+Lff441och?=
 =?us-ascii?Q?IpGMBYc0fN8lLY4Qzt7umO7N8aiYxomhYLhWtmQiqYrh2M47P+j40EjZ0PSV?=
 =?us-ascii?Q?KhuvUZvm5sIWzkO8RFwnccsUkYVt7FaZBNntaMoEcbnWLYaeyODJD53DNgAn?=
 =?us-ascii?Q?/TAqDgbG+EGlG5O5FSG7vWxAeJPST9sPSeObdOmNb//uChHsI12ivEZHR4sm?=
 =?us-ascii?Q?xfkwMCgKs31O96vz4VCU7ShqqM1KOZgnHJWP469vQGt+xjNuNPRhKSrX4BBf?=
 =?us-ascii?Q?vM91pX4hD6byeno1swfDLSYfYCM/8JH04Af2q3e24sEtV6f03aen2Q/de5ES?=
 =?us-ascii?Q?I+5qPb2YXnmuwR/4vkC5UjenPWdUgMeEU3nAhF4sxAHA09fAxj1sZMpNqx5d?=
 =?us-ascii?Q?+SlgENvFiV4RgWJZxolHSyxSrmLmhroDVKLECk9IaOd7rQE6rmpoj8lOinXy?=
 =?us-ascii?Q?3Ae99O4efPaWP9zryTTCNiFYUhnI0nUHKb+sxfLdvRWT7pOPBNG6RcGZe/rr?=
 =?us-ascii?Q?rPzm8gVhoOxp6KoiSVRxZXaMRCkXb4dy2+HyeLSAQWn6149qTEt48XChshTo?=
 =?us-ascii?Q?UKBgQ1HMmoYTdBzJCwXU0hOaWddNa2nKodVbsDdCs1h9qbMWzdmSh7fMlhi+?=
 =?us-ascii?Q?zAb/c3zdHJs7CjzzOBP49zI6EK3JQRmzbycOVZQxCdyOhyWaJheUUOd0oYMe?=
 =?us-ascii?Q?wG47geenvG4s/KNXTr7xyo/zvOXpkcutsyQQD6gQFlQbUlTaM3rseKPoupNZ?=
 =?us-ascii?Q?D5wn7QeIfcr9BEIdEqg372dKPazAQT2HhbLdPDOsUf7YA9xnDxpFuSpmE/18?=
 =?us-ascii?Q?644xQ5Y9+97csOwzEKaPNS3MabmjFbAFRATJePfN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc4ec52-c21b-4d89-e556-08dac314773a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 12:09:49.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5LSEdUV81HZAqZOoBaH8yhQsF7Eh6NALB+MCP8ZpBDGpqrCuTR145UHLlshInaaxmzxh2R0druLG4e9vm51uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
No change in V2.
---
 drivers/tty/serial/fsl_lpuart.c | 281 +++++++++++++++++++++++---------
 1 file changed, 200 insertions(+), 81 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ebbc0539c56e..2654d86f52a4 100644
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
@@ -1628,10 +1629,23 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
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
@@ -1645,15 +1659,7 @@ static int lpuart_startup(struct uart_port *port)
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
@@ -1676,10 +1682,25 @@ static void lpuart32_configure(struct lpuart_port *sport)
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
@@ -1704,17 +1725,8 @@ static int lpuart32_startup(struct uart_port *port)
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
 
@@ -2778,97 +2790,204 @@ static int lpuart_remove(struct platform_device *pdev)
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
+static int __maybe_unused lpuart_suspend_noirq(struct device *dev)
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
+static int __maybe_unused lpuart_resume_noirq(struct device *dev)
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

