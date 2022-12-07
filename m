Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551AD646259
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiLGU2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLGU22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:28:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EACEDE88;
        Wed,  7 Dec 2022 12:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670444906; x=1701980906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sWTDm26dkSn9+qW1jd6fTadfWfLcjbzkrYlN30smQ6o=;
  b=dREONcz7Jthp8/bEn/Tr2KGdmuNsdT03Rj8mXGP7GWQhK1Qb0aJvqS8p
   T864/KLkkhBiW2yeXcjkQAavPIkRKVhzW7cekoQ1U0cgS7LEma6YgxxD0
   uunMNdhfq+Zb6XCtUM5Q34HjL7KqIEKuAgsmFv8Gi5A/j6Yzs4aJ25D3m
   TACULAOkanYXnc0jezjtA/iMVSOTGCYe1Lf5XHHAkrS8W2V2KNF0eAQy/
   JHwVYKlSKpZ4xknGBwk4jmjkz74QA2zDiQ4q2NVA3ixy5HSiIe1nNfPHw
   jcddGOiaD3Qzv/koHj1a83sGIO/YSbq1RZbVreb9bu0gCm+84lQzxlRU3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="314642775"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="314642775"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 12:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="624433944"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="624433944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2022 12:28:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p311M-005yqb-30;
        Wed, 07 Dec 2022 22:28:00 +0200
Date:   Wed, 7 Dec 2022 22:28:00 +0200
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
Message-ID: <Y5D3UKLgHCT9feuC@smile.fi.intel.com>
References: <20221207124305.49943-1-tony@atomide.com>
 <Y5D187ygOvDEA0UK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5D187ygOvDEA0UK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 10:22:11PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 07, 2022 at 02:43:05PM +0200, Tony Lindgren wrote:

...

> > +int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
> > +{
> 
> > +	bool allocated = false;
> 
> Not sure why this is needed.

Okay, I got it.
Still, see below.

> > +	struct device *ctrl_dev;
> > +	int ret;
> > +
> > +	ret = serial_core_add_one_port(drv, port);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&port_mutex);
> > +
> > +	/* Inititalize a serial core controller device if needed */
> > +	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
> > +	if (!ctrl_dev) {
> > +		ctrl_dev = serial_core_ctrl_device_add(port);
> > +		if (!ctrl_dev)
> > +			goto err_remove_port;
> > +		allocated = true;
> > +	}
> 
> Wouldn't be slightly better
> 
> 	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
> 	if (!ctrl_dev)
> 		ctrl_dev = serial_core_ctrl_device_add(port);
> 	if (!ctrl_dev)
> 		goto err_remove_port;
> 
> ?
> 
> > +	/* Initialize a serial core port device */
> > +	ret = serial_core_port_device_add(ctrl_dev, port);
> > +	if (ret)
> > +		goto err_del_ctrl_dev;
> > +
> > +	mutex_unlock(&port_mutex);
> > +
> > +	return 0;
> > +
> > +err_del_ctrl_dev:
> > +	if (allocated)

We can avoid this check by caching the platform device.

	struct platform_device *ctrl_pdev = NULL;

	if (...) {
		ctrl_pdev = to_platform_device(ctrl_dev);
	}

	platform_device_del(ctrl_pdev);

> > +		platform_device_del(to_platform_device(ctrl_dev));
> 
> Shouldn't you call platform_device_unregister()?
> 
> > +err_remove_port:
> > +	mutex_unlock(&port_mutex);
> > +
> > +	return serial_core_remove_one_port(drv, port);
> > +}

-- 
With Best Regards,
Andy Shevchenko


