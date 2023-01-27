Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290767E058
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjA0JeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjA0JeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:34:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29529E07;
        Fri, 27 Jan 2023 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674812024; x=1706348024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mwCyMlAJfonCrHYzpmJJHccfkoSdmotmHtS5TBMdU+k=;
  b=cj6NrjfhKZh3eK2SVTd8241zK827Wf3bQJo/DT2wO19e9p3E7PAWQBy6
   plnfIBv7LVU+7FvG2jPDZyOEjRtFgMpuU+hbZmtpr/tHVZkSWhOWwED/Y
   0RFH6/3Rvuv9aR1oEax7PEBqvIbPM415/pcJWfGKwIy5NIESIVgbwcPon
   KcaSTFAb2Lx75Sp3k6j5uaKfNbR5YOiaMCK7a7RgWIHUYRFk6hPjQKR7/
   sCxF3duCAovGegqfTM4Sdvm9eA+dlh6GdbPbpNECMDx9sl86ABtHNm2Fp
   Eel/7TQWKL+Vvj2kp5E5JrYgKXMWVR30pacl6jEFkNdK1SAKRIS9zpZvk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="306702685"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="306702685"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="731791790"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="731791790"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2023 01:33:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLL6u-00Ftar-2t;
        Fri, 27 Jan 2023 11:33:28 +0200
Date:   Fri, 27 Jan 2023 11:33:28 +0200
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
Subject: Re: [PATCH v2 06/11] driver core: fw_devlink: Allow marking a fwnode
 link as being part of a cycle
Message-ID: <Y9OaaC806Ywg7rM9@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-7-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127001141.407071-7-saravanak@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:11:33PM -0800, Saravana Kannan wrote:
> To improve detection and handling of dependency cycles, we need to be
> able to mark fwnode links as being part of cycles. fwnode links marked
> as being part of a cycle should not block their consumers from probing.

...

> +	list_for_each_entry(link, &fwnode->suppliers, c_hook) {
> +		if (link->flags & FWLINK_FLAG_CYCLE)
> +			continue;
> +		return link->supplier;

Hmm...

		if (!(link->flags & FWLINK_FLAG_CYCLE))
			return link->supplier;

?

> +	}
> +
> +	return NULL;

...

> -	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> -	    !fw_devlink_is_permissive()) {
> -		sup_fw = list_first_entry(&dev->fwnode->suppliers,
> -					  struct fwnode_link,
> -					  c_hook)->supplier;
> +	sup_fw = fwnode_links_check_suppliers(dev->fwnode);

dev_fwnode() ?

...

> -	val = !list_empty(&dev->fwnode->suppliers);
> +	mutex_lock(&fwnode_link_lock);
> +	val = !!fwnode_links_check_suppliers(dev->fwnode);

Ditto?

> +	mutex_unlock(&fwnode_link_lock);

-- 
With Best Regards,
Andy Shevchenko


