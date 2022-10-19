Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A05603FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiJSJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiJSJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:34:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBAA30F46;
        Wed, 19 Oct 2022 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170900; x=1697706900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QeLyseBRR5vdFFcCj6zBy2vHybO02Bt4+xdUVAJfGkQ=;
  b=HK5TFBUKP3lNhNuh+LumMk4iZgWVQmDiBCxdVvK+aKZLfCZoY6YK15UX
   6jkjKk50KFhGwVtWyGFwF4y6GGw1gVC7DYPMW+Xdx3iPGRtBQEDIDche0
   6Q2f7EY16hgRgvkoGgeSFa6HIAEr8CiLlPRkDDuCVJungAvqbpz/UZXd2
   PlhufR4gjatnnvO+uBehdhRagzlssIvK6sMCsc8hYHoWyKOEJEN7ZQ2GH
   3YXlN//jFFEJ6bl0lXFO1DZoLojVk68HOB/P0c140CPfXwgT5eKmtF1j4
   PWKQORS2fe/UBuOmjBXENHB59YhWBpIuKZQGNs/e2GCuMWwXtQZF9Tdr6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332911216"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332911216"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119081"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119081"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 28/44] serial: samsung_tty: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:35 +0300
Message-Id: <20221019091151.6692-29-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/samsung_tty.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 77d1363029f5..7e34361a1085 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -288,7 +288,6 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	struct s3c24xx_uart_dma *dma = ourport->dma;
-	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_tx_state state;
 	int count;
 
@@ -316,8 +315,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 					DMA_TO_DEVICE);
 		async_tx_ack(dma->tx_desc);
 		count = dma->tx_bytes_requested - state.residue;
-		xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
-		port->icount.tx += count;
+		uart_xmit_advance(port, count);
 	}
 
 	ourport->tx_enabled = 0;
@@ -351,8 +349,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
-	port->icount.tx += count;
+	uart_xmit_advance(port, count);
 	ourport->tx_in_progress = 0;
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -916,8 +913,7 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
 			break;
 
 		wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 		count--;
 	}
 
-- 
2.30.2

