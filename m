Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5535B646BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiLHJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLHJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:13:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EF877203;
        Thu,  8 Dec 2022 01:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670490751; x=1702026751;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uG+z6YFt2KidzCc4wAWQpTKyaaYKkEtXode3ts7CuaQ=;
  b=OBIcIlfCj8RcpK/l+/5WXyezC1DyNuNJLE5iha4IPMHVCqgtuB2KvF/n
   3xl9nrT+/NjfsnrMjSOPFPLsotLNTEdDJr4zGKq0UX29KzVQY9xmOxN8M
   AE4U0U1iit8iHfDrLW/+YjotJQdoIdXjhZFY+BxRy7u04o3YEk060lZZo
   BxmQDGH1X21490kEgIwCIgKVWSWsbI9ryp1jH7oy9Zx2x0XpO44QgoAT5
   8grEW7lagyIVgKmv82r6tdDFFI4YWE1bNgVLFSRIXjrAeWPcUjR8YXQgq
   uBfRfrxgaUOiOj/rnpb3vbkvf2GAk+jjk5Ag8xiWWmkHRuhKXnaxC4ZDM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381415870"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="381415870"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 01:12:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="975790008"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="975790008"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.39.224])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 01:12:24 -0800
Date:   Thu, 8 Dec 2022 11:12:14 +0200 (EET)
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
Subject: Re: [RFC PATCH v4 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
In-Reply-To: <20221207124305.49943-1-tony@atomide.com>
Message-ID: <7f105ff9-cdc3-f98e-2557-812361faa94@linux.intel.com>
References: <20221207124305.49943-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022, Tony Lindgren wrote:

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
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v3:
> 
> - Simplify things by adding a serial core control device as the child of
>   the physical serial port as suggested by Jiri
> 
> - Drop the tinkering of the physical serial port device for runtime PM.
>   Serial core just needs to manage port->port_dev with the addition of
>   the serial core control device and the device hierarchy will keep the
>   pysical serial port device enabled as needed
> 
> - Simplify patch description with all the runtime PM tinkering gone
> 
> - Coding style improvments as noted by Andy
> 
> - Post as a single RFC patch as we're close to the merge window
> 
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
> +
> +	/* Initialize a serial core port device */
> +	ret = serial_core_port_device_add(ctrl_dev, port);

How is ->port_dev supposed to work here?

->port_dev is not set until in serial_core_port_device_add() but you made
serial_core_add_one_port() call before that.

-- 
 i.

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
> +
> +err_remove_port:
> +	mutex_unlock(&port_mutex);
> +
> +	return serial_core_remove_one_port(drv, port);
> +}
> +EXPORT_SYMBOL_NS(serial_core_register_port, SERIAL_CORE);
