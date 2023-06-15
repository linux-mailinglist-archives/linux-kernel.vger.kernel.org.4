Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A547315C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbjFOKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbjFOKuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:50:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918BB1FDD;
        Thu, 15 Jun 2023 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686826205; x=1718362205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FcyhqzTeBGjztjLAE0WN1NbITmzLPl03bzOZHHHLy7k=;
  b=UsGQIXF2VuJNR0yBd6qHBkLpbhE7rppWosq6poJhbFPIAX6fIYASfzYw
   38wZVJAn/4MHKTtVByfI7PWI+oECvmweSUkz0bQ/toVK6ho1W+grBEzBc
   hehXEwCW1Qqv9qeZPI/56YA6DoPlmIkNhgy8wLRXoHjAWKz9651So0wVV
   Rrb6sOLLC8IQm+im8vZLn/br4dDSGf6ZcCvZIiQTwsOIYnRLZiJ+choQQ
   fT/7eXHpw9a5BsZUaplMEnGhgfmsJdZEwQzWMPoiF4Gx5ERVreTLGyCEN
   A2d+rO5MUmTeeyhkDGRdockNwvSf/yqGXNfWVRRjabdtQPHURvkgvuK5z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339222895"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="339222895"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 03:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="802292007"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802292007"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 03:50:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9kYD-003vAx-2v;
        Thu, 15 Jun 2023 13:50:01 +0300
Date:   Thu, 15 Jun 2023 13:50:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc:     "Jadav, Raag" <raag.jadav@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: Re: [PATCH v3 2/3] pinctrl: intel: refine ->irq_set_type() hook
Message-ID: <ZIrs2YSEUbPyvZWE@smile.fi.intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
 <20230613085054.10976-3-raag.jadav@intel.com>
 <ZInpT0dUUVUcKdqv@smile.fi.intel.com>
 <DM6PR11MB2779F9C28712D7C25F9FB3768C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
 <20230615095517.GV45886@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615095517.GV45886@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:55:17PM +0300, mika.westerberg@linux.intel.com wrote:
> On Thu, Jun 15, 2023 at 09:48:12AM +0000, Jadav, Raag wrote:
> > > On Tue, Jun 13, 2023 at 02:20:53PM +0530, Raag Jadav wrote:

...

> > > Looking at this I realized that entire temporary variable assignments can be
> > > done outside of spin lock. You probably would need another one for keeping
> > > rxinv value.
> > 
> > Something like this?

Almost, see below.

> >         u32 value, rxevcfg;
> >         u32 rxinv = 0;

No assignment here.

         u32 rxinv, rxevcfg;
         u32 value;

> >         if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
> >                 rxevcfg = PADCFG0_RXEVCFG_EDGE_BOTH;
> >         } else if (type & IRQ_TYPE_EDGE_FALLING) {
> >                 rxevcfg = PADCFG0_RXEVCFG_EDGE;
> >         } else if (type & IRQ_TYPE_EDGE_RISING) {
> >                 rxevcfg = PADCFG0_RXEVCFG_EDGE;
> >         } else if (type & IRQ_TYPE_LEVEL_MASK) {
> >                 rxevcfg = PADCFG0_RXEVCFG_LEVEL;
> >         } else {
> >                 rxevcfg = PADCFG0_RXEVCFG_DISABLED;
> >         }

Now, if it's fully included in the diff (even with --patience parameter),
then you may drop {}.

> >         if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_LEVEL_LOW)
> >                 rxinv = PADCFG0_RXINV;

		else
			rxinv = 0;

> >         raw_spin_lock_irqsave(&pctrl->lock, flags);
> > 
> >         intel_gpio_set_gpio_mode(reg);
> > 
> >         value = readl(reg);
> > 
> >         value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
> >         value |= rxinv;
> >         value |= rxevcfg << PADCFG0_RXEVCFG_SHIFT;

And I would rewrite these to the standard patterns:

         value = (value & ~PADCFG0_RXINV) | rxinv;
         value = (value & ~PADCFG0_RXEVCFG_MASK) | (rxevcfg << PADCFG0_RXEVCFG_SHIFT);

And looking at this, perhaps do shift also outside the lock:

         } else {
                 rxevcfg = PADCFG0_RXEVCFG_DISABLED;
         }
         rxevcfg <<= PADCFG0_RXEVCFG_SHIFT;

But, taking into account scope of the _RXEVCFG_*, I would add shift directly to
the definitions and kill that SHIFT entirely:

#define PADCFG0_RXEVCFG_LEVEL           (0 << 25)
#define PADCFG0_RXEVCFG_EDGE            (1 << 25)
#define PADCFG0_RXEVCFG_DISABLED        (2 << 25)
#define PADCFG0_RXEVCFG_EDGE_BOTH       (3 << 25)

	 ...

         value = (value & ~PADCFG0_RXINV) | rxinv;
         value = (value & ~PADCFG0_RXEVCFG_MASK) | rxevcfg;

Try that one and look if it looks better. It might even save bytes after all.

> >         writel(value, reg);
> 
> This one looks better.
> 
> > > Will it give us any memory reduction in comparison to the current code?
> > 
> > add/remove: 0/0 grow/shrink: 1/0 up/down: 4/0 (4)
> > Function                                     old     new   delta
> > intel_gpio_irq_type                          317     321      +4
> > Total: Before=10469, After=10473, chg +0.04%
> > 
> > Unfortunately gcc doesn't seem to consider this as best of the sequence,
> > and I'm not entirely sure why.
> 
> It's fine as is, readability counts more than few bytes here.

-- 
With Best Regards,
Andy Shevchenko


