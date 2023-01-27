Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4467E002
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjA0JYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjA0JYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:24:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFCE2E0EC;
        Fri, 27 Jan 2023 01:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674811438; x=1706347438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7L/axu+05lgRV1B7k83rTdiEnNvSos+SJ26ckkwltXU=;
  b=GmfhhfLsn52t3fzd66Kx+fbR5qn4OcKoZmIKoGK1X9HCl5AVxYyKb96x
   sb5ItVXdkYGeX5hcOBU3U3dD26AKwDkXcg3XrovuyNqbnkuj6FV2ZwZ0i
   kzATY1QT75rxlqPSTnZYPrRxlhF/Dgm50sRP4dU53JrMIDMUh2gPy0KAP
   HF7DJn0/w7Gt/qTsbO7hhSXbvbdH2VHzprugUEAoe+JScsgloc6F/is14
   6NwVbA4Zh83D7CNQ87tFD4K+CWMpEzwO+Hc6LBWSOBW71EYhxDux7CRlp
   ymVq7+3YePYLf3HZIxv26MxxQvgHyEc4zhRyA4fE9OGOwznQUB4eYdCgO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="310672030"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="310672030"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="656541888"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="656541888"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2023 01:22:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLKvk-00FtO1-00;
        Fri, 27 Jan 2023 11:21:56 +0200
Date:   Fri, 27 Jan 2023 11:21:55 +0200
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
Subject: Re: [PATCH v2 01/11] driver core: fw_devlink: Don't purge child
 fwnode's consumer links
Message-ID: <Y9OXs9+uYi31dYJD@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127001141.407071-2-saravanak@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:11:28PM -0800, Saravana Kannan wrote:
> When a device X is bound successfully to a driver, if it has a child
> firmware node Y that doesn't have a struct device created by then, we
> delete fwnode links where the child firmware node Y is the supplier. We
> did this to avoid blocking the consumers of the child firmware node Y
> from deferring probe indefinitely.
> 
> While that a step in the right direction, it's better to make the
> consumers of the child firmware node Y to be consumers of the device X
> because device X is probably implementing whatever functionality is
> represented by child firmware node Y. By doing this, we capture the
> device dependencies more accurately and ensure better
> probe/suspend/resume ordering.

...

>  static unsigned int defer_sync_state_count = 1;
>  static DEFINE_MUTEX(fwnode_link_lock);
>  static bool fw_devlink_is_permissive(void);
> +static void __fw_devlink_link_to_consumers(struct device *dev);
>  static bool fw_devlink_drv_reg_done;
>  static bool fw_devlink_best_effort;

I'm wondering if may avoid adding more forward declarations...

Perhaps it's a sign that devlink code should be split to its own
module?

...

> -int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
> +static int __fwnode_link_add(struct fwnode_handle *con,
> +			     struct fwnode_handle *sup)

I believe we tolerate a bit longer lines, so you may still have it on a single
line.

...

> +int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
> +{

> +	int ret = 0;

Redundant assignment.

> +	mutex_lock(&fwnode_link_lock);
> +	ret = __fwnode_link_add(con, sup);
> +	mutex_unlock(&fwnode_link_lock);
>  	return ret;
>  }

...

>  	if (dev->fwnode && dev->fwnode->dev == dev) {

You may have above something like


	fwnode = dev_fwnode(dev);
	if (fwnode && fwnode->dev == dev) {

>  		struct fwnode_handle *child;
>  		fwnode_links_purge_suppliers(dev->fwnode);
> +		mutex_lock(&fwnode_link_lock);
>  		fwnode_for_each_available_child_node(dev->fwnode, child)
> -			fw_devlink_purge_absent_suppliers(child);
> +			__fw_devlink_pickup_dangling_consumers(child,
> +							       dev->fwnode);

			__fw_devlink_pickup_dangling_consumers(child, fwnode);

> +		__fw_devlink_link_to_consumers(dev);
> +		mutex_unlock(&fwnode_link_lock);
>  	}

-- 
With Best Regards,
Andy Shevchenko


