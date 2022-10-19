Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC4604000
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiJSJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJSJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:32:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F317E25;
        Wed, 19 Oct 2022 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170886; x=1697706886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2sO96QvGbKZASEZajyqgl5elACacZqC44Dvl0bF594=;
  b=e3gIam+XlgVph4eDQ6z9ubdV+2WM18A2wvIQXXEXAmPFxBxkK/XzBYMc
   tqVSOz6eaiYTNKq/GPQC5GoSa6kuAZ7PVhrOPSbW8gU9QirPd7JmxLiGD
   3Cew/F4WCvg7olezTs9ktzdLB5+KaFDxdCgJMz56vBPhxCciRC6FeOyFP
   R05m6x5ijrCzQ1WNJ6Xj5FqmjqQ2fp0r9IsqyFlMcYN3AklpDZpUIJCYr
   zBvyUMgdxzI5i7qKqxYLfTRvocxqYm83KY+uzS11HAAG/MvOE+2QqkIH/
   ivyfn3VlrI6I3q8FEHCGi6xlEsqLUOa5rrreAeuwdUru5vax841rJPIRp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332911073"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332911073"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118880"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118880"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:30 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 22/44] serial: meson: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:29 +0300
Message-Id: <20221019091151.6692-23-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/meson_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 056243c12836..74110017988a 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -162,8 +162,7 @@ static void meson_uart_start_tx(struct uart_port *port)
 
 		ch = xmit->buf[xmit->tail];
 		writel(ch, port->membase + AML_UART_WFIFO);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 	}
 
 	if (!uart_circ_empty(xmit)) {
-- 
2.30.2

