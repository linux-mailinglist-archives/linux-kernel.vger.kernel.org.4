Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A631603FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiJSJiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiJSJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:31:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814323BC5E;
        Wed, 19 Oct 2022 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170871; x=1697706871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ObBwRuWrJK1g3IrqjFMLSUzxYAzEx+HCgNSGf3jLYM=;
  b=UlSQzY64Pp0+6M14RIovJM6PSDpMrmWXA4U84Kz6MPUHRVwIZ4IG5Zts
   AKD+yZpfoqEY9oqfOl8mXEbhXMwne++JOAWgNcknNeAtgjKysjSjQyh5/
   Nfg5aZr8NNEL40GkmMxIMn15n1PW60PqaNm4rNr9IgBiNAK5z5phC5RY+
   670Ud0PnkOPJbuGYb00CvqYaj3cqcCeZXqXe8j+0z89ESvE7TD6XFn2Aw
   e7ZvdvpP5R/WcjeFsqg2pPVcbmzGAkn1CAIR9wRfmDEmVPTaj/0D+Lmin
   hgnkst4fNYZLIotX2EwgkvLxm5UDGvmg95G4vpqMDJY3bFwojA4kuQ2oW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910963"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910963"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:13 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118786"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118786"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 16/44] serial: fsl_lpuart: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:23 +0300
Message-Id: <20221019091151.6692-17-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take advantage of the new uart_xmit_advance() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/fsl_lpuart.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67fa113f77d4..1c9c9f5e3610 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -535,9 +535,7 @@ static void lpuart_dma_tx_complete(void *arg)
 	dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,
 		     DMA_TO_DEVICE);
 
-	xmit->tail = (xmit->tail + sport->dma_tx_bytes) & (UART_XMIT_SIZE - 1);
-
-	sport->port.icount.tx += sport->dma_tx_bytes;
+	uart_xmit_advance(&sport->port, sport->dma_tx_bytes);
 	sport->dma_tx_in_progress = false;
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
@@ -792,8 +790,7 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 	txcnt &= UARTWATER_COUNT_MASK;
 	while (!uart_circ_empty(xmit) && (txcnt < sport->txfifo_size)) {
 		lpuart32_write(&sport->port, xmit->buf[xmit->tail], UARTDATA);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
+		uart_xmit_advance(&sport->port, 1);
 		txcnt = lpuart32_read(&sport->port, UARTWATER);
 		txcnt = txcnt >> UARTWATER_TXCNT_OFF;
 		txcnt &= UARTWATER_COUNT_MASK;
-- 
2.30.2

