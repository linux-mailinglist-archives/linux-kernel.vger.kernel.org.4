Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85BC637990
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiKXNA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiKXNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:00:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C0A467D;
        Thu, 24 Nov 2022 05:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669294812; x=1700830812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahe4RtT6QiA9G79DW5IcLGvzzQC2AlbVwYDb40hS8ks=;
  b=Mtr+cXMqTWvV9Z1cDW3fTyCC31qs6d1dh7xsn5sFH7SPqIGwF1S6Uzmo
   dNerxukGUFTDWT/byQVN+dmY3YXy17ezkdalZXaOPWVeJCMW5SoRf6DdH
   MDAdZC3FlliYmEKAFTJN5f001mJzz4LWYoUv3iPa7qfc3dcNgUCfpEycb
   dtkuaV7Vi/U4wwyrz+hKp6gPMnzDAkqLOxnJYm9ln8mc8MIZksC85vO+z
   KSXJJdZ9v4rEjU56737XeeD01fvz0ZtGuq2cl87/sLujYkBBSagixlM7+
   0nVv7AoTEltdVUWHVeF9S4ICehU6pfLEBU1koQn090vFs2PAQC9fZTK45
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311932085"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311932085"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887367672"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="887367672"
Received: from msharawy-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:10 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/6] serial: 8250: Add IIR FIFOs enabled field properly
Date:   Thu, 24 Nov 2022 14:59:46 +0200
Message-Id: <20221124125948.23432-5-ilpo.jarvinen@linux.intel.com>
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

Don't use magic literals & comments but define a real field instead
for UART_IIR_FIFO_ENABLED and name also the values.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 17 +++++++----------
 include/uapi/linux/serial_reg.h     |  4 ++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e79bf2afd9be..6d343b15bc58 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1293,22 +1293,19 @@ static void autoconfig(struct uart_8250_port *up)
 
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 
-	/* Assign this as it is to truncate any bits above 7.  */
-	scratch = serial_in(up, UART_IIR);
-
-	switch (scratch >> 6) {
-	case 0:
+	switch (serial_in(up, UART_IIR) & UART_IIR_FIFO_ENABLED) {
+	case UART_IIR_FIFO_ENABLED_8250:
 		autoconfig_8250(up);
 		break;
-	case 1:
-		port->type = PORT_UNKNOWN;
-		break;
-	case 2:
+	case UART_IIR_FIFO_EAABLED_16550:
 		port->type = PORT_16550;
 		break;
-	case 3:
+	case UART_IIR_FIFO_ENABLED_16550A:
 		autoconfig_16550a(up);
 		break;
+	default:
+		port->type = PORT_UNKNOWN;
+		break;
 	}
 
 #ifdef CONFIG_SERIAL_8250_RSA
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index bab3b39266cc..a63c124b7fdc 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -44,6 +44,10 @@
 #define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
 #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
 #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
+#define UART_IIR_FIFO_ENABLED	0xc0 /* FIFOs enabled / port type identification */
+#define  UART_IIR_FIFO_ENABLED_8250	0x00	/* 8250: no FIFO */
+#define  UART_IIR_FIFO_EAABLED_16550	0x80	/* 16550: (broken/unusable) FIFO */
+#define  UART_IIR_FIFO_ENABLED_16550A	0xc0	/* 16550A: FIFO enabled */
 
 #define UART_FCR	2	/* Out: FIFO Control Register */
 #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
-- 
2.30.2

