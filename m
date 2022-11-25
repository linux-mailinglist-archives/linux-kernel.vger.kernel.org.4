Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDBB638AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKYNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKYNFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:05:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3B82B61C;
        Fri, 25 Nov 2022 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669381533; x=1700917533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ic5NGKUd2TkcSnwEZPif9UrSF9XQfkvW0X1TSU5714E=;
  b=dtMGVOI9xXqLjnOvuHeihT/rhmwoHmLtWL9EoNPys7uhvmjrD1y6NfLJ
   IliVoyY7s1PqppB47/IMII7X0nIoOiY1asERWj49Bsb2mqhmahgH+m/vc
   fCQ2UTnxXSp36X/1+Sk9ZS1NFEpFWdtjc77utLlBKzvCrRfWaSCkuvUic
   VgH3P9yPqZis/o64I+y3nX7Z18l0SbeI6cpuM+8dY1Y/bPyQIx9jEexMW
   C3zJVq61CTuIzrmXGH30+hxGrSe3CAUQm+uSsVy2Oyu3zFJvkVnKZ2+Oo
   3dQ8GCizmbJDOg9r+1cC2Pdi7+sVdFW7nJCKiXnh0P68elCvcshQV/xav
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316300796"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="316300796"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="706064040"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="706064040"
Received: from dpotapen-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.50.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:31 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 5/6] serial: 8250: Define IIR 64 byte bit & cleanup related code
Date:   Fri, 25 Nov 2022 15:05:08 +0200
Message-Id: <20221125130509.8482-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221125130509.8482-1-ilpo.jarvinen@linux.intel.com>
References: <20221125130509.8482-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16750 indicates 64 bytes FIFO with a IIR bit. Add define for it and
make related code more obvious.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 14 +++++++++-----
 include/uapi/linux/serial_reg.h     |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a47ce3e974a2..33be7aad11ef 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1050,11 +1050,12 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 			serial_out(up, UART_LCR, 0);
 			serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO |
 				   UART_FCR7_64BYTE);
-			status1 = serial_in(up, UART_IIR) >> 5;
+			status1 = serial_in(up, UART_IIR) & (UART_IIR_64BYTE_FIFO |
+							     UART_IIR_FIFO_ENABLED);
 			serial_out(up, UART_FCR, 0);
 			serial_out(up, UART_LCR, 0);
 
-			if (status1 == 7)
+			if (status1 == (UART_IIR_64BYTE_FIFO | UART_IIR_FIFO_ENABLED))
 				up->port.type = PORT_16550A_FSL64;
 			else
 				DEBUG_AUTOCONF("Motorola 8xxx DUART ");
@@ -1122,17 +1123,20 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 */
 	serial_out(up, UART_LCR, 0);
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
-	status1 = serial_in(up, UART_IIR) >> 5;
+	status1 = serial_in(up, UART_IIR) & (UART_IIR_64BYTE_FIFO | UART_IIR_FIFO_ENABLED);
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
-	status2 = serial_in(up, UART_IIR) >> 5;
+	status2 = serial_in(up, UART_IIR) & (UART_IIR_64BYTE_FIFO | UART_IIR_FIFO_ENABLED);
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+
 	serial_out(up, UART_LCR, 0);
 
 	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
 
-	if (status1 == 6 && status2 == 7) {
+	if (status1 == UART_IIR_FIFO_ENABLED_16550A &&
+	    status2 == (UART_IIR_64BYTE_FIFO | UART_IIR_FIFO_ENABLED_16550A)) {
 		up->port.type = PORT_16750;
 		up->capabilities |= UART_CAP_AFE | UART_CAP_SLEEP;
 		return;
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 19aef5b0b049..08b3527e1b93 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -44,6 +44,7 @@
 #define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
 #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
 #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
+#define UART_IIR_64BYTE_FIFO	0x20 /* 16750 64 bytes FIFO */
 #define UART_IIR_FIFO_ENABLED	0xc0 /* FIFOs enabled / port type identification */
 #define  UART_IIR_FIFO_ENABLED_8250	0x00	/* 8250: no FIFO */
 #define  UART_IIR_FIFO_ENABLED_16550	0x80	/* 16550: (broken/unusable) FIFO */
-- 
2.30.2

