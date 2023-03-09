Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669576B240C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCIMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCIMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:23:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EB55678A;
        Thu,  9 Mar 2023 04:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678364597; x=1709900597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zrQ6SdmoAtu1iTJKI0dbhn+kY3EFRa2D18rxQvDuHSY=;
  b=RqdpC+AZnHXow412U5lY1nDTnbJgdUh84IkH+ejtAwle/dEW7QZeu83m
   OwJ9QPEEjzdgsz7/0n68R9wViPxF/00h4aGolMuq1GAVAFdN8ts/ZJwJs
   bS1YHsSUJ8dzlGQzBPPh0VT4z3OvD5EJ954j6r1JLtZqFgW3kYokPirxE
   Anxj/g6faugnrrn/NFpwAOzLjC1wo/eFehm7/9eBK7oGWrCU0Pmg+4TbR
   xjx3ZZdvCUfooqvWUQx9xA/gA26cfob3KcNUXUEljKVDJtiL3FepVeX2B
   FuqmHHvjfLp4U1L5gqCz6hR0tJk/sRJPy5vpzrWB5T3CUMuD76XJik2Ik
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="335134674"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="335134674"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 04:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746305788"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="746305788"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2023 04:23:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1paFIe-000JEN-0d;
        Thu, 09 Mar 2023 14:23:12 +0200
Date:   Thu, 9 Mar 2023 14:23:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZAnPrwLUA/1Bsq26@smile.fi.intel.com>
References: <20230309085713.57700-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309085713.57700-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:57:08AM +0200, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To do this, let's set up a struct bus and struct device for the serial
> core controller as suggested by Greg and Jiri. The serial core controller
> devices are children of the physical serial port device. The serial core
> controller device is needed to support multiple different kind of ports
> connected to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
> 
> We need to also update the documentation a bit as suggested by Andy.
> 
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.

Thanks, my comments below.

...

>    - Devices behind real busses where there is a connector resource
> -    are represented as struct spi_device or struct i2c_device. Note
> -    that standard UARTs are not busses so there is no struct uart_device,
> -    although some of them may be represented by struct serdev_device.
> +    are represented as struct spi_device, struct i2c_device or
> +    struct serdev_device.

JFYI: the i2c_device will be changed soon to i2c_client in the v6.3-rcX,
so this will have a conflict.

...

> +	if (!strncmp(name, "ctrl", 4)) {

Wouldn't str_has_previx() be better to show the intention?

> +		id = port->ctrl_id;
> +	} else {
> +		id = port->line;
> +		dev->port = port;
> +	}

...


> +	dev_set_name(&dev->dev, "%s.%s.%d", name, dev_name(port->dev), id);

No error check?

...

> +	ret = device_add(&dev->dev);
> +	if (ret) {

> +		kfree(dev);

Would it free the device name?

> +		return NULL;
> +	}

...

> +EXPORT_SYMBOL_GPL(serial_base_device_add);

I'm wondering if we can use namespace from day 1 for this.

...

> +static int serial_base_init(void)
> +{
> +	return bus_register(&serial_base_bus_type);
> +}
> +
> +static void serial_base_exit(void)
> +{
> +	bus_unregister(&serial_base_bus_type);
> +}

> +

Redundant blank line and...

> +module_init(serial_base_init);

...move this to be after the function itself.

> +module_exit(serial_base_exit);

...

> +extern int serial_base_driver_register(struct device_driver *driver);
> +extern void serial_base_driver_unregister(struct device_driver *driver);
> +extern struct serial_base_device *serial_base_device_add(struct uart_port *port,
> +							 const char *name,
> +							 struct device *parent_dev);
> +extern void serial_base_device_remove(struct serial_base_device *dev);
> +
> +extern int serial_ctrl_register_port(struct uart_driver *drv, struct uart_port *port);
> +extern void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port);
> +
> +extern int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
> +extern void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);

I believe you do not need "extern" for the function declarations here.

...

> +	err = pm_runtime_get(port_dev);

Is not sync API a deliberate choice? Do we need to comment on why is so?

...

> +	bool added = false;

> +	/* Inititalize a serial core controller device if needed */
> +	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
> +	if (!ctrl_dev) {
> +		ctrl_dev = serial_core_ctrl_device_add(port);
> +		if (!ctrl_dev) {
> +			ret = -ENODEV;
> +			goto err_unlock;
> +		}
> +		added = true;
> +	}


> +	if (added)
> +		serial_base_device_remove(to_serial_base_device(ctrl_dev));

Wondering if it makes sense to add a boolean directly into uart_port and drop
this conditional here and move it to the callee.

...

> +
> +module_init(serial_ctrl_init);
> +module_exit(serial_ctrl_exit);

Can we also move these closer to the respective functions?

...

> +
> +module_init(serial_port_init);
> +module_exit(serial_port_exit);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


