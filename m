Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB063529E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiKWI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbiKWI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:28:38 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1253C5CD25;
        Wed, 23 Nov 2022 00:28:34 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D696E816A;
        Wed, 23 Nov 2022 08:28:31 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] serial: core: Add port port device to flush TX on runtime resume
Date:   Wed, 23 Nov 2022 10:28:25 +0200
Message-Id: <20221123082825.32820-2-tony@atomide.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123082825.32820-1-tony@atomide.com>
References: <20221123082825.32820-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With PM runtime enabled for the serial port controllers, we can now flush
pending TX for the port on runtime PM resume as suggested by
Johan Hovold <johan@kernel.org>.

To flush the pending TX, let's set up each port as a proper device as
suggested by Greg Kroah-Hartman <gregkh@linuxfoundation.org>.

We set up each port as a child device for the serial port controller
device. We use platform device for this and pass the port information
in platform_data.

Let's just do mimimal changes needed for now, more port specific code
can be then moved from serial_core.c to serial_port.c as needed.

Suggested-by: Johan Hovold <johan@kernel.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/Makefile      |   2 +-
 drivers/tty/serial/serial_core.c |  77 ++++++++++++++++++++-
 drivers/tty/serial/serial_port.c | 111 +++++++++++++++++++++++++++++++
 drivers/tty/serial/serial_port.h |  16 +++++
 include/linux/serial_core.h      |   1 +
 5 files changed, 204 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tty/serial/serial_port.c
 create mode 100644 drivers/tty/serial/serial_port.h

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel serial device drivers.
 #
 
-obj-$(CONFIG_SERIAL_CORE) += serial_core.o
+obj-$(CONFIG_SERIAL_CORE) += serial_core.o serial_port.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -31,6 +32,8 @@
 #include <linux/irq.h>
 #include <linux/uaccess.h>
 
+#include "serial_port.h"
+
 /*
  * Serial port device specific data for serial core.
  *
@@ -151,9 +154,31 @@ static void __uart_start(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
+	struct device *port_dev;
+	int err;
+
+	if (!port || uart_tx_stopped(port))
+		return;
 
-	if (port && !uart_tx_stopped(port))
+	port_dev = port->state->port_dev;
+
+	err = pm_runtime_get(port_dev);
+	if (err < 0) {
+		/* Something went wrong, attempt to start TX anyways */
+		port->ops->start_tx(port);
+		pm_runtime_put_noidle(port_dev);
+		return;
+	}
+
+	/*
+	 * Start TX if enabled, and kick runtime PM. Otherwise we must
+	 * wait for a retry. See also serial_port.c for runtime PM
+	 * autosuspend timeout.
+	 */
+	if (pm_runtime_active(port_dev))
 		port->ops->start_tx(port);
+	pm_runtime_mark_last_busy(port_dev);
+	pm_runtime_put_autosuspend(port_dev);
 }
 
 static void uart_start(struct tty_struct *tty)
@@ -288,6 +313,37 @@ serial_core_find_controller(struct uart_driver *drv, struct device *dev)
 	return NULL;
 }
 
+static int serial_core_add_port_device(struct uart_port *port)
+{
+	struct serial_port_platdata pd;
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc("serial-port", PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.parent = port->dev;
+	pd.state = port->state;
+
+	ret = platform_device_add_data(pdev, &pd, sizeof(pd));
+	if (ret)
+		goto err_put;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err_put;
+
+	port->state->port_dev = &pdev->dev;
+
+	return 0;
+
+err_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
 /*
  * Initialize a serial port device and serial port controller as
  * needed. Called from uart_add_one_port() with port_mutex held.
@@ -317,13 +373,21 @@ static int serial_core_register_port(struct uart_port *port,
 	port->state->controller = controller;
 	WARN_ON(port->supports_autosuspend != controller->supports_autosuspend);
 
+	ret = serial_core_add_port_device(port);
+	if (ret)
+		goto err_free;
+
 	ret = serial_core_pm_runtime_start(port);
 	if (ret < 0)
-		goto err_free;
+		goto err_del;
 
 	return 0;
 
+err_del:
+	platform_device_del(to_platform_device(port->state->port_dev));
+
 err_free:
+	port->state->port_dev = NULL;
 	port->state->controller = NULL;
 	if (allocated)
 		kfree(controller);
@@ -339,11 +403,14 @@ static int serial_core_register_port(struct uart_port *port,
 static void serial_core_unregister_port(struct uart_port *port)
 {
 	struct serial_controller *controller = to_controller(port);
+	struct device *dev = port->state->port_dev;
 
 	/* Check for a registered controller, no struct device early on */
 	if (!controller)
 		return;
 
+	platform_device_del(to_platform_device(dev));
+	port->state->port_dev = NULL;
 	port->state->controller = NULL;
 	kref_put(&controller->ref, serial_core_pm_runtime_cleanup);
 }
@@ -363,6 +430,10 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (uport->type == PORT_UNKNOWN)
 		return 1;
 
+	retval = serial_port_get(state);
+	if (retval)
+		return retval;
+
 	/*
 	 * Make sure the device is in D0 state.
 	 */
@@ -2030,6 +2101,8 @@ static void uart_port_shutdown(struct tty_port *port)
 		/* Ensure that the IRQ handler isn't running on another CPU. */
 		synchronize_irq(uport->irq);
 	}
+
+	serial_port_put(state);
 }
 
 static int uart_carrier_raised(struct tty_port *port)
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
new file mode 100644
--- /dev/null
+++ b/drivers/tty/serial/serial_port.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Serial port driver to provide port specific services for serial_core
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/serial_core.h>
+
+#include "serial_port.h"
+
+#define SERIAL_PORT_AUTOSUSPEND_DELAY_MS	500
+
+struct serial_port_data {
+	struct uart_state *state;
+};
+
+int serial_port_get(struct uart_state *state)
+{
+	if (!state)
+		return -ENODEV;
+
+	/* Prevent uart_port from unloading */
+	if (!state->port_dev || !state->port_dev->driver ||
+	    !try_module_get(state->port_dev->driver->owner))
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL(serial_port_get);
+
+void serial_port_put(struct uart_state *state)
+{
+	if (!state || !state->port_dev || !state->port_dev->driver)
+		return;
+
+	module_put(state->port_dev->driver->owner);
+}
+EXPORT_SYMBOL(serial_port_put);
+
+/* Only considers TX for now. Caller must take care of locking */
+static int __serial_port_busy(struct uart_port *port)
+{
+	return (!uart_tx_stopped(port) &&
+		uart_circ_chars_pending(&port->state->xmit));
+}
+
+static int serial_port_runtime_resume(struct device *dev)
+{
+	struct serial_port_data *ddata = dev_get_drvdata(dev);
+	struct uart_port *port = ddata->state->uart_port;
+	unsigned long flags;
+
+	/* Flush any pending TX for the port */
+	spin_lock_irqsave(&port->lock, flags);
+	if (__serial_port_busy(port))
+		port->ops->start_tx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops serial_port_pm = {
+	SET_RUNTIME_PM_OPS(NULL, serial_port_runtime_resume, NULL)
+};
+
+static int serial_port_probe(struct platform_device *pdev)
+{
+	struct serial_port_platdata *pd = dev_get_platdata(&pdev->dev);
+	struct serial_port_data *ddata;
+
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->state = pd->state;
+	platform_set_drvdata(pdev, ddata);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 SERIAL_PORT_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
+	return 0;
+}
+
+static int serial_port_remove(struct platform_device *pdev)
+{
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver serial_port_driver = {
+	.driver = {
+		.name = "serial-port",
+		.pm = &serial_port_pm,
+	},
+	.probe = serial_port_probe,
+	.remove = serial_port_remove,
+};
+
+module_platform_driver(serial_port_driver);
+
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("Serial controller port driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/serial_port.h b/drivers/tty/serial/serial_port.h
new file mode 100644
--- /dev/null
+++ b/drivers/tty/serial/serial_port.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/**
+ * struct serial_port_platdata - Serial port platform data
+ * @state: serial port state
+ *
+ * Used by serial_core and serial_port only. Allocated on uart_add_one_port(),
+ * and freed on uart_remove_one_port(). Note that the life cycle for uart_state
+ * is different from serial_port_device.
+ */
+struct serial_port_platdata {
+	struct uart_state *state;
+};
+
+extern int serial_port_get(struct uart_state *state);
+extern void serial_port_put(struct uart_state *state);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -614,6 +614,7 @@ struct uart_state {
 	struct tty_port		port;
 
 	struct serial_controller *controller;
+	struct device		*port_dev;
 
 	enum uart_pm_state	pm_state;
 	struct circ_buf		xmit;
-- 
2.38.1
