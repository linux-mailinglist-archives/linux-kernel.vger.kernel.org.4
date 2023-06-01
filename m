Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D849671A300
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjFAPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjFAPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:46:21 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1434FB;
        Thu,  1 Jun 2023 08:46:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0DBA480F1;
        Thu,  1 Jun 2023 15:46:14 +0000 (UTC)
Date:   Thu, 1 Jun 2023 18:46:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix probing serial_base_bus devices
Message-ID: <20230601154612.GE14287@atomide.com>
References: <20230601141445.11321-1-tony@atomide.com>
 <CGME20230601142147eucas1p1ae331f80a07ad6280f8f759b2d03ade7@eucas1p1.samsung.com>
 <2023060112-onion-disparate-8ce8@gregkh>
 <d7c857b8-4aa1-cd5d-4c45-392f7ed6857b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c857b8-4aa1-cd5d-4c45-392f7ed6857b@samsung.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Marek Szyprowski <m.szyprowski@samsung.com> [230601 15:09]:
> On 01.06.2023 16:21, Greg Kroah-Hartman wrote:
> > On Thu, Jun 01, 2023 at 05:14:44PM +0300, Tony Lindgren wrote:
> >> If a physical serial port device driver uses arch_initcall() we fail to
> >> probe the serial_base_bus devices and the serial port tx fails. This is
> >> because as serial_base_bus uses module_initcall().
> >>
> >> Let's fix the issue by changing serial_base_bus to use arch_initcall().
> > This will only work if the linking order is such that this will always
> > come before the drivers.  Is that the case here?
> 
> Yes, serial_base_bus is linked as a second object, just after the 
> serial_core. Device drivers come later.

If we don't want to rely on the Makefile order here, we could do something
like the patch below.

Regards,

Tony

8< ---------------------
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -11,12 +11,18 @@
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #include "serial_base.h"
 
+static bool serial_base_initialized;
+static DEFINE_MUTEX(serial_base_lock);
+
+static int serial_base_init(void);
+
 static int serial_base_match(struct device *dev, struct device_driver *drv)
 {
 	int len = strlen(drv->name);
@@ -48,6 +54,12 @@ static int serial_base_device_init(struct uart_port *port,
 				   void (*release)(struct device *dev),
 				   int id)
 {
+	/*
+	 * Initialize bus if not yet initialized. Some drivers are using
+	 * arch_initcall()
+	 */
+	serial_base_init();
+
 	device_initialize(dev);
 	dev->type = type;
 	dev->parent = parent_dev;
@@ -163,6 +175,14 @@ static int serial_base_init(void)
 {
 	int ret;
 
+	mutex_lock(&serial_base_lock);
+
+	/* Also called from serial_base_device_init() in some cases */
+	if (serial_base_initialized) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	ret = bus_register(&serial_base_bus_type);
 	if (ret)
 		return ret;
@@ -175,6 +195,10 @@ static int serial_base_init(void)
 	if (ret)
 		goto err_ctrl_exit;
 
+	serial_base_initialized = true;
+
+	mutex_unlock(&serial_base_lock);
+
 	return 0;
 
 err_ctrl_exit:
@@ -183,15 +207,21 @@ static int serial_base_init(void)
 err_bus_unregister:
 	bus_unregister(&serial_base_bus_type);
 
+out_unlock:
+	mutex_unlock(&serial_base_lock);
+
 	return ret;
 }
 module_init(serial_base_init);
 
 static void serial_base_exit(void)
 {
+	mutex_lock(&serial_base_lock);
 	serial_base_port_exit();
 	serial_base_ctrl_exit();
 	bus_unregister(&serial_base_bus_type);
+	serial_base_initialized = false;
+	mutex_unlock(&serial_base_lock);
 }
 module_exit(serial_base_exit);
 
-- 
2.40.1
