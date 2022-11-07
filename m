Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45FE61F04E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiKGKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiKGKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:21:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433018E36;
        Mon,  7 Nov 2022 02:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667816499; x=1699352499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=86H81jTk5MeGGr4bfjg6h5GLTuAz4tzPfCa+h/HeqSM=;
  b=Ajm/VtNK0dgsKTDcGVG9hGscy3xT2aJKNr13HxjMwp61x8+5qIB4sSjR
   iSxJiE54+joW8RzxSe4MO8x5WoyEJqCSj3+12wWbsd7S/00FstHBsT/6h
   1jb4Gis8b1NLO+Ol4kaVLXrBEt0x1KpMbM1MNHXn22SW0pBrNEk5er0Nn
   PiiSti2212B002jeMsNpkErKOw4kxzGB8bx2vO76GF2Uy7QPA+wA63fKN
   uHnox2Yrvx42yHbc3JEQj59btWttoLzfxpaLyH+nKxYJGw4rcN8psoekc
   +wbtkW7Ymp8nIHQa9R7IQ7BZhtsByP6hH2jFTbdhsmcv9hW4X6O/PPh3y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293724142"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="293724142"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 02:21:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="965100338"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="965100338"
Received: from gschoede-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.46.211])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 02:21:36 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Gilles BULOZ <gilles.buloz@kontron.com>
Subject: [PATCH 1/1] serial: 8250_dma: Rearm DMA Rx if more data is pending
Date:   Mon,  7 Nov 2022 12:21:26 +0200
Message-Id: <20221107102126.56481-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DMA Rx completes, the current behavior is to just exit the DMA
completion handler without future actions. If the transfer is still
on-going, UART will trigger an interrupt and that eventually rearms the
DMA Rx. The extra interrupt round-trip has an inherent latency cost
that increases the risk of FIFO overrun. In such situations, the
latency margin tends to already be less due to FIFO not being empty.

Add check into DMA Rx completion handler to detect if LSR has DR (Data
Ready) still set. DR indicates there will be more characters pending
and DMA Rx can be rearmed right away to handle them.

Cc: Gilles BULOZ <gilles.buloz@kontron.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index b85c82616e8c..37d6af2ec427 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -38,9 +38,8 @@ static void __dma_tx_complete(void *param)
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
 
-static void __dma_rx_complete(void *param)
+static void __dma_rx_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tty_port = &p->port.state->port;
 	struct dma_tx_state	state;
@@ -57,6 +56,20 @@ static void __dma_rx_complete(void *param)
 	tty_flip_buffer_push(tty_port);
 }
 
+static void dma_rx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+	unsigned long flags;
+
+	__dma_rx_complete(p);
+
+	spin_lock_irqsave(&p->port.lock, flags);
+	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
+		p->dma->rx_dma(p);
+	spin_unlock_irqrestore(&p->port.lock, flags);
+}
+
 int serial8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;
@@ -130,7 +143,7 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 		return -EBUSY;
 
 	dma->rx_running = 1;
-	desc->callback = __dma_rx_complete;
+	desc->callback = dma_rx_complete;
 	desc->callback_param = p;
 
 	dma->rx_cookie = dmaengine_submit(desc);
-- 
2.30.2

