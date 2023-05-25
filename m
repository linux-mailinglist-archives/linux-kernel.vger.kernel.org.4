Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B46710907
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbjEYJfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbjEYJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:34:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D0A1B4;
        Thu, 25 May 2023 02:34:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685007270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAVFpLxJcM8gO8l/0bCuwkiWYAOYDDSeRboLXbR9Aek=;
        b=ykmKrFJzIEPB1IJaAecFMnbuPRNqq8W4v0ilizJRs2eB4zd7ETFHwUxbF6Df2nqmYD3Iq+
        fVFjwJfAyXYbyQ05LIMuNPGD+V8a3Qfq+DoyY8wFHmCWzMRxEySwmgevQYbQSAebVZ88wu
        sda0dyy9wmEABP85uFpf+hZ2J1e7hZFZpvTZi6Vacwpz2CIeNzQvnrJDeaJlwwdrf2ERWc
        qT0fokVrR9JnRGf0lWBhxElkKlDcyksM6NBA/+ksbX+eoOEuwM9K7cf8p0ox724pBIn+Ho
        qsqu64ECv7iV41bH5ziiJqXDxAN8+hvvf2wTF8cDXJ/PW6fNBRIYGFAvWGKNHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685007270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAVFpLxJcM8gO8l/0bCuwkiWYAOYDDSeRboLXbR9Aek=;
        b=gCBfiyyGHO59EVDJPrbMzAqqpgW3m+JHu7zU/NjqtshBqw/l5TgEsDdTfEc/lNCqnfW0rW
        3RBdS105E0pyplAw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH tty v1 5/8] serial: 8250: lock port for rx_dma() callback
Date:   Thu, 25 May 2023 11:37:56 +0206
Message-Id: <20230525093159.223817-6-john.ogness@linutronix.de>
In-Reply-To: <20230525093159.223817-1-john.ogness@linutronix.de>
References: <20230525093159.223817-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rx_dma() callback (omap_8250_rx_dma) accesses UART_IER. This
register is modified twice by each console write
(serial8250_console_write()) under the port lock. However, not
all calls to the rx_dma() callback are under the port lock.

Add the missing port locking around rx_dma() callback calls. Add
lockdep notation to the omap_8250_rx_dma().

Note that this is not fixing a real problem because:

1. Currently DMA is forced off for 8250_omap consoles.

2. The serial devices are resumed before console printing is enabled.

However, adding this locking allows for clean locking semantics
for the rx_dma() callback so that lockdep can be used to identify
possible problems in the future. It also simplifies synchronization
of UART_IER in general by not needing to rely on implementation
details such as 1 and 2.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index c17d98161d5e..3cb9cfa62331 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -728,8 +728,11 @@ static int omap_8250_startup(struct uart_port *port)
 		priv->wer |= OMAP_UART_TX_WAKEUP_EN;
 	serial_out(up, UART_OMAP_WER, priv->wer);
 
-	if (up->dma && !(priv->habit & UART_HAS_EFR2))
+	if (up->dma && !(priv->habit & UART_HAS_EFR2)) {
+		spin_lock_irq(&port->lock);
 		up->dma->rx_dma(up);
+		spin_unlock_irq(&port->lock);
+	}
 
 	enable_irq(up->port.irq);
 
@@ -1003,6 +1006,9 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 	unsigned long			flags;
 	u32				reg;
 
+	/* Port locked to synchronize UART_IER access against the console. */
+	lockdep_assert_held_once(&p->port.lock);
+
 	if (priv->rx_dma_broken)
 		return -EINVAL;
 
@@ -1736,8 +1742,11 @@ static int omap8250_runtime_resume(struct device *dev)
 	if (up && omap8250_lost_context(up))
 		omap8250_restore_regs(up);
 
-	if (up && up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2))
+	if (up && up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2)) {
+		spin_lock_irq(&up->port.lock);
 		omap_8250_rx_dma(up);
+		spin_unlock_irq(&up->port.lock);
+	}
 
 	priv->latency = priv->calc_latency;
 	schedule_work(&priv->qos_work);
-- 
2.30.2

