Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551E63798A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKXNAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:00:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091387CB94;
        Thu, 24 Nov 2022 05:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669294804; x=1700830804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4vgVjpU9TM3c0NS17ZVh5x8n1rUnhEw0wd9aDkvz4nk=;
  b=ElF5mXaVEII5eQpqvBFK7ngxtzQz+sFTqitXBzC1NHahOvRQGMaZ1St4
   Ul3wOMazCK4n+L1D8TNm5xSl9LLA/mY2Tl2gp01AMIyJEJbKLDOzBc/2F
   fNeWrEYhHXCPBk3Z9aoot+8jbUi0jAE6R8fcem+UDvKwjHOvL3K0ngzot
   m4i7DK33XQOZKCpz8hEZvN14mYZYQs1GVxsslsmhwl+oCFHZQwVMHiL1R
   oPHQekIByKuR1g8EJOi+YGT/7N8btN6dymA75nPFE3bPZd39U8W/eV1f2
   E8dkL2pFqj5RHiGAWV6w5IHcKqSj+0977Xd+HEEFsfs+J6VD+tB/niWT0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311932043"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311932043"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887367555"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="887367555"
Received: from msharawy-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:02 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/6] serial: 8250: Use defined IER bits
Date:   Thu, 24 Nov 2022 14:59:43 +0200
Message-Id: <20221124125948.23432-2-ilpo.jarvinen@linux.intel.com>
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

Instead of literal 0x0f, add a define for enabling all IER bits the
8250 driver is interested in.

Don't make the define for combined flags part of UAPI.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 10 +++++-----
 include/linux/serial.h              |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index beba8f38b3dc..8676f8b7f2e3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1236,14 +1236,14 @@ static void autoconfig(struct uart_8250_port *up)
 		 * Mask out IER[7:4] bits for test as some UARTs (e.g. TL
 		 * 16C754B) allow only to modify them if an EFR bit is set.
 		 */
-		scratch2 = serial_in(up, UART_IER) & 0x0f;
-		serial_out(up, UART_IER, 0x0F);
+		scratch2 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
+		serial_out(up, UART_IER, UART_IER_ALL_INTR);
 #ifdef __i386__
 		outb(0, 0x080);
 #endif
-		scratch3 = serial_in(up, UART_IER) & 0x0f;
+		scratch3 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
 		serial_out(up, UART_IER, scratch);
-		if (scratch2 != 0 || scratch3 != 0x0F) {
+		if (scratch2 != 0 || scratch3 != UART_IER_ALL_INTR) {
 			/*
 			 * We failed; there's nothing here
 			 */
@@ -1394,7 +1394,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		serial8250_out_MCR(up,
 			UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
 	}
-	serial_out(up, UART_IER, 0x0f);	/* enable all intrs */
+	serial_out(up, UART_IER, UART_IER_ALL_INTR);
 	serial_in(up, UART_LSR);
 	serial_in(up, UART_RX);
 	serial_in(up, UART_IIR);
diff --git a/include/linux/serial.h b/include/linux/serial.h
index 3d6fe3ef92cf..ad6e1c37e2d5 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -12,6 +12,11 @@
 #include <uapi/linux/serial.h>
 #include <uapi/linux/serial_reg.h>
 
+#define UART_IER_ALL_INTR	(UART_IER_MSI | \
+				 UART_IER_RLSI | \
+				 UART_IER_THRI | \
+				 UART_IER_RDI)
+
 /* Helper for dealing with UART_LCR_WLEN* defines */
 #define UART_LCR_WLEN(x)	((x) - 5)
 
-- 
2.30.2

