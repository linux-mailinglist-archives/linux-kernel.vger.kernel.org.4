Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480116B9146
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCNLO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCNLOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:14:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E81EF751;
        Tue, 14 Mar 2023 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678792424; x=1710328424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q0VhbocRzI5W9YCF9QPYOuHdETuAjlALdIDW6JAj/Us=;
  b=LM293hD4eWyccWMEatxf8yL2I0c1AaMjF24Q2XT4hRxXCoTIKt39t6HQ
   QVQe9hxA1J9tfZD/grV4wrhaF1UKeavhpVBbR37m/ZiNPoc9m3LEgmVXi
   IdnRwUnx8IRKq15EtGx1DUvK5VJdc4nV1QUOv+7IX7ZuZYk3jwpkV4w0m
   mlncpthAEPaYLMSSqroc9OOdRKunS7ReOfV9yzqlQURQ8Lyzx24PyLDch
   +ZZ4fy2+4oXl0tir9uVvlWPJiIzYqcjYWArtaLbL3cDHE69IAv35Carb7
   PZtZVCBnNhu53DRylqt4maqg9wa6Jx0ybvqJQx8T+PXfZUnWrvG77Jydw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337419412"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="337419412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 04:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822334471"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="822334471"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2023 04:12:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pc2Zr-003B29-1B;
        Tue, 14 Mar 2023 13:12:23 +0200
Date:   Tue, 14 Mar 2023 13:12:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZBBWlyDtyinbZBNJ@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
 <20230312165100.45de0c9b@jic23-huawei>
 <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
 <ZA8ho4YfhBkSMFxS@smile.fi.intel.com>
 <d2986a9e-c516-ea6d-8f94-5cd4723312bd@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2986a9e-c516-ea6d-8f94-5cd4723312bd@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:19:35AM +0000, Vaittinen, Matti wrote:
> On 3/13/23 15:14, Andy Shevchenko wrote:
> > On Mon, Mar 13, 2023 at 02:56:59PM +0200, Matti Vaittinen wrote:
> >> On 3/12/23 18:51, Jonathan Cameron wrote:
> >>> On Mon, 6 Mar 2023 14:52:57 +0200
> >>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >>>> On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:

...

> >>>>> +EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);
> >>>>
> >>>> I would say _HELPER part is too much, but fine with me.
> >>>
> >>> Hmm. I think I like the HELPER bit as separates it from being a driver.
> >>> Of course I might change my mind after a few sleeps.
> >>
> >> Ever considered a career as a politician? ;) (No offense intended - and feel
> >> free to change your mind on this. I don't expect this to be done tomorrow)
> > 
> > It will be a one liner in the provider if you use DEFAULT_SYMBOL_NAMESPACE
> > definition.
> 
> Oh. I didn't know about DEFAULT_SYMBOL_NAMESPACE - or if I did, I had 
> forgot it. My memory has never been great and seems to be getting worse 
> all the time...
> 
> I don't know what to think of this define though. I can imagine that 
> someone who is not familiar with it could be very confused as to why the 
> symbols are not found even though EXPORT_SYMBOL or EXPORT_SYMBOL_GPL are 
> used. OTOH, I think I once saw an error about symbols being in a 
> namespace (when trying to use one without the namespace). This should 
> probably just be a good enough hint for finding out what's going on.
> 
> Luckily, I think all the exports in this case were oneliners even with 
> the namespace explicitly spelled. Well, I think that for one or two 
> exports the semicolon did slip to col 81 or 82 - but I am not sure if 
> fixing this weighs more than the clarity of explicitly showing the 
> namespace in export.
> 
> Well, I guess I can go with either of these ways - do you have a strong 
> opinion on using the DEFAULT_SYMBOL_NAMESPACE?

If you asking me, I'm fine with either way. Usually the latter makes sense
when we expect APIs in the certain module to:
1) always belong to the single namespace, *and / or*
2) be expanded in the future w/o bothering about their (default) NS, *and not*
3) be a single exported function for the feasible future.

Also you made a good point about line length, but with all respect, I prefer
100 than 80 and I do not believe we ever will have function name + NS longer
than that.

-- 
With Best Regards,
Andy Shevchenko


