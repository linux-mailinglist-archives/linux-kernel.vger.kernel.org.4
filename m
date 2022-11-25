Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F277638BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKYODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiKYODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:03:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCDA1CB3C;
        Fri, 25 Nov 2022 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669384990; x=1700920990;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2Y/9XdXRQark7DT8SRb7nK7aO6b4EOSkUvrrkHSKpbM=;
  b=KwSR3ds9cg2jKrO3c8B+DMD3eGuupgsQupqDSaac5YqnNVMQythwJzkJ
   nShOk5oz3i7d4HKwo7/WJ9G3KqMR3I3ScWvYHNn7mB5dRQWjKpjRYDiIa
   SIr08ejupyU7DVExaoonwd45UPKRhJBJmTIDFcEJlMvTtYedKPBLrjcZ/
   wDGKOZYLjZsG/I58T+vaFWNHgkyBvzVF98cJJtfldcrcHNgSW4Np3ZUK4
   +4NApUkMTz5ryZ83lMb+UCeWYYOHZ3XNrxWjNOw9UAynN40QZmKkLRGrK
   AkYaNYhUM0Nq0813lkzIl7+62S+Xn8OhJ4Dipiuq6e89FDPKi1/+Vxeb7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="341390779"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="341390779"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 06:02:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="971579845"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="971579845"
Received: from dpotapen-mobl.ger.corp.intel.com ([10.252.50.101])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 06:02:47 -0800
Date:   Fri, 25 Nov 2022 16:02:45 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] serial: core: Start managing serial controllers
 to enable runtime PM
In-Reply-To: <20221123082825.32820-1-tony@atomide.com>
Message-ID: <e6922dd6-8968-b54-afbc-d5ad969f64@linux.intel.com>
References: <20221123082825.32820-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022, Tony Lindgren wrote:

> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> The serial layer has a few challenges to deal with:
> 
> 1. The serial port mapping to a physical serial port controller device
>    is currently not easily available after the physical serial controller
>    struct device gets registered uart_add_one_port() time
> 
> 2. The serial port device drivers have their own driver data. So we cannot
>    currently start making use of serial core generic data easily without
>    changing all the serial port device drivers
> 
> To find the serial ports for a controller based on struct device, let's
> add a new data structure for a serial_controller. On registering a port,
> we can use the drv->state array to find the associated serial port
> controller and initialize the serial core controller.
> 
> As some serial port device drivers enable runtime PM in their probe before
> registering with the serial core layer, and some do not enable runtime PM
> at all currently, we need check the state in the serial core layer on
> uart_port_startup(). We need to also consider that a serial port device
> may have multiple ports.
> 
> Initially we enable runtime PM for all the serial port controller devices.
> This allows us to add runtime PM calls and properly handle any errors
> without a need for serial layer specific runtime PM wrapper functions.
> 
> After this patch no functional changes for the serial port device drivers
> are intended. We just enable runtime PM and keep the runtime PM usage
> count until all the serial controller ports are unregistered. For drivers
> implementing PM runtime, we just keep track of the runtime PM
> configuration.
> 
> For the serial port drivers, the serial core layer has the following use
> cases to deal with:
> 
> 1. If a serial port device driver does not implement runtime PM, the
>    device state is set to active state, and the runtime PM usage count
>    is kept until the last port for a device is unregistered
> 
> 2. If a serial port device driver implements runtime PM, the runtime PM
>    usage count is kept until the last port for the device is unregistered
> 
> 3. If a serial port device driver implements runtime PM autosuspend,
>    autosuspend is not prevented. This currently gets set only for the
>    8250_omap driver to keep runtime PM working for it
> 
> For system suspend, things should be mostly detached from the runtime PM.
> The serial port device drivers may call pm_runtime_force_suspend() and
> pm_runtime_force_resume() as needed.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> Changes since v2:
> 
> - Make each serial port a proper device as suggested by Greg. This is
>   a separate patch that flushes the TX on runtime PM resume
> 
> Changes since v1:
> 
> - Use kref as suggested by Andy
> 
> - Fix memory leak on error as noted by Andy
> 
> - Use use unsigned char for supports_autosuspend as suggested by Andy
> 
> - Coding style improvments as suggested by Andy
> 
> ---
>  drivers/tty/serial/8250/8250_core.c |   1 +
>  drivers/tty/serial/8250/8250_omap.c |   1 +
>  drivers/tty/serial/serial_core.c    | 179 ++++++++++++++++++++++++++++
>  include/linux/serial_core.h         |   4 +
>  4 files changed, 185 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1004,6 +1004,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  		uart->port.regshift     = up->port.regshift;
>  		uart->port.iotype       = up->port.iotype;
>  		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
> +		uart->port.supports_autosuspend = up->port.supports_autosuspend;
>  		uart->bugs		= up->bugs;
>  		uart->port.mapbase      = up->port.mapbase;
>  		uart->port.mapsize      = up->port.mapsize;
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1330,6 +1330,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  	up.rs485_start_tx = serial8250_em485_start_tx;
>  	up.rs485_stop_tx = serial8250_em485_stop_tx;
>  	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> +	up.port.supports_autosuspend = 1;
>  
>  	ret = of_alias_get_id(np, "serial");
>  	if (ret < 0) {
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/console.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
> @@ -30,6 +31,20 @@
>  #include <linux/irq.h>
>  #include <linux/uaccess.h>
>  
> +/*
> + * Serial port device specific data for serial core.
> + *
> + * Each port device can have multiple ports with struct uart_state allocated
> + * for each port. The array of ports is kept in struct uart_driver.
> + */
> +struct serial_controller {
> +	struct device *dev;			/* Physical controller device */
> +	struct uart_driver *drv;		/* For port specific uart_state */
> +	struct kref ref;			/* Registered port count */
> +	unsigned long implements_pm_runtime:1;
> +	unsigned long supports_autosuspend:1;
> +};
> +
>  /*
>   * This is used to lock changes in serial line configuration.
>   */
> @@ -177,6 +192,162 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
>  		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
>  }
>  
> +static struct serial_controller *to_controller(struct uart_port *port)
> +{
> +	if (!port->dev)
> +		return NULL;
> +
> +	return port->state->controller;
> +}
> +
> +/*
> + * Starts runtime PM for the serial controller device if not already started
> + * by the serial port driver. Called from uart_add_one_port() with port_mutex
> + * held.
> + */
> +static int serial_core_pm_runtime_start(struct uart_port *port)
> +{
> +	struct serial_controller *controller = to_controller(port);
> +	struct device *dev = port->dev;
> +	int ret = 0;
> +
> +	if (kref_get_unless_zero(&controller->ref))
> +		return 0;
> +
> +	/* Init controller device on first reference */
> +	kref_init(&controller->ref);
> +
> +	/* Always enable autosuspend and consider child devices for serdev */
> +	pm_runtime_use_autosuspend(dev);
> +	pm_suspend_ignore_children(dev, false);
> +
> +	/*
> +	 * If the port driver did not enable runtime PM in probe, do it now.
> +	 * Devices that did not enable runtime PM get set active so we can
> +	 * properly handle the returned errors for runtime PM calls.
> +	 */
> +	if (!pm_runtime_enabled(dev)) {
> +		pm_runtime_set_active(dev);
> +		pm_runtime_enable(dev);
> +	} else {
> +		controller->implements_pm_runtime = 1;
> +	}
> +
> +	/*
> +	 * Keep the port device enabled unless autosuspend is supported.
> +	 * Released on port shutdown.
> +	 */
> +	if (!controller->supports_autosuspend) {
> +		ret = pm_runtime_resume_and_get(dev);

Should this be done regardless of autosuspend if the port is console?

There's a problem in the current place where this being called from 
though, uart_console_enabled() doesn't return the correct value with at 
least some devices this early:

https://lore.kernel.org/linux-serial/AS8PR04MB84047F39CD10C00CEE29213F92219@AS8PR04MB8404.eurprd04.prod.outlook.com/

-- 
 i.
