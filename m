Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5767E08B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjA0JnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjA0JnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:43:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3A0521CC;
        Fri, 27 Jan 2023 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674812601; x=1706348601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FA6Dutjgr8XnKBpJWp+xfqxnKtY395xQaS3sDUM3PWg=;
  b=Xuackp8byIAcaJhBzC6WZ8/PX8mkU0aRJ/NwS8T0WTjN4GJw8FFvVevj
   SA4lBpYoj4+MYzCP39G0IFQKXrA4xX0uXLWA1lfdktLODiv8P75D3KQBK
   VTJVPQO8+Bi2p+ZTT64e6qLG72zpcyeKy0lKly9CG9kYJJXcQYvUs9Aha
   FRu2LuZ0ty4jSCto9pkh1+lKUvLG6xnWStUqF/Zspfvb8yozDauk/rEFU
   Yfls9AGbrzFpjFgKkH6MHy9xTD/Mu0LnLTWWvcNkD/JeUHEi1EKyGOFQ4
   mBj6xvPUO21vQDLBqCJr3eLxrZ98+wkyTWwCuoHcEJMt1qEQHLO7SPs0a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="327073626"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="327073626"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="663209386"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="663209386"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2023 01:43:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLLGC-00FtmI-1U;
        Fri, 27 Jan 2023 11:43:04 +0200
Date:   Fri, 27 Jan 2023 11:43:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 08/11] driver core: fw_devlink: Make cycle detection
 more robust
Message-ID: <Y9OcqGTocu8ZlFqy@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-9-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127001141.407071-9-saravanak@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:11:35PM -0800, Saravana Kannan wrote:
> fw_devlink could only detect a single and simple cycle because it relied
> mainly on device link cycle detection code that only checked for cycles
> between devices. The expectation was that the firmware wouldn't have
> complicated cycles and multiple cycles between devices. That expectation
> has been proven to be wrong.
> 
> For example, fw_devlink could handle:
> 
> +-+        +-+
> |A+------> |B+
> +-+        +++
>  ^          |
>  |          |
>  +----------+
> 
> But it couldn't handle even something as "simple" as:
> 
>  +---------------------+
>  |                     |
>  v                     |
> +-+        +-+        +++
> |A+------> |B+------> |C|
> +-+        +++        +-+
>  ^          |
>  |          |
>  +----------+
> 
> But firmware has even more complicated cycles like:
> 
>     +---------------------+
>     |                     |
>     v                     |
>    +-+       +---+       +++
> +--+A+------>| B +-----> |C|<--+
> |  +-+       ++--+       +++   |
> |   ^         | ^         |    |
> |   |         | |         |    |
> |   +---------+ +---------+    |
> |                              |
> +------------------------------+
> 
> And this is without including parent child dependencies or nodes in the
> cycle that are just firmware nodes that'll never have a struct device
> created for them.
> 
> The proper way to treat these devices it to not force any probe ordering
> between them, while still enforce dependencies between node in the
> cycles (A, B and C) and their consumers.
> 
> So this patch goes all out and just deals with all types of cycles. It
> does this by:
> 
> 1. Following dependencies across device links, parent-child and fwnode
>    links.
> 2. When it find cycles, it mark the device links and fwnode links as
>    such instead of just deleting them or making the indistinguishable
>    from proxy SYNC_STATE_ONLY device links.
> 
> This way, when new nodes get added, we can immediately find and mark any
> new cycles whether the new node is a device or firmware node.

...

> + * Check if @sup_handle or any of its ancestors or suppliers direct/indirectly
> + * depend on @con.  This function can detect multiple cyles between @sup_handle

A single space is enough.

> + * and @con. When such dependency cycles are found, convert all device links
> + * created solely by fw_devlink into SYNC_STATE_ONLY device links.  Also, mark

Ditto.

> + * all fwnode links in the cycle with FWLINK_FLAG_CYCLE so that when they are
> + * converted into a device link in the future, they are created as
> + * SYNC_STATE_ONLY device links.  This is the equivalent of doing

Ditto.

> + * fw_devlink=permissive just between the devices in the cycle. We need to do
> + * this because, at this point, fw_devlink can't tell which of these
> + * dependencies is not a real dependency.
> + *
> + * Return true if one or more cycles were found. Otherwise, return false.

Return:

(you may run `kernel-doc -v ...` to see all warnings)

...

> +static bool __fw_devlink_relax_cycles(struct device *con,
> +				 struct fwnode_handle *sup_handle)
> +{
> +	struct fwnode_link *link;
> +	struct device_link *dev_link;

> +	struct device *sup_dev = NULL, *par_dev = NULL;

You can put it the first line since it's long enough.
But why do you need sup_dev assignment?

> +	bool ret = false;
> +
> +	if (!sup_handle)
> +		return false;
> +
> +	/*
> +	 * We aren't trying to find all cycles. Just a cycle between con and
> +	 * sup_handle.
> +	 */
> +	if (sup_handle->flags & FWNODE_FLAG_VISITED)
> +		return false;
> +
> +	sup_handle->flags |= FWNODE_FLAG_VISITED;

> +	sup_dev = get_dev_from_fwnode(sup_handle);
> +

I would put it closer to the condition:

> +	/* Termination condition. */
> +	if (sup_dev == con) {

	/* Get supplier device and check for termination condition */
	sup_dev = get_dev_from_fwnode(sup_handle);
	if (sup_dev == con) {

> +		ret = true;
> +		goto out;
> +	}
> +
> +	/*
> +	 * If sup_dev is bound to a driver and @con hasn't started binding to
> +	 * a driver, @sup_dev can't be a consumer of @con.  So, no need to

sup_dev or @sup_dev? What's the difference? Should you spell one of them
in full?

> +	 * check further.
> +	 */
> +	if (sup_dev && sup_dev->links.status ==  DL_DEV_DRIVER_BOUND &&

As in the comment above, the single space is enough.

> +	    con->links.status == DL_DEV_NO_DRIVER) {
> +		ret = false;
> +		goto out;
> +	}
> +
> +	list_for_each_entry(link, &sup_handle->suppliers, c_hook) {
> +		if (__fw_devlink_relax_cycles(con, link->supplier)) {
> +			__fwnode_link_cycle(link);
> +			ret = true;
> +		}
> +	}
> +
> +	/*
> +	 * Give priority to device parent over fwnode parent to account for any
> +	 * quirks in how fwnodes are converted to devices.
> +	 */

> +	if (sup_dev) {
> +		par_dev = sup_dev->parent;
> +		get_device(par_dev);
> +	} else {
> +		par_dev = fwnode_get_next_parent_dev(sup_handle);
> +	}

	if (sup_dev)
		par_dev = get_device(sup_dev->parent);
	else
		par_dev = fwnode_get_next_parent_dev(sup_handle);

> +	if (par_dev)
> +		ret |= __fw_devlink_relax_cycles(con, par_dev->fwnode);

Instead I would rather do a similar pattern of the ret assignment as elsewhere
in the function.

	if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode))
		ret = true;

> +	if (!sup_dev)
> +		goto out;
> +
> +	list_for_each_entry(dev_link, &sup_dev->links.suppliers, c_node) {
> +		/*
> +		 * Ignore a SYNC_STATE_ONLY flag only if it wasn't marked as a
> +		 * such due to a cycle.
> +		 */
> +		if (device_link_flag_is_sync_state_only(dev_link->flags) &&
> +		    !(dev_link->flags & DL_FLAG_CYCLE))
> +			continue;
> +
> +		if (__fw_devlink_relax_cycles(con,
> +					      dev_link->supplier->fwnode)) {

Keep it on one line.

> +			fw_devlink_relax_link(dev_link);
> +			dev_link->flags |= DL_FLAG_CYCLE;
> +			ret = true;
> +		}
> +	}
> +
> +out:
> +	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
> +	put_device(sup_dev);
> +	put_device(par_dev);
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


