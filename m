Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D06AB904
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCFJAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:00:19 -0500
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBD3C14
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:00:17 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202303060900142a43b2a92db8f82103
        for <linux-kernel@vger.kernel.org>;
        Mon, 06 Mar 2023 10:00:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=pIZj8+zdp8ZkWBypoawgPOIV+bNHdnfVxMzVLAvkRvo=;
 b=QHcpR46b0lgdpqR4RkuOwCPQFLP2NDPEfi9rXnCyFKcI4WkkLWSNIEXuOfnjgwMAv0gZFo
 kYEj8z0wAhiZrWzZ5ID38i1YTGC56mZZo5CXAU4GfJII9EwebnaRJGqz6NBmsZ7LQRFC+xwd
 U4795NN0Y3oXLasr8qEQM11ApcotY=;
From:   "A. Sverdlin" <alexander.sverdlin@siemens.com>
To:     linux-serial@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: fsl_lpuart: fix race on RX DMA shutdown
Date:   Mon,  6 Mar 2023 10:00:11 +0100
Message-Id: <20230306090011.80725-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

From time to time DMA completion can come in the middle of DMA shutdown:

<process ctx>:				<IRQ>:
lpuart32_shutdown()
  lpuart_dma_shutdown()
    del_timer_sync()
					lpuart_dma_rx_complete()
					  lpuart_copy_rx_to_tty()
					    mod_timer()
    lpuart_dma_rx_free()

When the timer fires a bit later, sport->dma_rx_desc is NULL:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
pc : lpuart_copy_rx_to_tty+0xcc/0x5bc
lr : lpuart_timer_func+0x1c/0x2c
Call trace:
 lpuart_copy_rx_to_tty
 lpuart_timer_func
 call_timer_fn
 __run_timers.part.0
 run_timer_softirq
 __do_softirq
 __irq_exit_rcu
 irq_exit
 handle_domain_irq
 gic_handle_irq
 call_on_irq_stack
 do_interrupt_handler
 ...

To fix this fold del_timer_sync() into lpuart_dma_rx_free() after
dmaengine_terminate_sync() to make sure timer will not be re-started in
lpuart_copy_rx_to_tty() <= lpuart_dma_rx_complete().

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/tty/serial/fsl_lpuart.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e945f41b93d43..47c267ee22e04 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1354,6 +1354,7 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 	struct dma_chan *chan = sport->dma_rx_chan;
 
 	dmaengine_terminate_sync(chan);
+	del_timer_sync(&sport->lpuart_timer);
 	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
 	kfree(sport->rx_ring.buf);
 	sport->rx_ring.tail = 0;
@@ -1813,7 +1814,6 @@ static int lpuart32_startup(struct uart_port *port)
 static void lpuart_dma_shutdown(struct lpuart_port *sport)
 {
 	if (sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
 		lpuart_dma_rx_free(&sport->port);
 		sport->lpuart_dma_rx_use = false;
 	}
@@ -1973,10 +1973,8 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Since timer function acqures sport->port.lock, need to stop before
 	 * acquring same lock because otherwise del_timer_sync() can deadlock.
 	 */
-	if (old && sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
+	if (old && sport->lpuart_dma_rx_use)
 		lpuart_dma_rx_free(&sport->port);
-	}
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
@@ -2210,10 +2208,8 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Since timer function acqures sport->port.lock, need to stop before
 	 * acquring same lock because otherwise del_timer_sync() can deadlock.
 	 */
-	if (old && sport->lpuart_dma_rx_use) {
-		del_timer_sync(&sport->lpuart_timer);
+	if (old && sport->lpuart_dma_rx_use)
 		lpuart_dma_rx_free(&sport->port);
-	}
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
@@ -3014,7 +3010,6 @@ static int lpuart_suspend(struct device *dev)
 			 * cannot resume as expected, hence gracefully release the
 			 * Rx DMA path before suspend and start Rx DMA path on resume.
 			 */
-			del_timer_sync(&sport->lpuart_timer);
 			lpuart_dma_rx_free(&sport->port);
 
 			/* Disable Rx DMA to use UART port as wakeup source */
-- 
2.34.1

