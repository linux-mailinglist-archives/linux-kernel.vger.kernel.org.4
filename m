Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7746680CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjA3MIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjA3MID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:08:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D5130180;
        Mon, 30 Jan 2023 04:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675080439; x=1706616439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L8oHpgiQkMSBM2SGo1lMty/TFLibAaBZaruIjfet5+o=;
  b=RIbRL4iuurpmcGH98p+ohe9OYus1xtYMU81sSaKjTqpUbmuicuUM6kyJ
   qoJvc2qm6kzjMk1Lo14TEy1Kl/r4zOf0YvVwcd18t5xIHnEQbGL7IN1Pc
   wBdrfgcwPh+LbG4Ksc7gexro6QKTxD7qsiqV6RNXWni6knD+FBXR5apHV
   yx/Yp6bqU0ttdOQnTlq5WuQHZ2DTrvzYM9M2p6UqZuPkKoXtJ7LVLndjO
   R6XG59+67bdv9ZRVC2mBmV9Jq+IGkaO5Ec2qZ59nEtmfYyXqDsKCIfhtX
   KItFak1Jb6oiRPM51+xMTELIOJ8/tc51fhKo9surCNHzmOvCGScomspMk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="311160688"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="311160688"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="909473739"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="909473739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jan 2023 04:05:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMSv5-00HKuX-01;
        Mon, 30 Jan 2023 14:05:55 +0200
Date:   Mon, 30 Jan 2023 14:05:54 +0200
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
Subject: Re: [PATCH v2 04/11] gpiolib: Clear the gpio_device's fwnode
 initialized flag before adding
Message-ID: <Y9eyohkI7EKOlHSX@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-5-saravanak@google.com>
 <Y9OY6pMwYtab1Avd@smile.fi.intel.com>
 <CAGETcx_sm5Efy=80kc9gNTaZgvOQzBGxwWA1n+bPJYWg43OebA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_sm5Efy=80kc9gNTaZgvOQzBGxwWA1n+bPJYWg43OebA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:33:38PM -0800, Saravana Kannan wrote:
> On Fri, Jan 27, 2023 at 1:27 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 26, 2023 at 04:11:31PM -0800, Saravana Kannan wrote:

...

> > > +     /*
> > > +      * If fwnode doesn't belong to another device, it's safe to clear its
> > > +      * initialized flag.
> > > +      */
> > > +     if (!gdev->dev.fwnode->dev)
> > > +             fwnode_dev_initialized(gdev->dev.fwnode, false);
> >
> > Do not dereference fwnode in struct device. Use dev_fwnode() for that.
> >
> >         struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
> >
> >         if (!fwnode->dev)
> >                 fwnode_dev_initialized(fwnode, false);
> 
> Honestly, we should work towards NOT needing dev_fwnode().

Honestly, it's that We SHOULD go to avoid any direct dereference of fwnode from
the struct device. I explained you in the comment in the other patch.

> The
> function literally dereferences dev->fwnode or the one inside of_node.
> So my dereference is fine. The whole "fwnode might not be set for
> devices with of_node" is wrong and we should fix that instead of
> writing wrappers to work around it.
> 
> Also, for now I'm going to leave this as if for the same reasons as I
> mentioned in Patch 1.

Same.


-- 
With Best Regards,
Andy Shevchenko


