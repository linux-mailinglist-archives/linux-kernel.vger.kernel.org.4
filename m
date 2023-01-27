Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B716B67E093
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjA0JpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjA0JpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:45:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A56761F9;
        Fri, 27 Jan 2023 01:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674812703; x=1706348703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qVG3SO3/mw1Za7KIPJqbPMkWrirnnDCNx1aYcVedBMY=;
  b=VmoFcCYL/V5hZ4+O+K0sTip9tuFwjzGmtekPy9372nVufBYyAS7bzuPF
   P2ooTJBTOief0Il0obQrpjHBi2hadWpcBJoXwV9l/NM0Xg/xILDL2EWKb
   K+ZPctdO4KggQNIEmwcBertcJtjbVm0UbdFbU5Jx3qFeqUJgnvc+rofvI
   0ZiLoQcDe8rsm5yBrsCp7zP24HYnSP8NCEUeIjvoQgoDOGonSLMl10PiT
   ejfGaDtXkJ80uu59biMXJGMzVBmDCR4sHRnAmBCVO3+xMiw/wJ0xv9CZ9
   6D/bstbiq2/8XU/t7Q/Wm8ONQ4BCvW0sQqzBxWocV4z+5ZMBgjsZLp12I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="413277656"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="413277656"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:45:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="908614631"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="908614631"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jan 2023 01:44:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLLHs-00FtoI-1i;
        Fri, 27 Jan 2023 11:44:48 +0200
Date:   Fri, 27 Jan 2023 11:44:48 +0200
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
Subject: Re: [PATCH v2 03/11] soc: renesas: Move away from using OF_POPULATED
 for fw_devlink
Message-ID: <Y9OdEOuqfrIrFR4E@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-4-saravanak@google.com>
 <Y9OYdX38NfRE9Tvb@smile.fi.intel.com>
 <CAMuHMdUdi9ShckBiEAfg3dgp9EUm354tpf3zEz8Dduo2Qyo2vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUdi9ShckBiEAfg3dgp9EUm354tpf3zEz8Dduo2Qyo2vA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:30:35AM +0100, Geert Uytterhoeven wrote:
> On Fri, Jan 27, 2023 at 10:25 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 26, 2023 at 04:11:30PM -0800, Saravana Kannan wrote:

...

> > > -             of_node_set_flag(np, OF_POPULATED);
> > > +             fwnode_dev_initialized(&np->fwnode, true);
> >
> > of_fwnode_handle(np) ?
> 
> Or of_node_to_fwnode().

Not really.

> Looks like we have (at least) two of them...

Yes, and the latter one is IRQ subsystem invention. Should gone in favour of
the generic helper.

-- 
With Best Regards,
Andy Shevchenko


