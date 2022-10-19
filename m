Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C75603FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiJSJfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiJSJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:29:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E47EC500;
        Wed, 19 Oct 2022 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170794; x=1697706794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTprBOiynTEpT508TKZJXu6vmpZ3D1X3CSumF2lsD10=;
  b=gTzkuGO5vAj2/5Mu8v0Ga4nofIDILpjOheqb95/idfHUkPKuCz3M/PQw
   X8cBPIxiIKj50FV1w1W8wlXwkEtNqPhynEASi2XeljqAsnuExzrH0NtZ0
   qdNwpV45xLYeKHiSwPU4hwuPfeV1HCD7SRJ+3uC5Fm0Qm4/E+7N88NdcN
   uLGkSQ+EReKv91GLEBxMQCfTYfUwA5WTn2XHYgTLxVVRZqRUS0GMI3Fa3
   Iw+OHeaNtIIDDAJ1La7KRsYXe7EKBS6DGo6RIS7466zC/rQM2hER+bLe5
   1wyBB4iMYU9KA13fc523P9uhCa0jQABLl4ofL1lBIvZvKlQ4afHxVeTj9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910821"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910821"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118499"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118499"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/44] serial: pch_uart: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:11 +0300
Message-Id: <20221019091151.6692-5-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/pch_uart.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index c59ce7886579..c76719c0f453 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -738,15 +738,12 @@ static void pch_dma_tx_complete(void *arg)
 {
 	struct eg20t_port *priv = arg;
 	struct uart_port *port = &priv->port;
-	struct circ_buf *xmit = &port->state->xmit;
 	struct scatterlist *sg = priv->sg_tx_p;
 	int i;
 
-	for (i = 0; i < priv->nent; i++, sg++) {
-		xmit->tail += sg_dma_len(sg);
-		port->icount.tx += sg_dma_len(sg);
-	}
-	xmit->tail &= UART_XMIT_SIZE - 1;
+	for (i = 0; i < priv->nent; i++, sg++)
+		uart_xmit_advance(port, sg_dma_len(sg));
+
 	async_tx_ack(priv->desc_tx);
 	dma_unmap_sg(port->dev, sg, priv->orig_nent, DMA_TO_DEVICE);
 	priv->tx_dma_use = 0;
@@ -843,8 +840,7 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 
 	while (!uart_tx_stopped(port) && !uart_circ_empty(xmit) && fifo_size) {
 		iowrite8(xmit->buf[xmit->tail], priv->membase + PCH_UART_THR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 		fifo_size--;
 		tx_empty = 0;
 	}
-- 
2.30.2

