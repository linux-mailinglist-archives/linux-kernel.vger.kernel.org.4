Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5E6B1F23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCII7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCII7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:59:21 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99BB5199F5;
        Thu,  9 Mar 2023 00:57:37 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 1D3E580DE;
        Thu,  9 Mar 2023 08:57:34 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 1/1] serial: core: Start managing serial controllers to enable runtime PM
Date:   Thu,  9 Mar 2023 10:57:08 +0200
Message-Id: <20230309085713.57700-1-tony@atomide.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

We need to also update the documentation a bit as suggested by Andy.

With the serial core port device we can now flush pending TX on the
runtime PM resume as suggested by Johan.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Suggested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

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
 .../firmware-guide/acpi/enumeration.rst       |   5 +-
 drivers/tty/serial/8250/8250_core.c           |   1 +
 drivers/tty/serial/Makefile                   |   2 +-
 drivers/tty/serial/serial_base.c              |  98 ++++++++++
 drivers/tty/serial/serial_base.h              |  27 +++
 drivers/tty/serial/serial_core.c              | 176 +++++++++++++++++-
 drivers/tty/serial/serial_ctrl.c              |  72 +++++++
 drivers/tty/serial/serial_port.c              | 101 ++++++++++
 include/linux/serial_core.h                   |   4 +-
 9 files changed, 474 insertions(+), 12 deletions(-)
 create mode 100644 drivers/tty/serial/serial_base.c
 create mode 100644 drivers/tty/serial/serial_base.h
 create mode 100644 drivers/tty/serial/serial_ctrl.c
 create mode 100644 drivers/tty/serial/serial_port.c

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -19,9 +19,8 @@ possible we decided to do following:
     platform devices.
 
   - Devices behind real busses where there is a connector resource
-    are represented as struct spi_device or struct i2c_device. Note
-    that standard UARTs are not busses so there is no struct uart_device,
-    although some of them may be represented by struct serdev_device.
+    are represented as struct spi_device, struct i2c_device or
+    struct serdev_device.
 
 As both ACPI and Device Tree represent a tree of devices (and their
 resources) this implementation follows the Device Tree way as much as
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -996,6 +996,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		if (uart->port.dev)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
 
+		uart->port.ctrl_id	= up->port.ctrl_id;
 		uart->port.iobase       = up->port.iobase;
 		uart->port.membase      = up->port.membase;
 		uart->port.irq          = up->port.irq;
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel serial device drivers.
 #
 
-obj-$(CONFIG_SERIAL_CORE) += serial_core.o
+obj-$(CONFIG_SERIAL_CORE) += serial_base.o serial_core.o serial_ctrl.o serial_port.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_SEMIHOST) += earlycon-semihost.o
diff --git a/drivers/tty/serial/serial_base.c b/drivers/tty/serial/serial_base.c
new file mode 100644
--- /dev/null
+++ b/drivers/tty/serial/serial_base.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Serial core base layer for controllers
+ *
+ * The serial core bus manages the serial core controller instances.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+
+#include "serial_base.h"
+
+static int serial_base_match(struct device *dev, struct device_driver *drv)
+{
+	int len = strlen(drv->name);
+
+	return (strncmp(dev_name(dev), drv->name, len) == 0);
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
+EXPORT_SYMBOL_GPL(serial_base_driver_register);
+
+void serial_base_driver_unregister(struct device_driver *driver)
+{
+	driver_unregister(driver);
+}
+EXPORT_SYMBOL_GPL(serial_base_driver_unregister);
+
+struct serial_base_device *serial_base_device_add(struct uart_port *port,
+						  const char *name,
+						  struct device *parent_dev)
+{
+	struct serial_base_device *dev;
+	int ret, id;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	device_initialize(&dev->dev);
+	dev->dev.parent = parent_dev;
+	dev->dev.bus = &serial_base_bus_type;
+
+	if (!strncmp(name, "ctrl", 4)) {
+		id = port->ctrl_id;
+	} else {
+		id = port->line;
+		dev->port = port;
+	}
+
+	dev_set_name(&dev->dev, "%s.%s.%d", name, dev_name(port->dev), id);
+
+	ret = device_add(&dev->dev);
+	if (ret) {
+		kfree(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(serial_base_device_add);
+
+void serial_base_device_remove(struct serial_base_device *dev)
+{
+	device_del(&dev->dev);
+	kfree(dev);
+}
+EXPORT_SYMBOL_GPL(serial_base_device_remove);
+
+static int serial_base_init(void)
+{
+	return bus_register(&serial_base_bus_type);
+}
+
+static void serial_base_exit(void)
+{
+	bus_unregister(&serial_base_bus_type);
+}
+
+module_init(serial_base_init);
+module_exit(serial_base_exit);
+
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("Serial core bus");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
new file mode 100644
--- /dev/null
+++ b/drivers/tty/serial/serial_base.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Serial core related functions, serial port device drivers do not need this. */
+
+struct device;
+struct uart_driver;
+struct uart_port;
+
+struct serial_base_device {
+	struct device dev;
+	struct uart_port *port;
+};
+
+#define to_serial_base_device(x) container_of((x), struct serial_base_device, dev)
+
+extern int serial_base_driver_register(struct device_driver *driver);
+extern void serial_base_driver_unregister(struct device_driver *driver);
+extern struct serial_base_device *serial_base_device_add(struct uart_port *port,
+							 const char *name,
+							 struct device *parent_dev);
+extern void serial_base_device_remove(struct serial_base_device *dev);
+
+extern int serial_ctrl_register_port(struct uart_driver *drv, struct uart_port *port);
+extern void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port);
+
+extern int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
+extern void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
@@ -30,6 +31,8 @@
 #include <linux/irq.h>
 #include <linux/uaccess.h>
 
+#include "serial_base.h"
+
 /*
  * This is used to lock changes in serial line configuration.
  */
@@ -136,9 +139,31 @@ static void __uart_start(struct tty_struct *tty)
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
+	err = pm_runtime_get(port_dev);
+	if (err < 0) {
+		/* Something went wrong, attempt to start TX anyways */
+		port->ops->start_tx(port);
+		pm_runtime_put_noidle(port_dev);
+		return;
+	}
 
-	if (port && !uart_tx_stopped(port))
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
@@ -3039,7 +3064,7 @@ static const struct attribute_group tty_dev_attr_group = {
 };
 
 /**
- * uart_add_one_port - attach a driver-defined port structure
+ * serial_core_add_one_port - attach a driver-defined port structure
  * @drv: pointer to the uart low level driver structure for this port
  * @uport: uart port structure to use for this port.
  *
@@ -3049,7 +3074,7 @@ static const struct attribute_group tty_dev_attr_group = {
  * core driver. The main purpose is to allow the low level uart drivers to
  * expand uart_port, rather than having yet more levels of structures.
  */
-int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
+static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
 	struct uart_state *state;
 	struct tty_port *port;
@@ -3139,10 +3164,9 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	return ret;
 }
-EXPORT_SYMBOL(uart_add_one_port);
 
 /**
- * uart_remove_one_port - detach a driver defined port structure
+ * serial_core_remove_one_port - detach a driver defined port structure
  * @drv: pointer to the uart low level driver structure for this port
  * @uport: uart port structure for this port
  *
@@ -3151,7 +3175,8 @@ EXPORT_SYMBOL(uart_add_one_port);
  * This unhooks (and hangs up) the specified port structure from the core
  * driver. No further calls will be made to the low-level code for this port.
  */
-int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
+static int serial_core_remove_one_port(struct uart_driver *drv,
+				       struct uart_port *uport)
 {
 	struct uart_state *state = drv->state + uport->line;
 	struct tty_port *port = &state->port;
@@ -3208,6 +3233,8 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 * Indicate that there isn't a port here anymore.
 	 */
 	uport->type = PORT_UNKNOWN;
+	uport->port_dev = NULL;
+	uport->ctrl_id = -ENODEV;
 
 	mutex_lock(&port->mutex);
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
@@ -3219,7 +3246,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	return ret;
 }
-EXPORT_SYMBOL(uart_remove_one_port);
 
 /**
  * uart_match_port - are the two ports equivalent?
@@ -3254,6 +3280,142 @@ bool uart_match_port(const struct uart_port *port1,
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
+	struct serial_base_device *dev;
+
+	dev = serial_base_device_add(port, "ctrl", port->dev);
+	if (IS_ERR(dev))
+		return NULL;
+
+	return &dev->dev;
+}
+
+static int serial_core_port_device_add(struct device *ctrl_dev, struct uart_port *port)
+{
+	struct serial_base_device *dev;
+
+	dev = serial_base_device_add(port, "port", ctrl_dev);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	port->port_dev = &dev->dev;
+
+	return 0;
+}
+
+static void serial_core_port_device_remove(struct device *port_dev)
+{
+	struct serial_base_device *dev = to_serial_base_device(port_dev);
+
+	serial_base_device_remove(dev);
+}
+
+/*
+ * Initialize a serial core port device, and a controller device if needed.
+ */
+int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
+{
+	struct device *ctrl_dev;
+	bool added = false;
+	int ret;
+
+	mutex_lock(&port_mutex);
+
+	/* Inititalize a serial core controller device if needed */
+	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
+	if (!ctrl_dev) {
+		ctrl_dev = serial_core_ctrl_device_add(port);
+		if (!ctrl_dev) {
+			ret = -ENODEV;
+			goto err_unlock;
+		}
+		added = true;
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
+	serial_core_port_device_remove(port->port_dev);
+
+err_unregister_ctrl_dev:
+	if (added)
+		serial_base_device_remove(to_serial_base_device(ctrl_dev));
+
+err_unlock:
+	mutex_unlock(&port_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS(serial_core_register_port, SERIAL_CORE);
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
+	serial_core_port_device_remove(port_dev);
+
+	/* Drop the serial core controller device if no ports are using it */
+	if (!serial_core_ctrl_find(drv, phys_dev, ctrl_id))
+		serial_base_device_remove(to_serial_base_device(ctrl_dev));
+
+	mutex_unlock(&port_mutex);
+}
+EXPORT_SYMBOL_NS(serial_core_unregister_port, SERIAL_CORE);
+
 /**
  * uart_handle_dcd_change - handle a change of carrier detect state
  * @uport: uart_port structure for the open port
diff --git a/drivers/tty/serial/serial_ctrl.c b/drivers/tty/serial/serial_ctrl.c
new file mode 100644
--- /dev/null
+++ b/drivers/tty/serial/serial_ctrl.c
@@ -0,0 +1,72 @@
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
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/serial_core.h>
+
+#include "serial_base.h"
+
+static DEFINE_RUNTIME_DEV_PM_OPS(serial_ctrl_pm, NULL, NULL, NULL);
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
+EXPORT_SYMBOL_NS(serial_ctrl_register_port, SERIAL_CORE);
+
+void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port)
+{
+	serial_core_unregister_port(drv, port);
+}
+EXPORT_SYMBOL_NS(serial_ctrl_unregister_port, SERIAL_CORE);
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
+
+static void serial_ctrl_exit(void)
+{
+	serial_base_driver_unregister(&serial_ctrl_driver);
+}
+
+module_init(serial_ctrl_init);
+module_exit(serial_ctrl_exit);
+
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("Serial core controller driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SERIAL_CORE);
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
new file mode 100644
--- /dev/null
+++ b/drivers/tty/serial/serial_port.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Serial core port device driver
+ */
+
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/serial_core.h>
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
+	struct serial_base_device *scd = to_serial_base_device(dev);
+	struct uart_port *port = scd->port;
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
+static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm, NULL,
+				 serial_port_runtime_resume,
+				 NULL);
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
+
+static void serial_port_exit(void)
+{
+	serial_base_driver_unregister(&serial_port_driver);
+}
+
+module_init(serial_port_init);
+module_exit(serial_port_exit);
+
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("Serial controller port driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SERIAL_CORE);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
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
-- 
2.39.1
