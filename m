Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1B603FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiJSJhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiJSJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:31:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F8C6955;
        Wed, 19 Oct 2022 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170844; x=1697706844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVyuluNhKfUl6XPBNwDdqJifQkuYh/oy8JzAs+w5pCs=;
  b=ViwfHK4Kb2V8QWDfNq5qssNPuvj6xBqQRW7C7ywNKqfIWXiFwV7aQSze
   iU6RbGQCrXIzAGJIDo3X4u/tmRF2Ewi5HF4O7LqNSycuLN2/h86vIKY80
   cehmVBuoYpB/xKC4UfLKDzvFfGEBS4EsR6S+dnZkVs2w4XJNQuu2V3vUG
   DFE82aP90R78d474jeKtuPOJV22PJrcBCdeOVwfMzLkcsJCf+weCcRgMb
   jdU8V0RR6Arl+5/J0oP5ziYaVMf8eNkkwQx3kqIe6j6KRzvP97eTOzeLZ
   Swp5Oi8PyQn7RmGSEgpn+gMfFphq+aQOwIgvExYYxjwpm77MvgFShUvAZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910913"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910913"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118651"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118651"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/44] serial: atmel: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:18 +0300
Message-Id: <20221019091151.6692-12-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/atmel_serial.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index bd07f79a2df9..4485f2d26b77 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -875,10 +875,7 @@ static void atmel_complete_tx_dma(void *arg)
 
 	if (chan)
 		dmaengine_terminate_all(chan);
-	xmit->tail += atmel_port->tx_len;
-	xmit->tail &= UART_XMIT_SIZE - 1;
-
-	port->icount.tx += atmel_port->tx_len;
+	uart_xmit_advance(port, atmel_port->tx_len);
 
 	spin_lock_irq(&atmel_port->lock_tx);
 	async_tx_ack(atmel_port->desc_tx);
@@ -1471,11 +1468,7 @@ static void atmel_tx_pdc(struct uart_port *port)
 	/* nothing left to transmit? */
 	if (atmel_uart_readl(port, ATMEL_PDC_TCR))
 		return;
-
-	xmit->tail += pdc->ofs;
-	xmit->tail &= UART_XMIT_SIZE - 1;
-
-	port->icount.tx += pdc->ofs;
+	uart_xmit_advance(port, pdc->ofs);
 	pdc->ofs = 0;
 
 	/* more to transmit - setup next transfer */
-- 
2.30.2

