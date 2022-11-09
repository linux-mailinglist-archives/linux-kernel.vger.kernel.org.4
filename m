Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD9F6227BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKIJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKIJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:57:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F386119C1B;
        Wed,  9 Nov 2022 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667987821; x=1699523821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wbN0WcvS6dfHyHMWrZth2dMe4EhIChvyffidy9u7Io=;
  b=DPKiMjrtYkrpZJPcpR9GUps3UOqZy1u9V9YJiI1K8HaYtintdIgoJa2G
   o3oSjfWjnN9760nbbbQWOep3qvrdQwtxg8oQ/5TZetESyDVNjaoZdvrtA
   ZOf6mOTYRWZMhIcZTIFUKk3YEn8uOvZg4hMu+GKqccldE0ZKLwEtRxS+o
   4/3w6a/pSIOnrXtStYTcstT61QzUpRk9F7kIfQI7Wfzk3G0zAe6g+68EO
   5nPqjSS1XdxDtChukhNCRJuVh7u0vKCYH6gUS+qTMeht9X3r9A6SB2Hqo
   Ul5fwSSuWox+bjiNMtrBulSk4bkEued9mKz51mHBVJFJvuByBoSH5V7/C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309649602"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="309649602"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 01:57:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="779286525"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="779286525"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2022 01:56:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oshpG-009dTN-0e;
        Wed, 09 Nov 2022 11:56:54 +0200
Date:   Wed, 9 Nov 2022 11:56:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 6/6] pinctrl: intel: Enumerate PWM device when
 community has a capabilitty
Message-ID: <Y2t5ZXM0Oihz/LDK@smile.fi.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-7-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVekP0kFpwexpb3NhqRSouNW7FhhRpSK0yRQTrJAGt4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbVekP0kFpwexpb3NhqRSouNW7FhhRpSK0yRQTrJAGt4A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:08:51AM +0100, Linus Walleij wrote:
> On Tue, Nov 8, 2022 at 3:22 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > +       static const struct pwm_lpss_boardinfo info = {
> > +               .clk_rate = 19200000,
> > +               .npwm = 1,
> > +               .base_unit_bits = 22,
> > +               .bypass = true,
> > +       };
> > +       struct pwm_lpss_chip *pwm;
> > +
> > +       if (!(community->features & PINCTRL_FEATURE_PWM))
> > +               return 0;
> > +
> > +       pwm = pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
> > +       if (IS_ERR(pwm) && PTR_ERR(pwm) != -ENODEV)
> > +               return PTR_ERR(pwm);
> 
> This is alike a boardfile embedded into the pin control driver.

Correct.

> It's a bit backwards since we usually go the other direction, i.e. probe
> a PWM driver or whatever and then that driver request its resources
> that are assigned from e.g. DT or ACPI, and in this case that would
> mean it request its pin control handle and the pins get set up.
> 
> I guess I can be convinced that this hack is the lesser evil :D
> 
> What is it in the platform that makes this kind of hacks necessary?

The PWM capability is discoverable by the looking for it in the pin
control IP MMIO, it's not a separate device, but a sibling (child?)
of the pin control, that's not a separate entity.

Moreover, not every pin control _community_ has that capability (capabilities
are on the Community level and depends on ACPI representation of the
communities themself - single device or device per community - the PWM may or
may not be easily attached.

What you are proposing is to invent at least two additional properties or so
for the pin control device description and then to support old platforms,
create a board file somewhere else, which will go through all pin control
devices, checks the capabilities, then embeds the properties via properties
(Either embedded into DSDT, if done in BIOS, or swnodes).

Do I get you right?

If so, in my opinion it's way more ugly and overkill that the current
approach.

> Inconsistent description in ACPI or is the PWM device simply
> missing from the DSDT (or whatever is the right form in ACPI)
> in already shipped devices that need it?

Right.

> Or is it simply impossible to describe the PWM device in ACPI?

It's a dynamic feature and existing firmwares are carved in stone.
It might be possible to move the above mentioned uglification to
the BIOS. But the horizon of that is 5+ years in case I am able
to convince program managers for it (TBH, I don't believe it's
feasible, since "Windows works!" mantra, they are not engineers).

That said, I agree that this looks not nice, but that's all what
Mika and me can come up with to make all this as little ugly and
intrusive as possible.

-- 
With Best Regards,
Andy Shevchenko


