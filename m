Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77783719853
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjFAKG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFAKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:06:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9498B1999;
        Thu,  1 Jun 2023 03:04:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB17C169C;
        Thu,  1 Jun 2023 03:04:52 -0700 (PDT)
Received: from [10.1.26.32] (e122027.cambridge.arm.com [10.1.26.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33E93F663;
        Thu,  1 Jun 2023 03:04:04 -0700 (PDT)
Message-ID: <f44b5fb0-2345-df07-abab-c04abd6f8a13@arm.com>
Date:   Thu, 1 Jun 2023 11:04:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230525113034.46880-1-tony@atomide.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-GB
In-Reply-To: <20230525113034.46880-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This has arrived in linux-next and causes boot warnings, see below.

On 25/05/2023 12:30, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To manage serial controllers, let's set up a struct bus and struct device
> for the serial core controller as suggested by Greg and Jiri. The serial
> core controller devices are children of the physical serial port device.
> The serial core controller device is needed to support multiple different
> kind of ports connected to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
> 
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

...

>  
>  /**
> - * uart_remove_one_port - detach a driver defined port structure
> + * serial_core_remove_one_port - detach a driver defined port structure
>   * @drv: pointer to the uart low level driver structure for this port
>   * @uport: uart port structure for this port
>   *
> @@ -3153,20 +3170,16 @@ EXPORT_SYMBOL(uart_add_one_port);
>   *
>   * This unhooks (and hangs up) the specified port structure from the core
>   * driver. No further calls will be made to the low-level code for this port.
> + * Caller must hold port_mutex.
>   */
> -void uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
> +static void serial_core_remove_one_port(struct uart_driver *drv,
> +					struct uart_port *uport)
>  {
>  	struct uart_state *state = drv->state + uport->line;
>  	struct tty_port *port = &state->port;
>  	struct uart_port *uart_port;
>  	struct tty_struct *tty;
>  
> -	mutex_lock(&port_mutex);

serial_core_remove_one_port() no longer takes port_mutex (caller must
hold it)...

> -
> -	/*
> -	 * Mark the port "dead" - this prevents any opens from
> -	 * succeeding while we shut down the port.
> -	 */
>  	mutex_lock(&port->mutex);
>  	uart_port = uart_port_check(state);
>  	if (uart_port != uport)
> @@ -3177,7 +3190,6 @@ void uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>  		mutex_unlock(&port->mutex);
>  		goto out;
>  	}
> -	uport->flags |= UPF_DEAD;
>  	mutex_unlock(&port->mutex);
>  
>  	/*
> @@ -3209,6 +3221,7 @@ void uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>  	 * Indicate that there isn't a port here anymore.
>  	 */
>  	uport->type = PORT_UNKNOWN;
> +	uport->port_dev = NULL;
>  
>  	mutex_lock(&port->mutex);
>  	WARN_ON(atomic_dec_return(&state->refcount) < 0);
> @@ -3218,7 +3231,6 @@ void uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>  out:
>  	mutex_unlock(&port_mutex);

... but it still drops it at the end of the function.

>  }
> -EXPORT_SYMBOL(uart_remove_one_port);

...

> +/*
> + * Find a registered serial core controller device if one exists. Returns
> + * the first device matching the ctrl_id. Caller must hold port_mutex.
> + */
> +static struct serial_ctrl_device *serial_core_ctrl_find(struct uart_driver *drv,
> +							struct device *phys_dev,
> +							int ctrl_id)
> +{
> +	struct uart_state *state;
> +	int i;
> +
> +	lockdep_assert_held(&port_mutex);

This function must be called with port_mutex held, but...

> +
> +	for (i = 0; i < drv->nr; i++) {
> +		state = drv->state + i;
> +		if (!state->uart_port || !state->uart_port->port_dev)
> +			continue;
> +
> +		if (state->uart_port->dev == phys_dev &&
> +		    state->uart_port->ctrl_id == ctrl_id)
> +			return serial_core_get_ctrl_dev(state->uart_port->port_dev);
> +	}
> +
> +	return NULL;
> +}

...

> +/*
> + * Removes a serial core port device, and the related serial core controller
> + * device if the last instance.
> + */
> +void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port)
> +{
> +	struct device *phys_dev = port->dev;
> +	struct serial_port_device *port_dev = port->port_dev;
> +	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
> +	int ctrl_id = port->ctrl_id;
> +
> +	mutex_lock(&port_mutex);

We take port_mutex here...

> +
> +	port->flags |= UPF_DEAD;
> +
> +	serial_core_remove_one_port(drv, port);
> +
> +	/* Note that struct uart_port *port is no longer valid at this point */
> +	serial_base_port_device_remove(port_dev);

serial_base_port_device_remove() then drops it...

> +
> +	/* Drop the serial core controller device if no ports are using it */
> +	if (!serial_core_ctrl_find(drv, phys_dev, ctrl_id))

serial_core_ctrl_find() complains that it's not held.

> +		serial_base_ctrl_device_remove(ctrl_dev);
> +
> +	mutex_unlock(&port_mutex);

And we attempt to unlock it when it's not held.

I haven't studied this change in detail, but I assume the bug is that
serial_base_port_device_remove() shouldn't be dropping port_mutex. The
below hack gets my board booting again.

Thanks,

Steve

Hack fix:
----8<----
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 29bd5ede0b25..044e4853341a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3234,8 +3234,7 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
        wait_event(state->remove_wait, !atomic_read(&state->refcount));
        state->uart_port = NULL;
        mutex_unlock(&port->mutex);
-out:
-       mutex_unlock(&port_mutex);
+out:;
 }
 
 /**
