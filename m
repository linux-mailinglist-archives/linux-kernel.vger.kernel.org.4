Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF21463DA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiK3QVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3QVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:21:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2DC2BB1F;
        Wed, 30 Nov 2022 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669825262; x=1701361262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YyFAqiAvl0ygxC+xDSxcfogAiposJLYMZ9OKZhChSBc=;
  b=UK1TTq31jB22+C2C4/KIssW8lS0WsU06uVnkglA3jiv1oRNXbVLShcjD
   I3Xi/LzgdXrUIuvRjfE2GTae8v0ItA6oowjgm/O86oYquaxZzYgRAD4Ai
   lwvkjBUZuJWMTh9Cx9oFoq30wBNRVlHyPKx460ejUpcngK5sEboAYjGhj
   NTNPHzz8o9EXxQns0QUYefofhuEIb8hr46gb5xs9loqmNmED/E7qVD63V
   s2RQX5mF+IXZ5zAim6jUE4DUBOTsNzfJiTOJo1BJKoqzaPN1NKXFpCYqI
   4vftzAGWAltVEiIcxDsQsFzsEa6DeM3n51wJorVmAq/cxBSkLXfOU3GvO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317286365"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="317286365"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 08:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="675080332"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="675080332"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 30 Nov 2022 08:20:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0PpR-002LYh-0u;
        Wed, 30 Nov 2022 18:20:57 +0200
Date:   Wed, 30 Nov 2022 18:20:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
Message-ID: <Y4eC6W/wstJFLrEr@smile.fi.intel.com>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
 <8a53e88b-1e74-bf34-62a1-780a1b29bcbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a53e88b-1e74-bf34-62a1-780a1b29bcbc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 05:12:13PM +0100, Hans de Goede wrote:
> On 11/30/22 16:55, Andy Shevchenko wrote:
> > The ->get() callback depending on other settings and hardware support
> > may return different values, while the line outside the chip is kept
> > in the same state. Let's discuss that in the documentation.

...

> > +Considerations of the ->get() returned value
> > +--------------------------------------------
> > +
> > +Due to different possible electrical configurations and software applications
> > +the value that ->get() callback returns may vary depending on the other settings.
> > +This will allow to use pins in the I2C emulation mode or other not so standard
> > +uses.
> > +
> > +The below table gathered the most used cases.
> > +
> > +==========  ==========  ===============  =======================
> > +  Input       Output         State        What value to return?
> > +==========  ==========  ===============  =======================
> > + Disabled    Disabled    Hi-Z             input buffer
> > + Disabled    OS/OD/etc   Single ended     [cached] output buffer
> 
> You need to clarify what single-ended means here. You mean a pin
> which is only capable of output I guess ?  So now way to figure
> out if another participant in the OS/OD bus has its transistor
> in the "on" state this pulling the bus high / low agains the bias
> resistor(s) which determine the state of the bus in rest ?
> 
> Or you mean that the bus is uni-directional, even then being
> able to detect a short-circuit is useful.

It's described in the previous chapter(s).

> > +    x        Push-Pull   Out              [cached] output buffer
> 
> Why, most GPIO drivers are protected against short-circuit to
> GND / Vdd and actually reading the input-buffer here will allow
> GPIO API consumers to detect such short-circuits if they are
> interested in this.  This would e.g. be useful to detect
> mis-wiring on devices like the Raspberry Pi were users often
> connect extra peripherals through breadboards.

I think it is nonsense from electronics point of view.

> IMHO for pins with an input buffer get() should simply
> always return the contents of the input buffer. This is what
> I believe almost all GPIO drivers currently do and also
> keeps the get() methods KISS.

As you can see, I disagree on this.

> Actually implementing the behavior you suggest here requires
> the get() method to differentiate between push-pull and
> other mode. This makes the get() method implementation
> needlessly complicated and will likely be a source of bugs
> as people will get this wrong in some cases and people
> will very likely not test all possible combinations from
> this big table you are adding here.

People already are getting wrong this and here is no documentation
on what to do to get it right.

> IHMO the rules for get() should simply be:
> 
> 1. Device has an input buffer:
>    Return input-buffer value for the pin.

I disagree on this. It makes no sense to read real hw wire state when output
is enabled. If somebody does a short circuit, it's not a Linux issue and
should be recognized on the PCB side (using oscilloscope, multi-meter, etc).

> 2. Devices does not have an input buffer:
>    Return last set output-buffer value

> > + Enabled     Disabled    In               input buffer
> > + Enabled     OS/OD/etc   Bidirectional    input buffer
> > +==========  ==========  ===============  =======================
> > +
> > +The [cached] here is used in a broader sense: either pure software cache, or
> > +read back value from the GPIO output buffer (not all hardware support that).

-- 
With Best Regards,
Andy Shevchenko


