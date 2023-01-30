Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A9680D30
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjA3MK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbjA3MKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:10:40 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB7518B3F;
        Mon, 30 Jan 2023 04:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675080569; x=1706616569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTY9WLS4wVtKo44V42B48degtPfcQUTsiQPaSpOWAqU=;
  b=Lr7WebiOVHyL2ZVAhEP/TicykpCLcQxpwKbglijyg4LJ1i3nQVELqewr
   wvW+By2SF9eFR23FINzK5KsL1UBzdkNAi5iEZKOejae3FAoDRo548dEnJ
   If0WYlAN8ZRZY+0RkhxT0XlaisK33CLX6A5kS1KL0RyLpghSGF44SMBdk
   6LdbEd3psB0a+PGxWrhKa9lm+VNr+fIDJF5mIYrrhvrDBP1Oyxeb9U2HV
   T/6LBNz2B0riW5HcfVbOLwjdXBInz7D+PvLd2Sjfl9+vsqOqcXjKR21fV
   XbXWkF+LQnvZWLOjZAGRsFjojqD2rJhmPDf1ZduVq9BKm+ApJTE59tUGE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="328816522"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="328816522"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="614008770"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="614008770"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2023 04:08:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMSxG-00HKyC-24;
        Mon, 30 Jan 2023 14:08:10 +0200
Date:   Mon, 30 Jan 2023 14:08:10 +0200
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
Message-ID: <Y9ezKs4kJPS1S7Jl@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-6-saravanak@google.com>
 <Y9OZh0ZqtnqmKcvT@smile.fi.intel.com>
 <CAGETcx9WX-Nf7oD=sLEsG70hDczrQkDRdQTBmgE2y89hDLbYDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9WX-Nf7oD=sLEsG70hDczrQkDRdQTBmgE2y89hDLbYDg@mail.gmail.com>
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

On Fri, Jan 27, 2023 at 11:34:11PM -0800, Saravana Kannan wrote:
> On Fri, Jan 27, 2023 at 1:30 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 26, 2023 at 04:11:32PM -0800, Saravana Kannan wrote:

...

> > >                              DL_FLAG_AUTOREMOVE_SUPPLIER | \
> > >                              DL_FLAG_AUTOPROBE_CONSUMER  | \
> > >                              DL_FLAG_SYNC_STATE_ONLY | \
> > > -                            DL_FLAG_INFERRED)
> > > +                            DL_FLAG_INFERRED | \
> > > +                            DL_FLAG_CYCLE)
> >
> > You can make less churn by squeezing the new one above the last one.
> 
> I feel like this part is getting bike shedded. I'm going to leave it
> as is. It's done in the order it's defined in the header and keeping
> it that way makes it way more easier to read than worry about a single
> line churn.

Not at all. What you are showing here is the additional churn for the sake of
the churn. With a no-cost trick you may avoid that.

Also, it will compress better the Git index and save some mW here and there
and in the size of the world and amount of Git copies of the Linux kernel
this may save the planet (I'm serious, no jokes).

-- 
With Best Regards,
Andy Shevchenko


