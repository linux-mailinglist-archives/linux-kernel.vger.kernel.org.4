Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634CF719F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjFAOPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjFAOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:15:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90E058E;
        Thu,  1 Jun 2023 07:15:00 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0386F80F1;
        Thu,  1 Jun 2023 14:14:57 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: Fix probing serial_base_bus devices
Date:   Thu,  1 Jun 2023 17:14:44 +0300
Message-Id: <20230601141445.11321-1-tony@atomide.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a physical serial port device driver uses arch_initcall() we fail to
probe the serial_base_bus devices and the serial port tx fails. This is
because as serial_base_bus uses module_initcall().

Let's fix the issue by changing serial_base_bus to use arch_initcall().

Let's also return an error if a driver attempts to call uart_add_one_port()
too early.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/linux-serial/20230601132012.GB14287@atomide.com/T/#m6a40440fc04d551d27b147da8602e065c982a115
Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -17,6 +17,8 @@
 
 #include "serial_base.h"
 
+static bool serial_base_initialized;
+
 static int serial_base_match(struct device *dev, struct device_driver *drv)
 {
 	int len = strlen(drv->name);
@@ -48,6 +50,11 @@ static int serial_base_device_init(struct uart_port *port,
 				   void (*release)(struct device *dev),
 				   int id)
 {
+	if (!serial_base_initialized) {
+		dev_err(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
+		return -EPROBE_DEFER;
+	}
+
 	device_initialize(dev);
 	dev->type = type;
 	dev->parent = parent_dev;
@@ -175,6 +182,8 @@ static int serial_base_init(void)
 	if (ret)
 		goto err_ctrl_exit;
 
+	serial_base_initialized = true;
+
 	return 0;
 
 err_ctrl_exit:
@@ -185,7 +194,7 @@ static int serial_base_init(void)
 
 	return ret;
 }
-module_init(serial_base_init);
+arch_initcall(serial_base_init);
 
 static void serial_base_exit(void)
 {
-- 
2.40.1
