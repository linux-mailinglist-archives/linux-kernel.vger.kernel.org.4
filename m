Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECDC637992
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKXNAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiKXNAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:00:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25844B4815;
        Thu, 24 Nov 2022 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669294815; x=1700830815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VutGYxx4X5h3Re6dYoyp+VWTCDAcQnLjx3PAe8fAJyU=;
  b=e5W07xu9djo0dlXVSZ+OU4YId69ILWV0VaQ2uUUsbt7zuL7seue15/Ai
   rvs9TLp1wDgGqfvOQS15QRU8xGH1jW+54lwcIgJZw4w520nXtI0EBF08h
   3yioaZ2L6QgCz2WIqjmkiFvEbvDada610JIcDXQ7mpQvy529O9loc7cyo
   t2cIhsx00zIVcbMjg0UDHkbRCGq7edhzyVx2xLUxnJtZTtzI3A7Mml500
   At+ITSuvH/tnUwL4wEFOrHSxy+ffj5BQRW5HmJhfV4o9cMHjHF+fPY5OT
   tBSqBfu+N2zUX+J1Hdl26vtDksnOx/kOgjXUEJ3Rg8BDNBSCTcPfR2HEP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311932102"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311932102"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887367695"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="887367695"
Received: from msharawy-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:13 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/6] serial: 8250: Define IIR 64 byte bit & cleanup related code
Date:   Thu, 24 Nov 2022 14:59:47 +0200
Message-Id: <20221124125948.23432-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221124125948.23432-1-ilpo.jarvinen@linux.intel.com>
References: <20221124125948.23432-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
index 6d343b15bc58..764043931a99 100644
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
index a63c124b7fdc..21ae5b930c7b 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -44,6 +44,7 @@
 #define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
 #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
 #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
+#define UART_IIR_64BYTE_FIFO	0x20 /* 16750 64 bytes FIFO */
 #define UART_IIR_FIFO_ENABLED	0xc0 /* FIFOs enabled / port type identification */
 #define  UART_IIR_FIFO_ENABLED_8250	0x00	/* 8250: no FIFO */
 #define  UART_IIR_FIFO_EAABLED_16550	0x80	/* 16550: (broken/unusable) FIFO */
-- 
2.30.2

