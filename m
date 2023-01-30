Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB1680D61
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbjA3MQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjA3MQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:16:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8945E93D1;
        Mon, 30 Jan 2023 04:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675080966; x=1706616966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OoZvW5mYAmBAqzGauPrm+It1FwPUT3sQTZsO9ABVQOg=;
  b=ebfWs4e6SKPb1ImT3zEl30068j5KQ5KLkN4Hge3p499dhVfZqfTBsbvD
   rV7TuHGjFBwJiB63HFIL16H10cQ5blOePHIGHgpOp0H0NkuzfQX1Xk+ud
   EPDZYQBi/7Ssue3f71wZ5HRW1nlYQfCiox9lCXhB1PZyTQ3HmW/UIujew
   5u0dTttJ/S3dECz++qK5RjjTeAVjc+LgznIA87wo8gNGy3mjmRMGKYf/z
   aQyDx56LOSFURj3xpA2dXv/8jXB6lCgXfa2yPycUJh/GEjh6kA+VM3TA9
   Ap849Q69NpcbZvPMdLZcRCLnxkM+8F9jlAEfZ78k4n4+RW23DNs+DejpP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="315501226"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="315501226"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="732677175"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="732677175"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2023 04:15:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMT4h-00HL8S-0F;
        Mon, 30 Jan 2023 14:15:51 +0200
Date:   Mon, 30 Jan 2023 14:15:50 +0200
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
Message-ID: <Y9e09qUa9CDxHFcb@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-9-saravanak@google.com>
 <Y9OcqGTocu8ZlFqy@smile.fi.intel.com>
 <CAGETcx-PiV12pKnVuKyvNcjYbHA=YFJG1QUa-o-G1cL3iMHgcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-PiV12pKnVuKyvNcjYbHA=YFJG1QUa-o-G1cL3iMHgcA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:34:28PM -0800, Saravana Kannan wrote:
> On Fri, Jan 27, 2023 at 1:43 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 26, 2023 at 04:11:35PM -0800, Saravana Kannan wrote:

...

> Lol, you are the king of nit picks :)

Not always, only when it comes with something else.

...

> > > + * Return true if one or more cycles were found. Otherwise, return false.
> >
> > Return:
> 
> I'm following the rest of the function docs in this file.

Okay, it makes sense. We will need to address them all.

> > (you may run `kernel-doc -v ...` to see all warnings)
> 
> Hmmm I ran it on the patch file and it didn't give me anything useful.
> Running it on the whole file is just a lot of lines to dig through.

The function description missing Return section. Something like this
I can get from the kernel doc without it.

...

> > > +static bool __fw_devlink_relax_cycles(struct device *con,
> > > +                              struct fwnode_handle *sup_handle)
> > > +{
> > > +     struct fwnode_link *link;
> > > +     struct device_link *dev_link;
> >
> > > +     struct device *sup_dev = NULL, *par_dev = NULL;
> >
> > You can put it the first line since it's long enough.
> 
> Wait, is that a style guideline to have the longer lines first?

No, but it's easier to read.

> > But why do you need sup_dev assignment?
> 
> Defensive programming I suppose. I can see this function being
> refactored in the future where a goto out; is inserted before sup_dev
> is assigned. And then the put_device(sup_dev) at "out" will end up
> operating on some junk value and causing memory corruption.

We don't need to be defensive here. Moreover, it's harder and easy to make
a mistake with predefined values (it's actually better NOT to define anything
qr at least define as closest to its user as possible, so you want miss the
compiler warnings as I believe you run your compiler with `make W=1 ...`, and
if not, I highly recommend to get this habit).

...

> > > +     sup_dev = get_dev_from_fwnode(sup_handle);
> > > +
> >
> > I would put it closer to the condition:
> >
> > > +     /* Termination condition. */
> > > +     if (sup_dev == con) {
> >
> >         /* Get supplier device and check for termination condition */
> >         sup_dev = get_dev_from_fwnode(sup_handle);
> >         if (sup_dev == con) {
> 
> I put it the way it is because sup_dev is used for more than just
> checking for termination condition.

Yes, but still it's better to see what you are actually checking.

> > > +             ret = true;
> > > +             goto out;
> > > +     }

...

> > > +             if (__fw_devlink_relax_cycles(con,
> > > +                                           dev_link->supplier->fwnode)) {
> >
> > Keep it on one line.
> 
> It'll make it > 80. Is this some recent change about allowing > 80
> cols? I'm leaving it as is for now.

Is it a problem? Do you have any tool that complains about it?

-- 
With Best Regards,
Andy Shevchenko


