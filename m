Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791BE680CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjA3MEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjA3MEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:04:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039914E8E;
        Mon, 30 Jan 2023 04:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675080258; x=1706616258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rj5FdHRZxfvSxZ+bvMThiL/pa+WbSCwCmjvsd0eDOSg=;
  b=YLUBHnwvSn57hEjyLjxTIM7//ulgDoDi6/LDYYn4ZoZKVMj794Dfh2CS
   Fn1nas37hzoHCPmbWF820H0Bp6pMhn7QyiPJ1vbDa3xuHOyIcmQcOK2tm
   MOVpQXonSugvcvPljgcDiOr7rAbK0QWCI6mz6umheUhgApFcO7eLg5d6a
   0lCpgqPQrGx5Sz2gvzB3ACI1mc7rGsSavraIhNF+2IgNa07EoqlUB0BBn
   cRVl4d886XWOBLRNHD1Z3of9SEyTaSqYdDla/bddOpUdEdYe3FmznSu72
   ZUttda2rKz8GqZNxprwk7q7nrXo0tb/gUiY2IjdLJk5o8ncpWBQuFZL3j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="315499561"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="315499561"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:04:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="732674303"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="732674303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2023 04:04:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMStF-00HKsM-2X;
        Mon, 30 Jan 2023 14:04:01 +0200
Date:   Mon, 30 Jan 2023 14:04:01 +0200
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
Message-ID: <Y9eyMck6rPRyfgrX@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-2-saravanak@google.com>
 <Y9OXs9+uYi31dYJD@smile.fi.intel.com>
 <CAGETcx_g8yKQQQVtNt+6cB8hS7OY9=dqm4tDhm1ZJZqG5nzSLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_g8yKQQQVtNt+6cB8hS7OY9=dqm4tDhm1ZJZqG5nzSLg@mail.gmail.com>
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

On Fri, Jan 27, 2023 at 11:33:28PM -0800, Saravana Kannan wrote:
> On Fri, Jan 27, 2023 at 1:22 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 26, 2023 at 04:11:28PM -0800, Saravana Kannan wrote:

...

> > >  static unsigned int defer_sync_state_count = 1;
> > >  static DEFINE_MUTEX(fwnode_link_lock);
> > >  static bool fw_devlink_is_permissive(void);
> > > +static void __fw_devlink_link_to_consumers(struct device *dev);
> > >  static bool fw_devlink_drv_reg_done;
> > >  static bool fw_devlink_best_effort;
> >
> > I'm wondering if may avoid adding more forward declarations...
> >
> > Perhaps it's a sign that devlink code should be split to its own
> > module?
> 
> I've thought about that before, but I'm not there yet. Maybe once my
> remaining refactors and TODOs are done, it'd be a good time to revisit
> this question.
> 
> But I don't think it should be done for the reason of forward
> declaration as we'd just end up moving these into base.h and we can do
> that even today.

What I meant is that the stacking up forward declarations is a good sign that
something has to be done sooner than later.

...

> > > -int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
> > > +static int __fwnode_link_add(struct fwnode_handle *con,
> > > +                          struct fwnode_handle *sup)
> >
> > I believe we tolerate a bit longer lines, so you may still have it on a single
> > line.
> 
> That'd make it >80 cols. I'm going to leave it as is.

Is it a problem?

...

> > >       if (dev->fwnode && dev->fwnode->dev == dev) {
> >
> > You may have above something like
> >
> >         fwnode = dev_fwnode(dev);
> 
> I'll leave it as-is for now. I see dev->fwnode vs dev_fwnode() don't
> always give the same results. I need to re-examine other places I use
> dev->fwnode in fw_devlink code before I start using that function. But
> in general it seems like a good idea. I'll add this to my TODOs.

Please do, the rationale is to actually move the fwnode to the proper layer,
now we have the single linked list defined in struct fwnode_handle and
dereferencing fwnode from struct device without helper adds a lot of
headache in the future. So, I really would like to see that we stopped doing
that.

> >         if (fwnode && fwnode->dev == dev) {
> >
> > >               struct fwnode_handle *child;
> > >               fwnode_links_purge_suppliers(dev->fwnode);
> > > +             mutex_lock(&fwnode_link_lock);
> > >               fwnode_for_each_available_child_node(dev->fwnode, child)
> > > -                     fw_devlink_purge_absent_suppliers(child);
> > > +                     __fw_devlink_pickup_dangling_consumers(child,
> > > +                                                            dev->fwnode);
> >
> >                         __fw_devlink_pickup_dangling_consumers(child, fwnode);
> 
> I like the dev->fwnode->dev == dev check. It makes it super clear that
> I'm checking "The device's fwnode points back to the device". If I
> just use fwnode->dev == dev, then one will have to go back and read
> what fwnode is set to, etc. Also, when reading all these function
> calls it's easier to see that I'm working on the dev's fwnode (where
> dev is the device that was just bound to a driver) instead of some
> other fwnode.
> 
> So I find it more readable as is and the compiler would optimize it
> anyway. If you feel strongly about this, I can change to use fwnode
> instead of dev->fwnode.

Please, read above.

-- 
With Best Regards,
Andy Shevchenko


