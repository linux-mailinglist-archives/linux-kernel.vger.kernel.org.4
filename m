Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2C6C4E73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCVOtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjCVOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:49:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2FF6782F;
        Wed, 22 Mar 2023 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679496473; x=1711032473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lj2AHpVNlWyegPAy0etEep0QsoP1FICJ6uYFf1nrmTY=;
  b=dgK7NSMhzqIS2MXR/HXgbMWjU1jtpeEvoXAJKvAs7Yes91BFwDYlJ4oD
   QOOmxMA+DuTIzS1O/Ghe6twUQjOqSjrnICEZLkbxKb6TxBDDkuX4+GOdc
   d+MGjPKJuE+tJGtT95rBXa9es6M/KAsRy42SEsUwbr0jfhpXAB1WtN7Jq
   VQMrNhdj4U/rQtdiOyjg2q/S9hUL/IbF3CvkPlDVn7rDLG40p0F1z5J9R
   cGdNfYLc7CC3kk9hV/ln1v333vWvlbWEVa8mAizrNQhemxmVOgTCIGnRc
   6A79MIDSqmC//jMjnRr2A/OPJDBp4fIjq22BpizoEJMJAw54Eo8CtPhQs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341590174"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="341590174"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="681919224"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="681919224"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 07:45:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pezik-007AYA-2e;
        Wed, 22 Mar 2023 16:45:46 +0200
Date:   Wed, 22 Mar 2023 16:45:46 +0200
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
Subject: Re: [PATCH v8 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZBsUmkqKnP/jrNjv@smile.fi.intel.com>
References: <20230322111255.29827-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322111255.29827-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:12:51PM +0200, Tony Lindgren wrote:
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
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.

With below addressed, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +	device_initialize(&sbd->dev);
> +	sbd->dev.parent = parent_dev;
> +	sbd->dev.bus = &serial_base_bus_type;
> +	sbd->dev.release = &serial_base_release;
> +
> +	if (str_has_prefix(name, "ctrl")) {
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

> +	kfree_const(sbd->dev.kobj.name);

This is double free if not const, right?
At least that's how I read kobject_cleanup() implementation.

Sorry I haven't paid attention to this earlier.

...

> +/*
> + * Serial core port device driver
> + */

Put it on one line for now?

-- 
With Best Regards,
Andy Shevchenko


