Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33389731B23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345015AbjFOORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbjFOORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:17:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E62D51;
        Thu, 15 Jun 2023 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686838620; x=1718374620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IZs3+IpTIl6TXY3NHA88Szi8RXaR0RScjuDF4WCYJC0=;
  b=X1aI454rl7PcLc9H4NXGXh3b8QKcpX8LZp4f2di0elHJEVRkeFPlj5bw
   99qZN3DgqIQoIr+E9UPstW4Q6u56knSosSgdFA3HPr8m7FlfxpTeF5ztl
   5/1TAdn+H/tE3rAFFWrpqmHweCQT5+9kF2zl50i3gpVQxE3ycNx3yoHKv
   1IhTKTjV5lQjAOol+y7fCKYfOTFpv0dbU2Dln+huM7PIZ424KflcxVRJ8
   2yq7RkxJ+sRGg61v/fHPUbOdiPllgfygvIOjTUVwAXwdh8fhCqpra4fev
   fsjZquCiYCuY/RS8Ys0tgFEFR57LbBu5QY1jS/2jrg0+uY8hFSlYKiP4X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338548468"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="338548468"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 07:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825294984"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825294984"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 07:09:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9net-003xUF-2V;
        Thu, 15 Jun 2023 17:09:07 +0300
Date:   Thu, 15 Jun 2023 17:09:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jadav, Raag" <raag.jadav@intel.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: Re: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Message-ID: <ZIsbg2h0u93tCQiz@smile.fi.intel.com>
References: <20230615125022.27421-1-raag.jadav@intel.com>
 <ZIsOvBGLJTCo45jp@smile.fi.intel.com>
 <DM6PR11MB2779FD7F6DF3A0126DB85E4B8C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2779FD7F6DF3A0126DB85E4B8C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:35:19PM +0000, Jadav, Raag wrote:
> > On Thu, Jun 15, 2023 at 06:20:22PM +0530, Raag Jadav wrote:
> > > Refine ->irq_set_type() hook and improve its readability by:
> > >
> > > - Reducing scope of spinlock by moving unneeded operations out of it.
> > > - Dropping redundant PADCFG0_RXEVCFG_SHIFT and including it directly
> > >   into PADCFG0_RXEVCFG_* definitions.
> > > - Utilizing temporary variables for common operations.
> > > - Simplifying if-else-if chain.
> > 
> > Two questions out of curiosity.
> > Do we gain or lose bytes with this?
> 
> add/remove: 0/0 grow/shrink: 1/0 up/down: 33/0 (33)
> Function                                     old     new   delta
> intel_gpio_irq_type                          317     350     +33
> Total: Before=10469, After=10502, chg +0.32%
> 
> > > +	value = readl(reg);
> > 
> > > +	value = (value & ~PADCFG0_RXINV) | rxinv;
> > > +	value = (value & ~PADCFG0_RXEVCFG_MASK) | rxevcfg;
> > 
> > Same question if we change this to be similar to the current code, i.e.
> > 
> > 	value = readl(reg);
> > 
> > 	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
> > 	value |= rxevcfg;
> > 	value |= rxinv;
> > 
> > And I would keep blank lines after readl() and before writel() since we have
> > more than a single line in between.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-9 (-9)
> Function                                     old     new   delta
> intel_gpio_irq_type                          317     308      -9
> Total: Before=10469, After=10460, chg -0.09%

Do I understand correctly that this is your patch + suggested above?

-- 
With Best Regards,
Andy Shevchenko


