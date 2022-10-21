Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE15607579
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJUKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJUKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:55:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD871244720;
        Fri, 21 Oct 2022 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666349719; x=1697885719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wx25grSXDV+rY/7gahOrHKDqSL40ohUGsgRb8cn4kGo=;
  b=FA3jJmYGd7OSRR9QO/OGxVrgA96MPMSCK29YBCWrfuHCokFYV9Lah4tz
   GYwHYSNctFH79Sk/Vp9APBU6MTyPRtML9lADqQn3DmHpBuIRGYj0ObnSR
   DYR+OxAjBXhcfJwgnw+67LTuWO+H1nPSJXCOMi0u2SzvP1/IKEUV4cMzA
   b05qQhRSzi1GlF+18QdTeWNnxp4ZyfesTKwhZyRicV/UGv4+C695aXwnl
   QE/Ykcn7wp9Qp61rJdYXwIGkp/TLg5IuTkm74GVahtrgpwzqGg7AHAssN
   wZv498OC7IX1PiEQJCnLXcf6WAJQvtKqdA5RL/NMr7Z0+9rGtdvCJ/iLb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305709345"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305709345"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 03:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630432859"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630432859"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2022 03:55:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olpgG-00B70q-2S;
        Fri, 21 Oct 2022 13:55:12 +0300
Date:   Fri, 21 Oct 2022 13:55:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     chengwei <foxfly.lai.tw@gmail.com>, lee@kernel.org,
        broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [PATCH 5/5] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <Y1J6kJ/sL4qqok16@smile.fi.intel.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-6-larry.lai@yunjingtech.com>
 <CACRpkdYfPT6-gt2RCxzPfy+GdkLYo8KP02CLLC+uY512AqPwNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYfPT6-gt2RCxzPfy+GdkLYo8KP02CLLC+uY512AqPwNw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:09:27AM +0200, Linus Walleij wrote:
> On Wed, Oct 19, 2022 at 4:26 AM chengwei <foxfly.lai.tw@gmail.com> wrote:

> > The UP Squared board <http://www.upboard.com> implements certain
> > features (pin control) through an on-board FPGA.

> I am a bit confused by this driver. Andy pointed out some obvious nits that
> need to be fixed but the overall architecture here is also a bit puzzling.
> 
> This seems to want to be compatible to Raspberry Pi (RPi), then which one?
> 
> The driver seems to translate GPIO calls to "native GPIO" in some cases,
> which GPIO controller is that?

There is an SoC level GPIO (Apollo Lake I believe) and there is a discrete
component between it and user visible header (connector). This driver AFAIU
is about controlling that discrete component.

> Also I don't see why, normally a pin control
> driver is an agnostic back-end for a GPIO controller, so the GPIO driver
> should be the same (whatever "native") means, and this driver should
> not even implement a gpio chip, just let the GPIO driver do its job
> and call back into the pin control back-end whenever it needs it.
> 
> Also we already have a driver that collects existing GPIOs to a new
> GPIO chip, the GPIO aggregator:
> drivers/gpio/gpio-aggregator.c
> 
> Maybe if you can explain a bit about how this hardware works and why
> you have to do indirect calls to another GPIO controller, things will
> be easier to understand?

-- 
With Best Regards,
Andy Shevchenko


