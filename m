Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613E3636914
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiKWSh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiKWShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:37:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FFE3FBA5;
        Wed, 23 Nov 2022 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669228629; x=1700764629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pB1EsglLcKD2gYBT5AzeYPhOVPqNCWBwum0p1o8faIY=;
  b=UBsY46wqcFB9d79lwnqNZ7n4N7aQb7g2kFnn0VJNYPf4bWqhJWQZM3b2
   f+CNmpTC+QuGASEHv8ZkTkFASxub1ZdcCrwcA5W7XYOrZgcWwBMoQKwZM
   q8v0sykJLumbJt9ykv0Ztr8gtU2BPe4eYAE0hvOIeXu/PLA1xwyK5JTbW
   8cyC+Hk89T/qf77vCEFhX67f4pzvXPFa4vmOaW1PRBGMDPnQWNdIVutDY
   0p1ZRonhvv+zCCSwxWw+4PgQSOnq1tXj7w2X6klXUkyPNBky8pUgo2XNd
   wkcVv6bAfMvhN1L0L0D8PqhzbZAXH2CGFbf1lwpLK25KoX5fTY7JbX9K2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="293841223"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="293841223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 10:37:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="672972434"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="672972434"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2022 10:37:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oxucJ-00GPFU-1y;
        Wed, 23 Nov 2022 20:37:03 +0200
Date:   Wed, 23 Nov 2022 20:37:03 +0200
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
Subject: Re: [PATCH v3 2/2] serial: core: Add port port device to flush TX on
 runtime resume
Message-ID: <Y35oT9/3OKRciWCP@smile.fi.intel.com>
References: <20221123082825.32820-1-tony@atomide.com>
 <20221123082825.32820-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123082825.32820-2-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:28:25AM +0200, Tony Lindgren wrote:
> With PM runtime enabled for the serial port controllers, we can now flush
> pending TX for the port on runtime PM resume as suggested by
> Johan Hovold <johan@kernel.org>.

I believe it's quite a duplication of email addresses (they are in Cc and will
be on lore.kernel.org) and also below.

> To flush the pending TX, let's set up each port as a proper device as
> suggested by Greg Kroah-Hartman <gregkh@linuxfoundation.org>.
> 
> We set up each port as a child device for the serial port controller
> device. We use platform device for this and pass the port information
> in platform_data.
> 
> Let's just do mimimal changes needed for now, more port specific code
> can be then moved from serial_core.c to serial_port.c as needed.

...

> +static int serial_core_add_port_device(struct uart_port *port)
> +{
> +	struct serial_port_platdata pd;
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_alloc("serial-port", PLATFORM_DEVID_AUTO);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	pdev->dev.parent = port->dev;
> +	pd.state = port->state;
> +
> +	ret = platform_device_add_data(pdev, &pd, sizeof(pd));
> +	if (ret)
> +		goto err_put;
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto err_put;
> +
> +	port->state->port_dev = &pdev->dev;
> +
> +	return 0;
> +
> +err_put:
> +	platform_device_put(pdev);
> +
> +	return ret;

Can we simply utilize platform_device_register_full()?

> +}

...

> +EXPORT_SYMBOL(serial_port_get);

Can we move these to namespace from day 1?

...

> +	return (!uart_tx_stopped(port) &&
> +		uart_circ_chars_pending(&port->state->xmit));

Outer parentheses are redundant.

...

> +static const struct dev_pm_ops serial_port_pm = {
> +	SET_RUNTIME_PM_OPS(NULL, serial_port_runtime_resume, NULL)
> +};

Can't we use new macros / helpers which starts from DEFINE_...

...

> +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> +					 SERIAL_PORT_AUTOSUSPEND_DELAY_MS);

With temporary

	struct device *dev = &pdev->dev;

this in particular become one line.

...

> +		.pm = &serial_port_pm,

As per above, use pm_ptr() ?

...

> +

Unneeded blank line.

> +module_platform_driver(serial_port_driver);

-- 
With Best Regards,
Andy Shevchenko


