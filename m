Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73527638AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKYNFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKYNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:05:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473E2A253;
        Fri, 25 Nov 2022 05:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669381523; x=1700917523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4vgVjpU9TM3c0NS17ZVh5x8n1rUnhEw0wd9aDkvz4nk=;
  b=jzmKeMMV0bFmDJAgLoCn50PQY3tQc2Yw0LddmwEt16ooYYi7B+N3wIOb
   TDjU1ikC/NJJiSYgFKo2sNU/ucwcc1hfPtv/5/5qEfSe4boKUIyCFfnQP
   xk92YnUvbWcLZcUQ/kZaXrao55bLRzl16ZlEN+4qAtoL7ZQigzKRDadrB
   IEW5CQ7uGTS0LgjsREtN8pd6eBmZNwK5w/gQSyxGXrVoISUD6yaGreBJo
   EXFFpBLqTk+hz/AAGu/+RQDWqSrCkm2fysvM/NA7+BusKZAPlAti2EIrp
   0iWFVNQkzcxrn1xD/dXc9dyp1AgZNVQB/JHOeWETZ0n6T9wjn222CaGP5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316300766"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="316300766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="706064018"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="706064018"
Received: from dpotapen-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.50.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:20 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/6] serial: 8250: Use defined IER bits
Date:   Fri, 25 Nov 2022 15:05:04 +0200
Message-Id: <20221125130509.8482-2-ilpo.jarvinen@linux.intel.com>
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

