Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E757314AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbjFOJzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbjFOJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:55:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E326B8;
        Thu, 15 Jun 2023 02:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686822911; x=1718358911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tgLchCQOCm3NxEtP7yRUXwmiZkL4G/bjAirc8TrgyEY=;
  b=QwNF9fBHEY2EapsOvVGDhwdjERdA5zB/Tl3iixCWWt6WMgLzGkpyMgev
   CfKEu59Iqdq4M5x/wjIMZa6mFMoNd/EAu16aEBhxQ27dhNMUut0l2TgRB
   gXKdfQqAlNKkdakkTE1f+TfFu+YOUSPu+FCeBEArm7KkiZxR9XGDl9uvn
   XvGv8WI5B3TAj/kqlZvezSd8xnAN0j9rrCQzmOYua2U7d2WyRaQ23cArW
   Adghvj820Qc8bIN++vFyat4zfhV18ZPGjtXqEMQ9ckQ6NRH9+LYA8XAm/
   RsuHXFKcy05iFM3A2NJOjYfzeL5Ob7FYSV0qqkPfgTckiqbLbG/NQHbCP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="357746579"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="357746579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 02:55:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="706598947"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="706598947"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 02:55:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7769D403; Thu, 15 Jun 2023 12:55:17 +0300 (EEST)
Date:   Thu, 15 Jun 2023 12:55:17 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     "Jadav, Raag" <raag.jadav@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: Re: [PATCH v3 2/3] pinctrl: intel: refine ->irq_set_type() hook
Message-ID: <20230615095517.GV45886@black.fi.intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
 <20230613085054.10976-3-raag.jadav@intel.com>
 <ZInpT0dUUVUcKdqv@smile.fi.intel.com>
 <DM6PR11MB2779F9C28712D7C25F9FB3768C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2779F9C28712D7C25F9FB3768C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:48:12AM +0000, Jadav, Raag wrote:
> > On Tue, Jun 13, 2023 at 02:20:53PM +0530, Raag Jadav wrote:
> > > Utilize a temporary variable for common shift operation in
> > > ->irq_set_type() hook and improve readability.
> > > While at it, simplify if-else-if chain and save a few bytes.
> > >
> > > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-16 (-16)
> > > Function                                     old     new   delta
> > > intel_gpio_irq_type                          317     301     -16
> > > Total: Before=10469, After=10453, chg -0.15%
> > 
> > ...
> > 
> > >  	value = readl(reg);
> > > -
> > >  	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
> > >
> > >  	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
> > > -		value |= PADCFG0_RXEVCFG_EDGE_BOTH <<
> > PADCFG0_RXEVCFG_SHIFT;
> > > +		rxevcfg = PADCFG0_RXEVCFG_EDGE_BOTH;
> > >  	} else if (type & IRQ_TYPE_EDGE_FALLING) {
> > > -		value |= PADCFG0_RXEVCFG_EDGE <<
> > PADCFG0_RXEVCFG_SHIFT;
> > > -		value |= PADCFG0_RXINV;
> > > +		rxevcfg = PADCFG0_RXEVCFG_EDGE;
> > >  	} else if (type & IRQ_TYPE_EDGE_RISING) {
> > > -		value |= PADCFG0_RXEVCFG_EDGE <<
> > PADCFG0_RXEVCFG_SHIFT;
> > > +		rxevcfg = PADCFG0_RXEVCFG_EDGE;
> > >  	} else if (type & IRQ_TYPE_LEVEL_MASK) {
> > > -		if (type & IRQ_TYPE_LEVEL_LOW)
> > > -			value |= PADCFG0_RXINV;
> > > +		rxevcfg = PADCFG0_RXEVCFG_LEVEL;
> > >  	} else {
> > > -		value |= PADCFG0_RXEVCFG_DISABLED <<
> > PADCFG0_RXEVCFG_SHIFT;
> > > +		rxevcfg = PADCFG0_RXEVCFG_DISABLED;
> > >  	}
> > >
> > > +	if (type == IRQ_TYPE_EDGE_FALLING || type ==
> > IRQ_TYPE_LEVEL_LOW)
> > > +		value |= PADCFG0_RXINV;
> > > +
> > > +	value |= rxevcfg << PADCFG0_RXEVCFG_SHIFT;
> > >  	writel(value, reg);
> > 
> > Looking at this I realized that entire temporary variable assignments can be
> > done outside of spin lock. You probably would need another one for keeping
> > rxinv value.
> 
> Something like this?
> 
>         u32 value, rxevcfg;
>         u32 rxinv = 0;
> 
>         if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
>                 rxevcfg = PADCFG0_RXEVCFG_EDGE_BOTH;
>         } else if (type & IRQ_TYPE_EDGE_FALLING) {
>                 rxevcfg = PADCFG0_RXEVCFG_EDGE;
>         } else if (type & IRQ_TYPE_EDGE_RISING) {
>                 rxevcfg = PADCFG0_RXEVCFG_EDGE;
>         } else if (type & IRQ_TYPE_LEVEL_MASK) {
>                 rxevcfg = PADCFG0_RXEVCFG_LEVEL;
>         } else {
>                 rxevcfg = PADCFG0_RXEVCFG_DISABLED;
>         }
> 
>         if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_LEVEL_LOW)
>                 rxinv = PADCFG0_RXINV;
> 
>         raw_spin_lock_irqsave(&pctrl->lock, flags);
> 
>         intel_gpio_set_gpio_mode(reg);
> 
>         value = readl(reg);
> 
>         value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
>         value |= rxinv;
>         value |= rxevcfg << PADCFG0_RXEVCFG_SHIFT;
> 
>         writel(value, reg);

This one looks better.

> > Will it give us any memory reduction in comparison to the current code?
> 
> add/remove: 0/0 grow/shrink: 1/0 up/down: 4/0 (4)
> Function                                     old     new   delta
> intel_gpio_irq_type                          317     321      +4
> Total: Before=10469, After=10473, chg +0.04%
> 
> Unfortunately gcc doesn't seem to consider this as best of the sequence,
> and I'm not entirely sure why.

It's fine as is, readability counts more than few bytes here.
