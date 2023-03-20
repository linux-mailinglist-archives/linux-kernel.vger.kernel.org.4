Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9A6C1A17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCTPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCTPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:45:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420873A851;
        Mon, 20 Mar 2023 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679326587; x=1710862587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q+Aqrp+jsVZRrM1TwtSk95kdu9HXUBXl8cfQitPnQCE=;
  b=GrGyhL8vpjhGdc+8L9K1bfXq3V1agJKosYJjQmP3x91WHJq8Ypl5L94W
   YPRYxJcvlVpleptLBGFpcLZhiZksVsVD/TCC2F9IuA6l6ZDTVtOh6+v5l
   wbsJs4ciuOtooWwIPUoesA+cjFqVv1Qz0wyoLjtuiVsZNkrk01ziHz/4R
   2i682wwrDFJrJpOPzq2lMRda2XZdVjBz/CWIOrymcH6qBzjpr9nHB124t
   vIMw6gr+mjosXBVyD4t238JJY8lOO6Cdfl7jQ67dJBtqCvL3DB28e+ROc
   W+Y/ub+78cwnCrnrH0GdYtk/W7hQtbGFxPLVOG8J5DrjvRrGLH1mMCkI/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="318344314"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="318344314"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 08:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="745433753"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="745433753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2023 08:36:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peHYY-006Kdx-0k;
        Mon, 20 Mar 2023 17:36:18 +0200
Date:   Mon, 20 Mar 2023 17:36:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZBh9cUwvV+hi5We8@smile.fi.intel.com>
References: <cover.1679149542.git.william.gray@linaro.org>
 <71496f9295e68388ce07f3051bf5882177be83c5.1679149543.git.william.gray@linaro.org>
 <ZBhRb+v/8+vSwjz6@smile.fi.intel.com>
 <ZBh8O5oOL0TB9wzT@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBh8O5oOL0TB9wzT@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:31:07AM -0400, William Breathitt Gray wrote:
> On Mon, Mar 20, 2023 at 02:28:31PM +0200, Andy Shevchenko wrote:
> > On Sat, Mar 18, 2023 at 10:59:51AM -0400, William Breathitt Gray wrote:
> > > The Preset Register (PR), Flag Register (FLAG), and Filter Clock
> > > Prescaler (PSC) have common usage patterns. Wrap up such usage into
> > > dedicated functions to improve code clarity.

...

> > > +static void quad8_preset_register_set(struct quad8 *const priv, const size_t id,
> > > +				      const unsigned long preset)
> > > +{
> > > +	struct channel_reg __iomem *const chan = priv->reg->channel + id;
> > > +	int i;
> > > +
> > > +	/* Reset Byte Pointer */
> > > +	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
> > > +
> > > +	/* Set Preset Register */
> > > +	for (i = 0; i < 3; i++)
> > > +		iowrite8(preset >> (8 * i), &chan->data);
> > > +}
> > 
> > May we add generic __iowrite8_copy() / __ioread8_copy() instead?
> > 
> > It seems that even current __ioread32_copy() and __iowrite32_copy() has to
> > be amended to support IO.

> Sure, I would use __iowrite8_copy() / __ioread8_copy() for these
> situations if it were available.

If needed, you may always introduce ones.

> Is something equivalent available for the regmap API? I'm planning to
> migrate this driver to the regmap API soon after this patch series is
> merged, so the *_copy() calls would need to migrated as well.

Yes. It's regmap bulk operations.

-- 
With Best Regards,
Andy Shevchenko


