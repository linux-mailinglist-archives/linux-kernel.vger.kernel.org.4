Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCB636085
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiKWNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbiKWNws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:52:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E43B2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669211241; x=1700747241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1J+oWK65EL/VKfkbcRmIHMExLaew7xvk0RcgvWYHTL4=;
  b=ig2/UOnSmkZ0KvXe+Iw751rhvPEbd4ri6ZoO3VGGRrnCd8Qry7XzxnL6
   ul3iRrcHOjiBt0eR0ITUoPtHKOHoLY1t1mMlSBE6Nrgm6dv6yfcX8n1mR
   8wK5WPPO6pwXpYuTL8oeJk8fye+MquZiWlD5/1X7DDOjo5IjasLNZR33U
   z5GYXWPymZODAARbiOXs1ZmLvAURi+Vd2h9/1knCq6lphGqFn3vGsQi75
   8s2vGV5Y1WmLG+cTRo+svRd4sVeeboNZNjBEU0JHdgkHPPvdBv+IHfQQ+
   oNKK3TyL0HfxW7e2s5j6TPVTWAmo0dDHnr1uAcR1NXuDVz7V1R4nF3Qte
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315888879"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="315888879"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 05:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="641800763"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="641800763"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2022 05:47:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxq5r-00GJ14-2h;
        Wed, 23 Nov 2022 15:47:15 +0200
Date:   Wed, 23 Nov 2022 15:47:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Message-ID: <Y34kY2SqghhAqKn0@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <Y3yTxRAVSOJTMuUu@smile.fi.intel.com>
 <a7a1b539-bd69-0227-ea93-b90f2e3ef2cd@maxlinear.com>
 <Y3yhFWQ7NHMArO74@smile.fi.intel.com>
 <fee4cf31-11be-9459-7d7b-ba8729dfb356@maxlinear.com>
 <Y3zDm1zaqpn8uMiV@smile.fi.intel.com>
 <bd1aab73-654a-59fd-7b2b-eb3773e3c97e@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1aab73-654a-59fd-7b2b-eb3773e3c97e@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:52:03AM +0000, Rahul Tanwar wrote:
> On 22/11/2022 8:42 pm, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 10:45:12AM +0000, Rahul Tanwar wrote:
> >  > On 22/11/2022 6:15 pm, Andy Shevchenko wrote:
> >  > > On Tue, Nov 22, 2022 at 09:49:04AM +0000, Rahul Tanwar wrote:

...

> > It creates patches automatically in the same was as it's done by
> > `git format-patch`. That's why it accepts a lot of the parameters
> > which you usually add there.
> > 
> > Typical use for the series is
> > 
> > ge2maintainer.sh -v 1 -c 4 HEAD~0 --annotate --cover-letter
> > 
> > Note, that your editor should be able to handle several files to edit
> > (e.g. vim supports that mode).
> 
> The script worked like a charm. Very useful. Thanks.

Thank you for trying it. I'm using it on a daily basis.

> But i missed to CC 
> you while using the script. I have addressed all your concerns and 
> already sent v4. Request to please review the series starting from below 
> link:
> https://lore.kernel.org/all/20221123093820.21161-1-rtanwar@maxlinear.com/

Since we have lore.kernel.org and very powerful tool, called `b4` (you may
install it, if you have one of the most spread Linux distro, with your package
manager) no need to resend. The Cc'ing on cover letter is enough, I can
retrieve the whole thread from lore.

-- 
With Best Regards,
Andy Shevchenko


