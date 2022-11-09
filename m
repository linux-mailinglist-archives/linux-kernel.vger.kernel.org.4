Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528306228AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiKIKkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKIKkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:40:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739FB1C10D;
        Wed,  9 Nov 2022 02:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667990414; x=1699526414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5bHYyqP5M5DI4ZLT2QWbl6fGoRoL44686dEs/SdCwz0=;
  b=bFQK1aWJdnVgaD2k3h4NeEcAMbqMD5gmkE62yR6cbvWpOobTKcmYwekw
   YgbfFRAZNnyqUssYRFbOsbDNjRIUXJnGKxgR/rNUb1bPPEtjsWTVngZfm
   1Gk1aJiTrwzC8N6zw3y1CgkSuckFDArH7+you43MTAMBKAC2+/WcgYzYR
   Vu/m0Srgb5zsl2eWzVd+i3rSGkKkLfGGUD4mVRN2zXk8Y99l56Fv3vhBq
   vtj6BAk3Hc2r161gKSSpmuf9porbBcjvTIkB69lvCDHS51RjKBln3iXla
   AXnkKLXsNuOcpUgQA12pZvS3SFAxKo4grqLh7WJne2FXCeRxUiWiaUz26
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298467163"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="298467163"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 02:40:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="811587922"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="811587922"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2022 02:40:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osiV7-009hZ3-29;
        Wed, 09 Nov 2022 12:40:09 +0200
Date:   Wed, 9 Nov 2022 12:40:09 +0200
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
Message-ID: <Y2uDifs0CkPl+P0X@smile.fi.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-7-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVekP0kFpwexpb3NhqRSouNW7FhhRpSK0yRQTrJAGt4A@mail.gmail.com>
 <Y2t5ZXM0Oihz/LDK@smile.fi.intel.com>
 <CACRpkda6uDOEXybduFbTe0yXzLMaQ8x0UORZAH-U0SOTWHkF-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda6uDOEXybduFbTe0yXzLMaQ8x0UORZAH-U0SOTWHkF-Q@mail.gmail.com>
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

On Wed, Nov 09, 2022 at 11:08:04AM +0100, Linus Walleij wrote:
> On Wed, Nov 9, 2022 at 10:56 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 09, 2022 at 10:08:51AM +0100, Linus Walleij wrote:

...

> > > I guess I can be convinced that this hack is the lesser evil :D
> > >
> > > What is it in the platform that makes this kind of hacks necessary?
> >
> > The PWM capability is discoverable by the looking for it in the pin
> > control IP MMIO, it's not a separate device, but a sibling (child?)
> > of the pin control, that's not a separate entity.
> 
> OK I get it.
> 
> > Moreover, not every pin control _community_ has that capability (capabilities
> > are on the Community level and depends on ACPI representation of the
> > communities themself - single device or device per community - the PWM may or
> > may not be easily attached.
> 
> OK I think I understand it a bit, if ACPI thinks about the PWM
> as "some feature of the community" then that is how it is, we have
> this bad fit between device tree and Linux internals at times as well,
> then spawning a device from another one is the way to go, we need
> to consider the option that it is Linux that is weird at times, not the
> HW description.

The problem here is not the impossibility to do the things. The problem is
that things are done and validated on a Windows system. After that it close
to impossible to update the firmware or perform any architectural changes.

OTOH, announcing the separate device out of the existing MMIO space doesn't
sound right from the software point of view that should follow the hardware
representation.

Ideally, this should be an adaptive MFD-like device, but it makes things
even more complicated than has been discussed already. (Note, that some
of the pin control drivers are enumerated as platform devices, and that
code should also be taken into account)

...

> > That said, I agree that this looks not nice, but that's all what
> > Mika and me can come up with to make all this as little ugly and
> > intrusive as possible.
> 
> I can live with it, rough consensus and running code.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


