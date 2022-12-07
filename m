Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8569664624F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLGUWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGUWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:22:17 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868A57B546;
        Wed,  7 Dec 2022 12:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670444536; x=1701980536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SodqFSDhcnwtxMcub58dUjY9JrZksyadfjH+6KyS0gs=;
  b=JB6u4TIIrGko0dNfaK780yMJNa5AXAWml7nFE48LK55mYCRbouycJwZn
   FYexH4Rz8vYz5pg/dQPWjgozD++DL7TF8sa/6llwvwSDcCdEoV11Wn1l7
   J8y/1vBQ8K8JxBDO4rpNgrPNRcdH5NTCWrIsmMY8MNlEqk9zbEVk04GNd
   ycqvyl8V3eyA/2RnE1OD4q+3mQ00+BnZ67gsHCiBH96z0eAMs0gTW8Llz
   gp8i8G6KS0Rpjy1JipLHUooI1EcDatZRiyEMS9vVCHWMYzp7eM4JhCgrj
   JlmMytp1K3K74UIYmjn8oDljIUCxQPFWwTdwxls1FoiXThNPoBcWO/kbN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="296687285"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="296687285"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 12:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="753251473"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="753251473"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2022 12:22:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p30vj-005yij-2e;
        Wed, 07 Dec 2022 22:22:11 +0200
Date:   Wed, 7 Dec 2022 22:22:11 +0200
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
Subject: Re: [RFC PATCH v4 1/1] serial: core: Start managing serial
 controllers to enable runtime PM
Message-ID: <Y5D187ygOvDEA0UK@smile.fi.intel.com>
References: <20221207124305.49943-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207124305.49943-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 02:43:05PM +0200, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To do this, let's set up a struct device for the serial core controller
> as suggested by Greg and Jiri. The serial core controller devices are
> children of the physical serial port device. The serial core controller
> device is needed to support multiple different kind of ports connected
> to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.

...

> +static struct platform_device *serial_core_device_add(struct uart_port *port,
> +						      const char *name,
> +						      struct device *parent_dev,
> +						      void *pdata,
> +						      int pdata_size)
> +{
> +	struct platform_device_info pinfo;

' = {}' can also work instead of memset(), but up to you.

> +	memset(&pinfo, 0, sizeof(pinfo));
> +	pinfo.name = name;
> +	pinfo.id = PLATFORM_DEVID_AUTO;
> +	pinfo.parent = parent_dev;
> +	pinfo.data = pdata;
> +	pinfo.size_data = pdata_size;
> +
> +	return platform_device_register_full(&pinfo);
> +}

...

> +	struct serial_port_platdata pdata;

Ditto.

> +	memset(&pdata, 0, sizeof(pdata));

...

> +int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
> +{

> +	bool allocated = false;

Not sure why this is needed.

> +	struct device *ctrl_dev;
> +	int ret;
> +
> +	ret = serial_core_add_one_port(drv, port);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&port_mutex);
> +
> +	/* Inititalize a serial core controller device if needed */
> +	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
> +	if (!ctrl_dev) {
> +		ctrl_dev = serial_core_ctrl_device_add(port);
> +		if (!ctrl_dev)
> +			goto err_remove_port;
> +		allocated = true;
> +	}

Wouldn't be slightly better

	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
	if (!ctrl_dev)
		ctrl_dev = serial_core_ctrl_device_add(port);
	if (!ctrl_dev)
		goto err_remove_port;

?

> +	/* Initialize a serial core port device */
> +	ret = serial_core_port_device_add(ctrl_dev, port);
> +	if (ret)
> +		goto err_del_ctrl_dev;
> +
> +	mutex_unlock(&port_mutex);
> +
> +	return 0;
> +
> +err_del_ctrl_dev:
> +	if (allocated)
> +		platform_device_del(to_platform_device(ctrl_dev));

Shouldn't you call platform_device_unregister()?

> +err_remove_port:
> +	mutex_unlock(&port_mutex);
> +
> +	return serial_core_remove_one_port(drv, port);
> +}

...

> +	platform_device_del(to_platform_device(port_dev));

Ditto?

...

> +	/* Drop the serial core controller device if no ports are using it */
> +	if (!serial_core_ctrl_find(drv, port->dev, port->ctrl_id))
> +		platform_device_del(to_platform_device(ctrl_dev));

Ditto?

...

> +/* Serial core controller data. Serial port device drivers do not need this. */

Some missing forward declarations?

struct uart_driver:
struct uart_port;

?

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm, NULL,
> +				 serial_port_runtime_resume, NULL);

Wouldn't be more logical to indent like

static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
				 NULL, serial_port_runtime_resume,
				 NULL);

?

-- 
With Best Regards,
Andy Shevchenko


