Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5363798C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiKXNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiKXNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:00:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC542D1E1;
        Thu, 24 Nov 2022 05:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669294807; x=1700830807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=382hEEQ4aybhmi7q6KqC+mBW2YH4NFBL19G2ZyJJaHk=;
  b=gojuiluKuAJxwCejmuHZPdRvRm7Zyl7Qr8iMYePXD3DXFtBip/+O2HQf
   wckOhHoSTrSap7uqfD5N1hlOal7t7r+W5Aa0DBemEjrYI2I0wLsz+RKGO
   TQvTFASaqTe7kQ45cixQPdfhBHuAcfwtlZ+HFjWbhlaMQvfmo5oxSUesm
   68CDEECvCrO0JlcybnX/urDnhLbUl+1iDBHoO3+0Dj2j8RHzQ2Uqh/KSb
   i3eCyUk4y/NRTScnZjVW34s8JLELuf+K3VZdLDiNYenfv5jY4mrk0YgQF
   /0M+cOSvomlWGrUdC3vY+ZJoX8a5rhZ4OJxy/3HgtasLp7wlwKRpnNMjU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311932055"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311932055"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887367592"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="887367592"
Received: from msharawy-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:04 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/6] serial: 8250: Name MSR literals
Date:   Thu, 24 Nov 2022 14:59:44 +0200
Message-Id: <20221124125948.23432-3-ilpo.jarvinen@linux.intel.com>
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

