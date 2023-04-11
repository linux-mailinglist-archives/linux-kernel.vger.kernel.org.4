Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869536DDE58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDKOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjDKOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:43:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917BDE;
        Tue, 11 Apr 2023 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681224236; x=1712760236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gXL3iYzbDFw+nViapfU/ZBKVCbSgeQskzRbek/ecmps=;
  b=R4RbUB21x+tToAU+l1W7NFFdV4H73VYLMp5MEKNih3op23TyJrmsBPNH
   InrDBqmOMrN6jaH5llTxeiYc0th37fA/e6JiFHBE3dExvF/fV/DuxSrqj
   AKM7wHavQC4MC+BjT7b8gdVFNuG0OsVhHxL0zF1Rr87WLCfaqay/WPGhd
   gx7ysCcyaNwkmHkvk8pSZtm4DOjxZLraU2/QB410Zg7/RljnTUvznf9t9
   5VO/ZVdqfePYAPRdBGmyQjZuvF/rCIwK4rrUkBWqTNBl7VdjhG2zdVDr8
   yRxtCLKWGEEKcEXgn39kq8YGDGx7LRXjMoUfKX2knQaLAb1QkrdaEj0He
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="342394020"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="342394020"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 07:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753167413"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="753167413"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2023 07:43:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmFDp-00FKHZ-1l;
        Tue, 11 Apr 2023 17:43:49 +0300
Date:   Tue, 11 Apr 2023 17:43:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 3/3] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZDVyJV8TfC31TYP2@smile.fi.intel.com>
References: <cover.1681134558.git.william.gray@linaro.org>
 <669c8f782f11fe27c4568e4fc3ba459c4f954874.1681134558.git.william.gray@linaro.org>
 <ZDVli05x7u/bg7Zc@smile.fi.intel.com>
 <ZDVpJb9DyIU+5eJf@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDVpJb9DyIU+5eJf@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:05:25AM -0400, William Breathitt Gray wrote:
> On Tue, Apr 11, 2023 at 04:50:03PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 10, 2023 at 10:03:13AM -0400, William Breathitt Gray wrote:
> > > The Preset Register (PR), Flag Register (FLAG), and Filter Clock
> > > Prescaler (PSC) have common usage patterns. Wrap up such usage into
> > > dedicated functions to improve code clarity.

...

> > >  	*val = 0;
> > 
> > Is not needed now as always being initialized by below call.
> 
> The regmap_noinc_read() call only reads the number of bytes requested.
> Since we request 3 bytes, the upper bytes of the u64 val remain
> uninitialized, so that is why we need to set *val = 0. This isn't
> immediately clear in the code, so I can add a comment to make it
> explicit.

Hmm...
Since we are using byte array for the value, can we actually use
memset() to show that explicitly? Perhaps in that way it will be more visible?

> > >  	spin_lock_irqsave(&priv->lock, irqflags);
> > >  
> > >  	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
> > > -
> > > -	for (i = 0; i < 3; i++)
> > > -		*val |= (unsigned long)ioread8(&chan->data) << (8 * i);
> > > +	ioread8_rep(&chan->data, val, 3);

But hold on, wouldn't this have an endianess issue? The call fills in LE,
while here you use the CPU order.

> > >  	spin_unlock_irqrestore(&priv->lock, irqflags);

That said, I think you should have something like

	u8 value[3];

	ioread8_rep(..., value, sizeof(value));

	*val = get_unaligned_le24(value);

-- 
With Best Regards,
Andy Shevchenko


