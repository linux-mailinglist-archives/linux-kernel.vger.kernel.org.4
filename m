Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4066FA20C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjEHIUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjEHIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:20:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49C0E1E98E;
        Mon,  8 May 2023 01:20:41 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 198178111;
        Mon,  8 May 2023 08:20:38 +0000 (UTC)
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
Subject: [PATCH 3/4] serial: 8250: omap: Fix life cycle issues for interrupt handlers
Date:   Mon,  8 May 2023 11:20:13 +0300
Message-Id: <20230508082014.23083-4-tony@atomide.com>
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

We have the struct uart_8250_port instance recycled on device rebind while
the struct omap8250_priv instance is not. For the console uart,
__tty_hangup() does not call tty->ops->hangup() as cons_filp stays open,
and uart shutdown won't get called. This means we have a stale
priv->wakeirq handler around after unbind, and port->irq is not freed on
unbind.

There's no need to claim the interrupts on startup. We can fix this and
simplify the driver a bit by claiming the interrupts in probe, and clearing
them on remove. For the device interrupt, we can use devm_request_irq().

To do this, we change omap8250_irq() to use struct omap8250_priv data
directly so we don't have to wait for the assigned port from
serial8250_register_8250_port().

We must also drop IRQF_SHARED to set IRQ_NOAUTOEN to avoid spurious
interrupts until the port has been registered. There's no need for
IRQF_SHARED for 8250_omap, the serial port interrupt lines are dedicated
lines.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 33 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -623,9 +623,9 @@ static int omap_8250_dma_handle_irq(struct uart_port *port);
 
 static irqreturn_t omap8250_irq(int irq, void *dev_id)
 {
-	struct uart_port *port = dev_id;
-	struct omap8250_priv *priv = port->private_data;
-	struct uart_8250_port *up = up_to_u8250p(port);
+	struct omap8250_priv *priv = dev_id;
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_port *port = &up->port;
 	unsigned int iir, lsr;
 	int ret;
 
@@ -709,11 +709,6 @@ static int omap_8250_startup(struct uart_port *port)
 		}
 	}
 
-	ret = request_irq(port->irq, omap8250_irq, IRQF_SHARED,
-			  dev_name(port->dev), port);
-	if (ret < 0)
-		goto err;
-
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
 
@@ -730,14 +725,11 @@ static int omap_8250_startup(struct uart_port *port)
 	if (up->dma && !(priv->habit & UART_HAS_EFR2))
 		up->dma->rx_dma(up);
 
+	enable_irq(up->port.irq);
+
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 	return 0;
-err:
-	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
-	dev_pm_clear_wake_irq(port->dev);
-	return ret;
 }
 
 static void omap_8250_shutdown(struct uart_port *port)
@@ -757,6 +749,8 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
+	disable_irq_nosync(up->port.irq);
+	dev_pm_clear_wake_irq(port->dev);
 
 	if (up->dma)
 		serial8250_release_dma(up);
@@ -770,8 +764,6 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
-	free_irq(port->irq, port);
-	dev_pm_clear_wake_irq(port->dev);
 }
 
 static void omap_8250_throttle(struct uart_port *port)
@@ -1451,8 +1443,6 @@ static int omap8250_probe(struct platform_device *pdev)
 				 &up.overrun_backoff_time_ms) != 0)
 		up.overrun_backoff_time_ms = 0;
 
-	priv->wakeirq = irq_of_parse_and_map(np, 1);
-
 	pdata = of_device_get_match_data(&pdev->dev);
 	if (pdata)
 		priv->habit |= pdata->habit;
@@ -1530,6 +1520,15 @@ static int omap8250_probe(struct platform_device *pdev)
 		}
 	}
 #endif
+
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(&pdev->dev, irq, omap8250_irq, 0,
+			       dev_name(&pdev->dev), priv);
+	if (ret < 0)
+		return ret;
+
+	priv->wakeirq = irq_of_parse_and_map(np, 1);
+
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
-- 
2.40.1
