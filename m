Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D7636923
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiKWSlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbiKWSlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:41:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8079911;
        Wed, 23 Nov 2022 10:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669228903; x=1700764903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5NUpWHxh0HMcGrVnX2uqj2PpmAieZarcGlSMWP4Qkgk=;
  b=OQamZGKTewFCjGBAIKBeVtEmRk/dkCp/uG0muzEczfGJ7Lkl8ipOEs1s
   T1lvVjoXVsqvCCxv/W4D7Y6hMsjaKqmY4dyM5C8RUc6Uae1pP5Z/d82q0
   JaXRK7sRa4qQj5i6/eWyrTFO+bURQkGhpzqkqIey5HU6wAKo/oRr+0KgK
   4OflOchUu92hHnKyTDuqLBgEHwtpbqcrbAQGEPRtL6JYMY9ljMwBFw3/u
   ggIT7GYo3oyTBNEU1yxficp/r/meYWNAiTKxAPxNoM/H5NNecBs3ALOxs
   NsdKX3iWu6nWSe9F70CkjCC70O7XSfg4CFJMIWFVSfuqAFqww//yaW5hz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="376279590"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="376279590"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 10:41:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="644211307"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="644211307"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2022 10:41:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oxugk-00GPLO-0x;
        Wed, 23 Nov 2022 20:41:38 +0200
Date:   Wed, 23 Nov 2022 20:41:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <Y35pYsrrSTPr4y9k@smile.fi.intel.com>
References: <20221123082825.32820-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123082825.32820-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:28:24AM +0200, Tony Lindgren wrote:
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

...

> +static struct serial_controller *to_controller(struct uart_port *port)

Perhaps to_serial_controller()? Or to_serial_ctrl() ?

> +{
> +	if (!port->dev)
> +		return NULL;
> +
> +	return port->state->controller;
> +}

...

> +/*
> + * Starts runtime PM for the serial controller device if not already started
> + * by the serial port driver. Called from uart_add_one_port() with port_mutex
> + * held.

Perhaps we may utilize lockdep_assert() here?

> + */

Also maybe might_sleep() can be added where it's appropriate?

...

> +static int serial_core_register_port(struct uart_port *port,
> +				     struct uart_driver *drv)
> +{
> +	struct serial_controller *controller;
> +	bool allocated = false;
> +	int ret;
> +
> +	if (!port->dev)
> +		return 0;
> +
> +	controller = serial_core_find_controller(drv, port->dev);
> +	if (!controller) {

> +		controller = kzalloc(sizeof(*controller), GFP_KERNEL);
> +		if (!controller)
> +			return -ENOMEM;
> +
> +		controller->drv = drv;
> +		controller->dev = port->dev;
> +		controller->supports_autosuspend = port->supports_autosuspend;
> +		allocated = true;

Maybe split this to a serial_core_controller_alloc()?

> +	}
> +
> +	port->state->controller = controller;
> +	WARN_ON(port->supports_autosuspend != controller->supports_autosuspend);
> +
> +	ret = serial_core_pm_runtime_start(port);
> +	if (ret < 0)
> +		goto err_free;
> +
> +	return 0;
> +
> +err_free:
> +	port->state->controller = NULL;
> +	if (allocated)
> +		kfree(controller);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


