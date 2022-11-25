Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A87638AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKYNFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKYNF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:05:28 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E7C2B258;
        Fri, 25 Nov 2022 05:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669381525; x=1700917525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=382hEEQ4aybhmi7q6KqC+mBW2YH4NFBL19G2ZyJJaHk=;
  b=NOPLbaZzR+Ww3HAfqB+WvtMxLkrTlwz/1nVi/Ka6Z1yxBhI07USp8UMc
   XETxdLg4vfhEdyyCqqOVqpyzoLG1uL9pRPr78qNayXYfvu3APfPoH9OMW
   XOaRfpyrRT4SNPvdxHNhiOaWFG3ECSmWyRk2f1eNfDg7dHIRuLtDtOuC5
   1l8FcdlROuJki6LuQa+w+8WYennjcL5wdm5ECXayFDENymBAmYplvNK97
   TkdtoqNLX8PHVgi0eq0zxaZP7fkjTvAv+vEW4i460f6+5+L0rGy4Sc7L/
   s+Iqh6NETjkySMp6/l67fIqMzf+/m8ZmuzUqwAoEO+Pq+OWrUgJnadjj0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316300773"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="316300773"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="706064021"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="706064021"
Received: from dpotapen-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.50.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:23 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/6] serial: 8250: Name MSR literals
Date:   Fri, 25 Nov 2022 15:05:05 +0200
Message-Id: <20221125130509.8482-3-ilpo.jarvinen@linux.intel.com>
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

Add UART_MSR_STATUS_BITS for CD, RI, DSR & CTS. Use names for the
literal.

Don't make the define for combined flags part of UAPI.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 include/linux/serial.h              | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8676f8b7f2e3..c870ee8e80b6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1268,9 +1268,9 @@ static void autoconfig(struct uart_8250_port *up)
 	 */
 	if (!(port->flags & UPF_SKIP_TEST)) {
 		serial8250_out_MCR(up, UART_MCR_LOOP | 0x0A);
-		status1 = serial_in(up, UART_MSR) & 0xF0;
+		status1 = serial_in(up, UART_MSR) & UART_MSR_STATUS_BITS;
 		serial8250_out_MCR(up, save_mcr);
-		if (status1 != 0x90) {
+		if (status1 != (UART_MSR_DCD | UART_MSR_CTS)) {
 			spin_unlock_irqrestore(&port->lock, flags);
 			DEBUG_AUTOCONF("LOOP test failed (%02x) ",
 				       status1);
diff --git a/include/linux/serial.h b/include/linux/serial.h
index ad6e1c37e2d5..bfda927dde15 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -28,6 +28,11 @@ static inline bool uart_lsr_tx_empty(u16 lsr)
 	return (lsr & UART_LSR_BOTH_EMPTY) == UART_LSR_BOTH_EMPTY;
 }
 
+#define UART_MSR_STATUS_BITS	(UART_MSR_DCD | \
+				 UART_MSR_RI | \
+				 UART_MSR_DSR | \
+				 UART_MSR_CTS)
+
 /*
  * Counters of the input lines (CTS, DSR, RI, CD) interrupts
  */
-- 
2.30.2

