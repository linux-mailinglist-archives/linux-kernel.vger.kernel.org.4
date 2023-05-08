Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A236FA20F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjEHIVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjEHIUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:20:55 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB4401F4BF;
        Mon,  8 May 2023 01:20:46 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 675FD8111;
        Mon,  8 May 2023 08:20:44 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] serial: 8250: omap: Shut down on remove for console uart
Date:   Mon,  8 May 2023 11:20:14 +0300
Message-Id: <20230508082014.23083-5-tony@atomide.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508082014.23083-1-tony@atomide.com>
References: <20230508082014.23083-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unbinding the console uart, we want to power down the uart hardware
on remove. For the console uart, the normal shutdown path will never get
called as the cons_filp stays open. Let's rearrange the dma related
functions a bit so we can call driver shutdown also on console uart rebind.

Currently we set up->dma on probe, but that causes issues calling
omap_8250_shutdown() on remove. The dma startup will not get called on
the next rebind as we still have up->dma set from probe.

Note that serial8250_release_dma() already checks for dma so we can
remove the check for it in 8205_omap driver.

With these changes we also avoid hogging dma virtual channels for the
unused uarts that may be limited on some devices.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 36 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -679,6 +679,7 @@ static int omap_8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = port->private_data;
+	struct uart_8250_dma *dma = &priv->omap8250_dma;
 	int ret;
 
 	if (priv->wakeirq) {
@@ -697,16 +698,16 @@ static int omap_8250_startup(struct uart_port *port)
 	up->msr_saved_flags = 0;
 
 	/* Disable DMA for console UART */
-	if (uart_console(port))
-		up->dma = NULL;
-
-	if (up->dma) {
+	if (dma->fn && !uart_console(port)) {
+		up->dma = &priv->omap8250_dma;
 		ret = serial8250_request_dma(up);
 		if (ret) {
 			dev_warn_ratelimited(port->dev,
 					     "failed to request DMA\n");
 			up->dma = NULL;
 		}
+	} else {
+		up->dma = NULL;
 	}
 
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
@@ -752,8 +753,8 @@ static void omap_8250_shutdown(struct uart_port *port)
 	disable_irq_nosync(up->port.irq);
 	dev_pm_clear_wake_irq(port->dev);
 
-	if (up->dma)
-		serial8250_release_dma(up);
+	serial8250_release_dma(up);
+	up->dma = NULL;
 
 	/*
 	 * Disable break condition and FIFOs
@@ -1499,24 +1500,24 @@ static int omap8250_probe(struct platform_device *pdev)
 	ret = of_property_count_strings(np, "dma-names");
 	if (ret == 2) {
 		struct omap8250_dma_params *dma_params = NULL;
+		struct uart_8250_dma *dma = &priv->omap8250_dma;
 
-		up.dma = &priv->omap8250_dma;
-		up.dma->fn = the_no_dma_filter_fn;
-		up.dma->tx_dma = omap_8250_tx_dma;
-		up.dma->rx_dma = omap_8250_rx_dma;
+		dma->fn = the_no_dma_filter_fn;
+		dma->tx_dma = omap_8250_tx_dma;
+		dma->rx_dma = omap_8250_rx_dma;
 		if (pdata)
 			dma_params = pdata->dma_params;
 
 		if (dma_params) {
-			up.dma->rx_size = dma_params->rx_size;
-			up.dma->rxconf.src_maxburst = dma_params->rx_trigger;
-			up.dma->txconf.dst_maxburst = dma_params->tx_trigger;
+			dma->rx_size = dma_params->rx_size;
+			dma->rxconf.src_maxburst = dma_params->rx_trigger;
+			dma->txconf.dst_maxburst = dma_params->tx_trigger;
 			priv->rx_trigger = dma_params->rx_trigger;
 			priv->tx_trigger = dma_params->tx_trigger;
 		} else {
-			up.dma->rx_size = RX_TRIGGER;
-			up.dma->rxconf.src_maxburst = RX_TRIGGER;
-			up.dma->txconf.dst_maxburst = TX_TRIGGER;
+			dma->rx_size = RX_TRIGGER;
+			dma->rxconf.src_maxburst = RX_TRIGGER;
+			dma->txconf.dst_maxburst = TX_TRIGGER;
 		}
 	}
 #endif
@@ -1550,12 +1551,15 @@ static int omap8250_probe(struct platform_device *pdev)
 static int omap8250_remove(struct platform_device *pdev)
 {
 	struct omap8250_priv *priv = platform_get_drvdata(pdev);
+	struct uart_8250_port *up;
 	int err;
 
 	err = pm_runtime_resume_and_get(&pdev->dev);
 	if (err)
 		return err;
 
+	up = serial8250_get_port(priv->line);
+	omap_8250_shutdown(&up->port);
 	serial8250_unregister_port(priv->line);
 	priv->line = -ENODEV;
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.40.1
