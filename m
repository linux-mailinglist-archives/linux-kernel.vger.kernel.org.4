Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2811067E026
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjA0JaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjA0JaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:30:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE48A79;
        Fri, 27 Jan 2023 01:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674811799; x=1706347799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d2yDCTUWrATaE6uAigdEvJNdLttVhMNqs/VWyHeY5TI=;
  b=iS3A+v8UEQvdTPj6561v21ctgdiIqspp/ibfJ7KAQ1kplQPNUus7EHNe
   LJagv6KdrYYmezdtN1t19D+NEJFVGcrjlKHD6bZmBbHVxPmHuFclqODow
   4GqBsnt+qLISuIDcuOGFwv9H7UdmPJSb3kyOdgsUs8Nru21rQcxgr116x
   R/+2xej832aYZRTJxpdUlh6Y3sLpWs5yaJKN1kp+QWLbiuusESvtrFbYL
   s1q+uM9NxUE93iETeFQuUrEm/MYLeRuSba+uaNhW3r1PTGAw76uLfti0K
   NJ/NWekAUI6dHs8PEDy3kwbkG0S8jEsExLRWKPaZvl+4cPpIvaXjkfq57
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391603533"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="391603533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:29:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="771513309"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="771513309"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2023 01:29:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLL3H-00FtWf-2a;
        Fri, 27 Jan 2023 11:29:43 +0200
Date:   Fri, 27 Jan 2023 11:29:43 +0200
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
Subject: Re: [PATCH v2 05/11] driver core: fw_devlink: Add DL_FLAG_CYCLE
 support to device links
Message-ID: <Y9OZh0ZqtnqmKcvT@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127001141.407071-6-saravanak@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 04:11:32PM -0800, Saravana Kannan wrote:
> fw_devlink uses DL_FLAG_SYNC_STATE_ONLY device link flag for two
> purposes:
> 
> 1. To allow a parent device to proxy its child device's dependency on a
>    supplier so that the supplier doesn't get its sync_state() callback
>    before the child device/consumer can be added and probed. In this
>    usage scenario, we need to ignore cycles for ensure correctness of
>    sync_state() callbacks.
> 
> 2. When there are dependency cycles in firmware, we don't know which of
>    those dependencies are valid. So, we have to ignore them all wrt
>    probe ordering while still making sure the sync_state() callbacks
>    come correctly.
> 
> However, when detecting dependency cycles, there can be multiple
> dependency cycles between two devices that we need to detect. For
> example:
> 
> A -> B -> A and A -> C -> B -> A.
> 
> To detect multiple cycles correct, we need to be able to differentiate
> DL_FLAG_SYNC_STATE_ONLY device links used for (1) vs (2) above.
> 
> To allow this differentiation, add a DL_FLAG_CYCLE that can be use to
> mark use case (2). We can then use the DL_FLAG_CYCLE to decide which
> DL_FLAG_SYNC_STATE_ONLY device links to follow when looking for
> dependency cycles.

...

> +static inline bool device_link_flag_is_sync_state_only(u32 flags)
> +{
> +	return (flags & ~(DL_FLAG_INFERRED | DL_FLAG_CYCLE))
> +		== (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED);

Weird indentation, why not

	return (flags & ~(DL_FLAG_INFERRED | DL_FLAG_CYCLE)) ==
	       (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED);

?

> +}

...

>  			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
>  			       DL_FLAG_AUTOPROBE_CONSUMER  | \
>  			       DL_FLAG_SYNC_STATE_ONLY | \
> -			       DL_FLAG_INFERRED)
> +			       DL_FLAG_INFERRED | \
> +			       DL_FLAG_CYCLE)

You can make less churn by squeezing the new one above the last one.

-- 
With Best Regards,
Andy Shevchenko


