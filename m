Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C5F63529D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiKWI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiKWI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:28:36 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 319D014082;
        Wed, 23 Nov 2022 00:28:29 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C178280F1;
        Wed, 23 Nov 2022 08:28:27 +0000 (UTC)
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
Subject: [PATCH v3 1/2] serial: core: Start managing serial controllers to enable runtime PM
Date:   Wed, 23 Nov 2022 10:28:24 +0200
Message-Id: <20221123082825.32820-1-tony@atomide.com>
X-Mailer: git-send-email 2.38.1
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

The serial layer has a few challenges to deal with:

1. The serial port mapping to a physical serial port controller device
   is currently not easily available after the physical serial controller
   struct device gets registered uart_add_one_port() time

2. The serial port device drivers have their own driver data. So we cannot
   currently start making use of serial core generic data easily without
   changing all the serial port device drivers

To find the serial ports for a controller based on struct device, let's
add a new data structure for a serial_controller. On registering a port,
we can use the drv->state array to find the associated serial port
controller and initialize the serial core controller.

As some serial port device drivers enable runtime PM in their probe before
registering with the serial core layer, and some do not enable runtime PM
at all currently, we need check the state in the serial core layer on
uart_port_startup(). We need to also consider that a serial port device
may have multiple ports.

Initially we enable runtime PM for all the serial port controller devices.
This allows us to add runtime PM calls and properly handle any errors
without a need for serial layer specific runtime PM wrapper functions.

After this patch no functional changes for the serial port device drivers
are intended. We just enable runtime PM and keep the runtime PM usage
count until all the serial controller ports are unregistered. For drivers
implementing PM runtime, we just keep track of the runtime PM
configuration.

For the serial port drivers, the serial core layer has the following use
cases to deal with:

1. If a serial port device driver does not implement runtime PM, the
   device state is set to active state, and the runtime PM usage count
   is kept until the last port for a device is unregistered

2. If a serial port device driver implements runtime PM, the runtime PM
   usage count is kept until the last port for the device is unregistered

3. If a serial port device driver implements runtime PM autosuspend,
   autosuspend is not prevented. This currently gets set only for the
   8250_omap driver to keep runtime PM working for it

For system suspend, things should be mostly detached from the runtime PM.
The serial port device drivers may call pm_runtime_force_suspend() and
pm_runtime_force_resume() as needed.

Suggested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
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
 drivers/tty/serial/8250/8250_omap.c |   1 +
 drivers/tty/serial/serial_core.c    | 179 ++++++++++++++++++++++++++++
 include/linux/serial_core.h         |   4 +
 4 files changed, 185 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1004,6 +1004,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.regshift     = up->port.regshift;
 		uart->port.iotype       = up->port.iotype;
 		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+		uart->port.supports_autosuspend = up->port.supports_autosuspend;
 		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.mapsize      = up->port.mapsize;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1330,6 +1330,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.rs485_start_tx = serial8250_em485_start_tx;
 	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	up.port.supports_autosuspend = 1;
 
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
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
@@ -30,6 +31,20 @@
 #include <linux/irq.h>
 #include <linux/uaccess.h>
 
+/*
+ * Serial port device specific data for serial core.
+ *
+ * Each port device can have multiple ports with struct uart_state allocated
+ * for each port. The array of ports is kept in struct uart_driver.
+ */
+struct serial_controller {
+	struct device *dev;			/* Physical controller device */
+	struct uart_driver *drv;		/* For port specific uart_state */
+	struct kref ref;			/* Registered port count */
+	unsigned long implements_pm_runtime:1;
+	unsigned long supports_autosuspend:1;
+};
+
 /*
  * This is used to lock changes in serial line configuration.
  */
@@ -177,6 +192,162 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
 		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 }
 
+static struct serial_controller *to_controller(struct uart_port *port)
+{
+	if (!port->dev)
+		return NULL;
+
+	return port->state->controller;
+}
+
+/*
+ * Starts runtime PM for the serial controller device if not already started
+ * by the serial port driver. Called from uart_add_one_port() with port_mutex
+ * held.
+ */
+static int serial_core_pm_runtime_start(struct uart_port *port)
+{
+	struct serial_controller *controller = to_controller(port);
+	struct device *dev = port->dev;
+	int ret = 0;
+
+	if (kref_get_unless_zero(&controller->ref))
+		return 0;
+
+	/* Init controller device on first reference */
+	kref_init(&controller->ref);
+
+	/* Always enable autosuspend and consider child devices for serdev */
+	pm_runtime_use_autosuspend(dev);
+	pm_suspend_ignore_children(dev, false);
+
+	/*
+	 * If the port driver did not enable runtime PM in probe, do it now.
+	 * Devices that did not enable runtime PM get set active so we can
+	 * properly handle the returned errors for runtime PM calls.
+	 */
+	if (!pm_runtime_enabled(dev)) {
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	} else {
+		controller->implements_pm_runtime = 1;
+	}
+
+	/*
+	 * Keep the port device enabled unless autosuspend is supported.
+	 * Released on port shutdown.
+	 */
+	if (!controller->supports_autosuspend) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			pm_runtime_dont_use_autosuspend(dev);
+			pm_runtime_disable(dev);
+		}
+	}
+
+	return ret;
+}
+
+/* Clean up the runtime PM settings done on serial_core_register_port() */
+static void serial_core_pm_runtime_cleanup(struct kref *ref)
+{
+	struct serial_controller *controller =
+		 container_of(ref, struct serial_controller, ref);
+	struct device *dev = controller->dev;
+
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_suspend_ignore_children(dev, true);
+	if (!controller->supports_autosuspend)
+		pm_runtime_put_sync(dev);
+	if (!controller->implements_pm_runtime) {
+		pm_runtime_set_suspended(dev);
+		pm_runtime_disable(dev);
+	}
+	kfree(controller);
+}
+
+/*
+ * Find the registered serial port controller if one exists. Caller must
+ * hold port_mutex.
+ */
+static struct serial_controller *
+serial_core_find_controller(struct uart_driver *drv, struct device *dev)
+{
+	struct uart_state *state;
+	int i;
+
+	for (i = 0; i < drv->nr; i++) {
+		state = drv->state + i;
+		if (!state->uart_port->dev)
+			continue;
+
+		if (state->uart_port->dev == dev)
+			return state->controller;
+	}
+
+	return NULL;
+}
+
+/*
+ * Initialize a serial port device and serial port controller as
+ * needed. Called from uart_add_one_port() with port_mutex held.
+ */
+static int serial_core_register_port(struct uart_port *port,
+				     struct uart_driver *drv)
+{
+	struct serial_controller *controller;
+	bool allocated = false;
+	int ret;
+
+	if (!port->dev)
+		return 0;
+
+	controller = serial_core_find_controller(drv, port->dev);
+	if (!controller) {
+		controller = kzalloc(sizeof(*controller), GFP_KERNEL);
+		if (!controller)
+			return -ENOMEM;
+
+		controller->drv = drv;
+		controller->dev = port->dev;
+		controller->supports_autosuspend = port->supports_autosuspend;
+		allocated = true;
+	}
+
+	port->state->controller = controller;
+	WARN_ON(port->supports_autosuspend != controller->supports_autosuspend);
+
+	ret = serial_core_pm_runtime_start(port);
+	if (ret < 0)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	port->state->controller = NULL;
+	if (allocated)
+		kfree(controller);
+
+	return ret;
+}
+
+/*
+ * Removes a serial port device and the serial port controller if the last
+ * port instance. Called from uart_add_one_port() error path with port_mutex
+ * held.
+ */
+static void serial_core_unregister_port(struct uart_port *port)
+{
+	struct serial_controller *controller = to_controller(port);
+
+	/* Check for a registered controller, no struct device early on */
+	if (!controller)
+		return;
+
+	port->state->controller = NULL;
+	kref_put(&controller->ref, serial_core_pm_runtime_cleanup);
+}
+
 /*
  * Startup the port.  This will be called once per open.  All calls
  * will be serialised by the per-port mutex.
@@ -3082,6 +3253,10 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 		goto out;
 	}
 
+	ret = serial_core_register_port(uport, drv);
+	if (ret)
+		goto out;
+
 	/*
 	 * If this port is in use as a console then the spinlock is already
 	 * initialised.
@@ -3105,6 +3280,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 				    GFP_KERNEL);
 	if (!uport->tty_groups) {
 		ret = -ENOMEM;
+		serial_core_unregister_port(uport);
 		goto out;
 	}
 	uport->tty_groups[0] = &tty_dev_attr_group;
@@ -3173,6 +3349,9 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 		goto out;
 	}
 	uport->flags |= UPF_DEAD;
+
+	serial_core_unregister_port(uport);
+
 	mutex_unlock(&port->mutex);
 
 	/*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -28,6 +28,7 @@
 
 struct uart_port;
 struct serial_struct;
+struct serial_port_controller;
 struct device;
 struct gpio_desc;
 
@@ -573,6 +574,7 @@ struct uart_port {
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
 	unsigned char		console_reinit;
+	unsigned char		supports_autosuspend;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
@@ -611,6 +613,8 @@ enum uart_pm_state {
 struct uart_state {
 	struct tty_port		port;
 
+	struct serial_controller *controller;
+
 	enum uart_pm_state	pm_state;
 	struct circ_buf		xmit;
 
-- 
2.38.1
