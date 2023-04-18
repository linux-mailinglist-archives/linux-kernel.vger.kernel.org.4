Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382806E5E63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjDRKOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDRKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:14:14 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60E913ABF;
        Tue, 18 Apr 2023 03:14:13 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 6899C8106;
        Tue, 18 Apr 2023 10:14:11 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] serial: 8250: Reinit port->pm on port specific driver unbind
Date:   Tue, 18 Apr 2023 13:14:06 +0300
Message-Id: <20230418101407.12403-1-tony@atomide.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we unbind a serial port hardware specific 8250 driver, the generic
serial8250 driver takes over the port. After that we see an oops about 10
seconds later. This can produce the following at least on some TI SoCs:

Unhandled fault: imprecise external abort (0x1406)
Internal error: : 1406 [#1] SMP ARM

Turns out that we may still have the serial port hardware specific driver
port->pm in use, and serial8250_pm() tries to call it after the port
specific driver is gone:

serial8250_pm [8250_base] from uart_change_pm+0x54/0x8c [serial_base]
uart_change_pm [serial_base] from uart_hangup+0x154/0x198 [serial_base]
uart_hangup [serial_base] from __tty_hangup.part.0+0x328/0x37c
__tty_hangup.part.0 from disassociate_ctty+0x154/0x20c
disassociate_ctty from do_exit+0x744/0xaac
do_exit from do_group_exit+0x40/0x8c
do_group_exit from __wake_up_parent+0x0/0x1c

Let's fix the issue by calling serial8250_set_defaults() in
serial8250_unregister_port(). This will set the port back to using
the serial8250 default functions, and sets the port->pm to point to
serial8250_pm.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v1:

- Call serial8250_init_port() instead of just clearing port->pm

- Updated patch subject line a bit

---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1158,6 +1158,7 @@ void serial8250_unregister_port(int line)
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->capabilities = 0;
+		serial8250_init_port(uart);
 		serial8250_apply_quirks(uart);
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
-- 
2.40.0
