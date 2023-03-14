Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024F56B9634
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjCNN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjCNN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:28:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C8F8B307;
        Tue, 14 Mar 2023 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678800342; x=1710336342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0DeveTeOTTZY6abqN216d+MpmyjSz+VWTzc+RDADd0I=;
  b=Pom7t7R5qTtJjcwtAr5Z0/P+St8EUPJt4k66dK6rtiRF7AtLsqO/ek0p
   6R9if7NrM6P58FocrJfzVsW8zSY6AHYOpNSnVo5Lrom2MkcQ+zRwGREWq
   dLclwFBcauouE1LC680oE7JueuOCcc0eAVygV7kqbjbIkoC+k5G4+ouXW
   H7yRDuzuF1nYNf1+D6m32ZWdTvB5BjvPo6cYZ8SCVVFCZ7HE16z6FEfEi
   NtCGqokyeHIKDR7t6dR75qJAMADxCkgGBHs8GImgXimkNL5VCLgfzpe4X
   TcpNo0soJV7uzG/2GW8mjqgjhNEyDmktQTNeI7xTG2ghWlxmQ9GClJ9MI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="365088126"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="365088126"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 06:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802861553"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="802861553"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2023 06:24:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pc4db-003EZd-39;
        Tue, 14 Mar 2023 15:24:23 +0200
Date:   Tue, 14 Mar 2023 15:24:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v7 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZBB1h12WHIGo4NX8@smile.fi.intel.com>
References: <20230314073603.42279-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314073603.42279-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:35:59AM +0200, Tony Lindgren wrote:
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

> We need to also update the documentation a bit as suggested by Andy.

Now this can be moved to the comments section (below '---' cutter)
with perhaps addition why it's not done yet.

> With the serial core port device we can now flush pending TX on the

...

> +	return (strncmp(dev_name(dev), drv->name, len) == 0);

Outer parentheses are redundant. The ' == 0' can be replaced with !,
but it's up to you.

...

> +struct serial_base_device *serial_base_device_add(struct uart_port *port,
> +						  const char *name,
> +						  struct device *parent_dev)
> +{
> +	struct serial_base_device *dev;

Can we call this variable (and perhaps everywhere else) like sbd, or sbdev?

This will help to distinguish core device operations and serial one, because,
for example, I have stumbled over kfree(dev) and puzzled a lot.

> +	int err, id;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return NULL;
> +
> +	device_initialize(&dev->dev);
> +	dev->dev.parent = parent_dev;
> +	dev->dev.bus = &serial_base_bus_type;

Who should provide a ->release() callback?

> +	if (str_has_prefix(name, "ctrl")) {
> +		id = port->ctrl_id;
> +	} else {
> +		id = port->line;
> +		dev->port = port;
> +	}
> +
> +	err = dev_set_name(&dev->dev, "%s.%s.%d", name, dev_name(port->dev), id);
> +	if (err)
> +		goto err_free_dev;
> +
> +	err = device_add(&dev->dev);
> +	if (err)
> +		goto err_free_name;
> +
> +	return dev;
> +
> +err_free_name:
> +	kfree_const(dev->dev.kobj.name);

It's still missing put_device() call as suggested by device_add() kernel
documentation. (Double) check also the removal path.

> +err_free_dev:
> +	kfree(dev);

> +	return NULL;
> +}

...

> +struct device;

Since you are embedding the device object this won't suffice,
you need to include device.h.

> +struct uart_driver;
> +struct uart_port;
> +
> +struct serial_base_device {
> +	struct device dev;
> +	struct uart_port *port;
> +};
> +
> +#define to_serial_base_device(x) container_of((x), struct serial_base_device, dev)

container_of.h

...

> +	/* Increment the runtime PM usage count for the active check below */
> +	err = pm_runtime_get(port_dev);

The question here is why don't we need to actually turn on the device immediately
(sync) if it's not already powered?

> +	if (err < 0) {
> +		pm_runtime_put_noidle(port_dev);
> +		return;
> +	}

> +	/*
> +	 * Start TX if enabled, and kick runtime PM. Otherwise we must
> +	 * wait for a retry. See also serial_port.c for runtime PM
> +	 * autosuspend timeout.
> +	 */

I.o.w. does the start_tx() require device to be powered on at this point?

> +	if (pm_runtime_active(port_dev))
>  		port->ops->start_tx(port);
> +	pm_runtime_mark_last_busy(port_dev);
> +	pm_runtime_put_autosuspend(port_dev);

...

> +++ b/drivers/tty/serial/serial_ctrl.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Serial core controller driver
> + *
> + * This driver manages the serial core controller struct device instances.
> + * The serial core controller devices are children of the physical serial
> + * port device.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/serial_core.h>

Include for the struct device_driver?

Do we need a separete include for EXPORT_SYMBOL_NS()?

...

> +/*
> + * Serial core port device driver
> + */
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/serial_core.h>

Similar questions.

+ spinlock.h?

...

> +static __maybe_unused DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,

Do you still need __maybe_unused?

> +						NULL,
> +						serial_port_runtime_resume,
> +						NULL);

-- 
With Best Regards,
Andy Shevchenko


