Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24106CD635
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjC2JTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjC2JTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98261FF3;
        Wed, 29 Mar 2023 02:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5430661C11;
        Wed, 29 Mar 2023 09:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B59C433EF;
        Wed, 29 Mar 2023 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680081558;
        bh=+oMibk1h4NtIM9bDaurEsNq4OE6u9Rh8IJ/CWXNT3/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7hmJ45ARm58VgntfnEHkUNTHqTKwdLEH7fDbCBlOiKth3YRtD1CWMb0dhvmJZHyG
         tuekN2dsg4qU4+mOW5eHVkWeWcaUuYfc6vHcvM5LrRHPqNZhLps6gAb63pTq9Nwqu3
         gwRqIeuysRx6xdym1DIez8n2PA10Gf2cbKVsjasc=
Date:   Wed, 29 Mar 2023 11:19:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZCQClBeEtSLu2X0U@kroah.com>
References: <20230323071051.2184-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323071051.2184-1-tony@atomide.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:10:47AM +0200, Tony Lindgren wrote:
> -obj-$(CONFIG_SERIAL_CORE) += serial_core.o
> +obj-$(CONFIG_SERIAL_CORE) += serial_base.o serial_core.o serial_ctrl.o serial_port.o

Why is this 3 new modules and not just all go into serial_base?  What's
going to auto-load the other modules you created here?  Feels like this
should all end up in the same .ko as they all depend on each other,
right?

>  
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>  obj-$(CONFIG_SERIAL_EARLYCON_SEMIHOST) += earlycon-semihost.o
> diff --git a/drivers/tty/serial/serial_base.c b/drivers/tty/serial/serial_base.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/tty/serial/serial_base.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Serial core base layer for controllers
> + *
> + * The serial core bus manages the serial core controller instances.
> + */
> +
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include "serial_base.h"
> +
> +struct serial_base_device {
> +	struct device dev;
> +	struct uart_port *port;
> +};
> +
> +#define to_serial_base_device(d) container_of((d), struct serial_base_device, dev)
> +
> +struct uart_port *serial_base_get_port(struct device *dev)
> +{
> +	struct serial_base_device *sbd;
> +
> +	if (!dev)
> +		return NULL;
> +
> +	sbd = to_serial_base_device(dev);
> +
> +	/* Check in case serial_core_add_one_port() happened to fail */
> +	if (!sbd->port->state) {

This is odd, how can it fail and then this function be called after that
failure?

> +		dev_warn(dev, "uninitialized serial port?\n");
> +		return NULL;
> +	}
> +
> +	return sbd->port;
> +}
> +EXPORT_SYMBOL_NS(serial_base_get_port, SERIAL_BASE);
> +
> +static int serial_base_match(struct device *dev, struct device_driver *drv)
> +{
> +	int len = strlen(drv->name);
> +
> +	return !strncmp(dev_name(dev), drv->name, len);
> +}
> +
> +static struct bus_type serial_base_bus_type = {
> +	.name = "serial-base",
> +	.match = serial_base_match,
> +};
> +
> +int serial_base_driver_register(struct device_driver *driver)
> +{
> +	driver->bus = &serial_base_bus_type;
> +
> +	return driver_register(driver);
> +}
> +EXPORT_SYMBOL_NS(serial_base_driver_register, SERIAL_BASE);
> +
> +void serial_base_driver_unregister(struct device_driver *driver)
> +{
> +	driver_unregister(driver);
> +}
> +EXPORT_SYMBOL_NS(serial_base_driver_unregister, SERIAL_BASE);
> +
> +static void serial_base_release(struct device *dev)
> +{
> +	struct serial_base_device *sbd = to_serial_base_device(dev);
> +
> +	kfree(sbd);
> +}
> +
> +struct device *serial_base_device_add(struct uart_port *port, const char *name,
> +				      struct device *parent_dev)
> +{
> +	struct serial_base_device *sbd;
> +	int err, id;
> +
> +	sbd = kzalloc(sizeof(*sbd), GFP_KERNEL);
> +	if (!sbd)
> +		return NULL;
> +
> +	device_initialize(&sbd->dev);
> +	sbd->dev.parent = parent_dev;
> +	sbd->dev.bus = &serial_base_bus_type;
> +	sbd->dev.release = &serial_base_release;
> +
> +	if (str_has_prefix(name, "ctrl")) {

That's a magic string, shouldn't it be documented somewhere?

> +		id = port->ctrl_id;
> +	} else {
> +		id = port->line;
> +		sbd->port = port;
> +	}
> +
> +	err = dev_set_name(&sbd->dev, "%s.%s.%d", name, dev_name(port->dev), id);
> +	if (err)
> +		goto err_free_dev;
> +
> +	err = device_add(&sbd->dev);
> +	if (err)
> +		goto err_put_device;
> +
> +	return &sbd->dev;
> +
> +err_put_device:
> +	put_device(&sbd->dev);
> +
> +err_free_dev:
> +	kfree(sbd);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS(serial_base_device_add, SERIAL_BASE);
> +
> +void serial_base_device_remove(struct device *dev)
> +{
> +	if (!dev)
> +		return;
> +
> +	device_del(dev);
> +}
> +EXPORT_SYMBOL_NS(serial_base_device_remove, SERIAL_BASE);
> +
> +static int serial_base_init(void)
> +{
> +	return bus_register(&serial_base_bus_type);
> +}
> +module_init(serial_base_init);
> +
> +static void serial_base_exit(void)
> +{
> +	bus_unregister(&serial_base_bus_type);
> +}
> +module_exit(serial_base_exit);
> +
> +MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
> +MODULE_DESCRIPTION("Serial core bus");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> new file mode 100644
> --- /dev/null
> +++ b/drivers/tty/serial/serial_base.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* Serial core related functions, serial port device drivers do not need this. */
> +
> +struct uart_driver;
> +struct uart_port;
> +struct device_driver;
> +struct device;
> +
> +int serial_base_driver_register(struct device_driver *driver);
> +void serial_base_driver_unregister(struct device_driver *driver);
> +struct device *serial_base_device_add(struct uart_port *port, const char *name,
> +				      struct device *parent_dev);
> +void serial_base_device_remove(struct device *dev);
> +struct uart_port *serial_base_get_port(struct device *dev);
> +
> +int serial_ctrl_register_port(struct uart_driver *drv, struct uart_port *port);
> +void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port);
> +
> +int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
> +void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -17,6 +17,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
> @@ -31,6 +32,8 @@
>  #include <linux/irq.h>
>  #include <linux/uaccess.h>
>  
> +#include "serial_base.h"
> +
>  /*
>   * This is used to lock changes in serial line configuration.
>   */
> @@ -134,9 +137,30 @@ static void __uart_start(struct tty_struct *tty)
>  {
>  	struct uart_state *state = tty->driver_data;
>  	struct uart_port *port = state->uart_port;
> +	struct device *port_dev;
> +	int err;
> +
> +	if (!port || uart_tx_stopped(port))
> +		return;
> +
> +	port_dev = port->port_dev;
> +
> +	/* Increment the runtime PM usage count for the active check below */
> +	err = pm_runtime_get(port_dev);
> +	if (err < 0) {
> +		pm_runtime_put_noidle(port_dev);
> +		return;
> +	}
>  
> -	if (port && !uart_tx_stopped(port))
> +	/*
> +	 * Start TX if enabled, and kick runtime PM. If the device is not
> +	 * enabled, serial_port_runtime_resume() calls start_tx() again
> +	 * after enabling the device.
> +	 */
> +	if (pm_runtime_active(port_dev))
>  		port->ops->start_tx(port);
> +	pm_runtime_mark_last_busy(port_dev);
> +	pm_runtime_put_autosuspend(port_dev);
>  }
>  
>  static void uart_start(struct tty_struct *tty)
> @@ -3036,7 +3060,7 @@ static const struct attribute_group tty_dev_attr_group = {
>  };
>  
>  /**
> - * uart_add_one_port - attach a driver-defined port structure
> + * serial_core_add_one_port - attach a driver-defined port structure
>   * @drv: pointer to the uart low level driver structure for this port
>   * @uport: uart port structure to use for this port.
>   *
> @@ -3046,7 +3070,7 @@ static const struct attribute_group tty_dev_attr_group = {
>   * core driver. The main purpose is to allow the low level uart drivers to
>   * expand uart_port, rather than having yet more levels of structures.
>   */
> -int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
> +static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  {
>  	struct uart_state *state;
>  	struct tty_port *port;
> @@ -3136,10 +3160,9 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(uart_add_one_port);
>  
>  /**
> - * uart_remove_one_port - detach a driver defined port structure
> + * serial_core_remove_one_port - detach a driver defined port structure
>   * @drv: pointer to the uart low level driver structure for this port
>   * @uport: uart port structure for this port
>   *
> @@ -3148,7 +3171,8 @@ EXPORT_SYMBOL(uart_add_one_port);
>   * This unhooks (and hangs up) the specified port structure from the core
>   * driver. No further calls will be made to the low-level code for this port.
>   */
> -int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
> +static int serial_core_remove_one_port(struct uart_driver *drv,
> +				       struct uart_port *uport)
>  {
>  	struct uart_state *state = drv->state + uport->line;
>  	struct tty_port *port = &state->port;
> @@ -3205,6 +3229,8 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>  	 * Indicate that there isn't a port here anymore.
>  	 */
>  	uport->type = PORT_UNKNOWN;
> +	uport->port_dev = NULL;
> +	uport->ctrl_id = -ENODEV;
>  
>  	mutex_lock(&port->mutex);
>  	WARN_ON(atomic_dec_return(&state->refcount) < 0);
> @@ -3216,7 +3242,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(uart_remove_one_port);
>  
>  /**
>   * uart_match_port - are the two ports equivalent?
> @@ -3251,6 +3276,127 @@ bool uart_match_port(const struct uart_port *port1,
>  }
>  EXPORT_SYMBOL(uart_match_port);
>  
> +/*
> + * Find a registered serial core controller device if one exists. Returns
> + * the first device matching the ctrl_id. Caller must hold port_mutex.
> + */
> +static struct device *serial_core_ctrl_find(struct uart_driver *drv,
> +					    struct device *phys_dev,
> +					    int ctrl_id)
> +{
> +	struct uart_state *state;
> +	int i;
> +
> +	if (ctrl_id < 0)
> +		return NULL;

Why is a negative number special here?


> +
> +	lockdep_assert_held(&port_mutex);
> +
> +	for (i = 0; i < drv->nr; i++) {
> +		state = drv->state + i;
> +		if (!state->uart_port || !state->uart_port->port_dev)
> +			continue;
> +
> +		if (state->uart_port->dev == phys_dev &&
> +		    state->uart_port->ctrl_id == ctrl_id)
> +			return state->uart_port->port_dev->parent;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct device *serial_core_ctrl_device_add(struct uart_port *port)
> +{
> +	return serial_base_device_add(port, "ctrl", port->dev);
> +}
> +
> +static int serial_core_port_device_add(struct device *ctrl_dev, struct uart_port *port)
> +{
> +	struct device *dev;
> +
> +	dev = serial_base_device_add(port, "port", ctrl_dev);

magic strings again :)

Do you really just want two different "types" of devices on this bus,
controllers and ports?  If so, just do that, don't make the name magic
here.

Then you can have:
	serial_base_port_add()
	serial_base_ctrl_add()

and one cleanup function will still work.

Otherwise this looks good to me, thanks for doing all of this work.

greg k-h
