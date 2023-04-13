Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77486E0750
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDMHEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDMHD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:03:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5344F46B9;
        Thu, 13 Apr 2023 00:03:56 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 5C3C580F0;
        Thu, 13 Apr 2023 07:03:54 +0000 (UTC)
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
Subject: [PATCH] serial: 8250: Clear port->pm on port specific driver unbind
Date:   Thu, 13 Apr 2023 10:03:41 +0300
Message-Id: <20230413070342.36155-1-tony@atomide.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Let's fix the issue by clearing port->pm in serial8250_unregister_port().

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1157,6 +1157,7 @@ void serial8250_unregister_port(int line)
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
+		uart->port.pm = NULL;
 		uart->capabilities = 0;
 		serial8250_apply_quirks(uart);
 		uart_add_one_port(&serial8250_reg, &uart->port);
-- 
2.40.0
