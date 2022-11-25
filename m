Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCF638AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKYNFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKYNFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:05:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9354C2A417;
        Fri, 25 Nov 2022 05:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669381530; x=1700917530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JyK1IkOeQHocT9IrUkcXubj5M8zAIvA2Nbr+c5YEM98=;
  b=mavMDgXaSx1p8ckmtBJ3rnkX/8fX6hxgQIAyLAkD/o6tWoD8sL4ryVN7
   raTnsf7se5Yak6u1E7dSUJE4gd6XjoQMYNKqljb1bZL0e7R4JGtqFvm4T
   FMu3idA2oct9Cj1l0GVTOhqCNA42HTIr2xe+At7x7UEcr9EFxt05gwRuI
   yeOAvsa1nYKrKSCx3ADX17Hdnkmpg3n8HFH/SOH8Hzb9Vf4mFenRkuInB
   JF8KaLu3UvukNPNFeK+3n/sCzRVHeiJUkF7ZOKgXSx3caZzt0gUug9yoD
   WKR5rQe55bNvBDT8ce5rUyw6eIsT75e1H0Hkp9c2ADz0kdrvDNwnvcf/+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316300785"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="316300785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="706064033"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="706064033"
Received: from dpotapen-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.50.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:28 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/6] serial: 8250: Add IIR FIFOs enabled field properly
Date:   Fri, 25 Nov 2022 15:05:07 +0200
Message-Id: <20221125130509.8482-5-ilpo.jarvinen@linux.intel.com>
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

Don't use magic literals & comments but define a real field instead
for UART_IIR_FIFO_ENABLED and name also the values.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 17 +++++++----------
 include/uapi/linux/serial_reg.h     |  4 ++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e79bf2afd9be..a47ce3e974a2 100644
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
+	case UART_IIR_FIFO_ENABLED_16550:
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
index bab3b39266cc..19aef5b0b049 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -44,6 +44,10 @@
 #define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
 #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
 #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
+#define UART_IIR_FIFO_ENABLED	0xc0 /* FIFOs enabled / port type identification */
+#define  UART_IIR_FIFO_ENABLED_8250	0x00	/* 8250: no FIFO */
+#define  UART_IIR_FIFO_ENABLED_16550	0x80	/* 16550: (broken/unusable) FIFO */
+#define  UART_IIR_FIFO_ENABLED_16550A	0xc0	/* 16550A: FIFO enabled */
 
 #define UART_FCR	2	/* Out: FIFO Control Register */
 #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
-- 
2.30.2

