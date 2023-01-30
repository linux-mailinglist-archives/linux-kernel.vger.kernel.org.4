Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463EB680D41
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjA3MMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjA3MLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:11:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093C37B58;
        Mon, 30 Jan 2023 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675080649; x=1706616649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F7kz/t7goqTvjK8l9cj5cpA+WN6lVLHQofCFYgKQjgM=;
  b=Aub4vzzByvl995Nq/Eae36nOWF+39w2/pU82SLe6C9hmeMwOlfuI9b+O
   Uf0bdncd29F7r7mkcdGN7MZvTOIAaU7O3G1sBo0PGndkh8foBDpb6UBCy
   LBj9eM78iWKpFzdgYCnhGTyniLG6Wh7zGI2o4q1VqKKlVLXEb2dK/gGN2
   +jMMpesFTQPK3Hk+RYm6ouuPvachQT+BDykaypjIYwn3jiLSNmPsB1RJf
   DBTpoEVxPZMdhAKRePctHROFkVmPQTUI4aBSISSnlparUHiy8KKKabvwp
   XYCtpqMsDQyeZ9yVDqtKyqaT06k2+d4s9uu63UceFZ4Zksx9fv2sl7BM/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="389906024"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="389906024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:10:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="806649751"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="806649751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2023 04:09:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMSyc-00HKzp-19;
        Mon, 30 Jan 2023 14:09:34 +0200
Date:   Mon, 30 Jan 2023 14:09:34 +0200
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
Message-ID: <Y9ezfr3xxFIUoXIF@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-7-saravanak@google.com>
 <Y9OaaC806Ywg7rM9@smile.fi.intel.com>
 <CAGETcx9XGq20kagmVXwEV6MF9mp9Ta5ra0+Ynhb7GiUKnxkWqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9XGq20kagmVXwEV6MF9mp9Ta5ra0+Ynhb7GiUKnxkWqg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:34:19PM -0800, Saravana Kannan wrote:
> On Fri, Jan 27, 2023 at 1:33 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 26, 2023 at 04:11:33PM -0800, Saravana Kannan wrote:

...

> > > -     if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> > > -         !fw_devlink_is_permissive()) {
> > > -             sup_fw = list_first_entry(&dev->fwnode->suppliers,
> > > -                                       struct fwnode_link,
> > > -                                       c_hook)->supplier;
> > > +     sup_fw = fwnode_links_check_suppliers(dev->fwnode);
> >
> > dev_fwnode() ?
> >
> > ...
> >
> > > -     val = !list_empty(&dev->fwnode->suppliers);
> > > +     mutex_lock(&fwnode_link_lock);
> > > +     val = !!fwnode_links_check_suppliers(dev->fwnode);
> >
> > Ditto?
> 
> Similar response as Patch 1 and Patch 4.

Same.

-- 
With Best Regards,
Andy Shevchenko


