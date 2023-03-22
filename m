Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA16C48BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCVLNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCVLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:13:10 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A17BF77C;
        Wed, 22 Mar 2023 04:13:08 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 979FC807A;
        Wed, 22 Mar 2023 11:13:05 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v8 1/1] serial: core: Start managing serial controllers to enable runtime PM
Date:   Wed, 22 Mar 2023 13:12:51 +0200
Message-Id: <20230322111255.29827-1-tony@atomide.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to enable runtime PM for serial port device drivers in a generic
way. To do this, we want to have the serial core layer manage the
registered physical serial controller devices.

To do this, let's set up a struct bus and struct device for the serial
core controller as suggested by Greg and Jiri. The serial core controller
devices are children of the physical serial port device. The serial core
controller device is needed to support multiple different kind of ports
connected to single physical serial port device.

Let's also set up a struct device for the serial core port. The serial
core port instances are children of the serial core controller device.

With the serial core port device we can now flush pending TX on the
runtime PM resume as suggested by Johan.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Suggested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v7:

- Add release() put_device() to serial_base.c as noted by Andy

- Make struct serial_base_device private to serial_base.c by adding
  serial_base_get_port()

- Add more comments to __uart_start()

- Coding style improvments for serial_base.c from Andy

Changes since v6:

- Fix up a memory leak and a bunch of issues in serial_base.c as noted
  by Andy

- Replace bool with new_ctrl_dev for freeing the added device on
  error path

- Drop unused pm ops for serial_ctrl.c as noted by kernel test robot

- Drop documentation updates for acpi devices for now to avoid a merge
  conflict and make testing easier between -rc2 and Linux next

Changes since v5:

- Replace platform bus and device with bus_add() and device_add(),
  Greg did not like platform bus and device here. This also gets
  rid of the need for platform data with struct serial_base_device,
  see new file serial_base.c

- Update documentation to drop reference to struct uart_device as
  suggested by Andy

Changes since v4:

- Fix issue noted by Ilpo by calling serial_core_add_one_port() after
  the devices are created

Changes since v3:

- Simplify things by adding a serial core control device as the child of
  the physical serial port as suggested by Jiri

- Drop the tinkering of the physical serial port device for runtime PM.
  Serial core just needs to manage port->port_dev with the addition of
  the serial core control device and the device hierarchy will keep the
  pysical serial port device enabled as needed

- Simplify patch description with all the runtime PM tinkering gone

- Coding style improvments as noted by Andy

- Post as a single RFC patch as we're close to the merge window

Changes since v2:

- Make each serial port a proper device as suggested by Greg. This is
  a separate patch that flushes the TX on runtime PM resume

Changes since v1:

- Use kref as suggested by Andy

- Fix memory leak on error as noted by Andy

- Use use unsigned char for supports_autosuspend as suggested by Andy

- Coding style improvments as suggested by Andy

---
 drivers/tty/serial/8250/8250_core.c |   1 +
 drivers/tty/serial/Makefile         |   2 +-
 drivers/tty/serial/serial_base.c    | 144 +++++++++++++++++++++++++
 drivers/tty/serial/serial_base.h    |  21 ++++
 drivers/tty/serial/serial_core.c    | 160 ++++++++++++++++++++++++++--
 drivers/tty/serial/serial_ctrl.c    |  71 ++++++++++++
 drivers/tty/serial/serial_port.c    | 104 ++++++++++++++++++
 include/linux/serial_core.h         |   4 +-
 8 files changed, 498 insertions(+), 9 deletions(-)
 create mode 100644 drivers/tty/serial/serial_base.c
 create mode 100644 drivers/tty/serial/serial_base.h
 create mode 100644 drivers/tty/serial/serial_ctrl.c
 create mode 100644 drivers/tty/serial/serial_port.c

Index: linux-bisect/drivers/tty/serial/8250/8250_core.c
===================================================================
--- linux-bisect.orig/drivers/tty/serial/8250/8250_core.c
+++ linux-bisect/drivers/tty/serial/8250/8250_core.c
@@ -996,6 +996,7 @@ int serial8250_register_8250_port(const
 		if (uart->port.dev)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
 
+		uart->port.ctrl_id	= up->port.ctrl_id;
 		uart->port.iobase       = up->port.iobase;
 		uart->port.membase      = up->port.membase;
 		uart->port.irq          = up->port.irq;
Index: linux-bisect/drivers/tty/serial/Makefile
===================================================================
--- linux-bisect.orig/drivers/tty/serial/Makefile
+++ linux-bisect/drivers/tty/serial/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel serial device drivers.
 #
 
-obj-$(CONFIG_SERIAL_CORE) += serial_core.o
+obj-$(CONFIG_SERIAL_CORE) += serial_base.o serial_core.o serial_ctrl.o serial_port.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_SEMIHOST) += earlycon-semihost.o
Index: linux-bisect/drivers/tty/serial/serial_base.c
===================================================================
--- /dev/null
+++ linux-bisect/drivers/tty/serial/serial_base.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Serial core base layer for controllers
+ *
+ * The serial core bus manages the serial core controller instances.
+ */
+
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "serial_base.h"
+
+struct serial_base_device {
+	struct device dev;
+	struct uart_port *port;
+};
+
+#define to_serial_base_device(d) container_of((d), struct serial_base_device, dev)
+
+struct uart_port *serial_base_get_port(struct device *dev)
+{
+	struct serial_base_device *sbd;
+
+	if (!dev)
+		return NULL;
+
+	sbd = to_serial_base_device(dev);
+
+	/* Check in case serial_core_add_one_port() happened to fail */
+	if (!sbd->port->state) {
+		dev_warn(dev, "unintialized serial port?\n");
+		return NULL;
+	}
+
+	return sbd->port;
+}
+EXPORT_SYMBOL_NS(serial_base_get_port, SERIAL_BASE);
+
+static int serial_base_match(struct device *dev, struct device_driver *drv)
+{
+	int len = strlen(drv->name);
+
+	return !strncmp(dev_name(dev), drv->name, len);
+}
+
+static struct bus_type serial_base_bus_type = {
+	.name = "serial-base",
+	.match = serial_base_match,
+};
+
+int serial_base_driver_register(struct device_driver *driver)
+{
+	driver->bus = &serial_base_bus_type;
+
+	return driver_register(driver);
+}
+EXPORT_SYMBOL_NS(serial_base_driver_register, SERIAL_BASE);
+
+void serial_base_driver_unregister(struct device_driver *driver)
+{
+	driver_unregister(driver);
+}
+EXPORT_SYMBOL_NS(serial_base_driver_unregister, SERIAL_BASE);
+
+static void serial_base_release(struct device *dev)
+{
+	struct serial_base_device *sbd = to_serial_base_device(dev);
+
+	kfree_const(sbd->dev.kobj.name);
+	kfree(sbd);
+}
+
+struct device *serial_base_device_add(struct uart_port *port, const char *name,
+				      struct device *parent_dev)
+{
+	struct serial_base_device *sbd;
+	int err, id;
+
+	sbd = kzalloc(sizeof(*sbd), GFP_KERNEL);
+	if (!sbd)
+		return NULL;
+
+	device_initialize(&sbd->dev);
+	sbd->dev.parent = parent_dev;
+	sbd->dev.bus = &serial_base_bus_type;
+	sbd->dev.release = &serial_base_release;
+
+	if (str_has_prefix(name, "ctrl")) {
+		id = port->ctrl_id;
+	} else {
+		id = port->line;
+		sbd->port = port;
+	}
+
+	err = dev_set_name(&sbd->dev, "%s.%s.%d", name, dev_name(port->dev), id);
+	if (err)
+		goto err_free_dev;
+
+	err = device_add(&sbd->dev);
+	if (err)
+		goto err_put_device;
+
+	return &sbd->dev;
+
+err_put_device:
+	put_device(&sbd->dev);
+	kfree_const(sbd->dev.kobj.name);
+
+err_free_dev:
+	kfree(sbd);
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS(serial_base_device_add, SERIAL_BASE);
+
+void serial_base_device_remove(struct device *dev)
+{
+	if (!dev)
+		return;
+
+	device_del(dev);
+}
+EXPORT_SYMBOL_NS(serial_base_device_remove, SERIAL_BASE);
+
+static int serial_base_init(void)
+{
+	return bus_register(&serial_base_bus_type);
+}
+module_init(serial_base_init);
+
+static void serial_base_exit(void)
+{
+	bus_unregister(&serial_base_bus_type);
+}
+module_exit(serial_base_exit);
+
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("Serial core bus");
+MODULE_LICENSE("GPL");
Index: linux-bisect/drivers/tty/serial/serial_base.h
===================================================================
--- /dev/null
+++ linux-bisect/drivers/tty/serial/serial_base.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Serial core related functions, serial port device drivers do not need this. */
+
+struct uart_driver;
+struct uart_port;
+struct device_driver;
+struct device;
+
+int serial_base_driver_register(struct device_driver *driver);
+void serial_base_driver_unregister(struct device_driver *driver);
+struct device *serial_base_device_add(struct uart_port *port, const char *name,
+				      struct device *parent_dev);
+void serial_base_device_remove(struct device *dev);
+struct uart_port *serial_base_get_port(struct device *dev);
+
+int serial_ctrl_register_port(struct uart_driver *drv, struct uart_port *port);
+void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port);
+
+int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
+void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
Index: linux-bisect/drivers/tty/serial/serial_core.c
===================================================================
--- linux-bisect.orig/drivers/tty/serial/serial_core.c
+++ linux-bisect/drivers/tty/serial/serial_core.c
@@ -17,6 +17,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
@@ -31,6 +32,8 @@
 #include <linux/irq.h>
 #include <linux/uaccess.h>
 
+#include "serial_base.h"
+
 /*
  * This is used to lock changes in serial line configuration.
  */
@@ -134,9 +137,30 @@ static void __uart_start(struct tty_stru
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
+	struct device *port_dev;
+	int err;
+
+	if (!port || uart_tx_stopped(port))
+		return;
+
+	port_dev = port->port_dev;
+
+	/* Increment the runtime PM usage count for the active check below */
+	err = pm_runtime_get(port_dev);
+	if (err < 0) {
+		pm_runtime_put_noidle(port_dev);
+		return;
+	}
 
-	if (port && !uart_tx_stopped(port))
+	/*
+	 * Start TX if enabled, and kick runtime PM. If the device is not
+	 * enabled, serial_port_runtime_resume() calls start_tx() again
+	 * after enabling the device.
+	 */
+	if (pm_runtime_active(port_dev))
 		port->ops->start_tx(port);
+	pm_runtime_mark_last_busy(port_dev);
+	pm_runtime_put_autosuspend(port_dev);
 }
 
 static void uart_start(struct tty_struct *tty)
@@ -3036,7 +3060,7 @@ static const struct attribute_group tty_
 };
 
 /**
- * uart_add_one_port - attach a driver-defined port structure
+ * serial_core_add_one_port - attach a driver-defined port structure
  * @drv: pointer to the uart low level driver structure for this port
  * @uport: uart port structure to use for this port.
  *
@@ -3046,7 +3070,7 @@ static const struct attribute_group tty_
  * core driver. The main purpose is to allow the low level uart drivers to
  * expand uart_port, rather than having yet more levels of structures.
  */
-int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
+static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
 	struct uart_state *state;
 	struct tty_port *port;
@@ -3136,10 +3160,9 @@ int uart_add_one_port(struct uart_driver
 
 	return ret;
 }
-EXPORT_SYMBOL(uart_add_one_port);
 
 /**
- * uart_remove_one_port - detach a driver defined port structure
+ * serial_core_remove_one_port - detach a driver defined port structure
  * @drv: pointer to the uart low level driver structure for this port
  * @uport: uart port structure for this port
  *
@@ -3148,7 +3171,8 @@ EXPORT_SYMBOL(uart_add_one_port);
  * This unhooks (and hangs up) the specified port structure from the core
  * driver. No further calls will be made to the low-level code for this port.
  */
-int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
+static int serial_core_remove_one_port(struct uart_driver *drv,
+				       struct uart_port *uport)
 {
 	struct uart_state *state = drv->state + uport->line;
 	struct tty_port *port = &state->port;
@@ -3205,6 +3229,8 @@ int uart_remove_one_port(struct uart_dri
 	 * Indicate that there isn't a port here anymore.
 	 */
 	uport->type = PORT_UNKNOWN;
+	uport->port_dev = NULL;
+	uport->ctrl_id = -ENODEV;
 
 	mutex_lock(&port->mutex);
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
@@ -3216,7 +3242,6 @@ out:
 
 	return ret;
 }
-EXPORT_SYMBOL(uart_remove_one_port);
 
 /**
  * uart_match_port - are the two ports equivalent?
@@ -3251,6 +3276,127 @@ bool uart_match_port(const struct uart_p
 }
 EXPORT_SYMBOL(uart_match_port);
 
+/*
+ * Find a registered serial core controller device if one exists. Returns
+ * the first device matching the ctrl_id. Caller must hold port_mutex.
+ */
+static struct device *serial_core_ctrl_find(struct uart_driver *drv,
+					    struct device *phys_dev,
+					    int ctrl_id)
+{
+	struct uart_state *state;
+	int i;
+
+	if (ctrl_id < 0)
+		return NULL;
+
+	lockdep_assert_held(&port_mutex);
+
+	for (i = 0; i < drv->nr; i++) {
+		state = drv->state + i;
+		if (!state->uart_port || !state->uart_port->port_dev)
+			continue;
+
+		if (state->uart_port->dev == phys_dev &&
+		    state->uart_port->ctrl_id == ctrl_id)
+			return state->uart_port->port_dev->parent;
+	}
+
+	return NULL;
+}
+
+static struct device *serial_core_ctrl_device_add(struct uart_port *port)
+{
+	return serial_base_device_add(port, "ctrl", port->dev);
+}
+
+static int serial_core_port_device_add(struct device *ctrl_dev, struct uart_port *port)
+{
+	struct device *dev;
+
+	dev = serial_base_device_add(port, "port", ctrl_dev);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	port->port_dev = dev;
+
+	return 0;
+}
+
+/*
+ * Initialize a serial core port device, and a controller device if needed.
+ */
+int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
+{
+	struct device *ctrl_dev, *new_ctrl_dev = NULL;
+	int ret;
+
+	mutex_lock(&port_mutex);
+
+	/* Inititalize a serial core controller device if needed */
+	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
+	if (!ctrl_dev) {
+		new_ctrl_dev = serial_core_ctrl_device_add(port);
+		if (!new_ctrl_dev) {
+			ret = -ENODEV;
+			goto err_unlock;
+		}
+		ctrl_dev = new_ctrl_dev;
+	}
+
+	/* Initialize a serial core port device */
+	ret = serial_core_port_device_add(ctrl_dev, port);
+	if (ret)
+		goto err_unregister_ctrl_dev;
+
+	mutex_unlock(&port_mutex);
+
+	ret = serial_core_add_one_port(drv, port);
+	if (ret)
+		goto err_unregister_port_dev;
+
+	return 0;
+
+err_unregister_port_dev:
+	mutex_lock(&port_mutex);
+	serial_base_device_remove(port->port_dev);
+
+err_unregister_ctrl_dev:
+	serial_base_device_remove(new_ctrl_dev);
+
+err_unlock:
+	mutex_unlock(&port_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS(serial_core_register_port, SERIAL_BASE);
+
+/*
+ * Removes a serial core port device, and the related serial core controller
+ * device if the last instance.
+ */
+void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port)
+{
+	struct device *phys_dev = port->dev;
+	struct device *port_dev = port->port_dev;
+	struct device *ctrl_dev = port_dev->parent;
+	int ctrl_id = port->ctrl_id;
+
+	serial_core_remove_one_port(drv, port);
+
+	mutex_lock(&port_mutex);
+
+	/* Note that struct uart_port *port is no longer valid at this point */
+	serial_base_device_remove(port_dev);
+
+	/* Drop the serial core controller device if no ports are using it */
+	if (!serial_core_ctrl_find(drv, phys_dev, ctrl_id))
+		serial_base_device_remove(ctrl_dev);
+
+	mutex_unlock(&port_mutex);
+}
+EXPORT_SYMBOL_NS(serial_core_unregister_port, SERIAL_BASE);
+
 /**
  * uart_handle_dcd_change - handle a change of carrier detect state
  * @uport: uart_port structure for the open port
Index: linux-bisect/drivers/tty/serial/serial_ctrl.c
===================================================================
--- /dev/null
+++ linux-bisect/drivers/tty/serial/serial_ctrl.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Serial core controller driver
+ *
+ * This driver manages the serial core controller struct device instances.
+ * The serial core controller devices are children of the physical serial
+ * port device.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/serial_core.h>
+#include <linux/spinlock.h>
+
+#include "serial_base.h"
+
+static int serial_ctrl_probe(struct device *dev)
+{
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int serial_ctrl_remove(struct device *dev)
+{
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+/*
+ * Serial core controller device init functions. Note that the physical
+ * serial port device driver may not have completed probe at this point.
+ */
+int serial_ctrl_register_port(struct uart_driver *drv, struct uart_port *port)
+{
+	return serial_core_register_port(drv, port);
+}
+EXPORT_SYMBOL_NS(serial_ctrl_register_port, SERIAL_BASE);
+
+void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port)
+{
+	serial_core_unregister_port(drv, port);
+}
+EXPORT_SYMBOL_NS(serial_ctrl_unregister_port, SERIAL_BASE);
+
+static struct device_driver serial_ctrl_driver = {
+	.name = "ctrl",
+	.suppress_bind_attrs = true,
+	.probe = serial_ctrl_probe,
+	.remove = serial_ctrl_remove,
+};
+
+static int serial_ctrl_init(void)
+{
+	return serial_base_driver_register(&serial_ctrl_driver);
+}
+module_init(serial_ctrl_init);
+
+static void serial_ctrl_exit(void)
+{
+	serial_base_driver_unregister(&serial_ctrl_driver);
+}
+module_exit(serial_ctrl_exit);
+
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("Serial core controller driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SERIAL_CORE);
Index: linux-bisect/drivers/tty/serial/serial_port.c
===================================================================
--- /dev/null
+++ linux-bisect/drivers/tty/serial/serial_port.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Serial core port device driver
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/serial_core.h>
+#include <linux/spinlock.h>
+
+#include "serial_base.h"
+
+#define SERIAL_PORT_AUTOSUSPEND_DELAY_MS	500
+
+/* Only considers pending TX for now. Caller must take care of locking */
+static int __serial_port_busy(struct uart_port *port)
+{
+	return !uart_tx_stopped(port) &&
+		uart_circ_chars_pending(&port->state->xmit);
+}
+
+static int serial_port_runtime_resume(struct device *dev)
+{
+	struct uart_port *port;
+	unsigned long flags;
+
+	port = serial_base_get_port(dev);
+	if (!port)
+		return 0;
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
+static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm, NULL,
+				 serial_port_runtime_resume, NULL);
+
+static int serial_port_probe(struct device *dev)
+{
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, SERIAL_PORT_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	return 0;
+}
+
+static int serial_port_remove(struct device *dev)
+{
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+/*
+ * Serial core port device init functions. Note that the physical serial
+ * port device driver may not have completed probe at this point.
+ */
+int uart_add_one_port(struct uart_driver *drv, struct uart_port *port)
+{
+	return serial_ctrl_register_port(drv, port);
+}
+EXPORT_SYMBOL(uart_add_one_port);
+
+int uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
+{
+	serial_ctrl_unregister_port(drv, port);
+
+	return 0;
+}
+EXPORT_SYMBOL(uart_remove_one_port);
+
+static struct device_driver serial_port_driver = {
+	.name = "port",
+	.suppress_bind_attrs = true,
+	.probe = serial_port_probe,
+	.remove = serial_port_remove,
+	.pm = pm_ptr(&serial_port_pm),
+};
+
+static int serial_port_init(void)
+{
+	return serial_base_driver_register(&serial_port_driver);
+}
+module_init(serial_port_init);
+
+static void serial_port_exit(void)
+{
+	serial_base_driver_unregister(&serial_port_driver);
+}
+module_exit(serial_port_exit);
+
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("Serial controller port driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SERIAL_CORE);
Index: linux-bisect/include/linux/serial_core.h
===================================================================
--- linux-bisect.orig/include/linux/serial_core.h
+++ linux-bisect/include/linux/serial_core.h
@@ -458,6 +458,7 @@ struct uart_port {
 						struct serial_rs485 *rs485);
 	int			(*iso7816_config)(struct uart_port *,
 						  struct serial_iso7816 *iso7816);
+	int			ctrl_id;		/* optional serial core controller id */
 	unsigned int		irq;			/* irq number */
 	unsigned long		irqflags;		/* irq flags  */
 	unsigned int		uartclk;		/* base uart clock */
@@ -563,7 +564,8 @@ struct uart_port {
 	unsigned int		minor;
 	resource_size_t		mapbase;		/* for ioremap */
 	resource_size_t		mapsize;
-	struct device		*dev;			/* parent device */
+	struct device		*dev;			/* serial port physical parent device */
+	struct device		*port_dev;		/* serial core port device */
 
 	unsigned long		sysrq;			/* sysrq timeout */
 	unsigned int		sysrq_ch;		/* char for sysrq */
