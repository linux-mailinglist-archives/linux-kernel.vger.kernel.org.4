Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756A36814A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjA3PSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbjA3PS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:18:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B80C15C;
        Mon, 30 Jan 2023 07:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675091875; x=1706627875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jfbSarMFyi7cMttwvDR5yy006KKKlZ6jChWvaFjhEk=;
  b=YzBqa9ltyfekpYfTOa4cifNKNPR+88bOa3O8Wv+rESqnn2J+LHMlI/rI
   o6A8U4fHRSqF1WPTqJvkdqAf5d7MoodgCFRylMYlJYjVAZtkcfGTPKfHN
   ubEyEKoLEe5DoBjEIB2wpnnwiojIqDqJkewioulYGMzySAFgVOuJOj7T7
   nmyEslTOIqYdadL+m6edgJx9LbgJtS/bXO9uLFHDWfAWAZ2PCzAE2KwVN
   EDbNeEfesgBBHObNEIqwdJ7YDnmsMjU7nJvP+ZugdKKa31A+7trTi7XGI
   5yt1y9LevJD03nYULxtPQWKX18NcYe1zUWhJYc+BrWJ1poBsqhN/T/ylZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="354898535"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="354898535"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 07:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="992938805"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="992938805"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2023 07:16:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMVtc-00HPM7-2k;
        Mon, 30 Jan 2023 17:16:36 +0200
Date:   Mon, 30 Jan 2023 17:16:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <Y9ffVEa1KECKqBGB@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-9-saravanak@google.com>
 <Y9OcqGTocu8ZlFqy@smile.fi.intel.com>
 <CAGETcx-PiV12pKnVuKyvNcjYbHA=YFJG1QUa-o-G1cL3iMHgcA@mail.gmail.com>
 <Y9e09qUa9CDxHFcb@smile.fi.intel.com>
 <CAMuHMdXSgS-hu1xV_vmJZi_kr6ypiS=a-e0p7Hb75HKDfz9k-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXSgS-hu1xV_vmJZi_kr6ypiS=a-e0p7Hb75HKDfz9k-g@mail.gmail.com>
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

On Mon, Jan 30, 2023 at 03:36:04PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 30, 2023 at 1:16 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Jan 27, 2023 at 11:34:28PM -0800, Saravana Kannan wrote:
> > > On Fri, Jan 27, 2023 at 1:43 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Jan 26, 2023 at 04:11:35PM -0800, Saravana Kannan wrote:
> > > > > +static bool __fw_devlink_relax_cycles(struct device *con,
> > > > > +                              struct fwnode_handle *sup_handle)
> > > > > +{
> > > > > +     struct fwnode_link *link;
> > > > > +     struct device_link *dev_link;
> > > >
> > > > > +     struct device *sup_dev = NULL, *par_dev = NULL;
> > > >
> > > > You can put it the first line since it's long enough.
> > >
> > > Wait, is that a style guideline to have the longer lines first?
> >
> > No, but it's easier to read.
> 
> Yes it is, "reverse xmas tree" local variable ordering:
> https://elixir.bootlin.com/linux/v6.2-rc6/source/Documentation/process/maintainer-netdev.rst#L272

Good to  know, thanks!

-- 
With Best Regards,
Andy Shevchenko


