Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655446B91A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjCNLbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCNLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:31:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EAA92F0C;
        Tue, 14 Mar 2023 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678793502; x=1710329502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2JIdZFnOgODiCPaS156p+1hgs/76WeFRt2PCzonJqQ=;
  b=k7iVdOl/Pgf063zyRD9v9NMwFeRm4Cy+Zd1HKn22LQI+9OyCbe4Kajq1
   oemWMwPsOKCBuY6AhU3Jn/rGONrM1cxlAxQv73t71ySjfAgDEfi6el5MM
   xxUskhuT1QHabbnPiICrPzT39/LuPlJxt0kbADqNqmVzrfykthniue5QC
   LIb+AmlLhC/y2+MdL6C3qnH1rySLUuYtQ0kmhhpYoHmUJ9QjIXAeTtnX+
   FHPveWViWYMsri7AW8GhNIHJfkgyHgGtU9IwcRdLqGky8QflDyjyz9nrw
   T+y5xfV8ub+Y7oXv5ufkp5rgRU9odt+JOQnGs3J6fJTm77/OZUmSuGZPu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399985105"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="399985105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 04:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="709247031"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="709247031"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 14 Mar 2023 04:31:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pc2ry-003Bcf-05;
        Tue, 14 Mar 2023 13:31:06 +0200
Date:   Tue, 14 Mar 2023 13:31:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZBBa+e9VXj/eyT4J@smile.fi.intel.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
 <ZAC7L8NQYgBcBTCF@smile.fi.intel.com>
 <7e537200-37ab-f6e6-c4e0-c3997128c01b@fi.rohmeurope.com>
 <ZAXK9Hn2NuQPJ7eo@smile.fi.intel.com>
 <1dbfc336-7d09-cd44-dfa2-9c4bedf257e1@gmail.com>
 <ZA81rpWgwvP2bigt@smile.fi.intel.com>
 <9d63c161-0449-7e56-5873-2909587f17af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d63c161-0449-7e56-5873-2909587f17af@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:28:43PM +0200, Matti Vaittinen wrote:
> On 3/13/23 16:39, Andy Shevchenko wrote:
> > On Mon, Mar 13, 2023 at 01:31:42PM +0200, Matti Vaittinen wrote:
> > > On 3/6/23 13:13, Andy Shevchenko wrote:
> > > > On Fri, Mar 03, 2023 at 07:54:22AM +0000, Vaittinen, Matti wrote:
> > > > > On 3/2/23 17:05, Andy Shevchenko wrote:
> > > > > > On Thu, Mar 02, 2023 at 12:57:54PM +0200, Matti Vaittinen wrote:

...

> > > > > > > +		for (i = 0; !ret && i < gts->num_avail_all_scales; i++)
> > > > > > 
> > > > > > Much easier to read if you move this...
> > > > > > 
> > > > > > > +			ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
> > > > > > > +					&gts->avail_all_scales_table[i * 2],
> > > > > > > +					&gts->avail_all_scales_table[i * 2 + 1]);
> > > > > > 
> > > > > > ...here as
> > > > > > 
> > > > > > 		if (ret)
> > > > > > 			break;
> > > > > 
> > > > > I think the !ret in loop condition is obvious. Adding break and brackets
> > > > > would not improve this.
> > > > 
> > > > It moves it to the regular pattern. Yours is not so distributed in the kernel.
> > > 
> > > I believe we can find examples of both patterns in kernel. I don't think the
> > > "many people use different pattern" is a great reason to add break +
> > > brackets which (in my eyes) give no additional value to code I am planning
> > > to keep reading also in the future...
> > 
> > The problem is that your pattern is not so standard (distributed) and hence
> > less maintainable.
> 
> I am sorry but I can't really agree with you on this one. For me adding the
> break and brackets would just complicate the flow and thus decrease the
> maintainability.

So, we may start to have a "fundamental disagreements between Matti and Andy on
the code style in the Linux kernel" document that we won't clash on this again.
At least the amount of these disagreements seems not decreasing in time.

...

> > > > > > > +			if (!diff) {
> > > > > > 
> > > > > > Why not positive conditional?
> > > > > 
> > > > > Because !diff is a special condition and we check explicitly for it.
> > > > 
> > > > And how my suggestion makes it different?
> > > 
> > > In example you gave we would be checking if the value is anything else but
> > > the specific value we are checking for. It is counter intuitive.
> > > 
> > > > (Note, it's easy to miss the ! in the conditionals, that's why positive ones
> > > >    are preferable.)
> > > 
> > > Thank you for explaining me the rationale behind the "positive checks". I
> > > didn't know missing '!' was seen as a thing.
> > > I still don't think being afraid of missing '!' is a good reason to switch
> > > to counter intuitive checks. A check "if (!foo)" is a pattern in-kernel if
> > > anything and in my opinion people really should be aware of it.
> > > 
> > > (I would much more say that having a constant value on left side of a
> > > "equality" check is beneficial as people do really occasionally miss one '='
> > > when meaning '=='. Still, this is not strong enough reason to make
> > > counter-intuitive checks. In my books 'avoiding negative checks' is much
> > > less of a reason as people (in my experience) do not really miss the '!'.)
> > 
> > It's not a problem when it's a common pattern (like you mentioned
> > if (!foo) return -ENOMEM; or alike), but in your case it's not.
> 
> I think we can find plenty of cases where the if (!foo) is used also for

Pleading to the quantity and not quality is not an argument, right?

> other type of checks. To me the argument about people easily missing the !
> in if () just do not sound reasonable.

You may theoretically discuss this, I'm telling from my review background
and real cases.

> > I would rather see if (diff == 0) which definitely shows the intention
> > and I wouldn't tell a word against it.
> 
> I think this depends much of the corner of the kernel you have been working
> with. As far as I remember, in some parts the kernel the check
> (foo == 0) was actually discouraged, and check (!foo) was preferred.

Don't you use your common sense?

> Personally I like !foo much more - but I can tolerate the (foo == 0) in
> cases where the purpose is to really see if some measure equals to zero.
> 
> Other uses where I definitely don't want to use "== 0" are for example
> checking if a flag is clear, pointer is NULL or "magic value" is zero.
> 
> In this case we are checking for a magic value. Having this check written
> as: (diff == 0), would actually falsely suggest me we are checking for the
> difference of gains being zero. That would really be a clever obfuscation
> and I am certain the code readers would fall on that trap quite easily.

Testing with !diff sounds like it's a boolean kind and makes a false
impression that all other values are almost the same meaning which is
not the case. Am I right? That's why diff == 0 shows the exact intention
here "I would like to check if diff is 0 because this is *special case*".

Making !diff creates less visibility on this.

Result: Fundamental disagreement between us.

-- 
With Best Regards,
Andy Shevchenko


